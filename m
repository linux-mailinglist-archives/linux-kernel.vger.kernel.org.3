Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD834D5B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiCKGCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346773AbiCKFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD7102426
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:51 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso4594184pjq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JCgIMWGYylR+0tTDSMULgiIUTl6bxuspkWjswelD2mY=;
        b=dftDPqlC860oR+YtSmDAdpFLZVJQ6LcOSvBFChN+hEqJdNGd5A0tzub22j7KFGA/oq
         DOrq1fbA2viJfssQ+b/cYho/HlqZ6f0GDMLg9uBZUGg0j6+K3LeDv/wahQ9V8D/Z8DBN
         GdmqFKJlm19aBd2Rccipc9NET3R+tPlkwGAnBXq6wv+bumjubuGwC6Y2qB8h3Ass0Dlk
         hj0sQGUCNPL0ttwqjjoVspn3AHyEVpKDztH4yv9REvul9AnBTvgrySLurFs68bY/xKjQ
         a/4zdfIAD8tAgmXjUVIA9DHO0MG04rHhqPQt7QQVoY4NKpqhVsVWPtbiW+VMYguWZBQc
         QPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JCgIMWGYylR+0tTDSMULgiIUTl6bxuspkWjswelD2mY=;
        b=bTpoHvS85VkS28v3WVvWAbbHmLizlE+5pQga2Ppp5dXOBoazj8797JPp/Q6bkJgPic
         vyUYLlWPa5zEbPDNYiSBF2xcgPE+biVg1nYmfU+wXrs9kiROmvwpvGFS9xTVDwhMEnR3
         6DWAJU5NF8VsqgIE9oDXZpP4UuqJl5UlGaN3WToAzhW1qxfgY6M2S5o2reZ5/3iR19lf
         GN/RxDLjpPEqB8kZcziyW3Ifa0f0gdhwA8bbQckcDk4JT+6xr2JhBs2XRS3yWWmx7hPX
         HhwwwUCAkldMFSM7WdWiOXgQ7SwK8M9fyBNJwCNR+h7zcPMiBFzr/yUVUyb6kLUDqyzh
         XVRA==
X-Gm-Message-State: AOAM530KUnmpPdTpBBz6JpxOxt8cV3fSJIIUd4bJ8DhSK+uYi5naKSYw
        1GCJ4u7p9DBZi5uIffv+sWYRPPb0m3e4th1tOejRZEG024PmPcJ+zKD/dg7S+GkDFVnXvqU2xfK
        FTIHeBjdUCovrpUHc5Z1a/MOzcTST3zl8sohvCwp9w31c93EwE+Tt2XxPDL41o19Mez0WqA==
X-Google-Smtp-Source: ABdhPJyTJP7rL+1gD5w6tK3Fdaw41/XRz8mFHhRF27RmpHx521Yc3It9AttvmkJnlMK5bJpP//rnEH6hRD0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:ccd:b0:4f6:f6dd:8288 with SMTP id
 b13-20020a056a000ccd00b004f6f6dd8288mr8724418pfv.25.1646978030995; Thu, 10
 Mar 2022 21:53:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:49 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-99-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 098/105] KVM: selftests: Convert get-reg-list away from VCPU_ID
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
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index f486223ac98c..56da85f3851b 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -406,6 +406,7 @@ static void run_test(struct vcpu_config *c)
 	struct kvm_vcpu_init init = { .target = -1, };
 	int new_regs = 0, missing_regs = 0, i, n;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct reg_sublist *s;
 
@@ -413,10 +414,10 @@ static void run_test(struct vcpu_config *c)
 
 	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	prepare_vcpu_init(c, &init);
-	aarch64_vcpu_add(vm, 0, &init, NULL);
-	finalize_vcpu(vm, 0, c);
+	vcpu = aarch64_vcpu_add(vm, 0, &init, NULL);
+	finalize_vcpu(vm, vcpu->id, c);
 
-	reg_list = vcpu_get_reg_list(vm, 0);
+	reg_list = vcpu_get_reg_list(vm, vcpu->id);
 
 	if (fixup_core_regs)
 		core_reg_fixup();
@@ -452,7 +453,7 @@ static void run_test(struct vcpu_config *c)
 		bool reject_reg = false;
 		int ret;
 
-		ret = __vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
+		ret = __vcpu_ioctl(vm, vcpu->id, KVM_GET_ONE_REG, &reg);
 		if (ret) {
 			printf("%s: Failed to get ", config_name(c));
 			print_reg(c, reg.id);
@@ -464,7 +465,7 @@ static void run_test(struct vcpu_config *c)
 		for_each_sublist(c, s) {
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
-				ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+				ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
 				if (ret != -1 || errno != EPERM) {
 					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
 					print_reg(c, reg.id);
@@ -476,7 +477,7 @@ static void run_test(struct vcpu_config *c)
 		}
 
 		if (!reject_reg) {
-			ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+			ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
 				print_reg(c, reg.id);
-- 
2.35.1.723.g4982287a31-goog

