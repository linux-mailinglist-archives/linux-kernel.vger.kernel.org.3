Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22C4C4344
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiBYLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiBYLYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:24:43 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA7222187
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:24:11 -0800 (PST)
X-QQ-mid: bizesmtp79t1645788245t49j8khg
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 25 Feb 2022 19:24:00 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000000A0000000
X-QQ-FEAT: geCjBjpTnm6nZW6W2+e1/q58vY6DH81pScFqhQy7CQF522ZdEZ1R/hd3i/nDP
        9bNj0+q1XoLitfPhMytuSWuV/QE7ioTdsZfPlNSrT/xsx04CZq7JqnidPKcK/RYB6R9IOqQ
        B1+aS9IPnWWjCZM8UPw7saIUW0q+ASTmODMfx//MPl+HJUW2DaJKxGM0QGofwUbRqOgAreS
        ZecbB2w31GVdrjdAm1nHPQ9Or0fjOAMIcKJMgJqyLGAYJY6Vyv7O8YRtanbrV9gKxepZiqa
        XsfT4d0E/oandwpcxjbUW3lDkRAJQ1h+fXKfdy5Xo+14T0SyZl6rikxpaTge4kvgJmXpeXb
        y0L77S0J5FUakoc12SwnPnFZ5BY6VvkQgpYU0lIvymSN4NOAC8=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] sound/soc/amd: Use platform_get_irq_byname() to get the interrupt
Date:   Fri, 25 Feb 2022 19:23:58 +0800
Message-Id: <20220225112358.19403-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_byname().

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/amd/acp/acp-renoir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index d06ad5ce7fec..d4deac821300 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -265,13 +265,10 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	if (!adata->acp_base)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "acp_dai_irq");
-	if (!res) {
-		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+	adata->i2s_irq = platform_get_irq_byname(pdev, "acp_dai_irq");
+	if (adata->i2s_irq < 0)
 		return -ENODEV;
-	}
 
-	adata->i2s_irq = res->start;
 	adata->dev = dev;
 	adata->dai_driver = acp_renoir_dai;
 	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
-- 
2.20.1



