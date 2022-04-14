Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99F500BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiDNLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiDNLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:11:28 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B37E08D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:09:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220414110855euoutp02bf5135fb943a6d8ec7b2748aeb5a208a~lvrfM5MeP3048230482euoutp02R
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:08:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220414110855euoutp02bf5135fb943a6d8ec7b2748aeb5a208a~lvrfM5MeP3048230482euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649934535;
        bh=l8T412n44Yp8hAPgEFINj7TZEYgRQmaaW9IgQHPhOAg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=RYMYV1izqrtEXKoUVB3GtlD83LSfg4jVU7wvdy5U1bY15gEibntszAjAjqTgbeCrC
         9s0GhNda9h2Q2l74xxjidMbyXrhNGxIVihBCzpiJBGuuIJlzdeoBbU3XSfbbbYo/xL
         iCArvU5RHDmdoIcdZzln0C1xwxWwVJs4Ew6VZu8E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220414110854eucas1p25898fff27fdc75b3bf54e9ac29134c32~lvre57xW12774927749eucas1p2X;
        Thu, 14 Apr 2022 11:08:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.4B.10009.6C008526; Thu, 14
        Apr 2022 12:08:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220414110854eucas1p2a037d45634218755b6a3c9bbfdb802ad~lvref1gT01069910699eucas1p2k;
        Thu, 14 Apr 2022 11:08:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220414110854eusmtrp1c883916e5468b2e625e1e91a5cf6cc74~lvrefFM2k2806528065eusmtrp1l;
        Thu, 14 Apr 2022 11:08:54 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-e6-625800c68830
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.0A.09522.6C008526; Thu, 14
        Apr 2022 12:08:54 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220414110853eusmtip277fdf49fb3793be6fb8c58261ef21493~lvrd-WfX-1076510765eusmtip2O;
        Thu, 14 Apr 2022 11:08:53 +0000 (GMT)
Message-ID: <39f69dfe-32e5-4cb3-118b-5c02b28cbcff@samsung.com>
Date:   Thu, 14 Apr 2022 13:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <877d7sar5k.wl-maz@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rHGCKSDGYd0rO41LqJ3WLT/iZW
        i/PnN7BbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo93586x
        e3zeJBfAGsVlk5Kak1mWWqRvl8CVsXbVPKaCe0IVcw92sTcwLufvYuTkkBAwkVjRtJu5i5GL
        Q0hgBaPEzmdNTBDOF0aJK+23WSGcz4wSixs/s8C0dO+8wgpiCwksZ5Q4+SEOougjo8SLdX/Z
        QRK8AnYSKx+8BitiEVCV+PplGyNEXFDi5MwnYINEBZIk5u67xwxiCwv4SEy5eAKshllAXOLW
        k/lMILaIgKLEpwsnoeJbmCQ2b8gCsdkEDCW63naxgdicAtoShz9/YIGokZfY/nYO2D8SAk84
        JF58PQV1tYvEg0lX2SBsYYlXx7ewQ9gyEqcn9wDVcADZ+RJ/ZxhDhCskrr1ewwxhW0vcOfeL
        DaSEWUBTYv0ufYiwo0T70efMEJ18EjfeCkJcwCcxadt0qDCvREebEES1msSs4+vgdh68cIl5
        AqPSLKQwmYXk91lIfpmFsHcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwDR0+t/x
        TzsY5776qHeIkYmD8RCjBAezkgjvzf7wJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE
        0hNLUrNTUwtSi2CyTBycUg1MDF6fzO9P++Ay/cTRDyb28xbJhjG6bT33rpz9SshH1g/rLe23
        a91bvipf0KmpuaP6z4EX8x29pJYbaQgZSyRKveJdL/H61dq2sAsPDBPnLmfI93QRuF3kt9mg
        4PN1zo1HrB51uT8778b6tl66L1PybcGHnF1zHL5OFD4+deOWhaz3Zz/UlXS55Oy1vjy+9d/l
        b0/+82RZvD9rylCoqaR1wVv5UofeniUCG3nXi5/d0XhsizXT33U/TI0n81q46hpHHCzsnvZC
        0sNduOZbz3lDnmbPjo0sC4WuHrG/EiSrf9KurmTqWcs9WR5XeoOrU/sNl4pobWafr3FrvUEB
        3/U5fP4rjnrqhyr25qQuYvZRYinOSDTUYi4qTgQAMN/dg7IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7rHGCKSDC6+E7C41LqJ3WLT/iZW
        i/PnN7BbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo93586x
        e3zeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXsXbVPKaCe0IVcw92sTcwLufvYuTkkBAwkejeeYW1i5GLQ0hgKaPExz1djBAJGYmT0xpY
        IWxhiT/Xutggit4zSnybc5ANJMErYCex8sFrsCIWAVWJr1+2MULEBSVOznzCAmKLCiRJvNj2
        HCwuLOAjMeXiCTCbWUBc4taT+UwgtoiAosSnCycZQRYwC2xhkji4axcjxLb7TBLndz4Dq2IT
        MJToetsFtplTQFvi8OcPLBCTzCS6tnZBTZWX2P52DvMERqFZSA6ZhWThLCQts5C0LGBkWcUo
        klpanJueW2yoV5yYW1yal66XnJ+7iREYgduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8N7sD08S
        4k1JrKxKLcqPLyrNSS0+xGgKDI2JzFKiyfnAFJBXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQ
        nliSmp2aWpBaBNPHxMEp1cCkGVYXedmWJayt9M03/x2/JFZcFrdfXbRENsl3l2aiO0tlzuG2
        m0Hrf/6a0S6qtpGPJeyy+IfZR+6u7drjstT41OWlcdlLw4wVV8+RzLm9k6vmd9+3w76Hv1kJ
        cM5wPnLr9sKZzkb82UXu4W7O2/0d2U+7G4tM/rDy8RJzZnnpPVN/MHRWSKzQrfDN4Jn5Ycui
        6sfqCaLWT68niTxw2XHkaPb2vy6WR2c5HZxdodF840+l8GM2fVZ9wSUTOBOu2ax8WOJqa7zv
        6NMFDxTDRM15VvNop1ZKySeIuoZPtErSC+71Cm6YkX4n6IzqPPYVE/vT/wgV1f/OubTg2ZTy
        hbUnDrI+uLhrSpvCa5mrneJKLMUZiYZazEXFiQBm0/mGSQMAAA==
X-CMS-MailID: 20220414110854eucas1p2a037d45634218755b6a3c9bbfdb802ad
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 14.04.2022 12:35, Marc Zyngier wrote:
> On Thu, 14 Apr 2022 10:09:31 +0100,
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 13.04.2022 19:26, Marc Zyngier wrote:
>>> On Wed, 13 Apr 2022 15:59:21 +0100,
>>> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> On 05.04.2022 20:50, Marc Zyngier wrote:
>>>>> When booting with maxcpus=<small number> (or even loading a driver
>>>>> while most CPUs are offline), it is pretty easy to observe managed
>>>>> affinities containing a mix of online and offline CPUs being passed
>>>>> to the irqchip driver.
>>>>>
>>>>> This means that the irqchip cannot trust the affinity passed down
>>>>> from the core code, which is a bit annoying and requires (at least
>>>>> in theory) all drivers to implement some sort of affinity narrowing.
>>>>>
>>>>> In order to address this, always limit the cpumask to the set of
>>>>> online CPUs.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> This patch landed in linux next-20220413 as commit 33de0aa4bae9
>>>> ("genirq: Always limit the affinity to online CPUs"). Unfortunately it
>>>> breaks booting of most ARM 32bit Samsung Exynos based boards.
>>>>
>>>> I don't see anything specific in the log, though. Booting just hangs at
>>>> some point. The only Samsung Exynos boards that boot properly are those
>>>> Exynos4412 based.
>>>>
>>>> I assume that this is related to the Multi Core Timer IRQ configuration
>>>> specific for that SoCs. Exynos4412 uses PPI interrupts, while all other
>>>> Exynos SoCs have separate IRQ lines for each CPU.
>>>>
>>>> Let me know how I can help debugging this issue.
>>> Thanks for the heads up. Can you pick the last working kernel, enable
>>> CONFIG_GENERIC_IRQ_DEBUGFS, and dump the /sys/kernel/debug/irq/irqs/
>>> entries for the timer IRQs?
>> Exynos4210, Trats board, next-20220411:
> Thanks for all of the debug, super helpful. The issue is that we don't
> handle the 'force' case, which a handful of drivers are using when
> bringing up CPUs (and doing so before the CPUs are marked online).
>
> Can you please give the below hack a go?

This patch fixed the issue. Thanks! Feel free to add my:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

