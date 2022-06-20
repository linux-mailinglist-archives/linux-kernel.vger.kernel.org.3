Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631975513BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiFTJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiFTJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6E558D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C446137F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C4C3411B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QAjDGtYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655715991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eNu1t95F3WyLFnN1cO3TOfXzGLQMrfQBdi7kaaniOVg=;
        b=QAjDGtYL9DVK58HtGk4VJIwJZNRgwP+jLywts85pocctjxQB1JZvL+eixWxk8Fktj2XYfc
        imWd/JqNS4T1iYNx9NoUiHmKs4UFNWXOWWvXZ8ON4vCBSc9btvEsxJSZmTzHiZTYB1VXyV
        drMrzt6nZ3A5xdq2qfqD2ciy14p2JAg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 571924b3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jun 2022 09:06:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: update comment from copy_to_user() -> copy_to_iter()
Date:   Mon, 20 Jun 2022 11:06:26 +0200
Message-Id: <20220620090626.700684-1-Jason@zx2c4.com>
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

This comment wasn't updated when we moved from read() to read_iter(), so
this patch makes the trivial fix.

Fixes: 1b388e7765f2 ("random: convert to using fops->read_iter()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 07a022e24057..e3dd1dd3dd22 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -408,7 +408,7 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
 
 	/*
 	 * Immediately overwrite the ChaCha key at index 4 with random
-	 * bytes, in case userspace causes copy_to_user() below to sleep
+	 * bytes, in case userspace causes copy_to_iter() below to sleep
 	 * forever, so that we still retain forward secrecy in that case.
 	 */
 	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
-- 
2.35.1

