Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187564995D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443182AbiAXU42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:56:28 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46484 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385544AbiAXUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:33:34 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3ED3B20140C;
        Mon, 24 Jan 2022 20:33:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id B809480E60; Mon, 24 Jan 2022 21:30:19 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 5/6] hw_random: break out of hwrng_fillfn if current rng is not trusted
Date:   Mon, 24 Jan 2022 21:29:50 +0100
Message-Id: <20220124202951.28579-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124202951.28579-1-linux@dominikbrodowski.net>
References: <20220124202951.28579-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For two reasons, current_quality may become zero within the rngd
kernel thread: (1) The user lowers current_quality to 0 by writing
to the sysfs module parameter file (note that increasing the quality
from zero is without effect at the moment), or (2) there are two or
more hwrng devices registered, and those which provide quality>0 are
unregistered, but one with quality==0 remains.

If current_quality is 0, the randomness is not trusted and cannot help
to increase the entropy count. That will lead to continuous calls to
the hwrngd thread and continuous stirring of the input pool with
untrusted bits.

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 9405fcdace38..bc9f95cbac92 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -429,6 +429,9 @@ static int hwrng_fillfn(void *unused)
 	while (!kthread_should_stop()) {
 		struct hwrng *rng;
 
+		if (!current_quality)
+			break;
+
 		rng = get_current_rng();
 		if (IS_ERR(rng) || !rng)
 			break;
-- 
2.34.1

