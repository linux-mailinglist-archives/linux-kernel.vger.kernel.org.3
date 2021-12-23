Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB80F47E454
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbhLWOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:05:22 -0500
Received: from foss.arm.com ([217.140.110.172]:42740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLWOFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:05:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CF3AD6E;
        Thu, 23 Dec 2021 06:05:20 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1FCF3F5A1;
        Thu, 23 Dec 2021 06:05:18 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Keeping <john@metanate.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
In-Reply-To: <YcRkUt8nFCWI7PHn@donbot>
References: <Yb3vXx3DcqVOi+EA@donbot> <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com> <20211221164528.3c84543f.john@metanate.com> <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com> <87r1a4775a.mognet@arm.com> <YcRkUt8nFCWI7PHn@donbot>
Date:   Thu, 23 Dec 2021 14:05:13 +0000
Message-ID: <87mtkr76xy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/21 11:58, John Keeping wrote:
> On Wed, Dec 22, 2021 at 07:48:33PM +0000, Valentin Schneider wrote:
>> mark_wakeup_next_waiter() first deboosts the previous owner and then
>> wakeups the next top waiter. Seems like you somehow have the wakeup happen
>> before the push_rt_task IRQ work is run. Also, tell_cpu_to_push() should
>> only pick a CPU that is in rq->rd->rto_mask, which requires having at least
>> 2 RT tasks there...
>> 
>> Now, that wakeup from the rtmutex unlock would give us a resched_curr() via
>> check_preempt_curr() if required, which is good, though I think we are
>> still missing some for sched_setscheduler() (there are no wakeups
>> there). So if we just have to live with an IRQ work popping in before we
>> get to preempt_schedule_irq() (or somesuch), then perhaps the below would
>> be sufficient.
>
> With this patch I ran 100 reboots without hitting the BUG, so it looks
> like this is the solution!
>
> If you post this as a patch, feel free to add:
>
> 	Tested-by: John Keeping <john@metanate.com>

Thanks!

I still need to convince myself beyond reasonable doubt that this is really
what is happening (esp the sched_setscheduler()) part, so the next episode
will probably air after the break :-)
