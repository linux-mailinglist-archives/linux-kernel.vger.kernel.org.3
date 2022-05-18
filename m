Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C152B6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiERJnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiERJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:41:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F31C123
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WMIQhBjGQ1AyewOOSm+elcUwgB8iEM4v1qmvWm/lR2g=; b=XEvnqIPkN9Db3ze+a+4kzYnbOO
        36gqGPjKECEBvvuiZf3efaGVETypr6da7xy2QUE8K9VsQMWKM9brv0hHVBnIgbCDZ8hm4CdhoHC3K
        bsDPx205shVP5QeBFg4y55I1Mb8n6RE7jKC2P6NyVNL7tcL3UxmL8ND4yUAgfBn4/Dr0CWfMU6Qv/
        sXGr4eWbTmf9y6hMHOv/G1s7VAbFBs3MntLSnHkJUebbCfkC6cVzT4jIJnTwaAkO1dLAHK3Bdz9rc
        +Um+VridYpNhK1iAMGG0qcTfX9mlWjMXNtOe7vucFfTH6LMNla9br7o5coiJe7ti/SdVPEQDIKpIi
        2oJO5MMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrGB8-001V4E-Ux; Wed, 18 May 2022 09:41:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F2D5980DFF; Wed, 18 May 2022 11:41:12 +0200 (CEST)
Date:   Wed, 18 May 2022 11:41:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Message-ID: <20220518094112.GE10117@worktop.programming.kicks-ass.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511143038.4620-5-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:30:38PM +0100, Mel Gorman wrote:
> For a single LLC per node, a NUMA imbalance is allowed up until 25%
> of CPUs sharing a node could be active. One intent of the cut-off is
> to avoid an imbalance of memory channels but there is no topological
> information based on active memory channels. Furthermore, there can
> be differences between nodes depending on the number of populated
> DIMMs.
> 
> A cut-off of 25% was arbitrary but generally worked. It does have a severe
> corner cases though when an parallel workload is using 25% of all available
> CPUs over-saturates memory channels. This can happen due to the initial
> forking of tasks that get pulled more to one node after early wakeups
> (e.g. a barrier synchronisation) that is not quickly corrected by the
> load balancer. The LB may fail to act quickly as the parallel tasks are
> considered to be poor migrate candidates due to locality or cache hotness.
> 
> On a range of modern Intel CPUs, 12.5% appears to be a better cut-off
> assuming all memory channels are populated and is used as the new cut-off
> point. A minimum of 1 is specified to allow a communicating pair to
> remain local even for CPUs with low numbers of cores. For modern AMDs,
> there are multiple LLCs and are not affected.

Can the hardware tell us about memory channels?
