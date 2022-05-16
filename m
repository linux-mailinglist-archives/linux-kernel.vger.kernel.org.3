Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27B5283AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbiEPL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiEPL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF615A2D;
        Mon, 16 May 2022 04:59:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd25so5367440edb.3;
        Mon, 16 May 2022 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6JdWBOFeyMMw2iBqLTjLOG7raGk0JckwGY/WzDd5go=;
        b=U1gO0n8iTonrVb7p6x+lN4NDxpjrm7HbjBINUn9bMCEotMjj6Nod0nH3R8IHT35io9
         4xj5JJt2VNTcCAX6kLTotF7PFk/55xGnWxTsgLa9+vGllxGJ22MW5esjuJYWwkd5VGKY
         vSC+0wegwUd4BuQOXLKGi1KZrPzx16GlBm9gmybNz7lm6Dy5KJdA1bqIYNQdSRWbl1Qx
         YVkdOQRL04r8GRsRbG0aFrta56kVllaj839/ManUpGgWK2flp0DOGT3VgJkV0nRLzmqk
         AMAT/sHoTyepTiW1b3z9zPGt3k4wQ1E8UGdIDMYK7H+Mck7ZH344/7RoUzQ4fUPzAI7J
         lagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6JdWBOFeyMMw2iBqLTjLOG7raGk0JckwGY/WzDd5go=;
        b=7ZMBzGE9PDTO4neRhqRu4ChHBInec3SVS1nrtMmTcpSuJxE3qdGZxrsQRbd8puw1WE
         tcnnvK3oCbytVPcR5M3OEa1R7x7Y/Q3diZTRmpkkZARQyTLw3OE7d/XvxayzhKOIpJUe
         Az0S8Y9iMdxVdZYySUXLqJNxEkCTuUooWWQFWMEepfXt2tuGJHka2ogDrCUfc3axPVh2
         s+v5WqUqUSu+O3zCGYVtFwOZjk2yP0LEtANQI98cQOpNuSSJ6hn9P4eLJQVlvibPBIL9
         75TS9U0r+dwDPLAvDDdepJDdstwggdhpfz1GABADK0gDfFAD4FCTEAbraJ7iqcI7Mld9
         kG1A==
X-Gm-Message-State: AOAM5313j3zWqfPecrthYcvVJ7GznKImt78vFQ0wqzh6a9TI41WyzvSn
        IxndyDyvENWQX4ay0lMMg2A=
X-Google-Smtp-Source: ABdhPJzm1oBNCNN5MgwfKo3BaHvqMFSf/kni3zzK323H2ANh2ioEuNI0P3DTutn+5O/rQ6DqMydRig==
X-Received: by 2002:aa7:d659:0:b0:42a:b0d5:a64e with SMTP id v25-20020aa7d659000000b0042ab0d5a64emr5133125edr.157.1652702362702;
        Mon, 16 May 2022 04:59:22 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:22 -0700 (PDT)
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
Subject: [PATCH v1 03/17] ARM: dts: imx6q-apalis: Add gpio-line-names
Date:   Mon, 16 May 2022 13:58:31 +0200
Message-Id: <20220516115846.58328-4-max.oss.09@gmail.com>
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

Add GPIO line names on module level. Those are all GPIOs which a user
might use on his custom carrier board. If more meaningful names are
available on the carrier board, the user can overwrite the line names
in the carrier board level device tree.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 193 ++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index da919d0544a8..e56451651a6d 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -141,6 +141,199 @@
 	status = "disabled";
 };
 
+&gpio1 {
+	gpio-line-names = "MXM3_84",
+			  "MXM3_4",
+			  "MXM3_15/GPIO7",
+			  "MXM3_96",
+			  "MXM3_37",
+			  "",
+			  "MXM3_17/GPIO8",
+			  "MXM3_14",
+			  "MXM3_12",
+			  "MXM3_2",
+			  "MXM3_184",
+			  "MXM3_180",
+			  "MXM3_178",
+			  "MXM3_176",
+			  "MXM3_188",
+			  "MXM3_186",
+			  "MXM3_160",
+			  "MXM3_162",
+			  "MXM3_150",
+			  "MXM3_144",
+			  "MXM3_154",
+			  "MXM3_146",
+			  "",
+			  "",
+			  "MXM3_72";
+};
+
+&gpio2 {
+	gpio-line-names = "MXM3_148",
+			  "MXM3_152",
+			  "MXM3_156",
+			  "MXM3_158",
+			  "MXM3_1/GPIO1",
+			  "MXM3_3/GPIO2",
+			  "MXM3_5/GPIO3",
+			  "MXM3_7/GPIO4",
+			  "MXM3_95",
+			  "MXM3_6",
+			  "MXM3_8",
+			  "MXM3_123",
+			  "MXM3_126",
+			  "MXM3_128",
+			  "MXM3_130",
+			  "MXM3_132",
+			  "MXM3_253",
+			  "MXM3_251",
+			  "MXM3_283",
+			  "MXM3_281",
+			  "MXM3_279",
+			  "MXM3_277",
+			  "MXM3_243",
+			  "MXM3_235",
+			  "MXM3_231",
+			  "MXM3_229",
+			  "MXM3_233",
+			  "MXM3_198",
+			  "MXM3_275",
+			  "MXM3_273",
+			  "MXM3_207",
+			  "MXM3_122";
+};
+
+&gpio3 {
+	gpio-line-names = "MXM3_271",
+			  "MXM3_269",
+			  "MXM3_301",
+			  "MXM3_299",
+			  "MXM3_297",
+			  "MXM3_295",
+			  "MXM3_293",
+			  "MXM3_291",
+			  "MXM3_289",
+			  "MXM3_287",
+			  "MXM3_249",
+			  "MXM3_247",
+			  "MXM3_245",
+			  "MXM3_286",
+			  "MXM3_239",
+			  "MXM3_35",
+			  "MXM3_205",
+			  "MXM3_203",
+			  "MXM3_201",
+			  "MXM3_116",
+			  "MXM3_114",
+			  "MXM3_262",
+			  "MXM3_274",
+			  "MXM3_124",
+			  "MXM3_110",
+			  "MXM3_120",
+			  "MXM3_263",
+			  "MXM3_265",
+			  "",
+			  "MXM3_135",
+			  "MXM3_261",
+			  "MXM3_259";
+};
+
+&gpio4 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "MXM3_194",
+			  "MXM3_136",
+			  "MXM3_134",
+			  "MXM3_140",
+			  "MXM3_138",
+			  "",
+			  "MXM3_220",
+			  "",
+			  "",
+			  "MXM3_18",
+			  "MXM3_16",
+			  "",
+			  "",
+			  "MXM3_214",
+			  "MXM3_216",
+			  "MXM3_164";
+};
+
+&gpio5 {
+	gpio-line-names = "MXM3_159",
+			  "",
+			  "",
+			  "",
+			  "MXM3_257",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "MXM3_200",
+			  "MXM3_196",
+			  "MXM3_204",
+			  "MXM3_202",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "MXM3_191",
+			  "MXM3_197",
+			  "MXM3_77",
+			  "MXM3_195",
+			  "MXM3_221",
+			  "MXM3_225",
+			  "MXM3_223",
+			  "MXM3_227",
+			  "MXM3_209",
+			  "MXM3_211",
+			  "MXM3_118",
+			  "MXM3_112",
+			  "MXM3_187",
+			  "MXM3_185";
+};
+
+&gpio6 {
+	gpio-line-names = "MXM3_183",
+			  "MXM3_181",
+			  "MXM3_179",
+			  "MXM3_177",
+			  "MXM3_175",
+			  "MXM3_173",
+			  "MXM3_255",
+			  "MXM3_83",
+			  "MXM3_91",
+			  "MXM3_13/GPIO6",
+			  "MXM3_11/GPIO5",
+			  "MXM3_79",
+			  "",
+			  "",
+			  "MXM3_190",
+			  "MXM3_193",
+			  "MXM3_89";
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
+			  "MXM3_99",
+			  "MXM3_85",
+			  "MXM3_217",
+			  "MXM3_215";
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.20.1

