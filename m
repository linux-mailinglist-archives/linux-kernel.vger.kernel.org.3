Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBBD58BAD3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiHGM1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiHGM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:27:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69555B7FA;
        Sun,  7 Aug 2022 05:27:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f65so6336051pgc.12;
        Sun, 07 Aug 2022 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8zU84gQmE6XXoGBx6p/jfGHY5q82lsww29jgFqcrpdo=;
        b=jXMHDp9wifXmiAPmpRE+z/oUm/JwLrA/lfAcSepkyoy2SDwMqtd+ZlKwLHUUSLXuMl
         37cR6t9RXHxlszTM33hZ6wkA0g4O2SkHG0mTR47F/NVe3k5VE5GvBf0j8oxVtdc70BiU
         5hsRXN0rypNT4NaT44S1Jy1lmzXLjJgvIXTXmN+d2fo3eXx0aTWiyeVdCH+wUl9XSjgv
         JKU4Ws08NfKkuVkkYVC/0AiAo1AHsRKaELv56tQhRvj2KtNp+y2O+izjNO8Mv6egJKsA
         b8WGZBz10B4YVir/ifTVdjYlARZZ2Vrgkk1dSwY4Og32CZahHSa8pdCr48dsSEWBt+tx
         s+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8zU84gQmE6XXoGBx6p/jfGHY5q82lsww29jgFqcrpdo=;
        b=adlQ5B0AsXENv/FDl372+nvByehb1i0g7XuskAFmN6dKknsdMbv435sHaoq8ymKmuQ
         MctMTcT5rbwrFheLPBfeBcJ6lF/ED7BkInNxAsB9QvvuKlTYvmwTq1ewI8Btg3nDsBG/
         5WtbbtQJosYlYV/R/tr4HoNOoBQUbjPyGmwCECC8AM0/kptay2mPjYOX3xg1oHZ5UvKy
         zSrZUMrfrichPMMyEWFK96/JceprqQN0Ur/EkyzSKBcVCRBEJqZiljAZr2HCU/S4wKF9
         O1SJjFOns52BHjJJHpT8koc57FzPQ6rel/Dq03Y91Lc6arpNeoew5hrlmxXf/ShElIIg
         cJrA==
X-Gm-Message-State: ACgBeo0c4hE6yH3vGpGDF0GO/qB5WgB2FbRfDE0uY7P8QDOsONKTJF4R
        HYKSdxeq2y8RGyBPqogqx/I=
X-Google-Smtp-Source: AA6agR56hO7U2HU+o1XnpqbGZdVQtP8cbvyygzF0+fcYbIisqKkUD5Lv9X2RmFBVp5L+V1XpvIP1Qw==
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id e132-20020a63698a000000b0041c8dfb29cbmr12065549pgc.170.1659875231899;
        Sun, 07 Aug 2022 05:27:11 -0700 (PDT)
Received: from Redmi-G.localdomain ([112.0.190.111])
        by smtp.googlemail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm6716709plf.20.2022.08.07.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 05:27:11 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH 1/2] pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
Date:   Sun,  7 Aug 2022 20:26:44 +0800
Message-Id: <20220807122645.13830-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807122645.13830-1-mollysophia379@gmail.com>
References: <20220807122645.13830-1-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in the wakeirq_map, gpio36 and gpio37 have the same wakeirq
number, resulting in gpio37 being unable to trigger interrupts.
It looks like that this is a typo in the wakeirq map. So fix it.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-sc8180x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
index 6bec7f143134..b4bf009fe23e 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
@@ -1582,7 +1582,7 @@ static const int sc8180x_acpi_reserved_gpios[] = {
 static const struct msm_gpio_wakeirq_map sc8180x_pdc_map[] = {
 	{ 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 }, { 12, 104 },
 	{ 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 }, { 30, 39 }, { 36, 43 },
-	{ 37, 43 }, { 38, 45 }, { 39, 118 }, { 39, 125 }, { 41, 47 },
+	{ 37, 44 }, { 38, 45 }, { 39, 118 }, { 39, 125 }, { 41, 47 },
 	{ 42, 48 }, { 46, 50 }, { 47, 49 }, { 48, 51 }, { 49, 53 }, { 50, 52 },
 	{ 51, 116 }, { 51, 123 }, { 53, 54 }, { 54, 55 }, { 55, 56 },
 	{ 56, 57 }, { 58, 58 }, { 60, 60 }, { 68, 62 }, { 70, 63 }, { 76, 86 },
-- 
2.25.1

