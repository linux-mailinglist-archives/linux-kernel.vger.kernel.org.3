Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56D51A2EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbiEDPFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350502AbiEDPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:05:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A21929B;
        Wed,  4 May 2022 08:01:59 -0700 (PDT)
Date:   Wed, 04 May 2022 15:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651676517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8Sl1BJzx5VZlK5935vDmJX+/Vd3hQyvhjrYXeHfdtc=;
        b=XI5LfGtNHhobMsq08iRDRcopiZIq0bV5PO3S8CjsO6Xa1KS2iKoca0nIbvnjMGVZ8C1V9f
        6R3N1vUeY+1Bsw5p2LdrLcQPmCo5l1TF3MA8cdHWIKP2NeQixry65VriVsPwlHD7Oa/AUa
        uo0dYVffpOYMznFB32psdd8RGsprr+3zmD5KfvkQC3tANZCrXSAMKDrIeH3JvPLPxZEgtn
        /8FeIKGVQrctp5aBFovUgZsbM8XYCvz3jZptCkuIBlLK79Uu4t0Jso38+IjCQU3LVmRiu9
        cCxolY9hFyaqyndBd7jAgdeC0QOwZL1vDxMkZpG1DozPYWQjaVaRYXRn8+pHNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651676517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8Sl1BJzx5VZlK5935vDmJX+/Vd3hQyvhjrYXeHfdtc=;
        b=MS3Eq1DoyPJk9fTfQuH9TayUh7IM2+QztHjHOqksRKFhL4k93m9wFzh9vtDHjNO3H+T/e/
        yXRs0hRtSNr/SBAg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86: Fix return value of __setup handlers
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
References: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
MIME-Version: 1.0
Message-ID: <165167651582.4207.15476698597517980214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     12441ccdf5e2f5a01a46e344976cbbd3d46845c9
Gitweb:        https://git.kernel.org/tip/12441ccdf5e2f5a01a46e344976cbbd3d46845c9
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 13 Mar 2022 18:27:25 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 04 May 2022 16:47:57 +02:00

x86: Fix return value of __setup handlers

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
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Link: https://lore.kernel.org/r/20220314012725.26661-1-rdunlap@infradead.org
---
 arch/x86/entry/vdso/vma.c   | 2 +-
 arch/x86/kernel/apic/apic.c | 2 +-
 arch/x86/kernel/cpu/intel.c | 2 +-
 arch/x86/mm/pat/memtype.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a579..1000d45 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -438,7 +438,7 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 static __init int vdso_setup(char *s)
 {
 	vdso64_enabled = simple_strtoul(s, NULL, 0);
-	return 0;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344b..ed7d9cf 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -170,7 +170,7 @@ static __init int setup_apicpmtimer(char *s)
 {
 	apic_calibrate_pmtmr = 1;
 	notsc_setup(NULL);
-	return 0;
+	return 1;
 }
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43..350c247 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -91,7 +91,7 @@ static bool ring3mwait_disabled __read_mostly;
 static int __init ring3mwait_disable(char *__unused)
 {
 	ring3mwait_disabled = true;
-	return 0;
+	return 1;
 }
 __setup("ring3mwait=disable", ring3mwait_disable);
 
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 4ba2a3e..d5ef64d 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -101,7 +101,7 @@ int pat_debug_enable;
 static int __init pat_debug_setup(char *str)
 {
 	pat_debug_enable = 1;
-	return 0;
+	return 1;
 }
 __setup("debugpat", pat_debug_setup);
 
