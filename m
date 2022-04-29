Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15133513FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353768AbiD2BIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353737AbiD2BHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:07:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB107BC87D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:27 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a170903124800b0015195a5826cso3494186plh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/vObjEr2duI6lVj2DJMiXx7mTG91sHLuRvuGuCnnp5s=;
        b=BTi4c7Cu302LzqbL4GcUUkcvj9CTYFdTcbPiomOjs7vaKzDfjVRNwHJbs/7uADbHVQ
         OTpoo7YsC7bnXCgBlljC7OPk26zAEDiYnR0gs7nHjjhjW/6x7PpusRMq0ZWHcwNW34el
         wksPfyimmN/zO0/29ZJCeSKRCVwaVzS/1vbxxc9WWUcCIHh3cjmoE4x4e0dMjbzhGMZY
         1x3VEy8+MLdU7e0KJBtaLqY6vhnbcuRJAcbUICS2rWbRV4qZatC9pV93MLFe9pXIU9QL
         FcV9WBd9WsFMBbHF7Qjkds+qmE32xrEcyfoj6jj4IuoyHlM1J+BoiAFYUL0DyX2tRkh8
         8MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/vObjEr2duI6lVj2DJMiXx7mTG91sHLuRvuGuCnnp5s=;
        b=LvmXq8Tz1e4ts/8kc72cSgEoa4OOQaoeU7RP9thveWrJ12UJ4BMPh+PgWvJ5SlZUh0
         Qtt4rkZUDNqOrf3lcBwRqbBQo9Y8UUUhKA0WNAgy56J/IYbDdaE0eOUU94j7Y6gUqyNm
         eSLJYBryaqpjoG8N4H3oCb6BptacRGkE7SFFEIW3KEX1OETdHpnF4eX8Jkf7OFWd5PEw
         8uZkMk+1rt9HFmaatRkv0fIraD3q1ZF20KnVkeWNFesT6a+DvDxTsob/zhZQczMJjeR1
         OmFSck6+k15U+c+VfBow9NuKZo2yAdR4lXIuPsMxa6cQJGkKmQWW7w/kS3NQK6eTaSqp
         Stkg==
X-Gm-Message-State: AOAM531WFa0KVMRWVA1ZJ4fvuznVTSnAxGfQ+DXBTwLlxhnR4ZcL1mN7
        1Wlu662uj69GYxMHcd4ZkICHkCsmhUU=
X-Google-Smtp-Source: ABdhPJyfhCif5QV45qKzkrHHL1rKzaRwb2023co9r5r38s2V6rgHOlKAXbndsrdWBD5/pjYZRk7mhxSGPtM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:1056:0:b0:3a8:2190:9e27 with SMTP id
 22-20020a631056000000b003a821909e27mr30475002pgq.303.1651194267207; Thu, 28
 Apr 2022 18:04:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Apr 2022 01:04:11 +0000
In-Reply-To: <20220429010416.2788472-1-seanjc@google.com>
Message-Id: <20220429010416.2788472-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220429010416.2788472-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 05/10] KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's
 APIC-access page
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Use kvm_vcpu_map() to get/pin the backing for vmcs12's APIC-access page,
there's no reason it has to be restricted to 'struct page' backing.  The
APIC-access page actually doesn't need to be backed by anything, which is
ironically why it got left behind by the series which introduced
kvm_vcpu_map()[1]; the plan was to shove a dummy pfn into vmcs02[2], but
that code never got merged.

Switching the APIC-access page to kvm_vcpu_map() doesn't preclude using a
magic pfn in the future, and will allow a future patch to drop
kvm_vcpu_gpa_to_page().

[1] https://lore.kernel.org/all/1547026933-31226-1-git-send-email-karahmed@amazon.de
[2] https://lore.kernel.org/lkml/1543845551-4403-1-git-send-email-karahmed@amazon.de

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 39 ++++++++++++---------------------------
 arch/x86/kvm/vmx/vmx.h    |  2 +-
 2 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a6688663da4d..cc1c7836f172 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -311,11 +311,12 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.cached_vmcs12 = NULL;
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
-	/* Unpin physical memory we referred to in the vmcs02 */
-	if (vmx->nested.apic_access_page) {
-		kvm_release_page_clean(vmx->nested.apic_access_page);
-		vmx->nested.apic_access_page = NULL;
-	}
+	/*
+	 * Unpin physical memory we referred to in the vmcs02.  The APIC access
+	 * page's backing page (yeah, confusing) shouldn't actually be accessed,
+	 * and if it is written, the contents are irrelevant.
+	 */
+	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
 	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
 	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
 	vmx->nested.pi_desc = NULL;
@@ -3159,8 +3160,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_host_map *map;
-	struct page *page;
-	u64 hpa;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
@@ -3175,23 +3174,12 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-		/*
-		 * Translate L1 physical address to host physical
-		 * address for vmcs02. Keep the page pinned, so this
-		 * physical address remains valid. We keep a reference
-		 * to it so we can release it later.
-		 */
-		if (vmx->nested.apic_access_page) { /* shouldn't happen */
-			kvm_release_page_clean(vmx->nested.apic_access_page);
-			vmx->nested.apic_access_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->apic_access_addr);
-		if (!is_error_page(page)) {
-			vmx->nested.apic_access_page = page;
-			hpa = page_to_phys(vmx->nested.apic_access_page);
-			vmcs_write64(APIC_ACCESS_ADDR, hpa);
+		map = &vmx->nested.apic_access_page_map;
+
+		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->apic_access_addr), map)) {
+			vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(map->pfn));
 		} else {
-			pr_debug_ratelimited("%s: no backing 'struct page' for APIC-access address in vmcs12\n",
+			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
 			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			vcpu->run->internal.suberror =
@@ -4627,10 +4615,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	}
 
 	/* Unpin physical memory we referred to in vmcs02 */
-	if (vmx->nested.apic_access_page) {
-		kvm_release_page_clean(vmx->nested.apic_access_page);
-		vmx->nested.apic_access_page = NULL;
-	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
 	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
 	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
 	vmx->nested.pi_desc = NULL;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9c6bfcd84008..2498774f36b2 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -203,7 +203,7 @@ struct nested_vmx {
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
-	struct page *apic_access_page;
+	struct kvm_host_map apic_access_page_map;
 	struct kvm_host_map virtual_apic_map;
 	struct kvm_host_map pi_desc_map;
 
-- 
2.36.0.464.gb9c8b46e94-goog

