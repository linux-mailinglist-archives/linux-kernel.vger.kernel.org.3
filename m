Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874574673CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379483AbhLCJVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:21:30 -0500
Received: from out1.migadu.com ([91.121.223.63]:44279 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351372AbhLCJVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:23 -0500
Date:   Fri, 3 Dec 2021 17:17:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638523078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRRcKTkq0gHKNp/1iXJzXbhalmkcrndZwlkadLPBwxI=;
        b=OjxdyOaB9u43vku1s/oXzfeVtG6jDIVjT6DU3FCM5MKcHijMpQ+Wt8QBs2RMEAaOTGcDaP
        LCsKC9fQVZcZNTMeiotb8g9o74vnSUlFBxF2AYCLEIsy9sTMX3+Fh2Ykl4REPLDoIEKvYV
        7SWZUsT7H9PauEtCPHElyDBtnjY2Wag=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 07/14] rtla/timerlat: Add timerlat hist mode
Message-ID: <YangwS/M9hO+o7TH@geo.homenetwork>
References: <cover.1638182284.git.bristot@kernel.org>
 <eb486340cc983bd8f7f69fe6f99f8d2927fcd296.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb486340cc983bd8f7f69fe6f99f8d2927fcd296.1638182284.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:07:45PM +0100,
Daniel Bristot de Oliveira wrote:

> +static void timerlat_hist_usage(char *usage)
> +{
> +	int i;
> +
> +	char *msg[] = {
> +		"",
> +		"  usage: [rtla] timerlat hist [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
> +		"         [-c cpu-list] [-P priority] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
> +		"         [--no-index] [--with-zeros]",
> +		"",
> +		"	  -h/--help: print this menu",
> +		"	  -p/--period us: timerlat period in us",
> +		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
> +		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
> +		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
> +		"	  -c/--cpus cpus: run the tracer only on the given cpus",
> +		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
> +		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
> +		"	  -n/--nano: display data in nanoseconds",
> +		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
> +		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
> +		"	     --no-irq: ignore IRQ latencies",
> +		"	     --no-thread: ignore thread latencies",
> +		"	     --no-header: do not print header",
> +		"	     --no-summary: do not print summary",
> +		"	     --no-index: do not print index",
> +		"	     --with-zeros: print zero only entries",
> +		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
> +		"		o:prio - use SCHED_OTHER with prio",
> +		"		r:prio - use SCHED_RR with prio",
> +		"		f:prio - use SCHED_FIFO with prio",
> +		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
> +		"						       in nanoseconds",
> +		NULL,
> +	};

[-t us] --> [-T us]
[-T[=file]] --> [-t[=file]]
[-d] [-b] [-e] [-n] lack in usage info. this is not important tho.
