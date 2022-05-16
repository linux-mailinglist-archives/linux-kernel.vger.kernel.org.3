Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808A5283C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiEPMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiEPMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:00:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66B1707C;
        Mon, 16 May 2022 04:59:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i40so2959573eda.7;
        Mon, 16 May 2022 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5klBQd+5VVDxjdh+quG2QVbCvgSx+FMLRBxcvrncEk=;
        b=CIjZSaFko+8bhEs+vM+NHZRLIWaxag02GeoxPgnAnBPYuHptRPYOxjhBh4yiPk3KWi
         lImIw6IM6aXA893VEOO5ACf6D0mIsHIaHMEqAhmJsTNy/mUTCpuRnmZzxtJcDrmX21Mc
         c2uP4QbHlnJ9tlYnI5K6rRzIYXUU6UCbI3p2x2UStYk8HT2lEkHRAjSylYg+dq/pEiK+
         4SrDV5LWLog34KJLk2Ef9uAe1T37AG+KCE2BxDMW2LZQayXcrk6uJx6n7enSwnmGq913
         U9V8so1/AHdkDzGBXyiwYPxYaEpgZCOwgKS+ooKUxcZOpxlOZmm0Ew8l3C5p757jKtdw
         xgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5klBQd+5VVDxjdh+quG2QVbCvgSx+FMLRBxcvrncEk=;
        b=DqRqK6KqLmZPKYYTGmK7K03mQ/i/pUmYy+SeF7sKpnPJNtKNIgg324KKEI5iHNwlAP
         DKWiA/5q74pmu94SMg125GjmqLDPYeb8jtxjo3OSi5oniQMYbUV0gagUo4ts2J0Juzdu
         kTFFPUpCOdI5acCkk55AC3sMG41tu8pbkfx2daQMHevWXPQu++RMj88xCDhN1R7yRxPs
         JQw/m29dIDZ4el5qzNrx5R3nSAZ4DRhtdTRfgnwVDMJz1djXXDYZsty7xdrYitMKdnF6
         E55Yz28k3flqFdFWTDnEBmWyNlj8q2ASD6ldAl69UZ7v65BEBDEU+OGoqxycIvbZzzZ2
         B2xA==
X-Gm-Message-State: AOAM5309CWJe7+gMlFIt+28iKcXs2mlPBw4ynGrjP3DJgh4X0XuCHS+C
        coSsIEtWJqM95SSeGhhO764=
X-Google-Smtp-Source: ABdhPJx1JBFiuRd9VuE61SGGK9mBPT3srwZOBVe7F0qmyVKKeBVfcHi5qM+43lnihoMWKUkZKugJ8A==
X-Received: by 2002:a05:6402:354a:b0:427:d0e1:8ef3 with SMTP id f10-20020a056402354a00b00427d0e18ef3mr12799717edd.66.1652702382458;
        Mon, 16 May 2022 04:59:42 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:42 -0700 (PDT)
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
Subject: [PATCH v1 16/17] ARM: dts: imx6q-apalis: backlight pwm: Adapt brightness steps
Date:   Mon, 16 May 2022 13:58:44 +0200
Message-Id: <20220516115846.58328-17-max.oss.09@gmail.com>
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

Adapt the brightness steps as the backlight doesn't light up
for very low duty cycles.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 49669caac8b7..62d9d907432c 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -20,8 +20,8 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
 		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-- 
2.20.1

