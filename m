Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3054253C209
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiFCBBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiFCAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68B27CED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:20 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 144-20020a621496000000b0051ba2e95df2so3498294pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=cfSqxZ12Bjmq6fmiqxfECFlT4VDOjDnjNktcrPKbpQI=;
        b=UCv4baQORggiyocez3lVcY3vzPmXcseuz4pxcWMKcKupvktD9JW4edCO4HWIuv84mn
         KMyY9egFWEv9ys20K/RR+jbzr5+kBu0JFZNz4BWF6cxQbnNljTMMb8FP0DlKa3gXfM5Z
         n7cIbmnmeZdB1TbaL18darlvxrMZ8FK9pzGlnuo6QrOWhN0T3uDEuuFgv4+89MLsUttd
         L13IEAiNyzan76FWmcoTZZ/p8kRnK6Uj8CB/7UwiJO19sDz25MTJRmtFd5iUrovd0hZI
         rolASGT5RoHEgWpiBWxfQ2T2KaETqYVg0qICExrryGYH8SpuCMqRkXEm76LkbOJshBSG
         CpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=cfSqxZ12Bjmq6fmiqxfECFlT4VDOjDnjNktcrPKbpQI=;
        b=U3eQdEX+kqil1wb4Ti/DOCQWJhJGBRyGMzQACrM7FCqegXhCUHS35tohiyA06a6UMn
         iBhovLTCWDCxYD6GS8n+Y2dT7jCK4nCLF40JTakfcHrEnQRd4Canf1GZ8lXpf/OjvL/i
         WKUbNSj1wFEomTkGkqE/5UKIKI82Vv0Oa6lMNBpxp5nRMu+2UE4Bv5yNNBK4kN6x1Drc
         pe0w7fL16KTtT+6lix5S1VL5y8Ux9mDiwCv/X84tHl1yzpv/ZJgjcoZ4sJg2XMFh0R6I
         8x7sO9p/vuEySkNWc3uLjsfdAs/XNTcMv1PayxyrpK4ZYDhY3AiJIIMs2uIrfV3jMQUZ
         4LcQ==
X-Gm-Message-State: AOAM530fZLFAnaffj4vEODBsbnp+3FOdTfX+XtiCYuovAQR5B8h38Tz9
        zOy5RDYLeVr38XimnF6MfkiDCmrmqrE=
X-Google-Smtp-Source: ABdhPJwA0ysu6SfV0rwFqm0B9SriMYHztRZCR7qUr75BrIGBBpLYu9QxeCDPsltwb4RmrUmbNsbBuSdmdhk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:cf06:b0:163:62cb:250e with SMTP id
 i6-20020a170902cf0600b0016362cb250emr7609751plg.171.1654217240324; Thu, 02
 Jun 2022 17:47:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:11 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-125-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 124/144] KVM: selftests: Drop @vcpuids param from VM creators
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Drop the @vcpuids parameter from VM creators now that there are no users.
Allowing tests to specify IDs was a gigantic mistake as it resulted in
tests with arbitrary and ultimately meaningless IDs that differed only
because the author used test X intead of test Y as the source for
copy+paste (the de facto standard way to create a KVM selftest).

Except for literally two tests, x86's set_boot_cpu_id and s390's resets,
tests do not and should not care about the vCPU ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++--
 tools/testing/selftests/kvm/kvm_page_table_test.c   | 2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c          | 8 +++-----
 tools/testing/selftests/kvm/lib/perf_test_util.c    | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 90521c5716b1..f409bae336d5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -563,7 +563,7 @@ static inline struct kvm_vm *vm_create(uint64_t nr_pages)
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[]);
+				      struct kvm_vcpu *vcpus[]);
 
 static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
@@ -571,7 +571,7 @@ static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 {
 	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus,
 				      DEFAULT_GUEST_PHY_PAGES, 0, 0,
-				      guest_code, NULL, vcpus);
+				      guest_code, vcpus);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index e91bc7f1400d..76031be195fa 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -269,7 +269,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
 	vm = __vm_create_with_vcpus(mode, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
-				    guest_num_pages, 0, guest_code, NULL, NULL);
+				    guest_num_pages, 0, guest_code, NULL);
 
 	/* Align down GPA of the testing memslot */
 	if (!p->phys_offset)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 03a26ef6a611..6ba28018e723 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -299,7 +299,7 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[])
+				      struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
 	struct kvm_vcpu *vcpu;
@@ -327,9 +327,7 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 	vm = __vm_create(mode, pages);
 
 	for (i = 0; i < nr_vcpus; ++i) {
-		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
-
-		vcpu = vm_vcpu_add(vm, vcpuid, guest_code);
+		vcpu = vm_vcpu_add(vm, i, guest_code);
 		if (vcpus)
 			vcpus[i] = vcpu;
 	}
@@ -345,7 +343,7 @@ struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	struct kvm_vm *vm;
 
 	vm = __vm_create_with_vcpus(VM_MODE_DEFAULT, 1, DEFAULT_GUEST_PHY_PAGES,
-				    extra_mem_pages, 0, guest_code, NULL, vcpus);
+				    extra_mem_pages, 0, guest_code, vcpus);
 
 	*vcpu = vcpus[0];
 	return vm;
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 5b80ba7f12e4..ffbd3664e162 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -140,7 +140,7 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
 	vm = __vm_create_with_vcpus(mode, vcpus, DEFAULT_GUEST_PHY_PAGES,
-				    guest_num_pages, 0, guest_code, NULL, NULL);
+				    guest_num_pages, 0, guest_code, NULL);
 
 	pta->vm = vm;
 
-- 
2.36.1.255.ge46751e96f-goog

