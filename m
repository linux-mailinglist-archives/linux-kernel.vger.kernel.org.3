Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915E84AD94E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiBHNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbiBHMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:37:21 -0500
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 04:37:18 PST
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3308C03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:37:18 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220208122956euoutp017da114aec742da591306d358dcdb095b~Rz2qsJNA80229102291euoutp01q
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:29:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220208122956euoutp017da114aec742da591306d358dcdb095b~Rz2qsJNA80229102291euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644323396;
        bh=jZc97aeAsEvvpN9tAfHxmY3tUD4xtDYsP0SBRSqq3ZI=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=jp58hwoamFlZrbE/mS5xM9RMCWW/gMVd4K0utVIrhY8xfKEwVZH/gskWSNPPAcsMn
         jWRiBBi/D1bFVnW/FBcCOEpRV2xQn/UfwsJpDX+6+XxM1Nsov5aOsiKvM8I3sNSrSK
         BEJwZMxLc1tbt06y01GHOU2DoHAtmWeZ2UWLRMIU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220208122955eucas1p23619f0d4cb5827cbe650eeaec7ced526~Rz2qUYoby0233702337eucas1p2t;
        Tue,  8 Feb 2022 12:29:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.33.10009.34262026; Tue,  8
        Feb 2022 12:29:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca~Rz2pwxCFp2822328223eucas1p2k;
        Tue,  8 Feb 2022 12:29:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220208122955eusmtrp109c71f4b9e7262f46c9594bc30fdf8d0~Rz2pvufy50537505375eusmtrp1J;
        Tue,  8 Feb 2022 12:29:55 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-df-620262432b31
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.E7.09404.24262026; Tue,  8
        Feb 2022 12:29:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220208122954eusmtip29a0f6f47337d4dbacc3fea2650576ed6~Rz2pN4-Zw2819028190eusmtip2F;
        Tue,  8 Feb 2022 12:29:54 +0000 (GMT)
Message-ID: <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
Date:   Tue, 8 Feb 2022 13:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Content-Language: en-US
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rOSUxJBpefSltMffiEzaJ58Xo2
        i/PnN7BbXN41h81ixvl9TBZr/i1mtpj7ZSqzA7vHplWdbB77565h95i4p87j8ya5AJYoLpuU
        1JzMstQifbsEroz2eQ/ZC/5wVezdvI61gfEzRxcjB4eEgInEqWcsXYxcHEICKxgldp16zgzh
        fGGUOH9lF5TzmVHi45wLQGWcYB1v+icyQSSWM0rcXvcLqv8jo8TJ4xvZQap4Bewktp5bC2az
        CKhILDq5gQUiLihxcuYTMFtUIEnics9xRhBbWCBCYuOh5UwgNrOAuMStJ/PBNogIbGCS+LTi
        KliCTcBQouttFxuIzQm0oOXdV2aIBnmJ7W/ngN0qIXCEQ+Lo51/sELe6SKy51gFlC0u8Or4F
        ypaROD25hwWioZlR4iHYqSBOD6PE5aYZjBBV1hJ3zv1iA4UTs4CmxPpd+hBhR4l7R0+yQ4KP
        T+LGW0GII/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuMUPYHhKvpq1mmsCoOAspXGYh+X8W
        ktdmIdywgJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmDqOf3v+KcdjHNffdQ7xMjE
        wXiIUYKDWUmEV6b7f6IQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUw
        WSYOTqkGJin9pyFbLMP42bm6jGZnrPqVVRLeJMa3+/ui8w0/Fx82e1NVcfL10k3xP5bKFvRz
        /hB84cpwpPTc6722S1wsojX694RfyGnhn121eKePe9Smq9ctIz/nvzh/0j7/h33xHzeBRedq
        Wqxc3q3gcVj5/L1PwdvCkrRLzw/FZU2eF/HixpVAwynBM78KepywZPq4oUK/8rkr6/FJPzK+
        skyYUi/LnKEcnijJIVbTcEkp4NST6/XLf/s+Oq38YTWbVqmmhnSJmdwDrYSLtkpmf5ti3548
        e24Je+rj4+z91zu6HTTtf1ze0NBY9ivz067A2YG7trje1ggK7Iyfot68qOPp8uTbb4PqGeSd
        hL5N5l2RrMRSnJFoqMVcVJwIAJEzONqsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7pOSUxJBtv/mVtMffiEzaJ58Xo2
        i/PnN7BbXN41h81ixvl9TBZr/i1mtpj7ZSqzA7vHplWdbB77565h95i4p87j8ya5AJYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYz2eQ/ZC/5w
        VezdvI61gfEzRxcjJ4eEgInEm/6JTF2MXBxCAksZJQ4sm8AIkZCRODmtgRXCFpb4c62LDaLo
        PaPEoxv/2EASvAJ2ElvPrWUHsVkEVCQWndzAAhEXlDg58wmYLSqQJPFw8TuwemGBCImNh5Yz
        gdjMAuISt57MB9ssIrCJSeLnjkNgDUICthItzb1gDWwChhJdb7vAbE6gZS3vvjJDNJtJdG3t
        YoSw5SW2v53DPIFRcBaS3bOQ7JiFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
        AmNq27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFeme7/iUK8KYmVValF+fFFpTmpxYcYTYEBMJFZ
        SjQ5HxjVeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTJmxp6Wr
        fub3Bb1cKpKrKhb9vLkkZPXyhZWXpzL8dz6T8UVu3oxbnxNWFhVWmezZlFd8+mbvjEMffS72
        uW5/tjRNLu2Zs+qVosudh748mJ0p+JLza+a3Hw7GbMktrkm/veOM3nJbtaTO/c5/01SuonFy
        zX42uSmG1/1r//9eW+k8qY/b5BefzPwM456gq1lqK9we7+Zxmspq9ivkj9+xkGePX4o6bhJk
        mbrRlT938byPDhc2dplYpRQYW0nKsb7jXOkmvebSIolmtcc3BGdflLm4JmfV3z/LUipOKmRU
        zA5R/z5F3/Eky4NcgeD5JXcvb3DcfErpm4diLbM16/7k+ZxTU07+OFdx22BF7QnGVUosxRmJ
        hlrMRcWJAOoX6jkyAwAA
X-CMS-MailID: 20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
        <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On 19.01.2022 15:29, Prasad Kumpatla wrote:
> With the existing logic by using regmap_write() all the bits in
> the register are being updated which is not expected. To update only the
> interrupt raised bit and not tocuhing other bits, replace regmap_write()
> with regmap_irq_update_bits().
>
> This patch is to fix the issue observed in MBHC button press/release events.
>
> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

There is something wrong with this patch. Since it landed in linux-next 
(20220204) I get an interrupt storm on two of my test devices:

1. ARM 32bit Exynos4412-based Trats2 ("wm8994-codec wm8994-codec: FIFO 
error" message)

2. ARM 64bit Exynos5433-based TM2e ("arizona spi1.0: Mixer dropped 
sample" message)

Definitely the interrupts are not acknowledged properly. Once I find 
some spare time, I will check it further which regmap configuration 
triggers the issue, but it is definitely related to this patch. 
Reverting it on top of current linux-next fixes the issue.

> ---
> Changes Since V1:
> -- Update commit message.
>
>   drivers/base/regmap/regmap-irq.c | 52 ++++++++++++++++++--------------
>   1 file changed, 29 insertions(+), 23 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

