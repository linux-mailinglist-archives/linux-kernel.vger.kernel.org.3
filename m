Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCC48DAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiAMPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57126 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiAMPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 237AFCE2013
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245DAC36AEB;
        Thu, 13 Jan 2022 15:44:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BIg9OsWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642088675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8uzfNbiMW9+EFnbQSTDD4OCUTw/CEslAl5QmUi7R7o=;
        b=BIg9OsWCiaVqvIDWhxIv46HjLLw5uqP0iTepKyEUJ4moJ925w03u1grR8AMmpyZnVvg1FC
        DGWzoKjMqydQIKSON66qZSLQgcYMqMfp5fkwvN+BSu5at+hQ8JOwTp1o8JvG08r2eaZ3Mt
        AUk/IMWOfhmB66iszQtGAv6ZNT6xE64=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id de5bea17 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 13 Jan 2022 15:44:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4/7] random: remove unused reserved argument
Date:   Thu, 13 Jan 2022 16:44:10 +0100
Message-Id: <20220113154413.29513-5-Jason@zx2c4.com>
In-Reply-To: <20220113154413.29513-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument is always set to zero, as a result of us not caring about
keeping a certain amount reserved in the pool these days. So just remove
it and cleanup the function signatures.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7a4d858ac731..5bef9565b251 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -519,7 +519,7 @@ struct entropy_store {
 };
 
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
-			       size_t nbytes, int min, int rsvd);
+			       size_t nbytes, int min);
 static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
 				size_t nbytes);
 
@@ -989,7 +989,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	} buf;
 
 	if (r) {
-		num = extract_entropy(r, &buf, 32, 16, 0);
+		num = extract_entropy(r, &buf, 32, 16);
 		if (num == 0)
 			return;
 	} else {
@@ -1327,8 +1327,7 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  * This function decides how many bytes to actually take from the
  * given pool, and also debits the entropy count accordingly.
  */
-static size_t account(struct entropy_store *r, size_t nbytes, int min,
-		      int reserved)
+static size_t account(struct entropy_store *r, size_t nbytes, int min)
 {
 	int entropy_count, orig, have_bytes;
 	size_t ibytes, nfrac;
@@ -1342,7 +1341,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	/* never pull more than available */
 	have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
 
-	if ((have_bytes -= reserved) < 0)
+	if (have_bytes < 0)
 		have_bytes = 0;
 	ibytes = min_t(size_t, ibytes, have_bytes);
 	if (ibytes < min)
@@ -1448,15 +1447,13 @@ static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
  * returns it in a buffer.
  *
  * The min parameter specifies the minimum amount we can pull before
- * failing to avoid races that defeat catastrophic reseeding while the
- * reserved parameter indicates how much entropy we must leave in the
- * pool after each pull to avoid starving other readers.
+ * failing to avoid races that defeat catastrophic reseeding.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
-				 size_t nbytes, int min, int reserved)
+				 size_t nbytes, int min)
 {
 	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	nbytes = account(r, nbytes, min, reserved);
+	nbytes = account(r, nbytes, min);
 	return _extract_entropy(r, buf, nbytes);
 }
 
-- 
2.34.1

