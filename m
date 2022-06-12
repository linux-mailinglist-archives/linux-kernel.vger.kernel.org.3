Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC33547A97
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiFLPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiFLO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:59:57 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2749F3D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:59:56 -0700 (PDT)
Date:   Sun, 12 Jun 2022 14:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1655045992; x=1655305192;
        bh=g1svjZQlTtLvQ67kaxAA8uuUzvl52iGTofluz6ehVRk=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=iE/VCEPEnT8mAEkENoQtVGHAL2qj9QpfOSHlcsHINz14hY0l/Ol3Zqfe2a3Bi7i70
         HGGPqnWguGx5Fo9kf8p+r61Sy/STqZVy1gEAMCGHGXRVVzsUL4xSJmSS7OPxnFsjGh
         9ES6APX7jG94P8+OYjcEEfIMyqp4pnSLqMVK0BmE7Tz4iQ9wRIHC/mrSMObXo1Vilz
         WpMpQWr1WCaPC/fkE4/SEQzn2C63wZK81ON0fE4uHDNSmDwwJWkbriE2KTvRfYHU0h
         u2A3u57Hi7Oj3d5QgxHwIhpzcPZFf8KY+Kvk0mn6V+NTlrCUspUL7v6RXFr2bdSzGj
         t0sa0biiomi3g==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Reply-To: =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] arm64: tegra: Fix SDMMC1 CD on P2888
Message-ID: <20220612145928.14448-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook SDMMC1 CD up with CVM GPIO02 (SOC_GPIO11) used for card detection on J=
4
(uSD socket) on the carrier.

Fixes: ef633bfc21e9 ("arm64: tegra: Enable card detect for SD card on P2888=
")
Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra194-p2888.dtsi
index a7d7cfd66379..b0f9393dd39c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -75,7 +75,7 @@

 =09=09/* SDMMC1 (SD/MMC) */
 =09=09mmc@3400000 {
-=09=09=09cd-gpios =3D <&gpio TEGRA194_MAIN_GPIO(A, 0) GPIO_ACTIVE_LOW>;
+=09=09=09cd-gpios =3D <&gpio TEGRA194_MAIN_GPIO(G, 7) GPIO_ACTIVE_LOW>;
 =09=09};

 =09=09/* SDMMC4 (eMMC) */
--
2.20.1


