Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2E475A84
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhLOOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:18:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60890 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237613AbhLOOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:18:23 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFAOoxL015895;
        Wed, 15 Dec 2021 15:17:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=do/02SlyNQ2+a/wzGPh8B/PB1HnlUOgEgfqJOwrlJMQ=;
 b=NE9yFbuy++muTva/j7V/fjsq4AqxbMX3E3lC/Yfg+BTr9yuZjgwKiVYY0msnnL4gia4h
 i2rrKFBvO89NKtzHWFJ8oC9iPQdVzX+2Yj48c8vlUr0nE+waB8ick/slqdyt9Vdq/V8u
 Eghz7r0BD+pz+CsozE2b4YuMyAFok70V21stuolRUfjkukAOrWWgomLBqaIXUoLLJLs5
 DevNEslNESPmutRvu7Xpu0cvZNHQp8bIBfSUFoWSr/zsZXi3/K13VaZrNMUm+uoKTNSd
 G8X7t4j+LvYvJpXZBAFfjp1FCDk3Cqjb34TdMjDxZHAKJsR+9oe5ee0i85LSw48ItHan Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyeka95m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 15:17:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AA2C10002A;
        Wed, 15 Dec 2021 15:17:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62B0D21EB8F;
        Wed, 15 Dec 2021 15:17:56 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 15:17:55
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
Subject: [PATCH 3/4] mmc: mmci: stm32: clear DLYB_CR after sending tuning command
Date:   Wed, 15 Dec 2021 15:17:26 +0100
Message-ID: <20211215141727.4901-4-yann.gautier@foss.st.com>
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

During test campaign, and especially after several unbind/bind sequences,
it has been seen that the SD-card on SDMMC1 thread could freeze.
The freeze always appear on a CMD23 following a CMD19.
Checking SDMMC internal registers shows that the tuning command (CMD19)
has failed.
The freeze is then due to the delay block involved in the tuning sequence.
To correct this, clear the delay block register DLYB_CR register after
the tuning commands.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index fdaa11f92fe6..a75d3dd34d18 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -441,6 +441,8 @@ static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
 		return -EINVAL;
 	}
 
+	writel_relaxed(0, dlyb->base + DLYB_CR);
+
 	phase = end_of_len - max_len / 2;
 	sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
 
-- 
2.17.1

