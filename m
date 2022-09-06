Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AED5AE2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiIFIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiIFIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:37:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2C77EAC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662453347; x=1693989347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xr2XFavRO7vmZgXY1TerF9mR0HBaDqK26PpRm3Zspt4=;
  b=ZG7eI6eXzfMAF9ymJNuMCXdBLBKCz3+FyeGjGdBWJ57FD8gT0Rl/a5Ik
   tuNXj0lwfpT+RHLs/284ScCwIauL34pXDbpSUKvudjuPCMXkCz5LsAUYf
   zbUnPO73aV6XmJ0YF+8CfDe/S0vfa/fvv+WFHbM04KXYxxswQHr9Fmqmr
   BvF4MF9ukCHuW2FkkSMHAWunkehGOodSujHkdP27aVjOj+BI3RTQWzFwa
   k4AS7ubHaHAiPQkfhbNypg0IndXwfaU6vyrkg9fW4WZqzq43sBnnByls4
   NeCeExNpW+prJxlVQ51ZQorkEPVYZSdzjWmJ5grx6Q0haTvvf+V9hGisB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295273481"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="295273481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 01:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="675597111"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 01:35:29 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v3 1/2] percpu: Add percpu_counter_add_local
Date:   Wed,  7 Sep 2022 00:54:29 +0800
Message-Id: <20220906165430.851424-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165430.851424-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220906165430.851424-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add percpu_counter_add_local for only updating local counter
without aggregating to global counter.

This function could be used with percpu_counter_sum together if
you need high accurate counter. It could bring obvious performance
improvement if percpu_counter_add is frequently called and
percpu_counter_sum is not in the critical path.

Please use percpu_counter_add_batch instead if you need the counter
timely but not accurate and the call of percpu_counter_add_batch is
not heavy.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/percpu_counter.h |  7 +++++++
 lib/percpu_counter.c           | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861eebed79..344d69ae0fb1 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -40,6 +40,7 @@ int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
 
 void percpu_counter_destroy(struct percpu_counter *fbc);
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
+void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
@@ -138,6 +139,12 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	preempt_enable();
 }
 
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add(fbc, amount);
+}
+
 static inline void
 percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..36907eb573a8 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -72,6 +72,20 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
+/*
+ * Recommend to use the function combined with percpu_counter_sum if you need
+ * high accurate counter. As the percpu_counter_sum add up all the percpu
+ * counter, there is no need to check batch size and sum in percpu_counter_add.
+ * If the percpu_counter_sum is infrequent used and the percpu_counter_add
+ * is in critical path, this combination could have significant performance
+ * improvement than the function percpu_counter_add_batch.
+ */
+void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	this_cpu_add(*fbc->counters, amount);
+}
+EXPORT_SYMBOL(percpu_counter_add_local);
+
 /*
  * This function is both preempt and irq safe. The former is due to explicit
  * preemption disable. The latter is guaranteed by the fact that the slow path
-- 
2.31.1

