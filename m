Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F352117B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiEJJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbiEJJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:56:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5322A1FCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q23so23004213wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hR+ipPq2gap4bXepi4EzWC/gfjexmZUBGu30czl6wWU=;
        b=BeFQAi9aZgk45QJ7w9Vhk3mGoIsSKbyQ4S5AFdZo5s1FX3Z7q9fG5J4UqIVmaCsBtb
         9LzMPnCSCxwWOfo2lYUgOvmFROVKWYS8Uo3XLX478oURoNgyS3fOhrwqvsvYuawK0Y7l
         P+kD6mNlsvvBKRzdPc7WJ+SvW4+4bd8QwPpXL1rY3AGwcaCsuVGPV0pE0F1/i+LjR+Mk
         TGfUYClXbLCSmLIh/PA2nLoBvPH0wcXvX9wMLcYzMWfwISFrc7L8WZkVS/tKk/T/JxFZ
         C2YI/zvqS8YECAs331IRBH/TW35nYM/onXkSXwacy9TNkI8W7QvW09uudNKZVXYTufAM
         O7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hR+ipPq2gap4bXepi4EzWC/gfjexmZUBGu30czl6wWU=;
        b=nCGyhX2gX3KcS2iM2AusOR0OKTSNFi4faEKvwzutS9ye06JGjlQxU1TvwRRILrpAi8
         SUodefBAWus4ri39gtKwNpDD0yB1BCfYRhV2qk0mW+8ICV2y+0kVzFjEKzwAUWu3CWls
         /RfJeoSzKAeH+w2aCjRx2soTg13RcxjBvN9n9MDuNIZH+v5bdzENtEqHPUGJuU72kKX5
         Do0GsuidehBCg+iqB3/B5wybVBFWFULkVec9oMaOpRGEUMa41L9ikiK7u3LWbDsKNzrT
         yUOLIJSxSYa9Czt3J1GoLJnaXS3ZyWq0wGrhJgu80j/W1z+knAHqpznzPS6+ICrKpgy6
         h8NQ==
X-Gm-Message-State: AOAM531lSZaw0ii7rGb2hONEvyJrgR0m0T3WmSKdVsBneCrXd2Bjq0sT
        FrGG+cHye2Py3jdYUBICANAvUQ==
X-Google-Smtp-Source: ABdhPJyJns+f0pETxhqMd5d8T1+t0MZFj/yGNaffAv20q0sMO3H9qDh3MqaWBUXTdm48Rbey5F5z4w==
X-Received: by 2002:a5d:4312:0:b0:20c:af5f:bdcf with SMTP id h18-20020a5d4312000000b0020caf5fbdcfmr14910971wrq.498.1652176369243;
        Tue, 10 May 2022 02:52:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244f40sm2268252wms.25.2022.05.10.02.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:52:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] slimbus: qcom: Fix IRQ check in qcom_slim_probe
Date:   Tue, 10 May 2022 10:52:04 +0100
Message-Id: <20220510095205.337-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220510095205.337-1-srinivas.kandagatla@linaro.org>
References: <20220510095205.337-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

platform_get_irq() returns non-zero IRQ number on success,
negative error number on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Cc: stable@vger.kernel.org
Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index f04b961b96cd..ec58091fc948 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,9 +510,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (!ctrl->irq) {
+	if (ctrl->irq < 0) {
 		dev_err(&pdev->dev, "no slimbus IRQ\n");
-		return -ENODEV;
+		return ctrl->irq;
 	}
 
 	sctrl = &ctrl->ctrl;
-- 
2.21.0

