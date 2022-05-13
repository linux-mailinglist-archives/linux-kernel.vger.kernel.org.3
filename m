Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95FD526019
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379566AbiEMK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379399AbiEMK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824C5045C;
        Fri, 13 May 2022 03:27:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a21so9452729edb.1;
        Fri, 13 May 2022 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsZTr9QjspygKqEP/6Io66r11TQgQqrqyops3JYlbzk=;
        b=qlA92aLVsqewcDDRuuGo1+NpNYJnqGNxX3oXp4Q2KrkoNsfUgm04VVeXMU8BD3Nznx
         gn1aIOgb+inPUojjmRwdm7UGbMjCiZEtE9LwlqUy90SWFvnfLhf/KA0VthiJDAnCNMGH
         oIob9jPv9/Kxzt98OCHPydPsJWxNMBR60eK6kyk3RiIhNW2tEO1OcssDtBLgkOwpV2Lh
         5dDiUgBR42Xa9GX5HTJ0QUdIHqoueQjPNjkI9TMFRMfD3MNtcCxubOv/j8xX8od7cBT4
         QkPkbyFdcD7xbmBHgSt5P6QerjkWimxTGZ+eG/sv3AOivQ0MdiXVbli2IgCMctWh14x7
         B/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsZTr9QjspygKqEP/6Io66r11TQgQqrqyops3JYlbzk=;
        b=wBRAZICkx5RBtWEEXCFHJ6pyzK6MpcwNZIjSVmuoZst+/j95IYVaaP/yW+GnzBnsjG
         2Og98hawNeFefxTxpIQn2+lSjm1u33qRkI3UiUTZurjYez20fUKW2lyYyoas49vTmPeG
         SvsUohuJniZHk2P4FJOdYeJVHSMHsAVFkS+7t8oypvWxO2YB0sXIYCEfkKw+x/ziytbL
         3k9Abi1mqbET61DkK+oJ+MolNnw7KO8TmIzUILvimWb6/otz+BsoEyFYf6n4GOgzeqT9
         DyGqC28rYdeqwiddSw6nyXtdjAfhEtHABkAiUafdS1XWD73gzgqhaPetbBMWbMwSphGp
         EATg==
X-Gm-Message-State: AOAM532QzC7QGToGLiHp3a33SdwsMEeb83B8LVe/5KSrk/sRy+xgZp+1
        M7ddEwp5t++iittzmQ03/D4=
X-Google-Smtp-Source: ABdhPJxvN5lB6DSJD2MYMERwdhdTFcjVUkbw9vp5dslvwhSUVn2GAyGWfh9eNKuuBmE5E7xd/e2GpA==
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr39972511edv.35.1652437627797;
        Fri, 13 May 2022 03:27:07 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906100300b006f3ef214e40sm609677ejm.166.2022.05.13.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:27:07 -0700 (PDT)
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
Subject: [PATCH v3 4/4] ARM: dts: imx6qdl-colibri: backlight pwm: Adapt brightness steps
Date:   Fri, 13 May 2022 12:26:15 +0200
Message-Id: <20220513102616.48040-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513102616.48040-1-max.oss.09@gmail.com>
References: <20220513102616.48040-1-max.oss.09@gmail.com>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

(no changes since v2)

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

