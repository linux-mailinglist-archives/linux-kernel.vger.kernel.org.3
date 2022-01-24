Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A64995D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443198AbiAXU4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:56:30 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46478 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385536AbiAXUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:33:34 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 35D0920140A;
        Mon, 24 Jan 2022 20:33:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 3E81B809C2; Mon, 24 Jan 2022 21:30:02 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/6] hw_random: explicit ordering of initcalls
Date:   Mon, 24 Jan 2022 21:29:46 +0100
Message-Id: <20220124202951.28579-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw-random device drivers depend on the hw-random core being
initialized. Make this ordering explicit, also for the case
these drivers are built-in. As the core itself depends on
misc_register() which is set up at subsys_initcall time,
advance the initialization of the core (only) to the
fs_initcall() level.

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a3db27916256..e860e044b19e 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -638,7 +638,7 @@ static void __exit hwrng_modexit(void)
 	unregister_miscdev();
 }
 
-module_init(hwrng_modinit);
+fs_initcall(hwrng_modinit); /* depends on misc_register() */
 module_exit(hwrng_modexit);
 
 MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
-- 
2.34.1

