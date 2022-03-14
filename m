Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFA4D7A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiCNGEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiCNGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:04:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D840E0A1;
        Sun, 13 Mar 2022 23:03:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z4so12827932pgh.12;
        Sun, 13 Mar 2022 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8uW8MVx4cu2bnNodD5dVLV/dP3D3LkkTrGrX8U0zMQ=;
        b=OrwJZ+GOMqgHHcecyi4J1EYX4ljlpHVETDUhA8MuJPldjdHnUNAW44lir2MZ7tGbtC
         IbV6+vxEtX0KNuSPcQYtNY2WkOkzJVEXBTrTJr2wRDF1ywRrOaRfIA1U+fknjF0Klf+P
         6BRzei7PXqpB9YJ0Bn4qLiyisNHANyEyDKU8f0vSXZLd70nuxRnbNdnZaPmF34JkXMhK
         JCQzBQN7qog72HiFA/Zmu90WG0D3lRRb+2CR6AAq87kzbmqPLvGaxaduinFfAzwieGi1
         P9SN8IliT/PHhmCUCEpFnRJ08XdR9z5EDaaUAFKZeZyDoKtVqnPo5CySF4c+1JyvmO6T
         Jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8uW8MVx4cu2bnNodD5dVLV/dP3D3LkkTrGrX8U0zMQ=;
        b=PSwWbLaQvHbp7Qf/iRbHNXOdqPqvxDxrm4HvOAnuud1Xn+rnLOWtADoeL+0zpLHJJf
         u9DSAFVSpxQ8GJVtibigdtsMomb2799+giOV7DDzb7E4s2+N93tWa5bC+LN0jyGbc+Q/
         LoUlz2pyewxN4i4gs611pABlzxz/od6weklBXpmjhXoPixDh0ed+GzIOZLb7EfnfJSe9
         OzZvoDWKN9kk8BzBHdZwT6DBCog1M9Jt0onSjQrVg2LKab83jswTHhu0BGoZ5ynPEDz4
         0II+zRkjraHJUsbWMa0V2WuEUbs9xMoULWZbMBwCTcDEUKKrKKhvQKCJUZ9NjZ9PerZ6
         Xj0w==
X-Gm-Message-State: AOAM5325hvgWJxz8bAapXwm6KXApBEDkkFXuk/8G77+furgmU5copGsQ
        hlWAZ03zp8/oFNBI7rodOAaD03bs0AsLXQ==
X-Google-Smtp-Source: ABdhPJz4lT0U5N4b+V4udDfBb/98jw9AIgU+6CZ6/RiKXA9NE0clDlKqPpAYh6G+rwb5qsHBJprCFg==
X-Received: by 2002:a05:6a00:1799:b0:4f7:37cd:d03e with SMTP id s25-20020a056a00179900b004f737cdd03emr21921787pfg.10.1647237806621;
        Sun, 13 Mar 2022 23:03:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:e222:e75e:e6:3e5e])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f7b425211bsm5341905pfj.36.2022.03.13.23.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:03:26 -0700 (PDT)
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
Subject: [PATCH] docs/scheduler: Introduce the doc of load average
Date:   Mon, 14 Mar 2022 14:03:04 +0800
Message-Id: <20220314060304.95400-1-juitse.huang@gmail.com>
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

Load average is one of the common as well as easily observed statistics provided
by Linux, but still not well documented, which makes the numbers that users
observe from the output of top, htop or other system monitoring applications are
only numbers. This patch discusses how Linux calculates the load average as well
as what is concerned while calculating the load average.

The discussion flow is divided into several parts:
1. The expression used to get the load average.
2. Why does Linux choose such an average method from the other.
2. The meaning of each term in the expression.
3. The type of tasks that will be covered in the calculation.
4. A brief explanation of the fixed-point number since the weights defined in
   the Linux kernel are based on it.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Co-Developed-by: Yiwei Lin <s921975628@gmail.com>

---
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
index 000000000000..1b55f8da4e16
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
+    $ cat /proc/laodavg
+
-- 
2.25.1

