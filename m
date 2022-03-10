Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCEE4D4F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiCJQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbiCJQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:47:28 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74084197B7E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id h12-20020a63530c000000b0037c8f45bf1bso3229383pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NW+z7HtQmlg5a0U0koIIQucOMtvMCE0mN+TldjWFMzI=;
        b=A6tZ8fUNYKG6WFUuHJ21b9uCD5dMPkYBBYMpTMl6dEvJNqI5oVKTYYMiWMMhBj2xqA
         3KVbpQg3rc1rZ8oNcG59/bueMJfgsOakAHvl/T5d8eP8SXPS+j85IKFUp5xjwJfgIgTh
         UPGxoOIMIi+w24D+zOkg1hPhVMRxIzy5pL8sh1J1C4qu22NfkuSGvqeNwkYjdPaVtwX/
         DLPpcqKCeZkKHFqB7BECyiFMOKg0q5A5xn9LNxX3ACRS+nO/QOqag32TpFVwPchTSpkd
         LAZSYn4vAYZh1krjAbG+UpB5X2aGByV8XeWwqyr9FguBm8V+P3rGXY2UpKf8yJ5DKb0D
         Eeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NW+z7HtQmlg5a0U0koIIQucOMtvMCE0mN+TldjWFMzI=;
        b=4PIWYVpq/NvI23VW/Tz1dIg1Y/+QFfNcwLqRCh+Z84YBA/Tf1U4g9o9YkIH4WiWXYT
         fqz4GATiNvVH9Jvfcz8QflrzcrkLNesrxvSuspj3jPgk//sz6y3unsb6AePX3J0Kc7Jf
         fUosYlVIbHfjL+N5uf3l3qbXmjhJ5egY0LOuO7KYclsiFEa9jbFyXYYEAoJ8Ucyp1rdQ
         E23k1069O+4MDHlAjHwnpHGBiljyy+HzH06vXuOMUKUNruspAMcr3rO4No0g41xwoU2S
         QZYP6i47NKZoOFmuw6MRLsAob+lFvW7Bnhot5GFRvE9mA03F57zvv81ROy3T8hT4cFBi
         FFOQ==
X-Gm-Message-State: AOAM533olY38J26wtRaSpeXwW/884fsv8iYUDrBCxDrZnw8xkHcSNime
        Ir9ZGu4QTgu/2s3x6WAs9ue/isXK0YwFvYBFz2k7yf8RH2+rsE9CaMqv9KqQwtTIX8/3NAQW998
        dR+UXMaCaB14nA1hJfjrcy5RmCHPHN06rwl1tqan8VMxmIHyoZKmNZjnXlp3yUlllNtp1u/+I
X-Google-Smtp-Source: ABdhPJzEz+KcGZn1TBz/jV3Jq6wYxRTubaL8HoPTXQnSO/rJqUdU3ejJQpxctcAMk9C/B5Af7mWSDlEYVDvP
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2d58:733f:1853:8e86])
 (user=bgardon job=sendgmr) by 2002:a17:90a:2ec2:b0:1bc:8bdd:8cfc with SMTP id
 h2-20020a17090a2ec200b001bc8bdd8cfcmr17171203pjs.237.1646930773835; Thu, 10
 Mar 2022 08:46:13 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:45:29 -0800
In-Reply-To: <20220310164532.1821490-1-bgardon@google.com>
Message-Id: <20220310164532.1821490-11-bgardon@google.com>
Mime-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH 10/13] KVM: x86/MMU: Allow NX huge pages to be disabled on a
 per-vm basis
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the NX hugepage mitigation for iTLB multihit is not
needed for all guests on a host. Allow disabling the mitigation on a
per-VM basis to avoid the performance hit of NX hugepages on trusted
workloads.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.h              | 1 +
 arch/x86/kvm/mmu/mmu.c          | 6 ++++--
 arch/x86/kvm/x86.c              | 6 ++++++
 include/uapi/linux/kvm.h        | 1 +
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0a0c54639dd8..04ddfc475ce0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1242,6 +1242,7 @@ struct kvm_arch {
 #endif
 
 	bool nx_huge_pages;
+	bool disable_nx_huge_pages;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index dd28fe8d13ae..36d8d84ca6c6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -177,6 +177,7 @@ static inline bool is_nx_huge_page_enabled(struct kvm *kvm)
 {
 	return READ_ONCE(kvm->arch.nx_huge_pages);
 }
+void kvm_update_nx_huge_pages(struct kvm *kvm);
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 					u32 err, bool prefetch)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dc9672f70468..a7d387ccfd74 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6195,9 +6195,10 @@ static void __set_nx_huge_pages(bool val)
 	nx_huge_pages = itlb_multihit_kvm_mitigation = val;
 }
 
-static void kvm_update_nx_huge_pages(struct kvm *kvm)
+void kvm_update_nx_huge_pages(struct kvm *kvm)
 {
-	kvm->arch.nx_huge_pages = nx_huge_pages;
+	kvm->arch.nx_huge_pages = nx_huge_pages &&
+				  !kvm->arch.disable_nx_huge_pages;
 
 	mutex_lock(&kvm->slots_lock);
 	kvm_mmu_zap_all_fast(kvm);
@@ -6451,6 +6452,7 @@ int kvm_mmu_post_init_vm(struct kvm *kvm)
 	int err;
 
 	kvm->arch.nx_huge_pages = READ_ONCE(nx_huge_pages);
+	kvm->arch.disable_nx_huge_pages = false;
 	err = kvm_vm_create_worker_thread(kvm, kvm_nx_lpage_recovery_worker, 0,
 					  "kvm-nx-lpage-recovery",
 					  &kvm->arch.nx_lpage_recovery_thread);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51106d32f04e..73df90a6932b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4256,6 +4256,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SYS_ATTRIBUTES:
 	case KVM_CAP_VAPIC:
 	case KVM_CAP_ENABLE_CAP:
+	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
 		r = 1;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
@@ -6048,6 +6049,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
+		kvm->arch.disable_nx_huge_pages = true;
+		kvm_update_nx_huge_pages(kvm);
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ee5cc9e2a837..6f9fa7ecfd1e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1144,6 +1144,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_MEM_OP_EXTENSION 211
 #define KVM_CAP_PMU_CAPABILITY 212
 #define KVM_CAP_DISABLE_QUIRKS2 213
+#define KVM_CAP_VM_DISABLE_NX_HUGE_PAGES 214
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.35.1.616.g0bdcbb4464-goog

