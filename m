Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439894D5B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbiCKGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbiCKFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C1FCB48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 64-20020a621743000000b004f778ce34eeso2060058pfx.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hnr6XEqehIXzCALgq9vRASMm6oo2AIu/MDOgH1LyShk=;
        b=EoAgH5cJ31OJjhXsxuxR7e6zL32VPZA1g5mhlp8NSkqu6WpqnN7tDwnR+BwidyrDHZ
         pAKDW7xU+9JeydShcuwof5FE5nB2xiMZF4pCXYy3utxwDDQ2dDIQdbhJRXQdhfLtRcSN
         ldRCHIBqwAibsAScSbT+Nw6lmZTleUEhtebNqzqG85lkPxptvWG74elShld6F6clTIje
         Pqzqdn9TkCTBRjfia/iKSXrQ1Jqm4yfuRihsxbz2fIwnQdrxcYN506d2H17KZc9YErfk
         RJis4C1EWALn1bzMWMEqwpOFrQJ0n9WeZwoYLDmMek/pOr6CcApLohsdahFyY4YmaNLx
         pRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hnr6XEqehIXzCALgq9vRASMm6oo2AIu/MDOgH1LyShk=;
        b=KVQSpkHi75fVKbO+pHO96f/CpYm1X5oZaOpJlj9Iq03G4RrCFF229pyR8vMHS2Jb5m
         6VhnegO8IP8yk7+cQOLVAg9yzV60t/29i1D+q8VK7Z5YUc9KFz07/qL0UubCQsjJqYzc
         HV+6kgsmWjnn34fO+OjaQmOGMINUK6tVg+fQ5oft+cg9UfMQcI+5PgwrtCGERRWa9EZT
         lnSUUugI3sH1lSeFgCk+3bUC7Lxdha33wkPr/BvlHhwaB4chiTQe7aZI2fh3CxM+6tud
         5qSjUuMxoxomN7lXHzaAW0VI4BIpQj0nW/pEcXuEoxhFdI6exOvFlz/eH3xOQBghvnml
         WssQ==
X-Gm-Message-State: AOAM5332XTuHbE4JmLVvR/DlMcA5gep67ZbTsSmpBjeu2HdLN0W7mWfy
        fcAhqdzJkl7DB93jxn81L/sQrbk0IiVEk+N6Q9F0Ltq1KBx2mHohCK2jQtASG6a8aEZuVGP2c3G
        UEc3VxzgmlIJvZ0VJjIc/Xd5nQ8MOtmd+XN9LN+vav7JzEFTwN4Ho9OmMZth83AFCpH8YYQ==
X-Google-Smtp-Source: ABdhPJzX+Pnx85Bo0dMNSMCJtoCR/r5g9PUrtYDfOe+8lfxOmFP6cvRUh9u+RsJbE9AUrqZmlGq2yN8yoOo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2312:b0:4f7:2d1f:d83e with SMTP id
 h18-20020a056a00231200b004f72d1fd83emr8785234pfh.14.1646978008030; Thu, 10
 Mar 2022 21:53:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:35 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-85-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 084/105] KVM: selftests: Add VM creation helper that
 "returns" vCPUs
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
 .../selftests/kvm/include/kvm_util_base.h       | 16 ++++++++++++----
 .../testing/selftests/kvm/kvm_page_table_test.c |  4 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c      | 17 ++++++++++-------
 .../testing/selftests/kvm/lib/perf_test_util.c  |  4 ++--
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 14457f98080b..051d9707e2e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -541,11 +541,19 @@ struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_me
 					    uint32_t vcpuids[]);
 
 /* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
-struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
-				    uint32_t num_percpu_pages, void *guest_code,
-				    uint32_t vcpuids[]);
+struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				      uint32_t num_percpu_pages, void *guest_code,
+				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[]);
 
+static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
+						  void *guest_code,
+						  struct kvm_vcpu *vcpus[])
+{
+	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus,
+				      DEFAULT_GUEST_PHY_PAGES, 0, 0,
+				      guest_code, NULL, vcpus);
+}
 
 /*
  * Create a VM with a single vCPU with reasonable defaults and @extra_mem_pages
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index ba1fdc3dcf4a..b969257f646d 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -268,8 +268,8 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
-	vm = vm_create_with_vcpus(mode, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
-				  guest_num_pages, 0, guest_code, NULL);
+	vm = __vm_create_with_vcpus(mode, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
+				    guest_num_pages, 0, guest_code, NULL, NULL);
 
 	/* Align down GPA of the testing memslot */
 	if (!p->phys_offset)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1580d4888d74..de568d0a2ccc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -305,12 +305,13 @@ struct kvm_vm *vm_create(uint64_t phy_pages)
  * extra_mem_pages is only used to calculate the maximum page table size,
  * no real memory allocation for non-slot0 memory in this function.
  */
-struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
-				    uint32_t num_percpu_pages, void *guest_code,
-				    uint32_t vcpuids[])
+struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				      uint32_t num_percpu_pages, void *guest_code,
+				      uint32_t vcpuids[], struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
 
@@ -344,7 +345,9 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	for (i = 0; i < nr_vcpus; ++i) {
 		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
 
-		vm_vcpu_add(vm, vcpuid, guest_code);
+		vcpu = vm_vcpu_add(vm, vcpuid, guest_code);
+		if (vcpus)
+			vcpus[i] = vcpu;
 	}
 
 	return vm;
@@ -354,8 +357,8 @@ struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_me
 					    uint32_t num_percpu_pages, void *guest_code,
 					    uint32_t vcpuids[])
 {
-	return vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
-				    extra_mem_pages, num_percpu_pages, guest_code, vcpuids);
+	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
+				      extra_mem_pages, num_percpu_pages, guest_code, vcpuids, NULL);
 }
 
 struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 722df3a28791..5b80ba7f12e4 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -139,8 +139,8 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	 * The memory is also added to memslot 0, but that's a benign side
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
-	vm = vm_create_with_vcpus(mode, vcpus, DEFAULT_GUEST_PHY_PAGES,
-				  guest_num_pages, 0, guest_code, NULL);
+	vm = __vm_create_with_vcpus(mode, vcpus, DEFAULT_GUEST_PHY_PAGES,
+				    guest_num_pages, 0, guest_code, NULL, NULL);
 
 	pta->vm = vm;
 
-- 
2.35.1.723.g4982287a31-goog

