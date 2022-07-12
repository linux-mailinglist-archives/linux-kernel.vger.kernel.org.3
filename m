Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21F45728BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiGLVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGLVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:44:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814F2FFFB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:44:34 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4408766015C4;
        Tue, 12 Jul 2022 22:44:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657662272;
        bh=Wik+BSgjTEwACqP1//DVq69wKrPz3LMLTI3NbGLzuqg=;
        h=From:To:Cc:Subject:Date:From;
        b=P4uqCVhD4Vkk33HXVq83SlYRoshdXd6+uKuOAFEKfb7tbcruikwjgLShkeTD1BHUo
         Ul1nYF4ubAs7IM5CytrNG6f8GXLnMog8lbzqE5m9xiqRbGJhGsSDxBb/R3ut+U/+9J
         dyMsm6+hfZu/2jL0cAD7aYYnDReYBUDN9yjyQzTQOtbS9wCU9o9xYRqz5Nkzwg5if+
         wJpUjZM2k9ZC7FauIFOBhR9Q2wExNfmoE5lnp3pGoi5M6vsP4tMhG2eMiIBQwxAZ3T
         8vzWbtglFMdvrKEX3rzzTGpTaJQdN4p6GmB/odr9vPuxu8NtNtKji/PDeZsg9D/K4P
         6Ms0SZ7wCAF/Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] iommu/mediatek: Log with dev_err_probe when failing to parse dts
Date:   Tue, 12 Jul 2022 17:44:27 -0400
Message-Id: <20220712214427.544860-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_iommu_mm_dts_parse() can fail with EPROBE_DEFER if not all larbs
have probed yet, so use dev_err_probe() to avoid logging as an error in
that case. Also drop the return value from the message since it's
already printed by dev_err_probe(), and add the missing newline at the
end.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b2ae84046249..3d23409bf108 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1214,7 +1214,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
 		if (ret) {
-			dev_err(dev, "mm dts parse fail(%d).", ret);
+			dev_err_probe(dev, ret, "mm dts parse fail\n");
 			goto out_runtime_disable;
 		}
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
-- 
2.37.0

