Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5334AA816
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiBEKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:35:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58130 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiBEKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:35:11 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 84A57200C43;
        Sat,  5 Feb 2022 10:35:10 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id A7574811AC; Sat,  5 Feb 2022 11:35:06 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] random: fix locking in crng_fast_load()
Date:   Sat,  5 Feb 2022 11:34:57 +0100
Message-Id: <20220205103458.133386-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205103458.133386-1-linux@dominikbrodowski.net>
References: <20220205103458.133386-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crng_init is protected by primary_crng->lock, so keep holding that lock
when incrementing crng_init from 0 to 1 in crng_fast_load(). The call to
pr_notice() can wait until the lock is released; this code path cannot
be reached twice, as crng_fast_load() aborts early if crng_init > 0.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d7d6e01bbc4..2df08d05e850 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -653,12 +653,13 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		pr_notice("fast init done\n");
 	}
+	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
 	return ret;
 }
 
-- 
2.35.1

