Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572B5490FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbiAQRwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiAQRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:52:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAF5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE7BB80F00
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 17:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2D3C36AE3;
        Mon, 17 Jan 2022 17:52:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qz4RErlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642441968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR77sVBJKfk/enxOsWX3Wu8wGdXDiwHLJ+nNzLvRppY=;
        b=Qz4RErlu17jmLsEsoT3sgMJ0fbY4w0qRPvCCU5ko7oohvLb1KKb0Gcu5pJcCPZWete8wF+
        gi02PYUjfAQT8Z+NUEwvyJbSkgkKdP1UoEu9AOnCa4ztcyCRdUidgKI50KidhKQrYHqBFW
        zfhxx+ln8ECTseOpwlnFlzui4lBVdTU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 937c7668 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 17 Jan 2022 17:52:48 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: simplify arithmetic function flow in account()
Date:   Mon, 17 Jan 2022 18:52:37 +0100
Message-Id: <20220117175237.361518-1-Jason@zx2c4.com>
In-Reply-To: <YeWnVHwcBaS7OZak@owl.dominikbrodowski.net>
References: <YeWnVHwcBaS7OZak@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that have_bytes is never modified, we can simplify this function.
First, we move the check for negative entropy_count to be first. That
ensures that subsequent reads of this will be non-negative. Then,
have_bytes and ibytes can be folded into their one use site in the
min_t() function.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a1720a48f583..ecb45be9535f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1291,9 +1291,9 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  * This function decides how many bytes to actually take from the
  * given pool, and also debits the entropy count accordingly.
  */
-static size_t account(size_t nbytes, int min)
+static noinline size_t account(size_t nbytes, int min)
 {
-	int entropy_count, orig, have_bytes;
+	int entropy_count, orig;
 	size_t ibytes, nfrac;
 
 	BUG_ON(input_pool.entropy_count > POOL_FRACBITS);
@@ -1301,20 +1301,15 @@ static size_t account(size_t nbytes, int min)
 	/* Can we pull enough? */
 retry:
 	entropy_count = orig = READ_ONCE(input_pool.entropy_count);
-	ibytes = nbytes;
-	/* never pull more than available */
-	have_bytes = entropy_count >> (POOL_ENTROPY_SHIFT + 3);
-
-	if (have_bytes < 0)
-		have_bytes = 0;
-	ibytes = min_t(size_t, ibytes, have_bytes);
-	if (ibytes < min)
-		ibytes = 0;
-
 	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("negative entropy count: count %d\n", entropy_count);
 		entropy_count = 0;
 	}
+
+	/* never pull more than available */
+	ibytes = min_t(size_t, nbytes, entropy_count >> (POOL_ENTROPY_SHIFT + 3));
+	if (ibytes < min)
+		ibytes = 0;
 	nfrac = ibytes << (POOL_ENTROPY_SHIFT + 3);
 	if ((size_t)entropy_count > nfrac)
 		entropy_count -= nfrac;
-- 
2.34.1

