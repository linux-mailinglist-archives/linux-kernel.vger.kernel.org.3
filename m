Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEE4B384D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiBLWFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:05:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiBLWFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:05:49 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560A606FE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:05:42 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 18600 invoked from network); 12 Feb 2022 23:05:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1644703539; bh=AnQN+FJyRGopKtB+HTr7nThFXwjuArnFpHKHUUQNYoY=;
          h=From:To:Cc:Subject;
          b=r1TDnwTmPuDEihAsAdSvWAbdrgAuAZ6lf4OSZ/Y3JhQJcTbr3KbTzQu+/IsYxqcwC
           Y8zoZXDd1OmT5Qx1VJmD1j4gzeEgXhoIvYutCc4aNg5s+Sjut04B26/ay3xqtRr/xL
           ueakEzF45e8lnB18Ho3IWp6NDSwUG09I64hMKuO0=
Received: from aaem217.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.116.217])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 12 Feb 2022 23:05:38 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc-mc146818-lib: wait longer for UIP to clear
Date:   Sat, 12 Feb 2022 23:04:54 +0100
Message-Id: <20220212220454.566548-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 803afe6153e8175b7ef9efb8cb1be6a5
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gZP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before reading date / time from the CMOS RTC, we wait for the UIP
(Update in progress) bit to clear --- so that the values are correct and
consistent. To avoid a hang, there is a time limit after which we give
up waiting.

Increase the time limit from 10 to 20ms in case there are RTCs out there
that are much slower than expected.

Note: This may cause problems with hpet_rtc_interrupt() if the CMOS RTC
breaks down while the system is running and RTC update interrupt / RTC
alarm interrupt happens to be enabled (which should be rare).
hpet_rtc_interrupt() is executed usually 64 times per second and after
this patch it may take up to 20ms to complete (always hitting RTC read
timeout) - which may constantly occupy one CPU. This looks very
unlikely, though.

Also fix "then" -> "than" in a comment.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
---

This comment from Mr Alexandre Belloni got me thinking and is why I am
submitting this patch:
> We'll probably get some breakage later on because many RTCs using this
> driver are not adhering to the spec.
(See: https://lore.kernel.org/linux-rtc/277177e7-46a0-522c-297c-ad3ee0c15793@o2.pl/T/ )

Googling for dmesg messages that indicate problems with reading from RTC
(such as "unable to read current time" - using quotation marks to force
exact phrase search) produces no results apart from kernel code and
patches. Any problems would happen rarely on affected systems, though.

 drivers/rtc/rtc-mc146818-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index ae9f131b43c0..29ceec9875f4 100644
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

base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.25.1

