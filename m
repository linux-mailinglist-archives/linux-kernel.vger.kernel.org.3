Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A34877C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiAGMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:17 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:56220 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347265AbiAGMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:06 -0500
Received: (wp-smtpd smtp.tlen.pl 16347 invoked from network); 7 Jan 2022 13:50:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559804; bh=YcJVcQBbTkpAtrlB53Y19zxjPZMkU4TAL2cjGKrrYO0=;
          h=From:To:Cc:Subject;
          b=wORoW0cbuyFOOvGSeYRZOmBZpa/9aH/1gbC1Mcsjoy1GXYNOOsAfSsRGQadMAHWO3
           ibqxQUx+4MimKzt/kv6WS89P8EGlzEjpuPKo7LYJUVk7GGr+lp+dyFNxwNwwLZHt4i
           DLDyx3quXajmXOncnQoDKlnXIvog9ch5TZU7LREw=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:50:04 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 7/9] rtc-mc146818-lib: refactor mc146818_does_rtc_work
Date:   Fri,  7 Jan 2022 13:49:32 +0100
Message-Id: <20220107124934.159878-8-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 39616cef60deff4614506a3a4662ad17
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [0bO0]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor mc146818_does_rtc_work() so that it uses mc146818_avoid_UIP().
It is enough to call mc146818_avoid_UIP() with no callback.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

v4: fixed a mistake in the patch description.

 drivers/rtc/rtc-mc146818-lib.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 34a1ed61a4f9..75dfad22b31a 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -84,22 +84,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	int i;
-	unsigned char val;
-	unsigned long flags;
-
-	for (i = 0; i < 20; i++) {
-		spin_lock_irqsave(&rtc_lock, flags);
-		val = CMOS_READ(RTC_FREQ_SELECT);
-		spin_unlock_irqrestore(&rtc_lock, flags);
-
-		if ((val & RTC_UIP) == 0)
-			return true;
-
-		mdelay(1);
-	}
-
-	return false;
+	return mc146818_avoid_UIP(NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
-- 
2.25.1

