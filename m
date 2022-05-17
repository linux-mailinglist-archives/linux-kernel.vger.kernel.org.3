Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD93F52ACA6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352918AbiEQUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350882AbiEQUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:22:06 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603C522EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:22:02 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 23163 invoked from network); 17 May 2022 22:21:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1652818917; bh=iMnkwwcgkRQnDEbHbyihhtkLo3AnSPyvGVvhigcz/wQ=;
          h=From:To:Cc:Subject;
          b=wbdwRHHCksWIFUlj+g9uIxBfeoRccU+WyZJN2o2kiKP3kaA/Ih+8QGccJZJrbOAzL
           dzGoPPZiS/b55VQeCRtCvHXyT9vzE7Xrb8DQKpLbBE8fExfklylBS46S7korX6R4aM
           v6DerqqdYWGhYHV/hYaZXcs8hmEueDHBxON7f4Ew=
Received: from aafg236.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.136.236])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 17 May 2022 22:21:57 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 resend 0/2] x86/rtc: refactoring
Date:   Tue, 17 May 2022 22:21:29 +0200
Message-Id: <20220517202131.379939-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3f74181e37c2ca240d5ab56c2001b014
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [8QOU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The first and main patch of this series removes duplicated code in
mach_get_cmos_time() in arch/x86/kernel/rtc.c . This function performed
the same thing as mc146818_get_time() - reading the time from the CMOS
RTC - but used a different algorithm. So modify it to use common
mc146818_get_time().

The second patch renames a function in arch/x86/kernel/rtc.c.

Tested originally (on top of 5.18-rc3) on 3 computers, and in i386 and
amd64 VMs.

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


base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.25.1

