Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76D467CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382396AbhLCRpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:45:12 -0500
Received: from gateway30.websitewelcome.com ([192.185.198.26]:40473 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239496AbhLCRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:45:11 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 3B31324B9D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:41:43 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id tCZ5mDAH1jXZUtCZ5mZZCP; Fri, 03 Dec 2021 11:41:43 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:47266 helo=[10.0.0.165])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mtCZ3-002YDG-So; Fri, 03 Dec 2021 11:41:42 -0600
Message-ID: <e39ddd6d-27f0-e70e-17a1-b5bb1134d2fc@kernel.org>
Date:   Fri, 3 Dec 2021 18:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 06/14] rtla: Add timerlat tool and timelart top mode
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
 <e65a6899bbde6ecb129cfaf55e402d785ad124eb.1638182284.git.bristot@kernel.org>
 <YanfyfUgMW6KWpxS@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YanfyfUgMW6KWpxS@geo.homenetwork>
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
X-Exim-ID: 1mtCZ3-002YDG-So
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.165]) [79.34.250.122]:47266
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 10:13, Tao Zhou wrote:
>> +/*
>> + * timerlat_top_usage - prints timerlat top usage message
>> + */
>> +static void timerlat_top_usage(char *usage)
>> +{
>> +	int i;
>> +
>> +	static const char *const msg[] = {
>> +		"",
>> +		"  usage: rtla timerlat [top] [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
>> +		"	  [-c cpu-list] [-P priority]",
>> +		"",
>> +		"	  -h/--help: print this menu",
>> +		"	  -p/--period us: timerlat period in us",
>> +		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
>> +		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
>> +		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
>> +		"	  -c/--cpus cpus: run the tracer only on the given cpus	  -d/--duration time[m|h|d]: duration of the session in seconds",
>> +		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
>> +		"	  -n/--nano: display data in nanoseconds",
>> +		"	  -q/--quiet print only a summary at the end",
>> +		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
>> +		"		o:prio - use SCHED_OTHER with prio",
>> +		"		r:prio - use SCHED_RR with prio",
>> +		"		f:prio - use SCHED_FIFO with prio",
>> +		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
>> +		"						       in nanoseconds",
>> +		NULL,
>> +	};
> About help usage msg.
> 
> [-t us] --> [-T us]
> [-T=[file]] --> [-t[=file]]
> 
> [-d] [-D] [-n] lack in the head usage info 'usage: ...'
> 

Fixed in V9

-- Daniel
