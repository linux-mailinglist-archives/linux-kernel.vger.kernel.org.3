Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FA462DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhK3H67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:58:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57552 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229639AbhK3H65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:58:57 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AU0GJvO001818;
        Tue, 30 Nov 2021 08:55:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=ApzKX0Ohee8Bs+HYdLXyjIjlJjwLbFK+nNLOPyTFAjc=;
 b=lfpKX6lJvaJUijG2BeDDNtVBJe9D+dnnnEqAc8rfrqpdjwAht4+u2ysIXhZ3PxuZ5BN8
 snLLOjewpOyeikjCQy+WIxfcDCtuy+1+yLX+Guhs9wDPQZ83kXUVLr85/cV/SQCt6KQq
 8q6QjINVgEA/FSlk2zc2rnUPJWzbBb9Vlik0+7XJFejRnfebAJngLvevOB4VYWA4uagT
 c4ImUxT+ODeAiFtaV1gkCkyql6dULKIN3q6mg01/HauFgnyBvn+yBvuNCSkQ8ZKSDNPt
 beT895od+SkJjyMM2NtEqFUVVcwyMriLmpZxh9vJAG25jcpM3kHbltQ5vYxm0HmfRQOU eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cn98hhpt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:55:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A7D110002A;
        Tue, 30 Nov 2021 08:55:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 541322194DA;
        Tue, 30 Nov 2021 08:55:15 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 08:55:14
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
Subject: [PATCH v4 1/9] crypto: stm32/cryp - defer probe for reset controller
Date:   Tue, 30 Nov 2021 08:54:53 +0100
Message-ID: <20211130075501.21958-2-nicolas.toromanoff@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
References: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_06,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@foss.st.com>

Change stm32 CRYP driver to defer its probe operation when
reset controller device is registered but has not been probed yet.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 7389a0536ff0..dcdd313485de 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1973,7 +1973,11 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	rst = devm_reset_control_get(dev, NULL);
-	if (!IS_ERR(rst)) {
+	if (IS_ERR(rst)) {
+		ret = PTR_ERR(rst);
+		if (ret == -EPROBE_DEFER)
+			goto err_rst;
+	} else {
 		reset_control_assert(rst);
 		udelay(2);
 		reset_control_deassert(rst);
@@ -2024,7 +2028,7 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 	spin_lock(&cryp_list.lock);
 	list_del(&cryp->list);
 	spin_unlock(&cryp_list.lock);
-
+err_rst:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-- 
2.17.1

