Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E648497E86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiAXMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiAXMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:09:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7AEC06173B;
        Mon, 24 Jan 2022 04:09:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EED441F42E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643026165;
        bh=K2ObFY3Vsm+qnoFl2QeGq49BSilMuqWVDQ+bAXw3Mog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXIzTOobugUM0mowy79jjk1wphZsdQeaD09BgOWJkvg9YkRg2INPxE+3z59OGCbaP
         oGOgJZyLmJ/EDqaqCFR1peOp+C5HLSeEVSR8VN0fCVIerLlfa/PSP1gY89+4F7ymtk
         RmjpdpgsBEgOl0FqpJblVZj1Dsgw+lIhVOFigOX7JF8PmoIIh6/UCs+6NvySXOCRTo
         y5203U/mGV2mQ1spOsg1DoKw98o9G0kotfqk6RVIhRaDN8DxbfmdXuoyMl1P0n3i1d
         mZVoDugn6pJSvub6XGR1RYeiACs7trCsDaFVHFCgXjKt9Wq6pVhef28Ejy1BIlwamf
         GmUSTmUu1bXhg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/3] remoteproc: mtk_scp: Use dev_err_probe() where possible
Date:   Mon, 24 Jan 2022 13:09:15 +0100
Message-Id: <20220124120915.41292-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
References: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the probe function, where possible, by using dev_err_probe().
While at it, as to increase human readability, also remove some
unnecessary forced void pointer casts that were previously used in
error checking.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index e40706b0e015..dcddb33e9997 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -757,10 +757,8 @@ static int scp_probe(struct platform_device *pdev)
 	int ret, i;
 
 	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
-	if (!rproc) {
-		dev_err(dev, "unable to allocate remoteproc\n");
-		return -ENOMEM;
-	}
+	if (!rproc)
+		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
 
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
@@ -770,21 +768,20 @@ static int scp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
 	scp->sram_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR((__force void *)scp->sram_base)) {
-		dev_err(dev, "Failed to parse and map sram memory\n");
-		return PTR_ERR((__force void *)scp->sram_base);
-	}
+	if (IS_ERR(scp->sram_base))
+		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
+				     "Failed to parse and map sram memory\n");
+
 	scp->sram_size = resource_size(res);
 	scp->sram_phys = res->start;
 
 	/* l1tcm is an optional memory region */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
 	scp->l1tcm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR((__force void *)scp->l1tcm_base)) {
-		ret = PTR_ERR((__force void *)scp->l1tcm_base);
+	if (IS_ERR(scp->l1tcm_base)) {
+		ret = PTR_ERR(scp->l1tcm_base);
 		if (ret != -EINVAL) {
-			dev_err(dev, "Failed to map l1tcm memory\n");
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
 		}
 	} else {
 		scp->l1tcm_size = resource_size(res);
@@ -792,10 +789,9 @@ static int scp_probe(struct platform_device *pdev)
 	}
 
 	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
-	if (IS_ERR((__force void *)scp->reg_base)) {
-		dev_err(dev, "Failed to parse and map cfg memory\n");
-		return PTR_ERR((__force void *)scp->reg_base);
-	}
+	if (IS_ERR(scp->reg_base))
+		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
+				     "Failed to parse and map cfg memory\n");
 
 	ret = scp->data->scp_clk_get(scp);
 	if (ret)
-- 
2.33.1

