Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A190475A80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhLOOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:18:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33392 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237528AbhLOOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:18:22 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF9JQ9C011420;
        Wed, 15 Dec 2021 15:17:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=KgEN0FRgdT1cJ5AXMmY5RUzHd3EhRYCA7X2wqmj5vvc=;
 b=6Wp+V5vYPW9IY1+KGwifxkAD+hGrekVz5qWE4W2E2hcgDf/mgYPodhklJwSqUTUva/Pb
 rj0gpzXoTA5oJq9f2UoB6PmWN9IIqV/HF08ZsdKXVf3VnaXXTKlJGnc538QCN35RtqU3
 QBFHlsmQMwjsCT6PThphksFG5wzcjOA31LxSOUO5rdyZrITeq9HTUS/a53BKyn5pYe2g
 reTW9GWlRGJIRqjWYOVzF7UU7fdiJswCmp25mmekdT+vVbyocaMX7TNBY2G6XxBa4VFJ
 3IfSkMmrop3JSnmm5AL83ix8nT6NF7wAkAuDVlTjr0r9hZZEif2Ud6qqp0XkrfDgg1/+ 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cy79j42k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 15:17:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 29465100034;
        Wed, 15 Dec 2021 15:17:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20EC621EB8F;
        Wed, 15 Dec 2021 15:17:57 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 15:17:56
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 4/4] mmc: mmci: add hs200 support for stm32 sdmmc
Date:   Wed, 15 Dec 2021 15:17:27 +0100
Message-ID: <20211215141727.4901-5-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_09,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use feedback clock for HS200 mode, as for SDR104.
The HS200 mode can be enabled through DT by using mmc-hs200-1_8v.
It is possible to use it on STM32MP13, but not STM32MP15 platforms.

Signed-off-by: Ludovic Barre <ludovic.barre@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index a75d3dd34d18..9c13f2c31365 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -241,11 +241,12 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
 
 	/*
 	 * SDMMC_FBCK is selected when an external Delay Block is needed
-	 * with SDR104.
+	 * with SDR104 or HS200.
 	 */
 	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
 		clk |= MCI_STM32_CLK_BUSSPEED;
-		if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104) {
+		if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104 ||
+		    host->mmc->ios.timing == MMC_TIMING_MMC_HS200) {
 			clk &= ~MCI_STM32_CLK_SEL_MSK;
 			clk |= MCI_STM32_CLK_SELFBCK;
 		}
-- 
2.17.1

