Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA404C50F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiBYVvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiBYVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:51:17 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D520B176
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:50:44 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 17847 invoked from network); 25 Feb 2022 22:50:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1645825841; bh=Y2IT2MD+M5Kuxt46voh5jFtMk8ayrmPXt7vtMwYPIE4=;
          h=From:To:Cc:Subject;
          b=YLPEjH9M8sPKGfAxQw4h/EvZs8P3vxr1+LZonwamT7gnbHTYCnHewy130o0ImtIoW
           j8dX1IaVSVzHuosaPI3mkL88X/J7rsCV7+PeTDRIGCnEIFAwgeNWKZPV3uX/D4tt0G
           aKTvYXDa75qZFYErLyx56m+vnNlcBS2F25MLOp/4=
Received: from aaew227.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.126.227])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 25 Feb 2022 22:50:41 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc-mc146818-lib: reduce RTC_UIP polling period
Date:   Fri, 25 Feb 2022 22:50:09 +0100
Message-Id: <20220225215011.861477-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225215011.861477-1-mat.jonczyk@o2.pl>
References: <20220225215011.861477-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 478f42270233dca8f289efad5e49b1d1
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [cVNk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting 1ms every time is not necessary, for example on some AMD boxes
the RTC_UIP bit is documented as being high for around 270 microseconds
in some cases [1], which agreed with experiments on an SB710
southbridge. So 100us seems optimal.

This in preparation for mach_get_cmos_time() refactoring.
The functions mc146818_get_time() and mach_get_cmos_time() in
arch/x86/kernel/rtc.c perform the same function and the code is
duplicated. mach_get_cmos_time() is busy waiting for the RTC_UIP
bit to clear, so make mc146818_get_time() more similar to it by reducing
the polling period.

[1] AMD SB700/710/750 Register Reference Guide, page 307,
https://developer.amd.com/wordpress/media/2012/10/43009_sb7xx_rrg_pub_1.00.pdf

        "SB700 A12: The UIP high pulse is 270 μS Typical when SS on SRC
        clock is OFF and 100μ min when SRC SS is ON." [sic]

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mc146818-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index ae9f131b43c0..ae4b19e0a981 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,13 +21,13 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 	unsigned long flags;
 	unsigned char seconds;
 
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < 100; i++) {
 		spin_lock_irqsave(&rtc_lock, flags);
 
 		/*
 		 * Check whether there is an update in progress during which the
 		 * readout is unspecified. The maximum update time is ~2ms. Poll
-		 * every msec for completion.
+		 * every 100 usec for completion.
 		 *
 		 * Store the second value before checking UIP so a long lasting
 		 * NMI which happens to hit after the UIP check cannot make
@@ -37,7 +37,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			mdelay(1);
+			udelay(100);
 			continue;
 		}
 
@@ -56,7 +56,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		 */
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			mdelay(1);
+			udelay(100);
 			continue;
 		}
 
-- 
2.25.1

