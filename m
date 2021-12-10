Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB7470B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbhLJUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:05:54 -0500
Received: from mx-out.tlen.pl ([193.222.135.142]:48862 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240266AbhLJUFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:05:52 -0500
Received: (wp-smtpd smtp.tlen.pl 29603 invoked from network); 10 Dec 2021 21:02:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1639166533; bh=BfhIsyR4sRSn7gNQK3PqdNVAm26OvNKnvdZ2c96NVTY=;
          h=From:To:Cc:Subject;
          b=Ysaq2tX+4pi0OxCwakOVIyyUgAMWCKXxOig+u1PAjo4AfcNa+B6pYNUJsluAkRH1J
           FWcGxyE16ypPH5zegubtbHiOtFu0O5Ngjhribo8ltx8UGL2Y/p5tg6Jou4v24AKtMS
           +QlYUih9uIo5seSLc6BbD1/LJqillDbfOcSSjwmI=
Received: from aaff136.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.135.136])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 10 Dec 2021 21:02:13 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 2/9] rtc: change return values of mc146818_get_time()
Date:   Fri, 10 Dec 2021 21:01:24 +0100
Message-Id: <20211210200131.153887-3-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200131.153887-1-mat.jonczyk@o2.pl>
References: <20211210200131.153887-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: cc64d9f77310f525e76f7ab7fe795b4a
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [4VOk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No function is checking mc146818_get_time() return values yet, so
correct them to make them more customary.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

v4: Added this patch

 drivers/rtc/rtc-mc146818-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index dcfaf09946ee..c186c8c4982b 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -25,7 +25,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x40) != 0)) {
 		spin_unlock_irqrestore(&rtc_lock, flags);
 		memset(time, 0xff, sizeof(*time));
-		return 0;
+		return -EIO;
 	}
 
 	/*
@@ -116,7 +116,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 
 	time->tm_mon--;
 
-	return RTC_24H;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mc146818_get_time);
 
-- 
2.25.1

