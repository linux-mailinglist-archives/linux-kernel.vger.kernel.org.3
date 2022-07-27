Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1E581D30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiG0BeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiG0Bdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:33:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540733B943
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:33:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 21-20020a630015000000b0041b022ba974so2981954pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1N3h8/3xSQWX6SxOF5BPCgS/YJL4wXTsZ8CkYeFIT3M=;
        b=QpSGMoTn06o1HCqJaequgVUCWVDL6y7V2pJAXhgcZslE7hepnB5qO5bhCsayf8BgZT
         ioAnJDRO4dHDHZqT9epxdMWWuTHPxYpYQv7N9ry1QlIk5/V+cdUycj6fXPdRo+zdPUo4
         +0Z324w4ZR5jGLPTe46w9q+JE1ZZ5ABziZoQBzBQTrwwhqWlRBOLEcHVBm9L7dK5/Xdi
         xfKd8NoIGd/LYe/RpZOiwPs5NxYvdylykP+HFfsBwc/HIFJB2XohGmZzvFpXtiCPc2sI
         KLyTgTV/B/ZJi0VZmQ1yZMC9+h2YpRh2EOANQBwbCIdYGeqvIQFkcbdQymaE9OuWqLHy
         Y7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1N3h8/3xSQWX6SxOF5BPCgS/YJL4wXTsZ8CkYeFIT3M=;
        b=wfDT4xD1vCk/dOrkuh1o469g7D7xqOPBxBsdRD91mg+XFjfYv01JD0tfYdVqM+ghxu
         S/LT6Btx9vJjXfJrm9O52fkUT7z1t+QPOM0ldwmxEjVn6UW+78HwqU+idU1k6/fjJTDG
         CvbqbuqVAx2Vb6JyCMJtjks8jERrubEZph1lrFeIoH0XQ2ZbcdV+JK9q6RSw9XXpYUWE
         giAZ0yhvH8d85owByTvW03SazyYN0cXThjGRy2OpMV8+do0vp6cw7cBAY1j4bo4dbOWo
         hR1RjBNOw+4dnNuSLK9+O3xghEfEb/Nh4x7F5OjqSCt+k7PT62jaaXIV00kEyb7tgsYd
         Cb+Q==
X-Gm-Message-State: AJIora/4DYklsPY1T/AmH7EY1sms/GreN1tmkB21T6X0LdoIheG2+IPO
        aDAGjCc1AIpHQk21xaoVEmO1DBGHQ+faYuc=
X-Google-Smtp-Source: AGRyM1tNXxJJfexei0sXfG1FBir9ecawTKSUmr8oBmd7eGPMiF6IiFNkyG65ifGlltihpNEjyyTucthrEgJjoHc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f771:727:f95a:5335])
 (user=saravanak job=sendgmr) by 2002:a17:90a:6b45:b0:1e3:3cfa:3104 with SMTP
 id x5-20020a17090a6b4500b001e33cfa3104mr1862493pjl.113.1658885633796; Tue, 26
 Jul 2022 18:33:53 -0700 (PDT)
Date:   Tue, 26 Jul 2022 18:33:48 -0700
Message-Id: <20220727013349.3056826-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1] pinctrl: samsung: Finish initializing the gpios before
 registering them
From:   Saravana Kannan <saravanak@google.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as a gpio is registered, it should be usable by a consumer. So,
do all the initialization before registering the gpios. Without this
change, a consumer can request a GPIO IRQ and have the gpio to IRQ
mapping fail.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 26d309d2516d..a302b38a63a8 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1168,15 +1168,15 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put_banks;
 
-	ret = samsung_gpiolib_register(pdev, drvdata);
-	if (ret)
-		goto err_unregister;
-
 	if (ctrl->eint_gpio_init)
 		ctrl->eint_gpio_init(drvdata);
 	if (ctrl->eint_wkup_init)
 		ctrl->eint_wkup_init(drvdata);
 
+	ret = samsung_gpiolib_register(pdev, drvdata);
+	if (ret)
+		goto err_unregister;
+
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
-- 
2.37.1.359.gd136c6c3e2-goog

