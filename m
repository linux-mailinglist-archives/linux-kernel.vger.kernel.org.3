Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576934BFF97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiBVRDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiBVRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:03:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4650E0D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:02:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k10-20020a056902070a00b0062469b00335so9019428ybt.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=beGtXg45IQ4dKCY/A8ewT2jAssjG8oCd/wil2F8VoF8=;
        b=Qmw8f9ngENw67mW7ZY926jso9fM6FSWsadBt2xuNCmEM/wL9yNNx+++6QAzW5Geysa
         X0CVpzvJkNzo1xClPSFGBfQoQ9e82eUu5kgF0cfza/NxsGQMydRbfBIhqKkBzLs5aCzK
         VBY/ce5OQiMkErnhinkSoy35Z7xGC9tfoOBy0pVxgyAmPZog1qhtESjBaWlKEIEeimgX
         bKnw6hLvfmjhuk5Ps7Kiuf9lL11CkBXEiVCRXEz1k0Pj8iOLK68P3f2mF/3G5iD/5IP2
         26qsHRaykVbWjx15kawdg3HR402vdDmc9IFBtIz1CQ/1k/qSnS4QDbrQcuG21X7huvEk
         B9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=beGtXg45IQ4dKCY/A8ewT2jAssjG8oCd/wil2F8VoF8=;
        b=RFVbxtaBYfZoXwGCu/XOp2pHpM3T74HwS4lqmwC4talSVmUxJRCibMIwfnDN04DD+8
         R0TgiASd3W3/irVB3/7Plngd/edvlalaZSKxn5O6YKC9XVNIiZygmQuOY40Wl7sSq4u7
         zIWADkH5tyWE0Rkp1lhoL/CPKgOgTjsW4cjzUd6wTK0umC4ttzceWF9pBx5RthiWfka7
         ye6cOX7I5dQTpDnnrT9kEc25iVVFpLxxrbjh44OEIm0u+1NnqBIzV6W16WNliBoNNC2b
         oQYQVd4R92fEOt9u9yw0FzjmALejxXLWtIU996qdmtjxIRWlbdqFbyadmYigARtyxVyF
         /O7w==
X-Gm-Message-State: AOAM532XY2Nt5ybdPGK8bH2eR5V+++tzeFiUtJn1OYT1ZKkIpATp28b1
        CdVitTrBh+lGVIJtDkF5VggFO9kxLQM2ibz00Q==
X-Google-Smtp-Source: ABdhPJx9ya/dSuGbtyc2Drwg2dL1gTZ3RclR9peZ4NgVIVWBnHY+dyxNePng3kg7EOauiAGLQaMx/zndC7RygsTqtw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d60c:0:b0:610:dc8d:b3bd with SMTP
 id n12-20020a25d60c000000b00610dc8db3bdmr24399063ybg.561.1645549369167; Tue,
 22 Feb 2022 09:02:49 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:10 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-10-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 9/9] KVM: arm64: Symbolize the nVHE HYP backtrace
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reintroduce the __kvm_nvhe_ symbols in kallsyms, ignoring the local
symbols in this namespace. The local symbols are not informative and
can cause aliasing issues when symbolizing the addresses.

With the necessary symbols now in kallsyms we can symbolize nVHE
stacktrace addresses using the %pB print format specifier.

Some sample call traces:

-------
[  167.018598][  T407] kvm [407]: nVHE hyp panic at: [<ffffffc0116145cc>] __kvm_nvhe_overflow_stack+0x10/0x34!
[  167.020841][  T407] kvm [407]: nVHE HYP call trace:
[  167.021371][  T407] kvm [407]: [<ffffffc011614934>] __kvm_nvhe_hyp_panic_bad_stack+0xc/0x10
[  167.021972][  T407] kvm [407]: [<ffffffc01160fa48>] __kvm_nvhe___kvm_hyp_host_vector+0x248/0x794
[  167.022572][  T407] kvm [407]: [<ffffffc0116145dc>] __kvm_nvhe_overflow_stack+0x20/0x34
[  167.023135][  T407] kvm [407]: [<ffffffc0116145dc>] __kvm_nvhe_overflow_stack+0x20/0x34
[  167.023699][  T407] kvm [407]: [<ffffffc0116145dc>] __kvm_nvhe_overflow_stack+0x20/0x34
[  167.024261][  T407] kvm [407]: [<ffffffc0116145dc>] __kvm_nvhe_overflow_stack+0x20/0x34
. . .

-------
[  166.161699][  T409] kvm [409]: Invalid host exception to nVHE hyp!
[  166.163789][  T409] kvm [409]: nVHE HYP call trace:
[  166.164709][  T409] kvm [409]: [<ffffffc011614fa0>] __kvm_nvhe_handle___kvm_vcpu_run+0x198/0x21c
[  166.165352][  T409] kvm [409]: [<ffffffc011614980>] __kvm_nvhe_handle_trap+0xa4/0x124
[  166.165911][  T409] kvm [409]: [<ffffffc01160f060>] __kvm_nvhe___host_exit+0x60/0x64
[  166.166657][  T409] Kernel panic - not syncing: HYP panic:
. . .
-------

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Fix printk warnings - %p expects (void *)

 arch/arm64/kvm/handle_exit.c | 13 +++++--------
 arch/arm64/kvm/stacktrace.c  |  2 +-
 scripts/kallsyms.c           |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index b038c32a3236..1b953005d301 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -296,13 +296,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 	u64 elr_in_kimg = __phys_to_kimg(elr_phys);
 	u64 hyp_offset = elr_in_kimg - kaslr_offset() - elr_virt;
 	u64 mode = spsr & PSR_MODE_MASK;
+	u64 panic_addr = elr_virt + hyp_offset;
 
-	/*
-	 * The nVHE hyp symbols are not included by kallsyms to avoid issues
-	 * with aliasing. That means that the symbols cannot be printed with the
-	 * "%pS" format specifier, so fall back to the vmlinux address if
-	 * there's no better option.
-	 */
 	if (mode != PSR_MODE_EL2t && mode != PSR_MODE_EL2h) {
 		kvm_err("Invalid host exception to nVHE hyp!\n");
 	} else if (ESR_ELx_EC(esr) == ESR_ELx_EC_BRK64 &&
@@ -322,9 +317,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		if (file)
 			kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
 		else
-			kvm_err("nVHE hyp BUG at: %016llx!\n", elr_virt + hyp_offset);
+			kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
+					(void *)panic_addr);
 	} else {
-		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
+		kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
+				(void *)panic_addr);
 	}
 
 	hyp_dump_backtrace(hyp_offset);
diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
index cdd672bf0ea8..896c225a4a89 100644
--- a/arch/arm64/kvm/stacktrace.c
+++ b/arch/arm64/kvm/stacktrace.c
@@ -261,7 +261,7 @@ static void hyp_dump_backtrace_entry(unsigned long hyp_pc, unsigned long hyp_off
 	hyp_pc &= va_mask;	/* Mask tags */
 	hyp_pc += hyp_offset;
 
-	kvm_err("[<%016lx>]\n", hyp_pc);
+	kvm_err("[<%016lx>] %pB\n", hyp_pc, (void *)hyp_pc);
 }
 
 void hyp_dump_backtrace(unsigned long hyp_offset)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 54ad86d13784..19aba43d9da4 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -111,7 +111,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		".LASANPC",		/* s390 kasan local symbols */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
-		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
 		"__AArch64ADRPThunk_",	/* arm64 lld */
 		"__ARMV5PILongThunk_",	/* arm lld */
 		"__ARMV7PILongThunk_",
-- 
2.35.1.473.g83b2b277ed-goog

