Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCB538703
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiE3SEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiE3SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:04:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB72A206E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 129-20020a1c0287000000b003974edd7c56so5499753wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmgLvUIbxgbpdB2bdHpHdShKYYvDRAzse8YTxTcYmlw=;
        b=NfEC1OIXJEz3OYJ6J87rT9rzJ1mbZNB0gKkeP3tMJSIX/sM8LGt31DrleZc5+pOgwE
         5KAoev3tGKNxqP5IHJYqti6jxR1OasqD8F/XhjuE0JmwxCEbgqDtNRsL7DZ6vZyKNcFW
         f+lKaiQkrlyWUQYfWiftdcvKoxFeEORW0pgsLIwrwyAz5uyPtgy4gLAP8iMtiZrM2wtR
         zwdy/TO0g+G0huyLhlqJR2uz4v8437twjVazYvtTO00cfSnBdq9Wka9kZqoGpgmn0LbO
         k33+uKtOndBl3UlThJThhtyxMA++fkVMajtvMiS3bXy0WlGB5T4wYUHVgz76hnEXzJxf
         pm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmgLvUIbxgbpdB2bdHpHdShKYYvDRAzse8YTxTcYmlw=;
        b=nmART/QCXD2z1+7FOQAQ0k9KUDdRFCO0hhMR+V5IPNJDBHyxecIoGHxeb3K7JkJdFb
         2sKz+2rVPLa9KrF1uFiM7djhtBX2ie0BsP3iaYbbUmR8G/uW1KOe7lUSRb0EVut6wZjE
         NEyEcTgKfF2bMHMGQYZJKjmw4Lf+8esgCeORXCnK9rfewyMpQOFsrVrC1bZlEPGPjgO7
         zmYX64R9fJaORSBJx9JRlKWQwILxdyirY0yxznSYvzTmlBoFB3eun/VGxPobcH7om2fW
         G0uxcY/kpsYlOAhnXW8ghbZ37QPSOww/RsID+nBWsgG8kGEt8HDp6uc/f9x1pz3V8T2Z
         wYcg==
X-Gm-Message-State: AOAM530g7sxLR16pu16SUrCrx/vgg8tgTJqG4chOA83nBg2lo1MJvv2q
        2vaTVW3pzv0q+O5epi3BJAFu2Q==
X-Google-Smtp-Source: ABdhPJy3TpSKfEh0yxmuTCQYqERubX5Qj/lcKQ/awW7gRS0/MmJIqd0Xb3r8aUJ1ih0s8IO0W9TpgA==
X-Received: by 2002:a1c:4443:0:b0:397:38a7:30 with SMTP id r64-20020a1c4443000000b0039738a70030mr19773587wma.14.1653933838195;
        Mon, 30 May 2022 11:03:58 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b00397550b387bsm1647wmc.23.2022.05.30.11.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:03:57 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu: mtk_iommu: add support for 6-bit encoded port IDs
Date:   Mon, 30 May 2022 20:03:27 +0200
Message-Id: <20220530180328.845692-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530180328.845692-1-fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the port ID was always encoded as a 5-bit data. On MT8365,
the port ID is encoded as a 6-bit data. This requires to rework the
macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
to support 5-bit and 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++----
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fd75a60abd6..b692347d8d56 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -103,8 +103,10 @@
 #define REG_MMU1_INT_ID				0x154
 #define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
-#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
-#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+#define F_MMU_INT_ID_LARB_ID(a, port_width)	\
+				((a) >> ((port_width + 2) & 0x7))
+#define F_MMU_INT_ID_PORT_ID(a, port_width)	\
+				(((a) >> 2) & GENMASK(port_width - 1, 0))
 
 #define MTK_PROTECT_PA_ALIGN			256
 
@@ -291,12 +293,13 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_pa |= (u64)pa34_32 << 32;
 	}
 
-	fault_port = F_MMU_INT_ID_PORT_ID(regval);
+	fault_port = F_MMU_INT_ID_PORT_ID(regval, data->plat_data->port_width);
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
 		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
 	} else {
-		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+		fault_larb = F_MMU_INT_ID_LARB_ID(regval,
+						  data->plat_data->port_width);
 	}
 	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
@@ -1034,6 +1037,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt6779_data = {
@@ -1043,6 +1047,7 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
+	.port_width    = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8167_data = {
@@ -1052,6 +1057,7 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
@@ -1062,6 +1068,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
@@ -1071,6 +1078,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8192_data = {
@@ -1082,6 +1090,7 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
 			   {0, 14, 16}, {0, 13, 18, 17}},
+	.port_width     = 5,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index b742432220c5..84cecaf6d61c 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -54,6 +54,7 @@ struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	u32                 flags;
 	u32                 inv_sel_reg;
+	u8                  port_width;
 
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
-- 
2.36.1

