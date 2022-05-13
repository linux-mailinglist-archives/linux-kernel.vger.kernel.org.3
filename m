Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B03525BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377451AbiEMGuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359479AbiEMGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:50:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9522A28F3;
        Thu, 12 May 2022 23:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B1D9B82C44;
        Fri, 13 May 2022 06:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F39C34100;
        Fri, 13 May 2022 06:49:57 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Date:   Fri, 13 May 2022 16:49:52 +1000
Message-Id: <20220513064952.3610672-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuring for a nommu classic m68k target and enabling the generic rtc
driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
error:

   m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
   time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
   m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
   m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'

"mach_set_rtc_pll" and "mach_get_rtc_pll" are only defined in the common
MMU setup code, and are really only implemented in any meaningful way on
classic M68K MMU enabled machines. So conditionally limit their use to
MMU enabled classic M68K systems.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 340ffeea0a9d..c8b70b425ada 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -62,7 +62,7 @@ void timer_heartbeat(void)
 }
 #endif /* CONFIG_HEARTBEAT */
 
-#ifdef CONFIG_M68KCLASSIC
+#if defined(CONFIG_M68KCLASSIC) && defined(CONFIG_MMU)
 #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
 void read_persistent_clock64(struct timespec64 *ts)
 {
@@ -140,7 +140,7 @@ static int __init rtc_init(void)
 
 module_init(rtc_init);
 #endif /* CONFIG_RTC_DRV_GENERIC */
-#endif /* CONFIG M68KCLASSIC */
+#endif /* CONFIG M68KCLASSIC && CONFIG_MMU */
 
 void __init time_init(void)
 {
-- 
2.25.1

