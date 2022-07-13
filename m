Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40D573F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiGMWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiGMWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:22:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6492A731
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:22:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l23so208326ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=pQm/h5cc7p63jEzDc2/PjwaXQCdshE0JwFSB1IlnVb8=;
        b=7dtdSUVhMGijDVe8wvX5oRl4wxjP1wsXnlSBk+043qVgC7zfF4z4VewgDw5uqlz8UV
         784zBtoD0K3TMhI03emrGS4USqsLWxlJ842C5E/uyNRCluSBPmYhxUdLlN1k/NtKjANg
         t2l6X5rKQCiLN2T6FVHYozBe0viAGA/QLT2bLR9g/suGAXk4kaChCSStc+SLC6/B/sS0
         /flF5/N0+sq12ohdXz0XaarI4R/j81xS0k+5AGB0HGlzrdhkN/M7Fz87oC676om7JATt
         pRZtZQy1Kf2F1eVpvX/6un5BEPYZarthL92OpYTKxfH9J+HgyBHdGzpaYHA7FqFo2Dov
         LB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=pQm/h5cc7p63jEzDc2/PjwaXQCdshE0JwFSB1IlnVb8=;
        b=21meZBc8nwHUrnmxNkninVDlacNwTiRmiisZcwxo7kDndtvS1G4uD8LqXDOvYsNtOa
         XwekBvKR+QHW0zJa3okb7TlNIvT7OVExiQqx1J02rv1ukiZuTtuXXr8khLJClOvrv2xL
         qhEjoDhGrKB//Wx3qKtK+IbECme964YAzHSG2TR5P5VfwHjNJ4eA4z3a2P98JHdf/PWd
         DyL6/WvI4VGtAoSN+cOhgP5rqYGhY3A6+NvizivbwmxeV0qLzOMHeQ05J7U+69l1tqih
         TE8MVjH270Rgl/Vz/j/jshjRcd4dvIl2KExJeaNRAgTNk2pfijhLTx+Ao37sJfGVCfzm
         mPFA==
X-Gm-Message-State: AJIora+XS8uFFc8ETKDSjSu3LfCtERuWqI4YNkAwUzIaB+4fHCVEapTc
        GfI0BN9c/K+zzgTjeVrWnfUSjw0Qvne+rss5
X-Google-Smtp-Source: AGRyM1vmoqVV3QU0wWaPibUGD+7z0kkmOmVlx4xPn1tbz7nXmubFlbaOgslmtIhht5sjZKRpkrziHg==
X-Received: by 2002:a17:907:7e94:b0:72b:53d2:c004 with SMTP id qb20-20020a1709077e9400b0072b53d2c004mr5681911ejc.387.1657750945203;
        Wed, 13 Jul 2022 15:22:25 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906345a00b00726e51b6d7dsm5403470ejb.195.2022.07.13.15.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 15:22:24 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4 
Message-Id: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
Date:   Thu, 14 Jul 2022 00:22:23 +0200
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc/SD-card initialization may sometimes fail on NanoPi r4s with
"mmc1: problem reading SD Status register" /
"mmc1: error -110 whilst initialising SD card"

Moreover, rebooting would also sometimes hang.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..91789801ab03 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
 	vcc3v0_sd: vcc3v0-sd {
 		compatible =3D "regulator-fixed";
 		enable-active-high;
-		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&sdmmc0_pwr_h>;
-		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt =3D <3000000>;
 		regulator-max-microvolt =3D <3000000>;
 		regulator-name =3D "vcc3v0_sd";
@@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
=20
 	sdmmc {
 		sdmmc0_det_l: sdmmc0-det-l {
-			rockchip,pins =3D <0 RK_PA7 RK_FUNC_GPIO =
&pcfg_pull_up>;
+			rockchip,pins =3D <0 RK_PD6 RK_FUNC_GPIO =
&pcfg_pull_up>;
 		};
=20
 		sdmmc0_pwr_h: sdmmc0-pwr-h {
--=20
2.36.1

