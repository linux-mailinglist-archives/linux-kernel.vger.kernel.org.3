Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB4054FED7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiFQUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383548AbiFQUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:41:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC45C874;
        Fri, 17 Jun 2022 13:39:26 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CABF76601797;
        Fri, 17 Jun 2022 21:39:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655498352;
        bh=unOJLRCDw7ZgTYa/8lyD2J+JxtKXBgGo6Z3sHYVsN/8=;
        h=From:To:Cc:Subject:Date:From;
        b=XZ1pKxO8HcDYK1nHIJdH1GIT8ak5uIfYf37+VzFupVfJsNIC95X6RrjzhvnwWv+eL
         1V5kGuBt0rMJU8N2FslzzJj+IQzzcxbeUyGz02gMuwdbzAy/NxNEfhX03BHTTPo0kd
         iEZ7/eVobt29a+zVlMRMZZGwQD28ZeNLli4JaqRnpGXNvnuGYMLVfJlwQrzQ5PKhRU
         PKOjMLScWEeqGZtCNW7JB+kJceemCwEfvLAwwlBN44YgrgZNRBE/3lHsmhMlva7QJQ
         stYS3wC3VTM9qo9O3Fe2IGrp3nZtZC0APwZiZMHs0Y2+rnon+bgd5PJV82PG/gF9Ie
         Umha8AdstBUlw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Drop platform_get_resource(IORESOURCE_IRQ)
Date:   Fri, 17 Jun 2022 16:39:06 -0400
Message-Id: <20220617203906.2422868-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
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

Commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource
from DT core") removed support for calling platform_get_resource(...,
IORESOURCE_IRQ, ...) on DT-based drivers, but the probe() function of
mtk-vcodec's encoder was still making use of it. This caused the encoder
driver to fail probe.

Since the platform_get_resource() call was only being used to check for
the presence of the interrupt (its returned resource wasn't even used)
and platform_get_irq() was already being used to get the IRQ, simply
drop the use of platform_get_resource(IORESOURCE_IRQ) and handle the
failure of platform_get_irq(), to get the driver probing again.

Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Tested on mt8192-asurada-spherion.

 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c   | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 95e8c29ccc65..b91c27e79796 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -272,14 +272,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get irq resource");
-		ret = -ENOENT;
+	dev->enc_irq = platform_get_irq(pdev, 0);
+	if (dev->enc_irq < 0) {
+		ret = dev->enc_irq;
 		goto err_res;
 	}
 
-	dev->enc_irq = platform_get_irq(pdev, 0);
 	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
-- 
2.36.1

