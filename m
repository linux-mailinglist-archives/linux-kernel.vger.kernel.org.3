Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF24ADDB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382202AbiBHPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382230AbiBHPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6560C0612BD;
        Tue,  8 Feb 2022 07:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B019DB81BBA;
        Tue,  8 Feb 2022 15:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE06C004E1;
        Tue,  8 Feb 2022 15:54:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WT802gTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0ac5RYvFLuC+iFVFU7A5DVoaNbsJ43GdSQLF6niWbY=;
        b=WT802gTWzbOqidTARTWJdW+TFUzWSuVV/GAcdlq5DcXhl/W9uRYep0CJCDujlzZVD5shp0
        lkazgLEi+5b7tB8UY+rwT/CJI0VCVQjy8QT04MEZfmiRMHtr/BKR/nprEKm/om9Ir1dQ7/
        dUcC/Eld+sXCIwPXdZIBmUPP3Pdzp3I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a588c37c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:54:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 4/7] random: ensure early RDSEED goes through mixer on init
Date:   Tue,  8 Feb 2022 16:53:32 +0100
Message-Id: <20220208155335.378318-5-Jason@zx2c4.com>
In-Reply-To: <20220208155335.378318-1-Jason@zx2c4.com>
References: <20220208155335.378318-1-Jason@zx2c4.com>
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

Continuing the reasoning of "random: use RDSEED instead of RDRAND in
entropy extraction" from this series, at init time we also don't want to
be xoring RDSEED directly into the crng. Instead it's safer to put it
into our entropy collector and then re-extract it, so that it goes
through a hash function with preimage resistance.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index db0e0e77613e..2bd19dce822d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1218,24 +1218,18 @@ int __init rand_initialize(void)
 	bool arch_init = true;
 	unsigned long rv;
 
+	mix_pool_bytes(utsname(), sizeof(*(utsname())));
 	mix_pool_bytes(&now, sizeof(now));
 	for (i = BLAKE2S_BLOCK_SIZE; i > 0; i -= sizeof(rv)) {
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
-			rv = random_get_entropy();
-		mix_pool_bytes(&rv, sizeof(rv));
-	}
-	mix_pool_bytes(utsname(), sizeof(*(utsname())));
-
-	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
-	for (i = 4; i < 16; i++) {
 		if (!arch_get_random_seed_long_early(&rv) &&
 		    !arch_get_random_long_early(&rv)) {
 			rv = random_get_entropy();
 			arch_init = false;
 		}
-		primary_crng.state[i] ^= rv;
+		mix_pool_bytes(&rv, sizeof(rv));
 	}
+
+	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
 	if (arch_init && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		crng_init = 2;
-- 
2.35.0

