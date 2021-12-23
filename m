Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2192B47E63A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349088AbhLWQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:14:52 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:55056 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbhLWQOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:14:51 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0QjwnMoJoIEdl0QjwnhFhs; Thu, 23 Dec 2021 17:14:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Dec 2021 17:14:49 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nm@ti.com, ssantosh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] soc: ti: k3-ringacc: Use devm_bitmap_zalloc() when applicable
Date:   Thu, 23 Dec 2021 17:14:46 +0100
Message-Id: <45544b0d97a7bea7764292852842adf5085a7700.1640276001.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rings_inuse' and 'proxy_inuse' are bitmaps. So use 'devm_bitmap_zalloc()'
to simplify code and improve the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/ti/k3-ringacc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 31ab6c657fec..f7bf18b8229a 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1402,12 +1402,10 @@ static int k3_ringacc_init(struct platform_device *pdev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings,
 				      GFP_KERNEL);
-	ringacc->rings_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_rings),
-					    sizeof(unsigned long), GFP_KERNEL);
-	ringacc->proxy_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_proxies),
-					    sizeof(unsigned long), GFP_KERNEL);
+	ringacc->rings_inuse = devm_bitmap_zalloc(dev, ringacc->num_rings,
+						  GFP_KERNEL);
+	ringacc->proxy_inuse = devm_bitmap_zalloc(dev, ringacc->num_proxies,
+						  GFP_KERNEL);
 
 	if (!ringacc->rings || !ringacc->rings_inuse || !ringacc->proxy_inuse)
 		return -ENOMEM;
@@ -1483,9 +1481,8 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings * 2,
 				      GFP_KERNEL);
-	ringacc->rings_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_rings),
-					    sizeof(unsigned long), GFP_KERNEL);
+	ringacc->rings_inuse = devm_bitmap_zalloc(dev, ringacc->num_rings,
+						  GFP_KERNEL);
 
 	if (!ringacc->rings || !ringacc->rings_inuse)
 		return ERR_PTR(-ENOMEM);
-- 
2.32.0

