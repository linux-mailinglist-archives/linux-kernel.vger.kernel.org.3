Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2FC534671
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiEYW0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbiEYW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:26:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3326EA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so188482977b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sP4pft3yTMhXYmyTAUA9SDM5ympNXK0fw2aWJc3LaWM=;
        b=nt8xIxammCWBKmuZkiAyG5Rfz8Wi+6snvbgkikf7esrJCQZz6kOdx+Day2vV2sO0s0
         Cdb9tCPtVcRNZKt9tqyi+H5WzmOtP9vbdXPm2NDP6a8FFSA/gHxOYDC2wY6a9+Htd0e8
         WG676KXqy6xskD362nmb8T+9mg3JeTqIe8sFrphUxixgMSIHs3djCBOpnx8fwJyY6dx/
         6cZpOzp9DAkrASVkngVbSfTtsygFC8F1gfailABOosvp7tpqSETO9M9PnMf2HyPGPb5E
         n4lzS3Q2DZJVTrUKbsyaZx/8wt3mfVyuMnZ1aemACgJSNb4mb3/SmPfPwnY/YRvAl9/E
         no5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sP4pft3yTMhXYmyTAUA9SDM5ympNXK0fw2aWJc3LaWM=;
        b=ZncLOwk6lw5hEAZ7RjzhdztI6EyJPZ61w7zyNOV8VLkl0Ws+tAey58vX5KXHT4SQ44
         J39LOhRIGtdJQUOcX+5SppaehzaEfNALNqy5mLbFTSv+rMf9oREzmAUcAio757N2S9BH
         f3HtbhR5KJo8p0rUXwuq1pGnrvNKh9cTqoju6TEKRSRVjznS7VabU0rP7mKM+XVTqhW9
         6oqlvZKsHddkdlngzi3AmaLewVYMRGFMG1lIafvjhpdoVd7bDF73OfluNZIIgB6epl/Q
         X2JapEwnHsE7zhfSoIpk+W0n6ffJoGlbvKV5ysEW7uaqAYJ97oICXqnj0/oG9STy2KYN
         mmOg==
X-Gm-Message-State: AOAM5336I6Jq4MOs2Zf9z2dyxgQ7J272cYfU34p0+QIVdIxYR0Y3l2dv
        nwmR7XvADVEr5yofUEUjytTJtLryDek=
X-Google-Smtp-Source: ABdhPJyJ4tmdcPftxWFkmif8ejJIr/nQV0DAemlOUfspDQk7AN8fRlvb33qyuKNBkQq4K+vySs4+bJ4qE7Q=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:cb17:0:b0:64f:5939:533 with SMTP id
 b23-20020a25cb17000000b0064f59390533mr27804829ybg.105.1653517575274; Wed, 25
 May 2022 15:26:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 25 May 2022 22:26:04 +0000
In-Reply-To: <20220525222604.2810054-1-seanjc@google.com>
Message-Id: <20220525222604.2810054-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220525222604.2810054-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 4/4] KVM: x86: Use 16-bit fields to track dirty/valid emulator GPRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a u16 instead of a u32 to track the dirty/valid status of GPRs in the
emulator.  Unlike struct kvm_vcpu_arch, x86_emulate_ctxt tracks only the
"true" GPRs, i.e. doesn't include RIP in its array, and so only needs to
track 16 registers.

Note, having 16 GPRs is a fundamental property of x86-64 and will not
change barring a massive architecture update.  Legacy x86 ModRM and SIB
encodings use 3 bits for GPRs, i.e. support 8 registers.  x86-64 uses a
single bit in the REX prefix for each possible reference type to double
the number of supported GPRs to 16 registers (4 bits).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c     | 3 +++
 arch/x86/kvm/kvm_emulate.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd1bf116a9ed..afb115b6a5a4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -262,6 +262,9 @@ static ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	if (WARN_ON_ONCE(nr >= NR_EMULATOR_GPRS))
 		nr &= NR_EMULATOR_GPRS - 1;
 
+	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+
 	ctxt->regs_valid |= 1 << nr;
 	ctxt->regs_dirty |= 1 << nr;
 	return &ctxt->_regs[nr];
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index bdd4e9865ca9..fbe87ba78163 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -353,9 +353,9 @@ struct x86_emulate_ctxt {
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
-	u32 regs_valid;
+	u16 regs_valid;
 	/* bitmaps of registers in _regs[] that have been written */
-	u32 regs_dirty;
+	u16 regs_dirty;
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
-- 
2.36.1.124.g0e6072fb45-goog

