Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890FB4E3315
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiCUWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiCUWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:49:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804C33FB916
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:44:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso257354pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EY82t1wI0UkhgCIBG4tN+ElVzer0/ZPSO68cRK6+QHY=;
        b=bNAahe1AAw7nZrPbGPotsZ/9/5r2zqHzBYhxHca6ivEJcUpuhqmFvNbmKDfd1tPTOM
         NI8G62wJgoX+kIscR2ym13RiegPhmok71V4VyqR+YctTQFiufY3VzK4VALG/y8wK8cMe
         WCrCTt+La2ab+rXba+2kEO1/pMcsy0ZTqgxhUSQbMH9vlJQFCLJK1HCHvIur8Lv6SK2l
         N+Dm+Zam3ieoxiw6otCrzHOy+11V4FoJOIKIdZ1Y/Qr/2OmpRB2cRqO8jSScT5uoMD0+
         EYofeXONg33NLaCJb8A/IKFXBtkIgV/GPolpdGNxJP+XDnw0KyAQPZFLaWc37Okehn8b
         G1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EY82t1wI0UkhgCIBG4tN+ElVzer0/ZPSO68cRK6+QHY=;
        b=MioJTwyycSpl/hT5D2C3H3RuHhDt6oO9i7mvPL1++EJgquAfbfiXMQJ9Bo1HUPlQb4
         10wsuWizfxE9qGri9b/bVoxMkwry+Qk2CreI633SZJyRhsse9wH23aj588kGFo+nRcFb
         pOHzNGYE+LBOJ/n5Ee5Z+R2ZR8R/P4imWkx2YayhrMpB8e1YzUISA4E9gz89LJ+vUkJR
         0cT78HFV8thh54op64uF13eY6OqCmeVyiuPCrlu6nkPw8xs80FnSoxhBL5taikVaXlqZ
         9BiE6bar4IdIqGTyDcEemqohDIbK1atwxCQXv2s9CvqgucE1ZUJy/QQIDu3zwKxkPbFz
         Syvg==
X-Gm-Message-State: AOAM532zfqnSEhIgd12+ApevxjBytzddfE0/msKYg2MYSNWzhPctcKGh
        Sv4mQPka4m5erDCcH8/+tZPBxMcbDdl+9AEnTYXRb4s8XMe69vydM8k9UKJXWEZGA+UvAMKn0Sf
        70h9wLQh9nLl8k11UbmOwHlgDV8NzpBBSXI28sQ6kYv+5Y8lomACT9bbUyNCxNitP+2EZ5TUL
X-Google-Smtp-Source: ABdhPJym2hQm7vVkuMwMNLG3NwQtfGOTVM/0doXvdsomWSxSvSrvQt2pIWF3trMKjA3TrOJig60VFP+3m825
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b76a:f152:cb5e:5cd2])
 (user=bgardon job=sendgmr) by 2002:aa7:8889:0:b0:4f7:7283:e378 with SMTP id
 z9-20020aa78889000000b004f77283e378mr25972668pfe.36.1647902656923; Mon, 21
 Mar 2022 15:44:16 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:43:55 -0700
In-Reply-To: <20220321224358.1305530-1-bgardon@google.com>
Message-Id: <20220321224358.1305530-7-bgardon@google.com>
Mime-Version: 1.0
References: <20220321224358.1305530-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2 6/9] KVM: x86/mmu: Factor out part of vmx_get_mt_mask which
 does not depend on vcpu
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

Factor out the parts of vmx_get_mt_mask which do not depend on the vCPU
argument. This also requires adding some error reporting to the helper
function to say whether it was possible to generate the MT mask without
a vCPU argument. This refactoring will allow the MT mask to be computed
when noncoherent DMA is not enabled on a VM.

No functional change intended.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e8963f5af618..69c654567475 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7149,9 +7149,26 @@ static int __init vmx_check_processor_compat(void)
 	return 0;
 }
 
+static bool vmx_try_get_mt_mask(struct kvm *kvm, gfn_t gfn,
+				bool is_mmio, u64 *mask)
+{
+	if (is_mmio) {
+		*mask =  MTRR_TYPE_UNCACHABLE << VMX_EPT_MT_EPTE_SHIFT;
+		return true;
+	}
+
+	if (!kvm_arch_has_noncoherent_dma(kvm)) {
+		*mask = (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
+		return true;
+	}
+
+	return false;
+}
+
 static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	u8 cache;
+	u64 mask;
 
 	/* We wanted to honor guest CD/MTRR/PAT, but doing so could result in
 	 * memory aliases with conflicting memory types and sometimes MCEs.
@@ -7171,11 +7188,8 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	 * EPT memory type is used to emulate guest CD/MTRR.
 	 */
 
-	if (is_mmio)
-		return MTRR_TYPE_UNCACHABLE << VMX_EPT_MT_EPTE_SHIFT;
-
-	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
-		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
+	if (vmx_try_get_mt_mask(vcpu->kvm, gfn, is_mmio, &mask))
+		return mask;
 
 	if (kvm_read_cr0(vcpu) & X86_CR0_CD) {
 		if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
-- 
2.35.1.894.gb6a874cedc-goog

