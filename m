Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4F4877AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiAGMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:49:48 -0500
Received: from mx-out.tlen.pl ([193.222.135.175]:41256 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbiAGMtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:49:47 -0500
Received: (wp-smtpd smtp.tlen.pl 21951 invoked from network); 7 Jan 2022 13:49:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641559785; bh=aJZwZ7IpWhFWERR2lRcVhZlAPft24k0xF2MqSOnzzq0=;
          h=From:To:Cc:Subject;
          b=LqIib5mDajc5fjrTz8ae7DnA2cYhTFnVhGYLSoTPqJl5On1ffp62NzZ1FxQB/Yojb
           U67FAK3nF2B/aUn41iuwS/qw3S6fY1mn6Vh1HmSIFbWB9ql077IOo2dQIx1kScyZd8
           B0xWrHnb6FSJxQ4FXg33Ex+cdF0O8faWc5DvQJWo=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jan 2022 13:49:45 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v5 0/9] rtc-cmos,rtc-mc146818-lib: fixes
Date:   Fri,  7 Jan 2022 13:49:25 +0100
Message-Id: <20220107124934.159878-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 88d531224465cdb716ec0009a0249a60
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [obNU]                               
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

v5: Increase maximum accepted duration of the UIP high pulse from 10 to 20ms,
    in case there are some very slow chips out there.

    Note: this may cause problems with hpet_rtc_interrupt() if the CMOS
    RTC stops working while the system is running and RTC update
    interrupt / RTC alarm interrupt is enabled (which should be rare).
    In this case, hpet_rtc_interrupt() is executed 64 times per second
    and takes up to 20ms to complete - which may constantly occupy
    one CPU. I am not sure if this is likely enough to implement
    special handling of this case in hpet_rtc_interrupt().

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
