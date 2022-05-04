Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7F51B306
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384023AbiEDXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380319AbiEDW7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:59:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267A57108
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y17-20020a637d11000000b003ab06870074so1337313pgc.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6HSIjMhV1FkDSn9Q2dZiNlWH0XvamyXxhC0LlfB3b9Q=;
        b=DkRxlPcdbrbXKsKMK7kQ7JDeVGO2p2CzUK+kcqRqxCoet3tc5Dt5oyxJtVZNwIeigO
         ttI0bdDGSThuuBloWZkUkbqqdPf1hU2Kf/o1C1wZTrmfdrP9ZNAqQgYuFvlfyFcUAnDF
         mrViP4skJBJSSrb+Q20n9Kv7C4H/CSfkpChjZr+RykBIVIuLu0lNp7Z+B3ZXTf8dFxRT
         WqDuZ5ibzRj6oRqVBqIR2lXZ/nzRJgiJMwXSu9GjhJPwBJLdv/gWfpGVwsc6W1G/yl8f
         ntCIGN1lSE+SxsjhadwHWLNXNRJwClPh6wPftNDAqm32mzeVrgO11Ib1WFcgemsbqHmp
         wUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6HSIjMhV1FkDSn9Q2dZiNlWH0XvamyXxhC0LlfB3b9Q=;
        b=T5VUGr1xjSsnbFHs5VMAkz/87NNnSYEuhtFqz5re+ejUQgkeyXo5TNN2kGHousIaYi
         KBf+iphAePaVhuWvOzqhVc4idHoKlOefkc5h73kSH3k4fLioWFPKhT+UwcqkJIHuILS6
         eCh3I2aeaFR40Eo7AfCO8w1UhVUG/P8k+uMP7aQfLI784XIDHKFwnnsL/mrzvRq3Jw0a
         Lqd9fhTBNgxROLAP1Ac6HGh+MBtHsE6+mx0QOCaX3vqpSveY1Kgcc3fXwLGOgD4tOA52
         qBlemMxUK3jUnyzTZ67Zstswh7Xual95RI49v6mcYjNVIu9zXDHP8n/ahAtn8vmjVANr
         p7RA==
X-Gm-Message-State: AOAM531EeOieo8qpSqHMxs1I0foNjJyYWMJjMc/2bNDOra89rhYuWbPz
        rEKat1yRxZkRx2BVZg82UXDS3W22o10=
X-Google-Smtp-Source: ABdhPJxYHAVE8NMpqzvg79GDxP5iYL+Sq/Qsi6yll75i+qhzI1I08BjzeT6eLToG03Jc89JlQP+pbfWksSY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:e80d:0:b0:50d:8f8e:ffb8 with SMTP id
 c13-20020a62e80d000000b0050d8f8effb8mr22843748pfi.37.1651704762430; Wed, 04
 May 2022 15:52:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:57 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-112-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 111/128] KVM: selftests: Drop vm_create_default* helpers
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

Drop all vm_create_default*() helpers, the "default" naming turned out to
terrible as wasn't extensible (hard to have multiple defaults), was a lie
(half the settings were default, half weren't), and failed to capture
relationships between helpers, e.g. compared with the kernel's standard
underscores pattern.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 23 -------------------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 +++++--------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 2ddf0854c24d..882b684dc372 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -538,29 +538,6 @@ static inline struct kvm_vm *vm_create(uint64_t nr_pages)
 	return __vm_create(VM_MODE_DEFAULT, nr_pages);
 }
 
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
 /* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
 struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 				      uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 838a3eda9381..96d1daf14dc3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -341,28 +341,17 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
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
2.36.0.464.gb9c8b46e94-goog

