Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B34D5B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbiCKGDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbiCKFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5A100752
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090a674e00b001bf1c750f9bso7258169pjm.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Q1GD4eEQsvZ1Ive+fR6RX/dgJvQAbI+B/yP5IlUtfuc=;
        b=rgMXYfBlK3JFnqwB568fBYwS5ANJA0r18Psfs0C87WWFZnh/Ss6ZWEyliDQOwutJcn
         T9q827cJu3R+Yeo/l2xdb6Bxa1Xr9bGrsaqQUU5bjAiTfHB5WG7vGPI/XpNFr4rwp2vm
         cv4fwmZedQ3gzvwQiTESrgj2tNdqjdztwnQKgr6jqTReF6ZqQlbxW7LEJo8+hQQgR+zM
         ZSH/dGHIpK2PHYDglajMpoMTo2MgXrRUJndxVyx/g+pnk3+xRfI+oo9u4p578NuCq0M0
         EYWJrMwoO9wBnXBUgKGcEICmwvXGjLHghHUXhQrOEmtzhlJKErDNChrzpU0JMR5jLMtN
         NVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Q1GD4eEQsvZ1Ive+fR6RX/dgJvQAbI+B/yP5IlUtfuc=;
        b=aN0KvypK2d7qX3kdkANPXDrSBIwaOLbkDfe8LWKmzCqdU/+MgnhldEftc6w2DXpIsH
         +GOvv09aOKH57o2SNc7Pax1SPQMI0DaRJkMZpsSXa31nz77CPOSy6n6LzMil1ks3l40z
         7G2UN1BCSE12PAbM0q4xuh7O7MqHhD0nuS6GXBlbK9Rr9FAQvr7jwcggvuZ5zORQ6FFp
         rOLdTCah5wtrtRfo4FfjxnCzNdpjaGANOU767wfdVy3Ekc224sGGZmh+L0J7bq3NNzwp
         NkSzancp39SvndI9DspsqdTDZYYvlkzOo6j7XLw5knT8CZTsTVXcDIm7aCqCyQVtHKOu
         L3fw==
X-Gm-Message-State: AOAM531GOsgMen9NG6EFZK2XHIDoJjIBkFgIguX7rNYRuNmg3+2ZplrP
        P9Bn+HfU8JEiVaMdkLRRzGthwib+NSQVIHgFODwfO3gAUTMxBPysRay3qU92Eh4ctfTemqadmkr
        jK5uImSjyIkJ239kuUCLWJiCr9BVvCOmYRwm2Sgf3dtLNRtgaM6bo3rRrq26p/VMDOE30Rg==
X-Google-Smtp-Source: ABdhPJzWGLB/KRxURryJ1G067fJ2Q81Pev+9aAc3zavqQzkAe8k8Kv7FvmoTheaMUNgwqfPZZSy2KS6kN+s=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id
 r20-20020a170902be1400b0014fce67d0a1mr8670620pls.29.1646978024427; Thu, 10
 Mar 2022 21:53:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:45 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-95-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 094/105] KVM: selftests: Drop vm_create_default* helpers
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 24 -------------------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 +++++-------------
 2 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 051d9707e2e7..608f9d3cdfbf 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -517,30 +517,6 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
 
-/*
- * Create a VM with reasonable defaults
- *
- * Input Args:
- *   vcpuid - The id of the single VCPU to add to the VM.
- *   extra_mem_pages - The number of extra pages to add (this will
- *                     decide how much extra space we will need to
- *                     setup the page tables using memslot 0)
- *   guest_code - The vCPU's entry point
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to opaque structure that describes the created VM.
- */
-struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
-				 void *guest_code);
-
-/* Same as vm_create_default, but can be used for more than one vcpu */
-struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_mem_pages,
-					    uint32_t num_percpu_pages, void *guest_code,
-					    uint32_t vcpuids[]);
-
-/* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index de568d0a2ccc..a89369505232 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -353,28 +353,17 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 	return vm;
 }
 
-struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_mem_pages,
-					    uint32_t num_percpu_pages, void *guest_code,
-					    uint32_t vcpuids[])
-{
-	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
-				      extra_mem_pages, num_percpu_pages, guest_code, vcpuids, NULL);
-}
-
-struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
-				 void *guest_code)
-{
-	return vm_create_default_with_vcpus(1, extra_mem_pages, 0, guest_code,
-					    (uint32_t []){ vcpuid });
-}
-
 struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 					 uint64_t extra_mem_pages,
 					 void *guest_code)
 {
-	struct kvm_vm *vm = vm_create_default(0, extra_mem_pages, guest_code);
+	struct kvm_vcpu *vcpus[1];
+	struct kvm_vm *vm;
 
-	*vcpu = vcpu_get(vm, 0);
+	vm = __vm_create_with_vcpus(VM_MODE_DEFAULT, 1, DEFAULT_GUEST_PHY_PAGES,
+				    extra_mem_pages, 0, guest_code, NULL, vcpus);
+
+	*vcpu = vcpus[0];
 	return vm;
 }
 
-- 
2.35.1.723.g4982287a31-goog

