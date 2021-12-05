Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9C468B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhLEOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhLEOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:19:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC11C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OlYeA7fWwhONv4IrRanzGJcIMgNT0Z+hlWAC6Xi8Zag=; b=nTqNWIMmrI6nz07sOtKYfxHWA8
        K0i2ZsXwunEl1eoUdHYftkapGU+4NKf7PDS7KmFixNtCrr3l0zg7uj4d8Kw++Nx4CaxdOKJ5TwOwa
        oDrEOMSj4RQ42DxtLtfmEUiKEf+Rd/AzXmJKHpnFMqX/RyThxYXVq5+xUkec8TeowRM2wNcfL2jj8
        LcSy9BttbELoa3uOeRq1uGOHRqTwabewYdYnwpjXfWrqel2du8B/8J11hiwlHR4DKV703qSIhzPvy
        nLDf793W0hQq931OF427rPeBduiJJTyuy6eePZZBAi1nRATpadfmDb07jV8gipERg7LtbNoHvA9af
        gOPqLHaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtsJ4-000Btd-Pn; Sun, 05 Dec 2021 14:15:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0697E98168C; Sun,  5 Dec 2021 15:15:59 +0100 (CET)
Date:   Sun, 5 Dec 2021 15:15:58 +0100
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
        Namhyung Kim <namhyung@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2] perf/core: Set event shadow time for inactive events
 too
Message-ID: <20211205141558.GX16608@worktop.programming.kicks-ass.net>
References: <20211201045807.1223200-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201045807.1223200-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:58:07PM -0800, Namhyung Kim wrote:
> From: Namhyung Kim <namhyung@google.com>
> 
> While f79256532682 ("perf/core: fix userpage->time_enabled of inactive
> events") fixed this problem for user rdpmc usage, bperf (perf stat
> with BPF) still has the same problem that accessing inactive perf
> events from BPF using bpf_perf_event_read_value().
> 
> +static inline void group_update_event_time(struct perf_event *group_event)
>  {
> +	struct perf_event *event;
> +	struct perf_event_context *ctx = group_event->ctx;

:-( surely you're aware of the reverse xmas tree thing by now?

>  
> +	perf_event_update_time(group_event);
> +	perf_set_shadow_time(group_event, ctx);
>  
> +	for_each_sibling_event(event, group_event) {
> +		perf_event_update_time(event);
> +		perf_set_shadow_time(event, ctx);
> +	}
>  
> +	if (likely(!atomic_read(&group_event->mmap_count)))
>  		return;
>  
> +	perf_event_update_userpage(group_event);
> +
>  	for_each_sibling_event(event, group_event)
> +		perf_event_update_userpage(event);

How does it make sense to chase those pointers twice?

>  }
