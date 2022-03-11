Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001414D5AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiCKF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346683AbiCKFxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:11 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E023ECC63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x10-20020a170902a38a00b00151e09a4e15so3993068pla.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=o3uJ88GNV+YQmj/m0RYhTpW5VxFfvF1M+nMyDCpDOt0=;
        b=fc5q73HcXBegm+0tBM3/k1V4t9anDkQG+c1YNeo573WEBzqnlIBMexUmN4+VsKMiFf
         rDZynj4GPr43tQKhGkdNsGCS6InEH38WbtIE7uiWJUYhC7Ydvpem38imCTaJbiWTvquJ
         HAtmHlMcrsVErdfq05Igei4LempIIC4TUAp64/QEvnQud9PHQKRW5CJVcP2atrVm4FKz
         q+v2zARtfoNFx2cjPP/yCnUuFfV6KvGYFASJGSXRDphZWITLXEToG0j7wg2CTNVQ6LVN
         8gXG38SH5bhr0SDoFyuY+EWhyLJtj8ePNJIJGPumBOePOmvAO3DHFW6R6aqPPpadTNMx
         hm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=o3uJ88GNV+YQmj/m0RYhTpW5VxFfvF1M+nMyDCpDOt0=;
        b=pqGtubhnMnBa7JC+C9ReOfkOLfMM840gyinIsJCDp1Lvk6kcBZ7m6GrglDAntqo8bI
         B3EYB8U5Orhw2jj2lx7SV4H/wdo0XSXQti6J6W7kewNQDtq2Drl1Lf0HVuvIlPcpuFqs
         CgBpAVjn1wpUPIJ8CXAPr+3vSg6djvI2G1DqPgIcmH5AtkZrWuaBrzSief6eiAswzb4X
         72hseUbt2YOtfY3j0U0gFyz4eVCN415bi4SxnSZT3/vDVkEFac5vJf8aUoZ9gOCTjjoy
         r6QsOUIJwAVa3pytcF9S56D4Sysq7YrFs5k6/oI5xUIBJ3aZkWzJ+Mkju03xi6W6rf4H
         u4mg==
X-Gm-Message-State: AOAM530i97jAfVRLJs71+r8x7cm55FU3+lq2hPAXY1ALPLI/LGyGrK+k
        Pk2qNsnPFNHzauEGc8/ymlw+wkcNW1ui35/i7Z0dluk6PDKrGj2egpQAOlQERUUGnTm3MGp2iSf
        rdiRwlkaYOf377iyg5pZFopdj9cdm43D3CcLrx4bPOOPFSWru9sHEx0FZhRBUdnXVBN+avg==
X-Google-Smtp-Source: ABdhPJxiJIIyJ3647IJ4mIt+GeSLDZ/OwMIU0Mqv8ujNyz27YRqFc6NRwnNVxWaaxa8TL33ZzuEIAnVO1CI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2482:b0:4f7:644b:97b5 with SMTP id
 c2-20020a056a00248200b004f7644b97b5mr8668543pfv.37.1646977928571; Thu, 10 Mar
 2022 21:52:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:48 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-38-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 037/105] KVM: selftests: Convert vmx_tsc_adjust_test away
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
 .../selftests/kvm/x86_64/vmx_tsc_adjust_test.c       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index e683d0ac3e45..d5ce21d3c513 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -33,7 +33,6 @@
 #endif
 
 #define PAGE_SIZE	4096
-#define VCPU_ID		5
 
 #define TSC_ADJUST_VALUE (1ll << 32)
 #define TSC_OFFSET_VALUE -(1ll << 48)
@@ -128,26 +127,27 @@ static void report(int64_t val)
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
+	struct kvm_vcpu *vcpu;
 
 	nested_vmx_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, (void *) l1_guest_code);
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
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

