Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C505A71C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiH3XUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiH3XTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:19:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE597B2B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:17:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u14-20020a170902e5ce00b00174b2ad8435so5042620plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=7hcgE+3kLvfteqMqTOqZFsuXwWUwlLmJNQ6fU1SyGZw=;
        b=b4dE2Vhv8nSNaxaXbjIEuN3T/poWlkjAUIEj1Rn0G0mxHCgj31H/wQBsHtIi/ucSk5
         +fT9aNMFDIHFrTu//xQUfLvzdlwSRAzu0gFKUvGXYlBqUXZAOydYBSRjtQ4KCuNc5Fi0
         UHvFcgeF34kgihUR6V0l85BEW05UIJ2nK/qP2pQzrT5pVeH2HUJLck5vdwpM/DiOwpNe
         H1UVd5MYfva+oWp0yeeJMD/A/p1MP0hhu4MHWXwYVsDXjqe/9Elc/0qgYoD7vD5+qP5b
         5wQ6t7ph6ADB/GmzSsa3GhioYEIfKp+5biRXYxcYnC6KxPLpvrygRtCMNMMnin/x48Cb
         m+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=7hcgE+3kLvfteqMqTOqZFsuXwWUwlLmJNQ6fU1SyGZw=;
        b=DrNIviFV6K2DeIPQu+x7CgiiN09CmBfnEbzCtzVqDWDyzOIPnazrj9orNceVNc+ES8
         is38X/EqHjRQQ9+17kCMwz9Qs1z99fp/hbSvX/j6M7D4J7yMxCfyUx3ebsFDrMocb3Nr
         8k7Im9Sx9uMiI1AXTDLvpVve/06yfxO/hEZ58JMRmF+ql1lF4p4/gR8S5rHLN4uPjJMK
         fdD7GbvrgIc8luG7A9wrYZNRcz015cFTzmy6M4N7qXuJUME7jYQ0Qnv0Z0PfXkIzvU3j
         YQxj4HTm1jKpVQrPcwiqZTLd8/G9xcCwXKNgobVY0i3iNroUw07HrVCXA/bZ2v9rzhkT
         PgCQ==
X-Gm-Message-State: ACgBeo0y6BjlUtzdpy69wqpDmvkCOthaJhHgwfhwUB4nWCzSo7GNq3Gg
        GmR+dycJ9L63GKpoZYimiL2xODhCEt8=
X-Google-Smtp-Source: AA6agR7YO3t+S1zeEHDnbWyLng/WBHSvcO1sLUs4OX3LjmLgIOmsdJV/rf7DFe/k7o6NdHgNrfQf5Iw3a1Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6808:b0:174:617b:1147 with SMTP id
 h8-20020a170902680800b00174617b1147mr19028713plk.102.1661901422175; Tue, 30
 Aug 2022 16:17:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:16:14 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-28-seanjc@google.com>
Subject: [PATCH v5 27/27] KVM: x86: Allow force_emulation_prefix to be written
 without a reload
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Allow force_emulation_prefix to be written by privileged userspace
without reloading KVM.  The param does not have any persistent affects
and is trivial to snapshot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 45f295d35cc9..329998e9ee7a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
  */
 #define KVM_FEP_CLEAR_RFLAGS_RF	BIT(1)
 static int __read_mostly force_emulation_prefix;
-module_param(force_emulation_prefix, int, 0444);
+module_param(force_emulation_prefix, int, 0644);
 
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
@@ -7287,6 +7287,7 @@ static int kvm_can_emulate_insn(struct kvm_vcpu *vcpu, int emul_type,
 int handle_ud(struct kvm_vcpu *vcpu)
 {
 	static const char kvm_emulate_prefix[] = { __KVM_EMULATE_PREFIX };
+	int fep_flags = READ_ONCE(force_emulation_prefix);
 	int emul_type = EMULTYPE_TRAP_UD;
 	char sig[5]; /* ud2; .ascii "kvm" */
 	struct x86_exception e;
@@ -7294,11 +7295,11 @@ int handle_ud(struct kvm_vcpu *vcpu)
 	if (unlikely(!kvm_can_emulate_insn(vcpu, emul_type, NULL, 0)))
 		return 1;
 
-	if (force_emulation_prefix &&
+	if (fep_flags &&
 	    kvm_read_guest_virt(vcpu, kvm_get_linear_rip(vcpu),
 				sig, sizeof(sig), &e) == 0 &&
 	    memcmp(sig, kvm_emulate_prefix, sizeof(sig)) == 0) {
-		if (force_emulation_prefix & KVM_FEP_CLEAR_RFLAGS_RF)
+		if (fep_flags & KVM_FEP_CLEAR_RFLAGS_RF)
 			kvm_set_rflags(vcpu, kvm_get_rflags(vcpu) & ~X86_EFLAGS_RF);
 		kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
 		emul_type = EMULTYPE_TRAP_UD_FORCED;
-- 
2.37.2.672.g94769d06f0-goog

