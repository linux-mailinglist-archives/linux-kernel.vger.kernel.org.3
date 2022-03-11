Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBC4D5AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiCKF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiCKFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B89ED95A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3988791pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7GiJxySC4T+Pob+Yt72qF7V+PSmyAN911vam4VpEA3c=;
        b=IuMEt9lpw4IXWmfVeXUh8+ZwxqN74W+pwZCdIULUm9DuF6Sjc3QMwizfXY5xYuRr0R
         Ek1Xf6IW3rK+wT44xksdnyd2KX3zSCRdZmwkwSLcsEVdkQp1R48Of58oJ/VphB42mxoy
         +y2gR1imGs14NdwvCUxwLCTgbk5tX6GOeJbdKZ1bs/LSoosehdU/d3BMNULasJNX9ah9
         jICLqOnVmAi8yw355rMH9m5GaGt0zFzBdJ4Zg6+KddZ+4LO5F38wdHUCVNwLTap1XjJt
         ZN344Udf4FdbJss+NYF1WcH5Gsnqobmj1IrMjqTNW1v6CTWxsp2HZ78HHE/czFklOpwA
         rNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7GiJxySC4T+Pob+Yt72qF7V+PSmyAN911vam4VpEA3c=;
        b=67t7OgKSPManxySkQkIMpNbG1cACvKNxWyZ/Z9LUoZZfo09DCDlFqnifMZjO6sPRue
         GTyw3qcubnYcHIWK4yfZglYAsveDKAsDTtKzHkZVx3B65m9p+xK0GilxT3Sn/fUtfLGG
         EpUPqirL2pEwedRZT1AL/2yvOjuHwn/0/2HiAPvEpbwtmdS+K+DsASAeeFcQWZhA2cdS
         xdSaFwU9omRyLyiwZKHg7Hag1OeXn72V/zRzAu2XUx7cTy+SQ4K/soAaLaWSQ3KDRIjm
         fK9GwOd6F7LqLgy5KqVZlldSOzKWb5BuvzQYSVAHiIcGRwZKH0D49aJUXYKteVbal7l4
         i/kw==
X-Gm-Message-State: AOAM531kXyDt99v8AkMl982uIOTSNKLr9xBGQbU9tfj8BzncPe3oWoXx
        y5w3UjrrUJTa/MHSnzkq1vcGLFik/cxsh1Uea9P9Z/GLxmgdbjVRLTS0Oga9yQspDG5LnCdoQbS
        Ep6P7pXSnM+nSCSukW7i6iohIJ7ur+TQqgS3Lskc3ewCjgQd70f0+0lSRDIuMHww+26MTZw==
X-Google-Smtp-Source: ABdhPJwUaU+X48QC7iLkm0/3LvEchD2X4RhzgEZfVrlpRFrTqs08s5maywb6S6xmpnFEkJcTsy6XZmUbJGE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:885:b0:4f4:17d8:be31 with SMTP id
 q5-20020a056a00088500b004f417d8be31mr8649990pfj.57.1646977938440; Thu, 10 Mar
 2022 21:52:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:54 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-44-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 043/105] KVM: selftests: Convert svm_vmcall_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/svm_vmcall_test.c       | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
index be2ca157485b..15e389a7cd31 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
@@ -12,10 +12,6 @@
 #include "processor.h"
 #include "svm_util.h"
 
-#define VCPU_ID		5
-
-static struct kvm_vm *vm;
-
 static void l2_guest_code(struct svm_test_data *svm)
 {
 	__asm__ __volatile__("vmcall");
@@ -39,26 +35,28 @@ static void l1_guest_code(struct svm_test_data *svm)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	vm_vaddr_t svm_gva;
+	struct kvm_vm *vm;
 
 	nested_svm_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	vcpu_alloc_svm(vm, &svm_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
+	vcpu_args_set(vm, vcpu->id, 1, svm_gva);
 
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
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
-- 
2.35.1.723.g4982287a31-goog

