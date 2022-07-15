Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E5576590
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiGORB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiGORBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:01:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66D82386
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:01:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy29so8886230ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dIRVpOqiqH59RP0AoZiD2s3xlmYa2fxQT3tSFC8Essc=;
        b=HRy26nf+hmKczXYwhz8g5F1tYXyzvWLNDZbn+FWf+AiEATRROmPI+AoL9+m/YxBlLS
         K3uRB9w/1ZIIZV6E+hgu7GNHmQQFNvxB7fbmvBWEyxKY1+RF5dNWI1Q2veOAs8c8cW+Y
         hhxBqUOvZnpOaa4+p9EQ7lw6c5Q3W7aDFgdjclMTKaQPL3uGM28Bn1IA3BAeAjxiYckB
         N6bl61gRnYmN0esXHP2QkHcXNMWT09uysgJvDCcpyB8F5rNRlSdwFWt37o2tmfk27cWL
         MEKgBmxUvEYNaNwjpKnJDgT/2Uo2IqAtSUdBXGKFinOK3WxS7OTqYmAgx/rOf5b9UOzq
         L7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dIRVpOqiqH59RP0AoZiD2s3xlmYa2fxQT3tSFC8Essc=;
        b=OHw63evAgMPLEfLIHmK86AfiqVeDiHILGkx/Vf4S3W09ozZcG6jOd1YprHRnSzrdP7
         vgKTODCe79w2Jq5PM4Wy2sLxrfA3758TeWtFpPzQByKRJiDXgPxUaIwaC0wxl4G9iI/b
         8nkwt3c8MPEAhlnnG2kjOQf1X9k68NA75ARt+x3Jl/IE1oT4XIYeLJNz/MZ6urqOra0P
         CnxpsQMdnnud5drPLcm1TgQAkpJG8nFfhwldsiDPfAKNlgCXkLFKjTa/Ie88V+mZwG15
         DYxbe/xcDfBQXOgi3wN8fdEQD4z6cuV6wt9Ky1RSgiH9gWZeJgi4I65XlB8DqDy8Yh8w
         QVdg==
X-Gm-Message-State: AJIora+wyKUVbvYkEtTe3djQE4PTVvxQl5j5EaHsNentnR0jTfwkAmOP
        Ss/rvsCJ9vZ+1tp9qqm2m631pQ==
X-Google-Smtp-Source: AGRyM1s485bZlc9JnrL6z/lbu4yj3ep3vPK+ktztWjflB/3vWNqvh4mR5HlbnzXJR9uF9cnStQ2dMA==
X-Received: by 2002:a17:906:8a4d:b0:72b:6b8d:3779 with SMTP id gx13-20020a1709068a4d00b0072b6b8d3779mr14677191ejc.759.1657904463891;
        Fri, 15 Jul 2022 10:01:03 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402069800b004316f94ec4esm3142765edy.66.2022.07.15.10.01.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:01:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v3] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
Date:   Fri, 15 Jul 2022 19:01:02 +0200
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc/SD-card initialization may fail on NanoPi R4S with
"mmc1: problem reading SD Status register" /
"mmc1: error -110 whilst initialising SD card"
either on cold boot or after a reboot.

Moreover, the system would also sometimes hang upon reboot.

This is prevented by setting an explicit undervoltage protection limit
for the SD-card-specific vcc3v0_sd voltage regulator.

While using a limit of 3V seems to work, an additional safety buffer
should prevent accidental tripping, preventing a system hang.

Set the undervoltage protection limit to 2.7V, which is the minimum
permissible SD card operating voltage.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)
 mode change 100644 =3D> 100755 =
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
old mode 100644
new mode 100755
index 8c0ff6c96e03..669c74ce4d13
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -73,6 +73,10 @@ vcc3v0_sd: vcc3v0-sd {
 		regulator-always-on;
 		regulator-min-microvolt =3D <3000000>;
 		regulator-max-microvolt =3D <3000000>;
+
+		// must be initialized or SD card may fail to initialize =
/ system may hang
+		regulator-uv-protection-microvolt =3D <2700000>;
+
 		regulator-name =3D "vcc3v0_sd";
 		vin-supply =3D <&vcc3v3_sys>;
 	};
--=20
2.36.1


