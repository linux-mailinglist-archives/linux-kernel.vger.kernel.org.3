Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8F50671F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbiDSIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbiDSIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:49:56 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D11DA5F;
        Tue, 19 Apr 2022 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650358034; x=1681894034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmtUmX9TsVdQnWmEZl+ibd5oWqIkKPblhcl2o3QfvF0=;
  b=MHlLkr+KP0nfuBc3YHIlNBCnlK8plBYD0A9Ahvt/Wr4jHFQ7mbVTrhGo
   TizCLDNlI7zh99nhOgZ8leQot2ya8jlDMB2qI8PqiXdUG7eBFM0EnnGM8
   RXSIFXRHNBQGgivFA9nUCJ157/2xEi/jzwrE1ebDvDUFKf9oxoDHMknkY
   lSYMyjCLU6H8cSCQtyK5dlRPXeqyU6F7/P8xqXvtIlVkUdi70WrUVvtkg
   4LX60wSfndMYYakZcG9WkYGP8hVRCrOoBWZejZyqLzzx5jneG6RLA71pf
   Tc4bxt9OhZ3kHMwwLXgc3b55IQbQwe9tNNbrLgxyeYpHJKy1PIk2v+2Z6
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23351063"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Apr 2022 10:47:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 19 Apr 2022 10:47:09 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 19 Apr 2022 10:47:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650358029; x=1681894029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmtUmX9TsVdQnWmEZl+ibd5oWqIkKPblhcl2o3QfvF0=;
  b=PmJlmtyeml1T/3hMMy7BHykfYDtq+L1iy8xf1Nlj9j/kqfsDYfEMHEFA
   s8n7Eh9bbwOsELAAdqUzfs+luCJBiJS/38ifLo2dmRQmmoGAl9aaVXzkV
   GRjSBFE2Pp7fHzG9feDhueZMRI2wT0MN4I2eoWqYX/H6LRLNq5qFOmxKJ
   kHWyKdVhAjzMw9EAxXCWrhCNYhJpW98NA4kYTDdeBXe78SRBLrRHZNMiV
   BHnX30w3+dZXRXr+hLzse8VZtZUjeTyzdE/dwCaAyepxPe2F3TYCX//zs
   JTCo78Ur7R1TWoVt7p3EyaxVygYDXJdyp2gA6ubETxEIN1vmp1QjdiiuS
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23351046"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Apr 2022 10:47:02 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 013C8280075;
        Tue, 19 Apr 2022 10:46:57 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: allow operations with cmd/addr buswidth >1
Date:   Tue, 19 Apr 2022 10:46:40 +0200
Message-Id: <20220419084640.191299-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419084640.191299-1-matthias.schiffer@ew.tq-group.com>
References: <20220419084640.191299-1-matthias.schiffer@ew.tq-group.com>
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

With the improved cqspi_set_protocol(), ops with cmd/addr
buswidth >1 are now working correctly.

Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash using 1-4-4
operations.

DTR operations are currently untested, so we leave them disabled for now
(except for the previosly allowed 8-8-8 ops).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 96d14f3847b5..08f39f52e32a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1370,13 +1370,7 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
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

