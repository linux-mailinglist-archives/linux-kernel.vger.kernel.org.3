Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F454C7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347523AbiFOLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbiFOLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAF4DF7C;
        Wed, 15 Jun 2022 04:50:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so15702723edm.13;
        Wed, 15 Jun 2022 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOsg77BcWgr7gnFM+OgTQJkE/wzQHgLa6aUmenKQNwI=;
        b=B+cNlMySSFNbg5d+FlV1MUHBza9ntnX0xSUUGRq5lhISSm3Kj7s9/ZkWQpWSnUC89L
         fyDACn+6C76HAPxY8LBR3W8++ftw3uhPQlK3rkWmhYk9LroHqtQnIdSeSE+ZD2fgHwKe
         w9kkmIIbxaPpy3xsIRu+6+CU/hjyXBtUcbIqXU+Nrm/GiryiB8hVqVFQaus/x7szVAjM
         xx/IooCn/6kQZPKohyjZK4XdWwyVyGVDOAsu4jgSYE2DUwHsM5HdWwn+a6kgoDlui8+g
         DWNEs6NQxRkUKjNgQ/OMz46i0CPtu6O8J8iu8KxX3818MHViKVZqx6hDdyWqpuBQ867F
         AB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOsg77BcWgr7gnFM+OgTQJkE/wzQHgLa6aUmenKQNwI=;
        b=MD941+JX0DCI4xRMFL5N309g2IiAvfLrGJ1J0nL94QkEGVzOfSYJB4Q0kziR6QiVST
         FNN+7fLBc4hjmUDA7QpCBYAvI2DYLiUDwu2PtktnAhYR3HSHL7MpZDqXnZcU/v69gueD
         DGoD9lrMp7DNR2qKh5R7++oWlhJL9G8+ypGFLJ2DL3AO+MghoReQ8LpcPG3jXYTDLq5J
         QsU7X9yB6fp83jqiV9cbGc8oVsNH2fGMvFgY4cS+m0KgAJzz45/9AlUAnansRZRkTYho
         669jo+aUubR8f5Seoh2FRsGfXH+gLQzDfibPsceTTiBfJCYh73I/4bFZcPkPtPw40LZH
         MT4A==
X-Gm-Message-State: AOAM53383XS74A+mFTSaafMn+njsi5FoUwTkeaRgUmG5SrcD0fg9cbXy
        IJUspa0taIliuWccwuHI5xA=
X-Google-Smtp-Source: ABdhPJwrYv0HnbJxgpMI+NKkutK9hvbryZVM/wJmZJqPqVX8vqGNJoDT0uttaBIt6pIRXp0r+Vt3eg==
X-Received: by 2002:a05:6402:847:b0:42d:91ed:82f3 with SMTP id b7-20020a056402084700b0042d91ed82f3mr12626475edz.416.1655293856105;
        Wed, 15 Jun 2022 04:50:56 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:55 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/18] ARM: dts: imx6q-apalis: Disable HDMI
Date:   Wed, 15 Jun 2022 13:49:58 +0200
Message-Id: <20220615115006.45672-11-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
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

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 4 ----
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 4 ----
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 51efa7c57879..eeb20d7a637d 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -60,10 +60,6 @@
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
index 3d42f8ffeb34..a9daf1bb970f 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -66,10 +66,6 @@
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

