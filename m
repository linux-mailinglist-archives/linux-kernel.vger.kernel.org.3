Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C451487C35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiAGSas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:30:48 -0500
Received: from mx-out.tlen.pl ([193.222.135.158]:53201 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241055AbiAGSas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:30:48 -0500
Received: (wp-smtpd smtp.tlen.pl 34295 invoked from network); 7 Jan 2022 19:30:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641580245; bh=SWiAconY7zgizwjw07HhTiVctBWou/ptYNxMtMPUvvs=;
          h=From:To:Cc:Subject;
          b=ELTGkzekRhYVr6r9MfO9oCMxDA4T288lkA7VTGu8ZQFwGvJfsjVga5gAdUdSzCiIW
           QlWUmrww1NY7vYquweYU6IPivasAy/gFGb5YxDyq7W1SQzP/JwuZY/Jzhm1gJpFHjP
           viG/atwCp5fV2VHTUj6jg2RNik9io4ja+nmlLmew=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 19:30:45 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc-cmos: replace obsolete comments
Date:   Fri,  7 Jan 2022 19:30:29 +0100
Message-Id: <20220107183029.486207-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 6964a5c64c8ae93e48457f54cf352c5c
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gYNU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments in cmos_read_alarm() and cmos_set_alarm() do not apply to
current code, replace them.

These comments were added in
commit fbb974ba693b ("rtc: cmos: Do not export alarm rtc_ops when we do not support alarms")
which introduced a separate struct rtc_class_ops, which was used when
the device did not support RTC alarms. The functions cmos_read_alarm()
and cmos_set_alarm() were called not only from the rtc_op struct, but
also explicitly, so they had to independently check for RTC alarm
support.

The separate rtc_class_ops structure was later removed in
        commit 30f5bd537fdb ("rtc: cmos: remove cmos_rtc_ops_no_alarm")
but the comments remained and now are obsolete.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

This patch applies cleanly on rtc-next.

 drivers/rtc/rtc-cmos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7c006c2b125f..cd82eff2630a 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -290,7 +290,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		.time = &t->time,
 	};
 
-	/* This not only a rtc_op, but also called directly */
+	/* Fail if the RTC alarm is not supported */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
@@ -523,7 +523,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	unsigned char rtc_control;
 	int ret;
 
-	/* This not only a rtc_op, but also called directly */
+	/* Fail if the RTC alarm is not supported */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
-- 
2.25.1

