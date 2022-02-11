Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B04B213C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbiBKJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiBKJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:13:28 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8331029;
        Fri, 11 Feb 2022 01:13:28 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jw79w4jfXzdZbm;
        Fri, 11 Feb 2022 17:10:12 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 17:13:26 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Feb
 2022 17:13:26 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - not need to enable sm4 extra mode at HW V3
Date:   Fri, 11 Feb 2022 17:08:18 +0800
Message-ID: <20220211090818.55398-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not need to enable sm4 extra mode in at HW V3. Here is fix it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 26d3ab1d308b..89d4cc767d36 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -443,9 +443,11 @@ static int sec_engine_init(struct hisi_qm *qm)
 
 	writel(SEC_SAA_ENABLE, qm->io_base + SEC_SAA_EN_REG);
 
-	/* Enable sm4 extra mode, as ctr/ecb */
-	writel_relaxed(SEC_BD_ERR_CHK_EN0,
-		       qm->io_base + SEC_BD_ERR_CHK_EN_REG0);
+	/* HW V2 enable sm4 extra mode, as ctr/ecb */
+	if (qm->ver < QM_HW_V3)
+		writel_relaxed(SEC_BD_ERR_CHK_EN0,
+			       qm->io_base + SEC_BD_ERR_CHK_EN_REG0);
+
 	/* Enable sm4 xts mode multiple iv */
 	writel_relaxed(SEC_BD_ERR_CHK_EN1,
 		       qm->io_base + SEC_BD_ERR_CHK_EN_REG1);
-- 
2.33.0

