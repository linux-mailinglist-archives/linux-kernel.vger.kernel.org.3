Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18794462DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhK3H7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:59:04 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234260AbhK3H67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:58:59 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AU13TY8012031;
        Tue, 30 Nov 2021 08:55:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=23KQt3SEHQG2x+P/jacjp6tL0OJTLQOO2vIEH5W7XlU=;
 b=Tw/768f/FkgS7t0suD8bTiROn8wHJYZRmpqiq+pnhhQBi2I/BU2zkHGqiTGMpM9S4nLj
 pWl4iVYs4gaoQ1B9wFqT22qrqhcGKIdVqw6JLkhqXdGbLIthosq+GXkizKkZo+Od23CC
 m4nbxOhIaYq3Ij/6im+byJHc8LIfcCWONeTeQBV6OLxHguorx89nik7i5NwiwdyRT5MU
 vuXmIv0vOmxMEOXkyEw2NAyn7gaWBN9A3vX5lGPHcngY1jVGEcXjH0z3NdcKvsCqCyFw
 cro92Y9rnNa6ELsKsdwE7XGy5BlsQsrbwx+jRB9xd7fP1A4WKnq2hcuF9uG3rwy/wN2f 2Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cn9y7shv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:55:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93DBE10002A;
        Tue, 30 Nov 2021 08:55:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BDD9218121;
        Tue, 30 Nov 2021 08:55:25 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 08:55:25
 +0100
From:   Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Marek Vasut <marex@denx.de>,
        Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 2/9] crypto: stm32/cryp - don't print error on probe deferral
Date:   Tue, 30 Nov 2021 08:54:54 +0100
Message-ID: <20211130075501.21958-3-nicolas.toromanoff@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
References: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_06,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@foss.st.com>

Change driver to not print an error message when the device
probe is deferred for a clock resource.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index dcdd313485de..7b55ad6d2f1a 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1955,7 +1955,8 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 
 	cryp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(cryp->clk)) {
-		dev_err(dev, "Could not get clock\n");
+		dev_err_probe(dev, PTR_ERR(cryp->clk), "Could not get clock\n");
+
 		return PTR_ERR(cryp->clk);
 	}
 
-- 
2.17.1

