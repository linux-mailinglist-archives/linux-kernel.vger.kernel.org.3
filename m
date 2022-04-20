Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B4508530
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbiDTJuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbiDTJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:50:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E13BF93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:47:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220420094723euoutp028599824457bd41e44100ea510bab0ee1~nkcBkEOwz3135231352euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220420094723euoutp028599824457bd41e44100ea510bab0ee1~nkcBkEOwz3135231352euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650448043;
        bh=bgMkVNAEwThKqXPNrfzYaLJr9OBkz6KnPs1ebCuM7hs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=bxXEv/+rlX2xdpUTFb/4K17iNwIdq2mx3oZh1dO6VDq8hrQA7nf9mVIBJof4Ls2U3
         ihxcxST4jV+dDDdikq+PscXVIRRLGaPXxx0QGBwxSEF0D3IUSbN5JFCTZUeiR62np1
         A3Uq3s9KVN+N7NryJv2kWynVTh5gGxPR8U7B/Fio=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220420094723eucas1p12e71a38d430461486f70e554c4bdb902~nkcBPeERN1137711377eucas1p1f;
        Wed, 20 Apr 2022 09:47:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.D1.09887.BA6DF526; Wed, 20
        Apr 2022 10:47:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220420094723eucas1p261eda3b5db7d5f0a4da0d3f01968b683~nkcA6ilkN1158311583eucas1p2Q;
        Wed, 20 Apr 2022 09:47:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220420094723eusmtrp190308a2b1c5480b53ff6c63f9cd73e4e~nkcA50yGs2560825608eusmtrp1x;
        Wed, 20 Apr 2022 09:47:23 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-d7-625fd6ab776b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.33.09404.BA6DF526; Wed, 20
        Apr 2022 10:47:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220420094722eusmtip255a384d5d587d48e927e7afa0cc2c974~nkcAYhyxs1598715987eusmtip2f;
        Wed, 20 Apr 2022 09:47:22 +0000 (GMT)
Message-ID: <9e2306a9-8181-ba43-e331-b3b70c1a72eb@samsung.com>
Date:   Wed, 20 Apr 2022 11:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <70123e98-046f-f10e-1032-8d112edd3ecf@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7qrr8UnGZx9p2hxqXUTu8Wm/U2s
        Fntfb2W3uLxrDpvFjPP7mCx2zjnJarF501Rmi6mvtzA6cHgs2FTq0XLkLavHplWdbB53ru1h
        83h37hy7x+dNcgFsUVw2Kak5mWWpRfp2CVwZjfc6WAoecFQ8OW3UwDiVvYuRk0NCwETi4PHl
        LF2MXBxCAisYJbbO7GGHcL4wSpw4PQHK+cwosbblEVzLzZ17oBLLGSXWL7nKCOF8ZJQ41XSe
        BaSKV8BOYuq+d4wgNouAqsSBCc+ZIOKCEidnPgGrERVIkpi77x4ziC0s4CMx5eIJsHpmAXGJ
        W0/mg9WLCERKvGo5wgIR72aS6GsCq2cTMJToetvFBmJzAu06dXwJE0SNvMT2t3OYQQ6SEHjA
        IbF27WJWiLNdJDY8b2GBsIUlXh3fAvWOjMTpyT1AcQ4gO1/i7wxjiHCFxLXXa5ghbGuJO+d+
        sYGUMAtoSqzfpQ8RdpRoP/qcGaKTT+LGW0GIC/gkJm2bDhXmlehoE4KoVpOYdXwd3M6DFy4x
        T2BUmoUUJrOQ/D4LyS+zEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiQTv87
        /mUH4/JXH/UOMTJxMB5ilOBgVhLhDZ0ZnyTEm5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQ
        QHpiSWp2ampBahFMlomDU6qByTLBd5+887WnOwKf89sU6URNOv0uo2+DtzJro+EvU4G1STHb
        fge+7pPRepTLHvM2g9lErkphWh77v4WzjZ5ZRbIrxN9XLU5wOPCqq2WpbCqPSUmaEI9JgzjT
        YvVn6a80VF0d9qs0FwYy+q9bOy0yb8IZK/8lmpmPrWclz2xWuKktJ2EyV/5mQMDF2rj7Tieq
        K57tvFQs06SuNIf1z3POmx8K/3JP1WU5WlTmuuHwDd8jTg7/IxYZ/5d9aDfNR8Kl5NVelgdR
        5yZ05DzZotp3sFROZUXu++t3r63ZmLPjtKoNx1xn5hl8fe4XxOdeXMbqpjG1MehF/qTVdesa
        rjXu257av4ExMm8Wp6JdX7oSS3FGoqEWc1FxIgBFtnUjtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qrr8UnGVzp4LC41LqJ3WLT/iZW
        i72vt7JbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo871/aw
        ebw7d47d4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2MxnsdLAUPOCqenDZqYJzK3sXIySEhYCJxc+ceIJuLQ0hgKaPE78OfGSESMhIn
        pzWwQtjCEn+udbGB2EIC7xklmicKgdi8AnYSU/e9A6tnEVCVODDhORNEXFDi5MwnLCC2qECS
        xIttz8FqhAV8JKZcPAFmMwuIS9x6Mh+sXkQgUuL262lsIEcwC/QySZw48BHqohPMEofP/gPr
        YBMwlOh6C3EFJ9DmU8eXMEFMMpPo2toFNVVeYvvbOcwTGIVmITlkFpKFs5C0zELSsoCRZRWj
        SGppcW56brGRXnFibnFpXrpecn7uJkZgHG479nPLDsaVrz7qHWJk4mA8xCjBwawkwhs6Mz5J
        iDclsbIqtSg/vqg0J7X4EKMpMDQmMkuJJucDE0FeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
        emJJanZqakFqEUwfEwenVAPTfnUHPYmO1QnrF9jJG33ripuuZfTVxlf0Nc/RHZ06GU4RNR6L
        1TcWFbQ+DbhW8OBvV1Xk/og9tT8DPp/1OCcUKO149dFC9q6E6e3TPP8y2Zvde7xXRi4qpGPT
        nJMbcmdc9lgXqaoxgTu7P1j3jnOMYv2zdaWJTLtTnYP9nBZ4KlUVSkySkQvM33f+7a7pAcEx
        3oZ+/9VfhJbe8g6ZdShY0fP6x1vC1vuZ20/fkvbRFXDbXz8jjI/JxTaeJ+2EzWQWDcaD534z
        v/C6eJnjp/ZRw163HYbs4v2CS6/2P1/HsDnfN3qPSFvrReWUO91rm3fYRC21zXFynrmV0zhe
        RmpnZdGCc+vbJHLZP6z+rMRSnJFoqMVcVJwIANK4fmhMAwAA
X-CMS-MailID: 20220420094723eucas1p261eda3b5db7d5f0a4da0d3f01968b683
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
References: <20220405185040.206297-1-maz@kernel.org>
        <20220405185040.206297-3-maz@kernel.org>
        <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
        <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
        <878rs8c2t2.wl-maz@kernel.org>
        <5dcf8d22-e9b3-f306-4c5f-256707e08fbf@samsung.com>
        <877d7sar5k.wl-maz@kernel.org>
        <39f69dfe-32e5-4cb3-118b-5c02b28cbcff@samsung.com>
        <70123e98-046f-f10e-1032-8d112edd3ecf@linaro.org>
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 20.04.2022 11:13, Krzysztof Kozlowski wrote:
> On 14/04/2022 13:08, Marek Szyprowski wrote:
>>> Thanks for all of the debug, super helpful. The issue is that we don't
>>> handle the 'force' case, which a handful of drivers are using when
>>> bringing up CPUs (and doing so before the CPUs are marked online).
>>>
>>> Can you please give the below hack a go?
>> This patch fixed the issue. Thanks! Feel free to add my:
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Hi Marc,
>
> Linux-next still fails to boot on Exynos5422 boards, so I wonder if you
> applied the fix?
>
> Instead of silent fail there is now "Unable to handle kernel paging
> request at virtual address f0836644", so it is slightly different.

This is yet another issue (related to all ARM 32bit boards) introduced 
in next-20220413, see:

https://lore.kernel.org/all/20220405014836.14077-1-peterx@redhat.com/T/#m6137721ae1323fdf424cee0f8ea1a6af5a3af396

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

