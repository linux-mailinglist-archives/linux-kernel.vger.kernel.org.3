Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50C4DD389
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiCRDZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiCRDZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:25:56 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40894F453
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:24:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 18 Mar
 2022 11:24:36 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 18 Mar
 2022 11:24:34 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <sgoutham@marvell.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] hwrng: cavium: fix possible NULL pointer dereference
Date:   Fri, 18 Mar 2022 11:24:32 +0800
Message-ID: <1647573872-19278-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdev is NULL but dereference to pdev->dev

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/char/hw_random/cavium-rng-vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/cavium-rng-vf.c b/drivers/char/hw_random/cavium-rng-vf.c
index 6f66919..bffcb01 100644
--- a/drivers/char/hw_random/cavium-rng-vf.c
+++ b/drivers/char/hw_random/cavium-rng-vf.c
@@ -179,7 +179,7 @@ static int cavium_map_pf_regs(struct cavium_rng *rng)
 	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
 			      PCI_DEVID_CAVIUM_RNG_PF, NULL);
 	if (!pdev) {
-		dev_err(&pdev->dev, "Cannot find RNG PF device\n");
+		printk(KERN_ERR "Cannot find RNG PF device\n");
 		return -EIO;
 	}
 
-- 
2.7.4

