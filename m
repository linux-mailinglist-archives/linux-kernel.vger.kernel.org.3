Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3F6511EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiD0Rfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiD0RfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:35:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F7B1218AFB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3145DED1;
        Wed, 27 Apr 2022 10:31:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0BBE3F73B;
        Wed, 27 Apr 2022 10:31:48 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 08/13] lkdtm/stackleak: avoid spurious failure
Date:   Wed, 27 Apr 2022 18:31:23 +0100
Message-Id: <20220427173128.2603085-9-mark.rutland@arm.com>
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

The lkdtm_STACKLEAK_ERASING() test scans for a contiguous block of
poison values between the low stack bound and the stack pointer, and
fails if it does not find a sufficiently large block.

This can happen legitimately if the scan the low stack bound, which
could occur if functions called prior to lkdtm_STACKLEAK_ERASING() used
a large amount of stack. If this were to occur, it means that the erased
portion of the stack is smaller than the size used by the scan, but does
not cause a functional problem

In practice this is unlikely to happen, but as this is legitimate and
would not result in a functional problem, the test should not fail in
this case.

Remove the spurious failure case.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/stackleak.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 00db21ff115e4..707d530d509b7 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -53,13 +53,6 @@ void lkdtm_STACKLEAK_ERASING(void)
 			found = 0;
 	}
 
-	if (found <= check_depth) {
-		pr_err("FAIL: the erased part is not found (checked %lu bytes)\n",
-						i * sizeof(unsigned long));
-		test_failed = true;
-		goto end;
-	}
-
 	pr_info("the erased part begins after %lu not poisoned bytes\n",
 				(i - found) * sizeof(unsigned long));
 
-- 
2.30.2

