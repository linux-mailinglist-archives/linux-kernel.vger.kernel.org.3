Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28E4F63D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiDFPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiDFPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:44:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A224DA2A7;
        Wed,  6 Apr 2022 06:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5909DB82389;
        Wed,  6 Apr 2022 13:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B257C385AD;
        Wed,  6 Apr 2022 13:09:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kimauhVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649250566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBb2vjofyUluOQh7TVdillsblyWSB74FkGKE9XEp+88=;
        b=kimauhVO0qreQir90l3FGbnPsUNRHKDvOy4Uc0hYovmeIqu1/9DdSwv3VPVdSQkoJpfoWS
        gG+ouJKYHGIFOV4oYdnN8CE4JAOKA3xnSQMxtb257wVesu4Dq/6wclPU7fPyprqjQw6JN8
        lQ9GzjFocqmruezeV6trtk1iFH0rmr4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e40af94 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 6 Apr 2022 13:09:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: [PATCH v2] random: do not allow user to keep crng key around on stack
Date:   Wed,  6 Apr 2022 15:09:13 +0200
Message-Id: <20220406130913.14481-1-Jason@zx2c4.com>
In-Reply-To: <20220405154627.244473-1-Jason@zx2c4.com>
References: <20220405154627.244473-1-Jason@zx2c4.com>
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

The fast key erasure RNG design relies on the key that's used to be used
and then discarded. We do this, making judicious use of
memzero_explicit().  However, reads to /dev/urandom and calls to
getrandom() involve a copy_to_user(), and userspace can use FUSE or
userfaultfd, or make a massive call, dynamically remap memory addresses
as it goes, and set the process priority to idle, in order to keep a
kernel stack alive indefinitely. By probing
/proc/sys/kernel/random/entropy_avail to learn when the crng key is
refreshed, a malicious userspace could mount this attack every 5 minutes
thereafter, breaking the crng's forward secrecy.

In order to fix this, we just overwrite the stack's key with the first
32 bytes of the "free" fast key erasure output. If we're returning <= 32
bytes to the user, then we can still return those bytes directly, so
that short reads don't become slower. And for long reads, the difference
is hopefully lost in the amortization, so it doesn't change much, with
that amortization helping variously for medium reads.

We don't need to do this for get_random_bytes() and the various
kernel-space callers, and later, if we ever switch to always batching,
this won't be necessary either, so there's no need to change the API of
these functions.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jann Horn <jannh@google.com>
Fixes: c92e040d575a ("random: add backtracking protection to the CRNG")
Fixes: 186873c549df ("random: use simpler fast key erasure flow on per-cpu keys")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- If len <= 32, return bytes directly to caller.

 drivers/char/random.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 388025d6d38d..47f01b1482a9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -532,19 +532,29 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	if (!nbytes)
 		return 0;
 
-	len = min_t(size_t, 32, nbytes);
-	crng_make_state(chacha_state, output, len);
-
-	if (copy_to_user(buf, output, len))
-		return -EFAULT;
-	nbytes -= len;
-	buf += len;
-	ret += len;
+	/*
+	 * Immediately overwrite the ChaCha key at index 4 with random
+	 * bytes, in case userspace causes copy_to_user() below to sleep
+	 * forever, so that we still retain forward secrecy in that case.
+	 */
+	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
+	/*
+	 * However, if we're doing a read of len <= 32, we don't need to
+	 * use chacha_state after, so we can simply return those bytes to
+	 * the user directly.
+	 */
+	if (nbytes <= CHACHA_KEY_SIZE) {
+		ret = copy_to_user(buf, &chacha_state[4], nbytes) ? -EFAULT : nbytes;
+		goto out_zero_chacha;
+	}
 
-	while (nbytes) {
+	do {
 		if (large_request && need_resched()) {
-			if (signal_pending(current))
+			if (signal_pending(current)) {
+				if (!ret)
+					ret = -ERESTARTSYS;
 				break;
+			}
 			schedule();
 		}
 
@@ -561,10 +571,11 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 		nbytes -= len;
 		buf += len;
 		ret += len;
-	}
+	} while (nbytes);
 
-	memzero_explicit(chacha_state, sizeof(chacha_state));
 	memzero_explicit(output, sizeof(output));
+out_zero_chacha:
+	memzero_explicit(chacha_state, sizeof(chacha_state));
 	return ret;
 }
 
-- 
2.35.1

