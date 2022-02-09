Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8B4AEE29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiBIJlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:41:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiBIJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:38:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFCC003641
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtUNZ4s01M6g6RdXvEjIliRhqQEYsPwz6AWii/ZtLpg=; b=dNpieonr1BtMyKj8yCUtfbkPtJ
        3kLQTSK4DVNughTfQzVLdIcHgdh+CAFZC06vZaMlhQmDu2SeTL5icfhy/Q9sJxWj/2umgUBPQA2hR
        UdHF8vSVgnqEEK74YWOpJ7VKEHUT7dP6EY4DrM5poXhmtiHpFd9uFHDh7kkWWMkEynKScNxn/Ivb3
        KCV0x2lTs1/QfOZ6nXxE9+LW4ORVEMoItBIyOh+sEy6SX86PRzZ/tWLQU4iQd219iqdZl0q12dhoS
        0kECkfWzx+LEQ58oQpctjG5QjlvcHXLYRMLs4LzAu/uUiY0lMVa8vNUJHDK7ril4mqTU7cqHUc4ZI
        dfG1KdTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHjQj-008NfZ-Sd; Wed, 09 Feb 2022 09:38:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B82F89853C7; Wed,  9 Feb 2022 10:38:28 +0100 (CET)
Date:   Wed, 9 Feb 2022 10:38:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] Adjust NUMA imbalance for multiple LLCs
Message-ID: <20220209093828.GL23216@worktop.programming.kicks-ass.net>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208094334.16379-1-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:43:32AM +0000, Mel Gorman wrote:
> Changelog sinve v5
> o Fix off-by-one error
> 
> Changelog since V4
> o Scale imbalance based on the top domain that prefers siblings
> o Keep allowed imbalance as 2 up to the point where LLCs can be overloaded
> 
> Changelog since V3
> o Calculate imb_numa_nr for multiple SD_NUMA domains
> o Restore behaviour where communicating pairs remain on the same node
> 
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
> 
> The series addresses two problems -- inconsistent logic when allowing a
> NUMA imbalance and sub-optimal performance when there are many LLCs per
> NUMA node.
> 
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 30 ++++++++++---------
>  kernel/sched/topology.c        | 53 ++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 13 deletions(-)

Thanks!
