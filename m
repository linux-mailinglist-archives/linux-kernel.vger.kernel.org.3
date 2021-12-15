Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F25475A88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbhLOOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:18:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36106 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243292AbhLOOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:18:23 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFBf3DC026365;
        Wed, 15 Dec 2021 15:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=av9SREGRIP3BmGxg7nqmThmWDEKblw7r0lH+mZ9Ul9w=;
 b=rEDw3AhrFntwmEgHZNMhDhSHUQn5SIJti1sayN5WzG50wv5BqtT3leYvWcW+ZDeVmzbC
 CACX0pz1ixN2pc33je7+wu92/VgJRw02ETlYEYzjenpatRjaacflTV9shvoXq9v+WomV
 y7y+ADQ4B/6FNAoLp8YqDNu+j4zhkKcz5v6EE1iUSync6o+G8Eqkma9+5P0n1mjs5Rho
 9uyhj3cRHViM5dSZUqrl+9R+7i3YxeZu2UowJ90PJF2xr2H+1vGRNPgd1bAbPP4nR2x+
 RQmq0DEBI3hihGIuoDzLDvrH45+wn1RKQqpbIvi+YCGIEqfEgISxBMfffUImbXCxDDB8 Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyfpxgs9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 15:17:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7244100038;
        Wed, 15 Dec 2021 15:17:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCBDE21EB8F;
        Wed, 15 Dec 2021 15:17:54 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 15:17:54
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
Subject: [PATCH 1/4] mmc: mmci: Add support for sdmmc variant revision v2.2
Date:   Wed, 15 Dec 2021 15:17:24 +0100
Message-ID: <20211215141727.4901-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_09,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change is only hardware, and does not need driver change:
Added hardware flow control during transmit packet with variable delay.
The new id is then added to the ids list structure.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c9cacd4d5b22..c0478dfa61b9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2435,6 +2435,11 @@ static const struct amba_id mmci_ids[] = {
 		.mask	= 0xf0ffffff,
 		.data	= &variant_stm32_sdmmcv2,
 	},
+	{
+		.id     = 0x20253180,
+		.mask	= 0xf0ffffff,
+		.data	= &variant_stm32_sdmmcv2,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
2.17.1

