Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5F50ABFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442555AbiDUXfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349332AbiDUXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:35:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4243BBC1;
        Thu, 21 Apr 2022 16:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5080B82936;
        Thu, 21 Apr 2022 23:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7294BC385A7;
        Thu, 21 Apr 2022 23:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650583962;
        bh=N4PWRNQyzJhdBLpeVkHT5hgPnH2wpLBteBcwAUC81uE=;
        h=From:To:Cc:Subject:Date:From;
        b=f8YS12Zp7oN2fmrppBL6o2uUJlnajln7s1JQIlCTwf9dCQ5/Agk23KsKyH0YQ6Dd9
         WKRFXTdtIhrmrF/faG+0TlsWpsZAgJIoI3OTeogEISAQVe+LKb0tk86yMccaiWf968
         9lX+Uo56dK/d+xhVZzi6xAmGBfeUhwiuxbs5ZUncttLaMOmw1ztDAuASWfPwf+LCre
         hl/LPuipt9dWg6RxGKyfURGGjonUOPuUKuWGVi8K277vX9iX051fGkJvrnYY58ccGy
         gWgcoKgFqX0gz0iJZhHlh1ZUCfL1Fvdw7KOfwpoOkvzkogfyqcYzznCd9Xt6qvmtn5
         P7D1xQ0fWWCaA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH v2] random: avoid mis-detecting a slow counter as a cycle counter
Date:   Thu, 21 Apr 2022 16:31:52 -0700
Message-Id: <20220421233152.58522-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The method that try_to_generate_entropy() uses to detect a cycle counter
is to check whether two calls to random_get_entropy() return different
values.  This is uncomfortably prone to false positives if
random_get_entropy() is a slow counter, as the two calls could return
different values if the counter happens to be on the cusp of a change.
Making things worse, the task can be preempted between the calls.

This is problematic because try_to_generate_entropy() doesn't do any
real entropy estimation later; it always credits 1 bit per loop
iteration.  To avoid crediting garbage, it relies entirely on the
preceding check for whether a cycle counter is present.

Therefore, increase the number of counter comparisons from 1 to 3, to
greatly reduce the rate of false positive cycle counter detections.

Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: compare with previous value rather than first one.

 drivers/char/random.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf89c6f27a192..18d2d1f959683 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1382,12 +1382,22 @@ static void try_to_generate_entropy(void)
 		unsigned long entropy;
 		struct timer_list timer;
 	} stack;
+	int i;
 
+	/*
+	 * We must not proceed if we don't actually have a cycle counter.  To
+	 * detect a cycle counter, check whether random_get_entropy() returns a
+	 * new value each time.  Check this multiple times to avoid false
+	 * positives where a slow counter could be just on the cusp of a change.
+	 */
 	stack.entropy = random_get_entropy();
+	for (i = 0; i < 3; i++) {
+		unsigned long entropy = random_get_entropy();
 
-	/* Slow counter - or none. Don't even bother */
-	if (stack.entropy == random_get_entropy())
-		return;
+		if (stack.entropy == entropy)
+			return;
+		stack.entropy = entropy;
+	}
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {

base-commit: 939ee380b17589d026e132a1be91199409c3c934
-- 
2.35.2

