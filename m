Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83457166A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiGLKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiGLKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:01:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61165AAB12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so4481507wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=lV+xkoO3XvuZqxuUx+8KA5Xdc4YNeiFJMsqgHefyH9kDbZM2XA/UczHrvF/TP4zVBM
         SM6WPuvKI5XL8tLbc7bZ3A3TI2V+Fvy8lGc3PMcGL+NnUqTOxx/fP8JjUummq3OVCx3T
         W7TmEaR76GXZlqcTMffTcVQQXLZcasYQh2jNQYf68RRP2TNeToFFOVt7Zv/C9uLRlrlk
         23IL3R9HOy8UuQaiIF6/0BNh4NkI4sKVfdlNLr72y3q0uke9wKmsix6bBXGkpFb+U5gh
         v2hrWbv9qFHNgNm0FJeKHarvu/I57yNPIxvML4eUqzdI9GkoSnARVJsN9a6id30ElKjT
         YZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=rK0sAkXfeqMwtfsSdSmJFtdMtQoT0H0OgRRWFmYWm4D5qQAJq8hANW5hTet21JdNBv
         oUwHujVfLs8GJpl842wc1OKeC/BOuuR0d5nZ+E7Rq/3UiAMb3bZMU/Td0kzbFa3ztFox
         o624nYpidzJUr+HBH6Qre89TLJxhYYgpvtXoebmHfbjfCAI4k0NrcR59VD6hfrE5Dtma
         ftygmTI5gZb+Fk8gAf7XtEnW+Q0uKkWkRlJwaIjbjlAEc45GRPliLV8ibOBL4+DoKmsT
         zCXcwkuSVc3aX7Q9SNtQ09unQba0suAATDcGXW2LzBsPTsGAL0wgGk9BLowXs9HWN2cw
         1KuA==
X-Gm-Message-State: AJIora/6euU4gH/2yD6kNOK74xLm8mOxAlZdAEnkM19sGLA+0MBtELRB
        AH/1srjJdtkFYJFlSwl5owd/7Q==
X-Google-Smtp-Source: AGRyM1tJxquk043k0mzYGxhVyIEZ3mYiqG6prO/A2PEsCT8YJX2j4n4MebzwFHD2rQNNKrlIhgA5DA==
X-Received: by 2002:a7b:c381:0:b0:3a2:aef9:8df4 with SMTP id s1-20020a7bc381000000b003a2aef98df4mr2971359wmj.7.1657620077777;
        Tue, 12 Jul 2022 03:01:17 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:17 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 2/7] pwm: move dwc memory alloc to own function
Date:   Tue, 12 Jul 2022 11:01:08 +0100
Message-Id: <20220712100113.569042-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712100113.569042-1-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
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

