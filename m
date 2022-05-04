Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FB51B2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379727AbiEDW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbiEDWyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:32 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9B53722
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y14-20020a1709027c8e00b0015906c1ea31so1363411pll.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=n5OYPLxga2WxpiMrHoDu5Bg4CestG48JEuh/J9PdNW0=;
        b=Ft/ZM2zX1FPC/Db1m4EdNOLShY0cl4fvf2h6qxSswC7vLN5Xcg2QmEM0L+ZwvLy/A3
         d4N/X8UU8cPoFCNao0OUwEf3/UFTQxgY9s5x+xEmwNosMKEuzeg9yObVibetC+WaGG4K
         WFgpDduIzOrY+4wb+doNb+Gxo6qzHZQZkiuEdAXu7cQXamssG9In7HegyVRjc/JGxXH6
         3jQh75Ys3mRU5RJJSQlR2gAKvyjJvP71HpojdxMjGmV1bsRyahUyFJ968ZWjkK2ztgva
         lmmZ1Yv0BBRtpxihxL0kzQqbPRE/VpbdybPi3IWM3lVB1H9c/gQbrBDYlbTuXdG9jKcU
         huPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=n5OYPLxga2WxpiMrHoDu5Bg4CestG48JEuh/J9PdNW0=;
        b=ESzkKxJx5V5jASOF2BlJwTto9XLZIuOAdozO5SP5lYThYvqEm4UVs7S2b417t9PLtR
         Hz6vhnk9A1ljLXiDmENudLjFJmboFfJInglgmtPjtNJe+GmxwgodLFKtecA4AZ2RinlX
         fArInInCzIPWP0siK4qCX17MBlFTtDhABMRPBbNMMnseJ6v7YBSRjj3TdrXK5xqWjL8V
         OCa7/u0Q5Aj2dvAmG3yuUaud1HUu3EmwbAh8z0HOGR+B4lDLSCmkT962Uml+WzBaAWdK
         P/CxAm3CFZWWEqFwcT65MwTTBMyz96ZRPfDRbnTv+Mfis1SUoYcpCozAqH5MfbloBZ51
         +bbA==
X-Gm-Message-State: AOAM530Pk3XW8FNmnryp8amKKq6bBMaqDu/HcyBlQYnDrNxl8xGCV9eh
        kYbYx4PmZa0+qGnHF2E5oT2y6M3sJKg=
X-Google-Smtp-Source: ABdhPJxW33i9KdZKEyKsXS1sguRbRjvVFjvS+WfQA2xbnn66YROjk0TWvV4lrkzSPoH54RIX/UA78ixPdaU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:5551:0:b0:3ab:84c3:1a0 with SMTP id
 f17-20020a635551000000b003ab84c301a0mr20088916pgm.604.1651704654614; Wed, 04
 May 2022 15:50:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:54 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-49-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 048/128] KVM: selftests: Convert vmx_tsc_adjust_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Convert vmx_tsc_adjust_test to use vm_create_with_one_vcpu() and pass
around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.
Note, this is a "functional" change in the sense that the test now
creates a vCPU with vcpu_id==0 instead of vcpu_id==5.  The non-zero
VCPU_ID was 100% arbitrary and added little to no validation coverage.
If testing non-zero vCPU IDs is desirable for generic tests, that can be
done in the future by tweaking the VM creation helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_tsc_adjust_test.c      | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 19b35c607dc6..29699d7c16c3 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -32,8 +32,6 @@
 #define MSR_IA32_TSC_ADJUST 0x3b
 #endif
 
-#define VCPU_ID		5
-
 #define TSC_ADJUST_VALUE (1ll << 32)
 #define TSC_OFFSET_VALUE -(1ll << 48)
 
@@ -127,26 +125,27 @@ static void report(int64_t val)
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
2.36.0.464.gb9c8b46e94-goog

