Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF36B4FEA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiDLXf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiDLXcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:43 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4C14B03B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:25:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e189so208641oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt6hVezA4Ogh+PUM8JOZYwYjeiXqtSjEWHLo3rQRGl8=;
        b=rsrmN9GV2IuXGuywIbghXo04lZLtLq4A5BKYi11L5WMpei/I566zW/OwMuSj8sIspk
         h7JOTTAhevGgnMeH1vcnsGwCLaXOZGgt7nsmf2OKd6lhsmLkhUIPY98904dc1jZiNxTe
         e6QH2lMeq7jk8bdiNjXZIje95okyFWz3TzE/jLCy/hIAiXVOTdxhGjF0QYYFWv4HqDjA
         jtdkXHjQDKtWdF1buIm3Y9ezgu+i7x1PX1/Du2Rk67FNhzt+bujjUXvaq60d0Ep9QfO9
         NLHm++jtQ5HBWjwRNL23gzouVMgDCfcWdWNS7QrKPZQvBG/IVjc45xK/ifjt7AcppnUs
         LGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt6hVezA4Ogh+PUM8JOZYwYjeiXqtSjEWHLo3rQRGl8=;
        b=aNjt2qmfxiT2gZ7pWMW03CnjjBxLWfz3bmdsmOr4qEOizE8eZ9LDSH3hAbtEjxtkO4
         sqw87WglH/adyDHPD3/bqu5mc6aarM/3CiV64P/gCxOiysZshHzVkYxyMFxgbnFWJxRd
         VnYaeoit3xJdL8ahxHcp2oUh4y0CXLAW5qHLCKtWP0r4st79+RGfibatdnr1uZL75aIv
         3bh+m2dLYdDlK4/cyAQ5qGbJrN1c4Yj2vYS8hhDz5VdkAY21pzaKd4Ym6CKqgZ87en3x
         5CU7znic8oYgv8SDhrKaVL86qRJB6C/pxKmlTbha0dRkhwm6rJ4OT/9IcvP13DQCX7tC
         PujQ==
X-Gm-Message-State: AOAM531SFDaiXz5KTxrIGIVMWYcf5Hdg8ddvgji5YETgknC0UuX8M4PO
        0CcGSBBY4dqqzHrXJ7L/TjYafO2U/I1Trxxw
X-Google-Smtp-Source: ABdhPJzDXnuMXj8lsWFh9MLTAE6t9BXfQ7i8D5Ywu7RnBrVjybChs3FdEk4GVHksS5/5SqXipery7g==
X-Received: by 2002:a05:6871:1d4:b0:de:6122:2bbb with SMTP id q20-20020a05687101d400b000de61222bbbmr2978500oad.210.1649798865016;
        Tue, 12 Apr 2022 14:27:45 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id r8-20020a05683001c800b005cdadc2a837sm13831278ota.70.2022.04.12.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:27:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: gpi: Add SM8350 support
Date:   Tue, 12 Apr 2022 14:29:59 -0700
Message-Id: <20220412212959.2385085-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8350 platform does, like the SM8450, provide a set of GPI
controllers with an ee-offset of 0x10000. Add this to the driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This depends on the ee-offset series previously posted by Vinod:
https://lore.kernel.org/all/20220406132508.1029348-1-vkoul@kernel.org/

 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 0b402d923eae..d8fad6a77560 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2289,6 +2289,7 @@ static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
 	{ },
 };
-- 
2.35.1

