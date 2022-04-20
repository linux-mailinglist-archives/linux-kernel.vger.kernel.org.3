Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8301F509254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382661AbiDTVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDTVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:49:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD73E5DE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:46:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f198b4e2d1so26926907b3.14
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=3TRcCUUaZ+b7tjFg88UNtO89FA4GsBVVD3ULOF8xuc0=;
        b=fNlEbCPYFY/2sKN0B+7mRjKWh9Vmc0mQaldUs5//VcDe8AKIWT3mEXRG2KmS10vL5m
         55EK4a6Y6SvHoEHe583jl1ltI7lA3lfGImFy/DQ2SKUpe8Irwm8RZBCCkLKpl4jwU2hE
         cQjtaRRrYRRRRGCWFwdlb4iNu1ZFs+3MDX+TOnItxhcue3RRUprY5La0mnX8uvo+dqjt
         2Mxx/8gIDsYenMuLbEfx/0MI476D/uSdF3vFghFSAOT/mzBSXqlZchMjcvwiSaJPI+yl
         685YmTacJ70CuTt+LNso67g/Cybklwhm0T5nrSbQ3W8Y2OVqVugGT8KvrofMeWv2RMV8
         OYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=3TRcCUUaZ+b7tjFg88UNtO89FA4GsBVVD3ULOF8xuc0=;
        b=w1xXIjJn5MqcOln49PANzSevP4i6hoiM1hXI20FVDkFUpNPLQ70q3fo9M2o9+Hz8Yg
         BB45tJMCIQEDHw7lYNx8MTVHkwMmxNaLmVPhj1/GUOatqDFZ6k+lEE6gLyDOh5cQ66bL
         jJcwxO9ekTxvP5ADgrA9932TyeCNB/Q13Kq6H5XFczgyX9g0WsXFDbSkdNddRdWZZi1U
         t7Ktoie3EqfouVqyB3z4YoYDNdXo4dlxgtNO9DJqwMJheaimv5FtuH/CiRMqWh2suH9s
         XHO/Bcr/YejxyuJqHmV2QYEXsH83fjCZnQXJv80iJyTZdWt1OTjN7N+DgUkLkRARDfuX
         RPuw==
X-Gm-Message-State: AOAM532y7EbpAosJ7wBbxWGWmEM9s500Yw9Su22Y6wlORYKqCsXbl+Kp
        mxoQQVOm6JxjOcPfrkELyOQTS236GkBta8P/gw==
X-Google-Smtp-Source: ABdhPJxyWCmldtrllRKLYN9yFrNAbR/NngkeHfsRFEFtVhkoioyyWhx2dJv29w6NEgLNecP0TQ8HxC5kcoFaJH7jLQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:70c:b0:645:58e:a3ac with SMTP
 id k12-20020a056902070c00b00645058ea3acmr17151653ybt.380.1650491210272; Wed,
 20 Apr 2022 14:46:50 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:57 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 6/6] KVM: arm64: Symbolize the nVHE HYP addresses
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
addresses using the %p print format specifier:

[   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v8:
  - Also ignore local symbols prefixed by '.L' in KVM nvhe namespace,
    per Marc

Changes in v6:
  - Add Fuad's Reviewed-by and Tested-by tags.
  
Changes in v2:
  - Fix printk warnings - %p expects (void *)


 arch/arm64/kvm/handle_exit.c | 13 +++++--------
 scripts/kallsyms.c           |  3 ++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 97fe14aab1a3..a377b871bf58 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -295,13 +295,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
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
@@ -321,9 +316,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
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
 
 	/*
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..e6906f79833d 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -111,7 +111,8 @@ static bool is_ignored_symbol(const char *name, char type)
 		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
-		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
+		"__kvm_nvhe_.L",	/* arm64 local symbols in non-VHE KVM namespace */
 		"__AArch64ADRPThunk_",	/* arm64 lld */
 		"__ARMV5PILongThunk_",	/* arm lld */
 		"__ARMV7PILongThunk_",
-- 
2.36.0.rc0.470.gd361397f0d-goog

