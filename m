Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BC511ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiD0Qr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiD0Qrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:47:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4DAC42FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:44:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220427164431epoutp03809d81c0e1a5174d0c37fdea0ebcd38f~pzpOGaw-q0694406944epoutp03e
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:44:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220427164431epoutp03809d81c0e1a5174d0c37fdea0ebcd38f~pzpOGaw-q0694406944epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651077871;
        bh=mWaViwZu+abckHdLJlk7I0wTRVUsMaiY2Jto0Kb2I44=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=gKDVDrZq6Lwp8Vr9rwEwEeFSt/SL65x/6oroz1hqP29f5RY4wcCxqildIOktgW3Tz
         MjNlwRP4J9LPEajQCOkcC5dWuHmvMGCTAnQUAgOlQuFJ+9UoZ1uGWl41QQZUQtVFOh
         Yy0Itry106ItTcmBlkklHOb0Mqzq0NOLc8pF6ieE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220427164430epcas5p2bd04d9bd13c25f9298c8a7a2d921566c~pzpNUxK_d0388103881epcas5p2I;
        Wed, 27 Apr 2022 16:44:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpPjQ05gDz4x9Pq; Wed, 27 Apr
        2022 16:44:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.62.09762.9E279626; Thu, 28 Apr 2022 01:44:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220427164425epcas5p30b5f4965385f8e86aa6e00adbdc9c386~pzpIkAmb40684006840epcas5p3B;
        Wed, 27 Apr 2022 16:44:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427164425epsmtrp17fedfe0bd920c4aa7ea70073996713bf~pzpIi8OBV2854728547epsmtrp1s;
        Wed, 27 Apr 2022 16:44:25 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-9c-626972e92438
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.DB.08924.9E279626; Thu, 28 Apr 2022 01:44:25 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427164422epsmtip290ac1ac77a1961b047837e3699121ea6~pzpGHV4lA0802008020epsmtip2J;
        Wed, 27 Apr 2022 16:44:22 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Dinh Nguyen'" <dinguyen@kernel.org>,
        "'Michal Simek'" <michal.simek@xilinx.com>,
        "'Liviu Dudau'" <liviu.dudau@arm.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Ray Jui'" <rjui@broadcom.com>,
        "'Scott Branden'" <sbranden@broadcom.com>,
        "'Broadcom Kernel Team'" <bcm-kernel-feedback-list@broadcom.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 22:14:21 +0530
Message-ID: <000101d85a56$0dd09390$2971bab0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgDxMFG+AruheCutdgbGMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wbZRjH916v14Ok8+xKeK3LVm5BhaTQCi3HAkoQ5pltGUJMzKYpB9xa
        UmhrrziYU4uTjh/bhGk2KQhkwBaRZQhTCh0LMDpgcUMDInELqIChCAStjA3mZst1yn+f53m+
        z/u83/cHLpBMYTI812hlLUYmj8SC0W+vR0QoPJbcLOX3tjjq0ik3StUP3BZS7hEXQp2e+1VA
        9fzxjYiaWnEDqn16XEiNdtdi1Ocj1xCqt/kESi2sz4moJc+b1Gx1B0aV9AyIqMdXnSLq+sIJ
        IbX01QygLt50okkSurWuFdCOqVsY3d5ShtF3x69idEfTh/TpKy2A9rbvoHu862gaftCQoGeZ
        HNYiZ43Zppxcoy6R3JuhfUWr1ihVClU8FUfKjUw+m0im7EtT7MnN81kh5e8yeQW+VBrDcWT0
        SwkWU4GVletNnDWRZM05eeZYcxTH5HMFRl2UkbXuVimVL6p9wkyD/k/XGcQ8k1T4aLkDs4GF
        mHIQhEMiFtat9InKQTAuIVwA3hobQvjgLwC7vp4PBF4A6+3nwJOW8bvTgC90A9jfuRAIPAAO
        dhRjfhVGKKCz0Y75C1LigRB2H29A/QUBEQ5rH64J/BxEpMLJGjvi523EW9Djndxg1Ke51jax
        wWIiHp6cfCTi+Wk4XD0TWGcn7FysFfBbksMHsxeEfpYSyXDifi/Ca0Khxz2w4Q4Sj3FY9+XJ
        gIcU6Cr5ScTzNjg/eCXAMuj5xO5j3Mc0PP9Qxqf1cPHi5UDry7B3rBb1SwREBLzcHc2P2gpP
        rc8gfKcYltolvDocHl/6EeX5WVhVUSHkmYYX+s4KK0GYY5MxxyZjjk0GHP8PawBoC3iGNXP5
        OpZTm2OM7JH/LjzblN8ONl565F4n+O2X5ah+gOCgH0BcQErFf7v0WRJxDlN0lLWYtJaCPJbr
        B2rfaVcJZCHZJt9XMVq1qth4ZaxGo4mNj9GoyFDxTV0bIyF0jJU1sKyZtTzpQ/AgmQ0xVxwM
        +zR1lNlVV/jdUDgSlNV27FDZWkfaUKisa0XA2VOqf5iuT+qrGc/a97F2sFpU2hW9fWi4hqPF
        /6Q3n3Wcx7kty68nDm+3/B608x23F+dunxsRZuwHRZw3JCxXlfnFgfdXjjaNXSrfra6YWjaQ
        wQ1d1WWHZ4qsNxQ5SiedT98pLClO35UdSbqnJ0pfe952SEMkVya32j+jHYt3psqyyoAcxIU0
        ftDsaj02P/dCl+GItlaqkz1FyJK9zyX+bHqjZi29aGWreTA54/7cqtqdcWBZ+l6qaQucNQR7
        mcNjb7v37E+qujH40au21XujTZ3NCY2ZIauVzh02RF0cco9EOT2jihRYOOZfd3yQFHIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvO7Loswkg9dbJCzW9h5lsZh/5Byr
        xdHzu5ks+l48ZLbY+3oru8X9r0cZLTY9vsZqcXnXHDaLGef3MVkcWNrOYvHm9wt2i3cvIyye
        ztzMZtG69wi7xf89O9gtDr9pZ7V4t/oJo8XyUztYHIQ81sxbw+gx6/5ZNo9NqzrZPO5c28Pm
        sXlJvUffllWMHp83yXns/fybJYAjissmJTUnsyy1SN8ugSvj4+5JTAVPHCr+fdjM1sD4xriL
        kZNDQsBE4tqdx4xdjFwcQgI7GCUOP3jPCpGQlri+cQI7hC0ssfLfc3aIoueMEk9ePwdLsAno
        SuxY3MYGkhARaGWTWPmhlwUkwSygKjHnzy9miI7zjBJvLv1mBklwCrhK3JvdxgRiCwtESUx5
        tAOsgQWoYd+GG2BxXgFLiZ57/9ghbEGJkzOfANVwAA3Vk2jbyAgxX15i+9s5zBDXKUj8fLoM
        7GoRASeJGz8OMEHUiEu8PHqEfQKj8Cwkk2YhTJqFZNIsJB0LGFlWMUqmFhTnpucWGxYY5aWW
        6xUn5haX5qXrJefnbmIEx7WW1g7GPas+6B1iZOJgPMQowcGsJML7ZXdGkhBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Mu+Z+y45xnZHc0rdhP5tq8p+r
        V2q+t0xV8yk7oMhx+L+oIcuMuxUmfN6WAU7auT45ddPksqXDzMN3vLlsmCK3rGyymY9e9IWl
        yka20V3bmZj2q9RuuSjD2Wwh9WvajtPr5v0/L/D/Tm3nATXHpoRPGRMX/j2YZZFQtrlX6usc
        zYQtin/9Wdp2/7p2luu98PJ/fHtWvVgT+TeE61lh7c8JfKkhSnPVLjO9fx7P9NRY5N7Ejv+/
        njzU+MRkMX2V05JKR9skbxU9xhPKHu5ZS4OjGC3vP+tlF/u26JLrRK5bSmyfn36sVvV1L44S
        qRea22N1gHMvt4v1ljinSTOTjZekNLI0zEsSVbwpUcB+9K4SS3FGoqEWc1FxIgDpZHANWgMA
        AA==
X-CMS-MailID: 20220427164425epcas5p30b5f4965385f8e86aa6e00adbdc9c386
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427155901epcas5p3bbfded2d6c093d2e1c960b93f997d598
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427155901epcas5p3bbfded2d6c093d2e1c960b93f997d598@epcas5p3.samsung.com>
        <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Wednesday, April 27, 2022 9:29 PM
>To: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Dinh Nguyen <dinguyen@kernel.org>; Michal
>Simek <michal.simek@xilinx.com>; Liviu Dudau <liviu.dudau@arm.com>;
>Sudeep Holla <sudeep.holla@arm.com>; Lorenzo Pieralisi
><lorenzo.pieralisi@arm.com>; Ray Jui <rjui@broadcom.com>; Scott Branden
><sbranden@broadcom.com>; Broadcom Kernel Team <bcm-kernel-feedback-
>list@broadcom.com>; Sylwester Nawrocki <s.nawrocki@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Rob Herring
><robh@kernel.org>
>Subject: [PATCH 08/10] ARM: dts: exynos: use proper 'dma-
>channels/requests' properties
>
>pl330 DMA controller bindings documented 'dma-channels' and 'dma-
>requests' properties (without leading hash sign), so fix the DTS to match
the
>bindings.
>
>Reported-by: Rob Herring <robh@kernel.org>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm/boot/dts/exynos3250.dtsi             |  8 ++++----
> arch/arm/boot/dts/exynos4.dtsi                | 12 +++++------
> .../boot/dts/exynos4210-universal_c210.dts    |  4 ++--
> arch/arm/boot/dts/exynos5250.dtsi             | 16 +++++++--------
> arch/arm/boot/dts/exynos5410.dtsi             |  8 ++++----
> arch/arm/boot/dts/exynos5420.dtsi             | 20 +++++++++----------
> 6 files changed, 34 insertions(+), 34 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos3250.dtsi
>b/arch/arm/boot/dts/exynos3250.dtsi
>index 41bb421e67c2..7bdd4f0782c3 100644
>--- a/arch/arm/boot/dts/exynos3250.dtsi
>+++ b/arch/arm/boot/dts/exynos3250.dtsi
>@@ -429,8 +429,8 @@ pdma0: dma-controller@12680000 {
> 			clocks = <&cmu CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@12690000 {
>@@ -440,8 +440,8 @@ pdma1: dma-controller@12690000 {
> 			clocks = <&cmu CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		adc: adc@126c0000 {
>diff --git a/arch/arm/boot/dts/exynos4.dtsi
>b/arch/arm/boot/dts/exynos4.dtsi index 5fd17bc52321..2a244aaf84b4 100644
>--- a/arch/arm/boot/dts/exynos4.dtsi
>+++ b/arch/arm/boot/dts/exynos4.dtsi
>@@ -676,8 +676,8 @@ pdma0: dma-controller@12680000 {
> 			clocks = <&clock CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@12690000 {
>@@ -687,8 +687,8 @@ pdma1: dma-controller@12690000 {
> 			clocks = <&clock CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		mdma1: dma-controller@12850000 {
>@@ -698,8 +698,8 @@ mdma1: dma-controller@12850000 {
> 			clocks = <&clock CLK_MDMA>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 		};
>
> 		fimd: fimd@11c00000 {
>diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>index 138d606d58a5..c1b11704b8ee 100644
>--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>@@ -666,8 +666,8 @@ mdma0: dma-controller@12840000 {
> 		clocks = <&clock CLK_MDMA>;
> 		clock-names = "apb_pclk";
> 		#dma-cells = <1>;
>-		#dma-channels = <8>;
>-		#dma-requests = <1>;
>+		dma-channels = <8>;
>+		dma-requests = <1>;
> 		power-domains = <&pd_lcd0>;
> 	};
> };
>diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>b/arch/arm/boot/dts/exynos5250.dtsi
>index df80ddfada2d..c4c0b4c08094 100644
>--- a/arch/arm/boot/dts/exynos5250.dtsi
>+++ b/arch/arm/boot/dts/exynos5250.dtsi
>@@ -700,8 +700,8 @@ pdma0: dma-controller@121a0000 {
> 			clocks = <&clock CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@121b0000 {
>@@ -711,8 +711,8 @@ pdma1: dma-controller@121b0000 {
> 			clocks = <&clock CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		mdma0: dma-controller@10800000 {
>@@ -722,8 +722,8 @@ mdma0: dma-controller@10800000 {
> 			clocks = <&clock CLK_MDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 		};
>
> 		mdma1: dma-controller@11c10000 {
>@@ -733,8 +733,8 @@ mdma1: dma-controller@11c10000 {
> 			clocks = <&clock CLK_MDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 		};
>
> 		gsc_0: gsc@13e00000 {
>diff --git a/arch/arm/boot/dts/exynos5410.dtsi
>b/arch/arm/boot/dts/exynos5410.dtsi
>index 4d797a9abba4..6dc08cb0622c 100644
>--- a/arch/arm/boot/dts/exynos5410.dtsi
>+++ b/arch/arm/boot/dts/exynos5410.dtsi
>@@ -196,8 +196,8 @@ pdma0: dma-controller@121a0000 {
> 			clocks = <&clock CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@121b0000 {
>@@ -207,8 +207,8 @@ pdma1: dma-controller@121b0000 {
> 			clocks = <&clock CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		audi2s0: i2s@3830000 {
>diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>b/arch/arm/boot/dts/exynos5420.dtsi
>index 21b608705049..08198d82ce8d 100644
>--- a/arch/arm/boot/dts/exynos5420.dtsi
>+++ b/arch/arm/boot/dts/exynos5420.dtsi
>@@ -437,8 +437,8 @@ adma: dma-controller@3880000 {
> 			clocks = <&clock_audss EXYNOS_ADMA>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <6>;
>-			#dma-requests = <16>;
>+			dma-channels = <6>;
>+			dma-requests = <16>;
> 			power-domains = <&mau_pd>;
> 		};
>
>@@ -449,8 +449,8 @@ pdma0: dma-controller@121a0000 {
> 			clocks = <&clock CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@121b0000 {
>@@ -460,8 +460,8 @@ pdma1: dma-controller@121b0000 {
> 			clocks = <&clock CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		mdma0: dma-controller@10800000 {
>@@ -471,8 +471,8 @@ mdma0: dma-controller@10800000 {
> 			clocks = <&clock CLK_MDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 		};
>
> 		mdma1: dma-controller@11c10000 {
>@@ -482,8 +482,8 @@ mdma1: dma-controller@11c10000 {
> 			clocks = <&clock CLK_MDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 			/*
> 			 * MDMA1 can support both secure and non-secure
> 			 * AXI transactions. When this is enabled in
>--
>2.32.0


