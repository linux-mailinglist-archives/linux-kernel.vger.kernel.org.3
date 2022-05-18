Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13652B2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiERG5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiERG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:57:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0813E3A;
        Tue, 17 May 2022 23:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F903B81E98;
        Wed, 18 May 2022 06:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECD4C34100;
        Wed, 18 May 2022 06:56:51 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 2/3] m68k: removed unused "mach_get_ss"
Date:   Wed, 18 May 2022 16:56:38 +1000
Message-Id: <20220518065639.2432213-3-gerg@linux-m68k.org>
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

The m68k machine helper function "mach_get_ss" function pointer is
set for some machines, but ultimately never used anywhere. Remove it.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/hp300/config.c        | 7 -------
 arch/m68k/include/asm/machdep.h | 1 -
 arch/m68k/kernel/setup_mm.c     | 2 --
 arch/m68k/q40/config.c          | 7 -------
 4 files changed, 17 deletions(-)

diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index 2c92843397c3..e4bd6913f50e 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -240,12 +240,6 @@ static int hp300_hwclk(int op, struct rtc_time *t)
 	return 0;
 }
 
-static unsigned int hp300_get_ss(void)
-{
-	return hp300_rtc_read(RTC_REG_SEC1) * 10 +
-		hp300_rtc_read(RTC_REG_SEC2);
-}
-
 static void __init hp300_init_IRQ(void)
 {
 }
@@ -256,7 +250,6 @@ void __init config_hp300(void)
 	mach_init_IRQ        = hp300_init_IRQ;
 	mach_get_model       = hp300_get_model;
 	mach_hwclk	     = hp300_hwclk;
-	mach_get_ss	     = hp300_get_ss;
 	mach_reset           = hp300_reset;
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat       = hp300_pulse;
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 8fd80ef1b77e..841ba6aa3fcb 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -19,7 +19,6 @@ extern void (*mach_get_model) (char *model);
 extern void (*mach_get_hardware_list) (struct seq_file *m);
 /* machine dependent timer functions */
 extern int (*mach_hwclk)(int, struct rtc_time*);
-extern unsigned int (*mach_get_ss)(void);
 extern int (*mach_get_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern void (*mach_reset)( void );
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 07317367ead8..0593bf345b34 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -87,8 +87,6 @@ void (*mach_sched_init) (void) __initdata = NULL;
 void (*mach_init_IRQ) (void) __initdata = NULL;
 void (*mach_get_model) (char *model);
 void (*mach_get_hardware_list) (struct seq_file *m);
-unsigned int (*mach_get_ss)(void);
-EXPORT_SYMBOL(mach_get_ss);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
 void (*mach_power_off)( void );
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 9237243077ce..c78ee709b458 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -41,7 +41,6 @@ static void q40_get_model(char *model);
 extern void q40_sched_init(void);
 
 static int q40_hwclk(int, struct rtc_time *);
-static unsigned int q40_get_ss(void);
 static int q40_get_rtc_pll(struct rtc_pll_info *pll);
 static int q40_set_rtc_pll(struct rtc_pll_info *pll);
 
@@ -169,7 +168,6 @@ void __init config_q40(void)
 
 	mach_init_IRQ = q40_init_IRQ;
 	mach_hwclk = q40_hwclk;
-	mach_get_ss = q40_get_ss;
 	mach_get_rtc_pll = q40_get_rtc_pll;
 	mach_set_rtc_pll = q40_set_rtc_pll;
 
@@ -246,11 +244,6 @@ static int q40_hwclk(int op, struct rtc_time *t)
 	return 0;
 }
 
-static unsigned int q40_get_ss(void)
-{
-	return bcd2bin(Q40_RTC_SECS);
-}
-
 /* get and set PLL calibration of RTC clock */
 #define Q40_RTC_PLL_MASK ((1<<5)-1)
 #define Q40_RTC_PLL_SIGN (1<<5)
-- 
2.25.1

