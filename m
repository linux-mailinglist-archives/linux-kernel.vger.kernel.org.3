Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07934D274D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiCID5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCID5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:57:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A52DF7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:56:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s6so951888qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 19:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLFJFaK9btzqTP/j8r5zgihhiBksgfA2bHmxxtcpSXo=;
        b=MO43tOfzORiT8Row70VWECj83kZyVS99p0Eva5KHfRcGLaRhOh6TyQnphZCfKxxZW1
         1uKRvLYUa3UHqxWpaH8GMHhKufdg1MIOOERdVy3l3Qk/vzPNNbKVZ7Zuc1+JlCIPO8gU
         fYNJVjfgrB40OWzYbMT0HGFAY73vTSOzOwb1EOzOHIYD2YSeXA6F3EKui/J411ePPmBa
         W6yr7pss4VCEPeewo72RQf7ImrxzGpXn4nO0UrdGcyksgcqO3qg7kIuC5jwOkAaVGJLi
         AG1hH1JTLYWYpFoei0nPcJrQpggWpSYipA04qsg8Y/YfIP/fHgt+JHmnurFWJBBytbCH
         eXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLFJFaK9btzqTP/j8r5zgihhiBksgfA2bHmxxtcpSXo=;
        b=ojfslK1Bu8Er0kQEhK+vLaaa9V790xeyBIj/kMme8hkWb/ElVduEJTT4J4YIt0XGBG
         qI54LilI2f8nAaFGLwBkm6CrgovV8CaXEaYPtegJoYBXKoqs34vAIhN6DDP3oGJU1rqz
         nrYs/13+EiXFou3jm0Jf3ExCgUQ9u3tGAJFvR0hs8hZ/Ut2bJALt2wSDE9YrhyRCFLAO
         +MlaeZFBLWoJ5T8/+JQT51eFR5QnS/kFGjGLlXeOsUi9pw1xU2cPgQ936j/LHhZ+bnij
         2QuWfW0OVEef5xoFk8qE7ccHIW458QURCMQWkqG16srmg5EN0zIKuXF0AVTxdsZ0sP4Q
         PB2Q==
X-Gm-Message-State: AOAM531WsOGPcKpPSWCxEOh3GdmoiX+3XB2Ik889YEgwsvstcok81rzL
        KKfbT/sYAP+QBXMnWq0i2SM=
X-Google-Smtp-Source: ABdhPJwYvOGEEsmAfxA6tEGSPBqb2cgaYnfqcuBY+il+gmVYxgABSmNxS7sVYCoZsF1tKFp4rWB44w==
X-Received: by 2002:a05:622a:1715:b0:2e0:49ff:963b with SMTP id h21-20020a05622a171500b002e049ff963bmr16415010qtk.516.1646798173717;
        Tue, 08 Mar 2022 19:56:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n1-20020a05622a11c100b002dff3364c6esm614596qtk.19.2022.03.08.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:56:13 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mfd: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 03:56:07 +0000
Message-Id: <20220309035607.2080884-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/mfd/ab8500-core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 6a059270acdc..9d9e9787d5e8 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1022,9 +1022,9 @@ static int ab8500_probe(struct platform_device *pdev)
 	enum ab8500_version version = AB8500_VERSION_UNDEFINED;
 	struct device_node *np = pdev->dev.of_node;
 	struct ab8500 *ab8500;
-	struct resource *resource;
 	int ret;
 	int i;
+	int irq;
 	u8 value;
 
 	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
@@ -1033,13 +1033,11 @@ static int ab8500_probe(struct platform_device *pdev)
 
 	ab8500->dev = &pdev->dev;
 
-	resource = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!resource) {
-		dev_err(&pdev->dev, "no IRQ resource\n");
-		return -ENODEV;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	ab8500->irq = resource->start;
+	ab8500->irq = irq;
 
 	ab8500->read = ab8500_prcmu_read;
 	ab8500->write = ab8500_prcmu_write;
-- 
2.25.1

