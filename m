Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62F51150F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiD0Ko5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiD0Kon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:44:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2CC49AB47
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:25:40 -0700 (PDT)
X-UUID: eefbb75b7eb649d4803ab8ec1db8a0af-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:89c744a2-ae14-4fa2-8bfd-c801bfa8a180,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:89c744a2-ae14-4fa2-8bfd-c801bfa8a180,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:6d5bacc6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:febf3ac4902a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: eefbb75b7eb649d4803ab8ec1db8a0af-20220427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1096876898; Wed, 27 Apr 2022 17:59:33 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 17:59:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 17:59:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 17:59:31 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux@armlinux.org.uk>
CC:     <lecopzer.chen@mediatek.com>, <andreyknvl@gmail.com>,
        <anshuman.khandual@arm.com>, <ardb@kernel.org>, <arnd@arndb.de>,
        <dvyukov@google.com>, <geert+renesas@glider.be>,
        <glider@google.com>, <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lukas.bulwahn@gmail.com>,
        <mark.rutland@arm.com>, <masahiroy@kernel.org>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <ryabinin.a.a@gmail.com>, <yj.chiang@mediatek.com>
Subject: [PATCH v5 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Wed, 27 Apr 2022 17:59:14 +0800
Message-ID: <20220427095916.17515-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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


v5:
    rebase on 5.18-rc4
    
v4:
    rebase on 5.17-rc8.
    remove simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
    rewrite the description for VMAP_STACK

https://lore.kernel.org/lkml/20220315090157.27001-1-lecopzer.chen@mediatek.com/

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

