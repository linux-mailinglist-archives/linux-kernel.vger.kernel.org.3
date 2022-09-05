Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5D5AD151
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiIELQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiIELQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:16:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EF5A14C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662376587; x=1693912587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99PVs3adsOUhG4FlKPWA5eGj7EaAaYqxw5w7qNGXBCE=;
  b=gksWb+K7k3MhNVw4YVd2/czoth9RcWk3ZRHyLOXSojsS3v2MIoKVbR6M
   IfP6q2yDyRrPwgG7/486BRiMMmnPt0z3BwDe1XMevDeqZcQhp7FnkEmcW
   87iLudZX3v0nQDn3fruluf0vIz8j5EFuuKHAtvsnvDCucahGs1NQGnzSP
   V4GcmF9dMRuyLUR2wEzH0CFtt6Sj/GfWC9ls1FjGNe9tQQIlEl0wrFsF5
   tUIQ1r2xSFY5Yu2UD4C2s/NwhttAObw9/JYTcwl2N41HqwAoiyp5emezW
   YvhGC0FBMf2m3XaJZY/5FmhEw91fgSGjB0iQwJW8R54eopJr7vePjXHaD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="293951420"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="293951420"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643774517"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 04:16:22 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v2 1/2] percpu: Add percpu_counter_add_local
Date:   Tue,  6 Sep 2022 03:35:16 +0800
Message-Id: <20220905193516.846647-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220905193516.846647-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220905193516.846647-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add percpu_counter_add_local for only updating local counter
without aggregating to global counter.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/percpu_counter.h | 7 +++++++
 lib/percpu_counter.c           | 6 ++++++
 2 files changed, 13 insertions(+)

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
index ed610b75dc32..d33cb750962a 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -72,6 +72,12 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
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

