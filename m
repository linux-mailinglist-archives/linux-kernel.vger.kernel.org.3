Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E44EA87F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiC2H3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC2H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:29:39 -0400
Received: from out29-77.mail.aliyun.com (out29-77.mail.aliyun.com [115.124.29.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153724783F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:27:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.18044|-1;BR=01201311R171S78rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0509118-0.00316166-0.945926;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.NFCJAsm_1648538872;
Received: from sunxibot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.NFCJAsm_1648538872)
          by smtp.aliyun-inc.com(33.13.255.226);
          Tue, 29 Mar 2022 15:27:54 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, yanfei.xu@windriver.com, ardb@kernel.org,
        weidonghui@allwinnertech.com, rdunlap@infradead.org, arnd@arndb.de,
        mirq-linux@rere.qmqm.pl
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [RESEND] ARM: mmu: fix access to illegal address when using earlycon & memblock=debug
Date:   Tue, 29 Mar 2022 15:27:57 +0800
Message-Id: <20220329072757.64092-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

earlycon uses fixmap to create a memory map,
So we need to close earlycon before closing fixmap,
otherwise printk will access illegal addresses.
After creating a new memory map, we open earlycon again.

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 arch/arm/mm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5e2be37a198e..9b8baa222034 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/console.h>
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -1697,6 +1698,9 @@ static void __init early_fixmap_shutdown(void)
 	pmd_clear(fixmap_pmd(va));
 	local_flush_tlb_kernel_page(va);
 
+#ifdef CONFIG_FIX_EARLYCON_MEM
+	console_stop(console_drivers);
+#endif
 	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
 		pte_t *pte;
 		struct map_desc map;
@@ -1715,6 +1719,9 @@ static void __init early_fixmap_shutdown(void)
 
 		create_mapping(&map);
 	}
+#ifdef CONFIG_FIX_EARLYCON_MEM
+	console_start(console_drivers);
+#endif
 }
 
 /*
-- 
2.29.0

