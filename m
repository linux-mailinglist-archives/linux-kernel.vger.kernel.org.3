Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382E4D1E88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbiCHRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348898AbiCHRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECE53B51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14819B81B8B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BCEC340EB;
        Tue,  8 Mar 2022 17:18:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BiuKkS0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646759933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AZ+d5tFFjQ1rNjN45rdxTOo6PPrAddVrmZAsuxSqFck=;
        b=BiuKkS0j8xqotj6mFNIf7r/lkKm0JyJSrUJKyckxpjJPW9FNuvEqdj3dVtHlBIFTyWo1jE
        P05CokGXeCz2hz5tn8XQY4UYavumtAgD8urzDuN0328r4mGvk0nj8HdfSd1PcbanRlTWGJ
        q/5985/J7MGtA/X2b/IlMbHQIiGyAwQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dfec7c9e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Mar 2022 17:18:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: check for signal and try earlier when generating entropy
Date:   Tue,  8 Mar 2022 10:18:49 -0700
Message-Id: <20220308171849.242534-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call try_to_generate_entropy() from wait_for_random_bytes().
wait_for_random_bytes() always uses wait_event_interruptible_timeout()
when waiting, since it's called by userspace code in restartable
contexts, where signals can pend. When entering a busy loop in
try_to_generate_entropy(), we should therefore also check to see if any
signals are pending, so that a process doesn't get stuck in that loop
longer than expected. As well, there's no point in waiting for a full
second before trying to generate entropy; instead do it in the opposite
order, where we try to generate, and then go into the waitable.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index edb5b06544da..4c5f515b6080 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -128,11 +128,12 @@ int wait_for_random_bytes(void)
 
 	do {
 		int ret;
+
+		try_to_generate_entropy();
 		ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
 		if (ret)
 			return ret > 0 ? 0 : ret;
 
-		try_to_generate_entropy();
 	} while (!crng_ready());
 
 	return 0;
@@ -1374,7 +1375,7 @@ static void try_to_generate_entropy(void)
 		return;
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
-	while (!crng_ready()) {
+	while (!crng_ready() && !signal_pending(current)) {
 		if (!timer_pending(&stack.timer))
 			mod_timer(&stack.timer, jiffies + 1);
 		mix_pool_bytes(&stack.cycles, sizeof(stack.cycles));
-- 
2.35.1

