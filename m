Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8904C50ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiBYVvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBYVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:51:13 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5A1EF362
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:50:38 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 15074 invoked from network); 25 Feb 2022 22:50:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1645825836; bh=Kx3/G7m2qDBrWtPa33qqa60d46/oRO7n/lWecW+Mc6Q=;
          h=From:To:Cc:Subject;
          b=Oq2biu2krqKCAjfcgW/hXzb4mX25JM8nJ3vcyxcspn+HL/PPCi3vP8XYeVkY/apKR
           4YTaUjTCoy80cEx1CKWhY3UXGzEJXYyraYcQHFmJVe7mG8SUeWDlidN0v6SKagStar
           B+GYBnFye+z8CIq9IBshZxFcJIVwIagef/Hixcbg=
Received: from aaew227.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.126.227])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 25 Feb 2022 22:50:36 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/3] rtc,x86: RTC CMOS refactoring
Date:   Fri, 25 Feb 2022 22:50:08 +0100
Message-Id: <20220225215011.861477-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 6d70941d5c98bed34d264568df25d8f5
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [ocO0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The main aim of this series is to remove duplicated code in
mach_get_cmos_time() in arch/x86/kernel/rtc.c . This function performed
the same thing as mc146818_get_time() - reading the time from the CMOS
RTC - but used a different algorithm. So modify it to use standard
mc146818_get_time().

First, to make these functions more similar to each other (and also for
another reason described in the patch), reduce the polling period in
mc146818_get_time(). Then, rewrite mach_get_cmos_time().

The last patch renames a function in arch/x86/kernel/rtc.c.

I have tested this on three different computers.

Greetings,
Mateusz

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Mateusz Jończyk (3):
  rtc-mc146818-lib: reduce RTC_UIP polling period
  x86/rtc: rewrite mach_get_cmos_time
  x86/rtc: rename mach_set_rtc_mmss

 arch/x86/include/asm/mc146818rtc.h |  2 +-
 arch/x86/kernel/rtc.c              | 63 +++++-------------------------
 arch/x86/kernel/x86_init.c         |  2 +-
 drivers/rtc/rtc-mc146818-lib.c     |  8 ++--
 4 files changed, 15 insertions(+), 60 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.25.1

