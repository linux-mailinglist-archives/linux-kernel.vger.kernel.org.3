Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C59C7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiHVTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHVTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:05:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FF13F7C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:05:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a16-20020a17090abe1000b001fad8c29b0bso7298087pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=KkQKvejedeuo1Qp9kShkIqWMvh08M6V/RalDBTDRBcY=;
        b=Ny+6SLA0NQXEGHhDaKlRKIuTH8NDSIRQ/HotaFqw5r+iKHN4BhqHJOsZZToZ8Bu4PM
         2RgS5OzblEo2TI0DZA2h8RnfAJ8gGLSvjI3m46JCc2Fk5Vm6qhOLuiJxBNZPQK2e8Oc5
         YpSLvenUgIRNXucS8RVY8o1kvAWbSB3Xb5d9bhUjzsrnd3iWmnma4++gRNpyJzPWvKyq
         8Mikfy2SGUAmqU7V5dLbU/VxVkXOiWR/ZiumKj925SR1zLMa5aUopTXWfpvGNFDMK+mt
         z8B17hxJczYAx0sO3Rk9mr1MitKyxp2yr4BttIc7jVSQLBZevEC2xZVBIYAS54wwk+l3
         2t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=KkQKvejedeuo1Qp9kShkIqWMvh08M6V/RalDBTDRBcY=;
        b=fsONB0RpJVrW+FnEb/9LRddbbTaDfBsroHj8L89y6FCrRtvJ0SSe2ngZiBIDhkrvvE
         mzS+QP+DzukAFrUQiK/g9HrV+C+2nWBuZBL2QJm6iWJV4tOs8/Xa7dmBKp4ecnWbvNV+
         gggmXRZ1qqBDsTVwN3gxUXGood0yKAsz5rOFQv7MAviZzj8LbcPMwlYawZBSCkAd1hea
         0Ec2w6E8UBCNciWGPfLHqgGRI/PECm9CmnjyfiAph9LxTg5ewIoNEHpP5glgXHXv4Ahr
         ha6iZd+hsa8fCk4orH6foP7KyA2ol5FnLbzYThXVeGTcmeBTHSnqtKQwqpy9FLEUbxQk
         x4aA==
X-Gm-Message-State: ACgBeo3Ypr9SnJVJCg61s5JvNLsDZzNcqpHSeQXLyquZ/FCmaouC/MP1
        6mMHHN/53yFzpWk4iNhAuQj3UR0jKM0/uJ2Hvxr6FinAEHJK1148Q99VuuVqqFCwJg2Vr9eD/bK
        rvTjTVqUyJGosZ1JK4hHznBsOvR2l/ij7bCNVcHUL9/TNKc9PDSRvsQ4wkfJMQ/cyNEMvSi0=
X-Google-Smtp-Source: AA6agR4rP7fUU9Iojr6WmJyqTMEI1+0W5ZHOoXLHxPK/g5t8JxvJKjExwE+mQiYEQnWiUzqBvU7dIglOE9Or
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:b82:b0:52f:518f:fe6c with SMTP id
 g2-20020a056a000b8200b0052f518ffe6cmr22089260pfj.80.1661195105223; Mon, 22
 Aug 2022 12:05:05 -0700 (PDT)
Date:   Mon, 22 Aug 2022 19:04:59 +0000
Message-Id: <20220822190501.2171100-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC][PATCH v2 0/2] Softirq -rt Optimizations
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

This series is a set of patches that optimize scheduler decisions around
realtime tasks and softirqs.  This series is a rebased and reworked set
of changes that have been shipping on Android devices for a number of
years, originally created to resolve audio glitches seen on devices
caused by network or storage driver softirqs.

Long running softirqs cause issues because they aren=E2=80=99t currently ta=
ken
into account when a realtime task is woken up, but they will delay
realtime tasks from running if the realtime tasks are placed on a cpu
currently running a softirq.

This can easily be seen on some devices by running cyclictest* along
with some heavy background filesystems noise:

Without the patches:
T: 0 ( 7596) P:99 I:1000 C:  59980 Min:      7 Act:   13 Avg:   29 Max: 410=
7
T: 1 ( 7597) P:99 I:1500 C:  39990 Min:     14 Act:   26 Avg:   36 Max: 899=
4
T: 2 ( 7598) P:99 I:2000 C:  29995 Min:      7 Act:   22 Avg:   35 Max: 361=
6
T: 3 ( 7599) P:99 I:2500 C:  23915 Min:      7 Act:   25 Avg:   49 Max: 402=
73
T: 4 ( 7600) P:99 I:3000 C:  19995 Min:      8 Act:   22 Avg:   38 Max: 105=
10
T: 5 ( 7601) P:99 I:3500 C:  17135 Min:      7 Act:   26 Avg:   39 Max: 131=
94
T: 6 ( 7602) P:99 I:4000 C:  14990 Min:      7 Act:   26 Avg:   40 Max: 947=
0
T: 7 ( 7603) P:99 I:4500 C:  13318 Min:      8 Act:   29 Avg:   44 Max: 201=
01

Which you can visually see in the image here:
 https://github.com/johnstultz-work/misc/raw/main/images/2022-08-09-softirq=
-rt-big-latency.png

Which is from the perfetto trace captured here:
 https://ui.perfetto.dev/#!/?s=3D33661aec8ec82c2da0a59263f36f7d72b4a2f4e7a9=
9b28b222bd12ad872f

The first patch in the series adds logic to account for when softirqs
are running, and then conditionally based on
CONFIG_RT_SOFTIRQ_OPTIMIZATION allows rt-task placement to be done in a
way that=E2=80=99s aware if a current softirq might be a long-running one, =
to
potentially place the rt task on another free core.

The second patch in the series adds logic in __do_softirq(), also under
CONFIG_RT_SOFTIRQ_OPTIMIZATION, to defer some of the potentially long
running softirqs to ksoftirqd if a -rt task is currently running on the
cpu. This patch also includes a folded down fix that stubbs out
ksoftirqd_running() based on CONFIG_RT_SOFTIRQ_OPTIMIZATION, since in
changing to more frequently defer long running softirqs, the logic using
ksoftirqd_running will end up being too conservative and needlessly
delay shorter-running softirqs.

With these patches we see dramatic improvements in the worst case
latencies in the cyclictest* + filesystem noise test above:

With the patches
T: 0 ( 7527) P:99 I:1000 C:  59998 Min:      6 Act:   29 Avg:   35 Max: 173=
4
T: 1 ( 7528) P:99 I:1500 C:  40000 Min:      7 Act:   39 Avg:   35 Max: 118=
1
T: 2 ( 7529) P:99 I:2000 C:  30000 Min:      7 Act:   25 Avg:   25 Max: 444
T: 3 ( 7530) P:99 I:2500 C:  24000 Min:      7 Act:   34 Avg:   36 Max: 172=
9
T: 4 ( 7531) P:99 I:3000 C:  20000 Min:      7 Act:   36 Avg:   25 Max: 406
T: 5 ( 7532) P:99 I:3500 C:  17143 Min:      7 Act:   38 Avg:   34 Max: 126=
4
T: 6 ( 7533) P:99 I:4000 C:  15000 Min:      7 Act:   27 Avg:   33 Max: 235=
1
T: 7 ( 7534) P:99 I:4500 C:  13334 Min:      7 Act:   41 Avg:   29 Max: 228=
5

Since these patches have been carried along for years, and have at times
badly collided with upstream, I wanted to submit them for some initial
review, discussion and feedback so we could hopefully eventually find a
reasonable solution that might land upstream.

* Unfortunately cyclictest had a bug that causes it to always affine
threads to cpus preventing them from being migrated. So you=E2=80=99ll need
to update to the latest version (which includes a fix) to reproduce.

Let me know what you think!

thanks
-john

Changes in v2:
* Reformatted Kconfig entry to match coding style
  (Reported-by: Randy Dunlap <rdunlap@infradead.org>)
* Made rt_task_fits_capacity_and_may_preempt static to avoid
  warnings (Reported-by: kernel test robot <lkp@intel.com>)
* Rework to use preempt_count and drop kconfig dependency on ARM64

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com


Connor O'Brien (1):
  sched: Avoid placing RT threads on cores handling long softirqs

Pavankumar Kondeti (1):
  softirq: defer softirq processing to ksoftirqd if CPU is busy with RT

 include/linux/interrupt.h |  7 +++++
 include/linux/sched.h     | 10 ++++++
 init/Kconfig              | 10 ++++++
 kernel/sched/cpupri.c     | 13 ++++++++
 kernel/sched/rt.c         | 65 +++++++++++++++++++++++++++++++++------
 kernel/softirq.c          | 34 ++++++++++++++++++--
 6 files changed, 128 insertions(+), 11 deletions(-)

--=20
2.37.1.595.g718a3a8f04-goog

