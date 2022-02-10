Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032874B18C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbiBJWrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiBJWrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:47:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986EB5F46
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:47:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h6-20020a253a06000000b0061de83305f2so15006198yba.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=0KTIZ/BsAXUFEI2iaae3XhjiZCEBM5hWuzmqdk8v8UY=;
        b=ZHZcx5xA7EHUTHCEaadFyiIjhdIRYxHvTFae4ko0TI3GsIog1bV3SjKx1jRojQWUj9
         9YmFQDHXzEGOwzo0jbIx2p05gWQot0LfhQEneSFTIQDTsEvDEu3cbgpbhfSSiOKTck7B
         XnA5mt4AM4oFT952jp0wtfNf7wV5ozC6f4FRX17E75v7SVOIT6Qq311evP23Cd+WxpCL
         t4yqScsbIWIhUS/HOMp6RY2OVDmFmetiuTA2yxdyMmNDQyRHtrtm3pjz0CB+NKSsCK+K
         F7SOpuTg/HVJ5A4DPQFaIsMVgylVqHlTpMjmwpbi8GWIswYd63eFghrQb2JVt08OjyHt
         AohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=0KTIZ/BsAXUFEI2iaae3XhjiZCEBM5hWuzmqdk8v8UY=;
        b=HmJB2ERXclMiXKqPH6fLFIdLz1OkBawwkoRRiMvqrYPZhkfmRajklsbuFV2OPgBKm7
         CRf1ub7n0YYHuB0FRJfAnXpGDCcW8WfMye7exJJwiEUqkbuj5Oil+P4q6ljiS6UzD1SM
         M7dba0alLnonrCkjQj9NLxYmLJHmeSedhceIe/ZBBkEnI7nIpuvsX2AUPd8UCrcU3aVI
         /POQTyTz8kbUA4V8whhzghoNcsTtwnuBHNYo0SMmpk+qj2+RBtNywpGov782qiTsHuPV
         2S0SJLGAPYRHtTpmbUAZsbEkQVWxNMS5/DKv9IO4O+9Klp+d/9BEwaGvb9cz65nkjn0R
         zXIg==
X-Gm-Message-State: AOAM533SmH3EiGmi/Me4pYOdYONVzBq9ZMACfS8ivIzyBD5o6G6Kln4n
        XIchY/Rddl1PkLSfwOx/1kWpu8RIpeTcjVtDIg==
X-Google-Smtp-Source: ABdhPJw5p/Uh7hAVUUQUoiuUOWMwTt8ZLF4sqcEFxLAvSzIjy7oy/SoNwO/Prk3wKZ7puGZ6SI+A+MoEUcuHAzw3bA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a81:b650:: with SMTP id
 h16mr9312369ywk.238.1644533233863; Thu, 10 Feb 2022 14:47:13 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:48 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 7/7] KVM: arm64: Symbolize the nVHE HYP backtrace
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
 arch/arm64/kvm/handle_exit.c | 11 +++--------
 arch/arm64/kvm/stacktrace.c  |  2 +-
 scripts/kallsyms.c           |  2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index b038c32a3236..d7f0f295aebf 100644
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
@@ -322,9 +317,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		if (file)
 			kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
 		else
-			kvm_err("nVHE hyp BUG at: %016llx!\n", elr_virt + hyp_offset);
+			kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr, panic_addr);
 	} else {
-		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
+		kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr, panic_addr);
 	}
 
 	hyp_dump_backtrace(hyp_offset);
diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
index 3990a616ab66..4d12ffee9cc6 100644
--- a/arch/arm64/kvm/stacktrace.c
+++ b/arch/arm64/kvm/stacktrace.c
@@ -261,7 +261,7 @@ static void hyp_dump_backtrace_entry(unsigned long hyp_pc, unsigned long hyp_off
 	hyp_pc &= va_mask;
 	hyp_pc += hyp_offset;
 
-	kvm_err(" [<%016llx>]\n", hyp_pc);
+	kvm_err("[<%016llx>] %pB\n", hyp_pc, hyp_pc);
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
2.35.1.265.g69c8d7142f-goog

