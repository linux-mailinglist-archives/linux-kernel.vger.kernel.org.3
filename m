Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592BE468F15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhLFC0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:26:03 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:35250 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233953AbhLFC0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:26:02 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowAAH6BTLc61hYj1pAQ--.24025S2;
        Mon, 06 Dec 2021 10:22:03 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: coda/imx-vdoa: Handle dma_set_coherent_mask error codes
Date:   Mon,  6 Dec 2021 10:22:01 +0800
Message-Id: <20211206022201.1639460-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAH6BTLc61hYj1pAQ--.24025S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fZFWxWF4rur1kXw4kXrb_yoWDWwcE9a
        48Zrn7Wr1rKryakr12kr4S9ry3KFZ5urn5XFySgFWaq3y5Cw4UJrWjvr17X34UZryvyFW8
        A398XF4xCw13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF3kuDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of dma_set_coherent_mask() is not always 0.
To catch the exception in case that dma is not support the mask.

Fixes: b0444f18e0b1 ("[media] coda: add i.MX6 VDOA driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/media/platform/coda/imx-vdoa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/coda/imx-vdoa.c b/drivers/media/platform/coda/imx-vdoa.c
index 8bc0d8371819..dd6e2e320264 100644
--- a/drivers/media/platform/coda/imx-vdoa.c
+++ b/drivers/media/platform/coda/imx-vdoa.c
@@ -287,7 +287,11 @@ static int vdoa_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "DMA enable failed\n");
+		return ret;
+	}
 
 	vdoa = devm_kzalloc(&pdev->dev, sizeof(*vdoa), GFP_KERNEL);
 	if (!vdoa)
-- 
2.25.1

