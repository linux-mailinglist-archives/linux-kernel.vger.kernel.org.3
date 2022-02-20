Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEED4BCF09
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiBTOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:25:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiBTOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:25:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BE4E3B4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 06:24:50 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18E811EC0354;
        Sun, 20 Feb 2022 15:24:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645367085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Glb9ViJyXJzoR1vrz+e9rIQwwG8Jrqc/CbHBsUwkNCM=;
        b=KRskHcjwiOo4Qy7jReW7J5ls9yYPCxAzbZnpvFDkaI4BNMz1mSL4MjxSoZBRkVRqjimPRw
        YCb/ph5CGlI73X/ABryJwc4rt1dP+jXqihOhGn/3fsqoUAX1Q10Ys5Dp8VduninNU7cKza
        RsckCq9B+mY5woEm4ntaDMyDEqcyp7o=
Date:   Sun, 20 Feb 2022 15:24:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Correct documentation comments for x86
 csum_and_copy_...user()
Message-ID: <YhJPMFz7jEA9Lbe6@zn.tnic>
References: <20220205121456.478180-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205121456.478180-1-william.kucharski@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:14:56AM -0700, William Kucharski wrote:
> Clean up of calling conventions for csum_and_copy_..._user() did not update
> associated documentation comments to account for the removal of additional
> parameters.
> 
> Fixes: c693cc4676a0 ("saner calling conventions for csum_and_copy_..._user()")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  arch/x86/lib/csum-wrappers_64.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index 189344924a2b..25d533502693 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -14,8 +14,6 @@
>   * @src: source address (user space)
>   * @dst: destination address
>   * @len: number of bytes to be copied.
> - * @isum: initial sum that is added into the result (32bit unfolded)
> - * @errp: set to -EFAULT for an bad source address.
>   *
>   * Returns an 32bit unfolded checksum of the buffer.
>   * src and dst are best aligned to 64bits.
> @@ -39,8 +37,6 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
>   * @src: source address
>   * @dst: destination address (user space)
>   * @len: number of bytes to be copied.
> - * @isum: initial sum that is added into the result (32bit unfolded)
> - * @errp: set to -EFAULT for an bad destination address.
>   *
>   * Returns an 32bit unfolded checksum of the buffer.
>   * src and dst are best aligned to 64bits.
> @@ -64,7 +60,6 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
>   * @src: source address
>   * @dst: destination address
>   * @len: number of bytes to be copied.
> - * @sum: initial sum that is added into the result (32bit unfolded)
>   *
>   * Returns an 32bit unfolded checksum of the buffer.
>   */
> -- 

Wanna fix the rest of kernel-doc formatting issues while at it?

$ ./scripts/kernel-doc -v -none arch/x86/lib/csum-wrappers_64.c
arch/x86/lib/csum-wrappers_64.c:13: info: Scanning doc for function csum_and_copy_from_user
arch/x86/lib/csum-wrappers_64.c:23: warning: No description found for return value of 'csum_and_copy_from_user'
arch/x86/lib/csum-wrappers_64.c:36: info: Scanning doc for function csum_and_copy_to_user
arch/x86/lib/csum-wrappers_64.c:46: warning: No description found for return value of 'csum_and_copy_to_user'
arch/x86/lib/csum-wrappers_64.c:59: info: Scanning doc for function csum_partial_copy_nocheck
arch/x86/lib/csum-wrappers_64.c:68: warning: No description found for return value of 'csum_partial_copy_nocheck'

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
