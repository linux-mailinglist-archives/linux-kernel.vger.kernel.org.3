Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5664BCFD1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiBTQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:24:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiBTQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:24:53 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF63466D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:24:31 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220220162428epoutp026194c18b9346f50ca045b4abf264511e~Viy3xwAJj1202212022epoutp02p
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 16:24:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220220162428epoutp026194c18b9346f50ca045b4abf264511e~Viy3xwAJj1202212022epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645374268;
        bh=UdftajyJNW+EXTij2eYe1d1bvD9ABY+yr5v//ianeDM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=c1ncgXEMTFT0pycp+w8T2Em6NaoJ8tgwjDoi+oAyxVrgU0FCfhHweLby3nVFhTsiY
         jTY0x5c/rUQYrvO0uq5HbzfC79if/gV6UC1Cev94ItCPmKzVQfiXUKcxVqqBV3X68Y
         yyjk2/QIfhu2CjaY4Q5JLhVUgOoh/elywM/6BxKw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220220162427epcas5p16a2bac324a1c92cbb260a2ec83021451~Viy22SbZd0090000900epcas5p10;
        Sun, 20 Feb 2022 16:24:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K1rNj59CZz4x9Pp; Sun, 20 Feb
        2022 16:24:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.E5.06423.53B62126; Mon, 21 Feb 2022 01:24:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220220162421epcas5p1ca8ee53fa0fb60ae7721632f566a2e20~ViyxTOXhJ0090000900epcas5p1y;
        Sun, 20 Feb 2022 16:24:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220220162421epsmtrp1c519337e1a36d2f96cca01d33c0250e1~ViyxSYe4_0494104941epsmtrp19;
        Sun, 20 Feb 2022 16:24:21 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-bf-62126b35aa9e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.83.08738.53B62126; Mon, 21 Feb 2022 01:24:21 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220220162419epsmtip268dab7841e72ab9b216e4c35567c0eab~Viyv_vAHg1118311183epsmtip2K;
        Sun, 20 Feb 2022 16:24:19 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Thomas Abraham'" <thomas.abraham@linaro.org>,
        "'Stephen Warren'" <swarren@nvidia.com>,
        "'Kukjin Kim'" <kgene.kim@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220220103815.135380-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH] clocksource/drivers/exynos_mct: Handle DTS with higher
 number of interrupts
Date:   Sun, 20 Feb 2022 21:54:18 +0530
Message-ID: <0a0701d82676$5100e840$f302b8c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7zbZ9pC3GNQAhnJLYdx6+T3jvfAKoYAgcq0AOC3A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbVRzHc3rb28ugetd14YibNDfuj5IArevjAgOnknGZbtaYLBGX4AVu
        2tr2tvaWPdBkCIaMt03kVZqFWiBKXOS5EagE6Abb2CBmgsRAnA6GnaGSMZcBA225TPnve37n
        8/29zsEQ6XdoHGZinYyDpS0Eukd4JaBQJGrM0jxlvT+evLR6kKxumUbJruWnArL7/oyIvDvg
        QcnGqSEBOdvwhYjs6a5DyLHGVnA0inIXV6PU3IwfpUKTk2Kqp/UCVV0aQqma3g5ArXa/ohfn
        mI8YGbqAccgZNt9WYGIN6cTb7+e+lavRKlWJqhRSR8hZ2sqkE5nv6BOPmSzhxgj5GdpSGA7p
        aY4jkjOOOGyFTkZutHHOdIKxF1jsansSR1u5QtaQxDLOVJVS+ZomDH5kNl7/04faA/vP3fY+
        RYpBubQCRGEQV8PWBz5QAfZgUnwQwL5bnQL+8AjAvyurxBFKiq8CWDOY8dxR881lIQ8NAFhX
        7Bbxh2DY3joijFAongj7fWVo5EKGuxDoq9tEIhdROAVrWy+LInofngfrljYFES3ED8Fvt1q2
        tQRPgYud3SJe74U3mxa2kyJ4PLy67EH4NuRwbbE9zGDhAqnQu5HPI7EweP2aOFIX4m0YrBjy
        A57PhOXjK0Je74MPx3vFvI6DwdoycSQPxM2wauAwH/4Mtl0a28Ffh8M/eYQRBMEV8PuBZL7U
        C7B6Y0HAOyXwYtnORg/B0tD0jvNl6KqsFPGagsH2RZRfVTOAFc1TyJdA7t41pHvXkO5d07j/
        r9wChB3gJcbOWQ0Mp7GrWObsf++db7N2g+1vm5DdD+bvrSSNAgEGRgHEEEImWRmR5EklBfT5
        IsZhy3UUWhhuFGjCm3chcfvzbeF/zzpzVeoUpVqr1apTDmtVRKxkwtBJS3ED7WTMDGNnHM99
        Aiwqrlig8nYpn1V5yL6SH4+v3yqf2BsTePfjC86TRU/0Slla/F3JP5kxyaahK4ZTluEEj+ti
        9NcLnrHFpuyiWV2qd8tdcLAnNfDmzHTgYUVC2+kPVwZfrdsMzP8y4sXKh/uDoZrb81Zx8Mno
        xOlj2Q2z6FzWGwFnTvHGD02rB7Ys7nZR8M4f59aje9NcGX6Zve/xwtXPY/3j59Vwfe2GTVOy
        1hATP3Xid93ZZ7923vs09KKpo/1aPWc8+pvLckCRsdz4VVaWJ00xW5rcXtu7VDo3HtP8M1ui
        J3TWx8al9z7Q6aKhzIdo7mB/ObrUN72fnHlUk6O/P0kN3sg6BYOk5oFJVp9JCDkjrUpAHBz9
        L7XmDgM/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtc0WyjJ4PspDot5n2UtehdcZbPY
        +PYHk8Wmx9dYLS7vmsNmMeP8PiaLG9NbWC02b5rKbHFsxhJGB06PWQ29bB53ru1h83h37hy7
        x+Yl9R69ze/YPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvj6OvFbAWHRSvOLPzB3MDYKdTF
        yMkhIWAi0bdiLUsXIxeHkMAORonJLyYzQySkJa5vnMAOYQtLrPz3nB2i6DmjxJElX8ASbAK6
        EjsWt7GB2CIC05klHr4XgyiaySjx8sIJsCJOAQ+J/iVrWUFsYYEEif1rFoBtYBFQBZq6gAnE
        5hWwlHi6YRMrhC0ocXLmE6CTODiYBfQk2jYygoSZBeQltr+dA3WcgsTPp8tYQUpEBKwkFv5O
        higRl3h59Aj7BEahWUgGzUIYNAvJoFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
        zs/dxAiOKy2tHYx7Vn3QO8TIxMF4iFGCg1lJhPfDQd4kId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiWeLxiSpMzeZ7Xb/El83DkhWsZGqvPW1xOWPf2
        p676o9KlRb/aJ4lMV9c8du8Kw6sKfTd5HXXJKXPOX7q47M338D3RkTe33ut9Hmjgy8txeqNN
        7ollbY87lxqZ/jpT8X6FJ//LKoXGl9+7Dbtm9j5rWvnHJPuCoOmmvZNu+veL5fFqqC4p5p2f
        Xin4eImPL/OimrVZMeI3rm3aqDZr5rNVWc8inr2SL7y04eL5wKi5YWIbLqr33mNzlP91wpiF
        Y5Mb55JVcbvmXQyLuuYTFRVVeuLMfZb5jH2frl3776red66iqGfnVuEa7u+q965sMwr+6WZc
        PFckNM482SarxXzevnPzesRySm4/zo95tk1XiaU4I9FQi7moOBEA8WuXrxoDAAA=
X-CMS-MailID: 20220220162421epcas5p1ca8ee53fa0fb60ae7721632f566a2e20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220220103818epcas5p2ae2e390b30f82c42e26a5187af48ef4b
References: <CGME20220220103818epcas5p2ae2e390b30f82c42e26a5187af48ef4b@epcas5p2.samsung.com>
        <20220220103815.135380-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Sunday, February 20, 2022 4:08 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Thomas Abraham
><thomas.abraham@linaro.org>; Stephen Warren <swarren@nvidia.com>;
>Kukjin Kim <kgene.kim@samsung.com>; linux-kernel@vger.kernel.org; linux-
>arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
>Subject: [PATCH] clocksource/drivers/exynos_mct: Handle DTS with higher
>number of interrupts
>
>The driver statically defines maximum number of interrupts it can handle,
>however it does not respect that limit when configuring them.
>When provided with a DTS with more interrupts than assumed, the driver will
>overwrite static array mct_irqs leading to silent memory corruption.
>
>Validate the interrupts coming from DTS to avoid this.  This does not
change
>the fact that such DTS might not boot at all, because it is simply
incompatible,
>however at least some warning will be printed.
>
>Fixes: 36ba5d527e95 ("ARM: EXYNOS: add device tree support for MCT
>controller driver")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
Thanks, good to have this check.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>



> drivers/clocksource/exynos_mct.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/clocksource/exynos_mct.c
>b/drivers/clocksource/exynos_mct.c
>index 6db3d5511b0f..03782b399ea1 100644
>--- a/drivers/clocksource/exynos_mct.c
>+++ b/drivers/clocksource/exynos_mct.c
>@@ -541,6 +541,11 @@ static int __init exynos4_timer_interrupts(struct
>device_node *np,
> 	 * irqs are specified.
> 	 */
> 	nr_irqs = of_irq_count(np);
>+	if (nr_irqs > ARRAY_SIZE(mct_irqs)) {
>+		pr_err("exynos-mct: too many (%d) interrupts configured in
>DT\n",
>+			nr_irqs);
>+		nr_irqs = ARRAY_SIZE(mct_irqs);
>+	}
> 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> 		mct_irqs[i] = irq_of_parse_and_map(np, i);
>
>@@ -553,11 +558,14 @@ static int __init exynos4_timer_interrupts(struct
>device_node *np,
> 		     mct_irqs[MCT_L0_IRQ], err);
> 	} else {
> 		for_each_possible_cpu(cpu) {
>-			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>+			int mct_irq;
> 			struct mct_clock_event_device *pcpu_mevt =
> 				per_cpu_ptr(&percpu_mct_tick, cpu);
>
> 			pcpu_mevt->evt.irq = -1;
>+			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
>+				break;
>+			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>
> 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
> 			if (request_irq(mct_irq,
>--
>2.32.0


