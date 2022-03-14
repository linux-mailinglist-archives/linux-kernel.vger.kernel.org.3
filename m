Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D554D7DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiCNIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCNIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:49:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34BB1400F;
        Mon, 14 Mar 2022 01:48:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so10475014pjb.3;
        Mon, 14 Mar 2022 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbMnsuV/WjCVgNHAAhwwQM/BhzDcEyxYmkQ9AWEx0BI=;
        b=bxThCbIpNeDgqjkFCkbfhRkEALDTWe1csTnrolRMgdog4jnm1bH22CRZna/bQgdFKp
         1sW1dMPVhsdRfj0VpQqquI3cp7HB6Y1b/3TpsLYBeMYWbTkUjxSgMEFRdl5BOy7bvVub
         TCtRcbFNERpH4UdbXnj4EkSdge2Rcd+oDdPT6odeNXvies7/Qjs7EioxKajx294l3bIC
         DkTIHXgGWrYvdfe83M1AqfZR6Z1rZygMxFUTRBG/su6fFwiDz42y+oZ5zPN+vZ3A/7X6
         /TTmPVV5mxwz2j+K8ajtR0Tc25GRqSyXIWNpRaavtzvWD+HVT1cUksniqqbEcOlD2XpS
         6eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbMnsuV/WjCVgNHAAhwwQM/BhzDcEyxYmkQ9AWEx0BI=;
        b=pl8m3bNcJbFbANxbs9hvpX56RgJb/B80payT7h8XOY+Wh4AjDnhTGDGptvDzOMc0IR
         2o+PXegqYOOiPo0zQDDe9TFu1vaRejfXCftk7tTpP0VZahGuiLKMxs/FqyZ0pvrk24LM
         QAWymR0Mwi2LBmS/ajiIlDVzqPNG6zh3gPuy7Sym78gIuDxpdvcHskm15Wvy9418qnif
         WhdDM1S0+U4KRuitkNSv/tzfJXIIylogHbcrg4w9KePjvrfdTQnIpmoQUHtKPLZBTIEI
         OgbGIF4XCh0VrugYrHsF26+rwz4B7HccRGw3xoDRHPbRSSaC4YJX+yeib81soH9wnsiZ
         FznQ==
X-Gm-Message-State: AOAM533ceT9xMM6bKm/aojDiU7lCRBFG7l8Vnz7+FbeliPewBe8bw4Er
        xY8uXWScQf6dLXuxZ66mr24=
X-Google-Smtp-Source: ABdhPJyr2nILvPxagHGAFHs0MUGvuIVd6mr/DBlvo6qTVtXtTLACOTTBI/7QXIAYJI7qpOYF+7clWQ==
X-Received: by 2002:a17:90a:6508:b0:1be:d59c:1f10 with SMTP id i8-20020a17090a650800b001bed59c1f10mr23905491pjj.229.1647247725315;
        Mon, 14 Mar 2022 01:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:503c:a5f3:4f9d:fb88])
        by smtp.gmail.com with ESMTPSA id y13-20020a056a00180d00b004f733bc57e5sm18798479pfa.192.2022.03.14.01.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:48:44 -0700 (PDT)
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
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2] docs/scheduler: Introduce the doc of load average
Date:   Mon, 14 Mar 2022 16:47:59 +0800
Message-Id: <20220314084759.9849-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

The discussion flow is divided into several parts:
1. The expression used to get the load average.
2. Why Linux choose such average method from the other.
2. The meaning of each term in the expression.
3. The metrics, that is, the type of tasks that will be covered in the
   calculation.
4. A brief explanation over the fixed-point nubmer since the weights
   defined in the Linux kernel are based on it.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Co-Developed-by: Yiwei Lin <s921975628@gmail.com>

---
v1 -> v2:
    fix typo: '$cat /proc/laodavg' -> '$cat /proc/loadavg'

 Documentation/scheduler/index.rst        |  1 +
 Documentation/scheduler/load-average.rst | 77 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
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
index 000000000000..589320ee1cd7
--- /dev/null
+++ b/Documentation/scheduler/load-average.rst
@@ -0,0 +1,77 @@
+============
+Load Average
+============
+
+Load average is a basic statistic provided by almost all operating systems that
+aims to report the usage of system hardware resources. In Linux kernel, the
+load average is calculated via the following expression::
+
+                / 0                                      , if t = 0
+    load_{t} = |
+                \ laod_{t - 1} * exp + active * (1 - exp), otherwise
+
+The expression represents the exponential moving average of the historical
+loading of the system. There are several reasons that Linux kernel chooses
+exponential moving average from other similar average equations such as simple
+moving average or cumulative moving average:
+
+#. The exponential moving average consumes fixed memory space, while the simple
+   moving average has O(n) space complexity where n is the number of timeslice
+   within a given interval.
+#. The exponential moving average not only applies a higher weight to the most
+   recent record but also declines the weight exponentially, which makes the
+   resulting load average reflect the situation of the current system. Neither
+   the simple moving average nor cumulative moving average has this feature.
+
+In the expression, the load_{t} in the expression indicates the calculated load
+average at the given time t.
+The active is the most recent recorded system load. In Linux, the system load
+means the number of tasks in the state of TASK_RUNNING or TASK_UNINTERRUPTIBLE
+of the entire system. Tasks with TASK_UNINTERRUPTIBLE state are usually waiting
+for disk I/O or holding an uninterruptible lock, which is considered as a part
+of system resource, thus, Linux kernel covers them while calculating the load
+average.
+The exp means the weight applied to the previous report of load average, while
+(1 - exp) is the weight applied to the most recently recorded system load.
+There are three different weights defined in the Linux kernel, in
+include/linux/sched/loadavg.h, to perform statistics in various timescales::
+
+    // include/linux/sched/loadavg.h
+    ...
+    #define EXP_1    1884    /* 1/exp(5sec/1min) as fixed-point */
+    #define EXP_5    2014    /* 1/exp(5sec/5min) */
+    #define EXP_15   2037    /* 1/exp(5sec/15min) */
+    ...
+
+According to the expression shown on the top of this page, the weight (exp)
+controls how much of the last load load_{t - 1} will take place in the
+calculation of current load, while (1 - exp) is the weight applied to the most
+recent record of system load active.
+
+Due to the security issue, the weights are defined as fixed-point numbers based
+on the unsigned integer rather than floating-pointing numbers. The introduction
+of the fixed-point number keeps the FPU away from the calculation process. Since
+the precession of the fixed-point used in the Linux kernel is 11 bits, a
+fixed-point can be converted to a floating-point by dividing it by 2048, as the
+expression shown below::
+
+    EXP_1  = 1884 / 2048 = 0.919922
+    EXP_5  = 2014 / 2048 = 0.983398
+    EXP_15 = 2037 / 2048 = 0.994629
+
+Which indicates the weights applied to active are::
+
+    (1 - EXP_1)  = (1 - 0.919922) = 0.080078
+    (1 - EXP_5)  = (1 - 0.983398) = 0.016602
+    (1 - EXP_15) = (1 - 0.994629) = 0.005371
+
+The load average will be updated every 5 seconds. Each time the scheduler_tick()
+be called, the function calc_global_load_tick() will also be invoked, which
+makes the active of each CPU core be calculated and be merged globally, finally,
+the load average will be updated with that global active.
+
+As a user, the load average can be observed via top, htop, or other system
+monitor application, or more directly, by the following command::
+
+    $ cat /proc/loadavg
+
-- 
2.25.1

