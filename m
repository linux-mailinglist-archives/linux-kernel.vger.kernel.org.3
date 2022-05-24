Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021B532CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiEXPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiEXPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:07:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED63DDE1;
        Tue, 24 May 2022 08:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDE6EB81722;
        Tue, 24 May 2022 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C1FC34115;
        Tue, 24 May 2022 15:06:51 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Date:   Wed, 25 May 2022 01:06:15 +1000
Message-Id: <20220524150615.52206-1-gerg@linux-m68k.org>
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

There are no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
nommu code paths. Move these definitions and the associated "mach_hwclk",
so that they are around their use case in time.c. This means they will
always be defined on the builds that require them, and not on those that
cannot use them - such as ColdFire (both with and without MMU enabled).

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/setup_mm.c | 7 -------
 arch/m68k/kernel/setup_no.c | 1 -
 arch/m68k/kernel/time.c     | 9 +++++++++
 3 files changed, 9 insertions(+), 8 deletions(-)

v2: move definition of mach_set_rtc_pll/mach_get_rtc_pll to fix no rtc q40 build

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 8f94feed969c..07317367ead8 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -87,15 +87,8 @@ void (*mach_sched_init) (void) __initdata = NULL;
 void (*mach_init_IRQ) (void) __initdata = NULL;
 void (*mach_get_model) (char *model);
 void (*mach_get_hardware_list) (struct seq_file *m);
-/* machine dependent timer functions */
-int (*mach_hwclk) (int, struct rtc_time*);
-EXPORT_SYMBOL(mach_hwclk);
 unsigned int (*mach_get_ss)(void);
-int (*mach_get_rtc_pll)(struct rtc_pll_info *);
-int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 EXPORT_SYMBOL(mach_get_ss);
-EXPORT_SYMBOL(mach_get_rtc_pll);
-EXPORT_SYMBOL(mach_set_rtc_pll);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
 void (*mach_power_off)( void );
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 5e4104f07a44..19eea73d3c17 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -50,7 +50,6 @@ char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* machine dependent timer functions */
 void (*mach_sched_init)(void) __initdata = NULL;
-int (*mach_hwclk) (int, struct rtc_time*);
 
 /* machine dependent reboot functions */
 void (*mach_reset)(void);
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 340ffeea0a9d..a97600b2af50 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -63,6 +63,15 @@ void timer_heartbeat(void)
 #endif /* CONFIG_HEARTBEAT */
 
 #ifdef CONFIG_M68KCLASSIC
+/* machine dependent timer functions */
+int (*mach_hwclk) (int, struct rtc_time*);
+EXPORT_SYMBOL(mach_hwclk);
+
+int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+int (*mach_set_rtc_pll)(struct rtc_pll_info *);
+EXPORT_SYMBOL(mach_get_rtc_pll);
+EXPORT_SYMBOL(mach_set_rtc_pll);
+
 #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
 void read_persistent_clock64(struct timespec64 *ts)
 {
-- 
2.25.1

