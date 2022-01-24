Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189C4995D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443163AbiAXU4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:56:25 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46480 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385542AbiAXUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:33:34 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 30355201409;
        Mon, 24 Jan 2022 20:33:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id ABE6480A2D; Mon, 24 Jan 2022 21:30:08 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/6] hw_random: use rng_fillbuf in add_early_randomness()
Date:   Mon, 24 Jan 2022 21:29:48 +0100
Message-Id: <20220124202951.28579-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124202951.28579-1-linux@dominikbrodowski.net>
References: <20220124202951.28579-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using rng_buffer in add_early_randomness() may race with rng_dev_read().
Use rng_fillbuf instead, as it is otherwise only used within the kernel
by hwrng_fillfn() and therefore never exposed to userspace.

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index c2d260b5dd92..89891ac87af0 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -66,10 +66,10 @@ static void add_early_randomness(struct hwrng *rng)
 	int bytes_read;
 
 	mutex_lock(&reading_mutex);
-	bytes_read = rng_get_data(rng, rng_buffer, 32, 0);
+	bytes_read = rng_get_data(rng, rng_fillbuf, 32, 0);
 	mutex_unlock(&reading_mutex);
 	if (bytes_read > 0)
-		add_device_randomness(rng_buffer, bytes_read);
+		add_device_randomness(rng_fillbuf, bytes_read);
 }
 
 static inline void cleanup_rng(struct kref *kref)
-- 
2.34.1

