Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E25020ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbiDODjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiDODjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:39:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6A475227;
        Thu, 14 Apr 2022 20:36:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bg9so6364346pgb.9;
        Thu, 14 Apr 2022 20:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ro17QGxtHVWnLXeBVe0SlNl98KKA0TueGG/iwSk7MY=;
        b=SoNomD0cPYQQFNOaKEr2DrGdxVcL1rCNw2q2SbcogDpRWoNOD71hlheS04wpKHj+TU
         MuVD2tAz8sUeyGjquJBq3YDEC1ghetmuUJr1Ej1HYD9NfXZQqzuN9fPncVWNpH8WQM41
         e756f7xMs1S0FFufoTX4yGlhx1Br3jf+5miO1GNgMObnsR1pywvGXoqys6uikcjMTqoQ
         Y8vgBmYJMW2CDeTHwB0bfKYDgwrVB+yJYSa7CmHwmRUWHFGNNslcvi8Hfxso+0zcyjxT
         0bydlTvQappxG3dTZfMXcWkTxC7dh1lnx4Z4DwgZLA+hh3FxfM+GZRv7PtRAjqIlXkos
         ZSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ro17QGxtHVWnLXeBVe0SlNl98KKA0TueGG/iwSk7MY=;
        b=VMukzMKsIWklv1jdCBZwAJ7GmsiWvA3btyPLzm9KIYyvGG02KTRg8mK4iilM3YZRa6
         YGrRn5FUf5QRreCJR1jpmjy37vzvIl2e1cZRMTTzmmsv2eM/z7ZklDCEyRZuaHDL7TsL
         Rr8sZNLPdOdQsfI+nAyLfrXg2MxVt/Xa9YBZkuct9sMoHVNFzaN6RNlFRmb7CLHaYovt
         hJWoMnhjzUSEoMcw7CODNQjygntCydix6zAZ1oYdVLysO+qbMUytD6i/6hvyfmuzu+ka
         MDV039ThFSC2sLOq0Bxo+Hr2KaGGQ/ySM3xYWnWfqR+SmkryhcFffZPWSEF4Fhi2ckQC
         SdkQ==
X-Gm-Message-State: AOAM533WW8843nOEIKIB5gFN8o2oX1wV0/PvjjXCBCk43a5Fluh5X4YT
        ZTm/BwMbK9UkyqqxNYSfLXU=
X-Google-Smtp-Source: ABdhPJwBh8uY0NWxqCUopeD7zL0l2WitRXJ6DQ6vCt2+LVV4O9VF2VVYF3EAxr5uSFKtBT3PqlL1zA==
X-Received: by 2002:a63:f641:0:b0:3a2:cea2:bcf with SMTP id u1-20020a63f641000000b003a2cea20bcfmr764898pgj.506.1649993793693;
        Thu, 14 Apr 2022 20:36:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:15e8:72d0:44ea:4d07])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005082c3cbfd2sm1187165pfn.218.2022.04.14.20.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 20:36:33 -0700 (PDT)
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
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] docs/scheduler: fix unit error
Date:   Fri, 15 Apr 2022 11:36:18 +0800
Message-Id: <20220415033618.15655-1-juitse.huang@gmail.com>
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

The unit mentioned in the documentation of scheduler statistics is
outdated which may mislead the readers.

The unit of statistics that is reported by /proc/schedstat is modified
to nanosecond, and the unit of statistics that is reported by
/proc/PID/schedstat is provided as well to make the context consistent.

The rq_cpu_time and the rq_sched_info.run_delay of a run queue, and the
sched_info.run_delay of a task are all updated based on the clock of the
run queue, while the se.sum_exec_runtime of a task is updated based on
the clock_task of the run queue of the task. Both the clock and
clock_task are relied on the return value of the function sched_clock()
which is in the unit of nanosecond.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
---
 Documentation/scheduler/sched-stats.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index dd9b99a025f7..03c062915998 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -56,9 +56,9 @@ Next two are try_to_wake_up() statistics:
 
 Next three are statistics describing scheduling latency:
 
-     7) sum of all time spent running by tasks on this processor (in jiffies)
+     7) sum of all time spent running by tasks on this processor (in nanoseconds)
      8) sum of all time spent waiting to run by tasks on this processor (in
-        jiffies)
+        nanoseconds)
      9) # of timeslices run on this cpu
 
 
@@ -155,8 +155,8 @@ schedstats also adds a new /proc/<pid>/schedstat file to include some of
 the same information on a per-process level.  There are three fields in
 this file correlating for that process to:
 
-     1) time spent on the cpu
-     2) time spent waiting on a runqueue
+     1) time spent on the cpu (in nanoseconds)
+     2) time spent waiting on a runqueue (in nanoseconds)
      3) # of timeslices run on this cpu
 
 A program could be easily written to make use of these extra fields to
-- 
2.25.1

