Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270653C1AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbiFCBBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbiFCAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6822AC42
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h11-20020a65638b000000b003fad8e1cc9bso3059819pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Wtonz2gVngJJ7uBzze/lIY09PrVFKGL47X53rXdkK9o=;
        b=Hx+Rm1WelzvlxMNiDL6jH7bDcZTEuPRkFSt1167ZacFemHaqp5eIyk/eOV/aJODyNU
         3+RiPMtEf8NcNsqJVh49NQxDGwwODAhK2RLDCl6sh/K9bPg9UKwHvEwrEFonC1fFOoi5
         OJq+nNeIA3tQvfOBVnke5UkawsWBSQdhUolkS/VB6WNYwtRcParvmLPFb9RjtJeToYn7
         4dV3SsUIfpGzhMNmcJfwUemH4TrOfEEo2p9FaTMHtuR0IDiq1f8UuX8zM9zjcQMAp6dX
         w7apUSve9mHBwh0lpNoEI8YV8BqXGPQK7ZeqNAKbQQecBdY3hyWmw6KSplMx+RvyRd0x
         muEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Wtonz2gVngJJ7uBzze/lIY09PrVFKGL47X53rXdkK9o=;
        b=r/othIAzcKf2r22M9hfH6KCRElVD9BJawMzP+rF4EKrhbcVGgU8pPXoNwlXHDcDLtl
         OuMor7epzI2g80on1Y40/xU8oSF+28n6jH2u2TGATRZIGSWiGCdYePH9XWXTBYtakQW3
         DhapwTk0YWuA+ly+awUW/dsYksHex0CH3XxFE8V4b5TFGPJORqM/KVmUDY7mWCyAJk3Z
         dkzLjeQsz64d2BC9SQoDVDmFe44rlNBsu0DUoc6YaD/MYXwywfjSHH173Imd6bAxdxTz
         GhlDlgA6XUKLUrSiw0AuXGnIY+pBOzHeGW/tWrBTu2PEyaLC+FEAN1L/N2TyT+TCW5Zo
         1hTw==
X-Gm-Message-State: AOAM531gDtoax2hJzkA0ks4j5Hb3WTrG0nOhQF13XxL6/+q7XQc8OZ0c
        6A+Jrp/uMvkioHRZdzRJtJlc4ZcGhQQ=
X-Google-Smtp-Source: ABdhPJwJlWPDHIZqX4XN9J4HUUqVAcAeCBxORebV4fuCyTaja1dn1sXZGHtPO1fiZrDqgNVm8V81m+YST+4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:7b8b:b0:166:332f:2490 with SMTP id
 w11-20020a1709027b8b00b00166332f2490mr7497118pll.68.1654217245801; Thu, 02
 Jun 2022 17:47:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:14 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-128-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 127/144] KVM: selftests: Convert get-reg-list away from its "VCPU_ID"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Track the vCPU's 'struct kvm_vcpu' object in get-reg-list instead of
hardcoding '0' everywhere.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index e004afc29387..04950b10e083 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -411,6 +411,7 @@ static void run_test(struct vcpu_config *c)
 	struct kvm_vcpu_init init = { .target = -1, };
 	int new_regs = 0, missing_regs = 0, i, n;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct reg_sublist *s;
 
@@ -418,10 +419,10 @@ static void run_test(struct vcpu_config *c)
 
 	vm = vm_create_barebones();
 	prepare_vcpu_init(c, &init);
-	aarch64_vcpu_add(vm, 0, &init, NULL);
-	finalize_vcpu(vm, 0, c);
+	vcpu = aarch64_vcpu_add(vm, 0, &init, NULL);
+	finalize_vcpu(vm, vcpu->id, c);
 
-	reg_list = vcpu_get_reg_list(vm, 0);
+	reg_list = vcpu_get_reg_list(vm, vcpu->id);
 
 	if (fixup_core_regs)
 		core_reg_fixup();
@@ -457,7 +458,7 @@ static void run_test(struct vcpu_config *c)
 		bool reject_reg = false;
 		int ret;
 
-		ret = __vcpu_get_reg(vm, 0, reg_list->reg[i], &addr);
+		ret = __vcpu_get_reg(vm, vcpu->id, reg_list->reg[i], &addr);
 		if (ret) {
 			printf("%s: Failed to get ", config_name(c));
 			print_reg(c, reg.id);
@@ -469,7 +470,7 @@ static void run_test(struct vcpu_config *c)
 		for_each_sublist(c, s) {
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
-				ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+				ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
 				if (ret != -1 || errno != EPERM) {
 					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
 					print_reg(c, reg.id);
@@ -481,7 +482,7 @@ static void run_test(struct vcpu_config *c)
 		}
 
 		if (!reject_reg) {
-			ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+			ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
 				print_reg(c, reg.id);
-- 
2.36.1.255.ge46751e96f-goog

