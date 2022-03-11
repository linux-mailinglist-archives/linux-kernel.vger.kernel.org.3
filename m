Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507A4D5AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiCKFyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346574AbiCKFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C0F65FE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m14-20020a17090a4d8e00b001bf2d4926c5so7280337pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=lIUB4qj7fpuCOBqeayWJn3UXJ9Pxwe0onYdsgb7hw0A=;
        b=bMnfVlFJ2I4svXMcRb6J6mYB7p1XwKtTnUoWFbt0hE+0Y0imWFW/QHHehQ/pD64Txz
         UoF5sxs7J1JHuyMMg8KZJzNvVGigvnCowPP11/aBi37dymu4oHi1JSrhJUJcfzC9z/9Q
         MjmDMBEZdclzwKCIefgyNDZ/ypJqSkrgGL2biq6MTmecL7WwQnLtrO8/EidEbHCFekeL
         A+oK/R2BwITZZ873VisucROEFoCL3gblG1jH7p4t9nqvC2RXpWHbJGjQtn1BF+RsPIQB
         vdpzSbMSP8v0T0Fpj3ZC7PuPFe/t71cy13KynYuYpI9JmIV192pY7waygDHqEsm1tL9h
         orqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=lIUB4qj7fpuCOBqeayWJn3UXJ9Pxwe0onYdsgb7hw0A=;
        b=F4eDFBKhaMHOtdQGmxaiKO0y88elV8KXvSHQ6ubp8VHNNPytSCZftC+KC5c26Lzw68
         muljTQiRlCFlfzf+V/h6o+aln3hrgz1napqgLPF8SRkZGk4SqQSargi6hz7LOCVz5b82
         88G+fOthbIQgW23orHDw2MvhR5cxKbS9cCw0RlDMGxVguGEiAnAkUjwO8jnoXWYtAvOP
         wNz4pyDaqwJnnzEV37/F+bprGkNwzFkt8LWof7Mm+njtqM6yHCTYp8FGLjz3MRDzALXp
         bUYAmUTBc7VvYRoO1VJ5NiXVBOA0gJ/sJsg88cizWBO/SS9Gob1lCkNuwUdPobIXgdoS
         w5bA==
X-Gm-Message-State: AOAM531dLOy6AloCMpHkMwHdkXPo5oJ/gIosWCMocczg45dxM673EE7b
        iVIPxeOxa52o1dkY3l+mz9mpoTdM3RPDc00Al0v5DSoHkgeT6RgJvET0VJzzDHVd/vs1M6Y1x6p
        17Of5f1hpXnEvwmkWgztO8zBlkTh88Jv6HlevQbAKsgo9tX7AzCTj/W22kRXZbIhmfREfYA==
X-Google-Smtp-Source: ABdhPJwvVWgQ/qlK1dREYuK1HTus6CFRiBYVbGbH0iemh6a49GCqTOgm0x/zYJ0SX8cBkC7sniQVD0vlMaU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec81:b0:151:f1c5:2f9f with SMTP id
 x1-20020a170902ec8100b00151f1c52f9fmr8713480plg.123.1646977887660; Thu, 10
 Mar 2022 21:51:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:24 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-14-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 013/105] KVM: selftests: Make vm_ioctl() a wrapper to
 pretty print ioctl name
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

Deliberately do not use __stringify(), as that will expand the ioctl all
the way down to its numerical sequence, the intent is print the name of
the macro.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 36 ++++++++++---------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 28 ++++-----------
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index be8882dbe38a..bcffd9f85490 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -105,6 +105,26 @@ int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
 int vm_check_cap(struct kvm_vm *vm, long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
+
+#define __KVM_IOCTL_ERROR(_name, _ret) \
+	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
+
+#define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
+
+int __kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+void kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+
+int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg);
+#define vm_ioctl(vm, cmd, arg) _vm_ioctl(vm, cmd, #cmd, arg)
+
+int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
+		 void *arg);
+void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
+		 const char *name, void *arg);
+#define vcpu_ioctl(vm, vcpuid, cmd, arg) \
+	_vcpu_ioctl(vm, vcpuid, cmd, #cmd, arg)
+
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
@@ -151,22 +171,6 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
 	uint32_t flags);
 
-#define __KVM_IOCTL_ERROR(_name, _ret) \
-	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
-
-#define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
-
-void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		 const char *name, void *arg);
-int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		 void *arg);
-#define vcpu_ioctl(vm, vcpuid, ioctl, arg) \
-	_vcpu_ioctl(vm, vcpuid, ioctl, #ioctl, arg)
-
-void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
-void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int __kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d45f2ec7b13e..a37baaddfeaf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1652,32 +1652,18 @@ void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
 	return vcpu->dirty_gfns;
 }
 
-/*
- * VM Ioctl
- *
- * Input Args:
- *   vm - Virtual Machine
- *   cmd - Ioctl number
- *   arg - Argument to pass to the ioctl
- *
- * Return: None
- *
- * Issues an arbitrary ioctl on a VM fd.
- */
-void vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
-{
-	int ret;
-
-	ret = __vm_ioctl(vm, cmd, arg);
-	TEST_ASSERT(ret == 0, "vm ioctl %lu failed, rc: %i errno: %i (%s)",
-		cmd, ret, errno, strerror(errno));
-}
-
 int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 {
 	return ioctl(vm->fd, cmd, arg);
 }
 
+void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg)
+{
+	int ret = __vm_ioctl(vm, cmd, arg);
+
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));
+}
+
 /*
  * KVM system ioctl
  *
-- 
2.35.1.723.g4982287a31-goog

