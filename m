Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0A5119D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiD0NyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiD0Nxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:53:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478D25292
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651067443; x=1682603443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HopieV5ZHZK0eaCU80aYwEPJ5IP7myIfEMk8757Yeow=;
  b=UIgoIHZSs54VQJDZLcNCEd2cs2WbPKVAkK1AsibRbZOINm36ffNAr07Z
   voVp9cfYLStMytoj1/SJf7Dm3/k4kT5MvdKkAv1Y2XFVHgfVZk1cIkuEe
   PqylGBklyBt1HrgJL72HhPibwkfbBeX11TkwfV4DRXy6U0pkTWFY41TZN
   PYa3PtNuMKh6HePDqIioMEUmwzstO0vD/GCTayL7O29j9L0VJBY1b/0OT
   sozYi8/u8JcEAUGF0cUjt85pGUEsadml12B1vk6thT/n8c4fcW8+wOogw
   2dkv38JwDLtE03vvAUc38xi2Apl45ayii/K4rAB3GPpvLivXhh0j03+rB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="266092704"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="266092704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="730808148"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2022 06:50:39 -0700
From:   Jun Miao <jun.miao@intel.com>
To:     elver@google.com, dvyukov@google.com, ryabinin.a.a@gmail.com,
        peterz@infradead.org
Cc:     bigeasy@linutronix.de, qiang1.zhang@intel.com,
        andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jun.miao@intel.com
Subject: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
Date:   Wed, 27 Apr 2022 21:50:50 +0800
Message-Id: <20220427135050.20566-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not put NMI unsafe code in irq_work_queue_on().

The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
will call the spinlock. While the irq_work_queue_on() is also very carefully
carfted to be exactly that.
When unable CONFIG_SMP or local CPU, the irq_work_queue_on() is even same to
irq_work_queue(). So delete KASAN instantly.

Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
Suggested by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
Acked-by: Marco Elver <elver@google.com>
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

