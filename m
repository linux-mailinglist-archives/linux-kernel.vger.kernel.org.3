Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04FA58F5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiHKB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHKB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:58:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6683BFF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:14 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j184-20020a6255c1000000b0052d459139a3so7142477pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=qdqLxF/5iHPEN10z/S/rIt7c+kdfJ+YWiG6AiuGFtT0=;
        b=XUvzRo5cuRyhdwi5z+BlGovs3PpLrH0ampyMNUUhQ4HvHCw2SLhnZUQ/9B4h50twHF
         LWju86dkYjmp783bJVqwuLPkeeM9KHtykzRrqZPpGB2O4RtgxGkTWS2C0es/VNwZTLUr
         iai7KfROelVTbgXoR5ueVUs2Jp9jj5bZrbbXHuJAl2uL7idjwg9ZcAvjHmzbpHW9cJuG
         fc9uSL0taXXHdWiRQxEMJsGoqoXm4txFhJMwUUbdomuXcwWldMrSpGlF4qtQOXIipQaG
         m26MSs26HYVDC2w40E4ywePW1ky63ZnQMlwZrR4UxwbwmwTn91Y5YeDw4CiE6AB0KSnh
         V7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=qdqLxF/5iHPEN10z/S/rIt7c+kdfJ+YWiG6AiuGFtT0=;
        b=zk8y0CwdYDJeZxJLuUnyxed7Xv/cwkhST4p+vrW++ZLScIQsysc8ydi9o0C8/uDas1
         fb5eNg+to5cqgmth/fOpxe7h1p/ev0d0/lnORTUuFPTro5G5bBpLFH3QBsAJQF7zOoGT
         epBjz2TMC9oO02A6u+14u+9qp7k10ErUuLn6ebTCC/3prVrDVvcGy/X+6CHOK9e0bRsd
         i7P3qrX1JwWqkXdqC8RMs0Gybj0zaglPqNrk9tGYBB09Q4hp0gR4xV4YZOh/YPepsyVg
         3TqvWHlEoDN391Yi24IgtG9X+aETl8mRppaJ109QLHyZvT5dRkUb4JhtZN2FpFnYeDzs
         qGng==
X-Gm-Message-State: ACgBeo1aDNHULIkb3reNpEmvOBNFRoPxAvjGULulfB2snz/dfYrNtZhr
        tVblEcq98pnCjOLh8OzIKwnyFu/0WeKIRq/l0XNwFHkl2QNNOnOyK1NQ8bmlAR/gbD27plOFLSZ
        0XRKbHvzIG/0HQvPiTfGRSMlg5YgRNPSwlTJwrF2qFKJ7TTosEp6nJ9dGYcp4Wmgna5cDCYs=
X-Google-Smtp-Source: AA6agR5HV+Q8Fj44dxChPvWbz00eABJ9nrrnR+PNzRVZQOIR/qPEVj/cxMRue0NB4xLzB1pNiAzJ/Hf8mZgo
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:95a8:0:b0:52d:4185:198d with SMTP id
 a8-20020aa795a8000000b0052d4185198dmr30231778pfk.65.1660183094252; Wed, 10
 Aug 2022 18:58:14 -0700 (PDT)
Date:   Thu, 11 Aug 2022 01:57:56 +0000
Message-Id: <20220811015758.3001641-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC][PATCH 0/2] Softirq -rt Optimizations
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
caused by softirqs for network or storage drivers.

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

* Unfortunately cyclictest has a bug that causes it to always affine
threads to cpus preventing them from being migrated. So you=E2=80=99ll need
the fix proposed here:=20
  https://lore.kernel.org/linux-rt-users/20220728202236.3998964-1-jstultz@g=
oogle.com/

Let me know what you think!

thanks
-john

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
 init/Kconfig              | 11 +++++++
 kernel/sched/cpupri.c     | 13 ++++++++
 kernel/sched/rt.c         | 65 +++++++++++++++++++++++++++++++++------
 kernel/softirq.c          | 34 ++++++++++++++++++--
 6 files changed, 129 insertions(+), 11 deletions(-)

--=20
2.37.1.559.g78731f0fdb-goog



