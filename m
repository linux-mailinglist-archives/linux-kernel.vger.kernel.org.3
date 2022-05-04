Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5351B254
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379399AbiEDWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379263AbiEDWxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E0B53E2D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t15-20020a17090a3b4f00b001d67e27715dso3588150pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0nLwtUOlrCY6H6iuzO7O1Ko+feOabX7Ai0gSkCSh+GE=;
        b=NU021v3VWv5BJdKgD0s5e+BojwjxOUpPb6MjxZU4krq3imD0zVIhH9hBvpTOYNBwIv
         PZKhOn9StTHDHOcTsiSLJRxniDd9x5o3sMjCpHeGTHPS3a186/eTGfaYuGN8Qp/u5hvh
         cPxiq/Tkij+hlG/7dnLUC0Y8Sh2d6OoYs+7BhSGlWl8JinseF21WTDIVcB7s3sXenV3e
         ZVO1btEGw+atJYifJQga0YEtwSfEoy1oNttxyyFzHLcIyT+RdJqFu1xZeqGpPiSFnD0d
         iewWoX/HNynHGbSloJgbBlAmeIuRok2tHAepna4VlWCBpNdo8AK2n15GdPl90dinXW9N
         8jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0nLwtUOlrCY6H6iuzO7O1Ko+feOabX7Ai0gSkCSh+GE=;
        b=SHcgrQE1NcO/EehNESZ1L3jElausGdQdK8sFH0iZixXULE2r6YvV8E6pQMiJfQKNzb
         dAey925H/eEMtpXu8FMEJZi7fr9M/ivRoMXjr/zelYtWm7JnZC/hUXOm/Ft9SocAwAmB
         STLcBuUbQgp+b21METORCEqfPgpbQhIdyV7E3Bczl7onUO70xrcr3TLaJy2xWgyiBdS/
         wspb1X8EcZHhoITRmyM2AAIJj4Me5N3TacGflKRgqtNwhaDxIqIubirPEbdsu/Y+2wYJ
         StbO34Y3sNwYjT6+7yxwXHCUiGVym6OHFVyYr03ejNYCb30kwt00ZuFhiO3NXMRcyybK
         fHyA==
X-Gm-Message-State: AOAM532tHY0VPCkBUWduc40diy4mUyvktDnu35siDpwwSHG0yRor+i2W
        SAXvI4X4aTOGUZnOi7zMgJ/6SlxSkm0=
X-Google-Smtp-Source: ABdhPJy5fUxmBhhrHQfLP5m4CIHgD9QKxki712Pdge72NhLZqXncttgZHQEOtQyM3809h/zEZjEgg5EiFto=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP id
 t16-20020a17090ae51000b001d9ee239fa1mr139820pjy.0.1651704596258; Wed, 04 May
 2022 15:49:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:20 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-15-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 014/128] KVM: selftests: Make vm_ioctl() a wrapper to pretty
 print ioctl name
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

Make vm_ioctl() a macro wrapper and print the _name_ of the ioctl on
failure instead of the number.

Deliberately do not use __stringify(), as that will expand the ioctl all
the way down to its numerical sequence.  Again the intent is to print the
name of the macro.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 38 ++++++++++---------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 28 ++++----------
 2 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c2dfc4341b31..39e1971e5d65 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -105,6 +105,27 @@ int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
 int vm_check_cap(struct kvm_vm *vm, long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
+
+#define __KVM_SYSCALL_ERROR(_name, _ret) \
+	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
+
+#define __KVM_IOCTL_ERROR(_name, _ret)	__KVM_SYSCALL_ERROR(_name, _ret)
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
 
@@ -156,23 +177,6 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
 	uint32_t flags);
 
-#define __KVM_SYSCALL_ERROR(_name, _ret) \
-	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
-
-#define __KVM_IOCTL_ERROR(_name, _ret)	__KVM_SYSCALL_ERROR(_name, _ret)
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
index 940decfaa633..7eedd9ff20fa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1690,32 +1690,18 @@ void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
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
2.36.0.464.gb9c8b46e94-goog

