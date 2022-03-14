Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713FD4D8937
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiCNQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiCNQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C213D4E;
        Mon, 14 Mar 2022 09:30:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h15so24869487wrc.6;
        Mon, 14 Mar 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQsn3GuuUz52TzNLVtFaCymDKnKHO9CKxYjpT5cZM18=;
        b=N/CX6VgJ2HwWQioK9B5WhaJia8qiaRoPQkbSGcSs97Stb72sXGqgqXWzlbeujR7YCr
         M8TFjun2Uv+GchUnFI2Lx9cU+XSDJaFBOB1JAbEVmuvlYjXlzENhguRx5apw9MqJJaaJ
         u6JNGSyey6aQRc5ekPPzrHw4+m4qyyR29SMkITwoevKKeK3MMbdl/yeA7RZHdpfnM+ER
         jaCM1TuMWJ5XZkSrOAkt1pzUu0yomkfI2/hk49URyOD9XoAzf/dq1JapKSxaGlto+6YN
         CoqcCY0SQFxIj8N0gtRxpp+VDLlqiquep9Fwj/ynD+zlGemx9XA4D/1pzWJ7Cfkh6QIV
         0cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQsn3GuuUz52TzNLVtFaCymDKnKHO9CKxYjpT5cZM18=;
        b=1E6ZdRx1SnphFUl1MFQIboIsUCHuT132P2yX0QxcbbD22TgM1GSZ4/W72y5sdw/XxR
         B5a91PcYGcE0Kvz4gTrJOmIF6I7GXxyBuzH5LkFhtBxI+dHskL6VnuHk7yyDNBewr7FK
         5iY+Cx0wNfVhLPp8ToXRZ176osT0bHX71SlwjDaPMMKpSJoWbrWjjsjZcgoPV8muRyiJ
         PnfndSG7h2BceQ8SjdMJe49NvjY8cEsWoQ1sHEhq4nw4vJzfUQaS1IE75ZMyUOyMSsIe
         RX53y4Hhmd8yVkLe+yikoQ+M8TD9CQja1wUwcgMZIK0imm35FidfbIAnTYScdA+rpZs+
         6fNg==
X-Gm-Message-State: AOAM531Uc49p7WjdD9La4QsqQCvAlYIhfRgQu1T99G0oIpqmqrTcFIqL
        +NQQePh4PG5Hag7v5bFdzj8=
X-Google-Smtp-Source: ABdhPJwgH+RhoacMKh0ghMZUqXgSpKkD5p0fFqkycVHdOHpMAJt3Rxx5StpEigohrSKRfWse23gf2A==
X-Received: by 2002:a05:6000:1868:b0:203:732e:6a96 with SMTP id d8-20020a056000186800b00203732e6a96mr17442456wri.39.1647275418972;
        Mon, 14 Mar 2022 09:30:18 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:18 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/14] ARM: dts: imx6dl-colibri: Fix I2C pinmuxing
Date:   Mon, 14 Mar 2022 17:29:48 +0100
Message-Id: <20220314162958.40361-5-max.krummenacher@toradex.com>
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

Fix names of extra pingroup node and property for gpio bus recovery.
Without the change i2c2 is not functional.
Fixes: 56f0df6b6b58 ("ARM: dts: imx*(colibri|apalis): add missing
recovery modes to i2c")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 16d38bc78b2a..c6112b1bffd4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -132,7 +132,7 @@
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-0 = <&pinctrl_i2c2_gpio>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
 	scl-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio3 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
@@ -491,7 +491,7 @@
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2grp {
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
 			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x4001b8b1
-- 
2.20.1

