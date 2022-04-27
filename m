Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619E511DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiD0QtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiD0Qsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:48:54 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC73236E2A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:45:41 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220427164539epoutp04d1a20c1e9b213f83bac99aabfc57e294~pzqNRKGKB3094930949epoutp04E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:45:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220427164539epoutp04d1a20c1e9b213f83bac99aabfc57e294~pzqNRKGKB3094930949epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651077939;
        bh=ektsFN4vu4a5lgjSnCkvbLQU/K0crSZCjs8JT2+pWuw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=PBQGo0QFHNA3HF4O1qRpPXYkD/69qzhm/Iw1uO6GG0OK3gt8frmhhlgtNEL29D+ma
         jIpAX9K/uIn2yfln/KTUGPUqupQHu5sPIWL8EzgKW5KsyPc1PqoLKEBZgjefZlb/vJ
         ATFP+xBdH2QC4aFPbh9FtXFi6hGoqsoMvIYLtYtM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220427164538epcas5p4e369eda53f65fb014f08e84c3a2f4e6f~pzqMMWf8x0751907519epcas5p4I;
        Wed, 27 Apr 2022 16:45:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpPkk1h8Qz4x9Pw; Wed, 27 Apr
        2022 16:45:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.FF.09827.E2379626; Thu, 28 Apr 2022 01:45:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427164533epcas5p2a6560bade2e450ab488ffe1b3fd65049~pzqIJUN6D0961709617epcas5p2v;
        Wed, 27 Apr 2022 16:45:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427164533epsmtrp16a60679e6709e6c5259ade641396e5a5~pzqIHRT5y3058730587epsmtrp1D;
        Wed, 27 Apr 2022 16:45:33 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-4e-6269732ef3a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.0A.08853.D2379626; Thu, 28 Apr 2022 01:45:33 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427164531epsmtip176d1804a6cc1334e5fd410720702ef8e~pzqFmsVxD1379913799epsmtip1Z;
        Wed, 27 Apr 2022 16:45:30 +0000 (GMT)
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
In-Reply-To: <20220427155840.596535-8-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 07/10] ARM: dts: s5pv210: use proper
 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 22:15:29 +0530
Message-ID: <000201d85a56$367193d0$a354bb70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgLFnwNqAX0RGJGtcVhf8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmhq5ecWaSQc86Vou1vUdZLOYfOcdq
        cfT8biaLvhcPmS32vt7KbnH/61FGi02Pr7FaXN41h81ixvl9TBYHlrazWLz5/YLd4t3LCIun
        MzezWbTuPcJu8X/PDnaLw2/aWS3erX7CaLH81A4WByGPNfPWMHrMun+WzWPTqk42jzvX9rB5
        bF5S79G3ZRWjx+dNch57P/9mCeCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdMfvedOaCPpGKqZunMzcwfhDoYuTkkBAwkdiy6BVzFyMX
        h5DAbkaJg99fM0E4nxgldhz5ygRSJSTwjVGibUt4FyMHWMfx9kiImr2MEq9OvIFqeMkocf9Z
        PwtIA5uArsSOxW1sIAkRgZ+sEruaF4AlmAVUJeb8+cUMYnMKuEq8PH2XBWSqsECsxMZWF5Aw
        C1DJ8YUn2EBsXgFLiS8LpzNB2IISJ2c+gRojL7H97RxmiBcUJH4+XcYKYosIOEn8P3GQHaJG
        XOLl0SPsIDdICDRzSjy7eYAF4gMXiY9T2CB6hSVeHd/CDmFLSbzsb2OHKPGQWPRHCiKcIfF2
        +XpGCNte4sCVOWBTmAU0Jdbv0ofYxCfR+/sJE0Qnr0RHmxBEtapE87urLBC2tMTE7m5WCNtD
        4uvZs4wTGBVnIflrFpK/ZiG5fxbCsgWMLKsYJVMLinPTU4tNC4zyUsvhkZ2cn7uJEZzKtbx2
        MD588EHvECMTB+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4wm+SV
        xBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cC0q+3Ix9Ma7/T6rv6Y
        YLktxf6HoKX44wkBNYwrWpZ/8E3aUpfnFN169M3dtI2nAy/8nBSx2TDq66szYa0Fn/QP7jrR
        Lto5KViqLoE/x/6mX2Hm2R8p+1912X5gavyuce5v3Lc70kc2zXq0uOqX4tc5SR0VufdOFX6N
        L/P3idy2QSNrRUPWjWlZN3Rrr3iy/XukWS69fdZqxSe7SvJ7qu9MTuZJDn9n4fg0e6WRi6qk
        wtp/u1crHYh8Yjxxivo6jUvfsqdZCk+foWRTvO+aT+HMTUwmTvnhE9W4+0xsOHdyNC6VzfiZ
        kPe8Me2Cuw7TqZMtTRKlm/VmXvloWmRx5Y5voOGbm/XmAR0WiupvfEWVWIozEg21mIuKEwEQ
        j94RbgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnK5ucWaSwf9XShZre4+yWMw/co7V
        4uj53UwWfS8eMlvsfb2V3eL+16OMFpseX2O1uLxrDpvFjPP7mCwOLG1nsXjz+wW7xbuXERZP
        Z25ms2jde4Td4v+eHewWh9+0s1q8W/2E0WL5qR0sDkIea+atYfSYdf8sm8emVZ1sHneu7WHz
        2Lyk3qNvyypGj8+b5Dz2fv7NEsARxWWTkpqTWZZapG+XwJUx+9505oI+kYqpm6czNzB+EOhi
        5OCQEDCRON4e2cXIxSEksJtRYlHzCrYuRk6guLTE9Y0T2CFsYYmV/56zQxQ9Z5R4u20iWIJN
        QFdix+I2NpCEiEArm8TKD70sIAlmAVWJOX9+MUN0nGeUWLj8AxNIglPAVeLl6btgRcIC0RId
        nyYzgtgsQA3HF54AW80rYCnxZeF0JghbUOLkzCcsIKcyC+hJtG1khJgvL7H97RxmiOsUJH4+
        XcYKYosIOEn8P3GQHaJGXOLl0SPsExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM4qrU0dzBuX/VB7xAjEwfjIUYJDmYlEd4vuzOShHhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamA6Y/yivlJjfdPD5FPZ0zwt
        DJt0juq/MTU0kHANS61TP3AzboJE5YxH2yLX+zI5eDxb8fvOzrf9dYemr3tRoukQ5pSWLcyu
        s1zg/rltlrvMBHqNZJmsrco36XZ+EFqpvcEoPPO4U75WCOvDq0ubNzvvOMpjuCImd9W+n026
        jplL7YSXHuYxPVwVtXwCf08Z43710N1mN/L+b/8bue7pszdlYUWHX4efknNZUT8l41mLy/FD
        VRefL/uiUe9yfuHZBu7Jt54v0GlwPXZS6Yvx0bVScVuMDMreBTOuMnFZYPXywIRDWpoiZrop
        5skP9wTMCJ2QrCBa3nFui/V0hllC7Oejt08KX+zG4Nd43yH0e5YSS3FGoqEWc1FxIgCZtyvE
        WQMAAA==
X-CMS-MailID: 20220427164533epcas5p2a6560bade2e450ab488ffe1b3fd65049
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427155902epcas5p2287cc5446300759d25909ca7a77b4b04
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427155902epcas5p2287cc5446300759d25909ca7a77b4b04@epcas5p2.samsung.com>
        <20220427155840.596535-8-krzysztof.kozlowski@linaro.org>
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
>Subject: [PATCH 07/10] ARM: dts: s5pv210: use proper 'dma-
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


> arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/arch/arm/boot/dts/s5pv210.dtsi
b/arch/arm/boot/dts/s5pv210.dtsi
>index ac281f42e8f5..f6988ba3393d 100644
>--- a/arch/arm/boot/dts/s5pv210.dtsi
>+++ b/arch/arm/boot/dts/s5pv210.dtsi
>@@ -125,8 +125,8 @@ pdma0: dma-controller@e0900000 {
> 			clocks = <&clocks CLK_PDMA0>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		pdma1: dma-controller@e0a00000 {
>@@ -137,8 +137,8 @@ pdma1: dma-controller@e0a00000 {
> 			clocks = <&clocks CLK_PDMA1>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <32>;
>+			dma-channels = <8>;
>+			dma-requests = <32>;
> 		};
>
> 		adc: adc@e1700000 {
>@@ -526,8 +526,8 @@ mdma1: dma-controller@fa200000 {
> 			clocks = <&clocks CLK_MDMA>;
> 			clock-names = "apb_pclk";
> 			#dma-cells = <1>;
>-			#dma-channels = <8>;
>-			#dma-requests = <1>;
>+			dma-channels = <8>;
>+			dma-requests = <1>;
> 		};
>
> 		rotator: rotator@fa300000 {
>--
>2.32.0


