Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE215A8B78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiIAC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiIAC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:28:25 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8010B947
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:28:23 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8DBFA2C01B3;
        Thu,  1 Sep 2022 02:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1661999297;
        bh=kmCIylDm8Txm7onwtOZtWlrF/8ha8Og8/TRGivzIpGg=;
        h=From:To:Cc:Subject:Date:From;
        b=btcu/qdVAZ1Zb5cxjJElT/UHJeJaAJ2Epa9gD3K71VP6DmOr1NHHGDzpebNwM+RuQ
         BzpGF+D4xmewPkeu+wIRBD1eBeM0fgU2SsmIGFKuFJvuD9ZSJrKo/TsrzOf/r4A2jg
         g8ukDtF9RGB/COZorI1QWBD0pilHAARNrs9/hTGLv3cdZxEByUWe0XSv4G9/v+eCJV
         HdoFBv/6tVa8O8l7DqOjxLG42gmd9UVaKBsfaCrWnyrechwhLIwT+Kmz4NxSaCZudv
         VHpuZaS4u5bp8Boc7+wB1GwSYtZ2MndMyLmoJZRVQ1p95X1W9ekqDNHgtfXVA6S6xB
         htsLRwf9pH/EA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B631018c10000>; Thu, 01 Sep 2022 14:28:17 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 61DF413ECC4;
        Thu,  1 Sep 2022 14:28:17 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5EBC92A0098; Thu,  1 Sep 2022 14:28:17 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregory.clement@bootlin.com, vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] arm64: dts: marvell: 98dx25xx: use correct property for i2c gpios
Date:   Thu,  1 Sep 2022 14:28:08 +1200
Message-Id: <20220901022808.691198-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=xOM3xZuef0cA:10 a=yZng4R7sKkkHLZP_EocA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct names for scl-gpios and sda-gpios so that the generic
i2c recovery code will find them. While we're here set the
GPIO_OPEN_DRAIN flag on the gpios.

Fixes: b795fadfc46b ("arm64: dts: marvell: Add Armada 98DX2530 SoC and RD=
-AC5X board")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/b=
oot/dts/marvell/ac5-98dx25xx.dtsi
index 80b44c7df56a..881bf948d1df 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -117,8 +117,8 @@ i2c0: i2c@11000{
 				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&i2c0_pins>;
 				pinctrl-1 =3D <&i2c0_gpio>;
-				scl_gpio =3D <&gpio0 26 GPIO_ACTIVE_HIGH>;
-				sda_gpio =3D <&gpio0 27 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&gpio0 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+				sda-gpios =3D <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status =3D "disabled";
 			};
=20
@@ -136,8 +136,8 @@ i2c1: i2c@11100{
 				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&i2c1_pins>;
 				pinctrl-1 =3D <&i2c1_gpio>;
-				scl_gpio =3D <&gpio0 20 GPIO_ACTIVE_HIGH>;
-				sda_gpio =3D <&gpio0 21 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&gpio0 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+				sda-gpios =3D <&gpio0 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status =3D "disabled";
 			};
=20
--=20
2.37.2

