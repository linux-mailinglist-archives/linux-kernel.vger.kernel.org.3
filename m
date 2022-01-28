Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B749FC89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiA1POS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiA1POD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:14:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFFC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uf8qWeDju8EH3M4vP62u102f0sClYZhITwuykA+5lcI=; b=S2yemxHQ9pSElwsy3naRSvLYzs
        q1fjmb9VL3m6rkOpr3oO+YkxYiyDOKYj3wMXLgjP0Ty1xiwtL0Npy6j5jRzL3UBd+9uzL2Uax0FuO
        giJDrPWLK5UyWJpeEhr4Fl54O3oPpA7a2hHPtdrZU1DKiZD6rPmHGHOLcZsHYCL7oqpFn+sMh58pl
        /PYtdCSUFrstJ0zAfrs2bn66HPvAwROdw/UIvhB2gkGBo2uaY1/Lc7wRlakjn9r5j2ePIZLrnBRcg
        +L5UiHAbiVWGLfGjFVEkjohfo5ijZTKsS0uHU3hMxEROOGxzglFYRHNy4M4Yrz96xE2LQKFj4/Yn1
        lV1ggqvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDSwl-004aWZ-7E; Fri, 28 Jan 2022 15:13:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BCC330002E;
        Fri, 28 Jan 2022 16:13:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FE7A2142D5E8; Fri, 28 Jan 2022 16:13:54 +0100 (CET)
Date:   Fri, 28 Jan 2022 16:13:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for
 memory tiering system
Message-ID: <YfQIMmbY7nHusQRK@hirez.programming.kicks-ass.net>
References: <20220128023842.1946583-1-ying.huang@intel.com>
 <20220128052345.GA618915@linux.vnet.ibm.com>
 <87czkctiz9.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czkctiz9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:30:50PM +0800, Huang, Ying wrote:
> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> > * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:41]:
> >
> >> 
> >> One possible fix is to ignore CPU-less nodes when detecting NUMA
> >> topology type in init_numa_topology_type().  That works well for the
> >> example system.  Is it good in general for any system with CPU-less
> >> nodes?
> >> 
> >
> > A CPUless node at the time online doesn't necessarily mean a CPUless node
> > for the entire boot. For example: On PowerVM Lpars, aka powerpc systems,
> > some of the nodes may start as CPUless nodes and then CPUS may get
> > populated/hotplugged on them.
> 
> Got it!
> 
> > Hence I am not sure if adding a check for CPUless nodes at node online may
> > work for such systems.
> 
> How about something as below?

I'm thinking that might not be enough in that scenario; if we're going
to consistently skip CPU-less nodes (as I really think we should) then
__sched_domains_numa_masks_set() is not sufficient for the hotplug case
since sched_domains_numa_levels and sched_max_numa_distance can also
change.

This means we need to re-do more of sched_init_numa() and possibly
re-alloc some of those arrays etc..

Same for offline ofc.
