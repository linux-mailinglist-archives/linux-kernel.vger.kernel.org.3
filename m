Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068D5A4006
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiH1WZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH1WZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:25:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD814085
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:25:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d16-20020a17090ad3d000b001fb42eb7467so2371497pjw.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=+0YcUxl6w5S43rp5xSvLoFsoOQeX/6nXvUKDRMGuY+4=;
        b=lc30ffSB8YQZjEbZDqmcgbW3ZeNzpXVKwnW2YhSZLRRf+SIgS+ivUaMd7Vhc4TnTOe
         btrHLR5JniiAprJhu+IXljXcomK14NYed3aaauIkPwiAm2OSKgOZokFUYFoSCFI4sM27
         SRoJNeIjth14/1aBxa9a4WE0zUNbDhb00IPoRdn+hvotJJ3fGctGjjkrogEgqdv1gDsQ
         mDjATNizqZ/tBQD28YiT8ry7U+dweH2IyZzZNeuPEoZlYVJUvefancxIZiRDsagXctp7
         I+k+CHDYXmYO45zK8xNn0dATkQNHqRb09Q9ka0aeuvwcuILbza9w8evzMPTP6h0ufDyL
         k53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=+0YcUxl6w5S43rp5xSvLoFsoOQeX/6nXvUKDRMGuY+4=;
        b=JvuxLGaCSX508u5jad/678jVHRGgHDR0WYCSpZ6YN5SNtmB9SeTdk7zDDguvFE3Wxz
         8fzjjF6I+ppW0jsb/8M3C0swJlukKHg40AWve9eM/o66JZ6u8uJNo/1yltiMJ41QKl7S
         Hu0W9IfwFVOnOjwu/m3LAizn1/vHu5slgEYFShBeXbbnIpZlx36BmLhlQc0M40H9R7lS
         CTAtsH0j2drFrL4vu20A0bgUkCJ03ekmRK26W9/ear+NUdQnZz3momMkFUzXtuUXZpRd
         3s+gJTYg4vw0Y8i1vFRinfpxwNq/URtudLdrB9sctb3c63VEIHKNqxT+4K9gN7V0NeXK
         tJ5Q==
X-Gm-Message-State: ACgBeo0ovvqLMzwo+Ab2My2yuASS/G4a8vsO5U5ysLkEfB5o3UvHEAmO
        IzQHEe5BhDlCxZFesTCKtP/xanr9CY9i
X-Google-Smtp-Source: AA6agR6VtT2c2EjZ/labJtCIac4RDvO7XzQLXT1mkuGrZeZDh8HGBq2GIyvbrQmwulc75D7KaUM48UUYry/k
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90b:3807:b0:1f4:ecf7:5987 with SMTP id
 mq7-20020a17090b380700b001f4ecf75987mr15014728pjb.13.1661725549891; Sun, 28
 Aug 2022 15:25:49 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 28 Aug 2022 22:25:42 +0000
In-Reply-To: <20220828222544.1964917-1-mizhang@google.com>
Mime-Version: 1.0
References: <20220828222544.1964917-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220828222544.1964917-3-mizhang@google.com>
Subject: [PATCH v2 2/4] KVM: selftests: Save/restore vAPIC state in migration tests
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>
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

Save/restore vAPIC state as part of vCPU save/load so that it is preserved
across VM (copyless) migration. This wil allow testing the posted
interrupts are properly handled across VM migration.

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
index 0cbc71b7af50..102a56a60652 100644
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
index 2e6e61bbe81b..e22b4f0e24f1 100644
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
2.37.2.672.g94769d06f0-goog

