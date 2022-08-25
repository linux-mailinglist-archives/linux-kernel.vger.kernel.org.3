Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4A5A1381
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiHYOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiHYOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347DB6028
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220825142325euoutp026a9946bb02cc605ca10dc4ca3acc1c4c~OnIRomN2g1717017170euoutp02x
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220825142325euoutp026a9946bb02cc605ca10dc4ca3acc1c4c~OnIRomN2g1717017170euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661437405;
        bh=Huwdp/Iixibsm1+U+Ec1zSSlNuiVTB4RieBDCeUbh60=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=aCTPEhxjI4Kn3h+UMdnKxEwTwvAGUhaGwLVFcSc+7NDlSS6++JN3cJTtwlcjf5b4D
         CYDAwydULWyIA4Sfb8sTwbE7ioVtlS+y5ZDiK936luIjffWj1jRz2X88I0P9LyFjrG
         hrlQeu2lqKCC2mwvdrzsK5DfZNJN3TvroolSRbuc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825142324eucas1p28b9945a763d61eefa0a1926d478203ec~OnIRVXztV1050010500eucas1p2e;
        Thu, 25 Aug 2022 14:23:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.32.29727.CD587036; Thu, 25
        Aug 2022 15:23:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220825142324eucas1p1cd5c4bbba236542b758269a11a2fb9ab~OnIQz1uqE1219512195eucas1p13;
        Thu, 25 Aug 2022 14:23:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220825142324eusmtrp14df396a5be6d1910922e318235988b4d~OnIQy45Ad1357613576eusmtrp1N;
        Thu, 25 Aug 2022 14:23:24 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-83-630785dc1bdc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.EB.07473.CD587036; Thu, 25
        Aug 2022 15:23:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220825142323eusmtip2b3f4a238ad06be12ed4d0ea06e8bfa49~OnIQMl41E3051730517eusmtip2b;
        Thu, 25 Aug 2022 14:23:23 +0000 (GMT)
Message-ID: <a78822d5-f0a1-6c42-8269-e8168ea5cd5b@samsung.com>
Date:   Thu, 25 Aug 2022 16:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4] regulator: core: Resolve supply name earlier to
 prevent double-init
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Christian_Kohlschu=cc=88tter?= 
        <christian@kohlschutter.com>, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <YwdpOX0xCzYwhjmx@sirena.org.uk>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87p3WtmTDf7sU7OY+vAJm8X2Q8/Z
        LP4/es1q8e1KB5PFpsfXWC0u75rDZnHkfz+jxacH/5ktXh75wWhx8MMTVovja5+xWcyae53N
        gcdjzbw1jB637tR77Jx1l91j06pONo9Jk3cxeWxeUu+x/do8Zo/Pm+QCOKK4bFJSczLLUov0
        7RK4MprepBZsFa5o2NfG0sB4nb+LkYNDQsBE4t/S2i5GLg4hgRWMEkcedDNCOF8YJWa9bmDp
        YuQEcj4zSsyfGQdigzR0XOtggyhazigx79IaJgjnI6NE16EuZpAqXgE7ib0HZ4LZLAKqEqdP
        9zJBxAUlTs58AjZVVCBZ4tn/xewgtrBArETX9O1gcWYBcYlbT+aD1YsIKEtc/b6XBWQBs8Bl
        JolXi54xgiTYBAwlut52sYHYnAK6Ev8fLGOGaJaXaN46mxmkQUKgn1PiwM5+Roi7XSSeHT3C
        AmELS7w6voUdwpaROD25hwUSGPkSf2cYQ4QrJK69XsMMYVtL3Dn3iw2khFlAU2L9Ln2IakeJ
        nl2sECafxI23ghAH8ElM2jadGSLMK9HRJgQxQ01i1vF1cCsPXrjEPIFRaRZSmMxC8vssJK/M
        Qli7gJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAaO/3v+KcdjHNffdQ7xMjEwXiI
        UYKDWUmE1+oYS7IQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYO
        TqkGphYNtvhbV/7czFkWmsx5wYBp/ralRwQm2vb9OnT35o/K+EV7spZZfJ9/+7X4rwUH1aUW
        GHqvcanYU3/p0JKnzgbaKpxik05vOp6VJM0fpfPHt8jjHYeEu+6eq3Pjw/rslq8vFJsrzMnz
        +WPxWsUTzD6biz5ZdAZkrdxxybu9gu/xlocKz39V+ndV7DL/N1di7v3Lak/t3VWz/33v3sib
        9CZh+z3pSZteHg8LPCKV8Gue78wyUV+lCcnfufQdvmm6hb8wyfw355w2o2XPjNOqs+bF+Au3
        TRD7cluvch7X0qlrfd+/8FSPnZzO9yR7XcCKWOHHE/yO7G5dUcr9sME0yF+PUZMx7OTtUPs9
        J5RqXymxFGckGmoxFxUnAgAFREnM0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7p3WtmTDXpPs1hMffiEzWL7oeds
        Fv8fvWa1+Halg8li0+NrrBaXd81hszjyv5/R4tOD/8wWL4/8YLQ4+OEJq8Xxtc/YLGbNvc7m
        wOOxZt4aRo9bd+o9ds66y+6xaVUnm8ekybuYPDYvqffYfm0es8fnTXIBHFF6NkX5pSWpChn5
        xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GU1vUgu2Clc07GtjaWC8
        zt/FyMkhIWAi0XGtg62LkYtDSGApo8SpVd/ZIRIyEienNbBC2MISf651QRW9Z5TovQPicHLw
        CthJ7D04kxnEZhFQlTh9upcJIi4ocXLmExYQW1QgWWLBoaVgtrBArETX9O1gNrOAuMStJ/PB
        6kUElCWuft8LFb/MJHHxigrEsl4miaYVj8CWsQkYSnS9hVjMKaAr8f/BMmaIBjOJrq1djBC2
        vETz1tnMExiFZiG5YxaSfbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYARv
        O/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJrdYwlWYg3JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbn
        A1NIXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk0Pjyx5Oh922
        rjueWPNdqqm2+2jgF3dd13TP19gvnmVhEsWBnmuN/1RuilOdqpnpMvXlvxUNgs2RB9+4nYh7
        sqt0bWLNnQieg73zg6Ycs8261f3u/vxvE6aeeSJbVfbb9KrKjN+X187+L9DztznImZ3Z6Y3X
        5rsvtBsFduiWaP8QODNrydoXGxeU1x/KOGmwd0/+3VST+dEc0nP2PD3rPdtcfMbmUiH2PZEb
        NkQaWHu7zZj02OtrRpRHpNcvZSmOF2fP3z7c6R9+YjV39MM4902Kt+4GSnSnRriEZi28KsK4
        Vr9SZIbksXX8mxZbT3v9tyBtrcTFk1+60vceKuN+vObkLed1jGf4b+8QvLZ2R4gSS3FGoqEW
        c1FxIgDAntcbaQMAAA==
X-CMS-MailID: 20220825142324eucas1p1cd5c4bbba236542b758269a11a2fb9ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220825113251eucas1p247c3d57de823da148ca4790975a4aba8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220825113251eucas1p247c3d57de823da148ca4790975a4aba8
References: <YvorNPDQQr2SH/NF@sirena.org.uk>
        <20220818124646.6005-1-christian@kohlschutter.com>
        <CGME20220825113251eucas1p247c3d57de823da148ca4790975a4aba8@eucas1p2.samsung.com>
        <58b92e75-f373-dae7-7031-8abd465bb874@samsung.com>
        <YwdpOX0xCzYwhjmx@sirena.org.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 25.08.2022 14:21, Mark Brown wrote:
> On Thu, Aug 25, 2022 at 01:32:50PM +0200, Marek Szyprowski wrote:
>
>> This patch landed recently in linux next as commit 8a866d527ac0
>> ("regulator: core: Resolve supply name earlier to prevent double-init").
>> Unfortunately it breaks booting of Samsung Exynos 5800 based Peach-Pi
>> (arch/arm/boot/dts/exynos5800-peach-pi.dts) and Peach-Pit
>> (arch/arm/boot/dts/exynos5420-peach-pit.dts) Chromebooks. The last
>> message in the kernel log is a message about disabling 'vdd_1v2'
>> regulator. This regulator is not used directly, however it is a supply
>> for other critical regulators.
> This suggests that supplies are ending up not getting bound.  Could you
> perhaps add logging to check that we're attempting to resolve the supply
> (in the
>
>
> +       if ((rdev->supply_name && !rdev->supply) &&
> +                       (rdev->constraints->always_on ||
> +                        rdev->constraints->boot_on)) {
>
> block)?


I've spent a little time debugging this issue and here are my findings. 
The problem is during the 'vdd_mif' regulator registration. It has one 
supply called 'inb1' and provided by 'vdd_1v2' regulator. Both 'vdd_mif' 
and 'vdd_1v2' regulators are provided by the same PMIC.

The problem is that 'inb1' supply is being routed to dummy regulator 
after this change. The regulator_resolve_supply(), which is just after 
the above mentioned check, returns 0 and bounds 'vdd_mif' supply to 
dummy-regulator. This happens because regulator_dev_lookup() called in 
regulator_resolve_supply() returns -19, what in turn lets the code to 
use dummy-regulator. I didn't check why it doesn't return -EPROBE_DEFER 
in that case yet.

> I'd also note that it's useful to paste the actual error
> messages you're seeing rather than just a description of them.

There is really nothing more that I can paste here:

[   32.306264] systemd-logind[1375]: New seat seat0.
[   32.331790] systemd-logind[1375]: Watching system buttons on 
/dev/input/event1 (gpio-keys)
[   32.550686] systemd-logind[1375]: Watching system buttons on 
/dev/input/event0 (cros_ec)
[   32.570493] systemd-logind[1375]: Failed to start user service, 
ignoring: Unknown unit: user@0.service
[   32.750913] systemd-logind[1375]: New session c1 of user root.
[   35.070357] vdd_1v2:

--- EOF ---


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

