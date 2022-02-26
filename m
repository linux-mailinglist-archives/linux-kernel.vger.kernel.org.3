Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77F4C57B0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiBZSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiBZSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:38 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8F27EDDD;
        Sat, 26 Feb 2022 10:42:02 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g24so7310145qkl.3;
        Sat, 26 Feb 2022 10:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im3jhqbRxcVhFb0LH+3d/Ku9WkG9V/8mj+qtSjXi2MQ=;
        b=Ghkzii35oEk0YNg6aKLT06vzZxLa3oWyc8XXhLkK50PQvvtyAZ44Poo+pCTWs3/FYP
         VG+UdXBgWy6ag7Cfs2cHJ0bPZPm7x1GsCwp4nKcdnGWpg1BgbTOaLovYZ+NolLFzqtLH
         FaOGERTBPDxNQUb/av0MME2hS8Pm4u+1wZ/D424jQg48qq0oDYa0kBkPxZXYvXvCF6nj
         +zdA2CNMTMbwApgREqeBE3u1+7SK5A3YnjIUTZw45LSTTQhkMe7NV78iTUoXMmUQrZvt
         3d+ZfhmhaqTsIo87prgrjpxnO2V3xRAthKeTnexl4kvWUaELlz8MDh8CuRkMDYRIPle9
         KiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im3jhqbRxcVhFb0LH+3d/Ku9WkG9V/8mj+qtSjXi2MQ=;
        b=tmZzArOY/tw5gNvOHmFA01OjA6PC6XLiybfio2sI9zxpZkxOrATEJ1GCcEsiUDzqP1
         XaeuxmZAiEIr+2buN1Y6j/iCQt7WQGwJu4FF6fZJtEfdenAeZ6rKIvTVyC6vpvY12w8v
         ovJ/XiLt5Uu396lLscsr6tsoDppBiEwyOS/N8PHLNGF/Ad3liq6HVCfSHb+sj1BItPqK
         NT+KL0ZE8b0cQmLvAlBeEh3zp7YY6JtP6Nmw9WTTUB2Sq2fHQENa9aYYrSurAMTMrOtM
         d7jBIcPzeqa495B0VECyqi0s0gu5UkO9AJXMjKc7VWTBjHkINJoMQ6dmmbdccBhsWMDE
         NGQA==
X-Gm-Message-State: AOAM5331uFdV0Nhv13A/HvIJBjbJtfCiTnVbKuR1TxtBEUZW+ZyBHP4K
        zFhzeFmvsc/EiTI4798WQtSjClVPeHYybA==
X-Google-Smtp-Source: ABdhPJym8DP8QPfFSS/2U7TpSb8ylxzl1V/5tXc7tQFPh+tZlC8Q//yyix0ycdxzLkpBzfZ7lwweGQ==
X-Received: by 2002:a37:e213:0:b0:5f1:8911:855e with SMTP id g19-20020a37e213000000b005f18911855emr7748469qki.174.1645900921264;
        Sat, 26 Feb 2022 10:42:01 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:42:01 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, Peter Geis <pgwipeout@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] usb: dwc3: convert dwc3-of-simple to use match-data
Date:   Sat, 26 Feb 2022 13:41:43 -0500
Message-Id: <20220226184147.769964-8-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

The upcoming support for rk3568 will reuse data from rk3399.
Instead of adding a bunch of of_device_is_compatible as we add support
for new devices, lets get ahead of the problem and use of_match_data
instead.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 39 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 9dc6295df6b1..57ba9427ad74 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -30,12 +30,16 @@ struct dwc3_of_simple {
 	bool			need_reset;
 };
 
+struct dwc3_of_simple_data {
+	bool			need_reset;
+};
+
 static int dwc3_of_simple_probe(struct platform_device *pdev)
 {
 	struct dwc3_of_simple	*simple;
 	struct device		*dev = &pdev->dev;
 	struct device_node	*np = dev->of_node;
-
+	const struct dwc3_of_simple_data *data = of_device_get_match_data(dev);
 	int			ret;
 
 	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
@@ -49,8 +53,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	 * Some controllers need to toggle the usb3-otg reset before trying to
 	 * initialize the PHY, otherwise the PHY times out.
 	 */
-	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
-		simple->need_reset = true;
+	if (data->need_reset)
+		simple->need_reset = data->need_reset;
 
 	simple->resets = of_reset_control_array_get(np, false, true,
 						    true);
@@ -170,13 +174,30 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 			dwc3_of_simple_runtime_resume, NULL)
 };
 
+static const struct dwc3_of_simple_data dwc3_of_simple_data_rk3399 = {
+	.need_reset = true,
+};
+
 static const struct of_device_id of_dwc3_simple_match[] = {
-	{ .compatible = "allwinner,sun50i-h6-dwc3" },
-	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-	{ .compatible = "hisilicon,hi3670-dwc3" },
-	{ .compatible = "intel,keembay-dwc3" },
-	{ .compatible = "rockchip,rk3399-dwc3" },
-	{ .compatible = "sprd,sc9860-dwc3" },
+	{
+		.compatible = "allwinner,sun50i-h6-dwc3",
+	},
+	{
+		.compatible = "cavium,octeon-7130-usb-uctl",
+	},
+	{
+		.compatible = "hisilicon,hi3670-dwc3",
+	},
+	{
+		.compatible = "intel,keembay-dwc3",
+	},
+	{
+		.compatible = "rockchip,rk3399-dwc3",
+		.data = &dwc3_of_simple_data_rk3399,
+	},
+	{
+		.compatible = "sprd,sc9860-dwc3",
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.25.1

