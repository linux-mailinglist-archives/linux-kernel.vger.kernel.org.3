Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24354C7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiFOLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbiFOLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF624F1C9;
        Wed, 15 Jun 2022 04:51:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so22683633ejb.11;
        Wed, 15 Jun 2022 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f66p0kMBxY73E/g74soR57z54u2uiQJKAItmpu/tNI=;
        b=GSbiBARVuzeZzIQ5z37nKh8xLbVn6DtsFP8tGnr0Bssj8MHIPnvcL1QLB4Ld9Ox/Xa
         v4bEOJ9KAwgqHxCXpLdQs8GgkJAnn43O+qhpB7gbfJa/tU3fDY5o2nzqo6eyxykknhki
         UClmEgrnZ1003yRiH78VsiAroWIQ1j0Jd/NbWJI++9a/q12FbJ4q76ZOaHubmxOD6lGU
         0jf8GhdjbN3jAGWimhGcb1hEA2YYZSG0a8WBHLFXL3jMLQczRe0AndhvFXWjhEhDFnrV
         yB3MX+d+6UemvLQvTeVu1P7oQa/4XInFw+rKOBlDGcD5TsEJhjByHzApjosuxE1yyuOV
         pP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f66p0kMBxY73E/g74soR57z54u2uiQJKAItmpu/tNI=;
        b=k32m+k9dMd8MDv6U8vgLBQjLmF2YXa9d+VcyW/HECZo5Br5DDB8VaOLPLxQmnYWt17
         v6ycrLOe3U4GrFy/J3JuWSVW9daO3vKi5pnmeEqx9fPmPf/owkL2S1PsjwhnkWDaoEni
         AFGBswjKVQ4TMM+S/4nbOC9haa232+b5293kHyhZCi4hZpW5jV+KtAqdWVunXvii1911
         rntzMfW/hioVpOIAWSv8YUAxWz3i+NvCbSdb+2R2NEuz1Y2ateZPaC2+n0/Hltk+QnhL
         gC7L1+w54/5KmygoeQY2+KtwwvcmcIE8+1p/iA+aJXLBp4kN+uGPKl/D5w+REWiY0p3m
         3lLw==
X-Gm-Message-State: AOAM530coPEFlVpUoEMHll/E5df9lovrTDVfKjE5E34UoFojnbeejVEO
        VJFEy/TO3WW9Eq73eRVPOQr89VcgSpNYmQ==
X-Google-Smtp-Source: ABdhPJw3exQGUeLKVBnRIM/7t4HtLaPBNv5i593bexm9gnEmX098Wg1uqI9aXC/jZlj737x5fNriOg==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr8206934ejj.278.1655293859642;
        Wed, 15 Jun 2022 04:50:59 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:59 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/18] ARM: dts: imx6q-apalis: Add adv7280 video input
Date:   Wed, 15 Jun 2022 13:50:01 +0200
Message-Id: <20220615115006.45672-14-max.oss.09@gmail.com>
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

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The Apalis iMX6 modules allow connecting a parallel video input.
Add support for our ADV7280 video input module but have it disabled.
This allows to enable it in an overlay per the current system
configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Added "adv,force-bt656-4" property as suggested by Fabio.
  Note: in my PAL setup I didn't see any noticable change.

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bbd838acb8d6..6d072aa87952 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -432,6 +432,21 @@
 			  "MXM3_215";
 };
 
+&gpr {
+	ipu1_csi0_mux {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		port@1 {
+			reg = <1>;
+			ipu1_csi0_mux_from_parallel_sensor: endpoint {
+				remote-endpoint = <&adv7280_to_ipu1_csi0_mux>;
+			};
+		};
+	};
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -657,6 +672,22 @@
 	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 
+	adv_7280: adv7280@21 {
+		compatible = "adi,adv7280";
+		adv,force-bt656-4;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_csi0>;
+		reg = <0x21>;
+		status = "disabled";
+
+		port {
+			adv7280_to_ipu1_csi0_mux: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+			};
+		};
+	};
+
 	ov5640_csi_cam: ov5640_mipi@3c {
 		compatible = "ovti,ov5640";
 		AVDD-supply = <&reg_ov5640_2v8_a_vdd>;
-- 
2.20.1

