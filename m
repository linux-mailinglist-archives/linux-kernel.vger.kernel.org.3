Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80C47332C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhLMRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhLMRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:46:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 09:46:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w5-20020a634745000000b0030a5bee70e8so9356341pgk.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 09:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=xkL4K9dgU9RwK5048Aq2bqr9IhZdksP2KF2usWFUkl4=;
        b=sUnxZOm9PP16yJLfOGfR1jk6144eZQKgMEzbBMb40s28/4uQFZlwqa8M6WIYLu6m2Y
         StFyhsnUtuHVwdZUjymHZOlTOUssLDtb7jLmajRBCTVkZfe9pAOjG6pVlkrDB7XNkwly
         i1HTbqk0+N13j5So+SA1Iapwoe1y06pk28SwxJRTaBdHE/nEDvdA4qrlabDNB5EiQGaC
         NY5eTu3orlEUd6ORUevBLdseGCU/qoeD8rbEMYMtkfpoCdRzBclEy7QLCFgZLgMZRynN
         4ZegfKMmV/Fp4qijW4pBtc+rJn+pRX7Etk51LcAErNvgowhbEXnT+DmI7VR9wHZZc4Os
         Duow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=xkL4K9dgU9RwK5048Aq2bqr9IhZdksP2KF2usWFUkl4=;
        b=nP+VT1Tk24+KNHtqcMZ7dAuJj1Uz9CAfOCxdn2zs52uiovdcznlzFTRkHFp93s3ts+
         fuZD1SOeTnJg2biPAX3hKUVRQ3tIpMtN8g+Bq0Zb5BTQlwevna1Cfls+9IcIFA8J0w/T
         Rcebz0b/SnZrDQiPdDLtFrD+Su7P4gijnxQywbjcP6tVtOPQXXKYAjlAUdHzi0MCUrdv
         ber2sEGUWVjVEmPP1YG1/eORN7BJMTeSvtc92i0qpSXOFbJhNkmMeMw7wj+FkoyrnVN7
         skpPv2wBBnt3mYBWQbiFoZtvEHEmf1nGWzrnD47J4QLle4q4AfMBoLSbIwp6Au/wPEzI
         XJ9Q==
X-Gm-Message-State: AOAM532ghRHnAr9cx3AtXpg13GoFJLastZODIaNHngS9gs0pLzuYmFEt
        W/DgT/23dyM7SV5ILCO1q2KDTmiLbUI=
X-Google-Smtp-Source: ABdhPJwJMNH/cGeIHI9wCwI/0nhngmeH/h3oVoFyKZeuGB5UOmWw57zBOuyEQPNvXN1GAmWFM/4habhUWW8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:a16:: with SMTP id
 gg22mr968644pjb.0.1639417616924; Mon, 13 Dec 2021 09:46:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 13 Dec 2021 17:45:56 +0000
Message-Id: <20211213174556.3871157-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] KVM: PPC: Book3S HV P9: Use kvm_arch_vcpu_get_wait() to get
 rcuwait object
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_arch_vcpu_get_wait() to get a vCPU's rcuwait object instead of
using vcpu->wait directly in kvmhv_run_single_vcpu().  Functionally, this
is a nop as vcpu->arch.waitp is guaranteed to point at vcpu->wait.  But
that is not obvious at first glance, and a future change coming in via
the KVM tree, commit 510958e99721 ("KVM: Force PPC to define its own
rcuwait object"), will hide vcpu->wait from architectures that define
__KVM_HAVE_ARCH_WQP to prevent generic KVM from attepting to wake a vCPU
with the wrong rcuwait object.

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Compile tested only.  Carrying this in the PPC tree will avoid a build
failure due to a silent merge conflict with a change in the KVM tree.

https://lore.kernel.org/all/496ECBB3-36F3-4F07-83B2-875F683BC446@linux.vnet.ibm.com/

 arch/powerpc/kvm/book3s_hv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7986911b873c..f64e45d6c0f4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4442,6 +4442,7 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
 int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			  unsigned long lpcr)
 {
+	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 	struct kvm_run *run = vcpu->run;
 	int trap, r, pcpu;
 	int srcu_idx;
@@ -4588,7 +4589,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (is_kvmppc_resume_guest(r) && !kvmppc_vcpu_check_block(vcpu)) {
 		kvmppc_set_timer(vcpu);
 
-		prepare_to_rcuwait(&vcpu->wait);
+		prepare_to_rcuwait(wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current)) {
@@ -4605,7 +4606,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			schedule();
 			trace_kvmppc_vcore_blocked(vc, 1);
 		}
-		finish_rcuwait(&vcpu->wait);
+		finish_rcuwait(wait);
 	}
 	vcpu->arch.ceded = 0;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

