Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB5492528
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiARLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:46:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6563 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbiARLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642506407; x=1674042407;
  h=from:to:cc:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=de5ZGjLvBkaSdPvbLoUtLwwssWNwE8g5pE6J8wp83mM=;
  b=y8ACTFFPzDSIQfCOIO+WeQeSwFR5xy4+AeB7FBkO0rZ1NUoUKdQSUZnr
   C1PunZ2D9R74adFjy+kEDGnPMilpoPCLmPt+U60qX64PQasho7JLee57P
   78RE0dsjUmuHE4/0KkiclB+jPYQSM3PCge4c0gezpnzyHVGckwr07DpO7
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Jan 2022 03:46:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:46:45 -0800
Received: from [10.216.2.106] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 18 Jan
 2022 03:46:44 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     lkml <linux-kernel@vger.kernel.org>
CC:     <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
Date:   Tue, 18 Jan 2022 17:16:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

We are facing one issue in hotplug test where cpuhp/2 gets stuck in 
below path [1] in
synchronize_rcu_expedited at state CPUHP_AP_ONLINE_DYN and it is not 
able to proceed.
We see wait_rcu_exp_gp() is queued to cpu2  and it looks like it did not 
get chance to
run as we see it as in pending state at cpu2 [2].

So, when exactly cpu2 gets available for scheduling in hotplug path, is 
it after
CPUHP_AP_ACTIVE?

It looks to be dead lock here. Can it be fixed by making 
wait_rcu_exp_gp() queued on another wq ?
or is it a wrong usage of synchronise_rcu in hotplug path?

[1]

=======================================================
Process: cpuhp/2, [affinity: 0x4] cpu: 2 pid: 24 start: 0xffffff87803e4a00
=====================================================
     Task name: cpuhp/2 [affinity: 0x4] pid: 24 cpu: 2 prio: 120 start: 
ffffff87803e4a00
     state: 0x2[D] exit_state: 0x0 stack base: 0xffffffc010160000
     Last_enqueued_ts:      59.022215498 Last_sleep_ts: 59.022922946
     Stack:
     [<ffffffe9f4074354>] __switch_to+0x248
     [<ffffffe9f5c02474>] __schedule+0x5b0
     [<ffffffe9f5c02b28>] schedule+0x80
     [<ffffffe9f42321a4>] synchronize_rcu_expedited+0x1c4
     [<ffffffe9f423b294>] synchronize_rcu+0x4c
     [<ffffffe9f6d04ab0>] waltgov_stop[sched_walt]+0x78
     [<ffffffe9f512fa28>] cpufreq_add_policy_cpu+0xc0
     [<ffffffe9f512e48c>] cpufreq_online[jt]+0x10f4
     [<ffffffe9f51323b8>] cpuhp_cpufreq_online+0x14
     [<ffffffe9f4128d3c>] cpuhp_invoke_callback+0x2f8
     [<ffffffe9f412c30c>] cpuhp_thread_fun+0x130
     [<ffffffe9f4187a58>] smpboot_thread_fn+0x180
     [<ffffffe9f417d98c>] kthread+0x150
     [<ffffffe9f4013918>] ret_to_user[jt]+0x0


[2]

CPU 2
pool 0
IDLE Workqueue worker: kworker/2:3 current_work: (None)
IDLE Workqueue worker: kworker/2:2 current_work: (None)
IDLE Workqueue worker: kworker/2:1 current_work: (None)
IDLE Workqueue worker: kworker/2:0 current_work: (None)
Pending entry: wait_rcu_exp_gp[jt]
Pending entry: lru_add_drain_per_cpu[jt]
Pending entry: wq_barrier_func[jt]

Thanks,
Mukesh

