Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE644D6010
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbiCKKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiCKKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:49:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDAB7D034
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:47:58 -0800 (PST)
X-UUID: 26ee146925a34e8983401382666511be-20220311
X-UUID: 26ee146925a34e8983401382666511be-20220311
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 768871941; Fri, 11 Mar 2022 18:47:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Mar 2022 18:47:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Mar
 2022 18:47:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 18:47:52 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux@armlinux.org.uk>
CC:     <andreyknvl@gmail.com>, <anshuman.khandual@arm.com>,
        <ardb@kernel.org>, <arnd@arndb.de>, <dvyukov@google.com>,
        <geert+renesas@glider.be>, <glider@google.com>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lukas.bulwahn@gmail.com>,
        <mark.rutland@arm.com>, <masahiroy@kernel.org>,
        <matthias.bgg@gmail.com>, <ryabinin.a.a@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 1/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Fri, 11 Mar 2022 18:47:52 +0800
Message-ID: <20220311104752.2616-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YislvzIg3Tvwj2+J@shell.armlinux.org.uk>
References: <YislvzIg3Tvwj2+J@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Feb 27, 2022 at 09:47:25PM +0800, Lecopzer Chen wrote:
> > Simply make shadow of vmalloc area mapped on demand.
> > 
> > Since the virtual address of vmalloc for Arm is also between
> > MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> > address has already included between KASAN_SHADOW_START and
> > KASAN_SHADOW_END.
> > Thus we need to change nothing for memory map of Arm.
> > 
> > This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> > and provide the first step to support CONFIG_VMAP_STACK with Arm.
> > 
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm/Kconfig                 |  1 +
> >  arch/arm/include/asm/kasan_def.h | 11 ++++++++++-
> >  arch/arm/mm/kasan_init.c         |  6 +++++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 4c97cb40eebb..78250e246cc6 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -72,6 +72,7 @@ config ARM
> >  	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
> >  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >  	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> > +	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> >  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> >  	select HAVE_ARCH_PFN_VALID
> >  	select HAVE_ARCH_SECCOMP
> > diff --git a/arch/arm/include/asm/kasan_def.h b/arch/arm/include/asm/kasan_def.h
> > index 5739605aa7cf..96fd1d3b5a0c 100644
> > --- a/arch/arm/include/asm/kasan_def.h
> > +++ b/arch/arm/include/asm/kasan_def.h
> > @@ -19,7 +19,16 @@
> >   * space to use as shadow memory for KASan as follows:
> >   *
> >   * +----+ 0xffffffff
> > - * |    |							\
> > + * |    |\
> > + * |    | |-> ZONE_HIGHMEM for vmalloc virtual address space.
> > + * |    | |   Such as vmalloc(), GFP_HIGHUSER (__GFP__HIGHMEM),
> > + * |    | |   module address using ARM_MODULE_PLTS, etc.
> > + * |    | |
> > + * |    | |   If CONFIG_KASAN_VMALLOC=y, this area would populate
> > + * |    | |   shadow address on demand.
> > + * |    |/
> 
> This diagram is incorrect. We already have the memory layout in
> Documentation/arm/memory.rst, so we don't need another set of
> documentation that is misleading.

 Ok, should I send a v4 to remove this?



BRs,
Lecopzer
