Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7B4B3C37
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiBMQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiBMQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:07:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626545A0A4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 08:07:04 -0800 (PST)
X-UUID: 7c26e1c48cb240c78db72cdf8cb77316-20220214
X-UUID: 7c26e1c48cb240c78db72cdf8cb77316-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 757746491; Mon, 14 Feb 2022 00:06:57 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 00:06:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 00:06:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 00:06:56 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linus.walleij@linaro.org>
CC:     <andreyknvl@gmail.com>, <anshuman.khandual@arm.com>,
        <ardb@kernel.org>, <arnd@arndb.de>, <dvyukov@google.com>,
        <geert+renesas@glider.be>, <glider@google.com>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <lukas.bulwahn@gmail.com>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ryabinin.a.a@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 1/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Mon, 14 Feb 2022 00:06:56 +0800
Message-ID: <20220213160656.17605-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CACRpkdYDg3saLpfHg=R1kYpnC_BBNgBbe7un-B4e8bgDYPq1Fg@mail.gmail.com>
References: <CACRpkdYDg3saLpfHg=R1kYpnC_BBNgBbe7un-B4e8bgDYPq1Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus
 
Thanks for your review.
 
> > -       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
> > +       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
> > +               kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
> > +                                           kasan_mem_to_shadow((void *)VMALLOC_END));
> > +
> > +       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_END),
> >                                     kasan_mem_to_shadow((void *)-1UL) + 1);
> 
> Where is this actually mapped?
> 
> Can you print out where
> kasan_mem_to_shadow((void *)VMALLOC_START)
> kasan_mem_to_shadow((void *)VMALLOC_END)
> as well as KASAN_SHADOW_START and KASAN_SHADOW_END
> points?
> 
> When I looked into this getting the shadow memory between
> KASAN_SHADOW_START and KASAN_SHADOW_END
> seemed like the big problem since this is static, so how is Kasan
> solving this now?

For quick answer:
As I knwon, the definition of KASAN_SHADOW_START and END

(@arch/arm/include/asm/kasan_def.h)
* 1) KASAN_SHADOW_START
 *   This value begins with the MODULE_VADDR's shadow address. It is the
 *   start of kernel virtual space....
 *
 * 2) KASAN_SHADOW_END
 *   This value is the 0x100000000's shadow address: the mapping that would
 *   be after the end of the kernel memory at 0xffffffff....

and the virt address of vmalloc for ARM32 is also between MODULE_VADDR and
0x100000000 (ZONE_HIGHMEM), so nothing needs to do.

If there is any cases may break this assumption, please correct me, thanks.

> 
> Please patch the picture in
> include/asm/kasan_def.h
> and the info in
> Documentation/arm/memory.rst
> so it clearly reflects where VMALLOC is shadowed.

Thanks for suggestion, Yes, we really do need to update doc for memory layout.
I'll study how to add it and provide in v3.




