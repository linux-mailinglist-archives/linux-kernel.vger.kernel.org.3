Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF364CD81C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiCDPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiCDPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:40:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF671C664A;
        Fri,  4 Mar 2022 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2oRDZsuNGrwg4ZW4QGeKyjKlKY/1cuXv9zPS2PZras=; b=SH/pl5Db9JCgKZpNoXynYkzcn9
        K6K6kmc5uFDT2VLC/i9cnD7UaJF1TJXstrezlE8pLc32wryhkQXgePI9ZlhmBJfNgcWCJUkXPeNGS
        PMReH4h6GJOWiV62TlogrsDyqr92faFaeuqOByZZF9l3+CdTMzAaK56nBoaocvD0nSQSNCBRTg+Qd
        4BsHZpf5f+ha0hImA7vPhg55lw1LH4u24842SLUuIoO70Qxz6p5pQIPhYafclAoSjAgpZoI4Bn+n+
        X+80sOHS8/rQe4lhz8B7Bqkd+HTk+x05nUaXMvXuJypgfUZwDY+yZyO0+Vrq2e15gW6XE0dDp8qHK
        8n4SYstQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQA1f-00Ckbk-FB; Fri, 04 Mar 2022 15:39:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FAE73001EA;
        Fri,  4 Mar 2022 16:39:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 507452012A02A; Fri,  4 Mar 2022 16:39:24 +0100 (CET)
Date:   Fri, 4 Mar 2022 16:39:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <simon.wy@alibaba-inc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
Message-ID: <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304110351.47731-2-simon.wy@alibaba-inc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:03:51PM +0800, Wen Yang wrote:
> this issue has been there for a long time, we could reproduce it as follows:

What issue? You've not described an issue. So you cannot reference one.

This is still completely unreadable gibberish.

> 1, run a script that periodically collects perf data, eg:
> while true
> do
>     perf stat -e cache-misses,cache-misses,cache-misses -c 1 sleep 2
>     perf stat -e cache-misses -c 1 sleep 2
>     sleep 1
> done
> 
> 2, run another one to capture the ipc, eg:
> perf stat -e cycles:d,instructions:d  -c 1 -i 1000

<snip line noise>

> the reason is that the nmi watchdog permanently consumes one fp
> (*cycles*). therefore, when the above shell script obtains *cycles*
> again, only one gp can be used, and its weight is 5.
> but other events (like *cache-misses*) have a weight of 4,
> so the counter used by *cycles* will often be taken away, as in
> the raw data above:
> [1]
>   n_events = 3
>   assign = {33, 1, 32, ...}
> -->
>   n_events = 6
>   assign = {33, 3, 32, 0, 1, 2, ...}

Again unreadable... what do any of those numbers mean?

> 
> so it will cause unnecessary pmu_stop/start and also cause abnormal cpi.

How?!?

> Cloud servers usually continuously monitor the cpi data of some important
> services. This issue affects performance and misleads monitoring.
> 
> The current event scheduling algorithm is more than 10 years old:
> commit 1da53e023029 ("perf_events, x86: Improve x86 event scheduling")

irrelevant

> we wish it could be optimized a bit.

I wish for a unicorn ...

> The fields msk_counters and msk_events are added to indicate currently
> used counters and events so that the used ones can be skipped
> in __perf_sched_find_counter and perf_sched_next_event functions to avoid
> unnecessary pmu_stop/start.

Still not sure what your actual problem is, nor what the actual proposal
is.

Why should I attempt to reverse engineer your code without basic
understanding of what you're actually trying to achieve?
