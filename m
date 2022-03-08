Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8B4D106C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbiCHGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiCHGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:43:32 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F61260D;
        Mon,  7 Mar 2022 22:42:35 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id jo29so1662857qvb.5;
        Mon, 07 Mar 2022 22:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BlhCpzOl8RmNINpEx6ZksN8PuzFGiT+rReK1e6qksg=;
        b=U3b0Pp6Ijjok03//V1wBwEFHZ7gTBQ8F2ZBI4ch/90od19po2tzo1FBwcz3e/d/UrA
         8T0xqVnuRugaqn17fibFF/skhjednRMy39yTgtuAxNGp/Fj10qAR077tzRpK4GVndeQz
         8k0jYRabxXUVI4mHoyd4vwlbC1ZwIxyy9ddIZUb9OSWEQIXox3K1YG5+aP5ZDbHDCjNu
         JOv4TXTa3yxFKIN6IHVHILud4f0gaPgrZD33sQnQtTQlKNntp7YLd+jqD1RjkELPgsbO
         U4GqAcB4vmamiio1LyGL+fwjDwiiYWMxRR5zVCV3L1+QFVnoBR66mK13h6ptdQKfgnEo
         kNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BlhCpzOl8RmNINpEx6ZksN8PuzFGiT+rReK1e6qksg=;
        b=qanQgGuGn3ZCczlq73rMEozMEwgqYrC+r37EcO2s1K71Fq7+Rq2NizMu0ksuveqDPS
         fGS1ZpFPiF/s9aakL6Q+QZ7gWv7CGf9MzYl2n8nc6v6cq1MmEkYcuYzcvh2dLan7lbT8
         T5BN3DeOzreG4Kuk0LOrIJF5TJ+ehWKC96vzWAEr8gvjkGcrljRQtVm33CRdVeGxE84o
         oQnptnXQMHljYmdkZFU61Zgj+ICaBjB5+T7r1D+mBkT8eS4U3xIzZ3gOM46dSaHr7gs2
         4Z2jf/Xrxa40DQpg+qybQeTtBbf/HUYeh6H750Q18GrDinUi0rQxH8aIpa3bjDiktZzj
         a7zg==
X-Gm-Message-State: AOAM530mOQXysrp+ahCZeifX+ObDtasCyzpPwPeRLCE+ZAyv527nD+nY
        FF0WZOHtStuOWbpEsdL7en9eR693o3A=
X-Google-Smtp-Source: ABdhPJyL+ONQKKz2WT8OVKHKyi+s1c6O+NGOtB4Ij3TgkDX1Q/RWspsXGBGtOWiHRHwj6SoQlOtVbw==
X-Received: by 2002:a05:6214:1d23:b0:432:c15c:a09a with SMTP id f3-20020a0562141d2300b00432c15ca09amr11255706qvd.34.1646721755053;
        Mon, 07 Mar 2022 22:42:35 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id de18-20020a05620a371200b00662cf4b5631sm7314617qkb.23.2022.03.07.22.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:42:34 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     prabhakar.csengg@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] media: davinci: Use platform_get_irq() to get the interrupt
Date:   Tue,  8 Mar 2022 06:42:28 +0000
Message-Id: <20220308064228.2078109-1-chi.minghao@zte.com.cn>
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

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/media/platform/davinci/vpfe_capture.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 0a2226b321d7..b3cafa16a1ad 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -1674,11 +1674,10 @@ static int vpfe_probe(struct platform_device *pdev)
 {
 	struct vpfe_subdev_info *sdinfo;
 	struct vpfe_config *vpfe_cfg;
-	struct resource *res1;
 	struct vpfe_device *vpfe_dev;
 	struct i2c_adapter *i2c_adap;
 	struct video_device *vfd;
-	int ret, i, j;
+	int ret, i, j, irq;
 	int num_subdevs = 0;
 
 	/* Get the pointer to the device object */
@@ -1717,24 +1716,24 @@ static int vpfe_probe(struct platform_device *pdev)
 
 	strscpy(ccdc_cfg->name, vpfe_cfg->ccdc, sizeof(ccdc_cfg->name));
 	/* Get VINT0 irq resource */
-	res1 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res1) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		v4l2_err(pdev->dev.driver,
 			 "Unable to get interrupt for VINT0\n");
 		ret = -ENODEV;
 		goto probe_free_ccdc_cfg_mem;
 	}
-	vpfe_dev->ccdc_irq0 = res1->start;
+	vpfe_dev->ccdc_irq0 = irq;
 
 	/* Get VINT1 irq resource */
-	res1 = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-	if (!res1) {
+	irq = platform_get_irq(pdev, 1);
+	if (irq < 0) {
 		v4l2_err(pdev->dev.driver,
 			 "Unable to get interrupt for VINT1\n");
 		ret = -ENODEV;
 		goto probe_free_ccdc_cfg_mem;
 	}
-	vpfe_dev->ccdc_irq1 = res1->start;
+	vpfe_dev->ccdc_irq1 = irq;
 
 	ret = request_irq(vpfe_dev->ccdc_irq0, vpfe_isr, 0,
 			  "vpfe_capture0", vpfe_dev);
-- 
2.25.1

