Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D9497E85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiAXMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:09:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41616 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiAXMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:09:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4B1071F42E83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643026164;
        bh=Bg+voHqmmOa1mdX+12mwmf2wNJLVsjZM+19lKzpTkcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+2N6lH9qF/w/anJtg8Giee1yOCXlKi1VxuhWnXU3qdvAImKTJAiNaU9QCRfRr6Ep
         SxMmG5QzEiME07L+9dLsHaxas1cGROkj86ISJHDZlyGvi/AD/SRUErKbT9JYepCI4C
         8DoIabibPjV3LEJD/shtoULNFUXJbhb4m9/m7GWd5HW3dR+2Yl61OZPHFY4lyo2R3/
         nPQ0RD0yAbaKbRGktPh0VmgMLeb4ereE4gN0z2Sww+/8VPeG4JdtewGu32vEbHK1QG
         R9+pbI5qv4a473QtPgw13ovrRZBDPhoGllsQPuVQRMJnRGmXnb15Ni+oXcs7tbUkEn
         i9lFYfjDo8XsA==
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
Subject: [PATCH 2/3] remoteproc: mtk_scp: Reorder scp_probe() sequence
Date:   Mon, 24 Jan 2022 13:09:14 +0100
Message-Id: <20220124120915.41292-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
References: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the scp_probe() function by reordering some calls in this
function, useful to reduce the usage of goto(s), and preparing
for one more usage of dev_err_probe().

In particular, we can get the clocks before mapping the memory region,
and move the mutexes initialization right before registering the ipi
handler (which is the first mutex user in this driver).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 95a40e3f11e3..e40706b0e015 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -791,24 +791,23 @@ static int scp_probe(struct platform_device *pdev)
 		scp->l1tcm_phys = res->start;
 	}
 
-	mutex_init(&scp->send_lock);
-	for (i = 0; i < SCP_IPI_MAX; i++)
-		mutex_init(&scp->ipi_desc[i].lock);
-
 	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
 	if (IS_ERR((__force void *)scp->reg_base)) {
 		dev_err(dev, "Failed to parse and map cfg memory\n");
-		ret = PTR_ERR((__force void *)scp->reg_base);
-		goto destroy_mutex;
+		return PTR_ERR((__force void *)scp->reg_base);
 	}
 
-	ret = scp_map_memory_region(scp);
+	ret = scp->data->scp_clk_get(scp);
 	if (ret)
-		goto destroy_mutex;
+		return ret;
 
-	ret = scp->data->scp_clk_get(scp);
+	ret = scp_map_memory_region(scp);
 	if (ret)
-		goto release_dev_mem;
+		return ret;
+
+	mutex_init(&scp->send_lock);
+	for (i = 0; i < SCP_IPI_MAX; i++)
+		mutex_init(&scp->ipi_desc[i].lock);
 
 	/* register SCP initialization IPI */
 	ret = scp_ipi_register(scp, SCP_IPI_INIT, scp_init_ipi_handler, scp);
@@ -842,7 +841,6 @@ static int scp_probe(struct platform_device *pdev)
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
 	scp_unmap_memory_region(scp);
-destroy_mutex:
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
-- 
2.33.1

