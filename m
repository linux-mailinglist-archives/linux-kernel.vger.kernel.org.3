Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42534CD58C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiCDNxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCDNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:53:27 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765F33EB9;
        Fri,  4 Mar 2022 05:52:37 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224BrQTP011332;
        Fri, 4 Mar 2022 14:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=tbU0qOc6Ayx6hnhXQ94zwIDGkMujBZbQs9NbPVdBY5A=;
 b=xTD9vKiQCmfnFprZmglcB5VgO+UPllnPsraMHR7AjH/CQpzG459UvGxKnuppKF7l3phZ
 O5DrbC4o7iq/H/OHufsZQu25IFcemolPNTOK+y3iprzO4ek4r7m0kqOFSGZX5XYIjjAb
 AX4jJbPI9lpjQs0I9JEGu1LeMT3IddwRABqkJiMVBVNhnUCaUsnMQigYTy17CP/Mlvcr
 1Go75TThmKHtS8jbmBRCVHJhmQjNMkx2rsHpujwkyYwZFISvdr/Y9kOshHoV/T8Jpp+v
 bGKh0kpEr7M1rx8PZ/g7guIEhZNtXz8V0waxHONJL24IYvNfBmpwj3GIza4raQAvZgi/ zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ek4k5d52b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:51:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59220100038;
        Fri,  4 Mar 2022 14:51:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2741C2291CC;
        Fri,  4 Mar 2022 14:51:45 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Mar 2022 14:51:44
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 3/3] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
Date:   Fri, 4 Mar 2022 14:51:34 +0100
Message-ID: <20220304135134.47827-4-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304135134.47827-1-yann.gautier@foss.st.com>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a disable_keep_power field in variant_data struct. The
MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
It is only set to true for stm32_sdmmc variants.

The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
It doesn't correctly support low power, and we need to unbind the wifi
driver before a suspend sequence. But the wifi chip firmware is then
lost, and the communication with SDIO fails if MMC_PM_KEEP_POWER is
enabled.
The flag can still be enabled through DT property: keep-power-in-suspend.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.c | 5 ++++-
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 45b8608c935c..0e2f2f5d6a52 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -274,6 +274,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
 	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.disable_keep_power	= true,
 	.init			= sdmmc_variant_init,
 };
 
@@ -301,6 +302,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
 	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.disable_keep_power	= true,
 	.init			= sdmmc_variant_init,
 };
 
@@ -2172,7 +2174,8 @@ static int mmci_probe(struct amba_device *dev,
 	host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
 
 	/* We support these PM capabilities. */
-	mmc->pm_caps |= MMC_PM_KEEP_POWER;
+	if (!variant->disable_keep_power)
+		mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
 	/*
 	 * We can do SGIO
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e1a9b96a3396..2cad1ef9766a 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -361,6 +361,7 @@ struct variant_data {
 	u32			opendrain;
 	u8			dma_lli:1;
 	u32			stm32_idmabsize_mask;
+	u8			disable_keep_power:1;
 	void (*init)(struct mmci_host *host);
 };
 
-- 
2.25.1

