Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23419578177
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiGRMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiGRMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:02:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3F237EE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:02:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7176924wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=/Wjhe1Q4ojz7rsMCyD5ctxYAYQynJVyQzOqbmq13x+M=;
        b=VBEN/bhJNUvzckZpVfCiDdHgAK7UigIWSvfal3rwFk/4tpUC4IOIkEAj5G+4goZB6h
         Wt1GdfMgSvRlczraz0wEPEkH1JI6uv0ItpYQti+5E5oBSwJSU2KUmMWIha0Tf9+Q4EH+
         HoJw/Cnl2rlwNMwvUCcXrEPcmcVvKMv4r6OG9DZJZEWevaMj99FBXji3gIa1V1KDQxa/
         OGZxbwDjQcEX77iv70P4fDjJ1jl9CNoN+6pa/+cz9k8AIt+0NK0XlUFfcmZF+H4TtuEx
         ehoPL9VfA52v6hQo5Msl65DUNHwQoywx8ez+UB1MIMNAAh+oLxr54svJD3Tnxn/noiVW
         i6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=/Wjhe1Q4ojz7rsMCyD5ctxYAYQynJVyQzOqbmq13x+M=;
        b=6pp2BnoaoQ7Hhjl3rUSIKV3Ee6/KqIX37T4UYczxtVKaLbniJ+bEq1qK3qfAvQl/ZW
         nyBaS77UJMbVoR+fp83h7RS7ubGVXE4xLISvXC+NR2E23OgSjfxoODFtLNx7QDHXBA1O
         A6/30/D7FnIfrj+nrpuIxLtqceYSc5xkraPn1MaGJdycF+0tdEbFHNDtGpO9rVLPu3wo
         c06sDf8MX2Zn1U3sxMw9Y0Ooj7RXYUCCKGcklrS7zfX0p9a9IVeKdSonGIjdavLHq8H/
         hlx6zIRRGe+IHHAmpn/v0MGYirLnZul/ARF06ucbndQDlhniv50GsporDvWZSb3e68dT
         hNiQ==
X-Gm-Message-State: AJIora+qQi9GPUWk5D36daeBrYfH9YcVmWlO3MIUSqUxStI3lwdF0sGL
        5K53HD8quK8H/IBEQUged8ekTg==
X-Google-Smtp-Source: AGRyM1tBFMDGVyuDtUpZDJKZn/k9znCha3K7cNXmOzqGeRLKOzqZjr0gyk4atocyOVVdijeJqID0XQ==
X-Received: by 2002:a05:600c:1f0a:b0:3a3:15a8:a8e1 with SMTP id bd10-20020a05600c1f0a00b003a315a8a8e1mr8485096wmb.167.1658145729122;
        Mon, 18 Jul 2022 05:02:09 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm10639696wrn.69.2022.07.18.05.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:02:08 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 14:02:07 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
Message-Id: <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series of issues exist around the "vcc3v0_sd" voltage regulator that
made it necessary to mark it "always-on".

With the patch "regulator: core: Resolve supply name earlier to prevent
double-init", this option is no longer necessary.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 -
1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..55b93eac2f99 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -70,7 +70,6 @@ vcc3v0_sd: vcc3v0-sd {
		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&sdmmc0_pwr_h>;
-		regulator-always-on;
		regulator-min-microvolt =3D <3000000>;
		regulator-max-microvolt =3D <3000000>;
		regulator-name =3D "vcc3v0_sd";
--=20
2.36.1

