Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF962580666
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiGYVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiGYVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:22:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83224090
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h9so17742923wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=aSUJG9SjfQzeQbSHaQle5TiE99MFH/DrPYE4spsGZ3Mi+9LRUX/GxBPOSYwilhAL84
         GXB7TUPyLFdSHHMKXFXzHy74kYbM7JNHvU0e9gI1Hsr5dsmVT1LTOaHU4pesGBE7uEf0
         2IULc1rXisvRp7rWPLJhYcewa6uGyEul3UTV7T/jIFSAI7sM1CIg6pQ2+fIcKF3zYzXT
         gvwz+Wg0fLdFQtUleUafTLu+x+hNikVHzfhi4tQ/tCximBz9RF5nDYTK6L7W9nSL9VAz
         IEzCQrlGpPNyveUYzZCBqoNfNFe4q4dQxah2mk17DywMrHPH0EfXYx8tcaOvZ2tOLdCZ
         Ff0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=jpOo87H4NHCzbyp6gD6U2v5/8jPjTDHiiIIhVdwNo1byMEVsJ2l1eJwzY5r+nGxzr+
         uc+GPMdyS/POYzWTlak+MqAq12oWxjgV23gWznSusZfwbDwyPalIKUmdfqogw8+4FHqF
         pvdpNI3eq8ZFbAkZ57EFSrDddmqp9uLnE9zn3lbI3HS1bMQ2kVAha6Kwj9dVUbv5Ms1n
         YgP7PU6+jEWzCygpWAIvezfiZEOrR03U7ifUMH1zyZmQszKf78MxQjfmNSW/ORmPGeBu
         NWC0qlv+milxayDCFrJwnJuauXKt69iDiKBOwhlEinZS/gI/9Dwx9WlFIFVbNHlPHPjR
         uiCQ==
X-Gm-Message-State: AJIora+CxDiWa5AZV/t/2kyGniKh3Eg4WnWTFyaWKA1lAUh+65yR3ksX
        HBA3omwmC3qm+ouqQYMFvh1NeA==
X-Google-Smtp-Source: AGRyM1tfcnqu5pfLHxkI9dpvom1E5zBMe8+2o0+h8rxiHgHoZKAPO1zrGk9BYgoK4Bfu8QZEz9Elrg==
X-Received: by 2002:adf:f705:0:b0:21e:a2f6:2fbd with SMTP id r5-20020adff705000000b0021ea2f62fbdmr11404wrp.375.1658784128100;
        Mon, 25 Jul 2022 14:22:08 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:07 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 4/9] pwm: move dwc memory alloc to own function
Date:   Mon, 25 Jul 2022 22:21:35 +0100
Message-Id: <20220725212140.741644-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

