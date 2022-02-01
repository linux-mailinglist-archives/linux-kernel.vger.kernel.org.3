Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD34A571F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiBAGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:08:09 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36415 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbiBAGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:08:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V3MZg10_1643695678;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3MZg10_1643695678)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Feb 2022 14:07:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mirela.rabulea@nxp.com
Cc:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: imx-jpeg: Remove unnecessary print function dev_err()
Date:   Tue,  1 Feb 2022 14:07:57 +0800
Message-Id: <20220201060757.89837-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warning:
./drivers/media/platform/imx-jpeg/mxc-jpeg.c:2025:3-10: line 2025 is
redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index fed762491379..77c5134739ea 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -2022,7 +2022,6 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	for (slot = 0; slot < MXC_MAX_SLOTS; slot++) {
 		dec_irq = platform_get_irq(pdev, slot);
 		if (dec_irq < 0) {
-			dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
 			ret = dec_irq;
 			goto err_irq;
 		}
-- 
2.20.1.7.g153144c

