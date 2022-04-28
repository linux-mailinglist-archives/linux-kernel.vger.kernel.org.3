Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1579D5130B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiD1KH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiD1KHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB042A1F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:55:47 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220428095540epoutp03d5dbef67e8562a84ceb3cf61bd28a9c9~qBtilepR70643706437epoutp03K
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:55:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220428095540epoutp03d5dbef67e8562a84ceb3cf61bd28a9c9~qBtilepR70643706437epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651139740;
        bh=c+NSpwnS6jamqQmgp5WdGdQfBhrUARonkCY2t5byIC8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hQGmS4xkP088TFSU3VkN1wM0Tvm6Kx3CR2MWj0ZC9c+UO7fNxeeLV4dEiSyPSOM+S
         /XiHNkqEmTIQLEM2hP+xOtR//sqkys8pCRvo1BZiaaFlC23BaRdbO7lsZr5LrdaU6b
         ND49YuEI46iEp0Sb/Xd+Q/s6+t/KG4ISrrIIhp5g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220428095540epcas5p4f1325af2083458ccd6aa591ab0e4555b~qBth6FYLx2925729257epcas5p40;
        Thu, 28 Apr 2022 09:55:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KprbB2PZqz4x9Q1; Thu, 28 Apr
        2022 09:55:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.D6.09827.6946A626; Thu, 28 Apr 2022 18:55:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220428095533epcas5p3a4762efd30cb4116f245de161df25683~qBtbNVrxa1741717417epcas5p3Y;
        Thu, 28 Apr 2022 09:55:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428095533epsmtrp22f9c4d38467aff00fcec8a73b4fee76d~qBtbMKDzN1238812388epsmtrp2j;
        Thu, 28 Apr 2022 09:55:33 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-b9-626a64965ff1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.1D.08853.4946A626; Thu, 28 Apr 2022 18:55:32 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428095528epsmtip28de24c0acd85c40fb2876415cbd6cbd2~qBtWyrBsc2197321973epsmtip2C;
        Thu, 28 Apr 2022 09:55:28 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
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
In-Reply-To: <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
Subject: RE: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Date:   Thu, 28 Apr 2022 15:25:26 +0530
Message-ID: <017e01d85ae6$1987ae90$4c970bb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgJNR/79AruheCsBvClGGq1eZHwA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmlu60lKwkgyfHeCzW9h5lsZh/5Byr
        xdHzu5ks+l48ZLbY+3oru8X9r0cZLTY9vsZqcXnXHDaLGef3MVkcWNrOYvHm9wt2i7VH7rJb
        vHsZYfF05mY2i9a9R9gt/u/ZwW5x+E07q8W71U8YLZaf2sHiIOyxZt4aRo9Z98+yeWxa1cnm
        cefaHjaPzUvqPfq2rGL0+LxJzmPv598sARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QP8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzHq+dz1SwO7ji397/rA2M15y6GDk4JARMJOZ+
        luhi5OIQEtjNKPH37FkmCOcTo8SuSQvYIZxvjBL3+uaxdjFygnXM79vPBpHYyyhx4OcSZgjn
        JaPEl4dT2EGq2AR0JXYsbgOrEhFYwyZxe/EaJpAEs4CqxJw/v5hBbE4Be4ktf5azgdjCAjES
        Lz/fYwI5igWoZm1PHkiYV8BS4t3/PkYIW1Di5MwnLBBjtCWWLXzNDHGRgsTPp8vArhMRcJPY
        cPwQ1CpxiZdHj7BD1DRzSvz+ww9hu0icXvAPKi4s8er4FihbSuLzu71skHDxkFj0RwoinCHx
        dvl6RgjbXuLAlTksICXMApoS63fpQ2zik+j9/YQJopNXoqNNCKJaVaL53VUWCFtaYmJ3NzQI
        PST65jWzTGBUnIXkr1lI/pqF5P5ZCMsWMLKsYpRMLSjOTU8tNi0wyksth8d2cn7uJkZwWtfy
        2sH48MEHvUOMTByMhxglOJiVRHi/7M5IEuJNSaysSi3Kjy8qzUktPsRoCgzricxSosn5wMyS
        VxJvaGJpYGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFMHxMHp1QDU+ZR7c2BminsbSwp
        z5tuavlt9d52Z+d/g5K9ZidsvzZx1JWYHo/zOp3Bey9SP/Of3+a+0GzpXQ1f5E5z7XDPFl20
        tST5WKbFY8W5e88fPJagfsR4/2k2U7Xt9rId+829npwMiMpO7ylquMKhEOGtPmkFp5pFUcj9
        XW+YZS+tS9nXdINps6GARJne/nm3TWc6SM/S7GlkFzvxJGzDx/1SbG99BX7Zl18qdPLRsFLv
        6zf9Nm2T7quooi7nXy+vvixRa50mEjiPm1ley9l5zxN/+7jjdm8e8YSFbhc50uYwtcnul/6x
        9anCOcd68i1VJ2k2Oa02chJflV/xldNv4u573Mn3vvn+SniUv3ny9UVKLMUZiYZazEXFiQD0
        Ep8VdAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO6UlKwkg/VfTS3W9h5lsZh/5Byr
        xdHzu5ks+l48ZLbY+3oru8X9r0cZLTY9vsZqcXnXHDaLGef3MVkcWNrOYvHm9wt2i7VH7rJb
        vHsZYfF05mY2i9a9R9gt/u/ZwW5x+E07q8W71U8YLZaf2sHiIOyxZt4aRo9Z98+yeWxa1cnm
        cefaHjaPzUvqPfq2rGL0+LxJzmPv598sARxRXDYpqTmZZalF+nYJXBmXDvewF6z2r1j0s4+x
        gfGYXRcjJ4eEgInE/L79bCC2kMBuRol33xIg4tIS1zdOYIewhSVW/nsOZHMB1TxnlGh83wHW
        wCagK7FjcRsbSEJEYAebRP+FI2AJZgFViTl/fjFDdDQxSSya/JkZJMEpYC+x5c9ysCJhgSiJ
        KY92sHQxcnCwADWs7ckDCfMKWEq8+9/HCGELSpyc+YQFYqa2RO/DVkYYe9nC18wQ1ylI/Hy6
        jBXEFhFwk9hw/BATRI24xMujR9gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOAI19Lcwbh91Qe9Q4xMHIyHGCU4mJVEeL/szkgS4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgcnA9l/jBs1r885/iXxpVqhR
        nL05fb26+v9Z/Aa8cw7e2lO24MXJFwl3rjj92mhoaLv15q7YprD1+yRs5snf4H6/9X1V/75l
        06VFSj7+Mrz1+C5fQMebfZoiiamsX47brDkyX8z+t35k7cV5KtPmzq8Sn5itsGPjUquAT7uX
        e/78WvJL4XbxHAXB+SEOs7OOBRs5LGK23fldqqlN4B3P+dIrQm5XjUTTFj1xUgxMuJwdm7l4
        Y6t5+T0G59Xvvsq9X1Ex+TCXIouVr7vFhpoDf3ZPnCIR5vfn83pWdeHzpb9uPqzcvlzr0rd5
        zTk9LyNb3eJeLl1fLuuastnhnNgz7iVtzUd+a2q+lrtT/HnayUMiSizFGYmGWsxFxYkAIY9x
        wV8DAAA=
X-CMS-MailID: 20220428095533epcas5p3a4762efd30cb4116f245de161df25683
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
        <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
        <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
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
>From: Marek Szyprowski =5Bmailto:m.szyprowski=40samsung.com=5D
>Sent: Thursday, April 28, 2022 3:20 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>; Lee Jones
><lee.jones=40linaro.org>; Rob Herring <robh+dt=40kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
><alim.akhtar=40samsung.com>; Dinh Nguyen <dinguyen=40kernel.org>; Michal
>Simek <michal.simek=40xilinx.com>; Liviu Dudau <liviu.dudau=40arm.com>;
>Sudeep Holla <sudeep.holla=40arm.com>; Lorenzo Pieralisi
><lorenzo.pieralisi=40arm.com>; Ray Jui <rjui=40broadcom.com>; Scott Brande=
n
><sbranden=40broadcom.com>; Broadcom Kernel Team <bcm-kernel-feedback-
>list=40broadcom.com>; Sylwester Nawrocki <s.nawrocki=40samsung.com>;
>devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linu=
x-
>samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org
>Cc: Rob Herring <robh=40kernel.org>
>Subject: Re: =5BPATCH 08/10=5D ARM: dts: exynos: use proper 'dma-
>channels/requests' properties
>
>Hi Krzysztof,
>
>On 27.04.2022 17:58, Krzysztof Kozlowski wrote:
>> pl330 DMA controller bindings documented 'dma-channels' and
>> 'dma-requests' properties (without leading hash sign), so fix the DTS
>> to match the bindings.
>>
>> Reported-by: Rob Herring <robh=40kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
>
>Are those properties really needed for PL330 driver on Exynos SoCs? I've
>removed them and I still see the proper values read from registers and
>reported in the log (Exynos4210):
>
>dma-pl330 12680000.dma-controller: Loaded driver for PL330 DMAC-141330
>dma-pl330 12680000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>Num_Peri-32 Num_Events-32
>dma-pl330 12690000.dma-controller: Loaded driver for PL330 DMAC-141330
>dma-pl330 12690000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>Num_Peri-32 Num_Events-32
>dma-pl330 12850000.dma-controller: Loaded driver for PL330 DMAC-141330
>dma-pl330 12850000.dma-controller:       DBUFF-64x8bytes Num_Chans-8
>Num_Peri-1 Num_Events-32
>
>I also don't see any code that would read those properties. IMHO they shou=
ld
>be simply removed at all, at least for the PL330 related nodes.
>
I thought these series is correcting the DMA binding error, however is DMA =
binding itself is broken then probably this need a relook.=20

>> ---
>>   arch/arm/boot/dts/exynos3250.dtsi             =7C  8 ++++----
>>   arch/arm/boot/dts/exynos4.dtsi                =7C 12 +++++------
>>   .../boot/dts/exynos4210-universal_c210.dts    =7C  4 ++--
>>   arch/arm/boot/dts/exynos5250.dtsi             =7C 16 +++++++--------
>>   arch/arm/boot/dts/exynos5410.dtsi             =7C  8 ++++----
>>   arch/arm/boot/dts/exynos5420.dtsi             =7C 20 +++++++++--------=
--
>>   6 files changed, 34 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi
>> b/arch/arm/boot/dts/exynos3250.dtsi
>> index 41bb421e67c2..7bdd4f0782c3 100644
>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> =40=40 -429,8 +429,8 =40=40 pdma0: dma-controller=4012680000 =7B
>>   			clocks =3D <&cmu CLK_PDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		pdma1: dma-controller=4012690000 =7B
>> =40=40 -440,8 +440,8 =40=40 pdma1: dma-controller=4012690000 =7B
>>   			clocks =3D <&cmu CLK_PDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		adc: adc=40126c0000 =7B
>> diff --git a/arch/arm/boot/dts/exynos4.dtsi
>> b/arch/arm/boot/dts/exynos4.dtsi index 5fd17bc52321..2a244aaf84b4
>> 100644
>> --- a/arch/arm/boot/dts/exynos4.dtsi
>> +++ b/arch/arm/boot/dts/exynos4.dtsi
>> =40=40 -676,8 +676,8 =40=40 pdma0: dma-controller=4012680000 =7B
>>   			clocks =3D <&clock CLK_PDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		pdma1: dma-controller=4012690000 =7B
>> =40=40 -687,8 +687,8 =40=40 pdma1: dma-controller=4012690000 =7B
>>   			clocks =3D <&clock CLK_PDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		mdma1: dma-controller=4012850000 =7B
>> =40=40 -698,8 +698,8 =40=40 mdma1: dma-controller=4012850000 =7B
>>   			clocks =3D <&clock CLK_MDMA>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <1>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <1>;
>>   		=7D;
>>
>>   		fimd: fimd=4011c00000 =7B
>> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> index 138d606d58a5..c1b11704b8ee 100644
>> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> =40=40 -666,8 +666,8 =40=40 mdma0: dma-controller=4012840000 =7B
>>   		clocks =3D <&clock CLK_MDMA>;
>>   		clock-names =3D =22apb_pclk=22;
>>   		=23dma-cells =3D <1>;
>> -		=23dma-channels =3D <8>;
>> -		=23dma-requests =3D <1>;
>> +		dma-channels =3D <8>;
>> +		dma-requests =3D <1>;
>>   		power-domains =3D <&pd_lcd0>;
>>   	=7D;
>>   =7D;
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>> b/arch/arm/boot/dts/exynos5250.dtsi
>> index df80ddfada2d..c4c0b4c08094 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> =40=40 -700,8 +700,8 =40=40 pdma0: dma-controller=40121a0000 =7B
>>   			clocks =3D <&clock CLK_PDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		pdma1: dma-controller=40121b0000 =7B
>> =40=40 -711,8 +711,8 =40=40 pdma1: dma-controller=40121b0000 =7B
>>   			clocks =3D <&clock CLK_PDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		mdma0: dma-controller=4010800000 =7B
>> =40=40 -722,8 +722,8 =40=40 mdma0: dma-controller=4010800000 =7B
>>   			clocks =3D <&clock CLK_MDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <1>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <1>;
>>   		=7D;
>>
>>   		mdma1: dma-controller=4011c10000 =7B
>> =40=40 -733,8 +733,8 =40=40 mdma1: dma-controller=4011c10000 =7B
>>   			clocks =3D <&clock CLK_MDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <1>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <1>;
>>   		=7D;
>>
>>   		gsc_0: gsc=4013e00000 =7B
>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi
>> b/arch/arm/boot/dts/exynos5410.dtsi
>> index 4d797a9abba4..6dc08cb0622c 100644
>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>> =40=40 -196,8 +196,8 =40=40 pdma0: dma-controller=40121a0000 =7B
>>   			clocks =3D <&clock CLK_PDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		pdma1: dma-controller=40121b0000 =7B
>> =40=40 -207,8 +207,8 =40=40 pdma1: dma-controller=40121b0000 =7B
>>   			clocks =3D <&clock CLK_PDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		audi2s0: i2s=403830000 =7B
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> b/arch/arm/boot/dts/exynos5420.dtsi
>> index 21b608705049..08198d82ce8d 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> =40=40 -437,8 +437,8 =40=40 adma: dma-controller=403880000 =7B
>>   			clocks =3D <&clock_audss EXYNOS_ADMA>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <6>;
>> -			=23dma-requests =3D <16>;
>> +			dma-channels =3D <6>;
>> +			dma-requests =3D <16>;
>>   			power-domains =3D <&mau_pd>;
>>   		=7D;
>>
>> =40=40 -449,8 +449,8 =40=40 pdma0: dma-controller=40121a0000 =7B
>>   			clocks =3D <&clock CLK_PDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		pdma1: dma-controller=40121b0000 =7B
>> =40=40 -460,8 +460,8 =40=40 pdma1: dma-controller=40121b0000 =7B
>>   			clocks =3D <&clock CLK_PDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <32>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <32>;
>>   		=7D;
>>
>>   		mdma0: dma-controller=4010800000 =7B
>> =40=40 -471,8 +471,8 =40=40 mdma0: dma-controller=4010800000 =7B
>>   			clocks =3D <&clock CLK_MDMA0>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <1>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <1>;
>>   		=7D;
>>
>>   		mdma1: dma-controller=4011c10000 =7B
>> =40=40 -482,8 +482,8 =40=40 mdma1: dma-controller=4011c10000 =7B
>>   			clocks =3D <&clock CLK_MDMA1>;
>>   			clock-names =3D =22apb_pclk=22;
>>   			=23dma-cells =3D <1>;
>> -			=23dma-channels =3D <8>;
>> -			=23dma-requests =3D <1>;
>> +			dma-channels =3D <8>;
>> +			dma-requests =3D <1>;
>>   			/*
>>   			 * MDMA1 can support both secure and non-secure
>>   			 * AXI transactions. When this is enabled in
>
>Best regards
>--
>Marek Szyprowski, PhD
>Samsung R&D Institute Poland


