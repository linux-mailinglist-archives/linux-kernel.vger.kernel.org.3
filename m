Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B4508C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355155AbiDTQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbiDTQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:00:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FC2ED5D;
        Wed, 20 Apr 2022 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650470237; x=1682006237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S98vaXkbz8UZkBJ9FEMnbk+W6levwYfoDCblKiAVM20=;
  b=hzq1b4jquH4wQ+Xty9pUdCKh3UDj8yEJacSstOc6ziy6sY0BE6709pqj
   qCcIU9fbDsDUxUYvcdbGgPEiqco6FTt/rkXOXRB+d4nrlM3y4H93khAtL
   0HSfdsjXOoGw7nOu0h6BRz2nOGP4v6w0Ab0K2uVx4LjI3EdsyizQnq5JS
   JwQx0euU3bvwPezxOCEhJNBeHMllpQD0r8cDNOTSiV1MrGg8rb+1PELbu
   DKHxvv0tQz6ZTDobvXmU23lqXnkcJyBniIkMIw8gcVsW29JNUOwC7b74/
   HvPjO8Si7pxzM1bh5XEM8DvfS7qQ+ab2O02TpEv9hiqApEJN/d1ovaUVy
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643670000"; 
   d="scan'208";a="23392892"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Apr 2022 17:57:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 20 Apr 2022 17:57:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 20 Apr 2022 17:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650470235; x=1682006235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S98vaXkbz8UZkBJ9FEMnbk+W6levwYfoDCblKiAVM20=;
  b=DQrL6l2SiOoxKg5q/nTMqixNBoEGggjvvt3eeraTH0YM4f88s/hWl42V
   s8KOGt0hY8gtoI+guXiD8Ttbv7HY4kc8vyoO5o0VNdQwc8t0PmOSg1rHM
   FUKBla+K3XIAw0n+PgqoYG3IpaUnWPAtCRkW9RRnUKr2us9z+9XKJ4May
   NBmt31bik37WYIrwBh9skiYTUwtMeeVxdjPltagNSJQ2ePyFWLJu9W2D1
   el08blOadz7KXnFwOBEWODXnUoLBvUnZaGASNH4piSOLpbvo8SJWlSl1Y
   zBmyGUjISB/kvMoPMXlHHWZuLoY5qImMpBlWCRXH8yyr6pMdzCr7KNc/K
   g==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643670000"; 
   d="scan'208";a="23392891"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Apr 2022 17:57:15 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C2A19280070;
        Wed, 20 Apr 2022 17:57:14 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] spi: cadence-quadspi: allow operations with cmd/addr buswidth >1
Date:   Wed, 20 Apr 2022 17:56:16 +0200
Message-Id: <20220420155616.281730-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
References: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the incorrect logic of cqspi_set_protocol(), ops with
cmd/addr buswidth >1 are now working correctly.

Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash using 1-4-4
operations.

DTR operations are currently untested, so we leave them disabled for now
(except for the previously allowed 8-8-8 ops).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: update commit message; no code changes

 drivers/spi/spi-cadence-quadspi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8c12c6dd58ae..0f7e28ef5209 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1347,13 +1347,7 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 			return false;
 		if (op->data.nbytes && op->data.buswidth != 8)
 			return false;
-	} else if (all_false) {
-		/* Only 1-1-X ops are supported without DTR */
-		if (op->cmd.nbytes && op->cmd.buswidth > 1)
-			return false;
-		if (op->addr.nbytes && op->addr.buswidth > 1)
-			return false;
-	} else {
+	} else if (!all_false) {
 		/* Mixed DTR modes are not supported. */
 		return false;
 	}
-- 
2.25.1

