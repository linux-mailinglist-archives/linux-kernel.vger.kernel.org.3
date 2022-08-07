Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67358BAD6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiHGM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiHGM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:27:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D18BC9D;
        Sun,  7 Aug 2022 05:27:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o3so6344409ple.5;
        Sun, 07 Aug 2022 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wBAib5lIj4PJUGlyk4iTQzVyGIBH+CGO5pPhuP30EHg=;
        b=PUDC2IIQRPWZaLKg5j4NoAxtZknUO2RQ6OMTliQSBQMejjRC+zIRVOJeg4Btkhr8Wu
         D1HdkwGaRwMZKIliT9FFNPoeP6fH/2YUmn//XW+aMqyfysjjEtd/eGJCJ+gUxftGB69S
         m61KXZ+a60W8DzNnmZ92B/yxxd2cyzgvkinnbS9UFYl8Iuj6FMQs3DE0AdgX6N+qXjsK
         N7xRTrNTuABf6/nyt1sslsdAR+LNorR0xanYA8DdL9tESqkM4HSN70uV21CH7e49Nt4r
         iXNHVnY4mrFRHf2v8V0vNmu/bNPFgPK+/Yzdh3t+qLzoI0R3gtGgUnETUu85Nswk1h9N
         ogEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wBAib5lIj4PJUGlyk4iTQzVyGIBH+CGO5pPhuP30EHg=;
        b=jnrO2k1TlTPsGLkVSojg3i5/xqhfCxnCMXPyuefYSbKiHYLzhs8EQj3JA4L790dMSu
         qKKCaDIcgi7ok8pPRq4L4R8Gyhu/S0/DzZDMC0offaWbJY8TSRcT6PRA9nYmaI6Kjbv4
         mOQPAhgTnNmnAKdnLyPiHj+b4pZxXNdV7EFrGj8bSjKVZ+6kzP+l4D6GP0cA6X79lby5
         v4EWFoDMG/3dBVAwhzdSFgNF8B3zfRe0OIg6+jdqMaheziVTaRsknzGufxGPEAKSiyF/
         zUi6mXptuqb1Ptk/r5dJvuakpza/PCWzxqqH/yCsYf4vcTidcZ2Z99Io9OMgyDK03MI8
         oTPQ==
X-Gm-Message-State: ACgBeo2cWb3R/TtSU5xJ+ym5BwD3Fh7SjzYWAyQK3nYfYEj71Imdk3E0
        y3p7565yNmr2JAohNbH97BY=
X-Google-Smtp-Source: AA6agR5LeRELmDiZAAxgS+mUHslGi2AL4mX/OT6YLOWhzCNtQm7Fn4niAptlu1/dzlAi7G4z0T5D4Q==
X-Received: by 2002:a17:90b:1894:b0:1f5:1041:a4ed with SMTP id mn20-20020a17090b189400b001f51041a4edmr16358767pjb.125.1659875237512;
        Sun, 07 Aug 2022 05:27:17 -0700 (PDT)
Received: from Redmi-G.localdomain ([112.0.190.111])
        by smtp.googlemail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm6716709plf.20.2022.08.07.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 05:27:16 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH 2/2] pinctrl: qcom: sc8180x: Fix wrong pin numbers
Date:   Sun,  7 Aug 2022 20:26:45 +0800
Message-Id: <20220807122645.13830-3-mollysophia379@gmail.com>
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

The pin numbers for UFS_RESET and SDC2_* are not
consistent in the pinctrl driver for sc8180x.
So fix it.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-sc8180x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
index b4bf009fe23e..704a99d2f93c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
@@ -530,10 +530,10 @@ DECLARE_MSM_GPIO_PINS(187);
 DECLARE_MSM_GPIO_PINS(188);
 DECLARE_MSM_GPIO_PINS(189);
 
-static const unsigned int sdc2_clk_pins[] = { 190 };
-static const unsigned int sdc2_cmd_pins[] = { 191 };
-static const unsigned int sdc2_data_pins[] = { 192 };
-static const unsigned int ufs_reset_pins[] = { 193 };
+static const unsigned int ufs_reset_pins[] = { 190 };
+static const unsigned int sdc2_clk_pins[] = { 191 };
+static const unsigned int sdc2_cmd_pins[] = { 192 };
+static const unsigned int sdc2_data_pins[] = { 193 };
 
 enum sc8180x_functions {
 	msm_mux_adsp_ext,
-- 
2.25.1

