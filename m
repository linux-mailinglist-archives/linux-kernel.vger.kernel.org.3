Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203F476B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhLPHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:48:25 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40947 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbhLPHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:48:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-n8baH_1639640898;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V-n8baH_1639640898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 15:48:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bbrezillon@kernel.org
Cc:     arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] crypto: octeontx2 -Use swap() instead of swap_engines()
Date:   Thu, 16 Dec 2021 15:48:14 +0800
Message-Id: <20211216074814.71712-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1523:16-17:
WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 57307eac541c..9aef37972246 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1514,16 +1514,6 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	return ret;
 }
 
-static void swap_engines(struct otx2_cpt_engines *engsl,
-			 struct otx2_cpt_engines *engsr)
-{
-	struct otx2_cpt_engines engs;
-
-	engs = *engsl;
-	*engsl = *engsr;
-	*engsr = engs;
-}
-
 int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 				   struct devlink_param_gset_ctx *ctx)
 {
@@ -1624,7 +1614,7 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		}
 		/* Keep SE engines at zero index */
 		if (engs[1].type == OTX2_CPT_SE_TYPES)
-			swap_engines(&engs[0], &engs[1]);
+			swap(engs[0], engs[1]);
 	}
 	mutex_lock(&eng_grps->lock);
 
-- 
2.20.1.7.g153144c

