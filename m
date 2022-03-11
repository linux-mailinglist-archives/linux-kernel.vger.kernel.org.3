Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5784D5AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbiCKFwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346534AbiCKFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A59ED94F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h12-20020a63530c000000b0037c8f45bf1bso4234654pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OGdeptO7GDLnSXzyDOFVHXNsC4c15uqK/LE1tOkpfmU=;
        b=nVV1f4vOqOQ6LkkTLgIp1v/U7+YVR4vCaUcitzqAj2VPCGFry8haznr5aq/oNfwSzD
         lw8l7HuSlPBKXFGvrKQ7zrpUJF0I3ABv4k9/Fro/uDxdXMQoSALr0R+Y6mgosFFwjJyN
         KnRPzW2iUi7RjS6KiahtlXXHRFvN+/dtEpQV1EeZM7eS50I7ZtCQ03XWJZ+Xr+uF32QO
         hDq68lRTTKUx+oF9CkApTK6R8DzeDSNimlAe5vrB9t5FxRxozPVgUqpqm3QhtM4p9Jk9
         zqpj+qu9F4mpNvrGHjX5KoWhwHSq48GWBmXME48YaO/+65PbXjX8XITRl4xbGl9GBCyN
         N8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OGdeptO7GDLnSXzyDOFVHXNsC4c15uqK/LE1tOkpfmU=;
        b=6851wgdpVres2kt+yYBuZHRhTzAWSc8NcUWgZJWiYa9lHHeMtiz2Q4P3gDL9+6HNJC
         ArviDRnzK8c0T+J64C2A7vW1WIV1p3BK3YLadbP64oY6t/FcR/3fj2d3+sHCotes2f5D
         Wl56s/SUbNuVljdMikiHd5Pjfz9h6Ec1mnvMlVClys7O9R+fBE6Pwtyy+neeBOVdMj5m
         GsU/MBvzlhCKrtOeDPmgFdwt3IWJiX8g2i1FJcUpQRFknI5VmVjCRdRX1+NiV1ogeSEc
         dr5Ok3SSQMRGiUh6ouuZ2xo1zllA4kXzCgRtzzfKI2p7uWbntEcKB04yjJ5l06KhyJhw
         d1+A==
X-Gm-Message-State: AOAM532TIl/N2d1v51j/EqB7J3LU+qcsqtyCix3KHR4AxabH6ZR/rNvk
        CWNyBAQaaVpnTLu9lWgUl+ljoVFrhek1+XVIZFvlaASUnnTyP3HEVP38Zxc0M9zdIt8HTaXfv5c
        JoOxwmz+JAOvGEajKTN++ioI3EYnVguaSeOC/2vP1Q2FStDMgV631ZtXwLHn/3RrR7qlvSg==
X-Google-Smtp-Source: ABdhPJxNasJKZcvVk8lhnCtbgrZg1mXpU7HT/blAC83f0jJvgcsihlc/lOrTRiJXtS2cjYHIj0W/EHGQUFk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ee95:b0:151:8518:9f49 with SMTP id
 a21-20020a170902ee9500b0015185189f49mr8653226pld.1.1646977873268; Thu, 10 Mar
 2022 21:51:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:15 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 004/105] KVM: selftests: Make vcpu_ioctl() a wrapper to
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
 .../selftests/kvm/include/kvm_util_base.h     | 12 +++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 31 +++++--------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 77aaac4d344e..28440c12ffbc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -152,10 +152,18 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
 	uint32_t flags);
 
-void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		void *arg);
+#define __KVM_IOCTL_ERROR(_name, _ret) \
+	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
+
+#define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
+
+void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
+		 const char *name, void *arg);
 int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
 		 void *arg);
+#define vcpu_ioctl(vm, vcpuid, ioctl, arg) \
+	_vcpu_ioctl(vm, vcpuid, ioctl, #ioctl, arg)
+
 void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
 void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6f515333abe0..a6675d9aa7d9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1898,29 +1898,6 @@ void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
 		    ret, errno, strerror(errno));
 }
 
-/*
- * VCPU Ioctl
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   cmd - Ioctl number
- *   arg - Argument to pass to the ioctl
- *
- * Return: None
- *
- * Issues an arbitrary ioctl on a VCPU fd.
- */
-void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
-		unsigned long cmd, void *arg)
-{
-	int ret;
-
-	ret = __vcpu_ioctl(vm, vcpuid, cmd, arg);
-	TEST_ASSERT(ret == 0, "vcpu ioctl %lu failed, rc: %i errno: %i (%s)",
-		cmd, ret, errno, strerror(errno));
-}
-
 int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 		 unsigned long cmd, void *arg)
 {
@@ -1934,6 +1911,14 @@ int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 	return ret;
 }
 
+void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
+		 const char *name, void *arg)
+{
+	int ret = __vcpu_ioctl(vm, vcpuid, cmd, arg);
+
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));
+}
+
 void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu;
-- 
2.35.1.723.g4982287a31-goog

