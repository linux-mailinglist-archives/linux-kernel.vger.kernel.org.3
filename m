Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BC5A9BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiIAPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiIAPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:41:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67A3E760;
        Thu,  1 Sep 2022 08:41:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id se27so27807718ejb.8;
        Thu, 01 Sep 2022 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UdAxssIJlstCZGaS8Jok9Kgh/CUKOzKmjtPHBIyHVi4=;
        b=LaVUqW7/5aaJGtTFd8WDfW48b8Qa3G6lf0BGE9xuAuERoiEANky9qxVZm7B7nbg/PB
         pvHYeUVIf0jAmSkWvMlXKCx/JgRcynWB9tmgqIgDWhp9nvlpOrKRn7vR8HqfYpEY543m
         LniA9a7v3HwM4P3OeHI1QwJy3f/ODBs7Qq/AE6ssGZ4pMgbGisGYbDDqw3IqLx4e1FS5
         tt9BemVlDg0NDtR8ws4vb9Y78mGlVzOzG7SIyJFkFqhfAJjSN+7pSdC1t4WfXhEipnKE
         jmzd0N1eXK3N9tKytuxq7V5czetDpxZlzBnOc1p3bx0hfHG8/J3CTPDN8kCVaoRXNRBx
         vYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UdAxssIJlstCZGaS8Jok9Kgh/CUKOzKmjtPHBIyHVi4=;
        b=1OS5UGb/HCEIscM2yQJIR23X5H9/IkCTtm/oS2n4p6X38XNFurAc9O15IIFAA3C8hQ
         5y8qnxzQ3bxV0b9w4/AgGfVUrhM3eyJ70ZP55222b1qGHHWAbbFZBoRmqEo2AtCMK4DX
         Xa7yVnsM0l6vdt3HcNElnGn87JzJ/1+CZ6tl9TZg147EjthUmS5JVMa28vomsUA1yWUU
         MoiYQ5/2yqpqSvfUCPGQLxD/4ot91jSaxD62D435zSB3j3PGnyS+pJas0xCvwppOCS+2
         YGwfEIhn6JOOPCs3Rp01xU7fodIPrJ9FlTYloZHs+O8EB285QgmOAzQ5jk3gY8PEOECb
         u6hA==
X-Gm-Message-State: ACgBeo0a3XZ1GAj+LRkyABSF5DgXw6D+mtwogY2JWmoux9zEup6xohH8
        0uXheqloLHhjEkopN1u2oSo=
X-Google-Smtp-Source: AA6agR6iDpQf1r7dRyqoRN8uoo+/0JfYGnx+uIepyVxknKh4bMh1Ff/C5w/BfILcoRJIi1boOhDMKA==
X-Received: by 2002:a17:906:9b89:b0:73d:6a55:c489 with SMTP id dd9-20020a1709069b8900b0073d6a55c489mr24666187ejc.406.1662046861059;
        Thu, 01 Sep 2022 08:41:01 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c25-20020a056402159900b00447b1772a26sm1543103edv.12.2022.09.01.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:41:00 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mp-verdin: add dsi to hdmi functionality
Date:   Thu,  1 Sep 2022 17:40:50 +0200
Message-Id: <20220901154051.1885509-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Add the hdmi connector present on the dsi to hdmi adapter now
required by the upstream lontium bridge driver.
The dsi to hdmi adapter is enabled in an device tree overlay.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 76cc89296150..bd84a0d135dc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -59,6 +59,14 @@ button-wakeup {
 		};
 	};
 
+	hdmi_connector: hdmi-connector {
+		compatible = "hdmi-connector";
+		ddc-i2c-bus = <&i2c2>;
+		label = "hdmi";
+		type = "a";
+		status = "disabled";
+	};
+
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
-- 
2.35.3

