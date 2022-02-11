Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DA4B1CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiBKD2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:28:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBKD2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:28:10 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49410337
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:28:09 -0800 (PST)
X-QQ-mid: bizesmtp50t1644550079to65l9oo
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Feb 2022 11:27:57 +0800 (CST)
X-QQ-SSF: 01400000000000B0L000B00A0000000
X-QQ-FEAT: F3yR32iATbh2oLBgY04bLCEUrugK2eYu4uqKzn4vZXr8M3FhjTaXhTsqQBEGA
        1bFiRILN7D7WuAlXkxS9K6wuxbIdfTOvRUPUc//342iGA4AzJ2ggNOHQyQjx1WOpFSfWPIB
        GGlRpicv3TZMkOyuYQSiWFlgtLY9vw69udozN1/DwrdX+yChhQq9zOyjzn2BkEjIJ2z1Sqi
        r7vsbqLo42piW5VVPu0IQRh6GyHruikoqHcT/Xr4HNvJUOSulO8P+8FF9oE9M9DsW6UGuB9
        yGbEJuu2gF7uT5B9RxzK4jb12w8Deol0kDfhrhTxBePHSsfuGRryHcQtSIC5aVaOZnvyF7I
        +eBXrlcM4Y2JsmK3VT4FW26RuQqwyXUlO0hVF4S
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     jingoohan1@gmail.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] video: s3c-fb: Use platform_get_irq() to get the interrupt
Date:   Fri, 11 Feb 2022 11:27:55 +0800
Message-Id: <20220211032755.2271-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/video/fbdev/s3c-fb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 3b134e1bbc38..6ead7d3e2312 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1360,7 +1360,6 @@ static int s3c_fb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct s3c_fb_platdata *pd;
 	struct s3c_fb *sfb;
-	struct resource *res;
 	int win;
 	int ret = 0;
 	u32 reg;
@@ -1418,13 +1417,13 @@ static int s3c_fb_probe(struct platform_device *pdev)
 		goto err_lcd_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
+	sfb->irq_no = platform_get_irq(pdev, 0);
+	if (sfb->irq_no < 0) {
 		dev_err(dev, "failed to acquire irq resource\n");
 		ret = -ENOENT;
 		goto err_lcd_clk;
 	}
-	sfb->irq_no = res->start;
+
 	ret = devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
 	if (ret) {
-- 
2.20.1



