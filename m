Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4C5884AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiHBXHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiHBXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:07:26 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7010433E23
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:07:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y7-20020a056a00180700b0052d90ab2314so2811019pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=5S5GfKU8cE9TZ3ZcnKyvYT+yBk+CiJ9ehorTUQPSZEs=;
        b=QOh/W0eFpTk0c/umwo+PMzRBkFjczKJXoIz6nthb4A/+VkLytCm4loft0i+5IH7YR1
         yt+P5tSlmDfLKqZQExxwPCIGX0xsHYSCxYUOynqibr3CXnD9aTewZl0urmj+YXrRqqMz
         to6/NVOwXrBO88mpmYO5cxVgSx7SSIUJy8ci2SuYLZIyrxbAp6qtkettEXf6gWhxgKRz
         4C5YbCxXkRwsrTBuelBgkhehrwk9/4qF1UZawB6gRJhZzwQ+8EiJKfnSma+6PZAe3YDA
         kCFu/J03N7jOVQ3TGauhhwz5tgoH99Hul2avVFPvPzUNgilv3WusAf3eNNiojtaOH3zs
         LRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=5S5GfKU8cE9TZ3ZcnKyvYT+yBk+CiJ9ehorTUQPSZEs=;
        b=SSiPMpEy731FDZU5gEEDr6trfbVeIsE79cjVnHarl1AneYkOUQtoSq+JEnlYS1XIzz
         bTIvJkl0AGEJOZPXS8Pu8n3wT6DgK/5r2Gs5aaTVRonbsVz/2d6DQRZtsha/r42Un+AC
         ZAcZKwt5WMIZPZyU7WEW8K6jrllwFalt8CJg8BL1Ys2z7z4gc/r1iU1UnAffssE5NrMQ
         fVzBuKSdG97fZlBLTEVbuaZjN9l2GtB/mgerJl0YI+ag1JGa0qhTSHICYrYloKi9AzXZ
         8kLvRCSAoDrUWDx0CtzAOVQszbB/E6mU9FmmO+oW9jIFlzhV4b9YNNYrcIU8TQY6pi+X
         UWMA==
X-Gm-Message-State: AJIora9z3vyyaFZHeoNlVNZtqr1Ygm++DPp5CHwGHbXMVzHu25lWidtv
        ITP4aYHyQzsrvbaAE+VyaQjGjbM+OnzA
X-Google-Smtp-Source: AGRyM1vXCBWGjOx32Vj2hcf3hruHK6Ry9qboVB6qc3W51oW0TCNZfcf7MhiIxH1CE/gH8cJdZpK74gGKbTOz
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP
 id h5-20020a056a00218500b0052072766570mr23319476pfi.84.1659481645025; Tue, 02
 Aug 2022 16:07:25 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue,  2 Aug 2022 23:07:15 +0000
In-Reply-To: <20220802230718.1891356-1-mizhang@google.com>
Message-Id: <20220802230718.1891356-3-mizhang@google.com>
Mime-Version: 1.0
References: <20220802230718.1891356-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 2/5] selftests: KVM/x86: Fix vcpu_{save,load}_state() by
 adding APIC state into kvm_x86_state
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vcpu_{save,load}_state() by adding APIC state into kvm_x86_state and
properly save/restore it in vcpu_{save,load}_state(). When vcpu resets,
APIC state become software disabled in kernel and thus the corresponding
vCPU is not able to receive posted interrupts [1].  So, add APIC
save/restore in userspace in selftest library code.

[1] commit 97222cc83163 ("KVM: Emulate local APIC in kernel").

Cc: Jim Mattson <jmattson@google.com>

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h    | 10 ++++++++++
 tools/testing/selftests/kvm/include/x86_64/processor.h |  1 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c     |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 24fde97f6121..ac883b8eab57 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -457,6 +457,16 @@ static inline void vcpu_fpu_set(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	vcpu_ioctl(vcpu, KVM_SET_FPU, fpu);
 }
 
+static inline void vcpu_apic_get(struct kvm_vcpu *vcpu, struct kvm_lapic_state *apic)
+{
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, apic);
+}
+
+static inline void vcpu_apic_set(struct kvm_vcpu *vcpu, struct kvm_lapic_state *apic)
+{
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, apic);
+}
+
 static inline int __vcpu_get_reg(struct kvm_vcpu *vcpu, uint64_t id, void *addr)
 {
 	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)addr };
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 45edf45821d0..bf5f874709a4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -225,6 +225,7 @@ struct kvm_x86_state {
 		struct kvm_nested_state nested;
 		char nested_[16384];
 	};
+	struct kvm_lapic_state apic;
 	struct kvm_msrs msrs;
 };
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index f35626df1dea..d18da71654b6 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -980,6 +980,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 	vcpu_msrs_get(vcpu, &state->msrs);
 
 	vcpu_debugregs_get(vcpu, &state->debugregs);
+	vcpu_apic_get(vcpu, &state->apic);
 
 	return state;
 }
@@ -997,6 +998,7 @@ void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state)
 	vcpu_mp_state_set(vcpu, &state->mp_state);
 	vcpu_debugregs_set(vcpu, &state->debugregs);
 	vcpu_regs_set(vcpu, &state->regs);
+	vcpu_apic_set(vcpu, &state->apic);
 
 	if (state->nested.size)
 		vcpu_nested_state_set(vcpu, &state->nested);
-- 
2.37.1.455.g008518b4e5-goog

