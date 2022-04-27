Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED3511D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiD0Qw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbiD0QwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:52:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB484152D4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:49:12 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427164910epoutp0167108e3884a0468a7f0d24f59b17a990~pztSAWXj02781927819epoutp01U
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:49:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427164910epoutp0167108e3884a0468a7f0d24f59b17a990~pztSAWXj02781927819epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651078150;
        bh=hfmxlpSd4s66M6K+y/P55B2vsCALexeN0z+2FCrLRVY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cht35jZskVpfWgMxVKGxxAped7eKtmbBTdMVpCXAoBJwVwiBleNkRQL3xjvxRKjdY
         32XjJCoosr2RL2ZYy/gFAwkh3zm2tzu14auXn0dFcEHLvph786p/9WV+SM6WcRlghu
         apJsJjLJ6ZEANQoD9AdqdBNZDJbg8OhuHGJQIv5k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220427164908epcas5p2007b5f6e30352956b962890836a21be7~pztQj1u_V0970809708epcas5p2E;
        Wed, 27 Apr 2022 16:49:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KpPpn0wy4z4x9Ps; Wed, 27 Apr
        2022 16:49:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.E7.10063.00479626; Thu, 28 Apr 2022 01:49:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427164904epcas5p173aa5dc3b68e38cd7ce8466d29d38393~pztMoc3QH1651516515epcas5p1X;
        Wed, 27 Apr 2022 16:49:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427164904epsmtrp119ae13a1aed879a53d55f57eb61552d0~pztMnk5HI3058730587epsmtrp1i;
        Wed, 27 Apr 2022 16:49:04 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-99-626974006c90
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.EB.08924.00479626; Thu, 28 Apr 2022 01:49:04 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427164902epsmtip1f47598e5fa2a204d0c05377443300017~pztKGiL5F1379913799epsmtip1e;
        Wed, 27 Apr 2022 16:49:01 +0000 (GMT)
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
In-Reply-To: <20220427155840.596535-11-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 10/10] arm64: dts: fsd: use proper
 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 22:19:00 +0530
Message-ID: <000401d85a56$b43a8150$1caf83f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgHmAJxPAngHFiutcH5BUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmpi5jSWaSQc9CRou1vUdZLOYfOcdq
        cfT8biaLvhcPmS32vt7KbnH/61FGi02Pr7FaXN41h81ixvl9TBYHlrazWLz5/YLd4t3LCIun
        MzezWbTuPcJu8X/PDnaLw2/aWS3erX7CaLH81A4WByGPNfPWMHrMun+WzWPTqk42jzvX9rB5
        bF5S79G3ZRWjx+dNch57P/9mCeCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdcWjHXeaCPqmKs8/uszQwPhDtYuTkkBAwkdjUvIe1i5GL
        Q0hgN6PErUPboZxPjBJNz1ezQTifGSV2fz3LBNNy9uNGZhBbSGAXo8Tdd/oQ9ktGia9H7UBs
        NgFdiR2L28CaRQR+skrsal7AApJgFlCVmPPnF1gzp4CbxL5vr8FsYYFoibsnF4AtYAGqmXj2
        FDuIzStgKfFv3Uc2CFtQ4uTMJ1Bz5CW2v53DDHGQgsTPp8tYQWwRASeJ+y8fMULUiEu8PHqE
        HeQICYEfHBL7ns1lgWhwkVjVvwnKFpZ4dXwLO4QtJfGyvw3I5gCyPSQW/ZGCCGdIvF2+nhHC
        tpc4cGUOC0gJs4CmxPpd+hCr+CR6fz9hgujklehoE4KoVpVofncVapG0xMTublYI20Piwfcf
        zBMYFWcheWwWksdmIXlgFsKyBYwsqxglUwuKc9NTi00LDPNSy+HRnZyfu4kRnM61PHcw3n3w
        Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCj5JXEG5pY
        GpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwJR6RFy6zSlRe9thVtdYrnsB
        6ZvqUyx9r//Iv5F8I/0PD3uMRWqZYKNajcPGnDW8FeuZjPYrK7Uqv3kjt1+qQO0GU8H70NVf
        pBd0C29aa7KvLT3h8IalF+US35ovXM68d97OSQsfXtYruLpJ9fNrvpf7OrIX7PN9W3/Dp82r
        g6XO6Nn1dL0XTOUuszU3bf7++t1lHpbVXKaNt/Ny5Y9Nn5xokibyocyjizn6+XTBuONZ3uwF
        ea8UDDUyn3mmb/W7cXSH/SXH0u76My6X4qXTbByWlrFNDEjxm8t85qvzfOXQLMkvTy/vVS6/
        L3O8+f9y5V3hYl2MK40XW3y5URheWfI4UP3cIb3ceJ53IdPNlFiKMxINtZiLihMB247xanAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnC5DSWaSwYK5qhZre4+yWMw/co7V
        4uj53UwWfS8eMlvsfb2V3eL+16OMFpseX2O1uLxrDpvFjPP7mCwOLG1nsXjz+wW7xbuXERZP
        Z25ms2jde4Td4v+eHewWh9+0s1q8W/2E0WL5qR0sDkIea+atYfSYdf8sm8emVZ1sHneu7WHz
        2Lyk3qNvyypGj8+b5Dz2fv7NEsARxWWTkpqTWZZapG+XwJVxaMdd5oI+qYqzz+6zNDA+EO1i
        5OSQEDCROPtxI3MXIxeHkMAORolzn04wQiSkJa5vnMAOYQtLrPz3nB2i6DmjxNMZ05lBEmwC
        uhI7FrexgSREBFrZJFZ+6GUBSTALqErM+fMLauwFRokTb66zgiQ4Bdwk9n17DdYtLBAp8fTd
        XrAVLEANE8+eArN5BSwl/q37yAZhC0qcnPkEaCgH0FA9ibaNjBDz5SW2v53DDHGdgsTPp8vA
        xosIOEncf/kIqkZc4uXRI+wTGIVnIZk0C2HSLCSTZiHpWMDIsopRMrWgODc9t9iwwCgvtVyv
        ODG3uDQvXS85P3cTIziutbR2MO5Z9UHvECMTB+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYLog/HVnxrbr0xc8KUxOmmO8+nPb
        K77zzw2OTJyxhMHhU8Y/z8JftX8Ud0Z6OCx8xb83iiskQeCkzN45wfJm93jfaO+071rf4z/X
        Yc6lMof47J2bLn1hb/iZoBjo55hiUtz+VX5x/UM71UOi91k8ndY9tylRVfIJlDjipTr11KOd
        HyPD3rxyKImPUeEqn6af/fOgR372ExvPBS+atTmn679s92gs8I69reTEIfl49aS3imoq/iEH
        tz6dJ+wns83FVKzNaLf26o7XsicU8n4m7FUN9GU7/Uvf/mbAl9sM05Mus+9/sdOv88sNCadv
        NTxK76Z8T55m8kbPM6g/V+dxQ1FNz+yjgdODclSW3PG3VmIpzkg01GIuKk4EADFgLWtaAwAA
X-CMS-MailID: 20220427164904epcas5p173aa5dc3b68e38cd7ce8466d29d38393
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427155905epcas5p2a902af86ad3f08f96de4da0d5affec43
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427155905epcas5p2a902af86ad3f08f96de4da0d5affec43@epcas5p2.samsung.com>
        <20220427155840.596535-11-krzysztof.kozlowski@linaro.org>
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
>Subject: [PATCH 10/10] arm64: dts: fsd: use proper 'dma-channels/requests'
>properties
>
>pl330 DMA controller bindings documented 'dma-channels' and 'dma-
>requests' properties (without leading hash sign), so fix the DTS to match
the
>bindings.
>
>Reported-by: Rob Herring <robh@kernel.org>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

> arch/arm64/boot/dts/tesla/fsd.dtsi | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index 10c217a57a7d..7fba37d860b2 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>@@ -432,8 +432,8 @@ mdma0: dma-controller@10100000 {
> 			reg = <0x0 0x10100000 0x0 0x1000>;
> 			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 			clocks = <&clock_imem
>IMEM_DMA0_IPCLKPORT_ACLK>;
> 			clock-names = "apb_pclk";
> 			iommus = <&smmu_imem 0x800 0x0>;
>@@ -444,8 +444,8 @@ mdma1: dma-controller@10110000 {
> 			reg = <0x0 0x10110000 0x0 0x1000>;
> 			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 			clocks = <&clock_imem
>IMEM_DMA1_IPCLKPORT_ACLK>;
> 			clock-names = "apb_pclk";
> 			iommus = <&smmu_imem 0x801 0x0>;
>@@ -456,8 +456,8 @@ pdma0: dma-controller@14280000 {
> 			reg = <0x0 0x14280000 0x0 0x1000>;
> 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 			clocks = <&clock_peric
>PERIC_DMA0_IPCLKPORT_ACLK>;
> 			clock-names = "apb_pclk";
> 			iommus = <&smmu_peric 0x2 0x0>;
>@@ -468,8 +468,8 @@ pdma1: dma-controller@14290000 {
> 			reg = <0x0 0x14290000 0x0 0x1000>;
> 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 			clocks = <&clock_peric
>PERIC_DMA1_IPCLKPORT_ACLK>;
> 			clock-names = "apb_pclk";
> 			iommus = <&smmu_peric 0x1 0x0>;
>--
>2.32.0


