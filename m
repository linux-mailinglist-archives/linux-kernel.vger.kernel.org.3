Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB7518B31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiECRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiECRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:40:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBD24F0E;
        Tue,  3 May 2022 10:36:43 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD9031EC0354;
        Tue,  3 May 2022 19:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651599398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ck+uGn0FFYbKWUnm+9BbC6zDql8IAMFJc7yr1uqhvvQ=;
        b=sMlUAoI8K7II7r28TyRvkgIF0qp14gICloiB9vUrautcXJtuY2Mrh8TuXWU35LmYC6Oz4t
        iayZdB1TIhL71NnMG69c5fP8YuHNXHwf4Zh68xPHjOkkomAELGDkRpnubaV5RSQGe6nEyV
        YAaAtNXwtjTJVffalgoVECtlWE6dchQ=
Date:   Tue, 3 May 2022 19:36:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vit Kabele <vit@kabele.me>
Cc:     platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        x86@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] arch/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <YnFoIzmt1qJSucAd@zn.tnic>
References: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
 <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:46:46AM +0200, Vit Kabele wrote:
> The pointer to EBDA area is retrieved from a word at 0x40e in BDA.
> In case that the memory there is not initialized and contains garbage,
> it might happen that the kernel touches memory above 640K.

This is where I'm missing the "why do this" at all. Grepping back in
my mbox, I see another thread from you where you say something about
"testing custom virtualization platform".

So I'd like to see why this fix is needed so feel free to elaborate in the
commit message what the situation is and why you're doing this.

> This may cause unwanted reads from VGA memory which may not be decoded,
> or even present when running under virtualization.
> 
> This patch adds sanity check for the EBDA pointer retrieved from the memory

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

IOW,

s/This patch adds/Add/

> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index fed721f90116..9e0b4820f33b 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -633,8 +633,18 @@ void __init default_find_smp_config(void)
>  	 */
>  
>  	address = get_bios_ebda();
> -	if (address)
> -		smp_scan_config(address, 0x400);
> +
> +	/*
> +	 * Check that the EBDA address is sane and the get_bios_ebda() did not
> +	 * return just garbage from memory.
> +	 * The upper bound is considered valid if it points below 1K before
> +	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
> +	 * than 1K in which case the pointer will point above 639K but that
> +	 * case is handled in step 2) above, and we don't need to adjust scan
> +	 * size to not bump into the memory above 640K.
> +	 */
> +	if (address >= BIOS_START_MIN && address < (BIOS_START_MAX - 1024))
> +		smp_scan_config(address, 1024);
>  }

I guess but looking at reserve_bios_regions(), that function is already
doing kinda the same along with being a bit more careful to figure out
bios_start so you could unify the code into a common helper and use it
at both places?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
