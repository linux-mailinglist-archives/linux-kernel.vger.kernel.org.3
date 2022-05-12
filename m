Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E375255D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbiELThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiELThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212F62CC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0AD361BE2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A5C34117;
        Thu, 12 May 2022 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652384265;
        bh=lQpabCphLsIePbatgCbsEpbOuoC7zkFlFeb5DU65TmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYDyTW9RGEvNnX3N0dpBTAO528x9y7IuNfzSzRDBC2Mk0Ks6gaTOiZk8NWCT4N/Xq
         r4XbMICQYY5ENy20WojmmEBXmIYChvUFqlRtj+PxhjzdXlxbIu/aU3v709AUGOvRXT
         ajOHnuqlikd883wEH/JTxU1sAv15kCNPcAIbn82Y=
Date:   Thu, 12 May 2022 12:37:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
Message-Id: <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
In-Reply-To: <20220512085043.5234-7-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
        <20220512085043.5234-7-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 09:50:43 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> From: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> drain work queued by __drain_all_pages(). So introduce a new mechanism to
> remotely drain the per-cpu lists. It is made possible by remotely locking
> 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this new scheme
> is that drain operations are now migration safe.
> 
> There was no observed performance degradation vs. the previous scheme.
> Both netperf and hackbench were run in parallel to triggering the
> __drain_all_pages(NULL, true) code path around ~100 times per second.
> The new scheme performs a bit better (~5%), although the important point
> here is there are no performance regressions vs. the previous mechanism.
> Per-cpu lists draining happens only in slow paths.
> 
> Minchan Kim tested this independently and reported;
> 
> 	My workload is not NOHZ CPUs but run apps under heavy memory
> 	pressure so they goes to direct reclaim and be stuck on
> 	drain_all_pages until work on workqueue run.
> 
> 	unit: nanosecond
> 	max(dur)        avg(dur)                count(dur)
> 	166713013       487511.77786438033      1283
> 
> 	From traces, system encountered the drain_all_pages 1283 times and
> 	worst case was 166ms and avg was 487us.
> 
> 	The other problem was alloc_contig_range in CMA. The PCP draining
> 	takes several hundred millisecond sometimes though there is no
> 	memory pressure or a few of pages to be migrated out but CPU were
> 	fully booked.
> 
> 	Your patch perfectly removed those wasted time.

I'm not getting a sense here of the overall effect upon userspace
performance.  As Thomas said last year in
https://lkml.kernel.org/r/87v92sgt3n.ffs@tglx

: The changelogs and the cover letter have a distinct void vs. that which
: means this is just another example of 'scratch my itch' changes w/o
: proper justification.

Is there more to all of this than itchiness and if so, well, you know
the rest ;)

