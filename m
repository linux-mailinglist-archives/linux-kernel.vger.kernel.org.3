Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01EB497E82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiAXMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:09:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiAXMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:09:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 90FB01F42E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643026162;
        bh=aOuYPLM5L/mmuMP/xuJRrEHY6ka8AQ/+E0HBxwte4rk=;
        h=From:To:Cc:Subject:Date:From;
        b=UOSTw1zFcyrq8krivX1eQH6s3kCIy1msupv2GSjycaN5568uej4szCz8kk1Sgi+o2
         +1+FDKEjUhFUOGHySgTcntP4O1W0NlSHNfGOxKzbe1zmvZjH0rqomv+hFcNQYbzFyI
         zSsTn+oYkWBGIwXm/bBDK1laxNHsJS/GvgqE57DPF6SzGS4ZFeRVrTy5T/if6vIHch
         elcKf3nJoGvhFwpKfGwFrqxXAji7nWvfFP4+Y287AK6iW6MC/ZSoElO/lzIqdV0RxT
         YvKlm5ONN+3u0C2HKZuxXAtOgSfhCuoYbTG0kNGgiX/EiV7tXMebMWQQCzhbO1MjPt
         h2/xEgF2c9jPw==
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
Subject: [PATCH 1/3] remoteproc: mtk_scp: Use devm variant of rproc_alloc()
Date:   Mon, 24 Jan 2022 13:09:13 +0100
Message-Id: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the probe function, switch from using rproc_alloc() to
devm_rproc_alloc(); while at it, also put everything on a single line,
as it acceptably fits in 82 columns.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 36e48cf58ed6..95a40e3f11e3 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -756,11 +756,7 @@ static int scp_probe(struct platform_device *pdev)
 	char *fw_name = "scp.img";
 	int ret, i;
 
-	rproc = rproc_alloc(dev,
-			    np->name,
-			    &scp_ops,
-			    fw_name,
-			    sizeof(*scp));
+	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
 	if (!rproc) {
 		dev_err(dev, "unable to allocate remoteproc\n");
 		return -ENOMEM;
@@ -776,8 +772,7 @@ static int scp_probe(struct platform_device *pdev)
 	scp->sram_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR((__force void *)scp->sram_base)) {
 		dev_err(dev, "Failed to parse and map sram memory\n");
-		ret = PTR_ERR((__force void *)scp->sram_base);
-		goto free_rproc;
+		return PTR_ERR((__force void *)scp->sram_base);
 	}
 	scp->sram_size = resource_size(res);
 	scp->sram_phys = res->start;
@@ -789,7 +784,7 @@ static int scp_probe(struct platform_device *pdev)
 		ret = PTR_ERR((__force void *)scp->l1tcm_base);
 		if (ret != -EINVAL) {
 			dev_err(dev, "Failed to map l1tcm memory\n");
-			goto free_rproc;
+			return ret;
 		}
 	} else {
 		scp->l1tcm_size = resource_size(res);
@@ -851,8 +846,6 @@ static int scp_probe(struct platform_device *pdev)
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
-free_rproc:
-	rproc_free(rproc);
 
 	return ret;
 }
-- 
2.33.1

