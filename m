Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F051211A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiD0QuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiD0Qt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:49:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCF2B0E15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:46:46 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427164644epoutp01408ef96d2f70010929861fb0ae8f6592~pzrKMK_0V2781927819epoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427164644epoutp01408ef96d2f70010929861fb0ae8f6592~pzrKMK_0V2781927819epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651078004;
        bh=xu+OZIThmWFqC+k7qAoNSoUGjST226mSqfWHlz0OtwA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AceK7U/E3DI7Wswf2DlMWELcB2Tsf2dK15KQQO7n156DPDpb7ao5hJAxMUn+O1Jp1
         /MbmVFwNC7p22mVRlrDbAj0c7oQB6bgkZ2cMq7NIZB7p+nOw/yBxYsTiwS84RYfywi
         k9KKS5UboaLWxT8gzHMhtqg731S6X6XwBMvQjqNI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220427164643epcas5p4a0ded6a720f46d87fa7c4faf1d2b3f31~pzrJErrzj2168221682epcas5p47;
        Wed, 27 Apr 2022 16:46:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KpPlz6qvVz4x9Pp; Wed, 27 Apr
        2022 16:46:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.B7.10063.F6379626; Thu, 28 Apr 2022 01:46:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220427164638epcas5p3557a63299f176bf5e399a545198c8a3e~pzrE19n8R1041610416epcas5p3I;
        Wed, 27 Apr 2022 16:46:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427164638epsmtrp1d37e48ccdb0bfe2d90d6ce38f486c53f~pzrE06B1R2854728547epsmtrp1O;
        Wed, 27 Apr 2022 16:46:38 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-a5-6269736fcc2f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.EB.08924.E6379626; Thu, 28 Apr 2022 01:46:38 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427164636epsmtip2f81f4200c8cd6d6f6fe448c0966398f3~pzrCSidcy0395103951epsmtip2i;
        Wed, 27 Apr 2022 16:46:36 +0000 (GMT)
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
In-Reply-To: <20220427155840.596535-10-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 09/10] arm64: dts: exynos: use proper
 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 22:16:35 +0530
Message-ID: <000301d85a56$5d4b68a0$17e239e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgHDwDYXAkaxgAqtcxqj8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmhm5+cWaSQf86Y4u1vUdZLOYfOcdq
        cfT8biaLvhcPmS32vt7KbnH/61FGi02Pr7FaXN41h81ixvl9TBYHlrazWLz5/YLd4t3LCIun
        MzezWbTuPcJu8X/PDnaLw2/aWS3erX7CaLH81A4WByGPNfPWMHrMun+WzWPTqk42jzvX9rB5
        bF5S79G3ZRWjx+dNch57P/9mCeCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdMfXhLLaCHpmKW2teMTUwbhXvYuTkkBAwkfjVfIgNxBYS
        2M0ocfRmaRcjF5D9iVFixqqDjBDOZ0aJcy9OMcN0PN4whxGiYxejRO8ZMYiil4wSx/u+gyXY
        BHQldixuYwNJiAj8ZJXY1byABSTBLKAqMefPL7BJnAJuEjOXLQWzhQXiJI6dWA1mswDVHPp3
        gRXE5hWwlJjT8wHKFpQ4OfMJ1Bx5ie1v50BdpCDx8+kysBoRASeJK5OnskPUiEu8PHqEHeQI
        CYH/HBINs7+zQjS4SGyeNoEdwhaWeHV8C5QtJfGyvw3I5gCyPSQW/ZGCCGdIvF2+nhHCtpc4
        cGUOC0gJs4CmxPpd+hCr+CR6fz9hgujklehoE4KoVpVofneVBcKWlpjY3Q11gIdEa+Mn9gmM
        irOQPDYLyWOzkDwwC2HZAkaWVYySqQXFuempxaYFhnmp5fDoTs7P3cQITudanjsY7z74oHeI
        kYmD8RCjBAezkgjvl90ZSUK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5hR8kriDU0sDUzM
        zMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYCqdslRiqwpXOcfFzQqz9G5dSnvQ
        +FlrEc9tlfBg0eT337o+3/9mb3zq0+Kpk/p8f5WtNKh/4ttZleit6sjM2nXeZtbnGHfhS92N
        a30vFLKsb9sqva3hidwRFR3Gzoa3E7pSjb/1bEiq3i/vsttOpsxotmmqtZDzA8HQD1pMfR6m
        e58IWasYujgmNS6u4XZzWii24UiDx7oXP7VVNJ5/382Q9uS6iEy1qtbaw0E+QjZfNfIfVoks
        quw9yynweGHjQbUvL+Q+3DD9FHZmNo9Iewmj2NnUnWqqKgfZOkLXz69nvlJ6+/+ma8qGco/K
        C77M6FH5NVn47GMnr/rs1H+n8ubPaTy+XHf360/VNp8NlViKMxINtZiLihMB6TSCg3AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvG5ecWaSwYEnuhZre4+yWMw/co7V
        4uj53UwWfS8eMlvsfb2V3eL+16OMFpseX2O1uLxrDpvFjPP7mCwOLG1nsXjz+wW7xbuXERZP
        Z25ms2jde4Td4v+eHewWh9+0s1q8W/2E0WL5qR0sDkIea+atYfSYdf8sm8emVZ1sHneu7WHz
        2Lyk3qNvyypGj8+b5Dz2fv7NEsARxWWTkpqTWZZapG+XwJUx9eEstoIemYpba14xNTBuFe9i
        5OSQEDCReLxhDmMXIxeHkMAORokvj14zQiSkJa5vnMAOYQtLrPz3nB2i6DmjxJS5O1hBEmwC
        uhI7FrexgSREBFrZJFZ+6GUBSTALqErM+fOLGaLjAqPE3Flz2EASnAJuEjOXLWUGsYUFYiSe
        fd0G1sAC1HDo3wWwqbwClhJzej5A2YISJ2c+AarhABqqJ9G2kRFivrzE9rdzmCGuU5D4+XQZ
        WLmIgJPElclT2SFqxCVeHj3CPoFReBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OLDQuM8lLL
        9YoTc4tL89L1kvNzNzGC41pLawfjnlUf9A4xMnEwHmKU4GBWEuH9sjsjSYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmJf0Pf/uTmfYtPx5bxPVU5dmb
        c8Innt839XJctvnsiqu/Un3aDG3/XZkiZTLVSL57G9v/75ucXWT8N88/uHjzhebsOVM5r1y8
        spstd/ZUwY4KV6vZd+rDucqD2ZwW9wdULXbj7FYsbPv88L99tNX6hpynoZJC+ZLFCswJWptN
        XNbvvXEspb3ioZ+jXOaZJ15ruSyuT86a+0h3m8eyjiDfJc/UON4ybkx0VteMMDf/Mr/2d43W
        15T9B3incv3WufD9s1ySge7TVo9GiRmT2SfN7Q1Lrqz6ffmA927/LZV+K2wfp5pvy/I5/mWV
        587uA/X7HzfLqrpvPmf4w/DT3F0fn0/7zVZxZmIX9/kXT5nXK7EUZyQaajEXFScCAMy08h9a
        AwAA
X-CMS-MailID: 20220427164638epcas5p3557a63299f176bf5e399a545198c8a3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427155904epcas5p288496858c47e2d5e3726da8b2242e28d
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427155904epcas5p288496858c47e2d5e3726da8b2242e28d@epcas5p2.samsung.com>
        <20220427155840.596535-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
>Subject: [PATCH 09/10] arm64: dts: exynos: use proper 'dma-
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


> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 12 ++++++------
> arch/arm64/boot/dts/exynos/exynos7.dtsi    |  8 ++++----
> 2 files changed, 10 insertions(+), 10 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index 017ccc2f4650..91e82e4283b2 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -1866,8 +1866,8 @@ pdma0: dma-controller@15610000 {
> 			clocks = <&cmu_fsys CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@15600000 {
>@@ -1877,8 +1877,8 @@ pdma1: dma-controller@15600000 {
> 			clocks = <&cmu_fsys CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		audio-subsystem@11400000 {
>@@ -1898,8 +1898,8 @@ adma: dma-controller@11420000 {
> 				clocks = <&cmu_aud CLK_ACLK_DMAC>;
> 				clock-names = "apb_pclk";
> 				#dma-cells = <1>;
>-				#dma-channels = <8>;
>-				#dma-requests = <32>;
>+				dma-channels = <8>;
>+				dma-requests = <32>;
> 				power-domains = <&pd_aud>;
> 			};
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>index e38bb02a2152..c31534771620 100644
>--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>@@ -149,8 +149,8 @@ pdma0: dma-controller@10e10000 {
> 			clocks = <&clock_fsys0 ACLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@10eb0000 {
>@@ -160,8 +160,8 @@ pdma1: dma-controller@10eb0000 {
> 			clocks = <&clock_fsys0 ACLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		clock_topc: clock-controller@10570000 {
>--
>2.32.0


