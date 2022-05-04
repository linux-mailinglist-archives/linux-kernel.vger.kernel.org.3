Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC951B315
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379618AbiEDWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbiEDWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:06 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78831120B2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z16-20020a17090a015000b001dbc8da29a1so1315913pje.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CCjFdttK3ojszU+ceLKLHTNc3RJgVsyUXIdUXpmHmJ0=;
        b=F8oSR/oCtITryrxXQb/bUhxlifCVsN/ZGwm4DP8RxFYPNw2529DRRxU7jT6Q+sX6K3
         iqybSuhKP3aJykLC5j03lrbtFgELCVkIP9wzWSDeLRUtOyon3zZ52GaTk9QHaBb0zhnq
         p8GOx2WjqEmArX9vHnsCatMp7KsgCmsQAD7z+9VT4xJlA+o3qV4gwBfo8v24VO+mOEPV
         KpEEbr1L5Czfqe9457KQkn4vSX0zcSO1+ToIExzzEq6sEVUQPTFm95w4kmFo76dyri0e
         KNTnByyik9cdij91szDVlprIduTWrDpl7M8KrDXDSCDNYmJ2jUgH8GE/ZBu2bF6xaleX
         6YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CCjFdttK3ojszU+ceLKLHTNc3RJgVsyUXIdUXpmHmJ0=;
        b=yjAxZ31s6ZgE756QX1Clq52mNUWQ+RsWybmXWsAPyfJytyUr9QR84n6J7viDvJ/oU/
         FSn+OQQZb3n87jFOU+hFcVRp8nWiHadZfB8hI5pKBdQ9f/MmE3k0A3aXfOjakPG4wfIy
         s54zP+Tcy38Rz7mTfS81VyeWqznylgabq5phmqlLVDzp8YpFDNjVP/m+rkQ/+lkDaLDL
         2Mmi93hCnXSq56+5vYgZGI9tVug3YgGxv6xVjSCJHJAdW8/6KRLBnJGlDKSLD3bwa8gx
         Wlz2cNmKXQ/zfN4qanx+rDdc8j9YCl4zGwg/HEtYncamJKrOOFaHlnxCiKCk5GIUhLDI
         susg==
X-Gm-Message-State: AOAM530bG3/KjtwJgqX/EeyA7yFM0jNiSKQ/AoW4fcUCHhZpu2FFHSb/
        Ivx7sZr9SIQrqPNhcewCj5uDSSlXITc=
X-Google-Smtp-Source: ABdhPJyF+9X097h6QDljW/0vVEuPwsUfGtuebUGPmAllqyCOQx3Y0xbVnWuSrXw9faXvqvdPZa8xp0sE0gU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id
 j10-20020a056a00174a00b0050d44ca004bmr22965190pfc.0.1651704621604; Wed, 04
 May 2022 15:50:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:35 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-30-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 029/128] KVM: selftests: Add vm_create_*() variants to
 expose/return 'struct vcpu'
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

Add VM creation helpers to expose/return 'struct vcpu' so that tests
don't have to hardcode a VCPU_ID or make assumptions about what vCPU ID
is used by the framework just to retrieve a vCPU the test created.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h      | 16 ++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 5d06d384bf10..07c453428e06 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -627,6 +627,22 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 /* Create a default VM without any vcpus. */
 struct kvm_vm *vm_create_without_vcpus(enum vm_guest_mode mode, uint64_t pages);
 
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
index 937e1b80a420..bf14574288e7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -373,6 +373,16 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
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
@@ -407,6 +417,14 @@ void kvm_vm_restart(struct kvm_vm *vmp)
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
2.36.0.464.gb9c8b46e94-goog

