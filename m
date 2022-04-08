Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22C4F9DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiDHUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiDHUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:08:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6825353A99
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:06:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e4-20020a056902034400b00633691534d5so7521590ybs.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=YMe3PswfejdLgJcOM+IwePz8bwgUsFhWIzC+X7TRk74=;
        b=SDDZXBLIrGsW+et2Gk7b5lo7cEr1tJz/aR/cf3Ij4+ew35M0VT5KBR5KSGpmpjWNs0
         t//I6PG91dmLQ0L+GdOs4DwU1OMe/Yx/qSbV1k+7vZXFzx0QN0lXXF/ixYjhR6PWOIQr
         TC/ECs0qk7HJ+kjf1KaePs3tnhpyqqwGpVGAOFK7RDKhHd//d00+yQtTVz+GbcUMjapS
         AEH8oI4W4DR8MfAuz6MzB3DsLtsTCcGT4X1Nv3ztd4QU1eun1xaJ2Oc64ok+h3V7kGye
         tN1MF+NuBtLwdfT4tEm/Hj+1ZFpWvjHUKG96fLQaAeenDWrFjcYU8knrJIHYkDWJf2H9
         ufVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=YMe3PswfejdLgJcOM+IwePz8bwgUsFhWIzC+X7TRk74=;
        b=NO4KxP5gMFjPgZdC8sstjlfmbecFmRzoQwJs7H0nmoUzrg5hHYR1y8vxzTDgkmae4V
         MmPxvYCXIZg/Jhv++6ATIrdkrNq6MHrNK9uNzUbKnEIXWBryHrl5fmkWv2UjWU7MMIyt
         FWw8q7rsjFQN3SFB63hkW/tvl5O13gc6CQxtNTE+ZZTisHg/njeiCADHiwZbRGjUB0av
         GQSwTA3Bcj2qtAM+Gb96aVKpSSjbaEc9jL6yGS4atQuD9hsFldjXglDEmnuOlL9VnN13
         La8YytHg/J6wE5gFSiCT2glAnTuqZLdSgZcHr7VGUC39bM5yP17n2LQQ8T+TbW4DL5HL
         vG0w==
X-Gm-Message-State: AOAM531hATgxFSD39kglQxADwcZ8eUavlWHZZXhAJI8ydfXZTkUPW1wc
        qg5v7b+dOZQNG1NeJQ7U6/hINPSBofxYQHuSNg==
X-Google-Smtp-Source: ABdhPJz7Xbg+YMlZC29IRqjeFluZOMCZUAs3P4FohGI67MZiTVA+Oxev9PNRndMoOAcC1cQHGV4y5em9Xs6NahFteg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:9845:0:b0:628:99a6:55ed with SMTP
 id k5-20020a259845000000b0062899a655edmr15089978ybo.221.1649448406098; Fri,
 08 Apr 2022 13:06:46 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:29 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 6/6] KVM: arm64: Symbolize the nVHE HYP addresses
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
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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
addresses using the %p print format specifier:

[   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad's Reviewed-by and Tested-by tags.
  
Changes in v2:
  - Fix printk warnings - %p expects (void *)


 arch/arm64/kvm/handle_exit.c | 13 +++++--------
 scripts/kallsyms.c           |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

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
index 8caabddf817c..ad2c93640a92 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -111,7 +111,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
-		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
 		"__AArch64ADRPThunk_",	/* arm64 lld */
 		"__ARMV5PILongThunk_",	/* arm lld */
 		"__ARMV7PILongThunk_",
-- 
2.35.1.1178.g4f1659d476-goog

