Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087DA4F6430
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiDFQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B525E324;
        Wed,  6 Apr 2022 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649251733; x=1680787733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Czi26NrfwMoH/x1j5H0r+4QfXvJ3RCxa8l9zjCCm750=;
  b=PEhPxBL1wxXwuWew6OqpROWADo9iY23YxrjJ5f3bFPyJeRGeHKsvay8i
   z+cAyuV91pUdBoi+hkjfnyPLO8Kieq+71Tlk7P6RM+IhfJEv6EVHK9j0o
   BqRTcFq8gJE/sdsXCHkwYRc3BIbn+Dz70PBw/o8sD0ag7tB2CFO4yJf1l
   AiaeRDwV+kzece0hzbQs6WYZsMghDan5xRm8KZcoQ7j+fcddBK9n+nszE
   X8UUjy6juSYHWtcJMwVIO1cClGLfvOP4ik10QT6mo9ZW7+WUnmje5sHiT
   yE+M3XZD0RITtMv+H/w7CodCk7kuyGg/rUatPWK20ENqxT7VMNpMwBRnK
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643670000"; 
   d="scan'208";a="23132845"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Apr 2022 15:28:51 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Apr 2022 15:28:51 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Apr 2022 15:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649251731; x=1680787731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Czi26NrfwMoH/x1j5H0r+4QfXvJ3RCxa8l9zjCCm750=;
  b=duaJpFpIUmkCqo80X4zugsdBh+HlqbekiXO9a8eDBymJgQfvo+fcTeyE
   pgORznI20if+Nn63Af9yNITceu5sCa1uLeLYR0B2HA+w7erjGc4x5JR7j
   2CZUxBjn0v5ftkdlssGbx2MAaU0ZcglTMJtxhPHxoYAtTtJ844JmUet7g
   mpXtsFMaRBIUQvYdnhPabiKGggiGVPPzy1IQpkEkDexq4vTXa4lzTK+8M
   abxeYZ3v75iOWWQO65yjxpCR0s3aa4srXQxJbsKtU/en+427sOkcNUVOa
   4HfaBVUYJ+Jm+8+Ps2bHeqFaFkDLuRiYvJWhwg4Fn73J+OkAj3yJ84NWV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643670000"; 
   d="scan'208";a="23132844"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Apr 2022 15:28:51 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 30966280065;
        Wed,  6 Apr 2022 15:28:51 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] spi: cadence-quadspi: fix incorrect supports_op() return value
Date:   Wed,  6 Apr 2022 15:28:32 +0200
Message-Id: <20220406132832.199777-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the conversion to spi-mem, the driver advertised support for
various operations that cqspi_set_protocol() was never expected to handle
correctly - in particuar all non-DTR operations with command or address
buswidth > 1. For DTR, all operations except for 8-8-8 would fail, as
cqspi_set_protocol() returns -EINVAL.

In non-DTR mode, this resulted in data corruption for SPI-NOR flashes that
support such operations. As a minimal fix that can be backported to stable
kernels, simply disallow the unsupported operations again to avoid this
issue.

Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

As discussed, here's the minimal fix to disallow the accidentally enabled
1-X-X and X-X-X operations again. As a bonus, I also added proper handling
for non-8-8-8 DTR ops to cqspi_supports_mem_op() to avoid -EINVAL in
cqspi_set_protocol() for these ops.

The patch is based on spi for-5.18 now. It will unfortunately not
cherry-pick cleanly to 5.10 and 5.15, but I can take care of submitting a
backport patch once this is in Linus's tree.

I also have patches for 5.19/next that add proper support for 1-X-X and
X-X-X (without DTR for now, as I haven't tested DTR), which remove most
of the code of cqspi_set_protocol(). I will submit the follow-up patches
once this fix patch is accepted.


 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b0c9f62ccefb..c898321d4e94 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1437,9 +1437,24 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
 		    !op->data.dtr;
 
-	/* Mixed DTR modes not supported. */
-	if (!(all_true || all_false))
+	if (all_true) {
+		/* Right now we only support 8-8-8 DTR mode. */
+		if (op->cmd.nbytes && op->cmd.buswidth != 8)
+			return false;
+		if (op->addr.nbytes && op->addr.buswidth != 8)
+			return false;
+		if (op->data.nbytes && op->data.buswidth != 8)
+			return false;
+	} else if (all_false) {
+		/* Only 1-1-X ops are supported without DTR */
+		if (op->cmd.nbytes && op->cmd.buswidth > 1)
+			return false;
+		if (op->addr.nbytes && op->addr.buswidth > 1)
+			return false;
+	} else {
+		/* Mixed DTR modes are not supported. */
 		return false;
+	}
 
 	return spi_mem_default_supports_op(mem, op);
 }
-- 
2.25.1

