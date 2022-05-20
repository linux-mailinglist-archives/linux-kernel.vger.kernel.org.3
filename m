Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FA752E44A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiETFUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbiETFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:20:36 -0400
Received: from smtpbg511.qq.com (smtpbg511.qq.com [203.205.250.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AAA14AF52
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 22:20:31 -0700 (PDT)
X-QQ-mid: bizesmtp66t1653024024tli9ljwk
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 20 May 2022 13:20:22 +0800 (CST)
X-QQ-SSF: 01400000000000C0P000B00A0000000
X-QQ-FEAT: m2MyNB0G64l0Nsuavp5W6TBGn3MsEceFfz5qolkav3oV4q3Nm43n81lToTJrn
        1Rum+E0qbsdbFFEdQL/vn5RK4gaLe8EeNI7NFR8MyxC1ADHZjS5J96UPBTReAVQvp9/yq9c
        /YyFaFktayoNIBEBGrwzuhtNvlZDOjbtIqwaXrj0YvpBNUpOcljwZanLa20H4kxnYGPNzz7
        xCwER8NIgrRGM1eOsK10XWaWWsK/cgKK7LS1838dxMIJzoIu/OiJLjaDzxFpK0IjB4FUhcY
        0Onm9AY7p3T+rM3P7mHdDWGG9SC6PHd/ENwOIyjPhlgw035mARCX5BtNO/2QEKFsMfEaCkx
        c5njvxE
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] pinctrl: berlin: bg4ct: Use devm_platform_*ioremap_resource() APIs
Date:   Fri, 20 May 2022 13:20:21 +0800
Message-Id: <20220520052021.25631-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() and
devm_platform_ioremap_resource() APIs instead of their
open coded analogues.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/pinctrl/berlin/berlin-bg4ct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
index 6a7fe929a68b..3026a3b3da2d 100644
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -460,8 +460,7 @@ static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
 	if (!rmconfig)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.20.1



