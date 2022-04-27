Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62161511EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbiD0Rf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiD0RfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:35:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9D312360C5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BA9143D;
        Wed, 27 Apr 2022 10:31:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DA463F73B;
        Wed, 27 Apr 2022 10:31:54 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 11/13] lkdtm/stackleak: check stack boundaries
Date:   Wed, 27 Apr 2022 18:31:26 +0100
Message-Id: <20220427173128.2603085-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427173128.2603085-1-mark.rutland@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackleak code relies upon the current SP and lowest recorded SP
falling within expected task stack boundaries.

Check this at the start of the test.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>
---
 drivers/misc/lkdtm/stackleak.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 46c60761a05ea..52800583fd051 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -35,6 +35,25 @@ static void noinstr check_stackleak_irqoff(void)
 	unsigned long poison_high, poison_low;
 	bool test_failed = false;
 
+	/*
+	 * Check that the current and lowest recorded stack pointer values fall
+	 * within the expected task stack boundaries. These tests should never
+	 * fail unless the boundaries are incorrect or we're clobbering the
+	 * STACK_END_MAGIC, and in either casee something is seriously wrong.
+	 */
+	if (current_sp < task_stack_low || current_sp >= task_stack_high) {
+		pr_err("FAIL: current_stack_pointer (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
+		       current_sp, task_stack_low, task_stack_high - 1);
+		test_failed = true;
+		goto out;
+	}
+	if (lowest_sp < task_stack_low || lowest_sp >= task_stack_high) {
+		pr_err("FAIL: current->lowest_stack (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
+		       lowest_sp, task_stack_low, task_stack_high - 1);
+		test_failed = true;
+		goto out;
+	}
+
 	/*
 	 * Depending on what has run prior to this test, the lowest recorded
 	 * stack pointer could be above or below the current stack pointer.
@@ -87,6 +106,7 @@ static void noinstr check_stackleak_irqoff(void)
 		poison_high - task_stack_low,
 		task_stack_low - task_stack_base);
 
+out:
 	if (test_failed) {
 		pr_err("FAIL: the thread stack is NOT properly erased!\n");
 		pr_expected_config(CONFIG_GCC_PLUGIN_STACKLEAK);
-- 
2.30.2

