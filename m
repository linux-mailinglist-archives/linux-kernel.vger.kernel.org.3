Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002E257E9F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiGVWod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbiGVWoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:44:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE015A1F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:44:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id rm8-20020a17090b3ec800b001f07b25d636so4498401pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZY+tUE4rZ+sUQOkiCezCy7txeAhXNX+dCy+Lqq1rkD4=;
        b=OSW3LvDdoeGIwZPNx8kr9+XrS21Q+ytT7VjmU2P3X6LwHhKBk99ebVSfxt32kvJYap
         nZOpxA2OCVkHZIXEj/sETQykOSKs9OcNXH59oNJIFBKHgqWrLvsRvGX1VZr6U09S935x
         z1D4BzsbQjjhCDKBKDVu9VzUwXYu3tVs1z3qn2/EZk9BrAoozhqUyoCT6g7leU7LwiGS
         7BGsNQ7dM5WKuiAXIO8VAVHFGFMr5ucfMR0l/uQ3eBS2NXfitjmbE0zpHwNTuU3bCcoO
         n0wY8is0EUkCX/2IlyOibwgbuOsRE3Sc3O437kPCc8I9Wu/y/I8yZ7usie5Us3oDqpAQ
         P59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZY+tUE4rZ+sUQOkiCezCy7txeAhXNX+dCy+Lqq1rkD4=;
        b=IwhLRqKgN2ZA90MZYIHfX3+K/88W7uyPOYd2S5o76jHBKMSdzylZkNd82CTPFerQ+g
         Prxvtchi3dY8eMzRgCGTWrtZAZpjS1QJ+YqqDSHduVA2bbGaGMfC6u/lCcohWKYxYJMx
         TmU1oXM9W13+L5JqX9nlyTcTmIMFPapaqnI1NBB9ok5BYUAgo/75LV3k0DzIt7QbhxcS
         U3R8sfSZUeWuWwuTQB1yr3u4D9l026YjidqfBRLYrRKT1GSTK5kp7qBpHAWGKUeUS178
         T3YDWLbkjxdlyNsiafa8las0IacJfwh7HOIsJFzpT75SjeUGWxSeZjpRC8DUYr/gkQnZ
         my5Q==
X-Gm-Message-State: AJIora+EyTiyGLlVRPVqurmREEmLseNGBu1TZAhagB8+QV/19262kpuQ
        rUMOHbQsGL/Quxmxs5pw8oISt27/fD4=
X-Google-Smtp-Source: AGRyM1tHsO7GYWir9NMkM91Dbxrg8Fwutg92d7z6lsJLR/uW6wheeqtHfTkKncraswX+5s/dyWDlbiGR2Wg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8743:0:b0:41a:6f6b:db7b with SMTP id
 i64-20020a638743000000b0041a6f6bdb7bmr1688976pge.594.1658529859008; Fri, 22
 Jul 2022 15:44:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jul 2022 22:44:08 +0000
In-Reply-To: <20220722224409.1336532-1-seanjc@google.com>
Message-Id: <20220722224409.1336532-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220722224409.1336532-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 4/5] KVM: nVMX: Attempt to load PERF_GLOBAL_CTRL on nVMX xfer
 iff it exists
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Attempt to load PERF_GLOBAL_CTRL during nested VM-Enter/VM-Exit if and
only if the MSR exists (according to the guest vCPU model).  KVM has very
misguided handling of VM_{ENTRY,EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL and
attempts to force the nVMX MSR settings to match the vPMU model, i.e. to
hide/expose the control based on whether or not the MSR exists from the
guest's perspective.

KVM's modifications fail to handle the scenario where the vPMU is hidden
from the guest _after_ being exposed to the guest, e.g. by userspace
doing multiple KVM_SET_CPUID2 calls, which is allowed if done before any
KVM_RUN.  nested_vmx_pmu_refresh() is called if and only if there's a
recognized vPMU, i.e. KVM will leave the bits in the allow state and then
ultimately reject the MSR load and WARN.

KVM should not force the VMX MSRs in the first place.  KVM taking control
of the MSRs was a misguided attempt at mimicking what commit 5f76f6f5ff96
("KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled",
2018-10-01) did for MPX.  However, the MPX commit was a workaround for
another KVM bug and not something that should be imitated (and it should
never been done in the first place).

In other words, KVM's ABI _should_ be that userspace has full control
over the MSRs, at which point triggering the WARN that loading the MSR
must not fail is trivial.

The intent of the WARN is still valid; KVM has consistency checks to
ensure that vmcs12->{guest,host}_ia32_perf_global_ctrl is valid.  The
problem is that '0' must be considered a valid value at all times, and so
the simple/obvious solution is to just not actually load the MSR when it
does not exist.  It is userspace's responsibility to provide a sane vCPU
model, i.e. KVM is well within its ABI and Intel's VMX architecture to
skip the loads if the MSR does not exist.

Fixes: 03a8871add95 ("KVM: nVMX: Expose load IA32_PERF_GLOBAL_CTRL VM-{Entry,Exit} control")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 451cbb9c56c3..52fb45e23910 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2623,6 +2623,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	}
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) &&
+	    intel_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)) &&
 	    WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
 				     vmcs12->guest_ia32_perf_global_ctrl))) {
 		*entry_failure_code = ENTRY_FAIL_DEFAULT;
@@ -4333,7 +4334,8 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->host_ia32_pat);
 		vcpu->arch.pat = vmcs12->host_ia32_pat;
 	}
-	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
+	if ((vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL) &&
+	    intel_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)))
 		WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
 					 vmcs12->host_ia32_perf_global_ctrl));
 
-- 
2.37.1.359.gd136c6c3e2-goog

