Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13F252B2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiERG51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiERG4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DE12772;
        Tue, 17 May 2022 23:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE86EB81E9B;
        Wed, 18 May 2022 06:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13932C385A9;
        Wed, 18 May 2022 06:56:48 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Date:   Wed, 18 May 2022 16:56:37 +1000
Message-Id: <20220518065639.2432213-2-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518065639.2432213-1-gerg@linux-m68k.org>
References: <20220518065639.2432213-1-gerg@linux-m68k.org>
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

There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
nommu code paths. Move these definitions and the associated "mach_hwclk",
so that they are around their use case in time.c. This means they will
always be defined on the builds that require them, and not on those that
cannot use them - such as ColdFire (both with and without MMU enabled).

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/setup_mm.c | 7 -------
 arch/m68k/kernel/setup_no.c | 1 -
 arch/m68k/kernel/time.c     | 9 +++++++++
 3 files changed, 9 insertions(+), 8 deletions(-)

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
index 340ffeea0a9d..97a5438562cd 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -63,6 +63,10 @@ void timer_heartbeat(void)
 #endif /* CONFIG_HEARTBEAT */
 
 #ifdef CONFIG_M68KCLASSIC
+/* machine dependent timer functions */
+int (*mach_hwclk) (int, struct rtc_time*);
+EXPORT_SYMBOL(mach_hwclk);
+
 #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
 void read_persistent_clock64(struct timespec64 *ts)
 {
@@ -82,6 +86,11 @@ void read_persistent_clock64(struct timespec64 *ts)
 #endif
 
 #if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
+int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+int (*mach_set_rtc_pll)(struct rtc_pll_info *);
+EXPORT_SYMBOL(mach_get_rtc_pll);
+EXPORT_SYMBOL(mach_set_rtc_pll);
+
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
 	mach_hwclk(0, tm);
-- 
2.25.1

