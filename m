Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5924BF8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiBVNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBVNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:05:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693212D0A4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:05:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 162E4B81866
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF47C340E8;
        Tue, 22 Feb 2022 13:05:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E30iyLR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645535106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4YbJtGQg0BkecnlLX0loQH7fn5kcMhVwUQrgGLGgH04=;
        b=E30iyLR8UNu1m5GQjQMwGeWJxJJXv3AaQ0NQwNuqs7RL5Urg6WDk24yrl0nej5Svds9opw
        HhU38hei82GsIXnWbRezBBNeW35ji7+JbmZ5G1GSb7MVZS4rsZpRDAYIwXn3X6Karb1SUY
        /k/gsEsUAbIjONv3x1BhTxL9pZO3QJw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3b2df2e4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Feb 2022 13:05:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: only wake up writers after zap if threshold was passed
Date:   Tue, 22 Feb 2022 14:05:03 +0100
Message-Id: <20220222130503.45043-1-Jason@zx2c4.com>
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

The only time that we need to wake up /dev/random writers on
RNDCLEARPOOL/RNDZAPPOOL is when we're changing from a value that is
greater than or equal to POOL_MIN_BITS to zero, because if we're
changing from below POOL_MIN_BITS to zero, the writers are already
unblocked.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a4dedeea35e9..536237a0f073 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1582,7 +1582,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		 */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (xchg(&input_pool.entropy_count, 0)) {
+		if (xchg(&input_pool.entropy_count, 0) >= POOL_MIN_BITS) {
 			wake_up_interruptible(&random_write_wait);
 			kill_fasync(&fasync, SIGIO, POLL_OUT);
 		}
-- 
2.35.1

