Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61531535873
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiE0E1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiE0E1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:27:07 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6028EC32A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:27:04 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220527042703epoutp04152d9cf17117839869083d9e3e477e96~y2742sPOM1273212732epoutp04D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220527042703epoutp04152d9cf17117839869083d9e3e477e96~y2742sPOM1273212732epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653625623;
        bh=zXVW3TEfJ1KXlcxGA24ZaWjHWMC7E3yB1TAgrFFv2QY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ZEXJfzDkpHR6LIyKdosqTtX6gSW5g1ZG34ZjbC7zZBsf3pK8sVELHzj9UVvRdhXK6
         6RIzoIPKTNRa5IW/KX1cs3gweHbSubbpN7XdVM9j1kBlxQXYE6WdIrDnNHSZnFRrVf
         j3UjYVSUDtHsV5no5WH15USWOOmZh5oYczUxkkLs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220527042702epcas2p2067ecdbf4976ee47411ab07a0798c2e9~y274SB-mh2907629076epcas2p2L;
        Fri, 27 May 2022 04:27:02 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L8Wwh0q4Nz4x9Pp; Fri, 27 May
        2022 04:27:00 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.B5.09764.21350926; Fri, 27 May 2022 13:26:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220527042657epcas2p2e29aaa3a107c4e062a74e4453fe997ed~y27z-jP602907629076epcas2p26;
        Fri, 27 May 2022 04:26:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220527042657epsmtrp2e51a9dcad12b50a0b37031026f1338f2~y27z_qL481017710177epsmtrp27;
        Fri, 27 May 2022 04:26:57 +0000 (GMT)
X-AuditID: b6c32a46-79619a8000002624-9c-629053126a80
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.00.11276.11350926; Fri, 27 May 2022 13:26:57 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220527042657epsmtip109a721015f1b930989c69d03e4d2c8d6~y27zy_z4L0134601346epsmtip1C;
        Fri, 27 May 2022 04:26:57 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
In-Reply-To: <20220526143707.767490-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/7] ARM: dts: s3c64xx: use local header for pinctrl
 register values
Date:   Fri, 27 May 2022 13:26:57 +0900
Message-ID: <012e01d87182$00af8660$020e9320$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJyxhdZ1KlViaDZ4SOc3qllW0JPVwJJa2ERAg2BLVKr2r9O0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmua5Q8IQkg/alihYP5m1js5h/5Byr
        Rd+Lh8wWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLGef3MVm07j3CbnH4TTurxapdfxgd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv
        4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAblRTKEnNKgUIBicXFSvp2NkX5pSWpChn5
        xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQ9nH2Ip+M1Uce7UFZYGxl1MXYwc
        HBICJhKvFqp1MXJxCAnsYJTYceocC4TziVFi9fe7zBDON0aJ26e7WLsYOcE6XjzpZYVI7GWU
        eP90FVTLC0aJ3dffM4NUsQnoS7zs2AbWISLQySLxq98FxOYUcJVo3nQCrEZYIEri7JXZbCA2
        i4CqxPXDDSwgNq+ApcSX9/1QtqDEyZlPwGxmAXmJ7W/nMENcoSDx8+kyVoi4iMTszjZmkH9E
        BJwk1vXpgdwjIbCWQ+LFc5BLQf50kfi4KRKiVVji1fEt7BC2lMTnd3vZIOxiiaWzPjFB9DYw
        Slze9gsqYSwx61k7I8gcZgFNifW79CFGKkscuQV1GZ9Ex+G/7BBhXomONiGIRnWJA9uns0DY
        shLdcz5DHeMh0TQ7YwKj4iwkL85C8uIsJG/NQli7gJFlFaNYakFxbnpqsVGBETymk/NzNzGC
        066W2w7GKW8/6B1iZOJgPMQowcGsJMJ74WlvkhBvSmJlVWpRfnxRaU5q8SFGU2CgT2SWEk3O
        Byb+vJJ4QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTJmZPD2xmywj
        b8f/rVbIeO4zb+LSQ2c0YhQ0L2vG8bnsCsxX6Zy4QmLp7TwexyQLV+YMn5zjabNu13q33L/c
        k6WeqzR/3YRSBR8Zs6Idpda66Us4BQrKmZgzVm2YrnvyZGBvrkxvZYbf343vTnMwSW3kf/b1
        TG3VU/UK7qm1SQ4HmKbwvvspuVNO8YT69I/GDBVlfCufMyTVO/z6rSCcPdVR5UKdqkCFM9Px
        eYfVdnj+1159Pu10jJat6YLq+0dMqqd4m70wY7zvYCqxpPNX4omFK2J6raTNK54v1w9J6X6R
        8yEjMD3r8PruV5vfaSaoLO44NlV8U+CjlT7fRWZuC+/arfy83tE5MuFWjrcSS3FGoqEWc1Fx
        IgClAVo8RAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnK5g8IQkg9X7zS0ezNvGZjH/yDlW
        i74XD5kt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7Jo3XuE3eLwm3ZWi1W7/jA6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZD2cfYin4
        zVRx7tQVlgbGXUxdjJwcEgImEi+e9LJ2MXJxCAnsZpRon97JCpGQlXj2bgc7hC0scb/lCFTR
        M0aJjg8TWUASbAL6Ei87toE1iAhMZJG4uiIRoug8o8SDu9PAEpwCrhLNm04wg9jCAhES65r7
        2UBsFgFVieuHG8AG8QpYSnx53w9lC0qcnPkEzGYW0JNYv34OI4QtL7H97RxmiIsUJH4+XcYK
        EReRmN3ZBhTnADrCSWJdn94ERqFZSCbNQjJpFpJJs5B0L2BkWcUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERxxWpo7GLev+qB3iJGJg/EQowQHs5II74WnvUlCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MC3eHW3z6cWLPM8cvz5fzS8ZWTtb
        /qxSNcpW3HMoOTLorDg7Ezfb/jXfXkrJvJOZFXD7mG/TdEffJ8oJbxMdyppe7fw3zTJg33Wl
        Fz2T9B5U/1VUnMzqvnj2+6kF8r0fl3iyrSoQ1eo68WBxrE2Anaf6X6m07Ol6a9IFGOXPNPbG
        Rl3b071hxfuDKuWX+liZuSZs7Uqp9J8wp2ZlX1vm/Tv5DidiV2u1hl68eejLb+Gp86Uv56r+
        j/j4P8Tb76tQpfPxxPm/TfNleFyrzwZe1oq3YXz7X21jUyH/Sr0up4wfPrs+77Xo9byoLTVR
        ZMKRxltvkwo/fl35tGviguVJp7J3hKxP2sjve35uuk7wGyWW4oxEQy3mouJEAGW1KDQnAwAA
X-CMS-MailID: 20220527042657epcas2p2e29aaa3a107c4e062a74e4453fe997ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526143737epcas2p37a5854cd0ee466428b36b92378b7d830
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
        <CGME20220526143737epcas2p37a5854cd0ee466428b36b92378b7d830@epcas2p3.samsung.com>
        <20220526143707.767490-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.h
> b/arch/arm/boot/dts/s3c64xx-pinctrl.h
> new file mode 100644
> index 000000000000..c2c88ff96881
> --- /dev/null
> +++ b/arch/arm/boot/dts/s3c64xx-pinctrl.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung's Exynos pinctrl bindings

Exynos -> s3c64xx

Best Regards,
Chanho Park

