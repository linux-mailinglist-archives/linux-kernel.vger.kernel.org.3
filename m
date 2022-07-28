Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16885584819
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiG1WSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiG1WSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:18:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F69785AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:18:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31dfe25bd47so27116867b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=2h7quCwA+U8RPYleefIstCQInHVnFoLtGc6jewkyotU=;
        b=GI+DN4SdbIj1EzFV04CUuXGNvjR0s9JzqDD2uP+mNHbJlTeyrLffiGdDKVcd6y8RyC
         YPUG6jowPUQnpME6OXH36dsJcEN3mawmcalBKcR/7AXxVpf0e9ka+NKtwBVbl7T9Gwwc
         nOOiNLWH7RHs9eRt7L5XaTbva2h0ldHF2iYmyprZ0Nf+ulyq7eJm7rTxF7CmJDQ5oIld
         mrqWq1e5QkjcnHmK5eY7t/5MPlj5ErQP7/XjuOrx1NrkS8xJZtMIWHSDry3qhRx/XgDq
         i2mcMtjnYGc/SRQUBQNJx3LyPbe8aodC1byanFyCriDYIzYDOi7Ask175BzzNbuhLQhD
         b8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=2h7quCwA+U8RPYleefIstCQInHVnFoLtGc6jewkyotU=;
        b=t3GVXcTg8E3yvdz9ZFfXjX//CE/DdEchUnSXAt0e6lYcmPe2kTf8AqHLRKmyeaXPfC
         dKdxUE9IrbxpamNg6DmVFbtTGn3UpH3U3/e8aKhiyf2XuW6sTFNUMztRD8q2kG44OZG3
         gJnXB9iXCXVMDXIq3rAEPPpdIjBd27qlxvkO63LJH5BCkNkEOsn4RBwLbXQrchRGmSRq
         RR68Ltc+aHYzWNx+zj0d++gO6aozjafFbYl4tK4i/xtguWqY4kJguXjJQpj4e7KQFSyI
         Y0s2CMcN8C9HAMScfbtUQE6AOTZvTHBQeSAP5gT5AZXXeEGB93rTaCp7mvqYdJTcht60
         J6Zw==
X-Gm-Message-State: ACgBeo0Sr0YOLidEn7jCcsKtRi1iQbNzSBXR4m7YSfZVhyswGs2K3NAe
        USns4Z+Gljk+movIVsF7q+KhhrK8nqo=
X-Google-Smtp-Source: AA6agR59D4S6bJffvnjXS+SAAFZFxnspfNvlSkUHdfP3Tc7+DuOCTC1os453r0qtOQZO0/XOzmx/6KM672E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4a42:0:b0:31e:9954:ff83 with SMTP id
 x63-20020a814a42000000b0031e9954ff83mr798277ywa.82.1659046685202; Thu, 28 Jul
 2022 15:18:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 28 Jul 2022 22:17:57 +0000
In-Reply-To: <20220728221759.3492539-1-seanjc@google.com>
Message-Id: <20220728221759.3492539-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220728221759.3492539-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 2/4] KVM: x86/mmu: Fully re-evaluate MMIO caching when SPTE
 masks change
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
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

Fully re-evaluate whether or not MMIO caching can be enabled when SPTE
masks change; simply clearing enable_mmio_caching when a configuration
isn't compatible with caching fails to handle the scenario where the
masks are updated, e.g. by VMX for EPT or by SVM to account for the C-bit
location, and toggle compatibility from false=>true.

Snapshot the original module param so that re-evaluating MMIO caching
preserves userspace's desire to allow caching.  Use a snapshot approach
so that enable_mmio_caching still reflects KVM's actual behavior.

Fixes: 8b9e74bfbf8c ("KVM: x86/mmu: Use enable_mmio_caching to track if MMIO caching is enabled")
Reported-by: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c  |  4 ++++
 arch/x86/kvm/mmu/spte.c | 19 +++++++++++++++++++
 arch/x86/kvm/mmu/spte.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2975fcb14c86..660f58928252 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6699,11 +6699,15 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
 /*
  * nx_huge_pages needs to be resolved to true/false when kvm.ko is loaded, as
  * its default value of -1 is technically undefined behavior for a boolean.
+ * Forward the module init call to SPTE code so that it too can handle module
+ * params that need to be resolved/snapshot.
  */
 void __init kvm_mmu_x86_module_init(void)
 {
 	if (nx_huge_pages == -1)
 		__set_nx_huge_pages(get_nx_auto_mode());
+
+	kvm_mmu_spte_module_init();
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 7314d27d57a4..66f76f5a15bd 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -20,6 +20,7 @@
 #include <asm/vmx.h>
 
 bool __read_mostly enable_mmio_caching = true;
+static bool __ro_after_init allow_mmio_caching;
 module_param_named(mmio_caching, enable_mmio_caching, bool, 0444);
 
 u64 __read_mostly shadow_host_writable_mask;
@@ -43,6 +44,18 @@ u64 __read_mostly shadow_nonpresent_or_rsvd_lower_gfn_mask;
 
 u8 __read_mostly shadow_phys_bits;
 
+void __init kvm_mmu_spte_module_init(void)
+{
+	/*
+	 * Snapshot userspace's desire to allow MMIO caching.  Whether or not
+	 * KVM can actually enable MMIO caching depends on vendor-specific
+	 * hardware capabilities and other module params that can't be resolved
+	 * until the vendor module is loaded, i.e. enable_mmio_caching can and
+	 * will change when the vendor module is (re)loaded.
+	 */
+	allow_mmio_caching = enable_mmio_caching;
+}
+
 static u64 generation_mmio_spte_mask(u64 gen)
 {
 	u64 mask;
@@ -340,6 +353,12 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask)
 	BUG_ON((u64)(unsigned)access_mask != access_mask);
 	WARN_ON(mmio_value & shadow_nonpresent_or_rsvd_lower_gfn_mask);
 
+	/*
+	 * Reset to the original module param value to honor userspace's desire
+	 * to (dis)allow MMIO caching.  Update the param itself so that
+	 * userspace can see whether or not KVM is actually using MMIO caching.
+	 */
+	enable_mmio_caching = allow_mmio_caching;
 	if (!enable_mmio_caching)
 		mmio_value = 0;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index cabe3fbb4f39..26b144ffd146 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -450,6 +450,7 @@ static inline u64 restore_acc_track_spte(u64 spte)
 
 u64 kvm_mmu_changed_pte_notifier_make_spte(u64 old_spte, kvm_pfn_t new_pfn);
 
+void __init kvm_mmu_spte_module_init(void);
 void kvm_mmu_reset_all_pte_masks(void);
 
 #endif
-- 
2.37.1.455.g008518b4e5-goog

