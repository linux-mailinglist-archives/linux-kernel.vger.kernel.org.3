Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EC48653C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiAFNXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:23:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46372 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239337AbiAFNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:23:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20683sij011437;
        Thu, 6 Jan 2022 14:22:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=GXNow/WGCNS6VVfniMqNqO7XFYKxdCU9IcX7ReUi5Ig=;
 b=7WCqrJph1nk6Rds7gdVixNTL61WhNlAQ+8j0n33ji7P9yRQ8jqTl/WVDzJknzvC5riLT
 JzVrzPGjIPLFWEnfNKS4ECYgbbxalb0pEOnU0OaVhlG0tsnC0m5hFk5Uwi1gzB44IFWE
 pRL0lVNYuC9MacEMHVlykogS2pD2qDrhCc+cGfhO9Xx+DaWmztDPA0w6WVliG0GO5kUm
 rbHRnGFxU9hBwJwY31QTf1OVcI/MD9lqT1tugu4p9hkN6GXXiWGpPPT08mhxY4PAgJZH
 pij525yUn4f20kraWJ2hYGqqxaKi5SvJJAzeyteu2hiQYxxM7i10ymHvMz9M3E0Rk9GJ vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ddmqubbfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 14:22:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9766B10002A;
        Thu,  6 Jan 2022 14:22:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C5C924DE9D;
        Thu,  6 Jan 2022 14:22:49 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 14:22:49
 +0100
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: spi: stm32-qspi: Update spi registering
Date:   Thu, 6 Jan 2022 14:20:52 +0100
Message-ID: <20220106132052.7227-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_05,2022-01-06_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Replace devm_spi_register_master() by spi_register_master() to ensure
that spi sub-nodes are unregistered in the correct order when qspi driver
is removed.
This issue was put in evidence using kernel v5.11 and later
with a spi-nor which supports the software reset feature introduced
by commit d73ee7534cc5 ("mtd: spi-nor: core: perform a Soft Reset on shutdown")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 514337c86d2c..db005443aa7c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -784,7 +784,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 
-	ret = devm_spi_register_master(dev, ctrl);
+	ret = spi_register_master(ctrl);
 	if (ret)
 		goto err_pm_runtime_free;
 
@@ -817,6 +817,7 @@ static int stm32_qspi_remove(struct platform_device *pdev)
 	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(qspi->dev);
+	spi_unregister_master(qspi->ctrl);
 	/* disable qspi */
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	stm32_qspi_dma_free(qspi);
-- 
2.17.1

