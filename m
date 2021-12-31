Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB74823D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhLaLu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:50:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46118 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLaLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:50:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF98B81D72;
        Fri, 31 Dec 2021 11:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47339C36AEA;
        Fri, 31 Dec 2021 11:50:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fYcWwMGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640951451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tVzg2dFp9Ag0q40I1RLaWI8DKB23+5H9AMK1O1RC1Q=;
        b=fYcWwMGq8jAfLqFowl7tO/SRX2OPLD8Ul0mCt0UUYA8oEVjBqi0omTQsi9WA3iD2ftrDfg
        PMkk/8NpjzgmsevA6nOSOc7VfBLQyBraaYnN7BMHQJUS+SKjrlrxKO+dq5cHtFfIrT/CSI
        K/fNdcaCN8K99EHw3UCTdpxGKgyFe6I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5a113dd6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 31 Dec 2021 11:50:50 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG extraction
Date:   Fri, 31 Dec 2021 12:49:03 +0100
Message-Id: <20211231114903.60882-1-Jason@zx2c4.com>
In-Reply-To: <Yc56ey6QKwaYg0yi@mit.edu>
References: <Yc56ey6QKwaYg0yi@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RDRAND is not fast. RDRAND is actually quite slow. We've known this for
a while, which is why functions like get_random_u{32,64} were converted
to use batching of our ChaCha-based CRNG instead.

Yet CRNG extraction still includes a call to RDRAND, in the hot path of
every call to get_random_bytes(), /dev/urandom, and getrandom(2).

This call to RDRAND here seems quite superfluous. CRNG is already
extracting things based on a 256-bit key, based on good entropy, which
is then reseeded periodically, updated, backtrack-mutated, and so
forth. The CRNG extraction construction is something that we're already
relying on to be secure and solid. If it's not, that's a serious
problem, and it's unlikely that mixing in a measly 32 bits from RDRAND
is going to alleviate things.

And in the case where the CRNG doesn't have enough entropy yet, we're
already initializing the ChaCha key row with RDRAND in
crng_init_try_arch_early().

Removing the call to RDRAND improves performance on an i7-11850H by
370%. In other words, the vast majority of the work done by
extract_crng() prior to this commit was devoted to fetching 32 bits of
RDRAND.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4de0feb69781..17ec60948795 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1023,7 +1023,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 static void _extract_crng(struct crng_state *crng,
 			  __u8 out[CHACHA_BLOCK_SIZE])
 {
-	unsigned long v, flags, init_time;
+	unsigned long flags, init_time;
 
 	if (crng_ready()) {
 		init_time = READ_ONCE(crng->init_time);
@@ -1033,8 +1033,6 @@ static void _extract_crng(struct crng_state *crng,
 				    &input_pool : NULL);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	if (arch_get_random_long(&v))
-		crng->state[14] ^= v;
 	chacha20_block(&crng->state[0], out);
 	if (crng->state[12] == 0)
 		crng->state[13]++;
-- 
2.34.1

