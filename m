Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4E588E67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiHCORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiHCORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:17:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9262E9;
        Wed,  3 Aug 2022 07:17:30 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27395h4c002458;
        Wed, 3 Aug 2022 16:17:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=dLbYuk3X5M04hPQKvyKFVfwoO8OZvzn9q4E7erryQrg=;
 b=x8ehuz9cGyzJX1eBEijaILUCum2JOvHPF2SAouYI/6Ab/q509llDCoEF4KiyUJzMKqo7
 oY5mlYWc+1LqYuBbTHOc8MhTKDt+E7f436xCetBH5dpoiSMM7oTGlLB5LkS8tWFHa5It
 lKRDuh6FTAOAEULZO9ldB+32Iy0MkrSdclUwoVE+3UIF5kLJB+x66xUNMNQWc+syNoF3
 yYUAty8XK2vsorIqmODltdfgamTNLZb5zIeUCIYxMZB5etuE5Fbgo6uN59oJcU3rSISa
 YKXvuE5KB6RO6L275riz4EztVlklhpiOtKbBAbOLSI4NFw35U5FwNLGxtLvw26UdA2QN 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hq06ktekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 16:17:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 987C3100039;
        Wed,  3 Aug 2022 16:17:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 938EE2248C9;
        Wed,  3 Aug 2022 16:17:02 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 3 Aug
 2022 16:17:02 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 3/3] spi: stm32-qspi: Remove unused stm32_qspi_wait_cmd() parameter
Date:   Wed, 3 Aug 2022 16:16:57 +0200
Message-ID: <20220803141657.301793-4-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803141657.301793-1-patrice.chotard@foss.st.com>
References: <20220803141657.301793-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

struct spi_mem_op *op parameter is no more used, remove it.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 622d1442a9b7..f3fe92300639 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -299,8 +299,7 @@ static int stm32_qspi_wait_nobusy(struct stm32_qspi *qspi)
 						 STM32_BUSY_TIMEOUT_US);
 }
 
-static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
-			       const struct spi_mem_op *op)
+static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
 {
 	u32 cr, sr;
 	int err = 0;
@@ -419,7 +418,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 		goto abort;
 
 	/* wait end of tx in indirect mode */
-	err = stm32_qspi_wait_cmd(qspi, op);
+	err = stm32_qspi_wait_cmd(qspi);
 	if (err)
 		goto abort;
 
-- 
2.25.1

