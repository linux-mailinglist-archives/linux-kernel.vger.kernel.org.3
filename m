Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73906511DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiD0QpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiD0QpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:45:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667668989
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:41:55 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427164151epoutp01900e35679ec35e2475f50a4b30cd3fb9~pzm5S2GyL1335613356epoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427164151epoutp01900e35679ec35e2475f50a4b30cd3fb9~pzm5S2GyL1335613356epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651077711;
        bh=oEJc213fWBSOqAC9X/iPQyapal9ZqILFmzDrPoypwKk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=L2eJ+32CmMLXP7fsEaDuAp8UFXzghIbpmlqiFYvVCOZZRoLvuvu+ZnlS8NvPQjbDi
         ommHDi8Te158IMrS8rPPCiIzYX4uCOi/+AzSg2U//KMyOah2ZvUMxloBjuM+hVTA1+
         J4FuGHJuJsJu6T/EpVHq/xw3B1N6ZGWCPCQ6PLmM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220427164150epcas5p273d23f3bbe5dea78d3569fc30a18e6b3~pzm4qwtsU0338003380epcas5p2n;
        Wed, 27 Apr 2022 16:41:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KpPfM1QRPz4x9Pp; Wed, 27 Apr
        2022 16:41:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.32.09762.A4279626; Thu, 28 Apr 2022 01:41:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220427164145epcas5p4439e423d437a847f09734e2f857dd638~pzmz1OLdb0275202752epcas5p4w;
        Wed, 27 Apr 2022 16:41:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427164145epsmtrp24e1e77cd66e4cdbe92fd5e5605801ddb~pzmz0OTYT1831418314epsmtrp2q;
        Wed, 27 Apr 2022 16:41:45 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-a9-6269724ae2cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.CB.08924.94279626; Thu, 28 Apr 2022 01:41:45 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427164143epsmtip13387e79e48c6c8dd9f08c54b0f5f9811~pzmxUr33h2854928549epsmtip1C;
        Wed, 27 Apr 2022 16:41:42 +0000 (GMT)
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
In-Reply-To: <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 06/10] dt-bindings: mfd: samsung,exynos5433-lpass: fix
 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 22:11:41 +0530
Message-ID: <000001d85a55$ae9b6850$0bd238f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQnzfwuAxkOYqHux9KbyQb5tlOAgH0g7qSAm5vulutcFRuMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH92tvby9mHdfK1p+VsO5OMiUBW2nrxVBG0C1ljEmyhM3FDK7l
        rq30td52G2XLdAQZOHDGPSyrUxlDVyFgddqUh47HFETZnLhkMzwElWdFimEV0JVe3Pjve875
        nNfvgXGFfagY05tstNVEGQh0BXK2bf1L8RlW/U7p/VNcsq68AyGPtF/lkR09jRyyYmSQSzaP
        /8wn+x90ANIzdINH/uFzoeShnhYOeeHHEoScmBvhk/7Rt8nbztMoWdzczicfN3n5ZNtECY/0
        nxwG5PEuL5IqVNd+XwvUlf1XULXHXYqqb95oQtWnqz9VV5xxA3XAE6NuDswhWdg7+ck6msqj
        rRLapDHn6U1aFZHxZs6WHIVSKouXJZGbCImJMtIqYuvrWfGv6g2hVQjJB5TBHnJlUQxDbEhJ
        tprtNlqiMzM2FUFb8gwWuSWBoYyM3aRNMNG2zTKpdKMiBObm6x4OefiWf4QfzTR7eLvBHrwM
        RGAQl8OSmx5QBlZgQrwRQNe9Fh5rTAM4/MsthDUCAFbMXuQ8Salu7F5K8QF4x9mNssYogN99
        VcddpFA8Hnp/2BsOROFBHvQVHUUWA1w8FrrmH4ahCPwV2DT7dbjsKtwMg72+MIOEmLnq4rBf
        gCfBOucDwOqVsNM5vFTneXhu0sVlR5LA4O0a3qKOwtOg69jgEiOCox3t/MUhID6DQf9Ibago
        FjK2wlMNMWzuKjh28Qyf1WIY8DejLKKGVfNi1q2Dk8frAatfhheuu5BFhIuvh/W+DWynZ2D5
        3PBScQH8fK+QpWNhkb8XYfUaeGDfPh6r1XCh5TP+l+CFymV7VS7bq3LZ/JX/NzsKEDdYTVsY
        o5ZmFJZEE/3hf/etMRs9IPzQ4zK84NbAVEIr4GCgFUCMS0QJZhp1O4WCPKrAQVvNOVa7gWZa
        gSJ02Ae44mc15tBPMdlyZPIkqVypVMqTEpUyQiTo0jZQQlxL2eh8mrbQ1id5HCxCvJvj6JVM
        t3A22yOFadnvPmfH0mfGxDENRzrfl9+r86Zytkd3np+5m6pPOenckpFd0FrlX8msLS4TnG3P
        La9xzKoGOJmXXPdFxkHLFw7Z9TWmmh3IT+nzvt8W6N61BydWX74zkJY+fkIzGR336LXEw4U9
        kdOXPNqSWOeURNOSvJ3YdSwFjfY+2rMu8q70vH3bNZ0rWLXxz8aR0oUTE+2ZB0VT7vr3dq3z
        /J47bv/4qcdv4Spnh/yTgGYkokjUcK0tyWeMSOyeLvzWLnoRu6o3d/fhmYWX9xe9sf9pbet4
        gUQ7VPpX06GuX7VX+sbGKmoKRX+r+s9t87ol2cEdhzc5ZCVA8Q2BMDpKFse1MtS/NAPfFHEE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnK5nUWaSQUOTpsXa3qMsFvOPnGO1
        OHp+N5NF34uHzBZ7X29lt7j/9SijxabH11gtLu+aw2Yx4/w+JosDS9tZLN78fsFu8e5lhMXT
        mZvZLFr3HmG3+L9nB7vF4TftrBbvVj9htFh+ageLg5DHmnlrGD1m3T/L5rFpVSebx51re9g8
        Ni+p9+jbsorR4/MmOY+9n3+zBHBEcdmkpOZklqUW6dslcGX8eryJveCHUMWXvZtYGxgbBboY
        OTkkBEwkluw+w9jFyMUhJLCDUWLC5G8sEAlpiesbJ7BD2MISK/89Z4coes4osebpDrAEm4Cu
        xI7FbWwgCRGBVjaJlR96wbqZBVQl5vz5xQzRcZ5RYt61ViaQBKeAq8Se71PBbGGBXInfO+cy
        gtgsQA2/l0DU8ApYSqyd+ZURwhaUODnzCdBQDqChehJtGxkh5stLbH87hxniOgWJn0+XsYLY
        IgJOEnMWPoS6QVzi5dEj7BMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAKC+1XK84
        Mbe4NC9dLzk/dxMjOK61tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgqg6KC4k6Ffq4PcU2KSQzV2OuDdNx
        LZGaeZ+38S8/2i43xVb4zzWpusWL36l1LWIJFfn+vM7kOo93scCnT1sUps9Wj+ywyc73KXG+
        ZdfXmLjlY4vHfG/2CUEckRV2242W3w6zaAv/Ob1f89veSqaV9jMZliy7I33r++fbl9szN4UH
        b7nfHWtVw/F47b/e/D/qjvcucFScWya5XmW+UWikV1aYWfsG7bfPftzr45zCZ2UXXSM3zX/2
        pZTzfiGrZwR2C0dlbtsRG8ceke95qqbY2mej5/pb56L847a5vaq+dW0Rf5J59FzxIk7V4KAt
        bAfzpdWq1LacZwuZE89TrePoV2YWy7foLlfDoyJ5DyWW4oxEQy3mouJEAGVc/vdaAwAA
X-CMS-MailID: 20220427164145epcas5p4439e423d437a847f09734e2f857dd638
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427155859epcas5p239f497d1f81514bddaeac03b1b22b30b
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427155859epcas5p239f497d1f81514bddaeac03b1b22b30b@epcas5p2.samsung.com>
        <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
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
>Subject: [PATCH 06/10] dt-bindings: mfd: samsung,exynos5433-lpass: fix
>'dma-channels/requests' properties
>
>pl330 DMA controller bindings documented 'dma-channels' and 'dma-
>requests' properties (without leading hash sign), so fix the DTS to match
the
>bindings.
>
>Reported-by: Rob Herring <robh@kernel.org>
>Fixes: e18183cefc8b ("mfd: Add DT bindings documentation for Samsung
>Exynos LPASS")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
Looking at Documentation/devicetree/bindings/dma/dma-common.yaml
This change looks good.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> .../devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml     | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-
>lpass.yaml b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-
>lpass.yaml
>index f7bb67d10eff..b97b06848729 100644
>--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-
>lpass.yaml
>+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-
>lpass.yam
>+++ l
>@@ -79,8 +79,8 @@ examples:
>             clocks = <&cmu_aud CLK_ACLK_DMAC>;
>             clock-names = "apb_pclk";
>             #dma-cells = <1>;
>-            #dma-channels = <8>;
>-            #dma-requests = <32>;
>+            dma-channels = <8>;
>+            dma-requests = <32>;
>             power-domains = <&pd_aud>;
>         };
>
>--
>2.32.0


