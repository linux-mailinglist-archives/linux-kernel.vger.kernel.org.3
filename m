Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5930C589412
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiHCVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:34:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B921836E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:34:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5d66fcdeso154333667b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to:from:to:cc;
        bh=/SazQC2lwPXWcyhPy93J/BX93HGTzHZlI/PMEmhHeKA=;
        b=nKj3SNxld0SvUkkGS94WfdONp5zq74TBRgFMmLrWm4kpy09fUZq/IKC9yvkYEZbptr
         rEjZlCZwwknldtID668wvoBflLHgxI2yESaGDmyCgzVm5jKUB3xaOAzGAagrWXTsk1Ty
         j/1v116+v355LbJxYdLafbrh2bRT0K/vO+/23JND/7dAz19Jf9/yHOzsIlHDylWes5yG
         b7zvIbjIYFwzTxVh147laHOnyeUHvgAMcTQXS8f82XSUqi2b6TU8dPL6aieKd4BWGyjd
         yXGOVbcV9Bj7Zls99MVWzL7hduXICydMPl7AzTCcdqCpC2AdxlArIlAB98oWcoptc7TV
         XEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=/SazQC2lwPXWcyhPy93J/BX93HGTzHZlI/PMEmhHeKA=;
        b=Ck2M63VpPqtGEz6JiShxtNJYbB/Gs+G0hbBRTiygKxZ8UTO/6oDj++FDXTvj42AlK5
         1XnCuK74/L7qtsgbiL/eWVOATyxUPKyiWRx7cfOS3Io7nyxsfq5GPm41LHoKgtnaUu2O
         uxCUfgAe+F2ftugkUv4IgUR81+U12T96PhSwzVQ9+Rq6ZVMdLscQA/vLDYoWxzDOV/g/
         UkVQ/vm6YHSq5GkmyoShoa1bZNGeCdohFDASk6ZI2NHzJmNVUv4Knh/mLIcBWr15WjBq
         kyQ5rzW8G2Ivs/nxhfMvGKlvWe8AwM0S9sLpOZqokeDDMLWcRivpaI52kea76P5FRR7d
         WBSQ==
X-Gm-Message-State: ACgBeo0w9Nhz3UinbEFPflI6Av0NnwSMUy+CXnIuGoToGMBHVkT6Gqc7
        vDXXIM5SEOtJqQ1f0VSg81SbsPdaKGE=
X-Google-Smtp-Source: AA6agR4tx/Sn1l4PCVobPXR3TR9jhFKwgJC4ETWYlOi5rQ9ns65Yr7A+Vy+4i35+4MZQQSQXSitkrd5uR6I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c00d:0:b0:677:4093:892b with SMTP id
 c13-20020a25c00d000000b006774093892bmr13332791ybf.328.1659562439652; Wed, 03
 Aug 2022 14:33:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 21:33:54 +0000
Message-Id: <20220803213354.951376-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] KVM: x86/mmu: Add sanity check that MMIO SPTE mask doesn't
 overlap gen
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compile-time and init-time sanity checks to ensure that the MMIO SPTE
mask doesn't overlap the MMIO SPTE generation.  The generation currently
avoids using bit 63, but that's as much coincidence as it is strictly
necessarly.  That will change in the future, as TDX support will require
setting bit 63 (SUPPRESS_VE) in the mask.  Explicitly carve out the bits
that are allowed in the mask so that any future shuffling of SPTE MMIO
bits doesn't silently break MMIO caching.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 8 ++++++++
 arch/x86/kvm/mmu/spte.h | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 7314d27d57a4..08e8c46f3037 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -343,6 +343,14 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask)
 	if (!enable_mmio_caching)
 		mmio_value = 0;
 
+	/*
+	 * The mask must contain only bits that are carved out specifically for
+	 * the MMIO SPTE mask, e.g. to ensure there's no overlap with the MMIO
+	 * generation.
+	 */
+	if (WARN_ON(mmio_mask & ~SPTE_MMIO_ALLOWED_MASK))
+		mmio_value = 0;
+
 	/*
 	 * Disable MMIO caching if the MMIO value collides with the bits that
 	 * are used to hold the relocated GFN when the L1TF mitigation is
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index cabe3fbb4f39..6cd3936cbe1f 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -125,6 +125,15 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
 static_assert(!(SPTE_MMU_PRESENT_MASK &
 		(MMIO_SPTE_GEN_LOW_MASK | MMIO_SPTE_GEN_HIGH_MASK)));
 
+/*
+ * The SPTE MMIO mask is allowed to use "present" bits (i.e. all EPT RWX bits),
+ * all physical address bits (additional checks ensure the mask doesn't overlap
+ * legal PA bits), and bit 63 (carved out for future usage, e.g. SUPPRESS_VE).
+ */
+#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | GENMASK_ULL(2, 0))
+static_assert(!(SPTE_MMIO_ALLOWED_MASK &
+		(MMIO_SPTE_GEN_LOW_MASK | MMIO_SPTE_GEN_HIGH_MASK)));
+
 #define MMIO_SPTE_GEN_LOW_BITS		(MMIO_SPTE_GEN_LOW_END - MMIO_SPTE_GEN_LOW_START + 1)
 #define MMIO_SPTE_GEN_HIGH_BITS		(MMIO_SPTE_GEN_HIGH_END - MMIO_SPTE_GEN_HIGH_START + 1)
 

base-commit: 93472b79715378a2386598d6632c654a2223267b
-- 
2.37.1.559.g78731f0fdb-goog

