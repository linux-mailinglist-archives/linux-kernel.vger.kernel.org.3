Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B45A7C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHaLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHaLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:53:09 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA5C7F9B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:53:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220831115258euoutp01711728c076d00ae9f805a79ff1516340~Qa8o6w21P3194731947euoutp01k
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:52:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220831115258euoutp01711728c076d00ae9f805a79ff1516340~Qa8o6w21P3194731947euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661946778;
        bh=Nxlfym3ND6i/YRJglggezX4ww7hOMachCwDzRO1d2yI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=lyKfTnmjoKXjfIqJwFrgtTajFsmL9zOHZpwNF3QtXqJ49hMaw3N0dreGNQDrhyoaD
         b5X/CJwnoRxd0nuOYEAiICiYnNdDJMXxIERKUFuqFGupJsvOAyViDyiVULdnkwHbly
         YbGRaNZ498oAozrcxAx17eo6ffCbxTa4FsQR51Fk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220831115258eucas1p2096c19867288ec5578b4199c5e2c62fc~Qa8olfodV3267932679eucas1p2W;
        Wed, 31 Aug 2022 11:52:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 36.80.07817.A9B4F036; Wed, 31
        Aug 2022 12:52:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220831115257eucas1p20d37a01c51e42767860920a936255bd7~Qa8oCEOoU2649726497eucas1p2b;
        Wed, 31 Aug 2022 11:52:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220831115257eusmtrp14866fa61df5b58b1cf2cd02726e27927~Qa8oBIECS0765907659eusmtrp1L;
        Wed, 31 Aug 2022 11:52:57 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-cf-630f4b9a8237
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.33.07473.99B4F036; Wed, 31
        Aug 2022 12:52:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220831115257eusmtip106c11b8029e14f7219082ce264467265~Qa8nR2dEv1207712077eusmtip1R;
        Wed, 31 Aug 2022 11:52:57 +0000 (GMT)
Message-ID: <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
Date:   Wed, 31 Aug 2022 13:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Content-Language: en-US
To:     Victor Hassan <victor@allwinnertech.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220316023356.120595-1-victor@allwinnertech.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87qzvPmTDXbfFbM49beX0eLnl/eM
        Fn8nHWO3mPJnOZPFpsfXWC0u75rDZnFo6l5Gi2/PTzFaXOqfyGSxedNUZovvP+ayWmy4/IDN
        gcfjVdszJo/L1y4ye/z+NYnRY9OqTjaPO9f2sHm8O3eO3WPzknqPWW372Dw+b5LzWL9lK1MA
        VxSXTUpqTmZZapG+XQJXRufMJ6wFX/grdvV1sDcwPuLpYuTkkBAwkTg+/z9TFyMXh5DACkaJ
        xR9nMUM4Xxgl+uZuZYdwPjNKTH/+hQ2m5dasP1Atyxkl3rztZYFwPjJKnDrXxARSxStgJ/Gy
        5yELiM0ioCqx89pHVoi4oMTJmU/A4qICyRKzjh1jBLGFgewfjV1gNcwC4hK3nswH2yAi8JRR
        4knzdzaIRIXEu/Y9YA1sAoYSXW+7wOKcAvYSt5ctZISokZfY/nYO2BMSAvM5Ja683MoMcbeL
        xNntcxkhbGGJV8e3sEPYMhKnJ/cAXcQBZOdL/J1hDBGukLj2eg1Uq7XEnXO/2EBKmAU0Jdbv
        0ocIO0os2/uPGaKTT+LGW0GIC/gkJm2bDhXmlehoE4KoVpOYdXwd3M6DFy4xT2BUmoUUKLOQ
        PD8LyS+zEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZjkTv87/mUH4/JXH/UO
        MTJxMB5ilOBgVhLh/X6OJ1mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC
        1CKYLBMHp1QDk4R4Ss0Wdp7+4rmne/QstJLWvZyw91wPn+jF1wc4F164MVMpZ2Meu0cs0xpb
        y6/LUs998Vl7/RxzWjCHB5vOkTttl9rXpcX7V31ZkLf7X4bCM4Yl355qut3Zcuwpw4dIBv6D
        K0+HMOxbuPRk2Awhg8bTVSynNh3UXvpC9OXbB4dn+5UyXPFXWfx/cti2T38W5UT9vfqq6nDZ
        jE1erTNyihOvcrqfNXWYcLXnmNBHMWs/gUNFuwKy97Dc/f9wsWOC0pczp80blD6VPV1yt1/J
        vV304Kyv2THFmy6qs1a6X4o0O7ilOOnyMePNm1v1F8U/z9avOpS3SoJdNGzJ/srlz73nX5ta
        sHryytaXLnderc9UYinOSDTUYi4qTgQAoWrH8uEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7ozvfmTDb7d0LY49beX0eLnl/eM
        Fn8nHWO3mPJnOZPFpsfXWC0u75rDZnFo6l5Gi2/PTzFaXOqfyGSxedNUZovvP+ayWmy4/IDN
        gcfjVdszJo/L1y4ye/z+NYnRY9OqTjaPO9f2sHm8O3eO3WPzknqPWW372Dw+b5LzWL9lK1MA
        V5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRufM
        J6wFX/grdvV1sDcwPuLpYuTkkBAwkbg16w9TFyMXh5DAUkaJ+7+bmCASMhInpzWwQtjCEn+u
        dbFBFL1nlJjatpAZJMErYCfxsuchC4jNIqAqsfPaR1aIuKDEyZlPwOKiAskSSxrug8WFgewf
        jV1gNrOAuMStJ/PBNosIPGWUONZ4jA0iUSExY91BsGYhoAW7Tr4DW8YmYCjR9bYLrIZTwF7i
        9rKFjBD1ZhJdW7ugbHmJ7W/nME9gFJqF5I5ZSPbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5
        xaV56XrJ+bmbGIGRve3Yz807GOe9+qh3iJGJg/EQowQHs5II7/dzPMlCvCmJlVWpRfnxRaU5
        qcWHGE2BgTGRWUo0OR+YWvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqY
        ODilGpjMvY6xq2+8ai8ay7BaY1nOnOtXxfYyP7qYeCfhGLuhYrnkEuEF8d7durnRh2Ye3fTr
        lv/MdWc3Muzz4ebbaf2gPkONRXsab3E0T7LNvr8vfbl7t3tO+BLJJVlsr3fR66Gc4cOs944n
        r2nv5Pj623+2Tdlnm4v3vlzbE/3swNIFB8LM51wXNs/c3tLb5SUz+++2R26mHNYmJ+6xX74V
        OmHCjK+Sf9Luvm/jPBZl47ijSlHOf6aUq/lBdTNbfh+T6Kd/LMqPXJjeu3ujz834pAKTz8s+
        Ky32Mug5aOEZszvOcKnZ89WbFc85aZ5OXRlZtCiflWH3raVCE1LEZA/3qy/2sFD8r3D++I8e
        nZTrKu5KLMUZiYZazEXFiQCm24zRdQMAAA==
X-CMS-MailID: 20220831115257eucas1p20d37a01c51e42767860920a936255bd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220831115257eucas1p20d37a01c51e42767860920a936255bd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220831115257eucas1p20d37a01c51e42767860920a936255bd7
References: <20220316023356.120595-1-victor@allwinnertech.com>
        <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
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

Hi Victor,

On 16.03.2022 03:33, Victor Hassan wrote:
> earlycon uses fixmap to create a memory map,
> So we need to close earlycon before closing fixmap,
> otherwise printk will access illegal addresses.
> After creating a new memory map, we open earlycon again.
>
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>

This patch landed in linux next-20220831 as commit a76886d117cb ("ARM: 
9223/1: mmu: fix access to illegal address when using earlycon & 
memblock=debug"). Unfortunately it breaks booting of all my test boards 
which *do not* use earlycon. It can be easily reproduced even with QEMU.

With kernel compiled from multi_v7_defconfig the following setup boots:

$ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append 
"console=ttyAMA0 earlycon" -M virt -smp 2 -m 512

while this one doesn't:

$ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append 
"console=ttyAMA0" -M virt -smp 2 -m 512


> ---
>   arch/arm/mm/mmu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 274e4f73fd33..f3511f07a7d0 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -14,6 +14,7 @@
>   #include <linux/fs.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sizes.h>
> +#include <linux/console.h>
>   
>   #include <asm/cp15.h>
>   #include <asm/cputype.h>
> @@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
>   	pmd_clear(fixmap_pmd(va));
>   	local_flush_tlb_kernel_page(va);
>   
> +#ifdef CONFIG_FIX_EARLYCON_MEM
> +	console_stop(console_drivers);
> +#endif
>   	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>   		pte_t *pte;
>   		struct map_desc map;
> @@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
>   
>   		create_mapping(&map);
>   	}
> +#ifdef CONFIG_FIX_EARLYCON_MEM
> +	console_start(console_drivers);
> +#endif
>   }
>   
>   /*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

