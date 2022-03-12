Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A684D6E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiCLMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:04:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F66263
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Yn//COARxLJ1cbFi3b5HzA/U/7TH3RSrb4vYtg1HGks=; b=Ffx9A2c6h2D4jhunwrHGZIvMkY
        eBkP+g3aIuDSJnK7GRh8QwEeeih/dv/NRH7D6tEaWbjtJLVMkXb0N2327F1ferMK8qHAtfm5NB3Ef
        Y2f1zX6kxPeFPb3ON+78AEp6jh/TJ1uEefl4us7tLfoydRPS1DVlE79FWEyY8CdIYzROVR9TDH4h3
        pmMGpc5ORTk/6mQMLPFFiVVdlj0cw7qAJNUVouGofJasP/fxy+oJF58+WevuEeWxuipxQLumtC0t7
        7dhJvfN83f51z4LDVayEGMUwv0SW8DGehOKHUfw2zpxItXsiNp0zbUrizvoz/uOz+aoFCdEWArUla
        mZAOtc5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT0Sj-002OVE-Hq; Sat, 12 Mar 2022 12:03:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EE7798791D; Sat, 12 Mar 2022 13:03:09 +0100 (CET)
Date:   Sat, 12 Mar 2022 13:03:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     chenying <chenying.kernel@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        bsegall@google.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
Subject: Re: Subject: [PATCH] sched/fair: prioritize normal task over
 sched_idle task with vruntime offset
Message-ID: <20220312120309.GB6235@worktop.programming.kicks-ass.net>
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 03:58:47PM +0800, chenying wrote:
> We add a time offset to the se->vruntime when the idle sched_entity
> is enqueued, so that the idle entity will always be on the right of
> the non-idle in the runqueue. This can allow non-idle tasks to be
> selected and run before the idle.
> 
> A use-case is that sched_idle for background tasks and non-idle
> for foreground. The foreground tasks are latency sensitive and do
> not want to be disturbed by the background. It is well known that
> the idle tasks can be preempted by the non-idle tasks when waking up,
> but will not distinguish between idle and non-idle when pick the next
> entity. This may cause background tasks to disturb the foreground.
> 
> Test results as below:
> 
> ~$ ./loop.sh &
> [1] 764
> ~$ chrt -i 0 ./loop.sh &
> [2] 765
> ~$ taskset -p 04 764
> ~$ taskset -p 04 765
> 
> ~$ top -p 764 -p 765
> top - 13:10:01 up 1 min,  2 users,  load average: 1.30, 0.38, 0.13
> Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
> %Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.4 id,  0.0 wa,  0.0 hi, 0.0 si,  0.0
> st
> KiB Mem : 16393492 total, 16142256 free,   111028 used,   140208 buff/cache
> KiB Swap:   385836 total,   385836 free,        0 used. 16037992 avail Mem
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
>   764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 1:05.12 loop.sh
>   765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh
> 
> The non-idle process (764) can run at 100% and without being disturbed by
> the idle process (765).

Did you just do a very complicated true idle time scheduler, with all
the problems that brings?
