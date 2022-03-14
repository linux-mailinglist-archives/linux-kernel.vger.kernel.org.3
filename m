Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE94D7916
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiCNB2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiCNB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:28:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278822522
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CkToD0BxUEhnZ8Dohn6Eiu4LjNB1lWi0sx+7nTneJlE=; b=QfhrtS+SIghzPP0knT5lgq/oDL
        PIH5oCNdqFef80lOMqsmK8z/ZVT+LsV34fUmbgAeyOPSw9ASzk6an3sDURiMSqmtg72tgWS6gE+vk
        NJzqmOacFqnuwxCBQApz5938YbuhfHYfhe67kleVzxG1CMjBf+KmwffYPcbX3FllJzPTPSq0i1zyc
        JiCZXuFEAfTMY+ORfN+HOwdk2CfpIUKs2iQBqDmGwf7UwHGOC0Zg0LTFOL7d+2mnOk7sxxVnu42f/
        iKViEv/59cPxJ5YlCOE1d5/2W5Ru41ONRrVCC+xYf+OYY46FHmC2i2JwIvppGWJ3SlmTjss4EvNvi
        HXOhNAiw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTZUd-003Z4d-VU; Mon, 14 Mar 2022 01:27:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andi Kleen <ak@linux.intel.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] x86: fix return value of __setup handlers
Date:   Sun, 13 Mar 2022 18:27:25 -0700
Message-Id: <20220314012725.26661-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled. A return
of 0 causes the boot option/value to be listed as an Unknown kernel
parameter and added to init's (limited) argument (no '=') or environment
(with '=') strings. So return 1 from these x86 __setup handlers.

Examples:

  Unknown kernel command line parameters "apicpmtimer
    BOOT_IMAGE=/boot/bzImage-517rc8 vdso=1 ring3mwait=disable", will be
    passed to user space.

  Run /sbin/init as init process
   with arguments:
     /sbin/init
     apicpmtimer
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc8
     vdso=1
     ring3mwait=disable

Fixes: 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu")
Fixes: 77b52b4c5c66 ("x86: add "debugpat" boot option")
Fixes: e16fd002afe2 ("x86/cpufeature: Enable RING3MWAIT for Knights Landing")
Fixes: b8ce33590687 ("x86_64: convert to clock events")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/entry/vdso/vma.c   |    2 +-
 arch/x86/kernel/apic/apic.c |    2 +-
 arch/x86/kernel/cpu/intel.c |    2 +-
 arch/x86/mm/pat/memtype.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- lnx-517-rc8.orig/arch/x86/entry/vdso/vma.c
+++ lnx-517-rc8/arch/x86/entry/vdso/vma.c
@@ -438,7 +438,7 @@ bool arch_syscall_is_vdso_sigreturn(stru
 static __init int vdso_setup(char *s)
 {
 	vdso64_enabled = simple_strtoul(s, NULL, 0);
-	return 0;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
 
--- lnx-517-rc8.orig/arch/x86/mm/pat/memtype.c
+++ lnx-517-rc8/arch/x86/mm/pat/memtype.c
@@ -101,7 +101,7 @@ int pat_debug_enable;
 static int __init pat_debug_setup(char *str)
 {
 	pat_debug_enable = 1;
-	return 0;
+	return 1;
 }
 __setup("debugpat", pat_debug_setup);
 
--- lnx-517-rc8.orig/arch/x86/kernel/apic/apic.c
+++ lnx-517-rc8/arch/x86/kernel/apic/apic.c
@@ -170,7 +170,7 @@ static __init int setup_apicpmtimer(char
 {
 	apic_calibrate_pmtmr = 1;
 	notsc_setup(NULL);
-	return 0;
+	return 1;
 }
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
--- lnx-517-rc8.orig/arch/x86/kernel/cpu/intel.c
+++ lnx-517-rc8/arch/x86/kernel/cpu/intel.c
@@ -91,7 +91,7 @@ static bool ring3mwait_disabled __read_m
 static int __init ring3mwait_disable(char *__unused)
 {
 	ring3mwait_disabled = true;
-	return 0;
+	return 1;
 }
 __setup("ring3mwait=disable", ring3mwait_disable);
 
