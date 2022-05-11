Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA78952323D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiEKLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbiEKLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:55:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78912438E1;
        Wed, 11 May 2022 04:55:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24BBtIwB035581;
        Wed, 11 May 2022 06:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652270118;
        bh=f0uhcvsc+1kbeZtPp/p/m0PHcJZMWJuiePiXoa4pIJs=;
        h=From:To:CC:Subject:Date;
        b=o6QAvTD2dy4L5RAa4v/2ENw5yO4p7PNiDDi/azRcfv86SOgVtHtCCWDpDlmPyIBsz
         vH4DVWGWXe3Uk414mehjqj5z9NyOeS+vKMuxO3JkoRBFTYPezaLqCO2tfSIoG/qmKH
         ehqc2lo/srBLFe7/13oPvKoxFdvgSS/qgZZzsa6g=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24BBtI3x094140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 May 2022 06:55:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 11
 May 2022 06:55:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 11 May 2022 06:55:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24BBtG9n039452;
        Wed, 11 May 2022 06:55:17 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vigneshr@ti.com>, <p.yadav@ti.com>, <j-keerthy@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH] drivers: spi: cadence-quadspi: Handle spi_unregister_master() in remove()
Date:   Wed, 11 May 2022 17:25:16 +0530
Message-ID: <20220511115516.14894-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently devres managed removal of the spi_controller happens after
removing the power domain of the host platform_device.While this
does not affect the clean removal of the controller, but affects
graceful removal of the child devices if the child  device removal
requires issuing commands over SPI.

Eg. flash device being soft reset to 1S-1S-1S mode before removal
so that on next probe operations in 1S-1S-1S mode is successful.

Failure is seen when `rmmod spi-cadence-quadspi` is performed:

root@j7-evm:~# rmmod spi_cadence_quadspi
[ 49.230996] cadence-qspi 47050000.spi: QSPI is still busy after 500ms timeout.
[ 49.238209] spi-nor spi1.0: operation failed with -110
[ 49.244457] spi-nor spi1.0: Software reset failed: -110

and on subsequent modprobe the OSPI flash probe fails as it
is in 8D-8D-8D mode since the previous soft reset did not happen.

root@j7-evm:~# modprobe spi_cadence_quadspi
[ 73.253536] spi-nor spi0.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
[ 73.260476] spi-nor: probe of spi0.0 failed with error -2

This commit adds necessary changes to perform spi_unregister_master()
in the host device remove() so that the child devices are gracefully
removed before the power domain is removed.

changes tested on J721E with mt35xu512aba flash.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 19686fb47bb3..baf8559b553b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -62,7 +62,7 @@ struct cqspi_flash_pdata {
 
 struct cqspi_st {
 	struct platform_device	*pdev;
-
+	struct spi_master	*master;
 	struct clk		*clk;
 	unsigned int		sclk;
 
@@ -1639,7 +1639,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*cqspi));
 	if (!master) {
 		dev_err(&pdev->dev, "spi_alloc_master failed\n");
 		return -ENOMEM;
@@ -1652,6 +1652,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi = spi_master_get_devdata(master);
 
 	cqspi->pdev = pdev;
+	cqspi->master = master;
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1784,7 +1785,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_spi_register_master(dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
 		goto probe_setup_failed;
@@ -1807,6 +1808,7 @@ static int cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	spi_unregister_master(cqspi->master);
 	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
-- 
2.17.1

