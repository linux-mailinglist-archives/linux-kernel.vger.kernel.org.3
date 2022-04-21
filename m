Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90250A938
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391974AbiDUTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392125AbiDUTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76884D272;
        Thu, 21 Apr 2022 12:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B21961C37;
        Thu, 21 Apr 2022 19:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B218C385A7;
        Thu, 21 Apr 2022 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650569428;
        bh=1fcM7MbSJnaL9wKR6U/KV+2HM2X4zh1upGfZEhayAjs=;
        h=From:To:Cc:Subject:Date:From;
        b=HhwdwnCMMh1LSC6sLGLFDqUbR2Um/PwIUo/WCsiiHGaJEznGIbiedeHKxUHIF8TR5
         qX5lKEO9w97ZSbYzDVXmT5gkYResyHAFpO7hPNg+6eI2u9z8ykF1kKcnAHfAvai2yy
         7DiFqaf7lNKoNDZJOEWu82LF9CfOsTWzmcUpeH2D4gkqLrV33+tHnkjbzOxDFzOG9A
         UvOkkYg7MzM34MFwwpwMnQesVZuuf4tcPuYue6rvRfSkYkNkgjBwjF4/szpnGIw7Jq
         SM2Exdsp2CDkxG9FSwQhJMbo+7OXrjKQsVBQ/KImiVAmdprk0H5dFhlPD0oqkbwYq0
         DvShOoV4MZzpw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH] random: avoid mis-detecting a slow counter as a cycle counter
Date:   Thu, 21 Apr 2022 12:29:39 -0700
Message-Id: <20220421192939.250680-1-ebiggers@kernel.org>
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
 drivers/char/random.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf89c6f27a192..9647c61345573 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1382,12 +1382,20 @@ static void try_to_generate_entropy(void)
 		unsigned long entropy;
 		struct timer_list timer;
 	} stack;
+	int i;
 
 	stack.entropy = random_get_entropy();
 
-	/* Slow counter - or none. Don't even bother */
-	if (stack.entropy == random_get_entropy())
-		return;
+	/*
+	 * We must not proceed if we don't actually have a cycle counter.  To
+	 * detect a cycle counter, check whether random_get_entropy() returns a
+	 * different value each time.  Check it multiple times to avoid false
+	 * positives where a slow counter could be just on the cusp of a change.
+	 */
+	for (i = 0; i < 3; i++) {
+		if (stack.entropy == random_get_entropy())
+			return;
+	}
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {

base-commit: 939ee380b17589d026e132a1be91199409c3c934
-- 
2.35.2

