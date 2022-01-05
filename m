Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139B5484E83
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiAEGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAEGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:55:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC8C061761;
        Tue,  4 Jan 2022 22:55:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so2536576pjo.5;
        Tue, 04 Jan 2022 22:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHxFeGstP+BCXd0DmZ0cI7hC6yOkXgvah7Oc0RjtuNs=;
        b=GLoFpMGNKiFPL/vgy5ycwpjECekm+ySa0v7tWmHismDoSqyuOyArBKPZxRnCyA9f3R
         wQtO8jH2azwkhtkiKl5ddARyu+HPpALtEaTmcEk+bEEvRTp3M7Tz1avr1AfsagR71n26
         xvEZPbe4PlpMyflrYFpJvB63Gupc6olvCsSUapc0dCrQtQa4nGc5U9oo/ZpLyp45ZPbF
         ba47xQpORylQJig3oPaLNV2hTQ/2jocthGZhRaDZ8jUghbP0t1CDuxBfBUc9rilOmt9z
         czJbJa+GQmHGDTyfgM4fb/5ZYO94hw2ZavI4lSVTMEJpE2WxXYdhowqRfRzp2OJgCB9S
         tfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHxFeGstP+BCXd0DmZ0cI7hC6yOkXgvah7Oc0RjtuNs=;
        b=MqbpwOHIg6NEM+ePeHw5O8FvL/JnVNq6AdFmN1puBnXWpuo4hw15espxmrXxic42pC
         EHNJuc9nytbe68M7asxOqqAWrHDxpZ6FKtVVH1WoAmXYRBgPXmi02MdScYmcCik6sg1n
         MMGCsZOHPgCWfgk9NkNaAbQhbGzEvDtg12J0FVP/eJUPsT9Tj4lpbVeSF4UG5F34I9ed
         afrzjE19Gv9hLZVpf48b024uuYaYoNKHQDDUnnnozYyzl4chTzeczTvxIUBNdWeoiIXG
         6722kBpV5WabV12kMfEZGRecLARCZYenkAuIhhKqneTSGRL7bh0HG6j1s2EXdCBGibiy
         19Vg==
X-Gm-Message-State: AOAM531en2bVWFqQuUXQEsCu17uELyN94J7EDL1SzvLgnZGLRxZ7/W/y
        bnAhWVQiYkjbLN2sBhLYvZk=
X-Google-Smtp-Source: ABdhPJxdu+y7yQDhhdgXnDlHYuij2+dsSdeqHjfVdy6OkK31STIiaQ5NIVCcn4sHn4HEaK8+Qu/h4A==
X-Received: by 2002:a17:902:6a88:b0:149:848f:1e8b with SMTP id n8-20020a1709026a8800b00149848f1e8bmr39768252plk.124.1641365721850;
        Tue, 04 Jan 2022 22:55:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id m16sm46964903pfk.32.2022.01.04.22.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 22:55:21 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     vladimir.zapolskiy@linaro.org
Cc:     agross@kernel.org, balbi@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linmq006@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: dwc3-qcom: Add missing platform_device_put() in dwc3_qcom_acpi_register_core
Date:   Wed,  5 Jan 2022 06:55:17 +0000
Message-Id: <20220105065517.6967-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <83d55401-d8b3-f709-c77a-fa0e09fda27f@linaro.org>
References: <83d55401-d8b3-f709-c77a-fa0e09fda27f@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing platform_device_put() before return from
dwc3_qcom_acpi_register_core in the error handling case.

Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- add fixes tag.
- do error handling in a unified way.
- add necessary blank line.
---
 drivers/usb/dwc3/dwc3-qcom.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3cb01cdd02c2..f7f4af4c4ce5 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -598,8 +598,10 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	qcom->dwc3->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
 	child_res = kcalloc(2, sizeof(*child_res), GFP_KERNEL);
-	if (!child_res)
-		return -ENOMEM;
+	if (!child_res) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -637,9 +639,14 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add device\n");
 		device_remove_software_node(&qcom->dwc3->dev);
+		goto out;
 	}
 
+	kfree(child_res);
+	return 0;
+
 out:
+	platform_device_put(qcom->dwc3);
 	kfree(child_res);
 	return ret;
 }
-- 
2.17.1

