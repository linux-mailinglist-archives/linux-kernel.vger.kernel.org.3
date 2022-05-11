Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF748523251
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiEKMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiEKMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:00:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C35B2438D6;
        Wed, 11 May 2022 05:00:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y21so2282375edo.2;
        Wed, 11 May 2022 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eEpM+FBBTw194C71zX34kjk6ylwP+rd4n2HSuTY7Nw=;
        b=MRgaBpz/RsKSinth52qx2FJq+/0G6AQQtuh9XafwkipCFyBfMsll+OtwaBTOaK6U0H
         H7PJT2ZEWiTy3wnYZwGXp3e0+x4liCmtj/l0szWpbInYR6BImbfsFYgybhVyXKkBdVgY
         EpQDXwSbw1en/6Ne3dtUK0D7uQYvxwA8WPcij/ERPcWO0aW4O0wNdizWLhJ7kly24OJd
         nAzzKkz1V/2zAsWNiOdObrs0H9fLFcMOyri0f7uIhMFskJ17XAed4uvb5E7mWQE7zs7m
         AueUActhEfLyPC/GNeMOmbABJd8LYLHE4C3BhZhwVZCKxaAJSFJFMB2Fcv+6dpT/etK5
         7RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eEpM+FBBTw194C71zX34kjk6ylwP+rd4n2HSuTY7Nw=;
        b=nUKKFllc9EO36okTFKvDiKh6SW0fOLQodGTW//E7BC3Jahg6Xt5edVfozv3VoqJw6R
         uwC9iWKV6P1Z6pmEt/5F0Ie3aEQ/rQ5KdHhXZtU+q/OXwcsNFTNAFsWk1txOJIW45OI5
         k6Awd17GSZ4BAIdZjA0qfZNwaHFk3hOUCLFYBYbxWeDb01IXzCU0jdqFSSMxLMgneZdL
         saKZVSKLX+7avZ1PJjoBZRCED3eH30uRjPaQ/xcTn0vrCkfrIiv8d+AIbk6yV8xVTobS
         kc96IxDHBfa0Vojx86X2rTrpDMJE4DO9ccMqEzhbNCZEIdht1bWT7j1JgpfOMjPPdUso
         aYsA==
X-Gm-Message-State: AOAM532RVdfaVfqUmpKZz4G4hHcHe/tIJPPBsr/fXWeaSQhFU3hLTJtD
        nDNx9uKWxkpcATJcR47SulUI3CVIxzo=
X-Google-Smtp-Source: ABdhPJzG5hQF6/6whSh+Q6bYm+jLDCxI1y2bcjo9ORc2L/YKy513EqsfKP2t6gWyBKGIfmwPWt5kLg==
X-Received: by 2002:a05:6402:424c:b0:427:eae2:ed09 with SMTP id g12-20020a056402424c00b00427eae2ed09mr28523662edb.376.1652270398431;
        Wed, 11 May 2022 04:59:58 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm1089279edf.52.2022.05.11.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:59:57 -0700 (PDT)
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
Subject: [PATCH v2 4/4] ARM: dts: imx6qdl-colibri: backlight pwm: Adapt brightness steps
Date:   Wed, 11 May 2022 13:59:10 +0200
Message-Id: <20220511115911.54960-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511115911.54960-1-max.oss.09@gmail.com>
References: <20220511115911.54960-1-max.oss.09@gmail.com>
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

Changes in v2:
- add reviewed-by tags
- Split the Backlight PWM patch into two patches, a) #pwm-cells 3, b) adapt brightness steps
- Split to two patches as proposed by Fabio Estevam

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d91fae92c90a..023e76215064 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -14,8 +14,8 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
 		enable-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* Colibri BL_ON */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-- 
2.20.1

