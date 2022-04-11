Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEF4FC081
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDKP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347884AbiDKPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA233BFA4;
        Mon, 11 Apr 2022 08:22:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i7-20020a1c3b07000000b0038eb92fa965so782603wma.4;
        Mon, 11 Apr 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJPCXAKMSBI9bB7dpXYU1TNs7HyHYJtWYzm6jjkJbH8=;
        b=oK9V8fvQp7WnwWL4hDuqJlLxWSoYGgWJziVaXbcsEjuaUkugBO6Lw00ibA+xEXAJDD
         E+Z0TheQTN04J1cTHeZ1KW7cGsOO8jqMEYH/yscI7sxrlYjn889LrUODVE17+jnBfqST
         rh5X/qW4g8ZDL5lfHU+267IYyj0Cfka9c0o+D3+Tt42Ge5QiJWFmLtRLWc6BK66TGMW/
         LirraLuyx30zpdCxlnW6lurtOQ0xlHuNfjgCwOxjhFXWSXVwLpk4UnBP6SA1io1LWvZC
         vwSOGhyMTxHZ2uRn1zGAZ2oEhNugTx2QnuRb0YYiJZetqq4UtDtWpWp5uS2sonH1gbV2
         22ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJPCXAKMSBI9bB7dpXYU1TNs7HyHYJtWYzm6jjkJbH8=;
        b=FWx5JkdLN7cYQ/bhisGcp00H70MnTucUIBIcT+ScEMxBV4sUNuFE8IB3uDkQnPYexV
         oqGS0W6JhgnbBX3wBIac6rcUZwdwIlWdyxiZTljp7X5Wy70OaeF4CvpbrP9FZmC/kNF5
         MTNQ+RQfnfZjVevGmPsZCwE9TC82YJxlqLLQCqbTe4bXpZb2WiZCJ6R322JWL/7ElS7e
         rjMFZVegmvedDHydzJXBulxYYRwWrFbsLyQDs4Xasef2zjtmM6pBKqVfEo8aPe0NYbnU
         dQrXcvYHXp+btmnfOmtkwHRD4WU/wUyTGageMEYmNM+929z2B3h6kMubPU7ihHt53ELm
         fr/w==
X-Gm-Message-State: AOAM530rj5OI6LaWXBXpcJFc86ixomMpbU4/sVOCbnwD6JM9M0ZUUEqJ
        LS4X1QncJ/edj+d5YyAH+gA=
X-Google-Smtp-Source: ABdhPJzwUS+inNWZQxQfoRNGcraCOObrjnH562CDpAkYLOMfrWrdBRKgIXBZB4Qp/zuz15Y8Z3Zdxw==
X-Received: by 2002:a05:600c:4f46:b0:38c:d4cd:ee31 with SMTP id m6-20020a05600c4f4600b0038cd4cdee31mr29567542wmq.16.1649690572210;
        Mon, 11 Apr 2022 08:22:52 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
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
Subject: [PATCH v2 05/14] ARM: dts: imx6dl-colibri: Add gpio-line-names
Date:   Mon, 11 Apr 2022 17:22:25 +0200
Message-Id: <20220411152234.12678-6-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
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

Add GPIO line names on module level. Those are all GPIOs which a user
might use on his custom carrier board. If more meaningful names are
available on the carrier board, the user can overwrite the line names
in the carrier board level device tree.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 218 +++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c6112b1bffd4..c92887f6af61 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -118,6 +118,224 @@
 	};
 };
 
+&gpio1 {
+	gpio-line-names = "",
+			  "SODIMM_67",
+			  "SODIMM_180",
+			  "SODIMM_196",
+			  "SODIMM_174",
+			  "SODIMM_176",
+			  "SODIMM_194",
+			  "SODIMM_55",
+			  "SODIMM_63",
+			  "SODIMM_28",
+			  "SODIMM_93",
+			  "SODIMM_69",
+			  "SODIMM_99",
+			  "SODIMM_130",
+			  "SODIMM_106",
+			  "SODIMM_98",
+			  "SODIMM_192",
+			  "SODIMM_49",
+			  "SODIMM_190",
+			  "SODIMM_51",
+			  "SODIMM_47",
+			  "SODIMM_53",
+			  "",
+			  "SODIMM_22";
+};
+
+&gpio2 {
+	gpio-line-names = "SODIMM_132",
+			  "SODIMM_134",
+			  "SODIMM_135",
+			  "SODIMM_133",
+			  "SODIMM_102",
+			  "SODIMM_43",
+			  "SODIMM_127",
+			  "SODIMM_37",
+			  "SODIMM_104",
+			  "SODIMM_59",
+			  "SODIMM_30",
+			  "SODIMM_100",
+			  "SODIMM_38",
+			  "SODIMM_34",
+			  "SODIMM_32",
+			  "SODIMM_36",
+			  "SODIMM_59",
+			  "SODIMM_67",
+			  "SODIMM_97",
+			  "SODIMM_79",
+			  "SODIMM_103",
+			  "SODIMM_101",
+			  "SODIMM_45",
+			  "SODIMM_105",
+			  "SODIMM_107",
+			  "SODIMM_91",
+			  "SODIMM_89",
+			  "SODIMM_150",
+			  "SODIMM_126",
+			  "SODIMM_128",
+			  "",
+			  "SODIMM_94";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_111",
+			  "SODIMM_113",
+			  "SODIMM_115",
+			  "SODIMM_117",
+			  "SODIMM_119",
+			  "SODIMM_121",
+			  "SODIMM_123",
+			  "SODIMM_125",
+			  "SODIMM_110",
+			  "SODIMM_112",
+			  "SODIMM_114",
+			  "SODIMM_116",
+			  "SODIMM_118",
+			  "SODIMM_120",
+			  "SODIMM_122",
+			  "SODIMM_124",
+			  "",
+			  "SODIMM_96",
+			  "SODIMM_77",
+			  "SODIMM_25",
+			  "SODIMM_27",
+			  "SODIMM_88",
+			  "SODIMM_90",
+			  "SODIMM_31",
+			  "SODIMM_23",
+			  "SODIMM_29",
+			  "SODIMM_71",
+			  "SODIMM_73",
+			  "SODIMM_92",
+			  "SODIMM_81",
+			  "SODIMM_131",
+			  "SODIMM_129";
+};
+
+&gpio4 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_168",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_184",
+			  "SODIMM_186",
+			  "HDMI_15",
+			  "HDMI_16",
+			  "SODIMM_178",
+			  "SODIMM_188",
+			  "SODIMM_56",
+			  "SODIMM_44",
+			  "SODIMM_68",
+			  "SODIMM_82",
+			  "SODIMM_24",
+			  "SODIMM_76",
+			  "SODIMM_70",
+			  "SODIMM_60",
+			  "SODIMM_58",
+			  "SODIMM_78",
+			  "SODIMM_72",
+			  "SODIMM_80",
+			  "SODIMM_46",
+			  "SODIMM_62",
+			  "SODIMM_48",
+			  "SODIMM_74";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_95",
+			  "",
+			  "SODIMM_86",
+			  "",
+			  "SODIMM_65",
+			  "SODIMM_50",
+			  "SODIMM_52",
+			  "SODIMM_54",
+			  "SODIMM_66",
+			  "SODIMM_64",
+			  "SODIMM_57",
+			  "SODIMM_61",
+			  "SODIMM_136",
+			  "SODIMM_138",
+			  "SODIMM_140",
+			  "SODIMM_142",
+			  "SODIMM_144",
+			  "SODIMM_146",
+			  "SODIMM_172",
+			  "SODIMM_170",
+			  "SODIMM_149",
+			  "SODIMM_151",
+			  "SODIMM_153",
+			  "SODIMM_155",
+			  "SODIMM_157",
+			  "SODIMM_159",
+			  "SODIMM_161",
+			  "SODIMM_163",
+			  "SODIMM_33",
+			  "SODIMM_35",
+			  "SODIMM_165",
+			  "SODIMM_167";
+};
+
+&gpio6 {
+	gpio-line-names = "SODIMM_169",
+			  "SODIMM_171",
+			  "SODIMM_173",
+			  "SODIMM_175",
+			  "SODIMM_177",
+			  "SODIMM_179",
+			  "SODIMM_85",
+			  "SODIMM_166",
+			  "SODIMM_160",
+			  "SODIMM_162",
+			  "SODIMM_158",
+			  "SODIMM_164",
+			  "",
+			  "",
+			  "SODIMM_156",
+			  "SODIMM_75",
+			  "SODIMM_154",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_152";
+};
+
+&gpio7 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_19",
+			  "SODIMM_21",
+			  "",
+			  "SODIMM_137";
+};
+
 &hdmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hdmi_ddc>;
-- 
2.20.1

