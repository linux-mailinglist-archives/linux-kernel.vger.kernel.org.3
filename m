Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111884D9D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiCOONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbiCOONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:13:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858F546AA;
        Tue, 15 Mar 2022 07:12:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t22so5096784plo.0;
        Tue, 15 Mar 2022 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBjCmranFtHv1vltq1QMGyO83TXiM11V7MrR46Em3wg=;
        b=flgislALV+7xmb46BtergdR0pysltSIUFlYlXfHfsQ8uuQZPV3r2jE6Aqk7Zk6dTfG
         tNpHH5+cqF4RYzJYM6XVgc6T6utSbHG3vyBOO2sg0Dd4X1mO/BEj0vwYd8WUA/HsN7K1
         izZxh0pArEDoqTxYpoXKdmfZxIw1B+WUdYJxxZ2XvqHm5PDW4x0FDsjR13XuFpwWfwl/
         D0cdQYuAt0gE/oaOp7mOVow+HfkptY4r0SZ9CM34QzE0GpZvwqkkthk7XR9BLJVal0KT
         x5jdq8Ea3uL5Zx0Gmoy7397guqa4ZMZg0wOQ16gyUMztFYDNbdjfUajEb+sM8EaJ6QfT
         22JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBjCmranFtHv1vltq1QMGyO83TXiM11V7MrR46Em3wg=;
        b=eoaMFiGavupTUf/3QBzNJ06hYkdEG9Ko7jZOUbwtPxfnGRq1ZGARo1x4eoBKAjBahy
         Hr0XZHiwgYFKPl8zmp8hMyhdoEIAUOCfCwWuRYGJAkD8RLRnsk0ZIJPysUjYT0WHCuOm
         QEDlHizap4izwR6TLzEwcwsdLdmTUtdmmg/BoPB83bihYvHyJghexDZ1vj1UnHYhEYj6
         JJJxUTIwhjZy632UoetWyj00rTNMKWUcaTVeXBtqWhEec1N/Z3dKj6WZwz00HEkAbQ39
         kckMKFCL7L+gURIsijNiMB+ChjPR1I/6FQwYTTOc80qPtGGvLPXT9dVoeiJzeOVUEs96
         c7+Q==
X-Gm-Message-State: AOAM532Q3SvII62qOM2oSq5cRWvJMi4/wFGiuxUDmCPSNf8Iffe1JTMI
        ilgpdIzda6ziGwbTOumxe5E=
X-Google-Smtp-Source: ABdhPJz+bw0vZYPd6K41rTu627G1+NBT2paw4d81Ygh+VlOZIvUqJwJj0ZxHPLteYixdQSJavNgtkw==
X-Received: by 2002:a17:90b:3b8c:b0:1c5:ce7c:51de with SMTP id pc12-20020a17090b3b8c00b001c5ce7c51demr4854334pjb.182.1647353549828;
        Tue, 15 Mar 2022 07:12:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:9207:10e8:3cd5:9c86])
        by smtp.gmail.com with ESMTPSA id t9-20020a655549000000b0036570f81245sm20167129pgr.84.2022.03.15.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:12:28 -0700 (PDT)
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
Subject: [PATCH v3] docs/scheduler: Introduce the doc of load average
Date:   Tue, 15 Mar 2022 22:08:57 +0800
Message-Id: <20220315140857.41697-1-juitse.huang@gmail.com>
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

---

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
index 000000000000..27ce6cbae5f4
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
+the expressions shown bellow::
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

