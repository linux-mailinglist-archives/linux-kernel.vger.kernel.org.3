Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3152F2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbiETSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352690AbiETSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:31:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3EAE4A;
        Fri, 20 May 2022 11:30:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l16so10905236oil.6;
        Fri, 20 May 2022 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=bmWrGL3sEsj/DdoZUZdcCId3YfRUOcQRoow6LKtnPcmo0esJDFkFkFFljkGxOpxxJJ
         avUC00mtU9JRKRPMox3UfUVPVR7uDbTiKg41EUVYXHIJhZ7Ov0jnAeGbTIT4gjf7PmTF
         dSAmc0VOC6qvshTkf3GDA920vEHVQcg28W9mPr+hIGKbYqGvdOX60FfAexmDef1XGVEZ
         EKgGzT6YFwAfz6rDYLZzhgs5aNxFcJ8nBthjkg3Yx/HqIGHZtY/SoMniiT//p8D1wL7v
         4FkvNhZl7RglV78jjfItYydbnpeHJzty2rnHlL8kyCxD2OLpTzxTO5BcjwZW76PxHo9C
         Q10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=gC5dIMw1sA62XRHz2T0maMKaz/OUywDVVPOznCd+FPa0lH7wGMx2txowKyAbIzXe2H
         kF6UmgSdtuvxLZv2iMp1TN2+aqbtzT8VnO+veRfaiU/OJncTihU5Eo2uTe6enT7WrRTG
         tbMcGFT37/FTeYYVk2w//WqpSnyy06V4OA+IvixgLR4xhmZRdJWWqjFcXHKlNC7FdKZR
         gC3V+9KFFDivEFefttuU5GO+yInWBGFMpEsWw40RXUb5tUjYNTKN0p52uRdCQ0bn9375
         jdNWBP0k2x12/HZ7WljAmNh9kmSWGJffuyvobSRLRrAwcf3duxLnzcbcII5JUVFAUe+y
         8qwA==
X-Gm-Message-State: AOAM532u64o8uFylGXQzHRbgA2QccvpK863WR2VN0e0KGSXUJ3Nf95d+
        AVWO31yFdkNUVVixTl1L+w0UEgdJ5uy+mw==
X-Google-Smtp-Source: ABdhPJxho6ntEN/PHPYS1k/gry9G+Ml1ORAc+IgCOHBnwUE0s3xFIHwvSGsy6PMNnd3Q9Jjykl359g==
X-Received: by 2002:a05:6808:130b:b0:326:d1ff:b56f with SMTP id y11-20020a056808130b00b00326d1ffb56fmr6376634oiv.222.1653071456829;
        Fri, 20 May 2022 11:30:56 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ab6cc000000b0035eb4e5a6d0sm1339467ooo.38.2022.05.20.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:30:56 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [RESEND 4/4 v7] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Fri, 20 May 2022 13:30:37 -0500
Message-Id: <20220520183037.2566-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520183037.2566-1-macroalpha82@gmail.com>
References: <20220520183037.2566-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..ba72e6716e8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =	<4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -472,6 +491,13 @@ usb_midu: BOOST {
 			};
 		};
 
+		rk817_charger: charger {
+			monitored-battery = <&battery>;
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

