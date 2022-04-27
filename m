Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C45511ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiD0N7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiD0N7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD0381A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651067763; x=1682603763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iybemTWHbJzVGcBVPPYd43izh/rM5Dxfse0LBA83AKA=;
  b=jUqdkb8fdgapPppFiXjZQz6nIR/V3jiYafBw2x8QZNmKFL0d8cknrUeO
   uUtnMgsjX4K73M1athn1TIia0gLtmgLqAnbhz6/MM8b1YkJSHYUMX8g//
   IMS+SqwZ3vsu/+bDHDWgmVqNqps6jxTIjo0HTNF4EQZUObxVNaIirL3aK
   dsxzq7HXju/B+YBctcht5t23mE7mnfbH7LbqWYR3EFEEoK0wzuB2jsiC+
   M7J/UwV2vNzFYVS3bQIwVrwKl9Fi1kWqnrVvVy/2UHGNYBHU7jGYbQAnQ
   frpN5SiQ2IDv7KD8LXf8mAlq3JgxGzk38Xq+HmLxVSWAap2nfKt1bPeTN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="352368468"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="352368468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="596287912"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 06:55:38 -0700
From:   Jun Miao <jun.miao@intel.com>
To:     elver@google.com, dvyukov@google.com, ryabinin.a.a@gmail.com,
        peterz@infradead.org
Cc:     bigeasy@linutronix.de, qiang1.zhang@intel.com,
        andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jun.miao@intel.com
Subject: [PATCH v2] irq_work: Make irq_work_queue_on() NMI-safe again
Date:   Wed, 27 Apr 2022 21:55:49 +0800
Message-Id: <20220427135549.20901-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not put NMI unsafe code in irq_work_queue_on().

The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
will call the spinlock. While the irq_work_queue_on() is also very carefully
crafted to be exactly that.
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

