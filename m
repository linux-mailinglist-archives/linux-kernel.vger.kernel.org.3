Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E625752B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiGNQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiGNQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:26:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396561736
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:26:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so4302415ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=7EsrX8RZzD1TPXFClMq2wq7FeJKp9EF1t1w9cW3xhJg=;
        b=ew7OS+ExEFwv26meWu3bPXo2KC9aPJHx4sgXnwhGd9BkvwvymYlLHwdjfl6ROM8hdx
         inR3ATH5CRCDYqasegeX8QsnvCBB16A5ecUh6+oQDSWhHKl2qv+76z6Ja44eO/9n38WY
         m3/Jn+T8FnQtoYklwIrP9yu9FpgtPAhcNoxZn/S1TPsxCxM1QFWs6Z76Issv9nO1sFgP
         +LOlISQpmEt79xRo0rQEQGVtdbVWaqLOaL09+mB7TNk6jcV4gw1/TYinnKhyD6evtcRD
         CtduV1B61RzuZHhmTPmTB7m3V4nKc0gISg7MgYdxEYL/ZNMstptB15W6BZLYQqinjvIk
         43GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=7EsrX8RZzD1TPXFClMq2wq7FeJKp9EF1t1w9cW3xhJg=;
        b=I0N6+aVaImctAOHvXvj3Fp2j7+NPVi2IBQNzqT86D+cPBL8kemjLGYZeAd8TeWIqmj
         pMIK2/YJj1z2coY1habq8P8alu/QhUiZe1pxEksY8x4ks1EQOV9fjW7B6dzcJhoiJQ7k
         qMH/mLfhKBqRwcWOSOFuGCQnQJSmfFrPtR8Y9cl6yfus8kqCuFCTY1+GUYZFobKZej+I
         h7Yr+aNdJGrw7jX0CJ7JhVnjqBpMOu0RIZmiMyR4RhTP5hCm4Rl4RQvSb+JAXqOcM6Tx
         z42uPnK9i6/ZynZlm9Fc0qujxZIYLSNfWAdc2cew+RqLCUpmzkb3shFzoL4e2buTWvDh
         p3oQ==
X-Gm-Message-State: AJIora+Wfo4WszAFk+HYpCUVtJGHpz7YW7THiOiJ9s6TZl1Ka62aYnui
        EhY0moFFFieOFMQVvpr1YWf5Ag==
X-Google-Smtp-Source: AGRyM1tZTRUBFPqEmbiQrELRo8KQJc0vOQEwbM0TUYq7mZvrAv6anJA7BNMzkfzR3xqVc5OXuvS7UQ==
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id hb35-20020a170907162300b0072b64e3878amr9631814ejc.185.1657815999468;
        Thu, 14 Jul 2022 09:26:39 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id lb11-20020a170907784b00b007246492658asm879265ejc.117.2022.07.14.09.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:26:38 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v2] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Date:   Thu, 14 Jul 2022 18:26:38 +0200
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>
In-Reply-To: <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
Message-Id: <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
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

mmc/SD-card initialization may fail on NanoPi r4s with
"mmc1: problem reading SD Status register" /
"mmc1: error -110 whilst initialising SD card"

Moreover, rebooting would also sometimes hang.

This is caused by the gpio entry for the vcc3v0-sd regulator;
even though it appears to be the correct GPIO pin, the presence
of the binding causes these errors.

Fix the regulator to drop the gpio binding and add a comment
to prevent accidental reintroduction of that entry.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..d5f8a62e01be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -67,7 +67,7 @@ vcc1v8_s3: vcc1v8-s3 {
 	vcc3v0_sd: vcc3v0-sd {
 		compatible =3D "regulator-fixed";
 		enable-active-high;
-		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		// gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>; // breaks =
SDHC card support
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&sdmmc0_pwr_h>;
 		regulator-always-on;
--=20
2.36.1


