Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0654D5B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiCKF6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiCKFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D6011A12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:42 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j9-20020a170903024900b0015195e68490so3986396plh.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7cybGKQ7twwpsb/qnodDyF8Mn5LXVu4ZlYZ7x+hR7eE=;
        b=NRbOWYomFJU5rcwGuhVhK6pUeZd0VFoa7YkR9KcnQboKYAbUo8syVNH1PBl8kO4Zwz
         n+VsyRw9IcxN95utqJzP1V0HtKHkKJYs1o3grj4YXiotZuaYEYmhIHi+icd638OJEsOF
         3ZJRIQJmLQUF37sscaNPRepes7SqSlK7PVMgG7E0GF0EOdsvcP3vJQ2elEV4WMJvstO3
         sjViPs2KOWcfOl7cB/f8bINNh0ons0yyXRAQikdjInC8gMC0I1uRdoMigko1iv019G4D
         A+YfVnsBSyz4aeMFUEQJxENHGzHW2cnHXmCkwLyxSLtNeMyym9YZG/lSC35vjJ1UJkFQ
         BFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7cybGKQ7twwpsb/qnodDyF8Mn5LXVu4ZlYZ7x+hR7eE=;
        b=KB+KiedCsPHZYhTCWTnprC9h8Ihf2hGKQ27MeGEREE0L/E8zrNT7qa8pgJuK7vstXH
         eZzUqopARQMsFs2JRkps0H8YUSvoKvUBXov8pba8HmtkVCfwVfZHZyEWc4/JgogM189q
         vX+kFYt33HJXjIpPCZn3Oi8MdkO2bb7hefHXAj1akoggkvXF57zrT15q27A87Xpt6TrL
         yxX9NZNYdsszxBGt0mrwV3+75dU8AIu09TZyCWkms9C7Pk4UbVkpgO6ESy7TNP/lI+nU
         3NReuDT+VMYTkdEpgxTwrSE57Pgnb8asdNGihdh4w5tj+R1/FErob45YGAlwisUNUkMH
         AJAw==
X-Gm-Message-State: AOAM5334m/5HceAFF0UwxYWEdnjzIPPLsHxgKz078K8ptwZFW5ZgmOzD
        IpBSr47UrJFyOE6Rn75tduyZ0xNX97yY4lzf9/qv62xjQbujTjmxfTmMHr0vk6UdsO0O4eX3eEw
        I+IZz6EPDu2YTHtXpwwJ2KHOZCAaGTuPNyqqfv29LDmWnt1F9VrcToJPX8YYgeSRRdy/SbA==
X-Google-Smtp-Source: ABdhPJzLD70AGjURuPHSsew9G6xF7zeOA14Yn1vRGVxEEbwnUT94A/qJoqtHo85gvyxbExcA7vh/EIUtpA8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2442:b0:151:e3e2:cbf9 with SMTP id
 l2-20020a170903244200b00151e3e2cbf9mr9088495pls.115.1646977961959; Thu, 10
 Mar 2022 21:52:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:08 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-58-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 057/105] KVM: selftests: Convert hyperv_svm_test away from VCPU_ID
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
 .../testing/selftests/kvm/x86_64/hyperv_svm_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 21f5ca9197da..46f1070e7297 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -21,7 +21,6 @@
 #include "svm_util.h"
 #include "hyperv.h"
 
-#define VCPU_ID		1
 #define L2_GUEST_STACK_SIZE 256
 
 struct hv_enlightenments {
@@ -127,6 +126,7 @@ int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
@@ -137,20 +137,20 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
+	run = vcpu->run;
 	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, nested_gva);
+	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
-- 
2.35.1.723.g4982287a31-goog

