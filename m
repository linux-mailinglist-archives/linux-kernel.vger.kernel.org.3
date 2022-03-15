Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3C4D96FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbiCOJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiCOJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:03:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC944D9D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:02:09 -0700 (PDT)
X-UUID: 54457aaeeeae4d3aad0dffd452a40eb0-20220315
X-UUID: 54457aaeeeae4d3aad0dffd452a40eb0-20220315
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 914556803; Tue, 15 Mar 2022 17:02:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Mar 2022 17:02:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 17:02:02 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>
CC:     <lecopzer.chen@mediatek.com>, <andreyknvl@gmail.com>,
        <anshuman.khandual@arm.com>, <ardb@kernel.org>, <arnd@arndb.de>,
        <dvyukov@google.com>, <geert+renesas@glider.be>,
        <glider@google.com>, <kasan-dev@googlegroups.com>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <lukas.bulwahn@gmail.com>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ryabinin.a.a@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v4 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Tue, 15 Mar 2022 17:01:55 +0800
Message-ID: <20220315090157.27001-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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


Since the framework of KASAN_VMALLOC is well-developed,
It's easy to support for ARM that simply not to map shadow of VMALLOC
area on kasan_init.

Since the virtual address of vmalloc for Arm is also between
MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
address has already included between KASAN_SHADOW_START and
KASAN_SHADOW_END.
Thus we need to change nothing for memory map of Arm.

This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
and support CONFIG_VMAP_STACK with KASan.
    

Test on
1. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping.
2. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping + LPAE.
3. Qemu with memory 2G and vmalloc=500M for 2G/2G mapping.

v4:
    rebase on 5.17-rc8.
    remove simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
    rewrite the description for VMAP_STACK

v3:
    rebase on 5.17-rc5.
    Add simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
    Tweak commit message.

https://lore.kernel.org/lkml/20220227134726.27584-1-lecopzer.chen@mediatek.com/

v2:
    rebase on 5.17-rc3


Lecopzer Chen (2):
  arm: kasan: support CONFIG_KASAN_VMALLOC
  arm: kconfig: fix MODULE_PLTS for KASAN with KASAN_VMALLOC

 arch/arm/Kconfig         | 2 ++
 arch/arm/mm/kasan_init.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.18.0

