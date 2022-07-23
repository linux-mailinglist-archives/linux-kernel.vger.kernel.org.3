Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B84757EF38
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiGWNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:34:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2763B8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:34:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C86B538BEC;
        Sat, 23 Jul 2022 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658583247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEI33x8YY3TztEtZ2KmUdMfEFtQTA+u7UV3PRyCqwv4=;
        b=FrYYdPx94t0tIRiUJ4NCYmey0bUT5iqORrJUmjUcka/P+avPXo8XtMznm+Yzu1KPoQzIhQ
        B8L79iEEk5FWxq1MPTIQN3iHT/nTdZG7nHhwEt31L+/6o2EZMwzGSbyF2QQhWH8xPKc4Id
        3LSjOtvunV4Wc01Dn1nZK2wxJIqpqqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658583247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEI33x8YY3TztEtZ2KmUdMfEFtQTA+u7UV3PRyCqwv4=;
        b=4F72rQCzxjLkt8+OFlOXJF+MjJ6UuhwtNPX7CqCFc+VK2+yKZwBUU5pdw2Atg2s6x8l5MF
        O/asPpvdoa4UlRAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D70502C165;
        Sat, 23 Jul 2022 13:34:06 +0000 (UTC)
Date:   Sat, 23 Jul 2022 15:34:05 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     paulus@samba.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, Julia.Lawall@inria.fr, joel@jms.id.au,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com
Subject: Re: [PATCH] powerpc: Remove the static variable initialisations to 0
Message-ID: <20220723133405.GF17705@kitsune.suse.cz>
References: <20220723092436.7149-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723092436.7149-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jul 23, 2022 at 05:24:36PM +0800, Jason Wang wrote:
> Initialise global and static variable to 0 is always unnecessary.
> Remove the unnecessary initialisations.

Isn't this change also unnecessary?

Initializing to 0 does not affect correctness, or even any kind of
semantics in any way.

The current code is slightly easier to understand.

And changing the code introduces history noise for na gain.

Thanks

Michal

> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/powerpc/kexec/core_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index c2bea9db1c1e..2407214e3f41 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -135,7 +135,7 @@ notrace void kexec_copy_flush(struct kimage *image)
>  
>  #ifdef CONFIG_SMP
>  
> -static int kexec_all_irq_disabled = 0;
> +static int kexec_all_irq_disabled;
>  
>  static void kexec_smp_down(void *arg)
>  {
> -- 
> 2.35.1
> 
