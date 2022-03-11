Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6B4D5ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiCKFx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346588AbiCKFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:36 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD78F744C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:31 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id w3-20020a17090ac98300b001b8b914e91aso4628604pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=U30BYslSqMgS8jPD44uuCLBCYU7Bi5OSOxGJc5mPP8s=;
        b=FNcwLb7mLFAUSDK/IzRwHT2rVBfteGRQ43JSGQT8n2grIoCb8m1RbHDsZzWRmkWb48
         9MVjBZUzMaYCnc3iY0WHXiBomCjeF3oG2sFEWLpBIPMD8MiNAHJZMNEl23XZiYm975IZ
         16+tzCDLv5DnsJmpzkf8mpFiQipB47DKeZERabm7xqIH2YOH92ZSTBDrHgEegTeTkR4p
         Fx8rhZpWlpgs2OC/kLmSgJpK4m4qyoaHWIX519BRNFIdGNZRNFyL63PZ8WgYybFAQ6rV
         0tP4FaVcYSu9WGkWNkzmRR/ajmyD1HoOW4rWsbIER0L/0efjq+wTNjrWvHvbEkibhOju
         35IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=U30BYslSqMgS8jPD44uuCLBCYU7Bi5OSOxGJc5mPP8s=;
        b=RYYnl8N0i2vM0ArrLLL5E/XaNObWQpDtJD16gtEX1GkJSx0TGC7Ebls5+XAW4WCeR9
         wBFnCRgZ+sTBNmGbcJ1nZ7FH1gCpw9Bg+z0YDWL20jkH/3PS/awT2wrApDjzfeifBkYX
         MQy4rzag0q4erfUP9g5gQiW/ueqEmlYnx5w6Jn+ftvjVESn3Uv0MmmI/HwCKM0xIrnEQ
         doeJhvVJEvoGMrpGogmiTrHRG0UhCs9GFGl+JmxG/e0ifoE6BrFyvZ2dbra/12iPd4Hh
         3oQNbh4tFGKcuRzQgNhPYucLqg6JZk6y+yqFGNvmIN0lTltUgnBlARTStnh3P/Z26bc9
         qlrg==
X-Gm-Message-State: AOAM530RkDU8HGaa5AlZzaCLLWgw7kqNU8AMbfqkC+aX3oc60sUnWgFx
        /ELCK/VZn4iAz8IuatFJoPSbg89TvlVr5zvUc8HuDRXYuUI6xU/nBlmuiHjWYgKjT6qbalINpGM
        Gpli5q/fSdPsxRgTOtnbUqcs/VDWszPdfexU7Pog5hLfQ5Y9hKlh+K4e3A/+bLiw0bMEafA==
X-Google-Smtp-Source: ABdhPJyhyV97BT9f/9mApo1EDzJ793e/VzYIsTLRMdBPIF87JzEoq+Z2Ob8e0Wd2qwtSYHsi33ui2dj3f3s=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:20c4:b0:151:fe42:aaa3 with SMTP id
 i4-20020a17090320c400b00151fe42aaa3mr9017221plb.44.1646977890912; Thu, 10 Mar
 2022 21:51:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:26 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-16-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 015/105] KVM: selftests: Make kvm_ioctl() a wrapper to
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
 .../selftests/kvm/include/kvm_util_base.h     | 16 ++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 31 +++----------------
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  2 +-
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 09e84ce50331..e8dff9bdab89 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -109,8 +109,19 @@ int kvm_check_cap(long cap);
 
 #define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
 
-int __kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
-void kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+#define __kvm_ioctl(kvm_fd, cmd, arg) \
+	ioctl(kvm_fd, cmd, arg)
+
+static inline void _kvm_ioctl(int kvm_fd, unsigned long cmd, const char *name,
+			      void *arg)
+{
+	int ret = __kvm_ioctl(kvm_fd, cmd, arg);
+
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));
+}
+
+#define kvm_ioctl(kvm_fd, cmd, arg) \
+	_kvm_ioctl(kvm_fd, cmd, #cmd, arg)
 
 int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
 void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg);
@@ -484,6 +495,7 @@ unsigned int vm_get_page_size(struct kvm_vm *vm);
 unsigned int vm_get_page_shift(struct kvm_vm *vm);
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
 uint64_t vm_get_max_gfn(struct kvm_vm *vm);
+int vm_get_kvm_fd(struct kvm_vm *vm);
 int vm_get_fd(struct kvm_vm *vm);
 
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 974de21eef23..1b120c7a7845 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1580,32 +1580,6 @@ void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg
 	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));
 }
 
-/*
- * KVM system ioctl
- *
- * Input Args:
- *   vm - Virtual Machine
- *   cmd - Ioctl number
- *   arg - Argument to pass to the ioctl
- *
- * Return: None
- *
- * Issues an arbitrary ioctl on a KVM fd.
- */
-void kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
-{
-	int ret;
-
-	ret = ioctl(vm->kvm_fd, cmd, arg);
-	TEST_ASSERT(ret == 0, "KVM ioctl %lu failed, rc: %i errno: %i (%s)",
-		cmd, ret, errno, strerror(errno));
-}
-
-int __kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
-{
-	return ioctl(vm->kvm_fd, cmd, arg);
-}
-
 /*
  * Device Ioctl
  */
@@ -2039,6 +2013,11 @@ uint64_t vm_get_max_gfn(struct kvm_vm *vm)
 	return vm->max_gfn;
 }
 
+int vm_get_kvm_fd(struct kvm_vm *vm)
+{
+	return vm->kvm_fd;
+}
+
 int vm_get_fd(struct kvm_vm *vm)
 {
 	return vm->fd;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 7e45a3df8f98..896e1e7c1df7 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -123,7 +123,7 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, bool system)
 	if (!system)
 		ret = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
-		ret = __kvm_ioctl(vm, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+		ret = __kvm_ioctl(vm_get_kvm_fd(vm), KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
 	TEST_ASSERT(ret == -1 && errno == E2BIG,
 		    "%s KVM_GET_SUPPORTED_HV_CPUID didn't fail with -E2BIG when"
-- 
2.35.1.723.g4982287a31-goog

