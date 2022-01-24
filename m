Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA908499942
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454958AbiAXVeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:34:14 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51024 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444056AbiAXU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:59:55 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8EC1220124E;
        Mon, 24 Jan 2022 20:33:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id B3FDE80E73; Mon, 24 Jan 2022 21:30:21 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 6/6] hw_random: credit entropy for low quality sources of randomness
Date:   Mon, 24 Jan 2022 21:29:51 +0100
Message-Id: <20220124202951.28579-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124202951.28579-1-linux@dominikbrodowski.net>
References: <20220124202951.28579-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the entropy quality is low, there may be less than one bit to
credit in the call to add_hwgenerator_randomness(): The number of bytes
returned by rng_get_data() multiplied by the current quality (in entropy
bits per 1024 bits of input) must be larger than 128 to credit at least
one bit. However, imx-rngc.c sets the quality to 19, but may return less
than 32 bytes; hid_u2fzero.c sets the quality to 1; and users may override
the quality setting manually.

In case there is less than one bit to credit, keep track of it and add
that credit to the next iteration.

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index bc9f95cbac92..6d7f05641c7c 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -427,6 +427,7 @@ static int hwrng_fillfn(void *unused)
 	long rc;
 
 	while (!kthread_should_stop()) {
+		size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
 		struct hwrng *rng;
 
 		if (!current_quality)
@@ -445,9 +446,17 @@ static int hwrng_fillfn(void *unused)
 			msleep_interruptible(10000);
 			continue;
 		}
+
+		/* If we cannot credit at least one bit of entropy,
+		 * keep track of the remainder for the next iteration
+		 */
+		entropy = rc * current_quality * 8 + entropy_credit;
+		if ((entropy >> 10) == 0)
+			entropy_credit = entropy;
+
 		/* Outside lock, sure, but y'know: randomness. */
 		add_hwgenerator_randomness((void *)rng_fillbuf, rc,
-					   rc * current_quality * 8 >> 10);
+					   entropy >> 10);
 	}
 	hwrng_fill = NULL;
 	return 0;
-- 
2.34.1

