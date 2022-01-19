Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A01493761
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351755AbiASJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:33:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34464 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234544AbiASJdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:33:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J8MJq3014974;
        Wed, 19 Jan 2022 10:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Vz5Z00wN5zPjPO1SANvL9AXqgyIwOm0yfPV4ilWMIWI=;
 b=yhCwni+ENghLAF4NeUwjEY26pxzdzd1+ZEGGXBI4PUPMGXprekNh+nYp+CDvw4o0kwoS
 bH8a+IB6AvuACGo3kmXfX58RUKXI3y64Fa+YIGS2BXdVvp/oPtWqK4u7PW1hH8eS1U+z
 +aVgr9dcbtcoxvUjVBocaSdFA24vmk9qY1lMmeW+KVfASguf/BBuJiYYjnMRzcqYVX8v
 dUAYzsYDWCSJ1kzA7X71dTlb4wOVA4Z9dGcB7mEpVrJFdrMhuoD4+hONSa3IXOPJd2DW
 W9xb55E2Kb8tRyx45vv8+4NiC7RYPBKUHZyydE+OD6TSbQOomYp5uwGNH98RrdNI70sK fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dpf2v8f73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:33:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58B5F100038;
        Wed, 19 Jan 2022 10:33:15 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node5.st.com [10.75.127.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F26C20ED10;
        Wed, 19 Jan 2022 10:33:15 +0100 (CET)
Received: from localhost (10.75.127.51) by GPXDAG2NODE5.st.com (10.75.127.69)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 19 Jan 2022 10:33:14
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 2/2] spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4
Date:   Wed, 19 Jan 2022 10:32:45 +0100
Message-ID: <20220119093245.624878-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119093245.624878-1-alain.volmat@foss.st.com>
References: <20220119093245.624878-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To GPXDAG2NODE5.st.com
 (10.75.127.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 61367d0b8f5e ("spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4")
allowed to properly communicate with the st-gyro-spi even when
there is no tx_buf provided by setting the flag SPI_MASTER_MUST_TX and
thus forcing a dummy TX buffer to work in Full Duplex.
This behavior should kept only for the STM32F4 and not for other
compatible since the STM32H7 do support SIMPLEX_RX and SIMPLEX_TX.
Add the flags variable within the struct stm32_spi_cfg so that flags
used at master registration time are compatible specific.

Fixes: 61367d0b8f5e ("spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4")

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b5ef2470cefe..7fc24505a72c 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -231,6 +231,7 @@ struct stm32_spi;
  * @baud_rate_div_min: minimum baud rate divisor
  * @baud_rate_div_max: maximum baud rate divisor
  * @has_fifo: boolean to know if fifo is used for driver
+ * @flags: compatible specific SPI controller flags used at registration time
  */
 struct stm32_spi_cfg {
 	const struct stm32_spi_regspec *regs;
@@ -251,6 +252,7 @@ struct stm32_spi_cfg {
 	unsigned int baud_rate_div_min;
 	unsigned int baud_rate_div_max;
 	bool has_fifo;
+	u16 flags;
 };
 
 /**
@@ -1720,6 +1722,7 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.baud_rate_div_min = STM32F4_SPI_BR_DIV_MIN,
 	.baud_rate_div_max = STM32F4_SPI_BR_DIV_MAX,
 	.has_fifo = false,
+	.flags = SPI_MASTER_MUST_TX,
 };
 
 static const struct stm32_spi_cfg stm32h7_spi_cfg = {
@@ -1852,7 +1855,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
-	master->flags = SPI_MASTER_MUST_TX;
+	master->flags = spi->cfg->flags;
 
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
-- 
2.25.1

