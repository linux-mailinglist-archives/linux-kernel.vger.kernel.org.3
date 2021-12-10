Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEC470B45
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbhLJUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:05:42 -0500
Received: from mx-out.tlen.pl ([193.222.135.142]:15829 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240266AbhLJUFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:05:41 -0500
Received: (wp-smtpd smtp.tlen.pl 31614 invoked from network); 10 Dec 2021 21:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1639166520; bh=ro91BKZb7ftRmQH03BQVatByZlZtZxH95clzpQgFwBs=;
          h=From:To:Cc:Subject;
          b=UXoRG4CEgmKcsr6WHB3GdZTm54W7DF+qHkvkj61p9A9rrpT5vgw2wOb5aIAtdB4Kj
           DDhOSSFx6VzTvht388d9JtL5iLGWtYBcJZjrX15YPntwilyHpOhI5Pbjs9BEIYQx7U
           4BXZBTwwS/yC0lIV9E/FRD9+TdzWusA2NGbzRA6s=
Received: from aaff136.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.135.136])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 10 Dec 2021 21:02:00 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/9] rtc-cmos,rtc-mc146818-lib: fixes
Date:   Fri, 10 Dec 2021 21:01:22 +0100
Message-Id: <20211210200131.153887-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 80a83cc73dcd7d1024b4fda400e06e99
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [AQOk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series fixes some issues in the RTC CMOS handling code:

1. A missing spin_lock_irq() / spin_unlock_irq() pair in cmos_set_alarm().
2. A failing presence check of the RTC: the clock was misdetected as
   broken since Linux 5.11 on one of our home systems.
3. Do not touch the RTC alarm registers when the RTC update is in
   progress. (On some Intel chipsets, this causes bogus values being
   read or writes to fail silently.)

This is my first patch series, so please review carefully.

v2: Drop the last patch:
        Revert "rtc: cmos: Replace spin_lock_irqsave with spin_lock in hard IRQ"
which was made obsolete by mainlining of 
commit 13be2efc390a ("rtc: cmos: Disable irq around direct invocation of cmos_interrupt()")

v3: Rework solution to problem 3 (I'd like to thank Greg KH for comment),
drop x86 refactoring patches (I'll send them later).

v4: Fixed some issues pointed out by Mr Alexandre Belloni:
    - do not add strings to rtc-mc146818-lib.c - I moved the error printing
      code to callers of mc146818_get_time(). This resulted in two new
      patches in the series,
    - other small issues.

I have noticed that mach_get_cmos_time() in arch/x86/kernel/rtc.c
performs a similar function to mc146818_get_time() in
drivers/rtc/rtc-cmos.c . In the future, I'm going to post a new series
that removes this duplicated code and makes mach_get_cmos_time() use
mc146818_get_time(). This will likely include reducing polling interval
in mc146818_avoid_UIP() from 1ms to 100us to make it more similar to
mach_get_cmos_time()'s current behaviour.

Greetings,
Mateusz

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
