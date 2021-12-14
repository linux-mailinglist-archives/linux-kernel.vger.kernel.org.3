Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22E474103
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhLNLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:02:01 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7721 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhLNLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639479717; x=1671015717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lDbdt0qppU9wkR9JXAW96NVTHS8jtIsFV54SHK4VGNA=;
  b=LgFx10sKd4YePLwwZlzI89nWQwHrcv45K1a2m6BgL8r+pBrknpL0wDWc
   s0Ri50fJkFIOXapEwKS6TfkMWXV9kNw0yTnloZdByA//6/YTbrWw/By6w
   YNiozGRcMVzc1cwUGKtgrBabfxBDIGyfU7dtIlvFN1quj2J/7rh+X88rp
   omc2ruimiE8f5QM80JTTv3r4PNA3ZgyIhFWTueBCTaVozYCW7YF8BWZoH
   6S6ECfUboE9bC2LNBW8+jHhERQlUTOzgmXAyjPElM2SiWQ7sIyyXpOJIK
   I1M5/lQDrYAwedrI2szXvF89VaG/HX0f/f8foeVvzmWAcP/rEsP7yclt+
   w==;
IronPort-SDR: o2YKEReHwzPyFz5QsrEnnujmBmVcUJLvqZlQoDOyLGM2S8C3xkwr65CiQOcTcoC+aN1UBpwFjA
 mxa5QWLAgDkgvjY+XZSmU1rwk/RsIf/9bO+NeZ5mkCTcITB4adSjdRu/Fg0h5BNlnfXt0IaXNa
 5yajRD8dBWZ5oI41bCeBTiFS29JPmd17Z76Lg2N7BDgTX0iDZbdbOgKEEg7dre/6AobSDGoD0Y
 5V8R59H3dUbs6AGn3A+xzCDsONx/T4dYfZPkvetWJjjZ17XA8Nfe7tHbj4tYQy6dAPgcA55IHm
 ty6GBVZMe0VybKrpbttpilVZ
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="155413484"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2021 04:01:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Dec 2021 04:01:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 14 Dec 2021 04:01:54 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <quanyang.wang@windriver.com>,
        <amit.kumar-mahapatra@xilinx.com>
CC:     <michal.simek@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] Revert "spi: spi-zynqmp-gqspi: add mutex locking for exec_op"
Date:   Tue, 14 Dec 2021 13:01:51 +0200
Message-ID: <20211214110152.48316-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
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

