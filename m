Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5B52D311
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiESMx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiESMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:53:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF85EBD2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:53:21 -0700 (PDT)
X-UUID: 2f90352f96384583ab3d051eb54a4772-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:6c3301bf-9788-4165-994c-eaa240be668a,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:6c3301bf-9788-4165-994c-eaa240be668a,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:6384df79-5ef6-470b-96c9-bdb8ced32786,C
        OID:2de5543946eb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 2f90352f96384583ab3d051eb54a4772-20220519
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1938921453; Thu, 19 May 2022 20:53:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 20:53:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 20:53:15 +0800
Message-ID: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
Subject: [Bug] Race condition between CPU hotplug off flow and
 __sched_setscheduler()
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, <tglx@linutronix.de>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Vincent Donnefort" <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>
Date:   Thu, 19 May 2022 20:53:15 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all


There is a race condition between CPU hotplug off flow and
__sched_setscheduler(), which will cause hang-up in CPU hotplug off
flow.

Syndrome:
During hotplug off flow in CPU_A, it blocks on
CPUHP_AP_SCHED_WAIT_EMPTY state when enters rcuwait_wait_event().
In that moment, CPU_A stays in idle and cannot wake up stopper
thread(cpuhp/A) to continue CPU_A hotplug off flow.

Root cause:
Balance_push() callback has been stolen by CPU_B in executing
__sched_setscheduler() func., which should be executed in idle task of
CPU_A to wake up stopper thread (cpuhp/A) through calling
rcuwait_wake_up(&rq->hotplug_wait).

Racing flow as below:
CPU_A is going to hotplug off and set rq->balance_callback =
&balance_push_callback, then CPU_A should use balance_push() to push
the task out and release rq_lock.
But if CPU_B do __sched_setscheduler() before CPU_A switch to
swapper/A, CPU_B use splice_balance_callbacks() to steal rq-
>balance_callback and set the CPU_A rq->balance_callback = NULL.
Due to rq->balance_callback is NULL,
so swapper/A could not do balance_push() at CPU_A,
Due to rq(rq_A) != this_rq(rq_B),
so swapper/A could not do rcuwait_wake_up() at CPU_B.


Racing flow:
-----------------------------------------------------------------------
CPU_A (Hotplug down)                          
-----------------------------------------------------------------------
State: CPUHP_AP_ACTIVE
sched_cpu_deactivate()
-> balance_push_set(cpu, true)
   -> rq_A->balance_callback = &balance_push_callback
      => CPU_A set rq_A balance_callback here.
                                
State: CPUHP_AP_SCHED_WAIT_EMPTY
sched_cpu_wait_empty()
-> balance_hotplug_wait()
   -> rcuwait_wait_event(&rq->hotplug_wait)
      => CPU_A do while loop to push task out from CPU_A,
         until swapper/A wake up cpuhp/A.
      -> schedule()
         -> rq_lock(rq, &rf)
            -> context_switch() 
              -> finish_lock_switch()
                 -> __balance_callbacks(rq_A)
                    -> do_balance_callbacks(rq,
                                      splice_balance_callbacks(rq))
                       -> balance_push(rq_A)
                 -> raw_spin_rq_unlock_irq(rq_A)
                    => CPU_A release rq_A lock.

CPU_A release rq_A lock, CPU_B can get rq_A lock.

-----------------------------------------------------------------------
CPU_B (do __sched_setscheduler(), set rq_A->balance_callback = NULL)
-----------------------------------------------------------------------
__sched_setscheduler(p) => task_rq(p) is rq_A
-> task_rq_lock(rq_A)
  -> splice_balance_callbacks(rq_A)
     -> if (head)
           rq_A->balance_callback = NULL
           => CPU_B steal rq_A->balance_callback.
     -> task_rq_unlock(rq_A)


CPU_B release rq_A lock, CPU_A can get rq_A lock and switch to
swapper/A.

-----------------------------------------------------------------------
CPU_A (Hotplug down)                           
-----------------------------------------------------------------------
switch to swapper/A:
schedule()
-> rq_lock(rq, &rf)
   -> context_switch()                                     
      -> finish_lock_switch()
         -> __balance_callbacks(rq_A)
            -> do_balance_callbacks(rq, NULL) 
               => Because rq_A->balance_callback = NULL,
                  swapper/A could not do rcuwait_wake_up().
         -> raw_spin_rq_unlock_irq(rq_A)   

-----------------------------------------------------------------------
CPU_B (do __sched_setscheduler(), set rq_A->balance_callback = NULL) 
-----------------------------------------------------------------------
balance_callbacks(rq_A, head)
-> balance_push(rq_A)
   -> rq->balance_callback = &balance_push_callback;
     -> if (rq != this_rq())
           return;
           => Because rq = rq_A, this_rq = rq_B,
              swapper/A could not do rcuwait_wake_up().

-----------------------------------------------------------------------
CPU_A (Hotplug down)                           
-----------------------------------------------------------------------
rcuwait_wait_event(&rq->hotplug_wait)
=> swapper/A could not do rcuwait_wake_up(),
   it cannot wake up stopper thread(cpuhp/A),
   so system could not exit the while loop at rcuwait_wait_event.




Do you have any suggestion or solution for this issue?
Thank you.



Best regards,
Jing-Ting Wu

