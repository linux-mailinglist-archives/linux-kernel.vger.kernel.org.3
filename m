Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98054D5ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiCKFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiCKFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13967ED95A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:22 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3987698pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1K8XiB8/q7GOUeGCOVODhNnDPMTUOmdv7nwendERxtY=;
        b=bWM96fI89WRJbvud1mF7qtvXeoYDhLED0TIIVdpEPN9crFK45Y5D4LJF1O1VqqKGyO
         a7IPuRnwJBOJ1ILG6YnVdXyy7NCXlkuUhlr+KDQO2PB7ctt/Pz9m2xJ7R5TAsV3hi1i4
         Hyq8/GjIbVOziM5Q26QRousG1TuKyYwtTQRj/deqQvrg84RavxBNiHXQ3T+toGY69KdT
         DVbq73uFMLDRU0bftzuvzZQb7kfq+dt1C3tXnqFRSuNUO+jWDclMYDQZU+CFBxfKsOMl
         4TccgRh+j0IAntbSExEPacHzjbmNYeyo65B7KkmyweMcVM4l2EqFHqsmnIU+Q72smcbs
         o3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1K8XiB8/q7GOUeGCOVODhNnDPMTUOmdv7nwendERxtY=;
        b=SJvQDD7nWSMmT52uonDtn4r2IBEVDgYiqQrZ6A6T8/ic0iE03wldEDqOoWGlMr2Bnq
         nwRGGuwwsOgvAc7wdPOzdBgGt4i9GKNvF2ur+jCMWVU/0iLEByGBnozuhkU7CRMju67H
         7ohbRnIm5fUlRtmQCJBhhxie06E5alOVl4540RdSvZhzCVMnHeXkJeXI+jL8kbOb4Hp7
         s0YPouzJwWE9vIlKEp4bVOQfiPnekeNBT1yg/51UrhC4fvjY3VQrkviltoJ91qGyzNNs
         X7EtmkVsiIY8V0+a5+xfff4Bnl4wHW8c3Xg5EeO2dUr7WRdfg64lKo7KdtT8sQQVRoPi
         V0HQ==
X-Gm-Message-State: AOAM530ChwEeHBQTl4WFLuv8TkhYUzz0WPvolTWa6trrN6HM9CY7xwJ0
        gIVQup81iPTErKQQ7j8WZUknUi0S+qBB5a+C+giNFyusddDMUgtEcx9CVTgNm7z9/0Ypiwc5OFa
        ss0HxpwSZuU8DkUFjhclSPKk1VAzDoR5WYTBHUWrSmBc5LSeKAZiKEfKuVnedku7Narg37Q==
X-Google-Smtp-Source: ABdhPJxzR/o9niaQRBy8TAxO+1nS0Sj/aF9vIzigjXaUjo9vtmDWIQdwFCY0LlGH/XE5gg5vEC9WTl3ar34=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:24d:b0:14f:84dd:babb with SMTP id
 j13-20020a170903024d00b0014f84ddbabbmr9117164plh.47.1646977881427; Thu, 10
 Mar 2022 21:51:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:20 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 009/105] KVM: selftests: Add __vcpu_run() helper
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
 tools/testing/selftests/kvm/aarch64/vgic_init.c     | 6 ++----
 tools/testing/selftests/kvm/dirty_log_test.c        | 6 ++----
 tools/testing/selftests/kvm/include/kvm_util_base.h | 6 ++++++
 tools/testing/selftests/kvm/lib/kvm_util.c          | 6 ++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 373c8005c2e7..9a153b2ea3de 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -55,10 +55,8 @@ static void guest_code(void)
 static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	ucall_init(vm, NULL);
-	int ret = __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
-	if (ret)
-		return -errno;
-	return 0;
+
+	return __vcpu_run(vm, vcpuid) ? -errno : 0;
 }
 
 static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type, uint32_t nr_vcpus)
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 01c01d40201f..5752486764c9 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -509,7 +509,7 @@ static void generate_random_array(uint64_t *guest_array, uint64_t size)
 
 static void *vcpu_worker(void *data)
 {
-	int ret, vcpu_fd;
+	int ret;
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
 	uint64_t pages_count = 0;
@@ -517,8 +517,6 @@ static void *vcpu_worker(void *data)
 						 + sizeof(sigset_t));
 	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
 
-	vcpu_fd = vcpu_get_fd(vm, VCPU_ID);
-
 	/*
 	 * SIG_IPI is unblocked atomically while in KVM_RUN.  It causes the
 	 * ioctl to return with -EINTR, but it is still pending and we need
@@ -539,7 +537,7 @@ static void *vcpu_worker(void *data)
 		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		pages_count += TEST_PAGES_PER_LOOP;
 		/* Let the guest dirty the random pages */
-		ret = ioctl(vcpu_fd, KVM_RUN, NULL);
+		ret = __vcpu_run(vm, VCPU_ID);
 		if (ret == -1 && errno == EINTR) {
 			int sig = -1;
 			sigwait(sigset, &sig);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index cebfc667e3db..f4bf77eed00a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -202,6 +202,12 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
 struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+
+static inline int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	return __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
+}
+
 int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
 struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c9bbe69513eb..066314ea880c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1559,12 +1559,10 @@ void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	int rc;
 
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 	do {
-		rc = ioctl(vcpu->fd, KVM_RUN, NULL);
+		rc = __vcpu_run(vm, vcpuid);
 	} while (rc == -1 && errno == EINTR);
 
 	assert_on_unhandled_exception(vm, vcpuid);
@@ -1589,7 +1587,7 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 
 	vcpu->state->immediate_exit = 1;
-	ret = ioctl(vcpu->fd, KVM_RUN, NULL);
+	ret = __vcpu_run(vm, vcpuid);
 	vcpu->state->immediate_exit = 0;
 
 	TEST_ASSERT(ret == -1 && errno == EINTR,
-- 
2.35.1.723.g4982287a31-goog

