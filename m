Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF246793F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381405AbhLCOTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:19:05 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1381318AbhLCOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:19:04 -0500
X-UUID: 2d0978e4593f45a7a832ca40b3596156-20211203
X-UUID: 2d0978e4593f45a7a832ca40b3596156-20211203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2115325506; Fri, 03 Dec 2021 22:15:37 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 3 Dec 2021 22:15:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Dec
 2021 22:14:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Dec 2021 22:14:18 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <rmk+kernel@armlinux.org.uk>
CC:     <arnd@arndb.de>, <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <rppt@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <mark-pk.tsai@mediatek.com>
Subject: [PATCH] arm: remove [_text, _stext) from kernel code resource
Date:   Fri, 3 Dec 2021 22:14:16 +0800
Message-ID: <20211203141416.31121-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the [_text, _stext) from Kernel Code.
Although there are some startup code in head.text, they
are freed to the buddy system after kernel boot.

And we have memory protection mechanism use this
which have false alarm when some other IPs doing dma
if the dma page frame is in the [_text, _stext).

Below are my iomem resource and reserved memory information:
console:/ # grep Kernel /proc/iomem
  20208000-219fffff : Kernel code
  21b00000-21c2e76f : Kernel data

console:/ # cat /sys/kernel/debug/memblock/reserved
0: 0x20201000..0x20207fff
1: 0x20300000..0x21c2e76f

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 arch/arm/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 284a80c0b6e1..85ffc9501e38 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -851,7 +851,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 	struct resource *res;
 	u64 i;
 
-	kernel_code.start   = virt_to_phys(_text);
+	kernel_code.start   = virt_to_phys(_stext);
 	kernel_code.end     = virt_to_phys(__init_begin - 1);
 	kernel_data.start   = virt_to_phys(_sdata);
 	kernel_data.end     = virt_to_phys(_end - 1);
-- 
2.18.0

