Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01634DA87B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348348AbiCPCfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiCPCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:35:14 -0400
Received: from out29-195.mail.aliyun.com (out29-195.mail.aliyun.com [115.124.29.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5AF2C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:33:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2041822|-1;BR=01201311R111S35rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0423659-0.00231199-0.955322;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.N5VpE7V_1647398035;
Received: from sunxibot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.N5VpE7V_1647398035)
          by smtp.aliyun-inc.com(33.37.2.29);
          Wed, 16 Mar 2022 10:33:56 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, yanfei.xu@windriver.com, ardb@kernel.org,
        tglx@linutronix.de, mirq-linux@rere.qmqm.pl, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com,
        Victor Hassan <victor@allwinnertech.com>
Subject: [PATCH] ARM: mmu: fix access to illegal address when using earlycon & memblock=debug
Date:   Wed, 16 Mar 2022 10:33:56 +0800
Message-Id: <20220316023356.120595-1-victor@allwinnertech.com>
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
index 274e4f73fd33..f3511f07a7d0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/console.h>
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
 	pmd_clear(fixmap_pmd(va));
 	local_flush_tlb_kernel_page(va);
 
+#ifdef CONFIG_FIX_EARLYCON_MEM
+	console_stop(console_drivers);
+#endif
 	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
 		pte_t *pte;
 		struct map_desc map;
@@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
 
 		create_mapping(&map);
 	}
+#ifdef CONFIG_FIX_EARLYCON_MEM
+	console_start(console_drivers);
+#endif
 }
 
 /*
-- 
2.29.0

