Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B04D5B01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbiCKFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbiCKFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F913FABE6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:52 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k130-20020a628488000000b004f362b45f28so4617535pfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kgxCOayuOfCfyQ/cB0i9Z9RutZCvQT+K5y78pquGYSc=;
        b=dm8K0vIoWRCu9ziESuUfuBYtCsMRUblpAfXcUhQEu8kpN2aYyRgi8ntjPI06+g144r
         ovX/3X2wFr1MLVZL4s1Fw6LT2Kcb0m6UQhQCFa14ifK/R91VuzJ24F4Ll7ozBJrwDY8Y
         qsivp/qQHK7Cg2O4k83TV0QrWkZtNF5c2obysNtHfg7Xb0ipBFnrvDYKjVUxkof2IhDU
         XiHAtzKRioyA5KzqM7OgDSOz6UOyZIh76c9fAruhvq0nSf7QPiHe4HB8/Nwlg/j+/8B8
         jXUKZt5aGcU3yZ3LRCFgYwc5ua0LmbJbhDNv7Km+wQ6oFYfi4aDkMnr1dD0nx/TDxTkL
         HVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kgxCOayuOfCfyQ/cB0i9Z9RutZCvQT+K5y78pquGYSc=;
        b=VpoVDOCXpxMVpqBa78J6+Mp1a6uGtqfW7kb2n+jG+wf+BmmJuji9fhfzCU+9hfMttI
         iO0gRM7CDs246Bkn4kPaS5m1f+3v9tGmo24mqM+AHwQIDYxBBtzAM/WCTuo6JMlf98dK
         LsassBk9Wf45vX0pbaHYIEhycxF53YC3VluKdZ4cFBIPphdoeFsXKQ6+sKFDczqeRrE+
         NsQ9RZvUwDrtep5gsd+B6bULnM8Dxy6Ed1L1uW9Fo7rTRVKEKaMPFYQdWEEzW+TwRIXJ
         nZBXUUKfvAZmsoHT7J02VeglVp6iaSbbAGRmx16QbljLy1Ope/+OBOqzAoXNFrC2fyAq
         uUEQ==
X-Gm-Message-State: AOAM530W2ErvSK9c75YMr4ccIt8UsmmL/ojwhebrzrUbsrp3R3odrcTG
        aTqM+wXRLyOgRebi+aYXiKlxYdKnq4NZBdzITEhiTWSmhCvuAk6cJ1XyT5BiLB9Hl8Bf+RxxQ7D
        +XlUl3LSQs7uOXC0T5CzfvnpQS6JAOsLjvVquLEBKbDvwrnq58kR5Bi08+MLQpsGQoqsU8w==
X-Google-Smtp-Source: ABdhPJxw2ReaMDDN9SJrY6nV/XjF6hRxFCd4B2TkFx4aXHyDWnOjsZezpCPfmTvc65IMa+nVFzNVPQDkUWU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461196pjb.0.1646977911305; Thu, 10 Mar
 2022 21:51:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:38 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-28-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 027/105] KVM: selftests: Add vm_create_*() variants to
 expose/return 'struct vcpu'
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
 .../selftests/kvm/include/kvm_util_base.h      | 17 +++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 21020d6a4f01..e87988665607 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -619,6 +619,23 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				    uint32_t num_percpu_pages, void *guest_code,
 				    uint32_t vcpuids[]);
 
+
+/*
+ * Create a VM with a single vCPU with reasonable defaults and @extra_mem_pages
+ * additional pages of guest memory.  Returns the VM and vCPU (via out param).
+ */
+struct kvm_vm *__vm_create_with_one_vcpu(struct vcpu **vcpu,
+					 uint64_t extra_mem_pages,
+					 void *guest_code);
+
+static inline struct kvm_vm *vm_create_with_one_vcpu(struct vcpu **vcpu,
+						     void *guest_code)
+{
+	return __vm_create_with_one_vcpu(vcpu, 0, guest_code);
+}
+
+struct vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
+
 /*
  * Adds a vCPU with reasonable defaults (e.g. a stack)
  *
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ed7e2c5b0062..0c088454e600 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -365,6 +365,16 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 					    (uint32_t []){ vcpuid });
 }
 
+struct kvm_vm *__vm_create_with_one_vcpu(struct vcpu **vcpu,
+					 uint64_t extra_mem_pages,
+					 void *guest_code)
+{
+	struct kvm_vm *vm = vm_create_default(0, extra_mem_pages, guest_code);
+
+	*vcpu = vcpu_get(vm, 0);
+	return vm;
+}
+
 /*
  * VM Restart
  *
@@ -399,6 +409,14 @@ void kvm_vm_restart(struct kvm_vm *vmp)
 	}
 }
 
+struct vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
+{
+	kvm_vm_restart(vm);
+
+	vm_vcpu_add(vm, 0);
+	return vcpu_get(vm, 0);
+}
+
 /*
  * Userspace Memory Region Find
  *
-- 
2.35.1.723.g4982287a31-goog

