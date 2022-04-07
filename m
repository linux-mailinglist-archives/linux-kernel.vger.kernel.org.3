Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0262E4F7E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiDGLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiDGLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:48:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51E1B0BEF;
        Thu,  7 Apr 2022 04:46:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q12so1579327pla.9;
        Thu, 07 Apr 2022 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2g0qTv/eeZWtDti+ATHGItbAOEFAIAEnNZj9ujHAJ0=;
        b=hh52FeZEkwuY3mp18JtJBNxWKrHokEWyg6IbVNqp09c/kZh+V1ZWfO5AL/cfZPrtSf
         w0kTyJJbIapKC47lOxdRZFyBqaTx3pHbgXMr/xl4BCMt2FApj3B13qyu/kqAm+3LLmtC
         spn23QsbH+6bO9XpZJqCwtSNTua2LZcjLx+B6uiKzKOjQLN19BEwIn8jlfSkxqbiV4Py
         kL6opsVSX0EugpI+R10o8Mb2xmmxuUhfgTo16mlF2HA0DjtUScaja8vbj99rrr3mNBSk
         JhAZ0XtLYnu2dFzYWualQykLeyah+rFqTxB6DvBoRdj9AvgB/gC9F+KoXATaqoJEgRpD
         aKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2g0qTv/eeZWtDti+ATHGItbAOEFAIAEnNZj9ujHAJ0=;
        b=amcMoCmQZE1DdMw6ei4lQkQ68YSDhlmgeNzkdFLwftO14jPg5FwCKjyq5guWPdyiGY
         DzFjLP4dRa6Ze4kjSup4VbYWx7DSFnEiB+1OKMccoh/qaCPx7QX0ZfH3oeQmDTApZtcA
         PUeP+V+w2FeQ81gXPyY6TkO4c3OQSf2GDNQ7T8Ofk8uZiJklb2azIIz7aH/39JOutRRA
         RGj/wBvOVufJKgTXX51AhNY9zweu5YtXq6md7FCPA8urpI0Xr2ov387J1DEZ06BmFW+M
         UpZIMXS+BTKGDbYf22u49PeSg0b0AxzAZ6SbchAmzP7/Bs3u31K0VhpoAg6ESpZCNPDF
         p1hA==
X-Gm-Message-State: AOAM531WUs1qJxE7Qg8MUmonG/VbXT4nPsQWrIKoGT66tFfo1wisbuiQ
        pr+zQ2PngNMC1PKvZS6M1dM=
X-Google-Smtp-Source: ABdhPJwdQZOsGeUjJOJMpg1cffe6bfcFYBXRXcPARtfFwLh5oiwUslQhR3M65KXNb8ZoAUmp51LJ5A==
X-Received: by 2002:a17:90b:3e8c:b0:1c7:3001:f359 with SMTP id rj12-20020a17090b3e8c00b001c73001f359mr15397926pjb.179.1649331971609;
        Thu, 07 Apr 2022 04:46:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:31cc:1965:3110:2d22])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79497000000b004fdc6ecd157sm24460626pfk.99.2022.04.07.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 04:46:10 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Brendan Gregg <bgregg@netflix.com>,
        Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v5] docs/scheduler: Introduce the docs of load average
Date:   Thu,  7 Apr 2022 19:45:57 +0800
Message-Id: <20220407114557.39417-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load average is one of a common as well as easy observed statistic
provied by Linux, but still not well documented, which makes the numbers
that users observes from the output of top, htop or other system
monitoring application are only numbers. This patch gives a discussion
on how Linux calculates the load average as well as what metrics are
concerned while calculating the load average.

Topics covered in this documentation:
1. The physical meaning of load average
2. How to peek at load average as well as what values could be fetched
   from /proc/loadavg interface.
3. Run through the implementation of the updating process of load
   average.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Co-Developed-by: Yiwei Lin <s921975628@gmail.com>

---

Notes:
    Notes:
        v5:
          - Reorgnize the content (Peter Zijlstra)
    
        v4:
          - Fix typo and grammar error (Randy Dunlap)
    
        v3:
          - Fix typo (Randy Dunlap)
          - Add further reading that links to Brendan Gregg's blog
    
        v2:
          - Fix typo (Chun-Hung Tseng)

 Documentation/scheduler/index.rst        |   1 +
 Documentation/scheduler/load-average.rst | 115 +++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/scheduler/load-average.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 88900aabdbf7..bdc779b4190f 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -17,6 +17,7 @@ Linux Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    load-average
 
     text_files
 
diff --git a/Documentation/scheduler/load-average.rst b/Documentation/scheduler/load-average.rst
new file mode 100644
index 000000000000..a8dfcd66b20e
--- /dev/null
+++ b/Documentation/scheduler/load-average.rst
@@ -0,0 +1,115 @@
+============
+Load Average
+============
+The Load average, provided by common operating systems, indicates the average
+number of system loads over a period of time. In Linux, it shows the average
+number of tasks running and waiting for CPU time.
+
+The Physical Meaning
+--------------------
+A task is considered consuming hardware resources once it is in the TASK_RUNNING
+state as well as the TASK_UNINTERRUPTIBLE state but without being frozen (flag
+PF_FROZEN is not set) and is not marked as an idle task (TASK_NOLOAD). The
+former (TASK_RUNNING) indicates the task is consuming CPU or waiting for CPU,
+and the latter usually means a task is waiting for an I/O operation being
+completed, both of them will be covered in the load average.
+
+Two variables are covered while calculating the load average, one is the number
+of previously mentioned tasks (*active*), the other one is the load average of
+the previous time slot (*load_{t - 1}*). The weighted average of these two
+variables will then be calculated to provide the current load average of the
+system. Applying different weights to these variables controls how *active*
+affects the resulting load average (load_t). A higher weight applied to *active*
+makes *load_t* increase or decrease easily when facing a burst load or when the
+heavy tasks are complete, while a lower weight applied to *active* requires
+tasks to keep using hardware resources for a long time to affect *load_t*.
+
+Peeking at Load Average
+-----------------------
+The load average is provided in three different timescales (by applying
+different weights) and could be observed via system monitoring applications such
+as top or htop, or with the following command::
+
+  $cat /proc/loadavg
+
+The output of the command shown above has the format::
+
+  AVG_1 AVG_5 AVG_15 RUNNING/THREADS PID
+
+The first three fields are load averages:
+
+- AVG_{i}: The system load average over the last i minutes.
+
+Next field contains two numbers describing the task counts:
+
+- RUNNING: # of runable tasks on the system.
+- THREADS: # of not idle tasks on the system.
+
+The last field shows overall PID allocation:
+
+- PID: The last allocated PID.
+
+Implementation
+--------------
+The period of updating cycle is predefined as 5 seconds, which relies on the
+scheduler tick of each CPU. The scheduler tick of CPUs may be disabled with
+NO_HZ configuration (see `NO_HZ: Reducing Scheduling-Clock Ticks
+<https://www.kernel.org/doc/html/latest/timers/no_hz.html>`_ for detail), which
+may cause miss counting the *active* of those CPUs (a CPU may disable its
+scheduler tick even it is not idle) as well as miss the updating cycle of load
+average (the scheduler tick of all  CPUs is disabled), thus, the situation
+should be dealt explicitly.
+
+At the beginning of each iteration, a 10-tick sample window is given to avoid
+synchronization costs between CPUs. While in the sample window, CPUs will upload
+the *active* of their run queue to a global variable `calc_load_tasks`, and the
+job is done in the function `calc_global_load_tick()`. And the *active* of the
+scheduler tick disabled CPUs is collected with the following steps:
+
+#. Before a CPU disables its scheduler tick, the function
+   `calc_load_nohz_start()` is invoked to upload its *active* even if the sample
+   window is not met yet.
+#. The *active* of the scheduler tick disabled CPU is uploaded by other CPU via
+   the function `calc_load_nohz_remote()`.
+#. The uploaded *active* is merged with *active* held by `calc_load_tasks` in
+   the function `calc_global_load()`.
+#. Once the scheduler tick of a CPU is restarted, the missed updating period is
+   synchronized in the function `calc_load_nohz_stop()`.
+
+Two counters, elements of array `calc_load_nohz[2]`, aim to hold the pending
+*active* of the scheduler tick disabled CPUs and will be swapped between cycles.
+Functions `calc_load_read_idx()` and `calc_load_write_idx()` will provide
+correct index into the array. Worth to notice that the index for writing is
+renewed once steps into a new updating cycle, which makes the uploaded *active*
+will be considered in the next cycle, while the index for reading is renewed
+after the sample window.
+
+Once the sample window ends, the function `calc_global_load()` will invoke the
+function `calc_load()` which calculates the load average base on the following
+formula::
+
+  load_{t + 1} = load_{t} * exp + active * (1 - exp)
+
+And if we expend the formula recursively, we will have following expression::
+
+  load_{t + 2} = load_{t + 1} * exp + active * (1 - exp)
+               = (load_{t} * exp + active * (1 - exp)) * exp + active * (1 - exp)
+               = load_{t} * exp^2 + active * (exp - exp^2 + 1 - exp)
+               = load_{t} * exp^2 + active * (1 - exp^2)
+  ...
+  load_{t + n} = load_{t} * exp^n + active * (1 - exp^n)
+
+Thus, if there is any updating cycle missed, the weights taken to get the load
+average should be modified as the weight to the power of n, where n is the
+number of missed cycles. The function `calc_global_nohz()`, invoked at the end
+of the function `calc_global_load()`, takes the responsibility to calculate the
+number of missed cycles, and with the function `calc_load_n()`, the modified
+weights are applied to get the result.
+
+See `kernel/sched/loadavg.c` for detail.
+
+Further Reading
+---------------
+Brendan Gregg has explained the history of load average as well as analysis over
+it in his blog post:
+https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html
-- 
2.25.1

