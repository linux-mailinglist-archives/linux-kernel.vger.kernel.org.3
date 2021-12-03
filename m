Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5B467CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382268AbhLCSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:10:16 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.73]:15563 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353418AbhLCSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:10:12 -0500
X-Greylist: delayed 1478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 13:10:12 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 533E24F9C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:42:10 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id tCZVm3fLl0ESotCZVmtZxe; Fri, 03 Dec 2021 11:42:10 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:47268 helo=[10.0.0.165])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mtCZU-002YlH-6q; Fri, 03 Dec 2021 11:42:08 -0600
Message-ID: <aabde006-ce0e-fc68-63fb-58eb43648ef1@kernel.org>
Date:   Fri, 3 Dec 2021 18:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 07/14] rtla/timerlat: Add timerlat hist mode
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
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
References: <cover.1638182284.git.bristot@kernel.org>
 <eb486340cc983bd8f7f69fe6f99f8d2927fcd296.1638182284.git.bristot@kernel.org>
 <YangwS/M9hO+o7TH@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YangwS/M9hO+o7TH@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1mtCZU-002YlH-6q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.165]) [79.34.250.122]:47268
X-Source-Auth: kernel@bristot.me
X-Email-Count: 15
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 10:17, Tao Zhou wrote:
> On Mon, Nov 29, 2021 at 12:07:45PM +0100,
> Daniel Bristot de Oliveira wrote:
> 
>> +static void timerlat_hist_usage(char *usage)
>> +{
>> +	int i;
>> +
>> +	char *msg[] = {
>> +		"",
>> +		"  usage: [rtla] timerlat hist [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
>> +		"         [-c cpu-list] [-P priority] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
>> +		"         [--no-index] [--with-zeros]",
>> +		"",
>> +		"	  -h/--help: print this menu",
>> +		"	  -p/--period us: timerlat period in us",
>> +		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
>> +		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
>> +		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
>> +		"	  -c/--cpus cpus: run the tracer only on the given cpus",
>> +		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
>> +		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
>> +		"	  -n/--nano: display data in nanoseconds",
>> +		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
>> +		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
>> +		"	     --no-irq: ignore IRQ latencies",
>> +		"	     --no-thread: ignore thread latencies",
>> +		"	     --no-header: do not print header",
>> +		"	     --no-summary: do not print summary",
>> +		"	     --no-index: do not print index",
>> +		"	     --with-zeros: print zero only entries",
>> +		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
>> +		"		o:prio - use SCHED_OTHER with prio",
>> +		"		r:prio - use SCHED_RR with prio",
>> +		"		f:prio - use SCHED_FIFO with prio",
>> +		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
>> +		"						       in nanoseconds",
>> +		NULL,
>> +	};
> 
> [-t us] --> [-T us]
> [-T[=file]] --> [-t[=file]]
> [-d] [-b] [-e] [-n] lack in usage info. this is not important tho.
> 

Fixed in V9

-- Daniel
