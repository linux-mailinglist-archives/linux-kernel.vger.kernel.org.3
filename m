Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCBF4FF99C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiDMPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiDMPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:02:03 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C3E0C2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:59:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220413145923euoutp01badf428cdf225be3e0916b1bb1d5e07d~lfLbYb_M12697326973euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220413145923euoutp01badf428cdf225be3e0916b1bb1d5e07d~lfLbYb_M12697326973euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649861963;
        bh=zNLEjfif5pqC2zwkByBACL9zjM0ijdLdeN7p2xj/RNU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IPFtyd+MEXv/+/9/zjotkMT34iREOobbGRe3udmLRRvgSk7jgaVjY2KF5UKJE6S0l
         A5DzjnMVEtnUIYgF9in5//cu/nqmiwFlTQAOT9D/wecyYhN3IaWpzJEusd79ZkzSKS
         5Eiwh1pS7WKonoBIEv/I7Hc2VBLwGPgw4fRlpYho=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220413145923eucas1p158c15e259cee117c55e5b343586a1c49~lfLbJVmXI0672506725eucas1p1V;
        Wed, 13 Apr 2022 14:59:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.98.10009.A45E6526; Wed, 13
        Apr 2022 15:59:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220413145922eucas1p2dc46908354f4d2b48db79978d086a838~lfLa1E-vn0300803008eucas1p2b;
        Wed, 13 Apr 2022 14:59:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220413145922eusmtrp1c4eaf23a13c10b503eaf36b1f4be8675~lfLa0WsRF0438704387eusmtrp1X;
        Wed, 13 Apr 2022 14:59:22 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-31-6256e54a7a75
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.86.09522.A45E6526; Wed, 13
        Apr 2022 15:59:22 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220413145921eusmtip1022be223c674e5ab9579f5faf67cef6c~lfLaKfD5Z1721817218eusmtip1H;
        Wed, 13 Apr 2022 14:59:21 +0000 (GMT)
Message-ID: <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
Date:   Wed, 13 Apr 2022 16:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220405185040.206297-3-maz@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87peT8OSDD6uNbe41LqJ3WLT/iZW
        i/PnN7BbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo93586x
        e3zeJBfAGsVlk5Kak1mWWqRvl8CVserfLcaCbdIVn784NTA+Eu1i5OSQEDCRWHp5MXMXIxeH
        kMAKRonXKw4yQThfGCUere5mgXA+M0rsPf6RGablXv9kqKrljBJHPz1ghXA+MkpMPTebBaSK
        V8BO4tCbh2A2i4CqxJmzz9kg4oISJ2c+AYuLCiRJrN6+GiwuLOAjMeXiCUYQm1lAXOLWk/lg
        G0QEuhkl/s2bwQbiMAucYpRYPuEQ2B1sAoYSXW+7wLo5BUwlth2dyArRLS+x/e0csJckBJ5w
        SFz5spe9i5EDyHGROD3ZBuIHYYlXx7ewQ9gyQOEeFoiSfIm/M4whwhUS116vgXrZWuLOuV9s
        ICXMApoS63fpQ4QdJdqPPmeG6OSTuPFWEOIAPolJ26ZDhXklOtqEIKrVJGYdXwe38+CFS8wT
        GJVmIQXKLCTPz0LyyiyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJqLT/45/
        2sE499VHvUOMTByMhxglOJiVRHj71UOThHhTEiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJI
        TyxJzU5NLUgtgskycXBKNTApbzvbZtSacengIzWJ3eyHvbyWeTFEhM7L+rNV3+VSgPDbnZf7
        1mVlVqe1qC07u0rdoi+819JdY1Hd+716t09O+KD1tOebXXPK4oCp28tZN51nlP+6ccHv5Yv7
        v104eXzf/dDnM7arfLK5JLg+seTSs46GpffnqAftflMae9chwHH5tOru6JaC8hvdX48HtN89
        +UNAX7Wg+Ib18b95cTO1yk4tOVI+06ss0faWXYVl/5NpDeWX8iY+NY5bt+Wa4K5nruHtDUI1
        xaG9Xl/0z5Wfinxy1oVtxR4tTZFbl4LsFWb2Waw+v8It4fjDG9qH4u9uutPQ/O2z36qHHzbd
        aC68qrnn7tyCq3EL00uzpk/apMRSnJFoqMVcVJwIAAgdtmSzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7peT8OSDP5NVLG41LqJ3WLT/iZW
        i/PnN7BbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo93586x
        e3zeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXserfLcaCbdIVn784NTA+Eu1i5OSQEDCRuNc/mamLkYtDSGApo8Tf13/ZIBIyEienNbBC
        2MISf651sUEUvWeUuPJ+ExNIglfATuLQm4csIDaLgKrEmbPP2SDighInZz4Bi4sKJElc6mpn
        BLGFBXwkplw8AWYzC4hL3HoyH2yziEA3o8S2cxuYQRxmgVOMEpvW/gdbLSQQLzHpXzcziM0m
        YCjR9bYLbAOngKnEtqMTWSEmmUl0be2Cmiovsf3tHOYJjEKzkBwyC8nCWUhaZiFpWcDIsopR
        JLW0ODc9t9hQrzgxt7g0L10vOT93EyMw/rYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4e1XD00S
        4k1JrKxKLcqPLyrNSS0+xGgKDI2JzFKiyfnABJBXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQ
        nliSmp2aWpBaBNPHxMEp1cDkdjv80YoQkaYozVvmGfM2FDi5fz1oODmLe83iSzVP5vqkHJfZ
        ImWlpL3hpj3HgbV9AVMu+jptPx488UVkw/Zz0r2sT3pTvD5qPNqtmVana9/t8Io57Nne04IM
        EhLC0vr8V9yNMlTN9rVLvj8y7/Quo6rGEJ0nIldPnts1RZhz4jYbr6UVi09mS97U2vou2+ej
        3v8OJRablZpl6VEFLetUmZRtz5ilnZ8aF+kcnXvdQM3880TRu7n/fm++4fpo2fOEK7+FPrqt
        N2FWZQzVvufZOPm+CbN24ZXkxef8/q/8uPn9Jx7jvgNuiheSbLJsJ/OpGOrVb5r27UXYFf2r
        Am5Lcxeaq31y+S7qZbXtxDslluKMREMt5qLiRAAz9PgQSAMAAA==
X-CMS-MailID: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
References: <20220405185040.206297-1-maz@kernel.org>
        <20220405185040.206297-3-maz@kernel.org>
        <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 05.04.2022 20:50, Marc Zyngier wrote:
> When booting with maxcpus=<small number> (or even loading a driver
> while most CPUs are offline), it is pretty easy to observe managed
> affinities containing a mix of online and offline CPUs being passed
> to the irqchip driver.
>
> This means that the irqchip cannot trust the affinity passed down
> from the core code, which is a bit annoying and requires (at least
> in theory) all drivers to implement some sort of affinity narrowing.
>
> In order to address this, always limit the cpumask to the set of
> online CPUs.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This patch landed in linux next-20220413 as commit 33de0aa4bae9 
("genirq: Always limit the affinity to online CPUs"). Unfortunately it 
breaks booting of most ARM 32bit Samsung Exynos based boards.

I don't see anything specific in the log, though. Booting just hangs at 
some point. The only Samsung Exynos boards that boot properly are those 
Exynos4412 based.

I assume that this is related to the Multi Core Timer IRQ configuration 
specific for that SoCs. Exynos4412 uses PPI interrupts, while all other 
Exynos SoCs have separate IRQ lines for each CPU.

Let me know how I can help debugging this issue.

> ---
>   kernel/irq/manage.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c03f71d5ec10..f71ecc100545 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -222,11 +222,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>   {
>   	struct irq_desc *desc = irq_data_to_desc(data);
>   	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	const struct cpumask  *prog_mask;
>   	int ret;
>   
> +	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
> +	static struct cpumask tmp_mask;
> +
>   	if (!chip || !chip->irq_set_affinity)
>   		return -EINVAL;
>   
> +	raw_spin_lock(&tmp_mask_lock);
>   	/*
>   	 * If this is a managed interrupt and housekeeping is enabled on
>   	 * it check whether the requested affinity mask intersects with
> @@ -248,24 +253,28 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>   	 */
>   	if (irqd_affinity_is_managed(data) &&
>   	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
> -		const struct cpumask *hk_mask, *prog_mask;
> -
> -		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
> -		static struct cpumask tmp_mask;
> +		const struct cpumask *hk_mask;
>   
>   		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>   
> -		raw_spin_lock(&tmp_mask_lock);
>   		cpumask_and(&tmp_mask, mask, hk_mask);
>   		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
>   			prog_mask = mask;
>   		else
>   			prog_mask = &tmp_mask;
> -		ret = chip->irq_set_affinity(data, prog_mask, force);
> -		raw_spin_unlock(&tmp_mask_lock);
>   	} else {
> -		ret = chip->irq_set_affinity(data, mask, force);
> +		prog_mask = mask;
>   	}
> +
> +	/* Make sure we only provide online CPUs to the irqchip */
> +	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
> +	if (!cpumask_empty(&tmp_mask))
> +		ret = chip->irq_set_affinity(data, &tmp_mask, force);
> +	else
> +		ret = -EINVAL;
> +
> +	raw_spin_unlock(&tmp_mask_lock);
> +
>   	switch (ret) {
>   	case IRQ_SET_MASK_OK:
>   	case IRQ_SET_MASK_OK_DONE:

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

