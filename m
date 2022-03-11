Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778004D5AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbiCKF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiCKFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A305F8B8D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mz5-20020a17090b378500b001bf46a762baso4597777pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=f/9Fx/PavHslU1pUv3Zhw8t4foCTO0SPxMweKFyRcn0=;
        b=DRoorF0Y6CoKhgZbThJ9t9slOtpoTWCDboPK3SgR53t0wNdXSq3CfLwXEFeqPRXUq2
         D3KQVFop9A/hFOgB5u6oaOahbJHLa4x2HP0bbj6FvWKKbr0E/Pwwzi+DjEufEQoajhq9
         o6Xjzb58vrZFV9Vy8XfY79sRbQS4b3BBRORw4SAyJ6xZkRITi4N9PSlY1m6vNKw4aia6
         v7qXVinLlgMkj36BvD8CJTIOaQIxQB9q/dn6fDTqpbOHmUu3kzAL4UmKUY+Ckg7SEpef
         sDJurQ36h7rC6V/SLLt7C0kD9mq6nf8SEVmkyGnwja4lhmfK8vlfsBTh3tUhan9ee6IW
         XaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=f/9Fx/PavHslU1pUv3Zhw8t4foCTO0SPxMweKFyRcn0=;
        b=uBrGinROuGDgvGuG28DJOoPK9CASmNlxTqhvnvu5G2YqODYMpnpJQPtH7eUVCEkygX
         u+Syv4XgthYcIh/UcNr/rFOADbR5hBr8T8blkEJ4LOFGRm0GmiGtBwgrMqDMhORwx0YV
         bLfXgPx58WE3DylRaGnoBZCZNhMjq9Cf6HlLgLz5og7tM38PtMD9x4/0/26JIaPlrZkm
         JZVu+1o5gR9arrLeLHoAJzlXsfRhD465JV49nwIfRMXrtbcDyNjAIk9LCyNeHpeiP03Z
         Wo1TvfABJNV08Ge89XvK2hnHYNHz9+w9gLh2mjvsBRxtY+GuE6l7Kf22PlEw7jVJr0Wk
         UDkw==
X-Gm-Message-State: AOAM530UKjrfzQh+a/5qOYzsQb7LW1sMuYHlTpReDT/DxFoBc2rJEFLc
        AZiIO20iDQlKVXYSvwTqiFOI040KtnRVHrTMOTo6s7aN3s2G1TLZAixC2dn5R+nEz74DU4/8htK
        cR/78lDxxvRfnMMP8QnIFV6w0ylRMVXqFVYmipY/tJ4GJbunB1FZAYDzntanzRdblQ9BrXQ==
X-Google-Smtp-Source: ABdhPJzLRZkhXT+5/qVqea23evUC9ic9DpPgnu4xEAZdBo4BGlsCDB3cpMT65kDigMqVsmhd4VBKqqlRDoI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:240c:b0:4e1:2d98:d2c9 with SMTP id
 z12-20020a056a00240c00b004e12d98d2c9mr8530102pfh.51.1646977947007; Thu, 10
 Mar 2022 21:52:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:59 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-49-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 048/105] KVM: selftests: Convert vmx_nested_tsc_scaling_test
 away from VCPU_ID
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
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index c35ada9f7f9c..c9cb29f06244 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -15,9 +15,6 @@
 #include "vmx.h"
 #include "kselftest.h"
 
-
-#define VCPU_ID 0
-
 /* L2 is scaled up (from L1's perspective) by this factor */
 #define L2_SCALE_FACTOR 4ULL
 
@@ -150,6 +147,7 @@ static void stable_tsc_check_supported(void)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	vm_vaddr_t vmx_pages_gva;
 
@@ -182,28 +180,28 @@ int main(int argc, char *argv[])
 	l0_tsc_freq = tsc_end - tsc_start;
 	printf("real TSC frequency is around: %"PRIu64"\n", l0_tsc_freq);
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
-	tsc_khz = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_TSC_KHZ, NULL);
+	tsc_khz = __vcpu_ioctl(vm, vcpu->id, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(tsc_khz != -1, "vcpu ioctl KVM_GET_TSC_KHZ failed");
 
 	/* scale down L1's TSC frequency */
-	vcpu_ioctl(vm, VCPU_ID, KVM_SET_TSC_KHZ,
+	vcpu_ioctl(vm, vcpu->id, KVM_SET_TSC_KHZ,
 		  (void *) (tsc_khz / l1_scale_factor));
 
 	for (;;) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *) uc.args[0]);
 		case UCALL_SYNC:
-- 
2.35.1.723.g4982287a31-goog

