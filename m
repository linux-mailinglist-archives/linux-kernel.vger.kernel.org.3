Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E25283BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiEPMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbiEPL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3B516596;
        Mon, 16 May 2022 04:59:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l18so28140973ejc.7;
        Mon, 16 May 2022 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijndZeMokX/hEJkaDxQ/IoPAmAy206jKv8vbR7k2snk=;
        b=h5qaa5vCkXXVcZNO1QqCMQAIp7ZLuKfNhYWysWVgoyL66gim/KjrgSjoS65AU29ud7
         42VkFP/v6+QpOYN/xvPYgOYU7pH+d45e76LDj8m9c2kQkMkKimDNw8Ujco05BgFBpb7J
         oGdHvEM6WK24fYWFs7UZaAtskaF/aEXdNkLFoYB+NKQX2Ka4121gbkk14WQ7HN7Q29M+
         1ph4E5IbWsypBG4iqZGa0m5ERGhCvYQbTlYmYfcOoW2bjSnOtZp5GY1S5XOctWlGouGx
         cplv1akofNnKwSptEpphegTQdkQGS7Ndbrt5UZ1rCz88Da1v/OIIkv/C5Ff0tpSDH40u
         Qfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijndZeMokX/hEJkaDxQ/IoPAmAy206jKv8vbR7k2snk=;
        b=l3VxZvDAFIG7TiOeJfZ3GSscF8h+WLpZzvdsE/KP8AZF96qbk9xmD8UKMcdj+7ULcy
         vMPwfybA65M2GeH80OPOzWv/lqgnFKv0FdZfNQSzs2qgj+t/SLzzSiDLtzR4zVr4TUOS
         dnJKCTGpcV4as+lZyiNLEaubMq1kPoLz9To9Ui5QOnqu/uXTu1L1Cpd52KdxuOZs18Dl
         Yiwt2qKOBpHZm/kKwqwyosCm0+mEimYdHWIgpgr7wmdtInp1UTFmh2g0ELnTmyKAL0cq
         QUG8vSB7fOLtuF7uWBopFGHcT2Y6kX/Vb+xOCwFaO50EnLcn8LFU+LQNzTfsvaehYyvl
         Yj0A==
X-Gm-Message-State: AOAM5317w/LdiiOPiiwT2PB1meY1Dj/9ZcDxze1HZEepVVMBx52dHcMN
        Rja6tDvh3jfCO6xVP5J1hgF7Vh85djo=
X-Google-Smtp-Source: ABdhPJx/cDamiwiWlibYkBKC8V1pm/jPhnUWDYI8f8yVrHf0mOBKx1FpuyesASQq63NRQGd9mplA5Q==
X-Received: by 2002:a17:906:4786:b0:6f9:635f:72a7 with SMTP id cw6-20020a170906478600b006f9635f72a7mr15385967ejc.326.1652702371721;
        Mon, 16 May 2022 04:59:31 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:31 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/17] ARM: dts: imx6q-apalis: Disable HDMI
Date:   Mon, 16 May 2022 13:58:37 +0200
Message-Id: <20220516115846.58328-10-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

This allows to enable it in an overlay per the current system
configuration.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 4 ----
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 4 ----
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 948bbece3ab5..2436f9a1e18c 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -74,10 +74,6 @@
 	status = "okay";
 };
 
-&hdmi {
-	status = "okay";
-};
-
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index beb1981fc775..b254e96d194a 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -81,10 +81,6 @@
 	status = "okay";
 };
 
-&hdmi {
-	status = "okay";
-};
-
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 28e5d6b68530..97ddf4621bdf 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -80,10 +80,6 @@
 	status = "okay";
 };
 
-&hdmi {
-	status = "okay";
-};
-
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	status = "okay";
-- 
2.20.1

