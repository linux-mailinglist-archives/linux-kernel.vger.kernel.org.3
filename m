Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3D5777FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGQT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiGQT3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:29:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805711836
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:29:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r6so12777713edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=xXctcMyuUmlawA3nFYo56xgNoTbeCn1PRUaqrpg5K6E=;
        b=ZpSFJBjLczjzFvqWi4xf6rD2u41QbN6ixUWvq4q5pvigNainMwifZSgf75VyxrlPAf
         sQgXbaMvxeNjQaJWdiMJetC17XtmkeuTf2mKXLFKa54rSGwY0+8uff0tn4nHEilysL6f
         VyjRfO2Sx7diYK5Ps4+ch4/83peRJzMKXy5zHVWFjT0TdnRigeEPGU1KZHm+NxG32ucC
         zxeCoo0+GSlrw+DvexE3T3InHv6l7W9b/5NnAS7Xa4nfY1YsLILXclbpHRVRm29kA72w
         OOdFi7tuHFTa9us2m+oJV93aABLzwTRNXNkjn2QpYiJ3uQhTDysv0L1nS04zf+3ZFJC+
         aPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=xXctcMyuUmlawA3nFYo56xgNoTbeCn1PRUaqrpg5K6E=;
        b=Y55qgll7FVNm2GrmxlvokGji3LnWpYueQmOle465Rm2i+AMjxBqceDD3nB2F5jCmLR
         Brswm47OCfF40Ucsgi847QKOj548+haum5p+wXGnuZMYKi7mn6C62lLurjrBgwM2srT0
         klAs0+8sBdoVtXdab0ufSPwbEFHTVhDW6G6XIWu+FKXwMUC6FrdnJTkhYr7nY1b1zBjd
         b6Z95G7owONY60h59d5yTy6zzJGb0g9fNJefs8/DtUkHyRJa7YSBJkKIvTBazQY/dLOB
         Vry8HDu3nTFTrVtxGGI0LynWHntrAj/vaDXWwwHi3EU8FKa4nMF7/DBU9UYKj/fihP3f
         sh/g==
X-Gm-Message-State: AJIora81DyBszBAopRhElY3GtF1zumuPjBvtsm/KmFY47bjKNI56xhAL
        CblWSeb0UZ6DvPssqA2DCxu08rlIGJu134vn
X-Google-Smtp-Source: AGRyM1vFPngnTHOdEyGGe9wlwswHpg+d4JNRLJTxJLUUakuz8oH/gNyvv0Ar9Ezb/ipbBjAMqefHVA==
X-Received: by 2002:aa7:cac7:0:b0:43a:c5ba:24a6 with SMTP id l7-20020aa7cac7000000b0043ac5ba24a6mr32372348edt.84.1658086144315;
        Sun, 17 Jul 2022 12:29:04 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id lc10-20020a170906f90a00b0070efa110afcsm4676844ejb.83.2022.07.17.12.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 12:29:03 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage regulator
 config
Message-Id: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
Date:   Sun, 17 Jul 2022 21:29:01 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Removing this option not only prevents a hang when rebooting Nanopi R4S,
it also ensures that bootloaders like u-boot can boot from an SD card
right away, without out-of-tree patches that re-initialize voltage =
levels.

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


