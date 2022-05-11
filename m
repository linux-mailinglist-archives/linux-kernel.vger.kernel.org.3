Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CD6522D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiEKHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbiEKHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:47:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A66EC6E;
        Wed, 11 May 2022 00:47:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B6m0iI032615;
        Wed, 11 May 2022 09:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=j/DyzE+naJ1AnO/Sannl9gKpYXXGK+B/WTEOEOIvbTY=;
 b=VfYuBqDxFhD7N9Q4guNQyVeT8zYXR0FeZ/3QWiMF1FQpGQnle+2ARmkDTdEvXwrWMn69
 O/NdOgLp+6qzQiF7U2126eb3CCOs7wNZJAqAYpwXtH9tpYl/6NCkDWqAET21GzrbHDHy
 O8YT+sBw/HrLLul5pu9q7jgmmso0iqPmjLnEgTiHLqsNxqI/hJ2B9xGlfYmfWkqiZh3H
 x0vnSP/g3hZrbwfxAWvaI9v9lC3CImhoRNN+ZG1oSXHEpRj0eiaMeNn87xZ5XL7QwuMs
 KAg70hOhdB2xLTvWMxBezVliUdH2W79EdoREG2ctK7XdomcIHIiRPlB40MgO4rfDyYle vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwg415695-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 09:47:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3156610002A;
        Wed, 11 May 2022 09:47:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AB2A2128DB;
        Wed, 11 May 2022 09:47:03 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 11 May
 2022 09:47:02 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 2/3] spi: stm32-qspi: Always check SR_TCF flags in stm32_qspi_wait_cmd()
Date:   Wed, 11 May 2022 09:46:43 +0200
Message-ID: <20220511074644.558874-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511074644.558874-1-patrice.chotard@foss.st.com>
References: <20220511074644.558874-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_02,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Currently, SR_TCF flag is checked in case there is data, this criteria
is not correct.

SR_TCF flags is set when programmed number of bytes has been transferred
to the memory device ("bytes" comprised command and data send to the
SPI device).
So even if there is no data, we must check SR_TCF flag.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 12d8bec35bf6..1660ca5bd1c5 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -305,9 +305,6 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	u32 cr, sr;
 	int err = 0;
 
-	if (!op->data.nbytes)
-		goto wait_nobusy;
-
 	if ((readl_relaxed(qspi->io_base + QSPI_SR) & SR_TCF) ||
 	    qspi->fmode == CCR_FMODE_APM)
 		goto out;
@@ -328,7 +325,6 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 out:
 	/* clear flags */
 	writel_relaxed(FCR_CTCF | FCR_CTEF, qspi->io_base + QSPI_FCR);
-wait_nobusy:
 	if (!err)
 		err = stm32_qspi_wait_nobusy(qspi);
 
-- 
2.25.1

