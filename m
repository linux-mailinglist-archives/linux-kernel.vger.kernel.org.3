Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974D84D5ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbiCKFwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbiCKFwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:20 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F5ECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d13-20020a170902b70d00b0015317d9f08bso2687083pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+//LVsfWbe87jUmquz/Z+X7CZ4GkPj4POMfX1hZXHjc=;
        b=J/PhaPb1/f7/9vzeB48d5h7wWcTsMXkMNef9B/X1bIgJf8GNCTGUFekdZ9bElmSk11
         4vIrkh7iT58T2Avnwn0MhH4hg0CM8cqAiORgb0XPd6UppjZ1B/WnOjM9aPkVrzk2ndfX
         UE0FdPS3L1j8DqLzdNLei2dRhI6AjVMdRABwYB8DXXzdL+TZGT04gmjthDoUcAL0/JJc
         P8G6dPa99swN1nxgpVem2Zk4sCuqKkoQm7Hg1dR/4UtZP0srTw4CmQgMNs31uqCqP/g0
         w2XyXFIu85/XrhUcQKWK5tVGQv4bgSMUKrAPEgo3P6CP4pBygCYCAHgpi2B3g09lfDa+
         dJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+//LVsfWbe87jUmquz/Z+X7CZ4GkPj4POMfX1hZXHjc=;
        b=lA+tyCbsf9O7cwHcWIZTDp3ZMpk6z+mE68CXBEsY+ET14GwNuwNQjB1TSHJDJqWZWV
         LwFBj1hv065DvI5wf9crKMUKwndz1UmgaDhhTtfkHWyzcHD/7RRV0p3C+Hhc77mRLVyL
         RpopLan6bVBwABvS6Ki2A+fRfTH+Hy/gVfF+hutASxOvMdA3STotBj1cmEgS3Ok1CDuF
         GVKMhipr44IiOmGxnML/usxNynsGfShNUyKLsm9PeluhNRpVY9bFv0wQ7xShP+/EiWjt
         +bb+wnSMU6yWKu+HsjAa9NrIdP9G0Pgw6bDG+sW1A6p0MQi1GEod4X38Gc4tJQdO5cPn
         +8aA==
X-Gm-Message-State: AOAM532iYoJZGq2NusbEaqgrZ9RnACHjStBoaOxOhou2tPbBVBj7GIXH
        nGXK+yHr+b1IzS/440tVECEz+koqQPBCUhwtmjruIM/lVb85zKsbPgO2tc/pyX3/KDgXiF+WLyL
        w+FTr9+JNV9SlyVI3jxyjiKClw8Wr4U+ptJSCQwlFelrMXWmKNxyxv+vL5phVX/KeX8TFhw==
X-Google-Smtp-Source: ABdhPJx1dtQKLL9fkJpRtpHNFAj7PP33Hj8C47vXN77FsCdEaBYiAA79DbbgCKR99fhismp3F8+aTV3Lxag=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:170a:b0:4f7:918a:1eac with SMTP id
 h10-20020a056a00170a00b004f7918a1eacmr299675pfc.16.1646977876423; Thu, 10 Mar
 2022 21:51:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:17 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-7-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 006/105] KVM: selftests: Split vcpu_set_nested_state()
 into two helpers
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
 .../selftests/kvm/include/kvm_util_base.h     |  6 ++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 20 +++++++++----------
 .../kvm/x86_64/vmx_set_nested_state_test.c    |  4 ++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c29606be1268..aab258f17e91 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -255,8 +255,10 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 #ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state);
-int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_nested_state *state, bool ignore_error);
+int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+			    struct kvm_nested_state *state);
+void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+			   struct kvm_nested_state *state);
 #endif
 void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 03178004a6c3..8dabea79e394 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1788,22 +1788,22 @@ void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 		ret, errno);
 }
 
-int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_nested_state *state, bool ignore_error)
+int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+			    struct kvm_nested_state *state)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
 
 	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 
-	ret = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, state);
-	if (!ignore_error) {
-		TEST_ASSERT(ret == 0,
-			"KVM_SET_NESTED_STATE failed, ret: %i errno: %i",
-			ret, errno);
-	}
+	return ioctl(vcpu->fd, KVM_SET_NESTED_STATE, state);
+}
 
-	return ret;
+void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+			   struct kvm_nested_state *state)
+{
+	int ret = __vcpu_nested_state_set(vm, vcpuid, state);
+
+	TEST_ASSERT(!ret, "KVM_SET_NESTED_STATE failed, ret: %i errno: %i", ret, errno);
 }
 #endif
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 5827b9bae468..af3b60eb35ec 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -29,7 +29,7 @@ bool have_evmcs;
 
 void test_nested_state(struct kvm_vm *vm, struct kvm_nested_state *state)
 {
-	vcpu_nested_state_set(vm, VCPU_ID, state, false);
+	vcpu_nested_state_set(vm, VCPU_ID, state);
 }
 
 void test_nested_state_expect_errno(struct kvm_vm *vm,
@@ -38,7 +38,7 @@ void test_nested_state_expect_errno(struct kvm_vm *vm,
 {
 	int rv;
 
-	rv = vcpu_nested_state_set(vm, VCPU_ID, state, true);
+	rv = __vcpu_nested_state_set(vm, VCPU_ID, state);
 	TEST_ASSERT(rv == -1 && errno == expected_errno,
 		"Expected %s (%d) from vcpu_nested_state_set but got rv: %i errno: %s (%d)",
 		strerror(expected_errno), expected_errno, rv, strerror(errno),
-- 
2.35.1.723.g4982287a31-goog

