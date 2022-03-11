Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F224D5AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiCKF5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbiCKFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:27 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A7F1EA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a23-20020aa794b7000000b004f6a3ac7a87so4581996pfl.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=cCguG6PrmOTm/zXaI/ZSqU9KbkF2Vy3lLn/GfqDjzqA=;
        b=i29nOWMl4hDna0ox86JlbTor4E34FZnnUw5fmazu3jXQpWQ+vxxM/xekpHSMJkekOP
         4DLw30Kfu9BDGntz/vAmOyuL8wzUn9h/RH0T/vQtEInzHGMWQycPob6u/hlqOrrddNlu
         uRofm2pnYNV7O9AfP5vjNF+EeYGkupyBQbzJDnsibL3cuyyIBphpFwbirR5gGCuAKMO1
         bHFZWrfZ/4O6OkiErzoDpVD5O4ievCZbofM+IYbbCm165yBUJ5yt4ThQSkSB/zod9M8C
         K5JuIkS/cvOrRX+eedUqW4akFq55TcGNxWPysboRAnAsYAQh/4+KW+R4wPK5K8N9eBjR
         yzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=cCguG6PrmOTm/zXaI/ZSqU9KbkF2Vy3lLn/GfqDjzqA=;
        b=Es/aNZt4WVocvdiIKA0yCMwc4TqZ3pnrXOIHgSOZE0/S0mIjXUALsdX82QhNKewWHD
         XZa1e4DPE5+NR0ppP0v1lHNilRSGQXwni63pW2OGqCHjYOzbG722wemyhrlowi5U08Uv
         XXS6uG1oS2sTyckUcviycVECzYMZFmBZUFTKKxh14irBBPhTKDW9QFYWQbHCv6xM7+8U
         pqpp2cgvVraUO+XmyyOo4GUyjVBu6gCi47SVgCS9PSVs9f0DWkKEDs3M0rDhbj82m8kw
         bQ4FAerez15MhkpXVtpOrtiHUrQa1bIO4MKb8q9p5I2HXrhM2vMpCzcgmSRBTjEg8nIt
         9iPg==
X-Gm-Message-State: AOAM5330lJlikp0roGUp+UxLQsI+XQUIH6vqM3EiOTHPKVp7igwqv9sT
        Br3Xmmhy4G4dFxh0Wt2B6KHFvkZKDZFTs/bBgkCxiThgMVQUPnx/FVIag3RqnT+gG1Xu/WP3Y62
        kgnbSrb18d44A+ayazmrrAmR0vb5cIo36VlV5XOFNhcBb3/cTMZXlXJ4VlOMKbUGS/YObiQ==
X-Google-Smtp-Source: ABdhPJwLYBQW8QsnxkCgO5qH1T+UMmOF92iginNzLsff0IaFveiRBPa0LjM5KDL6zzREVcYSJa7ck1uhYg4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e748:b0:14f:969b:f6b6 with SMTP id
 p8-20020a170902e74800b0014f969bf6b6mr8504168plf.15.1646977943810; Thu, 10 Mar
 2022 21:52:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:57 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-47-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 046/105] KVM: selftests: Convert kvm_pv_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/kvm_pv_test.c        | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index 04ed975662c9..cce9016e31a7 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -171,24 +171,18 @@ static void handle_abort(struct ucall *uc)
 		  __FILE__, uc->args[1]);
 }
 
-#define VCPU_ID 0
-
-static void enter_guest(struct kvm_vm *vm)
+static void enter_guest(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run;
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
-	int r;
-
-	run = vcpu_state(vm, VCPU_ID);
 
 	while (true) {
-		r = _vcpu_run(vm, VCPU_ID);
-		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
+		vcpu_run(vcpu->vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 		case UCALL_PR_MSR:
 			pr_msr(&uc);
 			break;
@@ -208,6 +202,7 @@ int main(void)
 {
 	struct kvm_enable_cap cap = {0};
 	struct kvm_cpuid2 *best;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
 	if (!kvm_check_cap(KVM_CAP_ENFORCE_PV_FEATURE_CPUID)) {
@@ -215,20 +210,20 @@ int main(void)
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	cap.cap = KVM_CAP_ENFORCE_PV_FEATURE_CPUID;
 	cap.args[0] = 1;
-	vcpu_enable_cap(vm, VCPU_ID, &cap);
+	vcpu_enable_cap(vm, vcpu->id, &cap);
 
 	best = kvm_get_supported_cpuid();
 	clear_kvm_cpuid_features(best);
-	vcpu_set_cpuid(vm, VCPU_ID, best);
+	vcpu_set_cpuid(vm, vcpu->id, best);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 	kvm_vm_free(vm);
 }
-- 
2.35.1.723.g4982287a31-goog

