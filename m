Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9155472B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiFKHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:44:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1026D;
        Sat, 11 Jun 2022 00:44:26 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKqYw1NlhzjWvg;
        Sat, 11 Jun 2022 15:43:00 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 15:44:24 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 15:44:24 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - only HW V2 needs to change the BD err detection
Date:   Sat, 11 Jun 2022 15:38:08 +0800
Message-ID: <20220611073808.51610-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

The base register address of V2 and V3 are different. HW V3 not needs
to change the BD err detection.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 4d85d2cbf376..95e86d1f417e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -508,16 +508,17 @@ static int sec_engine_init(struct hisi_qm *qm)
 
 	writel(SEC_SAA_ENABLE, qm->io_base + SEC_SAA_EN_REG);
 
-	/* HW V2 enable sm4 extra mode, as ctr/ecb */
-	if (qm->ver < QM_HW_V3)
+	if (qm->ver < QM_HW_V3) {
+		/* HW V2 enable sm4 extra mode, as ctr/ecb */
 		writel_relaxed(SEC_BD_ERR_CHK_EN0,
 			       qm->io_base + SEC_BD_ERR_CHK_EN_REG0);
 
-	/* Enable sm4 xts mode multiple iv */
-	writel_relaxed(SEC_BD_ERR_CHK_EN1,
-		       qm->io_base + SEC_BD_ERR_CHK_EN_REG1);
-	writel_relaxed(SEC_BD_ERR_CHK_EN3,
-		       qm->io_base + SEC_BD_ERR_CHK_EN_REG3);
+		/* HW V2 enable sm4 xts mode multiple iv */
+		writel_relaxed(SEC_BD_ERR_CHK_EN1,
+			       qm->io_base + SEC_BD_ERR_CHK_EN_REG1);
+		writel_relaxed(SEC_BD_ERR_CHK_EN3,
+			       qm->io_base + SEC_BD_ERR_CHK_EN_REG3);
+	}
 
 	/* config endian */
 	sec_set_endian(qm);
-- 
2.33.0

