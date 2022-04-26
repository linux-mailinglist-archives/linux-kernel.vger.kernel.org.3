Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F750FF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbiDZNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiDZNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:52:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63D6D84D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650980963; x=1682516963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+1AaMUKz7U1/QUWjG1naPByn71Ih8gIWJmcdLnyBoi8=;
  b=bxM+KnRK+gZN8w5ZFYMF1QBiS+7Aef+w0bI7sTgu4sm6JPnZadkUjoPh
   49vfc2tULpZu3aHmfjHZCDDP6FLdfxNkXbWQY/My3huxvJhQDW+wsml0j
   xoRaBEqNXrAG/24qaV+y9ascwxSANcem1/7J76fo5MKHjpe5gp9eIzoF2
   0PWqCFswxRun4xlvO+XAd4HFmaDLLtcypqhJFFuaJMtqVT73vEomPpPmN
   hT5+bO/hemj25R4Xlr4L6+Mhu2oNv8ddDOigfINtUP6NB4DVRR+ksXNxu
   Wssyjw92nipLT7QTdi2OB4TA6Rx9CyT2HejJDLe0rAY3asf1RDBi9VsxE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265105770"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265105770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579902914"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2022 06:49:19 -0700
From:   Jun Miao <jun.miao@intel.com>
To:     peterz@infradead.org
Cc:     bigeasy@linutronix.de, qiang1.zhang@intel.com,
        linux-kernel@vger.kernel.org, jun.miao@intel.com
Subject: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
Date:   Tue, 26 Apr 2022 21:49:24 +0800
Message-Id: <20220426134924.736104-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not put NMI unsafe code in irq_work_queue_on().

The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
will call the spinlock. While the irq_work_queue_on() is also very carefully
carafted to be exactly that.
When unable CONFIG_SM or local CPU, the irq_work_queue_on() is even same to
irq_work_queue(). So delete KASAN instantly.

Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
Suggested by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 kernel/irq_work.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..e7f48aa8d8af 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,7 +20,6 @@
 #include <linux/smp.h>
 #include <linux/smpboot.h>
 #include <asm/processor.h>
-#include <linux/kasan.h>
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
@@ -137,8 +136,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	kasan_record_aux_stack_noalloc(work);
-
 	preempt_disable();
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
-- 
2.32.0

