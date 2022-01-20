Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45971494BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiATKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiATKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:43:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:43:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x22so19874388lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8enaquFPBu9Rpl1lG/EB/zWJM1rWqPYYB01U+8SlZc=;
        b=oXvULXpXY39sn/jk9FL0LtiC63NW6iWNXXZVo5rqmBPF5xoqFHjU8jlcEnuXKQEI7Q
         Mx5lL1NbP0vXAfuawEE92Zi+fkjnoP+iz2gZQShMiGJmzFqk9E/dN+CKuPQiijbNSAa9
         vDgaZ0UGpq3xYX0N2W37llQ9s4ktRUrU4UfuTK+arb82xBrlAVruWLXJTvBgCSqbzXbx
         /cfeFgRNZ+dh9Tnz3fq1kglShta/8PluJrqt1gyluxPloElSAJcOf8/ouQM7LTjgo4n5
         CZWBPFtgmNooZ6qycOa8RmAH9o13sNJhcEmm1v3dCNNC1mU8ZvSCt3Bu0TEjzhmMlFv9
         ziHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8enaquFPBu9Rpl1lG/EB/zWJM1rWqPYYB01U+8SlZc=;
        b=S+x99gxQ7RonlPPJD/UKZIJU/pAtvxRf4UDGNeupsHSjMQoQxestmid4ksU82biPrF
         bS/krpl9jBo+HRR88zqMc/Wg4/ah4IqUoA7cJUE6QI1XDJznUToHfV4CgWXsT+Od/PiO
         Qw9Wt66R7dy4uGlK2aGIM3yvkl/Q4kE49wFg7nOgC0Ixk1WzHjUEP+ENR8OO3ywA0lmt
         16/oOYsbh24PkMy2+3+gm/LRtl5b2qZu5NmPJLIcduNRwg1H0FTRRVzQIRoIa03hb2cI
         WiRo8pg5ETuKRGkripfDZ/e9nFL493tEmx8h0TzsAnTriQOrPmxbK0l0fDYzF9ETzspH
         PPwA==
X-Gm-Message-State: AOAM531Dtvx0jmMTqqud+XCOhwcu9+55GTofRhkx9tF868VXj2kj4kP6
        bjPvfb+sziRZF7YWvi+RS74hr1BrqshQgg==
X-Google-Smtp-Source: ABdhPJxs3QH4HwQUqKal4LjMvk7mDm2E1Z0ozXp3fEq5x26kAJj6tCxvI44ITmPVr+BvCAWXOcgHZQ==
X-Received: by 2002:a2e:9845:: with SMTP id e5mr24030748ljj.154.1642675382981;
        Thu, 20 Jan 2022 02:43:02 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b7sm248930ljp.35.2022.01.20.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:43:01 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 20 Jan 2022 11:42:56 +0100
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] mm/vmalloc: Move draining areas out of caller context
Message-ID: <Yek8sHMQuLZb3nCM@pc638.lan>
References: <20220119143540.601149-1-urezki@gmail.com>
 <YeknfRnxaxcVxEjF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeknfRnxaxcVxEjF@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 19, 2022 at 03:35:38PM +0100, Uladzislau Rezki (Sony) wrote:
> > +static void drain_vmap_area(struct work_struct *work)
> 
> Nit, but I prefer to have a _work postix for workers just to keep
> it easy to ready.
> 
Will fix it!

> >  	/* After this point, we may free va at any time */
> >  	if (unlikely(nr_lazy > lazy_max_pages()))
> > -		try_purge_vmap_area_lazy();
> > +		if (!atomic_xchg(&drain_vmap_area_work_in_progress, 1))
> > +			schedule_work(&drain_vmap_area_work);
> 
> Work items are defined to be single threaded, so I don't think we need
> the drain_vmap_area_work_in_progress hack.
> 
The motivation with that hack was to prevent the drain work being placed
several times at once, i.e. schedule_work() checks only a pending bit.

If the work is in run-queue another caller of vfree() will place it one
more time, since pending bit is not set because the work is in TASK_RUNNING
state.

Or am i missing something?

--
Vlad Rezki
