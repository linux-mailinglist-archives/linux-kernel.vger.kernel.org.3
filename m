Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036B50A927
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387788AbiDUT2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347468AbiDUT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:28:15 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3922B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:25:23 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 7750 invoked from network); 21 Apr 2022 21:25:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1650569118; bh=cL8/ZnaB/KGYG+SGDO68j65XoxyE6Adoj+9820riXYg=;
          h=From:To:Cc:Subject;
          b=WUOZGSM87IvSYQsX6ghg9tbHg8LTh/+S6mJfDvNWvxl+Xig4ulmN1iHt5NhSAaZMi
           7zclYU0m6O/xS+FYd1p1c262yCu7V2vo4ST4575BSsBOK5aQameeVb4yDmkvM3P3HS
           Fn0D8w9lZ5z8FHmI6e2XxocKjrN6a7KnzfeivuYE=
Received: from aafl13.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.141.13])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 21 Apr 2022 21:25:18 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/2] x86/rtc: refactoring
Date:   Thu, 21 Apr 2022 21:24:47 +0200
Message-Id: <20220421192449.11004-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: fcb26315dbc1799316f4225d272121ef
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gXMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The first and main patch of this series removes duplicated code in
mach_get_cmos_time() in arch/x86/kernel/rtc.c . This function performed
the same thing as mc146818_get_time() - reading the time from the CMOS
RTC - but used a different algorithm. So modify it to use standard
mc146818_get_time().

The second patch renames a function in arch/x86/kernel/rtc.c.

Greetings,
Mateusz

v2:
  - drop the previously first patch ("rtc-mc146818-lib: reduce RTC_UIP
    polling period"). Its intent was to make behaviour of
    mc146818_get_time() more similar to the existing version of
    mach_get_cmos_time() by decreasing the polling period in
    mc146818_get_time(). However, I determined that this does not matter
    for users of mach_get_cmos_time().

  - use pr_err instead of pr_err_ratelimited in the first remaining
    patch,

  - small patch description modifications.

Tested on 3 computers, and on i386 and amd64 VMs.
        
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Mateusz Jończyk (2):
  x86/rtc: rewrite mach_get_cmos_time to delete duplicated code
  x86/rtc: rename mach_set_rtc_mmss

 arch/x86/include/asm/mc146818rtc.h |  2 +-
 arch/x86/kernel/rtc.c              | 63 +++++-------------------------
 arch/x86/kernel/x86_init.c         |  2 +-
 3 files changed, 11 insertions(+), 56 deletions(-)

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.25.1

