Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A093A4D6025
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiCKKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiCKKx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:53:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101311B01A4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:52:23 -0800 (PST)
X-UUID: 133bdabe412341dd9d880869907dd98f-20220311
X-UUID: 133bdabe412341dd9d880869907dd98f-20220311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1442557884; Fri, 11 Mar 2022 18:52:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Mar 2022 18:52:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 18:52:15 +0800
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
Subject: Re: [PATCH v3 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Fri, 11 Mar 2022 18:52:15 +0800
Message-ID: <20220311105215.5408-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YismXDtUZ2cPtVnN@shell.armlinux.org.uk>
References: <YismXDtUZ2cPtVnN@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 11, 2022 at 12:08:52AM +0100, Linus Walleij wrote:
> > On Sun, Feb 27, 2022 at 2:48 PM Lecopzer Chen
> > <lecopzer.chen@mediatek.com> wrote:
> > 
> > > Since the framework of KASAN_VMALLOC is well-developed,
> > > It's easy to support for ARM that simply not to map shadow of VMALLOC
> > > area on kasan_init.
> > >
> > > Since the virtual address of vmalloc for Arm is also between
> > > MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> > > address has already included between KASAN_SHADOW_START and
> > > KASAN_SHADOW_END.
> > > Thus we need to change nothing for memory map of Arm.
> > >
> > > This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> > > and provide the first step to support CONFIG_VMAP_STACK with Arm.
> > >
> > >
> > > Test on
> > > 1. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping.
> > > 2. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping + LPAE.
> > > 3. Qemu with memory 2G and vmalloc=500M for 2G/2G mapping.
> > >
> > > v3:
> > >     rebase on 5.17-rc5.
> > >     Add simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
> > >     Tweak commit message.
> > 
> > Ater testing this with my kernel-in-vmalloc patches and some hacks, I got
> > the kernel booting in the VMALLOC area with KASan enabled!
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=kernel-in-vmalloc-v5.17-rc1
> > 
> > That's a pretty serious stress test. So:
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > for the series.
> > 
> > I suppose you could put this into Russell's patch tracker, it's gonna be
> > for kernel v5.19 by now but why stress. It seems I can fix up
> > kernel-in-vmalloc on top and submit that for v5.19 as well.
> 
> Ard's series already adds vmap stack support (which we've been doing
> some last minute panic-debugging on to get it ready for this merge
> window), but the above description makes it sound like this series is
> a pre-requisit for that.
> 
> Is it? Will Ard's work cause further regressions because this series
> isn't merged.
> 
> Please clarify - and urgently, there is not much time left before the
> merge window opens.
> 

Sorry I didn't describe it clearly,

config VMAP_STACK
  default y
  bool "Use a virtually-mapped stack"
  depends on HAVE_ARCH_VMAP_STACK
  depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC

This means KASAN can support with VMAP_STACK=y



BRs,
Lecopzer
