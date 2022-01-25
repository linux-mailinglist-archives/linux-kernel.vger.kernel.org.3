Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B749BA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587680AbiAYRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381187AbiAYROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:14:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C4C0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:12:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p27so58114310lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UoNr+FE7GC0nQ8z1tVChh4XpJW2PQJ2WwCVe19A6is=;
        b=S2Xsca/pBrSKIBu1XKkk91Xs6ui1f21MF3n7w3FTBVND1oL16KZrrPpJdcJhz7N8gq
         kNPz454MhzpkjAx5abKNt0qGL0SPSWK/V7A2IdmQoioVfo6k+QfsCUJNofdglfsLsuJe
         OG1POLzTyyAeU9x8rx1YqUgR/WwrpZa+m3ZMeR3L83MwNAOB3HYFBCJIbd4mRYVahCEF
         PkMSRPs3MDZDLLZkFnWeqyTSd8NGhoR2ryosiLv6PnnBDOu4INgjD/dlABbS3QP8Oznr
         qzuQTq8oEm9Sq+Ma43usJI2a3QEwKCkkxXZsEuHKCu+ToD2dFF9/2oVU3mtxmUiE3VoW
         CVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UoNr+FE7GC0nQ8z1tVChh4XpJW2PQJ2WwCVe19A6is=;
        b=RqA9B1r1WSbdHtqxF2yx/ySaRlKzhjAbRcwi6nEl4JJkQ+BDog9bPdsACz8IzWF93O
         +tNl/OEuP6ZxyaUXOQ1CVHkgxDb6x5fnMzK1FCeM0iAk11xAbkC+k9Y7uKdDpSb2XE34
         qUUUDrHE39yScnT/X/m2sAKQHPhXzmqACZayDdXe63/3kGP4U/p7Mq0XUrfk4NaIVt0C
         87DXrGgmDdvOchJRfp+ltYcXqSFXYGz/K6PfLb6lj/CFn9qJmafGEE7v5A5QrAzRdc91
         rphuwpgbF3GfUOt0XW389PSn3XmhysH3aJvVblhpEi9C/YHcS8XQQaBppyQ2H74OSmYS
         g2ew==
X-Gm-Message-State: AOAM533Pdc9SO5n3vL6V5AuLkGk/6IYBnEZMrRun2F4BASvmAUq5fRkp
        isSg+iYbyrz6ESsWHq8Iny9/Me5PwpMOjA==
X-Google-Smtp-Source: ABdhPJx4+NuT/KQg6rH8VOKC0RxcPtnDegIVdCANBNAXvi3Iuq/FjmXDFFXH8gMZ2jDn8dNZ6IZcrA==
X-Received: by 2002:a05:6512:39c6:: with SMTP id k6mr8279504lfu.193.1643130772056;
        Tue, 25 Jan 2022 09:12:52 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id n17sm741684lft.140.2022.01.25.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 25 Jan 2022 18:12:48 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <YfAvkKZlVQYukays@pc638.lan>
References: <20220125163912.2809-1-urezki@gmail.com>
 <YfAqRrGD2UKrZHfJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfAqRrGD2UKrZHfJ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:50:14PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 05:39:12PM +0100, Uladzislau Rezki (Sony) wrote:
> > @@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> >  
> >  	/* After this point, we may free va at any time */
> >  	if (unlikely(nr_lazy > lazy_max_pages()))
> > -		try_purge_vmap_area_lazy();
> > +		if (!atomic_xchg(&drain_vmap_work_in_progress, 1))
> > +			schedule_work(&drain_vmap_work);
> >  }
> 
> Is it necessary to have drain_vmap_work_in_progress?  The documentation
> says:
> 
>  * This puts a job in the kernel-global workqueue if it was not already
>  * queued and leaves it in the same position on the kernel-global
>  * workqueue otherwise.
> 
> and the implementation seems to use test_and_set_bit() to ensure this
> is true.
>
It checks pending state, if the work is in run-queue you can place it
one more time. The motivation of having it is to prevent the drain work
of being placed several times at once what i see on my stress testing.

CPU_1: invokes vfree() -> queues the drain work -> TASK_RUNNING
CPU_2: invokes vfree() -> queues the drain work one more time since it was not pending
...

Instead of drain_vmap_work_in_progress hack we can make use of work_busy()
helper. The main concern with that was the comment around that function:

/**
 * work_busy - test whether a work is currently pending or running
 * @work: the work to be tested
 *
 * Test whether @work is currently pending or running.  There is no
 * synchronization around this function and the test result is
 * unreliable and only useful as advisory hints or for debugging.
 *
 * Return:
 * OR'd bitmask of WORK_BUSY_* bits.
 */

i am not sure how reliable this is.

Thoughts?

--
Vlad Rezki
