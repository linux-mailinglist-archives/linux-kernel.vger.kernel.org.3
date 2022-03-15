Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E094D969E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbiCOIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbiCOIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4944CD7D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p9so27768567wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KY1G/hNwjUlBePE2ZVsqVFVqg40+RQ73iJFBjzwX3UY=;
        b=VaQCzPFvc6gtrXjrOVTaHng32EKCgrpOKFRwKXdGHL3vjaqvp9oU8WJuCtXcyeSei8
         2j1NVgnIvi/OITGXFHHtvLlc4MZMUIU/Cxj3NrK9+jFTBMZRg2TaU4qOBVHK6W7TlcBn
         NBWD3a5kxQXCVJpkCBzDndfp+6Em6F8x7yDxoLELdupn3YolG1aoy95JjHXQUZooZ4P1
         tVpN6HofIrXiDObrbGASiTx6PWZNxzLaNVVq3yF9H/LhG0aDHmiB7ka4ljpUJiN38v6Y
         ldWg/Y20y7xR723ld7AxMNcyrX2neBJi/prA44z0pXR64nFyzW5AMmPhHbjPdGAFQ1Dw
         PtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KY1G/hNwjUlBePE2ZVsqVFVqg40+RQ73iJFBjzwX3UY=;
        b=l2uTHgVZ65MEfv61YYEJy3t/ug/wupihpkFRQ2lfHxRLTU5CyYKUojHGuDEYIVgguT
         n9jWB2oFvR1RhOnDHfrr7C9BgDcWsmHaH9ul/XzarryO6IWe1COM2e56hacSNQxl9MQT
         sQplZ3beV3kmN+RNROMOFEqT04U3KQ27ICGWeMx64+w21E6kLvBRZx/HS/kXi6rnQC/n
         8l76SOiKWklWvAhHa2blbF0QlZIBE9pNdNB9UIbm5fb+MxQychcMqFQwF5UEnE+coa8/
         U59nHutk2/DJgEYwgXndY95kWjGDjAmL6GIvSjKdyqh5DL+rvBRZQPS6y9PU8WWqSBZy
         7ImA==
X-Gm-Message-State: AOAM532tnj8NZCkOn0JhjG6dd2suZB6Z1nh3C1Kgs9nHdPM6Dd7Z7FOY
        HIyVmIlsdHvGApcvA8LROUt4Anc9IuI=
X-Google-Smtp-Source: ABdhPJyiC5sLyH+DNjtIOlZBRK900kTKx50/7PnRjNGtmI2TrXF4WnahcgPd2dAjf+zzEaTZk+QnnQ==
X-Received: by 2002:a5d:62cf:0:b0:203:d97c:3bae with SMTP id o15-20020a5d62cf000000b00203d97c3baemr192727wrv.237.1647333841905;
        Tue, 15 Mar 2022 01:44:01 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:44:01 -0700 (PDT)
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
Subject: [PATCH 12/15] sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
Date:   Tue, 15 Mar 2022 09:42:44 +0100
Message-Id: <20220315084247.40783-13-mingo@kernel.org>
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
 kernel/sched/fair.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7391c9287503..89d21fda106c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -20,6 +20,35 @@
  *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
+#include <linux/energy_model.h>
+#include <linux/mmap_lock.h>
+#include <linux/hugetlb_inline.h>
+#include <linux/jiffies.h>
+#include <linux/mm_api.h>
+#include <linux/highmem.h>
+#include <linux/spinlock_api.h>
+#include <linux/cpumask_api.h>
+#include <linux/lockdep_api.h>
+#include <linux/softirq.h>
+#include <linux/refcount_api.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/cond_resched.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/isolation.h>
+
+#include <linux/cpuidle.h>
+#include <linux/interrupt.h>
+#include <linux/mempolicy.h>
+#include <linux/mutex_api.h>
+#include <linux/profile.h>
+#include <linux/psi.h>
+#include <linux/ratelimit.h>
+
+#include <asm/switch_to.h>
+
+#include <linux/sched/cond_resched.h>
+
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
-- 
2.32.0

