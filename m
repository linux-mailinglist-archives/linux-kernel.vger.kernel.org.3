Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3549BBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiAYTS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiAYTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:18:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99363C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:17:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z19so22004605lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZzixtPsBwjSdlfmVlQxvw65IbQas2Gqlofz//xzbt8=;
        b=SoiX0MB1KR/dZ1i0RrY8wFpu4FCIw2nPsbRx8INbBLCr10ClG/5D8Y5MXxUSb6i5Vs
         LY1GRHnVw+WHTeQCuf/jN5A7Ftfs5V+r0qa2Z6wJ25pHpM30g6zwvfr7VcibvIq+6w5P
         Y7NqDfXCdQ/q86EmFQR2qYP0Oqu8sfEUPhFmxYG61M4svXTBtHEnGqvc9d+iG4Q5/mg7
         aRILAfn33GP+HHRI4DFLT1voIKNhtENCcliuJxLC38Hlac2r4g6WahCQMYJycpS1RLwf
         NnKiclmqbb3knOVRKllMHjM23zGZ3fsArhcL+92vdHsQepZgsIPKot+hPPzXlOBpbhsb
         x7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZzixtPsBwjSdlfmVlQxvw65IbQas2Gqlofz//xzbt8=;
        b=FZyuJBENwMIlayk76demPWv8VUwOJrJIhD+GnRw9Ti7po8na+3YzK09pO/vi+1BsOG
         53yF1nV8CruNHohMM9DxdymSWw8DPnqB2PEDsL/8nFuKLcLvSn2N+5kqONTHgtmprpeP
         GikCTQWnlYT/8kF8vMzF+IEsUo8QTj5tuI61e65slnRkcoUmls1y4xGpbUZtlt8nIbTE
         OrmN7Bj3ZuOdTggntGnDOrazUca5tvPMwfw+R+naf9ihndYyWXmOsiZyBPNBU1ITlInZ
         hxwoWWX+mkaDWa/5hTMsN9knAAzu4zz95rqqZ7M/z/LTh5/cgqYHZ3f8iGuaD3N7fe71
         5HKQ==
X-Gm-Message-State: AOAM530pgexSye4v93fqqHSfQq42enBfbWnD/i0jQXdthxvB28wb++RY
        MLryOK5jnkfZ7MT2RxEu4K0=
X-Google-Smtp-Source: ABdhPJz18O5o0EYwKWuRD2/VV9tPzNMOAquUWPZmqL7c3La+ZxSp2jwLApG25RYI/RNZg3Xq2Qd7yg==
X-Received: by 2002:a05:6512:39c2:: with SMTP id k2mr5581182lfu.49.1643138263873;
        Tue, 25 Jan 2022 11:17:43 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z23sm819001lfu.84.2022.01.25.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:17:42 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 25 Jan 2022 20:17:40 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <YfBM1IF9maxuAAcL@pc638.lan>
References: <20220125163912.2809-1-urezki@gmail.com>
 <YfAqRrGD2UKrZHfJ@casper.infradead.org>
 <YfAvkKZlVQYukays@pc638.lan>
 <YfBFi5IqC0MtLADf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBFi5IqC0MtLADf@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:46:35PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 06:12:48PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 25, 2022 at 04:50:14PM +0000, Matthew Wilcox wrote:
> > > On Tue, Jan 25, 2022 at 05:39:12PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > @@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> > > >  
> > > >  	/* After this point, we may free va at any time */
> > > >  	if (unlikely(nr_lazy > lazy_max_pages()))
> > > > -		try_purge_vmap_area_lazy();
> > > > +		if (!atomic_xchg(&drain_vmap_work_in_progress, 1))
> > > > +			schedule_work(&drain_vmap_work);
> > > >  }
> > > 
> > > Is it necessary to have drain_vmap_work_in_progress?  The documentation
> > > says:
> > > 
> > >  * This puts a job in the kernel-global workqueue if it was not already
> > >  * queued and leaves it in the same position on the kernel-global
> > >  * workqueue otherwise.
> > > 
> > > and the implementation seems to use test_and_set_bit() to ensure this
> > > is true.
> > >
> > It checks pending state, if the work is in run-queue you can place it
> > one more time. The motivation of having it is to prevent the drain work
> > of being placed several times at once what i see on my stress testing.
> > 
> > CPU_1: invokes vfree() -> queues the drain work -> TASK_RUNNING
> > CPU_2: invokes vfree() -> queues the drain work one more time since it was not pending
> 
> But why not unconditionally call schedule_work() here?
>
We can :) The question is do we agree that extra queuing will be kind of
spurious? Because the CPU_1 will complete all cleanups once it is physically
on CPU and others workers just bail out.

We can disregard those spurious wake-ups for sure. If someone complains about
it in the future we can think later then.

Re-spin and do it unconditionally? I do not have a strong opinion about it.

--
Vlad Rezki
