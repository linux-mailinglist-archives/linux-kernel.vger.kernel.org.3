Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5784879C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbiAGPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:35:18 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:16351 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239572AbiAGPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:35:15 -0500
Received: (wp-smtpd smtp.tlen.pl 5873 invoked from network); 7 Jan 2022 16:35:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641569713; bh=twRNu/a9b9RNQJ2jdkhVBvobmGSZZg0vR5jFe0bYAAw=;
          h=From:To:Cc:Subject;
          b=xcfr3KVn915DT0ov1MQokXBEF0mRuhAvp4zIOIvBNAwZuYn0yrR/nYBOHELoM0mhS
           rAUDGS/K2gJ5d/vt0KtZI0vCLXK5r97jKZAKjQjYLFkLHq9ZbBVIDnq8KO3gsPD1Gn
           zm/nqgatRwikkYgklB90/rTBS5DUr/ralQSDVsDw=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 16:35:13 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] RFC: rtc-mc146818-lib: wait longer for UIP to clear
Date:   Fri,  7 Jan 2022 16:34:54 +0100
Message-Id: <20220107153454.391708-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cccbd4cf-f302-b64d-bf32-abdefbc7c6d0@o2.pl>
References: <cccbd4cf-f302-b64d-bf32-abdefbc7c6d0@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3439be24a1bcffc31e6316b4f92dcfc7
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gVMU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before reading date / time from the CMOS RTC, we wait for the
UIP (Update in progress) bit to clear --- so that the values are correct
and consistent. To avoid a hang, there is a time limit after
which we give up waiting.

Increase the time limit from 10 to 20ms in case there are RTCs out
there that are much slower than expected.

This is to be applied on top of rtc-next.

Note: This may cause problems with hpet_rtc_interrupt() if the CMOS RTC
breaks down while the system is running and RTC update interrupt / RTC
alarm interrupt happens to be enabled (which should be rare).
hpet_rtc_interrupt() is executed usually 64 times per second and after
this patch it may take up to 20ms to complete - which may constantly
occupy one CPU. This looks very unlikely, though.

So, I don't know whether implementing this change is worth it and even if
20ms is enough. So I'm asking for opinions.

This comment from Mr Alexandre Belloni got me thinking and is why I
consider this patch:
> We'll probably get some breakage later on because many RTCs using this
> driver are not adhering to the spec.
(See: https://lore.kernel.org/linux-rtc/277177e7-46a0-522c-297c-ad3ee0c15793@o2.pl/T/ )

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
---
 drivers/rtc/rtc-mc146818-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index f62e658cbe23..55e7d2a7578a 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,7 +21,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 	unsigned long flags;
 	unsigned char seconds;
 
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < 20; i++) {
 		spin_lock_irqsave(&rtc_lock, flags);
 
 		/*
@@ -79,8 +79,8 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
 
 /*
- * If the UIP (Update-in-progress) bit of the RTC is set for more then
- * 10ms, the RTC is apparently broken or not present.
+ * If the UIP (Update-in-progress) bit of the RTC is set for more than
+ * 20ms, the RTC is apparently broken or not present.
  */
 bool mc146818_does_rtc_work(void)
 {
-- 
2.25.1

