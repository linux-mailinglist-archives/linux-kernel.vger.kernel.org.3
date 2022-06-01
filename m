Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32E539DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiFAHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350951AbiFAHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:16:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1C9D076;
        Wed,  1 Jun 2022 00:16:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2517GDPm002488;
        Wed, 1 Jun 2022 02:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654067773;
        bh=mpZtlGZNYZkzKrIar+gOtdyJV1Br8CEFg9AwOfSIA8I=;
        h=From:To:CC:Subject:Date;
        b=LcJvdYGHWq5GNJvZS+CX77ExQNj4i2IvmbJ18nlrQX2xWA/BJCSfz4iPu/+c40LXb
         Be/ZV1Pz98/8zES/C4V4Dw4FUfEtceP9bnNEAaauEeVIE7jxLPXYzp52c0r39xu6FC
         aY0uPhiofmT9Idvb2FDl9L4ieJ2CgLUmVdMO3PoM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2517GDOn091123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jun 2022 02:16:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 1
 Jun 2022 02:16:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 1 Jun 2022 02:16:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2517GBnC070231;
        Wed, 1 Jun 2022 02:16:12 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <vaishnav.a@ti.com>, <p.yadav@ti.com>, <vigneshr@ti.com>
Subject: [PATCH -next] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
Date:   Wed, 1 Jun 2022 12:46:11 +0530
Message-ID: <20220601071611.11853-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the spi_master is allocated by devm_spi_alloc_master()
and devres core manages the deallocation, but in probe failure
path spi_master_put() is being handled manually which causes
"refcount underflow use-after-free" warning when probe failure happens
after allocating spi_master.

Trimmed backtrace during failure:

refcount_t: underflow; use-after-free.
pc : refcount_warn_saturate+0xf4/0x144
Call trace:
refcount_warn_saturate
kobject_put
put_device
devm_spi_release_controller
devres_release_all

This commit makes relevant changes to remove spi_master_put() from probe
failure path.

Fixes: 606e5d408184 ("spi: cadence-quadspi: Handle spi_unregister_master() in remove()")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2b9fc8449a62..72b1a5a2298c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1578,8 +1578,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = cqspi_of_get_pdata(cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot get mandatory OF data.\n");
-		ret = -ENODEV;
-		goto probe_master_put;
+		return -ENODEV;
 	}
 
 	/* Obtain QSPI clock. */
@@ -1587,7 +1586,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(cqspi->clk)) {
 		dev_err(dev, "Cannot claim QSPI clock.\n");
 		ret = PTR_ERR(cqspi->clk);
-		goto probe_master_put;
+		return ret;
 	}
 
 	/* Obtain and remap controller address. */
@@ -1596,7 +1595,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(cqspi->iobase)) {
 		dev_err(dev, "Cannot remap controller address.\n");
 		ret = PTR_ERR(cqspi->iobase);
-		goto probe_master_put;
+		return ret;
 	}
 
 	/* Obtain and remap AHB address. */
@@ -1605,7 +1604,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(cqspi->ahb_base)) {
 		dev_err(dev, "Cannot remap AHB address.\n");
 		ret = PTR_ERR(cqspi->ahb_base);
-		goto probe_master_put;
+		return ret;
 	}
 	cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
 	cqspi->ahb_size = resource_size(res_ahb);
@@ -1614,15 +1613,13 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	/* Obtain IRQ line. */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = -ENXIO;
-		goto probe_master_put;
-	}
+	if (irq < 0)
+		return -ENXIO;
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
-		goto probe_master_put;
+		return ret;
 
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
@@ -1716,8 +1713,6 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_clk_failed:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-probe_master_put:
-	spi_master_put(master);
 	return ret;
 }
 
-- 
2.17.1

