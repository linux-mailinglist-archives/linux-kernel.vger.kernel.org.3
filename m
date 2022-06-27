Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C155CA41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiF0IH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiF0IH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:07:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7D5F6F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:07:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 450CD1F982;
        Mon, 27 Jun 2022 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656317243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISmUJypDEnwyNLjOZHHl3YxuwgS1HsL3sHzfpjHOgNc=;
        b=U5vF9ggw+RqFSxI011hhAyFzIpWwoE1SwSFRSCwATM9d/e93uKrcJTAodL9k1q7GLqQ4xl
        WKcVqYD0OsNk1REYQLhzy3/ItAaRkdJIWnCrd9JAIV5vsQvOuxFJGhlFsebeTZkHa1dxy/
        pRUtsRBfWHnzVY3/qLEyeu6nAfIJwiM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB2F22C141;
        Mon, 27 Jun 2022 08:07:22 +0000 (UTC)
Date:   Mon, 27 Jun 2022 10:07:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YraWWl+Go17uPOgR@mtj.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 25-06-22 14:00:10, Tejun Heo wrote:
[...]
> tl;dr is that the worker creation code expects a newly created worker
> kthread to sit tight until the creator finishes setting up stuff and
> sends the initial wakeup. However, something, which wasn't identified
> in the report (Petr, it'd be great if you can find out who did the
> wakeup), wakes up the new kthread before the creation path is done
> with init which causes the new kthread to try to deref a NULL pointer.

One thing that hasn't been really mentioned explicitly but it might be
really important. 5.3.18-2-rt is the RT patchset backported to 5.3
based SLES kernel. We do not know whether the upstream RT patchset is
affected the same way and due to nature of the customer we cannot really
have this tested on that kernel.

I have tried to dig that out from the crash dump but no luck
unfortunately. I was able to find the kthread pointer on few stacks:
crash> search -t ffff9ca77e9a8000
PID: 2      TASK: ffff9ca700381d80  CPU: 0   COMMAND: "kthreadd"
ffffb0f68001fd78: ffff9ca77e9a8000
ffffb0f68001fe38: ffff9ca77e9a8000

PID: 842    TASK: ffff9ca75e6349c0  CPU: 0   COMMAND: "sysmon"
ffffb0f6808e7c50: ffff9ca77e9a8000
ffffb0f6808e7da8: ffff9ca77e9a8000

PID: 2035   TASK: ffff9ca71e252c40  CPU: 1   COMMAND: "vReqJob"
ffffb0f68300fba8: ffff9ca77e9a8000
ffffb0f68300fbf0: ffff9ca77e9a8000

PID: 16127  TASK: ffff9ca77e9abb00  CPU: 0   COMMAND: "kworker/0:0H"
ffffb0f688067dd0: ffff9ca77e9a8000

PID: 16213  TASK: ffff9ca77e9a8000  CPU: 1   COMMAND: "kworker/0:2H"
ffffb0f68822fba0: ffff9ca77e9a8000
ffffb0f68822fca0: ffff9ca77e9a8000
ffffb0f68822fd70: ffff9ca77e9a8000
ffffb0f68822fe38: ffff9ca77e9a8000
ffffb0f68822fef8: ffff9ca77e9a8000

kthreadadd is not all that interesting because that one has created the
thread. sysmon is 
crash> bt ffff9ca75e6349c0
PID: 842    TASK: ffff9ca75e6349c0  CPU: 0   COMMAND: "sysmon"
 #0 [ffffb0f6808e7be8] __schedule at ffffffffaa94bef1
 #1 [ffffb0f6808e7c78] preempt_schedule_common at ffffffffaa94c5d1
 #2 [ffffb0f6808e7c80] ___preempt_schedule at ffffffffaa201bb6
 #3 [ffffb0f6808e7cd8] rt_mutex_postunlock at ffffffffaa309f6b
 #4 [ffffb0f6808e7ce8] rt_mutex_futex_unlock at ffffffffaa94ea7c
 #5 [ffffb0f6808e7d30] rt_spin_unlock at ffffffffaa950ace
 #6 [ffffb0f6808e7d38] proc_pid_status at ffffffffaa4c9ff4
 #7 [ffffb0f6808e7dd8] proc_single_show at ffffffffaa4c3801
 #8 [ffffb0f6808e7e10] seq_read at ffffffffaa47c1b8
 #9 [ffffb0f6808e7e70] vfs_read at ffffffffaa455fd9
#10 [ffffb0f6808e7ea0] ksys_read at ffffffffaa456364

so collecting /pro/status data and releasing the sighand lock.

crash> bt ffff9ca71e252c40
PID: 2035   TASK: ffff9ca71e252c40  CPU: 1   COMMAND: "vReqJob"
 #0 [ffffb0f68300fbb0] __schedule at ffffffffaa94bef1
 #1 [ffffb0f68300fc40] schedule at ffffffffaa94c4e6
 #2 [ffffb0f68300fc50] futex_wait_queue_me at ffffffffaa33e2c0
 #3 [ffffb0f68300fc88] futex_wait at ffffffffaa33f199
 #4 [ffffb0f68300fd98] do_futex at ffffffffaa341062
 #5 [ffffb0f68300fe70] __x64_sys_futex at ffffffffaa341a7e
 #6 [ffffb0f68300fee0] do_syscall_64 at ffffffffaa2025f0

is scheduled into the kthread which is expected because the newly
created kernel thread should be running kthread() where it sleeps before
calling the thread function.

kworker/0:2H is our tkrehad worker.

crash> bt ffff9ca77e9abb00
 #5 [ffffb0f688067c90] delay_tsc at ffffffffaa9479fc
 #6 [ffffb0f688067c90] wait_for_xmitr at ffffffffaa6c1e45
 #7 [ffffb0f688067cb0] serial8250_console_putchar at ffffffffaa6c1ee6
 #8 [ffffb0f688067cc8] uart_console_write at ffffffffaa6bb095
 #9 [ffffb0f688067cf0] serial8250_console_write at ffffffffaa6c5962
#10 [ffffb0f688067d70] console_unlock at ffffffffaa30d795
#11 [ffffb0f688067db0] vprintk_emit at ffffffffaa30fc11
#12 [ffffb0f688067e00] printk at ffffffffaa3103c0
#13 [ffffb0f688067e68] __kthread_bind_mask at ffffffffaa2d74df
#14 [ffffb0f688067e90] create_worker at ffffffffaa2cfc13
#15 [ffffb0f688067ed8] worker_thread at ffffffffaa2d1cbe
#16 [ffffb0f688067f10] kthread at ffffffffaa2d6da2

is the delayed thread which is creating the worker and currently stuck
somewhere in the printk (console) code.

So if somebody has woken up our thread from inside kthread() then it
doesn't have that pointer on the stack and I couldn't it find elsewhere
either. Maybe somebody has an idea where to look at.

Btw. I still haven't caught up with the rest of the email thread and
today will be quite busy for me. Anyway, if somebody has ideas about a
further post mortem debugging then I am more than happy to help out.
-- 
Michal Hocko
SUSE Labs
