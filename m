Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B684D5B49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiCKGCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbiCKFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB6210077B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:47 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so60714007b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7S+sogfkTHCN8PvKieHvUcDB5oUV+qAvQ7j4xyqNqSI=;
        b=Z3UujuDimW53k/l1MWX50jt9w2LPYFbYyPPurCSq4/D2FiXfpRzJ109ZjoaGzsF5s0
         TA8nJjte9Hctcto+it0cLeSAuph+Id3yFLn+ryyRy7GUEcSwqGUlIZZhE1hRR/cfkypt
         cFAm5AgPXqB7dkqIRsBbehwz6BVIi03A+nYwBbYagx50qrmhyH+o0gQIggI9vvqcXYCB
         bqQ11CctfrnnivZkIgf4kqhpOETe/5WEv48Wyjw0x3ftXZ51Y5NMCvfg656vF5nZL8Vv
         y+uqJihXRsUoi3XcVPyMugrop3LiMQigBs/ntGlVv2B79S0uZwGmFFRwhNalTwu5XTMx
         DyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7S+sogfkTHCN8PvKieHvUcDB5oUV+qAvQ7j4xyqNqSI=;
        b=uzLcR+SQM8ZLU+VVxFpRDKIOG/r2XejI7voZI2lGsddaKnWZLMvfhfTb7rxFLuzfVC
         CfPT+/FfUiT3nHP660/t12ZW4XkSb4+4AisiLv9Q/WbjAo4tDo1jTHzQI5wIbr/dAQfV
         xKhvK6DM/vPvcfQcQQ3HboukRah5L/dyXkqE+4LRkB+K/rZNC6dfHH6mxRg/ok9s6a0Z
         znSv8c6tODJhyOq3uGq2DxhftFwuNZCjyKS8lumLfylkp+2jmcS47RpyJqaRUVKrQUdJ
         rpHEQLSrGE1yW4fWYFUqI4D3bbWaKSsiUphwHEBpU7LVeM6FsykAvy4FcKFyo88JPRON
         p/nw==
X-Gm-Message-State: AOAM531+gl105TM/wvq7xhBu8uc2gKhiXahP3kCdCA4yb+zPtFKOK/Zm
        CjuFGpkG1nxiriGilYZ+J60SBmlKiWHhO1DTqr5E/qLGcrc6wjPhlATrKPsMmsUhxhh2v8bRDra
        yF9nOevz+Lqtq7UxQw593HCuCDrtKqq6dURia+/NR5oNN5+q9gWisfFQBxYcCDrXXBPRpaQ==
X-Google-Smtp-Source: ABdhPJwd1wYoCF16lYoSN8c4z4Uiu/3AzODQr/0b0YnzNhZCbFyqElFbuGW7XOHD4g/o+2WNNPlwRe9bZBY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:6854:0:b0:628:9263:c327 with SMTP id
 d81-20020a256854000000b006289263c327mr7008339ybc.184.1646978026198; Thu, 10
 Mar 2022 21:53:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:46 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-96-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 095/105] KVM: selftests: Drop vcpuids param from VM creators
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
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++--
 tools/testing/selftests/kvm/kvm_page_table_test.c   | 2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c          | 8 +++-----
 tools/testing/selftests/kvm/lib/perf_test_util.c    | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 608f9d3cdfbf..391f72eb9bcb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -520,7 +520,7 @@ vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[]);
+				      struct kvm_vcpu *vcpus[]);
 
 static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
@@ -528,7 +528,7 @@ static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 {
 	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus,
 				      DEFAULT_GUEST_PHY_PAGES, 0, 0,
-				      guest_code, NULL, vcpus);
+				      guest_code, vcpus);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index b969257f646d..a3e3957f67fa 100644
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
index a89369505232..861d18ed868d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -308,7 +308,7 @@ struct kvm_vm *vm_create(uint64_t phy_pages)
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
 				      uint32_t num_percpu_pages, void *guest_code,
-				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[])
+				      struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
 	struct kvm_vcpu *vcpu;
@@ -343,9 +343,7 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 #endif
 
 	for (i = 0; i < nr_vcpus; ++i) {
-		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
-
-		vcpu = vm_vcpu_add(vm, vcpuid, guest_code);
+		vcpu = vm_vcpu_add(vm, i, guest_code);
 		if (vcpus)
 			vcpus[i] = vcpu;
 	}
@@ -361,7 +359,7 @@ struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
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
2.35.1.723.g4982287a31-goog

