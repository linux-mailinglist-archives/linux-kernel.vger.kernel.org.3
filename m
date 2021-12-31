Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE504823C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhLaLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLaLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:36:47 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA48C061574;
        Fri, 31 Dec 2021 03:36:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t123so23382625pfc.13;
        Fri, 31 Dec 2021 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1/UF0ncJUYwiLLzKEraXnHU13+tz0U123c7WptP7z5Y=;
        b=gp6BrgxTXFVQfR1+cp7I9Lsv8M8xOIo5oybzVN1oRSsD4aqOm/CJ4Sz4+q7vCXZ9cv
         7CdFaPFp5TtRls69NQIYoavLlsBCI5ne1W+ueNyFkLilIIWmpYjucy5fM+9K9XoqaPeo
         zXNgk+rfjdVG4vXeNDtZzH/LNX3F1N3H8i/19nitSOXtnR19odAFtiOJTppJ3pxpIOer
         wlDVLP5HeEBXfsKFQwLJWmna8wpwP80mXAHz/6GWlxyhF1SCSW1sydeBCCekHfLgCuk1
         EO5IzUXQLjGUiocHldAHc4jlz4YlBjIg9ANIIQDbrQUYryi9E4zjbjlO9PnaKyGHcDqc
         +Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1/UF0ncJUYwiLLzKEraXnHU13+tz0U123c7WptP7z5Y=;
        b=qCmMa/G6Simgkd1YuJ+6OpuT5+dKyxFcJcd6QPMPEK1Sn1quReFKH4vdIP7F0nTl3J
         snHD2f6KcrzHSr6tUpGJp8IKXEi64H3XxvShJGGkz/06wIgc9UKWh8G8EOC4deJ1mXQY
         WVmavMMCFxGClLCmGK82bDFQkcHwXIHzMPwnSsy3ySi8LEBnUymOmGFw7DohWWmufN0U
         lN6nz4zDFRK2w/O1BjmwsTvXNFfmr3MlMskSZDIKWcmhtZlhHrscs+QwxdJEGRT7nP5N
         kxR3ZsSMo0LRAETsJSl6UJ0QV9ukwrTzkYKw8LOZcZ8Uh2JJ4m7cPbZrdmn3XAugiWc7
         5JgQ==
X-Gm-Message-State: AOAM530nwN6z0Kj9Rscz+1zNV5O6qcNiZr9yjNDCxscA5IppCCwaNCmm
        zPC+Z9k/+KrjFD/V8TNAF94=
X-Google-Smtp-Source: ABdhPJyE7afA0OSGQwdpsYil4DdPNVqeivpZA14LhZUH7yEiDZqcuyvGBsDVC3/qAGA5O62LnAK8LA==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr15213032pga.371.1640950606698;
        Fri, 31 Dec 2021 03:36:46 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id e20sm8295460pfd.104.2021.12.31.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 03:36:46 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: dwc3-qcom: Add missing platform_device_put() in dwc3_qcom_acpi_register_core
Date:   Fri, 31 Dec 2021 11:36:41 +0000
Message-Id: <20211231113641.31474-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_put() before return from
dwc3_qcom_acpi_register_core in the error handling case.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3cb01cdd02c2..5257783f17b0 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -598,8 +598,10 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	qcom->dwc3->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
 	child_res = kcalloc(2, sizeof(*child_res), GFP_KERNEL);
-	if (!child_res)
+	if (!child_res) {
+		platform_device_put(qcom->dwc3);
 		return -ENOMEM;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -637,9 +639,13 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add device\n");
 		device_remove_software_node(&qcom->dwc3->dev);
+		goto out;
 	}
+	kfree(child_res);
+	return 0;
 
 out:
+	platform_device_put(qcom->dwc3);
 	kfree(child_res);
 	return ret;
 }
-- 
2.17.1

