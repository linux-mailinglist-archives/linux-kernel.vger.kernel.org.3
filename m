Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5824A54A262
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbiFMW6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbiFMW5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:57:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537125CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:57:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c11-20020a17090a4d0b00b001e4e081d525so7040508pjg.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=RHYcnFXTT7ac0ob6di8kcCxjr6TYxAsCityKr+RTKLI=;
        b=Ht+WkXrzNY4aCQJpUyHeoWPWNTBiTlUW3Lagepr4HbSdxEqbjS+ssk0l8Zamu5d1SR
         jjMxcznKpxbilodFMTbwrpKMcGsDf3SN15/AHVZrOIWYxZNkjMDYM5vYWcYW5iomnR8d
         ENCPPz0daRuFtW9s37PyTlx1y5/jAYunRaYufcaL3bKBWOyjrRQ6YKofuf8OAdaElQYX
         6fyug2OPvXy5nnN8B/AfFA82ZAlHIVmrpOqVheuMEB1MgTqPNrSqJqoWpEvMLy5hICph
         MwWuJkEmgQzcxqCKlGF9srg9wvaxtk8Pa4iWY14QwGls9+deEB7KJO5apyO8sxQyixMG
         IxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=RHYcnFXTT7ac0ob6di8kcCxjr6TYxAsCityKr+RTKLI=;
        b=d1eTzLE6waFMStwrj2mIRGJ4huxv7MxpDtSVHFlqrU4cm/XGloUe0Xc9E1D96KNgEE
         S0/i1DbElrl2Tlu2YsZAbyN9xh85bwkdIX4QWzkXqOhM+aN7rARuHfjMaZFw4GlotJAz
         +XrjBRl0Qruz2poHElA6t20pzWlPfsKm6Yhr0H3gOMPgLXcU8NAYHbcozU00yvEAuXEB
         TtXKTXV4qQjWuhhOOwO0Mj429ldr5lAUH6TSbA/1R7W/jicjdSPOcqcMf2OKV+cUVDPN
         Wl4xcaQ1N7aOFCy2AvrAi9ZkaNEN/I/WD0vDr0hiRkN+OapewZ2Sxj4Tlkg0e/gHd2sd
         yLjw==
X-Gm-Message-State: AJIora+x1AJ5GZw4zLq7pIq4HGM+A4bwzUyd47s3FU3l78EYE3Ufg306
        iDmoDVB+Aej/ysGtyBn4MNF242paNag=
X-Google-Smtp-Source: AGRyM1usL/eeVClnixov12j9knTnRvi5pIAGqLnemUdbfR1Ufy3iDbbtQEYUfhjil6JScKSo4HiKr6s8g5Q=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id
 z1-20020a17090a66c100b001e843aef7c0mr1054309pjl.245.1655161059904; Mon, 13
 Jun 2022 15:57:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 13 Jun 2022 22:57:23 +0000
In-Reply-To: <20220613225723.2734132-1-seanjc@google.com>
Message-Id: <20220613225723.2734132-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220613225723.2734132-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 8/8] KVM: x86/mmu: Use common logic for computing the
 32/64-bit base PA mask
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common logic for computing PT_BASE_ADDR_MASK for 32-bit, 64-bit, and
EPT paging.  Both PAGE_MASK and the new-common logic are supsersets of
what is actually needed for 32-bit paging.  PAGE_MASK sets bits 63:12 and
the former GUEST_PT64_BASE_ADDR_MASK sets bits 51:12, so regardless of
which value is used, the result will always be bits 31:12.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 2 --
 arch/x86/kvm/mmu/paging.h      | 9 ---------
 arch/x86/kvm/mmu/paging_tmpl.h | 4 +---
 3 files changed, 1 insertion(+), 14 deletions(-)
 delete mode 100644 arch/x86/kvm/mmu/paging.h

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aedb8d871030..0f0c3ebfcf51 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -53,8 +53,6 @@
 #include <asm/kvm_page_track.h>
 #include "trace.h"
 
-#include "paging.h"
-
 extern bool itlb_multihit_kvm_mitigation;
 
 int __read_mostly nx_huge_pages = -1;
diff --git a/arch/x86/kvm/mmu/paging.h b/arch/x86/kvm/mmu/paging.h
deleted file mode 100644
index 9de4976b2d46..000000000000
--- a/arch/x86/kvm/mmu/paging.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Shadow paging constants/helpers that don't need to be #undef'd. */
-#ifndef __KVM_X86_PAGING_H
-#define __KVM_X86_PAGING_H
-
-#define GUEST_PT64_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
-
-#endif /* __KVM_X86_PAGING_H */
-
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 4087e58e2232..1f0dbc31e5d4 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -25,7 +25,6 @@
 	#define pt_element_t u64
 	#define guest_walker guest_walker64
 	#define FNAME(name) paging##64_##name
-	#define PT_BASE_ADDR_MASK GUEST_PT64_BASE_ADDR_MASK
 	#define PT_LEVEL_BITS 9
 	#define PT_GUEST_DIRTY_SHIFT PT_DIRTY_SHIFT
 	#define PT_GUEST_ACCESSED_SHIFT PT_ACCESSED_SHIFT
@@ -39,7 +38,6 @@
 	#define pt_element_t u32
 	#define guest_walker guest_walker32
 	#define FNAME(name) paging##32_##name
-	#define PT_BASE_ADDR_MASK ((pt_element_t)PAGE_MASK)
 	#define PT_LEVEL_BITS PT32_LEVEL_BITS
 	#define PT_MAX_FULL_LEVELS 2
 	#define PT_GUEST_DIRTY_SHIFT PT_DIRTY_SHIFT
@@ -55,7 +53,6 @@
 	#define pt_element_t u64
 	#define guest_walker guest_walkerEPT
 	#define FNAME(name) ept_##name
-	#define PT_BASE_ADDR_MASK GUEST_PT64_BASE_ADDR_MASK
 	#define PT_LEVEL_BITS 9
 	#define PT_GUEST_DIRTY_SHIFT 9
 	#define PT_GUEST_ACCESSED_SHIFT 8
@@ -66,6 +63,7 @@
 #endif
 
 /* Common logic, but per-type values.  These also need to be undefined. */
+#define PT_BASE_ADDR_MASK	((pt_element_t)(((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1)))
 #define PT_LVL_ADDR_MASK(lvl)	__PT_LVL_ADDR_MASK(PT_BASE_ADDR_MASK, lvl, PT_LEVEL_BITS)
 #define PT_LVL_OFFSET_MASK(lvl)	__PT_LVL_OFFSET_MASK(PT_BASE_ADDR_MASK, lvl, PT_LEVEL_BITS)
 #define PT_INDEX(addr, lvl)	__PT_INDEX(addr, lvl, PT_LEVEL_BITS)
-- 
2.36.1.476.g0c4daa206d-goog

