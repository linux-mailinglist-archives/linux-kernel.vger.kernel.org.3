Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8356CB19
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 20:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGIShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGIShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 14:37:11 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB52E6BD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 11:37:10 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 11368 invoked from network); 9 Jul 2022 20:37:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1657391828; bh=9/lobc05iJLVKuQOLEHNyKmvwdtlHkHBYT8ylRLK7/8=;
          h=From:To:Cc:Subject;
          b=C6nQHHYfEUiIq6VK/cV2YsTXQ8na/t/Burko/i9sZtMjWGbquONRg4bIRX6LIIieE
           5bYqagOlG4kCYrspI7mlVs9gAg06iJ9+F1FPzxNnxOfh7XuffBiW2NC1h5ELjhCUAr
           3hQEHCak+3na03GsXT4GKdNzbVGLTJbYlb7e26hY=
Received: from aafi210.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.138.210])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 9 Jul 2022 20:37:07 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 2/2] x86/rtc: rename mach_set_rtc_mmss
Date:   Sat,  9 Jul 2022 20:36:50 +0200
Message-Id: <20220709183650.74955-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709183650.74955-1-mat.jonczyk@o2.pl>
References: <20220709183650.74955-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c8561f07e3dc0770976453636e08b2c3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [QdM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, before
commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp")
in 2013, the function set only the minute and seconds registers
of the CMOS RTC. This is no longer true, so rename the function to
mach_set_cmos_time.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>

---
 arch/x86/include/asm/mc146818rtc.h | 2 +-
 arch/x86/kernel/rtc.c              | 4 ++--
 arch/x86/kernel/x86_init.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

v3:
  - add more people to the Cc list.

diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 97198001e567..6115bb3d5795 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -95,7 +95,7 @@ static inline unsigned char current_lock_cmos_reg(void)
 unsigned char rtc_cmos_read(unsigned char addr);
 void rtc_cmos_write(unsigned char val, unsigned char addr);
 
-extern int mach_set_rtc_mmss(const struct timespec64 *now);
+extern int mach_set_cmos_time(const struct timespec64 *now);
 extern void mach_get_cmos_time(struct timespec64 *now);
 
 #define RTC_IRQ 8
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 1cadc8a15267..349046434513 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -27,13 +27,13 @@ DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
 /*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be
+ * In order to set the CMOS clock precisely, mach_set_cmos_time has to be
  * called 500 ms after the second nowtime has started, because when
  * nowtime is written into the registers of the CMOS clock, it will
  * jump to the next second precisely 500 ms later. Check the Motorola
  * MC146818A or Dallas DS12887 data sheet for details.
  */
-int mach_set_rtc_mmss(const struct timespec64 *now)
+int mach_set_cmos_time(const struct timespec64 *now)
 {
 	unsigned long long nowtime = now->tv_sec;
 	struct rtc_time tm;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e84ee5cdbd8c..57353519bc11 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,7 +138,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
 	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
-	.set_wallclock			= mach_set_rtc_mmss,
+	.set_wallclock			= mach_set_cmos_time,
 	.iommu_shutdown			= iommu_shutdown_noop,
 	.is_untracked_pat_range		= is_ISA_range,
 	.nmi_init			= default_nmi_init,
-- 
2.25.1

