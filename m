Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3665195E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiEDD2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiEDD2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:28:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01037275CC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:24:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7c322f770so2551447b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KpwL4QzbPyZbm+YVQpL9URPH0DGdCbuS02mP/hlbKlg=;
        b=jeKwpzihPzBI5DFNNTg8f9KTEk3wvyGcOz8iRa574qHehsCy7bxP2Oma0wA9aFy25r
         h1STXWOMy4gsGxF8l4TfrGR0UoxrcCdOZyJi60Hd0Tf85XzKVIozH/fzsrQB1lqhO0qm
         gP5B1DhbRhcQ+jUpsnqXllGbYtq8rNc8m8C1Z+2LJ/m1rOBq7GfL0x5p0OvqJ1UoW96U
         vYUO6uSQvES/r/ouEzcivg2/UGs+Tyj1a2VMJRSrJlNcXS187IX2utVRIRKPlmHW5Tlh
         BZdli+17//PdmR1+gjXpAR4odhnvuH2pEvKa3KED3ScCcX9zlBvBR/PNgK4+YvE5lsws
         wWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KpwL4QzbPyZbm+YVQpL9URPH0DGdCbuS02mP/hlbKlg=;
        b=1JNXiDsOCqIiDgXmPyxqUjgMMhb5LSxWR3QhdXgF0n8LH2STlNUNAtDyk/8ux3sI/P
         lttD83C2W59dxCaEGL2eq+gcX7RoWyHMQ3jsKzeEOrKZ8OKvLnGFvQAn6/aCpVnhHlVT
         jnKbtRsRKDXG/V0qEJD/GZFf191KlpZ2S13oN+OUqBlZzy1X054MHs8OXrl+Piz5VYFm
         QqCI0U5/tbGZ1sHVwIWXzchGivCtYm8aYbhPrLFI+KL09Bsb+v9/YhbRE49niJfxBiwv
         gDOzrjxQkw7+Y9nbMTcdIECuEC0II3cAAxyCfQISLFlsjrYAifLUHMyWFTYhBw61vgH4
         Q9Rg==
X-Gm-Message-State: AOAM531kDCRjGmo56H/WwtIatI8gPpZvs5KdbV3OXZIJ+qSy7k2mggIc
        xriZPLp0pViusxwEmJtPhTG1VWK6LT4=
X-Google-Smtp-Source: ABdhPJzZQ3AfNj3AGGTywFxgbadz+UrA7rVq5R/AGOh6+/FRVPv53w9pNiynRMxviJd1G3noU3oC08UvNJQ=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a25:bfca:0:b0:648:6d10:99ac with SMTP id
 q10-20020a25bfca000000b006486d1099acmr15486439ybm.176.1651634697177; Tue, 03
 May 2022 20:24:57 -0700 (PDT)
Date:   Wed,  4 May 2022 03:24:36 +0000
In-Reply-To: <20220504032446.4133305-1-oupton@google.com>
Message-Id: <20220504032446.4133305-3-oupton@google.com>
Mime-Version: 1.0
References: <20220504032446.4133305-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 02/12] KVM: arm64: Dedupe vCPU power off helpers
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        reijiw@google.com, ricarkol@google.com,
        Oliver Upton <oupton@google.com>
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

vcpu_power_off() and kvm_psci_vcpu_off() are equivalent; rename the
former and replace all callsites to the latter.

No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/kvm/arm.c              |  6 +++---
 arch/arm64/kvm/psci.c             | 11 ++---------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 94a27a7520f4..490cd7f3a905 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -841,4 +841,6 @@ void __init kvm_hyp_reserve(void);
 static inline void kvm_hyp_reserve(void) { }
 #endif
 
+void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..28c83c6ddbae 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -432,7 +432,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->cpu = -1;
 }
 
-static void vcpu_power_off(struct kvm_vcpu *vcpu)
+void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.power_off = true;
 	kvm_make_request(KVM_REQ_SLEEP, vcpu);
@@ -460,7 +460,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		vcpu->arch.power_off = false;
 		break;
 	case KVM_MP_STATE_STOPPED:
-		vcpu_power_off(vcpu);
+		kvm_arm_vcpu_power_off(vcpu);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1124,7 +1124,7 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	 * Handle the "start in power-off" case.
 	 */
 	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
-		vcpu_power_off(vcpu);
+		kvm_arm_vcpu_power_off(vcpu);
 	else
 		vcpu->arch.power_off = false;
 
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 67fbd6ef022c..9b1f3acae155 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -51,13 +51,6 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
 	return PSCI_RET_SUCCESS;
 }
 
-static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.power_off = true;
-	kvm_make_request(KVM_REQ_SLEEP, vcpu);
-	kvm_vcpu_kick(vcpu);
-}
-
 static inline bool kvm_psci_valid_affinity(struct kvm_vcpu *vcpu,
 					   unsigned long affinity)
 {
@@ -245,7 +238,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		val = kvm_psci_vcpu_suspend(vcpu);
 		break;
 	case PSCI_0_2_FN_CPU_OFF:
-		kvm_psci_vcpu_off(vcpu);
+		kvm_arm_vcpu_power_off(vcpu);
 		val = PSCI_RET_SUCCESS;
 		break;
 	case PSCI_0_2_FN_CPU_ON:
@@ -379,7 +372,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 
 	switch (psci_fn) {
 	case KVM_PSCI_FN_CPU_OFF:
-		kvm_psci_vcpu_off(vcpu);
+		kvm_arm_vcpu_power_off(vcpu);
 		val = PSCI_RET_SUCCESS;
 		break;
 	case KVM_PSCI_FN_CPU_ON:
-- 
2.36.0.464.gb9c8b46e94-goog

