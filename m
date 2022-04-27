Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDF511A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiD0Ohg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiD0OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:37:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E320C69
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:34:06 -0700 (PDT)
X-UUID: c48886751da04506850b1248e72e9b27-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7598e579-d76e-43ac-96c0-13c7b47018c8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:8e73ea2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,File:nil,QS:0,BEC:ni
        l
X-UUID: c48886751da04506850b1248e72e9b27-20220427
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2090439662; Wed, 27 Apr 2022 22:34:03 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Apr 2022 22:34:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 22:33:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 22:33:49 +0800
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
Subject: Re: [PATCH v5 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Wed, 27 Apr 2022 22:33:49 +0800
Message-ID: <20220427143349.15651-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CACRpkda_hpTVxKftKBqRvBtC-KN8c9NWHFJDV10TN4JOR7CQCw@mail.gmail.com>
References: <CACRpkda_hpTVxKftKBqRvBtC-KN8c9NWHFJDV10TN4JOR7CQCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 27, 2022 at 11:59 AM Lecopzer Chen
> <lecopzer.chen@mediatek.com> wrote:
> 
> > Since the framework of KASAN_VMALLOC is well-developed,
> > It's easy to support for ARM that simply not to map shadow of VMALLOC
> > area on kasan_init.
> >
> > Since the virtual address of vmalloc for Arm is also between
> > MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> > address has already included between KASAN_SHADOW_START and
> > KASAN_SHADOW_END.
> > Thus we need to change nothing for memory map of Arm.
> >
> > This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> > and support CONFIG_VMAP_STACK with KASan.
> 
> Excellent Lecopzer,
> 
> can you put these patches into Russell's patch tracker so he can pick them?
> https://www.armlinux.org.uk/developer/patches/
> 
> Yours,
> Linus Walleij


I've added
9202/1 	kasan: support CONFIG_KASAN_VMALLOC
9203/1 	kconfig: fix MODULE_PLTS for KASAN with KASAN_VMALLOC

Thank you very much

BRs,
Lecopzer
