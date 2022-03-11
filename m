Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE18D4D5AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbiCKF5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346643AbiCKFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E7C4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:31 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c7-20020a17090a674700b001beef0afd32so4710281pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=XUeIxaJPBuNQuCYNQZ93S//8bghme83ZNdK7Pf65uzI=;
        b=qUDIHocJC53kBWqba7+6hpgTpb9XEJrOG19q2OBqMhLr35ZL9pep0J6pN1YWlLFelu
         YA9umKxxW1W7nuC7bIkdSkylFj3LaBA+kSQ9xRpnNUZNvadWeiBF3sobOAHoRM9QQKbT
         Cj3VXZ9ALmIMoeMFjMKaOewgKqUjicR75sVwi0aZ4W4gQA5t2Rs+Q+VKBG/+/TbQxa2i
         2hugzANq8QWXfmRpnOB7j1neOZo3iG1/0jX4n9l/sM/gpn/4ahsFpvjnW6ApGqsSPgZb
         IsppuH9iA6IrwfQhTe/pz8WcHNH+5xI0g1SDTidbbnuZVaSo3AYaT4WYvLZ5LhSOTFLd
         QQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=XUeIxaJPBuNQuCYNQZ93S//8bghme83ZNdK7Pf65uzI=;
        b=uKW82LC/WoBfv8xLNvBtZzs9cvorHJ6cli4rOgtTTLMAkMeGYj8HYo6wGP1lm2wBnl
         HYO0VpI8/0JPN0w3L36XLgJiRKm3DZpBWUTZOygTwmT5hHXC/5YXSr+J1j1CqDiEbFtx
         Zns6DQo/ecUVC+dW14QkjEPi7BRdJaUI1Ge7pwbEJ/7WUbNQkS73YTrQnjTSRSscyAHH
         8lBU9ceDvekF5NiWl3slklWHuEc9rJSHmkaCa/duOYqC9K7GMrjD93IVx7k5yjgaPTnR
         utPFRcTUY3tKYkfWR6DyrYztfmYOzFoc+ic0pEZEm1PbrDCtqjeI4JH7hP/Mc7R3G6bq
         1ObA==
X-Gm-Message-State: AOAM531eqGdECsQqmeNx+/6pgU5HP6njkAZnIByWkpMA6NvbzScs6Cuh
        vWT2iHfyQm2eCcNiDq7yOwHNG3zboTpCtbK8p3mgl7P4I3wG2JqjYIN7l6Myl7pMaNh7yI3H3oc
        V+7I16Wdu1U5wYEoy6TiHHIbIzG9FXwvBhF3wVO79/lJcp2nwwTZiMz+NAeW65aiMbhkpMA==
X-Google-Smtp-Source: ABdhPJwDycjRrhtZFnXXWZeJUf1trL7SjYtbATLpvLYHR5roeOqFf/K3Hs2H1NroM/k2QelNev9LjB+EUFQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:88d5:0:b0:4f7:7fbd:c653 with SMTP id
 k21-20020aa788d5000000b004f77fbdc653mr5228547pff.41.1646977950526; Thu, 10
 Mar 2022 21:52:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:01 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-51-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 050/105] KVM: selftests: Convert vmx_dirty_log_test away
 from VCPU_ID
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
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c       | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 68f26a8b4f42..fb8c7f7236f7 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -17,8 +17,6 @@
 #include "processor.h"
 #include "vmx.h"
 
-#define VCPU_ID				1
-
 /* The memory slot index to track dirty pages */
 #define TEST_MEM_SLOT_INDEX		1
 #define TEST_MEM_PAGES			3
@@ -73,6 +71,7 @@ int main(int argc, char *argv[])
 	unsigned long *bmap;
 	uint64_t *host_test_mem;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
@@ -81,10 +80,10 @@ int main(int argc, char *argv[])
 	nested_vmx_check_supported();
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
-	run = vcpu_state(vm, VCPU_ID);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	run = vcpu->run;
 
 	/* Add an extra memory slot for testing dirty logging */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
@@ -116,13 +115,13 @@ int main(int argc, char *argv[])
 
 	while (!done) {
 		memset(host_test_mem, 0xaa, TEST_MEM_PAGES * 4096);
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 			       	  __FILE__, uc.args[1]);
-- 
2.35.1.723.g4982287a31-goog

