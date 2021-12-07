Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8646BD48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhLGONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhLGONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:13:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:10:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38C661EC04EC;
        Tue,  7 Dec 2021 15:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638886210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nMIOwz2qDbopLUx34G1IUCoLxN5m6RDRFzKA3kZm8Ag=;
        b=fwVZ9HowqQmvHUKHLFQDWzgTfmGl+N96cjS7cwz10ZslkZbANWus/8GeuBJTsC6TAjYltM
        Au+/s5uC1F8SeyLTjyXiU7mrWkfPqYHmID3IsrnSAttE0QsNvcGJf2i73E1tAO0h8/gO+l
        SsnzxhWTvf+b0Fch8VabRKGdGH4BH2A=
Date:   Tue, 7 Dec 2021 15:10:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mm: use WARN_ONCE instead of printk and WARN_ON_ONCE
Message-ID: <Ya9rRL0Bhv7SnV5C@zn.tnic>
References: <1638881702-3106-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1638881702-3106-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:55:00AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Simply use WARN_ONCE instead of printk(KERN_WARNING, ...) and WARN_ON_ONCE.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  arch/x86/mm/ioremap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 026031b..af9a321
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -195,9 +195,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>  		return NULL;
>  
>  	if (!phys_addr_valid(phys_addr)) {
> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> -		       (unsigned long long)phys_addr);
> -		WARN_ON_ONCE(1);
> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
> +			 (unsigned long long)phys_addr);
>  		return NULL;
>  	}
>  
> -- 

This is not an equivalent transformation.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
