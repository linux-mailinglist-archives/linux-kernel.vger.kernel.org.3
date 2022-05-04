Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09B51B318
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383793AbiEDXH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379418AbiEDXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:00:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A758394
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h128-20020a636c86000000b003c574b3422aso1341522pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ImITDaKyBtkThLaJUpWVVxyOwWtQRhgJK8uxleorh40=;
        b=I5/dXrI0Zyq6aPBwvpxtNVIny30LcjxKzdxTg+xMw2uABG3fTfwqU+CKeyDML3A7WE
         iESb6YqBVExXCIGsVHaIAm5hvPYKw3lYWxsVSLmYdILkTa5cZ8pDnkW/x306HFtCxwoe
         IRwrHnq9Nr5YRwY9oir2y/2Lo0EILNcXKJR6xL6u3/QtNve6r0WMyNWJioGm5cQwyBcv
         BoWOj9KuzLkR8MphZd/e+/Cd+v+9HPbJeRMgan7fxADO0fp3vn9pKeKzIN3qVtB1Xd5C
         Md5v6wfpzwUz3MfM/e7COSB5ZI05qcTEZzEQ4M6HGRqzAbYwygorlDrB/G6ZMqdsm4or
         9PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ImITDaKyBtkThLaJUpWVVxyOwWtQRhgJK8uxleorh40=;
        b=csYiIODw/aM3uphKbIFtf6uHaHbgoD8HCtAoXsFbqxL03M5fjg79NUFUClXAq0AxvX
         jZ7oBKLBJvmSqb1nE8iYrxiY2L9owaHVtScNZHnrZEaz993H1eTC9BUUFxqItnEBevfM
         O134MVIB6llv/mAdHFL7Mr1uGwAYpyUbs24cC31/ZXYN9iUc7Y+kWXmdQ5K3cc2fx09V
         pE6qZxWMoAbuB0AzZRaZzZ7THm4nrb6UxGzB1Tg7648Vw4z//ALWl/wqIUYmzV7DvSQ0
         COW3/UfdeAen1cEIPJKrmWPK6VzI9AJbzxa5qNZKoMBCcpOzVmU3d3GmSsOHxRP9M//u
         9OTQ==
X-Gm-Message-State: AOAM5326wMLsAPZmLE5zmDrPvoeGG5iIDd6N9i5ygUsvnZs8WmFCECi4
        2MXuptDJ9Yo26BioE5VNdIIiMN+v544=
X-Google-Smtp-Source: ABdhPJzExXBkY1l3swQDMZ7ZYuQWL0GSRHERa+Mb9iCOj8Hp691xytqU/tqSPbxCC9s7wFUjfMF+CyAw6OA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP id
 t16-20020a17090ae51000b001d9ee239fa1mr140692pjy.0.1651704779761; Wed, 04 May
 2022 15:52:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:49:07 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-122-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 121/128] KVM: selftests: Drop vcpu_get(), rename vcpu_find()
 => vcpu_exists()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop vcpu_get() and rename vcpu_find() to vcpu_exists() to make it that
much harder for a test to give meaning to a vCPU ID.  I.e. force tests to
capture a vCPU when the vCPU is created.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 --
 tools/testing/selftests/kvm/lib/kvm_util.c    | 34 +++++++------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c0533f2ab418..5ab9b5380310 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -93,8 +93,6 @@ struct kvm_vm {
 			continue;			\
 		else
 
-struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id);
-
 struct userspace_mem_region *
 memslot2region(struct kvm_vm *vm, uint32_t memslot);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 822bdcb5c38c..c5156e0caa98 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -463,26 +463,6 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	return &region->region;
 }
 
-static struct kvm_vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpu_id)
-{
-	struct kvm_vcpu *vcpu;
-
-	list_for_each_entry(vcpu, &vm->vcpus, list) {
-		if (vcpu->id == vcpu_id)
-			return vcpu;
-	}
-
-	return NULL;
-}
-
-struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id)
-{
-	struct kvm_vcpu *vcpu = vcpu_find(vm, vcpu_id);
-
-	TEST_ASSERT(vcpu, "vCPU %d does not exist", vcpu_id);
-	return vcpu;
-}
-
 /*
  * VM VCPU Remove
  *
@@ -1053,6 +1033,18 @@ static int vcpu_mmap_sz(void)
 	return ret;
 }
 
+static bool vcpu_exists(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	struct kvm_vcpu *vcpu;
+
+	list_for_each_entry(vcpu, &vm->vcpus, list) {
+		if (vcpu->id == vcpu_id)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
  * No additional vCPU setup is done.  Returns the vCPU.
@@ -1062,7 +1054,7 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	/* Confirm a vcpu with the specified id doesn't already exist. */
-	TEST_ASSERT(!vcpu_find(vm, vcpu_id), "vCPU%d already exists\n", vcpu_id);
+	TEST_ASSERT(!vcpu_exists(vm, vcpu_id), "vCPU%d already exists\n", vcpu_id);
 
 	/* Allocate and initialize new vcpu structure. */
 	vcpu = calloc(1, sizeof(*vcpu));
-- 
2.36.0.464.gb9c8b46e94-goog

