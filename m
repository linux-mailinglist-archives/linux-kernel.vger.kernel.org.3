Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744075283C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiEPMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbiEPL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C840C167DA;
        Mon, 16 May 2022 04:59:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g6so28205336ejw.1;
        Mon, 16 May 2022 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EhdZnBGNhKoELha1acB7pKc8koKdRuYwtp3Avxy8oI=;
        b=i9EsMC2lv00nRAFVxDcRyY0hG5V121w+/Ew8fuvpkalFFHov7+KQLqJixu1dyt9ub5
         CvhrkqszEq6MeCRmKh+W2EojH+PIczySWDRfQTh8Z98to/OUjTgM7c8urokFEdQnoMup
         YAoVjMa9HSdxLH4Ev77e/oRBGL4AdbnidwWUenTCaUo0CWqBNdF4yntuMDFu/qGnGRb8
         epYgqvTIiSJ/B04hsK03uszCiIU0J8YFoBrwnoCltN9lqvcAYFRQ+ltQ3Epe7c03t12B
         vDmPGT7JLZYjr5ZXLrKYS/hOgUpKM5hn8Dcz+nKdCQejZJyk0uva+/u8qufqMCh7Qm3r
         8OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EhdZnBGNhKoELha1acB7pKc8koKdRuYwtp3Avxy8oI=;
        b=sXkgOVqvJeHMFTof6E4F/n7Pfy65g2yNi5NAFss8t5GRPTG25PJIBi9eoZWaREW2JF
         bLseU3I5WTLzoo8np4A/wt0m1fyWfvBkr+PbmsnvoQ8OpcgLmOJA4SBVUcv0GJ6br+Nq
         ETjGH/ayQHS+ybwmNFbkjVh5y80iyLG6J04EHlAqNu5MS7EIZlcKJQyD8fuS3JFpDOO+
         if5rK89VvUDoUQ6DUspIBQ/okX1BJPBJn9jHVtZtNZUlZ29OVQO61XhE5Y54hMfDmqld
         HRSl1/ip9KtBaoYSC2IEkmSHavKIX3JHMCtaYGsaGWIUOptOShuOlc8HqDjYJD5Xssvk
         Vk7w==
X-Gm-Message-State: AOAM531KCTPzKEw1Y5YbNAPhijyEqjs0tbZH55ma88yPBmQhxbYxuMUo
        7RY9X0hEB64frVQ5qgy8yko=
X-Google-Smtp-Source: ABdhPJwTw63vxQa3VD8DO5ZvJ99y9QxISsFfkeOmu1ogAKWEmcsFNlFpjXUGTibWIw+Ggb9a/Sti+Q==
X-Received: by 2002:a17:907:6090:b0:6fa:14ca:fba2 with SMTP id ht16-20020a170907609000b006fa14cafba2mr15158725ejc.564.1652702376316;
        Mon, 16 May 2022 04:59:36 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:35 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/17] ARM: dts: imx6q-apalis: Add adv7280 video input
Date:   Mon, 16 May 2022 13:58:40 +0200
Message-Id: <20220516115846.58328-13-max.oss.09@gmail.com>
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

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The Apalis iMX6 modules allow connecting a parallel video input.
Add support for our ADV7280 video input module but have it disabled.
This allows to enable it in an overlay per the current system
configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 0d1004eede62..f33dfaa907d7 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -418,6 +418,21 @@
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
@@ -643,6 +658,21 @@
 	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 
+	adv_7280: adv7280@21 {
+		compatible = "adi,adv7280";
+		reg = <0x21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_csi0>;
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

