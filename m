Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461F59C458
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiHVQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiHVQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:44:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0F19027
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pgna4G+ORkwBzTExUNzYbFkMVR58lcZ1tipVS99VrCA=; b=u8lhnh+ikact0cMnMKwecu96jg
        YxEqXE052FfErSiTCh5bdaYrdBv3/bxlC71cukHzFd4bLqBxEXG2CatEXgiAlGHDnJGtgvBz7nF5B
        EI5A7FXXR1FNZAo5Yg9vujiN4CuN76crEzzk+vTgG1r9aXuqNkRHEsTMMRr6Alk6uYa4isk8GAfxJ
        r1eqtmg1JwTZwACtKa+dH0rFBz8KzeLym5OFW+a39ynu4qQBAqJYHtddxqaJ6EMGCGmja+6kjr1JT
        MD5y63TYYQc+h0o5DqwUXbeoR7B23k3r7EAfqOKkzinc5CZVPyjR6thOkzuo0wN6Ct2YqXYujxrzs
        MCHtYJhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQAXI-00ET7y-1S; Mon, 22 Aug 2022 16:44:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE3C19804A3; Mon, 22 Aug 2022 18:44:22 +0200 (CEST)
Date:   Mon, 22 Aug 2022 18:44:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YwOyZhk/eqrsPa1q@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdP4NExuwOHdC0G@hirez.programming.kicks-ass.net>
 <35394cb7-a490-5aeb-b3a8-0f46e3c8ca28@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35394cb7-a490-5aeb-b3a8-0f46e3c8ca28@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:40:34AM +0530, Ravi Bangoria wrote:
> On 13-Jun-22 8:25 PM, Peter Zijlstra wrote:
> > On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> >> @@ -12125,6 +12232,8 @@ SYSCALL_DEFINE5(perf_event_open,
> >>  		goto err_task;
> >>  	}
> >>  
> >> +	// XXX premature; what if this is allowed, but we get moved to a PMU
> >> +	// that doesn't have this.
> >>  	if (is_sampling_event(event)) {
> >>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> >>  			err = -EOPNOTSUPP;
> > 
> > No; this really should be against the event's native PMU. If the event
> > can't natively sample, it can't sample when placed in another group
> > either.
> 
> Right. But IIUC, the question was, would there be any issue if we allow
> grouping of perf_sw_context sampling event as group leader and
> perf_{hw|invalid}_context counting event as group member. I think no. It
> should just work fine. And, there could be real usecases of it as you
> described in one old thread[1].

Like you I need to bend my brain around this again, but I'm not seeing a
contradiction. The use-case from [1] is a software sampler with a bunch
of non-sampling uncore events.

The uncore events aren't sampling, the are simply read by the software
event (SAMPLE_READ). And moving the sampling software event to the
non-sample capable uncore PMU shouldn't matter.

That is; the code as it stands here seems right, we should check
is_sampling_event() against an event's native pmu->capabilities.

Or am I misunderstanding things?
