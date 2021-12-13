Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA6473665
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhLMVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240899AbhLMVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:09:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50731C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1y1X36Ob8cU0XGIpCqJ5e0YF1TEd/Y/leqFCnMQMzVM=; b=l3KyKA+Z7eWQoL9j1RlZbno6mg
        vNGt5KIwmnO07E9rCmeATEXVn9BjTp7nL9IQSbIYN89XgKL6bKYzoBJKRrsjqey/7SHdsCEbEnybD
        E5WQaSp2TWUWdMC+jgVuDiEJ5iXRBY+td10bJYfeo+VSc4/m6TLKhzBZ5CmWUDd5hcfQeB8KO/BVz
        FgEFwzCnmVvnC6bggiV4V3nq9xLvQ2Gwx9M4q+AH2Wmmz6/zb8gwBP5KHa6J36ymS1OKrssACVFWM
        ddVOx9xxO46PzJtShpM/hUxnwdUyJWNrlgdrwjic5qOlrtlFa1sip1WeMbu91T3Vs5uuQEn/N3hDl
        53ws3vJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwsZ9-00D9rp-On; Mon, 13 Dec 2021 21:09:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AB49981767; Mon, 13 Dec 2021 22:08:59 +0100 (CET)
Date:   Mon, 13 Dec 2021 22:08:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        kernel test robot <lkp@intel.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] perf/core: Fix cgroup event list management
Message-ID: <20211213210859.GC16608@worktop.programming.kicks-ass.net>
References: <20211213065936.1965081-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213065936.1965081-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 10:59:36PM -0800, Namhyung Kim wrote:
> The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
> This list is accessed from current cpu and not protected by any locks.
> But from the commit ef54c1a476ae ("perf: Rework
> perf_event_exit_event()"), this assumption does not hold true anymore.
> 
> In the perf_remove_from_context(), it can remove an event from the
> context without an IPI when the context is not active.  I think it
> assumes task event context, but it's possible for cpu event context

Yes, event_function_call() in general doesn't work, but for cpu events
it does.

> only with cgroup events can be inactive at the moment - and it might
> become active soon.

It can't, we're holding ctx->mutex and ctx->lock, and since it's a cpu
event, that's cpuctx.

But yes, cgrp_cpuctx_list relies on being strictly per-cpu and I can't
come up with a better solution either, doing those IPIs suck but...

But please, put in a comment like:

	/*
	 * Cgroup events are per-CPU events, and must IPI because of
	 * cgrp_cpuctx_list.
	 */
	if (!ctx->is_active || !is_cgroup_event(event)) {
