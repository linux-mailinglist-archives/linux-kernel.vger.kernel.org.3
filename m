Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0652BCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiEROLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiEROLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57705344F6;
        Wed, 18 May 2022 07:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3A62CE2135;
        Wed, 18 May 2022 14:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C342C385AA;
        Wed, 18 May 2022 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652883068;
        bh=rhhgaJOX3Nwe+osh/bDkMx6UVKw+p2ONZnKPvdg6Q4w=;
        h=Date:Cc:From:Subject:To:From;
        b=Y729/LYg+EjaFHgBQVlEf18ZibiPWFS/+SYr0fKN+EwX7+BF9PUMFJUY+JRQytwHm
         smh+767A/84cHFoyYKIl8h/sHymoAqnwO/hVR34sPvHuKugUantiRt+UeEVbIcey/6
         Q2Qb2UvhDvE1Qgrxkz1g3SFz8KBRHGXQ7MJaOxB8+5wWN8HpyG1MRWSCMyBepc0G44
         JM4MjIaVJqLsQV0Zn3tzTcpge/ylNTUvkK3f5Sgo8kzsKQw7mg8iFF3YcPYZ1pppL1
         qIZLs9GMTlVUWCxTU3l4TES6vpv88pL6Q3rWOqR2hL6PTirltAe40uafTBYoR7CSM5
         Dy5M0nB30zc9A==
Message-ID: <5564e168-c443-687b-77db-011084078a8c@kernel.org>
Date:   Wed, 18 May 2022 16:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Daniel Wagner <wagi@monom.org>,
        Ben Segall <bsegall@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        patrick.bellasi@matbug.net, Paul Turner <pjt@google.com>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Waiman Long <longman@redhat.com>,
        Scott Wood <swood@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [ANNOUNCE] CFP: Real-time and Scheduling Microconference - Linux
 Plumbers Conference 2022
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real-time and scheduling micro-conference joins these two intrinsically 
connected communities to discuss the next steps together.

Over the past decade, many parts of PREEMPT_RT have been included in the 
official Linux codebase. Examples include real-time mutexes, high-resolution 
timers, lockdep, ftrace, RCU_PREEMPT, threaded interrupt handlers and more. The 
number of patches that need integration has been significantly reduced, and the 
rest is mature enough to make their way into mainline Linux.

The scheduler is the core of Linux performance. With different topologies and 
workloads, it is not an easy task to give the user the best experience possible, 
from low latency to high throughput, and from small power-constrained devices to 
HPC.

In the last years, the real-time and scheduling microconferences helped in the 
The Real-time Linux Analysis tool merge [1], progress on the full mainline merge 
of the PREEMPT_RT,  core scheduling merge and to promote the progress in the 
latency nice scheduling feature [3].

If you are interested in participating in this microconference and have topics 
to propose, please use the LPC CfP process [4], and select "Real-time and 
Scheduling" for the "Track".

A non exhaustive list of potential topics is:
  - How to scale PREEMPT_RT for very-large systems
  - Improve overall system partitioning for real-time HPC workloads
  - Latency nice scheduling feature
  - Better support/heuristics for new processors
  - New tools for PREEMPT_RT analysis.
  - How do we teach the rest of the kernel developers how not to break 
    PREEMPT_RT?
  - The usage of PREEMPT_RT on safety-critical systems: what do we need to do?
  - The merge's status, and how can we resolve the last issues that block the 
    merge.
  - What’s next?

The submission deadline is June 30.

Come and join us in the discussion, we hope to see you there!

[1] https://www.kernel.org/doc/html/latest/tools/rtla/rtla.html
[2] https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/core-scheduling.html
[3] https://lore.kernel.org/lkml/20220311161406.23497-1-vincent.guittot@linaro.org/
[4] https://lpc.events/event/16/abstracts/

In case of doubts, feel contact the MC Leads:

Daniel Bristot de Oliveira <bristot@kernel.org>
Steven Rostedt <rostedt@goodmis.org>
Vincent Guittot <vincent.guittot@linaro.org>
Juri Lelli <juri.lelli@redhat.com>

Please, forward this email to anyone who might be interested on it
(and sorry if I forgot to add someone in Cc:, it is a long list).

Thanks
-- Daniel
