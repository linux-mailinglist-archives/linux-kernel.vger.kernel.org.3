Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B151B342
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383989AbiEDXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380364AbiEDW75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:59:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CE57135
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id v8-20020a170902b7c800b0015e927ee201so1368111plz.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=b5mqyDQydri5T13drbTfXUVGOsVwBBBBvhoVfKOp4Ng=;
        b=E3cUwHmMsCEN9UooIQHkxsNcWNT7UFkJIUUh57XKJtxJ+lG6bNMc9BIPYbGSCt3w5D
         yTtiuuMFgs4MLu8U9yAFk8qO7fPYH9+4ej6+fx/vszn0KljBFud3jxHmTbVOWk/EsUE4
         XqAFnVnWEIUpE1KA8wSbBhuEH1r05BAQbQ1sM7rcpiatoC1rNi7oLCk1mHHZR2kXhscg
         8RI/6xWxm0EIGgVOynQXQAEQR2V2+GqE8gdv17D0GYQ6kNAYGsS8nBDO3RSREWMujdPa
         YIdlFyuytchaVPJ4q1tuf+nbXCMBrGmmEurvexu4k/B/dsIRp97kEm7FqYSZ/Bl5j1a/
         4e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=b5mqyDQydri5T13drbTfXUVGOsVwBBBBvhoVfKOp4Ng=;
        b=nzSyugtJtTiKMs+cIlhyCxhobFSf1DauqbvUCD/hMgZPpiXX1KnC41rsxI7kJijdlc
         QuM2Qj3HdgxgOzieuAV1ZGJ94DNocggQxuJOBKhMW0nSSzZUFfvpQ+SeyFGjVFJdXjlq
         C/RNPcwkMn4735djcOOwkHHRMtxBdPIlYzZeTlCE/+g8QoBAq2WjuUSdLPx/bXR638Xf
         yDZCtdBjxeae7ISSKsePGl8Ok2KSG3/+yrtAGvSv0PglPvWEHguwveM4eD8RH7xBHmMP
         usW95aDTR6jyIX+U4ZMBm8ISBGYPuD2rYP/9B7dXyWRawkWhu27sAcWJjArGrnKYSubq
         8uXA==
X-Gm-Message-State: AOAM532Wtiws/EAvVm68WQn3D+lLHjhs4aTIJbr93j3Y3FUcBDntPuZZ
        XcgXKGwPTCLTWgaFVqnTf83znOYl8Pc=
X-Google-Smtp-Source: ABdhPJzGh9RbXHnHWVjsE25ui8Kt42FUo+iqCEdec0OdPK+O2q9UD6d1qGIZaYPIlueNm3i7xaDyT5darfs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b704:b0:156:624:934b with SMTP id
 d4-20020a170902b70400b001560624934bmr24729613pls.116.1651704764277; Wed, 04
 May 2022 15:52:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:58 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-113-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 112/128] KVM: selftests: Drop @vcpuids param from VM creators
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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
index 882b684dc372..6eeaef797ea1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -542,7 +542,7 @@ static inline struct kvm_vm *vm_create(uint64_t nr_pages)
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[]);
+				      struct kvm_vcpu *vcpus[]);
 
 static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
@@ -550,7 +550,7 @@ static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
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
index 96d1daf14dc3..ccd194007e90 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -303,7 +303,7 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[])
+				      struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
 	struct kvm_vcpu *vcpu;
@@ -331,9 +331,7 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 	vm = __vm_create(mode, pages);
 
 	for (i = 0; i < nr_vcpus; ++i) {
-		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
-
-		vcpu = vm_vcpu_add(vm, vcpuid, guest_code);
+		vcpu = vm_vcpu_add(vm, i, guest_code);
 		if (vcpus)
 			vcpus[i] = vcpu;
 	}
@@ -349,7 +347,7 @@ struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
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
2.36.0.464.gb9c8b46e94-goog

