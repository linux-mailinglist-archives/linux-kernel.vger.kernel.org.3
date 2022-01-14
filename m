Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0E48E42B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiANGSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiANGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:18:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B4C061574;
        Thu, 13 Jan 2022 22:18:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id f144so1147491pfa.6;
        Thu, 13 Jan 2022 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=P7I6VaE87nRYEstDp+uq11bjIAOgfEzIQh4DoOK5I2k=;
        b=qe9as3lG4cg4d11XtFLXqvRFNvZMNnNnIdE+gPaK3SFr4zp6zwuxYyFC5i0tv5TtTz
         zjAIcTezNFAI1yJWMHmkN1gY+NfhHuwweyxUCtK5fno4YDIU3Kuz1cHXFkym6XCxBAWI
         iqlPFhlAEN4dSWh61WkITrZRSp0TDfjnNOTc6shj9xNYue1dTBZXx6HSFx4V++8sU+55
         2xRcARCv7ky1ZRin/ot+OaQb6GEOsnk3Ym0u0GWKxLHsmFeCIKe+mfwEHpZtNfVQoLO0
         rqTYQk/DGCw1e3mQENDa3EFAvRjo+ZzBNdtdTSHyz6x6GHWL7ArD4fXIVa7svdTCm2Re
         yCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P7I6VaE87nRYEstDp+uq11bjIAOgfEzIQh4DoOK5I2k=;
        b=IrwpumvxVvyrO6vcztlir85cyB2gnx8MPIPKb7VUFTFxCYr87ze/oNSXThfQzrqJiD
         u6yo5BtTCF1ebHXQeRMVV1jVIARmntFsUMidg5cUG8Bn2ORnI8H4jGzC83PztjaCL8ST
         SRJm7vE5p7UC6tsa7p0LYnATCyuNMSKJxjKL47RfApBnb+fxdQrGlSoBp6VCzsBmOJyU
         kPkjeioKx6Md5u1ylHRM+E3FD3ZiTzIALxgtDzIsoc0u9utVYNUazTxC0BAOw/9316ZH
         /I8ELuGvT9JH/MqfmZCz09jrUhIVdy2rky72DiAJORP7/2UrmVaiqSnCAjBckw3ak28M
         bKyQ==
X-Gm-Message-State: AOAM533nlWZKMMlDEIl8oVd9nCEaEmFEFeSb94/RSgZkw9Hr28YqIFpr
        R4Gy1uNbLvPIaVVxVvwM74g=
X-Google-Smtp-Source: ABdhPJxDVsI0xYs0EXSiOjEYrv7EF3fAnGjGjUzRXG0ePAETn2CzuaiK1U+JTS0VUpNjF5BAA5/L5Q==
X-Received: by 2002:a63:6bc3:: with SMTP id g186mr6897880pgc.192.1642141122952;
        Thu, 13 Jan 2022 22:18:42 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pi7sm1871131pjb.23.2022.01.13.22.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:18:42 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] slimbus: qcom:  Fix IRQ check in qcom_slim_probe
Date:   Fri, 14 Jan 2022 06:18:29 +0000
Message-Id: <20220114061830.13456-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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
2.17.1

