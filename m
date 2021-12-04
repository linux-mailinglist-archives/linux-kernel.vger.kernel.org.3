Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9474681F1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbhLDCWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhLDCWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:22:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10EC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:19:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u80so4585570pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgqlE8L002r4rFKN6cOCZIPMWyYH8g/yRVNJw29FxcU=;
        b=TbvNG8EVmm1LVcp4nDgwfK+YHt+jRTjXW8yR+EFsftc7dSp4nc6uWJW0bmsu/0AU6b
         Ugg9X9aOGGpphNP1jombLTUi5lWeQCrJxMP5Si/ge7wZtx7EkDXYuu1tUUaOU69v49Mf
         cVCdeu2ixWVgmwwYEcg2QA3J8+X86r/gQnseXb4xzLol84JSjfeIr4vkkkCCeaIqQ4G4
         eU3qrXDFyxNwm5p2qAOtToEOTTu07JullPXo38G9PaiJ1kyiJNwjozlUyYZcHNqso4Iv
         AKJE5W3bMczYbpbXHM68AOUNh9jV8O7C8/5ainBhCoaEUCMtVZPbkAKypb3zHeAv9e9M
         tTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgqlE8L002r4rFKN6cOCZIPMWyYH8g/yRVNJw29FxcU=;
        b=IuPn0+nFhnCT+xjAN44P/DWNTLyj/md5AzAuBCV2S12xIACuNaMWIGnwexEU/rYnkY
         Y0NwNgoXVoww+JnUSEhClXhsS+GoAC5mcy4lSjfqDHdhxEYNA+YP3o6uS6600DkAz9Tp
         VSO1AS6MlnbIj0dbulP8Gjt93IKZL6R/X8qHw4Od5bAviS0us6W8AxTCeDbZ+v6bmZ34
         6tJ3MOdGxeCi+JXIRpea3Y096pc7fLwga8i30wkwKpApCEiOzC3bL/qSmZNG/L0AU8Ca
         4BASDopx8SrHC6Z2Mvr1LBFdc5mLAzaMCtZDSmXRAEAwj9ef+oINhE7hXkxDOhW2UbWm
         XpyA==
X-Gm-Message-State: AOAM532Cae542ZqyQVXi6rxE84aHl51hXIsnKRf7V0+v9ISYNRKj0i1R
        LVBIgqb0BTvljsW+N+/UgnTO+dhb46I=
X-Google-Smtp-Source: ABdhPJxsq9GOpUlxI12eeJEca8zEXwBe2VEoLvTIJw8q1Bn2i/1fE2nN7MYBAJtbMTT1kpLPjyjpBw==
X-Received: by 2002:a63:5b18:: with SMTP id p24mr7404473pgb.589.1638584345402;
        Fri, 03 Dec 2021 18:19:05 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id f4sm4760828pfj.61.2021.12.03.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:19:04 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] openrisc: Cleanup switch code and comments
Date:   Sat,  4 Dec 2021 11:18:40 +0900
Message-Id: <20211204021842.1853549-2-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The saving of the r12 register was there for a compiler bug referring
to a port that was never upstreamed.  It should be safe to use this
as the new compiler is what we use and the old deprecated.

Also, clean up some typos and references to old names in the switch
comments.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 59c6d3aa7081..c608f76e5753 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1001,11 +1001,10 @@ ENTRY(ret_from_fork)
 	l.lwz	r11,PT_GPR11(r1)
 
 	/* The syscall fast path return expects call-saved registers
-	 * r12-r28 to be untouched, so we restore them here as they
+	 * r14-r28 to be untouched, so we restore them here as they
 	 * will have been effectively clobbered when arriving here
 	 * via the call to switch()
 	 */
-	l.lwz	r12,PT_GPR12(r1)
 	l.lwz	r14,PT_GPR14(r1)
 	l.lwz	r16,PT_GPR16(r1)
 	l.lwz	r18,PT_GPR18(r1)
@@ -1037,10 +1036,10 @@ ENTRY(ret_from_fork)
 
 /* _switch MUST never lay on page boundry, cause it runs from
  * effective addresses and beeing interrupted by iTLB miss would kill it.
- * dTLB miss seams to never accour in the bad place since data accesses
+ * dTLB miss seems to never accour in the bad place since data accesses
  * are from task structures which are always page aligned.
  *
- * The problem happens in RESTORE_ALL_NO_R11 where we first set the EPCR
+ * The problem happens in RESTORE_ALL where we first set the EPCR
  * register, then load the previous register values and only at the end call
  * the l.rfe instruction. If get TLB miss in beetwen the EPCR register gets
  * garbled and we end up calling l.rfe with the wrong EPCR. (same probably
@@ -1068,9 +1067,8 @@ ENTRY(_switch)
 	/* No need to store r1/PT_SP as it goes into KSP below */
 	l.sw    PT_GPR2(r1),r2
 	l.sw    PT_GPR9(r1),r9
-	/* This is wrong, r12 shouldn't be here... but GCC is broken for the time being
-	 * and expects r12 to be callee-saved... */
-	l.sw    PT_GPR12(r1),r12
+
+	/* Save callee-saved registers to the new pt_regs */
 	l.sw    PT_GPR14(r1),r14
 	l.sw    PT_GPR16(r1),r16
 	l.sw    PT_GPR18(r1),r18
@@ -1111,9 +1109,7 @@ ENTRY(_switch)
 	/* No need to restore r10 */
 	/* ...and do not restore r11 */
 
-	/* This is wrong, r12 shouldn't be here... but GCC is broken for the time being
-	 * and expects r12 to be callee-saved... */
-	l.lwz   r12,PT_GPR12(r1)
+	/* Restore callee-saved registers */
 	l.lwz   r14,PT_GPR14(r1)
 	l.lwz   r16,PT_GPR16(r1)
 	l.lwz   r18,PT_GPR18(r1)
-- 
2.31.1

