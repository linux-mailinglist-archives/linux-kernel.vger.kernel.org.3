Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD24934E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbiASGOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiASGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:13:59 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 22:13:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id o135so1742380qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 22:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=66QSnsdAjW0WnnSYYUvfNj62A0KuOyzqQ9EzryppOp0=;
        b=MnyzRprWrTm+i2vZeTqaxSJG87Ot9eYEa4PdNmlgYZZ7Ls8Yo4iESys7Sjgz0YCp44
         eFer18lgQe468HHFaEVAOnnddyp2uDt5/iHy0YmyVj8SPBFcJmgTaZhJTsxlN9qZAKvm
         yeNIhURyj0sBX2fwywXkpfbONd8+aisBm01ZRl8iRHLntMI/S2sRmrnoE7uBZaqjIcED
         a8hyj6hE3dcv3Wlw6uUEIPCgzNHb+rycnqVLcyPAqkEfQLvUJ96n2qeyu1L4mo04lwcv
         O3e77j0aQauugwoqPKSC+hbyG6JSHBm37AB2eJoSqcSSM2wZUnkgVpdG95QLLdih3wNO
         3ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=66QSnsdAjW0WnnSYYUvfNj62A0KuOyzqQ9EzryppOp0=;
        b=VYjmFkW1IQECWgzG5vAJT60rFkZuKKuBn3WtaRMWy08tSkqVwN+nZEANwYNRYO1tmS
         EEiAqRrkjGtzhB7aFshitWco8yNscnjpoxLr3d05iH8ipY3M/aKd/SjU9PDPV8QbuW1v
         BFid+3j/mTtyVw1R8Gs4t23UjOaIbrrLZHTdeMW6V1AWxYDnEAhDasf+gYKzW5KoCuy/
         pUSZHf+GfrrHgeLGSvMXpcGIX7ns9WlRkDXPxWbuNDiTyqcqsnQYoMGT6vCceOpCNLRd
         scBZOkzDoP7UEslj0SdmdUtqLYSeiH5obHNVaOogrCK7wDC963P6rQWf3CGTHkWh6nSj
         Q7GA==
X-Gm-Message-State: AOAM530tLmIOATMC19LuVZzlPbJC2qB0HV++0WheXpW4fti6r6RFkoRx
        OpTxqj4NNV3k6Mc7GRltirg=
X-Google-Smtp-Source: ABdhPJxsvvYKIXZ4SVWgaHatO4NosaqRJQicOoOG6ed0VC69MIcLaR4bsbC0ORB26eB3ERpM1c2Qzg==
X-Received: by 2002:a37:b142:: with SMTP id a63mr19893978qkf.704.1642572838037;
        Tue, 18 Jan 2022 22:13:58 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o7sm11692224qke.44.2022.01.18.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 22:13:57 -0800 (PST)
Message-ID: <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
X-Google-Original-Message-ID: <20220119061354.GA931160@cgel.zte@gmail.com>
Date:   Wed, 19 Jan 2022 06:13:54 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVdvVVBvrXH5U0L@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:14:53AM -0500, Johannes Weiner wrote:
> Hello Yang,
> 
> On Sun, Jan 16, 2022 at 03:21:51PM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > When faults in from swap what used to be a ksm page and that page
> > had been swapped in before, system has to make a copy. Obviously
> > this kind of copy is related to high memory pressure, so we treat
> > it as memstall. Although ksm page merging is not because of high
> > memory pressure.
> > 
> > Information of this new kind of stall will help psi to account
> > memory pressure more precise.
> 
> Thanks for your patch. I'm curious if you have a concrete use case
> where this makes a difference, or if this is something you found while
> reading the code?
>
Thanks for your reply. I found it while reading the code, and did a test,
please see below.
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  mm/ksm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 4a7f8614e57d..d4ec6773f9b8 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/freezer.h>
> >  #include <linux/oom.h>
> >  #include <linux/numa.h>
> > +#include <linux/psi.h>
> >  
> >  #include <asm/tlbflush.h>
> >  #include "internal.h"
> > @@ -2569,6 +2570,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
> >  {
> >  	struct anon_vma *anon_vma = page_anon_vma(page);
> >  	struct page *new_page;
> > +	unsigned long pflags;
> >  
> >  	if (PageKsm(page)) {
> >  		if (page_stable_node(page) &&
> > @@ -2583,6 +2585,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
> >  	if (!PageUptodate(page))
> >  		return page;		/* let do_swap_page report the error */
> >  
> > +	psi_memstall_enter(&pflags);
> >  	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
> >  	if (new_page &&
> >  	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
> > @@ -2600,6 +2603,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
> >  #endif
> >  	}
> >  
> > +	psi_memstall_leave(&pflags);
> 
> This does unconditional stall accounting for a swapin operation. But
> if you take a look at workingset_refault() -> folio_wait_bit_common(),
> we only count memory stalls when the page is thrashing, not when it's
> a transitionary refault (which happen even when there is enough memory
> to hold the workingset). You need to check PageWorkingset() at least.
> 
I see PSI already does stall accounting for a swapin operation of zram
in most conditions. See swap_readpage(), it calls psi_memstall_enter().

> But again I'd be curious first if this is a practical concern. Swapins
> should be IO dominated - or in the case of zswap dominated by the
> decompression. Does a page copy really matter?
I did a test, when we use zram, it takes longer time for ksm copying than
swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
average takes 55639ns. So I think this patch is reasonable.

I use ktime_get_ts64() for time calcuating in swap_readpage() and
ksm_might_need_to_copy(). Code likes:
	psi_memstall_enter()
	ktime_get_ts64(&ts_start)
	//ksm copy or swapin
	ktime_get_ts64(&ts_end)
	time = timespec64_sub(ts_end, ts_start)
	psi_memstall_leave()
