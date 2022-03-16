Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF54DA8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353388AbiCPCzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiCPCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:55:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3932ED9;
        Tue, 15 Mar 2022 19:53:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso1235009pjb.0;
        Tue, 15 Mar 2022 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRuEiZtGwZMqp5hN4A7t0cPi9l0lVAH9LTZF4YhiTuw=;
        b=GOk1u4Q4xahk+DqeIvZwYQQlKGHRcsmyPgsDWS17jS4qhSE4KS3ir/1sLCddc+twn2
         RlPYZWAjSObrfUZN1VWARy8RSHPqvvO4/atNoC3h6WkjjqAAfzLZqKzzmdC8NRucdVcK
         Mfx2Sm10OZnZaMb9f94mZ7vzHXQg7VvAfak2xMmhiVs3LhMwjSnqXmKzYWheSoq65i3+
         AkWseCES/nF/aoz3e2LpgmcQrTMx9zAkx17x7tzLsgeVv026a929WB7JaeMwBPMCh9/k
         +4twTDH6vSjiOGzciujN8JG1fmPQKO0F3+eQjP8upyrEe6OzIZoFpoXJ+Do2f6xF8ddC
         CMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRuEiZtGwZMqp5hN4A7t0cPi9l0lVAH9LTZF4YhiTuw=;
        b=QQ8QXt3dmATeN/+vDNxESfBdftV/LaNGYR3cYnfN8KS9g7jTkDOOAh3KDukblQuVoh
         1Z7F+6Qwe/wAfAPmStRhWNgkRnhmYTAANgR26WeWH3rAcFEGDtExFm3HbuP+istOeXFg
         bkuCyEwGDLWwt6Iuk/V0QlSAzrRRLuTAYt9tKuyl+u7NlUalCj63xZJ7W/FT95VW0xtE
         Qa1R0A/lSd6LFNZphWyRU0zoOOUpgdg/p3p7eXoTq19y86XXprZyt/r9/znxYzcWU3Ex
         VX88mJcP8CxfMxf5U/I6DIOPNS07AaQZ4lLRvZu6BlzZTJv/cQOQMzpOUjFuzvFztMXk
         3s/Q==
X-Gm-Message-State: AOAM530rSVm2ex2YX8/i3gxdM+T5OdiYLvwm3/KfroykQbEox05SEUqu
        QY/AqUKZGnYxXwfKnquoXkz9r/DaOzg=
X-Google-Smtp-Source: ABdhPJwQwyfpyfEKBfsFUH0iOEaO/RQI2ZQaLMkT3S1ZHdOByg9qVB2C+QgPibGi4GDPg8x1rNP4Yg==
X-Received: by 2002:a17:902:d4cc:b0:153:32a9:2479 with SMTP id o12-20020a170902d4cc00b0015332a92479mr24690809plg.25.1647399229867;
        Tue, 15 Mar 2022 19:53:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:a2d:3f15:4d5c:16dc:7b54:eab4])
        by smtp.gmail.com with ESMTPSA id l5-20020a056a0016c500b004f768db4c94sm537857pfc.212.2022.03.15.19.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:53:49 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v4] docs/scheduler: Introduce the doc of load average
Date:   Wed, 16 Mar 2022 10:53:10 +0800
Message-Id: <20220316025310.13344-1-juitse.huang@gmail.com>
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
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Co-Developed-by: Yiwei Lin <s921975628@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

---

Notes:
    v4:
      - Fix typo and grammar error (Randy Dunlap)
    
    v3:
      - Fix typo (Randy Dunlap)
      - Add further reading that links to Brendan Gregg's blog
    
    v2:
      - Fix typo (Chun-Hung Tseng)

 Documentation/scheduler/index.rst        |  1 +
 Documentation/scheduler/load-average.rst | 82 ++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
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
index 000000000000..bdb5567e1e46
--- /dev/null
+++ b/Documentation/scheduler/load-average.rst
@@ -0,0 +1,82 @@
+============
+Load Average
+============
+
+The load average, provided by common operating systems, indicates the average
+number of system load over a period of time.  In Linux, it shows the average
+number of tasks running and waiting for CPU time. The following expression is
+used in Linux to update the load average::
+
+                / 0                                      , if t = 0
+    load_{t} = |
+                \ load_{t - 1} * exp + active * (1 - exp), otherwise
+
+The expression represents the exponential moving average of the historical
+loading of the system. There are several reasons that Linux kernel chooses
+exponential moving average from other similar average equations such as simple
+moving average or cumulative moving average:
+
+#. The exponential moving average consumes fixed memory space, while the simple
+   moving average has O(n) space complexity where n is the number of timeslices
+   within a given interval.
+#. The exponential moving average not only applies a higher weight to the most
+   recent record but also declines the weight exponentially, which makes the
+   resulting load average reflect the situation of the current system. Neither
+   the simple moving average nor cumulative moving average has this feature.
+
+In the expression, the load_{t} indicates the calculated load average at the
+given time t.
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
+the precision of the fixed-point used in the Linux kernel is 11 bits, a
+fixed-point can be converted to a floating-point by dividing it by 2048, as in
+the expressions shown below::
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
+is called, the function calc_global_load_tick() will also be invoked, which
+makes the active of each CPU core be calculated and be merged globally. Finally,
+the load average will be updated with that global active.
+
+As a user, the load average can be observed via top, htop, or other system
+monitor application, or more directly, by the following command::
+
+    $ cat /proc/loadavg
+
+Further Reading
+---------------
+The explanation and analysis done by Brendan Gregg on `his blog
+<https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html>`_.
-- 
2.25.1

