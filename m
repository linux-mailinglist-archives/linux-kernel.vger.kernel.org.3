Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F84D891F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiCNQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbiCNQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA313E3E;
        Mon, 14 Mar 2022 09:30:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i8so24903513wrr.8;
        Mon, 14 Mar 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzsIbe/VyQDZhQv3en/oGFWMkVwLL9AvbOE+B5m6rmM=;
        b=oluAmZ1AbProoVNTpi90HZvl0fwZzZZa4vLOh9Kw7RedFNCTQ+C2fpFTKnXJ1mDjmZ
         duGVfXlvqLBAzdKe9hKrZKq72KmCLmS28/3Tm/T8V7jgRsSIs7OzVwv65iWIHtL9+xib
         mNqhEvzO3LDIioC55gLFc8WxjlBOE60HswL6BxEksEBB7fuHtfcTOn1dyiG7YpTMjXV4
         qX8bSeZagaIiUBD+UQOxe0FCoXDvi+HkX4YHJvLcEUA2h6S/S9tTE++UQ12D85vDwdsL
         PB4mpdyn5bDrzzXUi3MM9WJEgEI2gO2/7pPkUnJrcpRhoP4Zc+A7w7eHYfarrUmHB4Ky
         2e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzsIbe/VyQDZhQv3en/oGFWMkVwLL9AvbOE+B5m6rmM=;
        b=DfHGdoRQbnkbqewtyp5t5Spi7mgSZm1b5SbSVYMqt2jZF3mGGUVXNdHrzumuBO1zXd
         pAk1QhXLqByqG62vxr+R9HzMVyoYJ6zHAs/OSMjQEujgGPZ4yf9IE7zoLiBI6/xVCrnC
         yAzt1p5vOK5sFxSrA9IX3h5mZ4t1UNNyNyqusSSWnuCnJHdLJlUV1QBLFQEcyX5olqDv
         ZJSb7xMKe1clSO79atrXp1Uealx895QpmcLboFqtdQ4I7vqd8ZvqVmq8QhOHtFDDG7jc
         DextNZV+wZ72N+2D4NZmzncYM8Krg4SN+qyJPZ/K+Xnd5DI3ONrk8Y9wF9Av0UIPxGyA
         wdbg==
X-Gm-Message-State: AOAM533zsEvz7zS+zceKFpW8PFwYKHv3ABzx5NmfDRN4gxnUZKFAL55I
        kW1QVVaD0hl+WPhW1YFTTdo=
X-Google-Smtp-Source: ABdhPJy5zV2RXw6618ozXkF+A8aLhNgnnHiahwhVyrGmH9IHJNHt1h6EQhbUi1N+zsOVFCxtMP8lsA==
X-Received: by 2002:a05:6000:1548:b0:203:7a50:315d with SMTP id 8-20020a056000154800b002037a50315dmr17318360wry.41.1647275419825;
        Mon, 14 Mar 2022 09:30:19 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:19 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/14] ARM: dts: imx6dl-colibri: Add gpio-line-names
Date:   Mon, 14 Mar 2022 17:29:49 +0100
Message-Id: <20220314162958.40361-6-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

