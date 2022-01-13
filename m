Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A048DADF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiAMPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33148 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiAMPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725C16124F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE9CC36AFE;
        Thu, 13 Jan 2022 15:44:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XqdyTKnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642088672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eUxLJt0e0HqhUgI6T/KYl5MzsAEP7W+V3LaSLhHLY4=;
        b=XqdyTKnZhhl6dACeRSp+nEPzQG0GS8xj1iw7myhMDUJV44QUFYJexCKGpBT5ll8vUKgwv6
        z0XyEwfv6gd7tCSe926THVCC0jkq09FKURuETA0xCfunEVrEvfuSdc6T+yFEp2I4jBjbFt
        3M+4eIDz0RNr0I6fay+5GASv2lBHFvI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd4162f5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 13 Jan 2022 15:44:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/7] random: remove incomplete last_data logic
Date:   Thu, 13 Jan 2022 16:44:09 +0100
Message-Id: <20220113154413.29513-4-Jason@zx2c4.com>
In-Reply-To: <20220113154413.29513-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few things added under the "if (fips_enabled)" banner,
which never really got completed, and the FIPS people anyway are
choosing a different direction. Rather than keep around this halfbaked
code, get rid of it so that we can focus on a single design of the RNG
rather than two designs.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4b84b95428bc..7a4d858ac731 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -337,7 +337,6 @@
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/percpu.h>
-#include <linux/fips.h>
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
@@ -517,14 +516,12 @@ struct entropy_store {
 	unsigned short add_ptr;
 	unsigned short input_rotate;
 	int entropy_count;
-	unsigned int last_data_init:1;
-	u8 last_data[EXTRACT_SIZE];
 };
 
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 			       size_t nbytes, int min, int rsvd);
 static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
-				size_t nbytes, int fips);
+				size_t nbytes);
 
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r);
 static u32 input_pool_data[INPUT_POOL_WORDS] __latent_entropy;
@@ -821,7 +818,7 @@ static void crng_initialize_secondary(struct crng_state *crng)
 
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
-	_extract_entropy(&input_pool, &crng->state[4], sizeof(u32) * 12, 0);
+	_extract_entropy(&input_pool, &crng->state[4], sizeof(u32) * 12);
 	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
@@ -1426,22 +1423,13 @@ static void extract_buf(struct entropy_store *r, u8 *out)
 }
 
 static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
-				size_t nbytes, int fips)
+				size_t nbytes)
 {
 	ssize_t ret = 0, i;
 	u8 tmp[EXTRACT_SIZE];
-	unsigned long flags;
 
 	while (nbytes) {
 		extract_buf(r, tmp);
-
-		if (fips) {
-			spin_lock_irqsave(&r->lock, flags);
-			if (!memcmp(tmp, r->last_data, EXTRACT_SIZE))
-				panic("Hardware RNG duplicated output!\n");
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
-			spin_unlock_irqrestore(&r->lock, flags);
-		}
 		i = min_t(int, nbytes, EXTRACT_SIZE);
 		memcpy(buf, tmp, i);
 		nbytes -= i;
@@ -1467,28 +1455,9 @@ static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 				 size_t nbytes, int min, int reserved)
 {
-	u8 tmp[EXTRACT_SIZE];
-	unsigned long flags;
-
-	/* if last_data isn't primed, we need EXTRACT_SIZE extra bytes */
-	if (fips_enabled) {
-		spin_lock_irqsave(&r->lock, flags);
-		if (!r->last_data_init) {
-			r->last_data_init = 1;
-			spin_unlock_irqrestore(&r->lock, flags);
-			trace_extract_entropy(r->name, EXTRACT_SIZE,
-					      ENTROPY_BITS(r), _RET_IP_);
-			extract_buf(r, tmp);
-			spin_lock_irqsave(&r->lock, flags);
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
-		}
-		spin_unlock_irqrestore(&r->lock, flags);
-	}
-
 	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
 	nbytes = account(r, nbytes, min, reserved);
-
-	return _extract_entropy(r, buf, nbytes, fips_enabled);
+	return _extract_entropy(r, buf, nbytes);
 }
 
 #define warn_unseeded_randomness(previous) \
-- 
2.34.1

