Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA84D969C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiCOIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbiCOIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B0A45AC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i8so27806751wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77pcSomeQnKShKXrvlesy60okMS3aTQ/Iv6cZiSzCOs=;
        b=TVJar/qlM8CWQr0Qf2F+gKbWJ+N5OOqoxwsklwdsBn6/BNPUEIxq5kASw1Nh/7Z2qV
         pXx0PPdF2iqsr41GDFVst36rJLYrMzuHy4Q0MRRGVd7FlJhsFrJ0Cfr9yPCYSzSzas7/
         qa8PxPa7XdBbw/w6cN4KJ4fDTS1/dfdg8OdxlZg65zLRQCbT3IYX5+8GftjyJ2rdkLuh
         GHVk6N2VmIFaRFNdRlTCy6DghvYEetmuiIixw5Dxvl5kLAENyF6lC/KaUdDJvBuKIEs8
         emGb1GqXlgGBW7Qjyb2mKEVDwjEafq3MyyWBRN82m6sukqO6acHNl5zmrth/wcAtx9HU
         BTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=77pcSomeQnKShKXrvlesy60okMS3aTQ/Iv6cZiSzCOs=;
        b=atVqDhx8MzM+9Extp/P8FdWCWz/ZARIaIVpA/6pX2Xh78HCiikHALqKyi/g87eAt79
         5ms60C4b2Bkz93GyeA+7cDAABiYnRe6S5j4aT8OWqCt6fXm7vQCkvHH8x5kanmuKCPVL
         mHqze31RRcQYg87pATCTRzOtSJuEGcVpcDTQa2p75gQhH76VrC+4YOUKazGqTyp5acHp
         Ngctse9QwquIDw56Asxnhz6ryVMZMPzCRYMTKfKM32XftblErAJ0IP71OsYMQEmaQJk2
         JqHoAgtyIcJ8UYe7aOokxnc/FMBUyshiWhiZbgkYaCfLPRpJhzIRoCQs2VJ7uTpztg8t
         gArg==
X-Gm-Message-State: AOAM533BPwa7Ghe599VywF4YSmprvOdcBsfd5AA0wiHhYyZ7TSZD7KHX
        V9BS3azxeHo7ByDWm70xQNoMubzCorQ=
X-Google-Smtp-Source: ABdhPJzWKBkPN97RucCYLQEd/Fnc8uNqwHg38moB8k4EYlSdXh/1Ejv6Pl6FdJLYnQI9CHBkAyPynA==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr19693711wru.212.1647333843026;
        Tue, 15 Mar 2022 01:44:03 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:44:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/15] sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
Date:   Tue, 15 Mar 2022 09:42:45 +0100
Message-Id: <20220315084247.40783-14-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/build_policy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 9a169b2f97e6..a2e4023771a0 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -12,12 +12,36 @@
  * core.c and fair.c are built separately.
  */
 
+/* Headers: */
+#include <linux/sched/clock.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/posix-timers.h>
+#include <linux/sched/rt.h>
+
+#include <linux/cpuidle.h>
+#include <linux/jiffies.h>
+#include <linux/livepatch.h>
+#include <linux/psi.h>
+#include <linux/seqlock_api.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/tsacct_kern.h>
+#include <linux/vtime.h>
+
+#ifdef CONFIG_PARAVIRT
+# include <asm/paravirt.h>
+#endif
+
+#include <uapi/linux/sched/types.h>
+
 #include "sched.h"
 
 #include "autogroup.h"
 #include "stats.h"
 #include "pelt.h"
 
+/* Source code modules: */
+
 #include "idle.c"
 
 #include "rt.c"
-- 
2.32.0

