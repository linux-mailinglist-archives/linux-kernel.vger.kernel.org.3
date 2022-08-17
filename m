Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86BE59691F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiHQGCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiHQGCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:02:17 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502037F268;
        Tue, 16 Aug 2022 23:02:09 -0700 (PDT)
X-QQ-mid: bizesmtp82t1660715993tzs4omjz
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 13:59:51 +0800 (CST)
X-QQ-SSF: 01400000002000D0T000B00A0000000
X-QQ-FEAT: aBJFcW+uBGYgmAL01Z5YK4fA139v7xj8q5YXUdXTQfe5/gq6ZjqhbWvJspXrS
        DGsosptREEMgLgZlT2veTkCeVQQVY1iX0VGXc1TkKP77zkq63Cu9jg6812chrv7D4InATU0
        //Vur3QoO2W9AohXnC0cxUVK9Ak0TsD1j3VnG6STBa/HpXyFquJ3a801llRzX/spGDlBNyV
        KUYqBVQbZI0VN7J0z0YwXNpi64pO8SxBFAmx0U6UK2AfGGhZ+gSNZZHcSzW826fqZWXQwuU
        wHpaUqmaE8S2yooAa+SDRUVQndHPI1z5wG1S3DGQxGTtx6aJ51ONiFDWyApPFNJ9q29VTJc
        EzET7f1qu0AWJb0cJvNzBFOeocACGjsZnIPZeRZi4gTCD1Ft/M=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] pwm: rockchip: Convert to use dev_err_probe()
Date:   Wed, 17 Aug 2022 13:59:49 +0800
Message-Id: <20220817055949.20497-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/pwm/pwm-rockchip.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index f3647b317152..bd7ab37aaf88 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -331,15 +331,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->pclk)) {
 		ret = PTR_ERR(pc->pclk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
-		return ret;
+			return dev_err_probe(&pdev->dev, ret, "Can't get APB clk: %d\n");
 	}
 
 	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk: %d\n");
 
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
-- 
2.20.1

