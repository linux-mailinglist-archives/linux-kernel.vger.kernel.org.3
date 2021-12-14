Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D72474104
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhLNLCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:02:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7721 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhLNLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639479719; x=1671015719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDbdt0qppU9wkR9JXAW96NVTHS8jtIsFV54SHK4VGNA=;
  b=FXN55r4FiuytVnljFcBsjf4TO66fKmgzoyZgCSr+9sxuGoZBkS1eisOQ
   RwGWHtmWhJ6OtQTOpxmJlOz+Je1zIIAkn6RT+dIHTDmYX2vcGS+95kQS7
   8+FpREHpfGB9Ft0hUHjUrpclUFf5obRgMLhBV8Wqfqq0dIfNea5h/dLzW
   ssRI2WmdsVJJGrSOqam4UEvgXv9qD+MkEg8TMNNlNknrwSQgkWnP3WBmC
   WWM/0uuJeiPr3txFx8ZffxuQc9fgbv3Hvdr39x2uc4GJe/tGCzuaIeONN
   dVbqsAcnInh+t+nDx88yxbJHWNmfYH7Gq0ckwkpYdkVXyikvTOIwgY/e3
   A==;
IronPort-SDR: na9vk+T6vMPwaRIF0TaHjTbid5V+jm7SnUvvLGkVSeET5HFRjTA5au+2yq5n1kF4UHGbRAGCVN
 o5zVHni4p6BuoRGUgnctXG4f6kt8LtQP6xiqFmEDMeAZndDzRqa5VwB8qQlfGblqMp0GctUFxd
 FmbdD4k4RlmyFf0OzkdqVbqW2O690gZ1sQOcEV1GjnftEmxaaO1uVqi5XHHCiK52GN40i8EffT
 Ba1K6HgyyqbbEP/iSLTVHmBFV76oTnkzygDUhlovEJ9A9Lp4kQkSID5upaHupUHytls7QnQBKw
 SZz67F+ZWYnLmaUyCCCp7XvE
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="155413491"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2021 04:01:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Dec 2021 04:01:59 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 14 Dec 2021 04:01:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <quanyang.wang@windriver.com>,
        <amit.kumar-mahapatra@xilinx.com>
CC:     <michal.simek@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] Revert "spi: spi-zynqmp-gqspi: add mutex locking for exec_op"
Date:   Tue, 14 Dec 2021 13:01:52 +0200
Message-ID: <20211214110152.48316-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214110152.48316-1-tudor.ambarus@microchip.com>
References: <20211214110152.48316-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a0f65be6e880a14d3445b75e7dc03d7d015fc922.

SPIMEM uses ctlr->bus_lock_mutex to prevent concurrency on
ctlr->mem_ops->exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 328b6559bb19..189fe4eb59ad 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -174,7 +174,6 @@ struct zynqmp_qspi {
 	u32 genfifoentry;
 	enum mode_type mode;
 	struct completion data_completion;
-	struct mutex op_lock;
 };
 
 /**
@@ -946,7 +945,6 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
 		op->dummy.buswidth, op->data.buswidth);
 
-	mutex_lock(&xqspi->op_lock);
 	zynqmp_qspi_config_op(xqspi, mem->spi);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
@@ -1069,7 +1067,6 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 return_err:
 
 	zynqmp_qspi_chipselect(mem->spi, true);
-	mutex_unlock(&xqspi->op_lock);
 
 	return err;
 }
@@ -1143,8 +1140,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&xqspi->data_completion);
 
-	mutex_init(&xqspi->op_lock);
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
-- 
2.25.1

