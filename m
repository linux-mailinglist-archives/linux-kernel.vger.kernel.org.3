Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A678746DEFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbhLHXZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhLHXZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:25:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 15:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KIQEGoY4fUnWl+kJio7CsnZTP/syTcCP6a2XL8diqvI=; b=k6XOg/QBVgraB+NcNH6jylobg6
        V2qvv7c5gAmx/jq/pcVEVktr/VkKvd+FVsTduFhsGCe5uBlGCN1CiqEpcoNw0dvtYKhN6vHEgzcPk
        8gAf5zMKnTD13k1NOjt4NngUtf6zJaexL3B2RlY8RUf8Q4hC7mXB5OKv0nA8J0M8OKwjkDOhZTU2S
        /MnMBqJS/cXcWws4BeqDBenS4IxnaR6Tg0dgW/Y8uCtZX6uROP80B8XmCYK6qqZomcDNwmYLwf7fQ
        9w/dKZgqPEy7GUQqrBXwBZu7ND8zpy8p9qkkJVx78EBhx3HX0quMhuBuUrcE1x4o0+um8WP5mQMoB
        JHKSLHRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv6GB-008qxE-W8; Wed, 08 Dec 2021 23:22:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE6F4981728; Thu,  9 Dec 2021 00:22:03 +0100 (CET)
Date:   Thu, 9 Dec 2021 00:22:03 +0100
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
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <20211208232203.GC16608@worktop.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205224843.1503081-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> While commit f79256532682 ("perf/core: fix userpage->time_enabled of
> inactive events") fixed this problem for user rdpmc usage,

You're referring to 'this problem' before actually describing a problem :-(

Also, you now have me looking at that commit again, and I'm still hating
it. Also, I'm again struggling to make sense of it; all except the very
last hunk that is.

So the whole, full-fat, mmap self-monitor thing looks like:


	u32 seq, time_mult, time_shift, index, width = 64;
	u64 count, enabled, running;
	u64 cyc, time_offset, time_cycles = 0, time_mask = ~0ULL;
	u64 quot, rem, delta;
	s64 pmc = 0;

	do {
		seq = pc->lock;
		barrier();

		enabled = pc->time_enabled;
		running = pc->time_running;

		if (pc->cap_user_time && enabled != running) {
			cyc = rdtsc();
			time_offset = pc->time_offset;
			time_mult   = pc->time_mult;
			time_shift  = pc->time_shift;
		}

		if (pc->cap_user_time_short) {
			time_cycles = pc->time_cycles;
			time_mask   = pc->time_mask;
		}

		index = pc->index;
		count = pc->offset;
		if (pc->cap_user_rdpmc && index) {
			width = pc->pmc_width;
			pmc = rdpmc(index - 1);
		}

		barrier();
	} while (pc->lock != seq);

	if (width < 64) {
		pmc <<= 64 - width;
		pmc >>= 64 - width;
	}
	count += pmc;

	cyc = time_cycles + ((cyc - time_cycles) & time_mask);

	quot = (cyc >> time_shift);
	rem = cyc & ((1ULL < time_shift) - 1);
	delta = time_offset + quot * time_mult +
		((rem * time_mult) >> time_shift);

	enabled += delta;
	if (index)
		running += delta;

	quot = count / running;
	rem  = count % running;
	count = quot * enabled + (rem * enabled) / running;


Now, the thing that sticks out to me is that 'enabled' is
unconditionally advanced. It *always* runs.

So how can not updating ->time_enabled when the counter is INACTIVE due
to rotation (which causes ->index == 0), cause enabled to not be
up-to-date?

Can we please figure that out so I can go revert all but the last hunk
of that patch?
