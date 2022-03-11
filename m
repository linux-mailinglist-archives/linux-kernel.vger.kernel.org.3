Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D54D5B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbiCKGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346767AbiCKFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:09 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA2101F31
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:49 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j15-20020a633c0f000000b00380ed7c5e91so1973503pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=YsmSUUnuP1TZg4m7zR4w99uQOnLeSOOSgT5uhyswrMk=;
        b=h4wQDFuoS19enz8Gmes9qfh9OUYMoQ7iHhJ2cXjyeWp24bbNuUNzwqi8ThtwiiASkY
         otGdfb2PEP3LnBpFn16jSclnOAlAg9wbEQN8nBUoByorQbnI2pQp8/DEpP4mMTWA0N+c
         vlzD0YG6fw5OaZG0oAfOULgGnSaW2ABKqoxKd5jxkQh4d9R6DCZfYQ6DYYZwxiNYvMp6
         iCZdHl1l7GGwntfjmEhhSXd4V/1pLFM10ERD8lA2HHGgITWnb7oXVazuJOy/1kueWhf5
         iie0F3xwy26tpXFRS0AQGMNJeT+IfHrszXGds5ZWSLptzmZbCqxHayqFeKGeh3umV4mP
         aMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=YsmSUUnuP1TZg4m7zR4w99uQOnLeSOOSgT5uhyswrMk=;
        b=J2vBicQdQoHlLIfXqu/MULh/oXei9Ar2o1NgaxiRoVPs3ERusM3xYpLRJSjtLo9MK9
         VOHQFKBkCzHMRthA9PTVBUdgb5ufnzL4sJ9QGFKd0RtzeY5BgiBYalv1alckdhaCOZQ2
         hfZpMdjJXu/Ej1v9yL66bdE+mqCjNVQg1y9xzG4W/L2AGdoTkUAxUygRcSfIXLs999o/
         5v+yeNtC8HnJtC+m2nqfLOnT0GEORdt+PYCPHxphlOde5tqzQtIlLOCTdU5EQ5d9R1G7
         tZHcnXQojKzk2w8fWJYx3r8/JnCqi43g7Fw/vqc9QscwrYY5IwB6BmoooKfnz3eUaq+o
         O41w==
X-Gm-Message-State: AOAM532ct8oTpnFEXXwCEwrlwtJXLNxNktA110pSkGb0gQNjilLH+htD
        jBstCzhvr22u/SWQWVAtUzP65V8WGYBjK+/lhvVp09iRRtFCQEJrIzloJ7wNO6tsxAsSdID1qYA
        1qbISvNYzUTjqkLqrjJsXF1QD/qyyPDOxNU6aBbI+Oiif5nc54+ZxMo7EUVK+f6Mt0j3+1A==
X-Google-Smtp-Source: ABdhPJw67FEZBNKiGXdERoQH8KjfsqKkRVrPMW8OGzGAW3bflpaPTmZ/Zw4kaHRfI+YUvtt+oFMxeFva7Ck=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea04:b0:152:7cf:1b85 with SMTP id
 s4-20020a170902ea0400b0015207cf1b85mr8905466plg.80.1646978029310; Thu, 10 Mar
 2022 21:53:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:48 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-98-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 097/105] KVM: selftests: Convert kvm_binary_stats_test
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
 .../testing/selftests/kvm/kvm_binary_stats_test.c  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 77b8967fe702..3a1eabd64137 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -172,9 +172,9 @@ static void vm_stats_test(struct kvm_vm *vm)
 	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
 }
 
-static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
+static void vcpu_stats_test(struct kvm_vcpu *vcpu)
 {
-	int stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
+	int stats_fd = vcpu_get_stats_fd(vcpu->vm, vcpu->id);
 
 	stats_test(stats_fd);
 	close(stats_fd);
@@ -195,6 +195,7 @@ static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
 int main(int argc, char *argv[])
 {
 	int i, j;
+	struct kvm_vcpu ***vcpus;
 	struct kvm_vm **vms;
 	int max_vm = DEFAULT_NUM_VM;
 	int max_vcpu = DEFAULT_NUM_VCPU;
@@ -220,17 +221,22 @@ int main(int argc, char *argv[])
 	/* Create VMs and VCPUs */
 	vms = malloc(sizeof(vms[0]) * max_vm);
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
+
+	vcpus = malloc(sizeof(struct kvm_vcpu *) * max_vm * max_vcpu);
+	TEST_ASSERT(vcpus, "Allocate memory for storing vCPU pointers");
+
 	for (i = 0; i < max_vm; ++i) {
 		vms[i] = vm_create(DEFAULT_GUEST_PHY_PAGES);
+
 		for (j = 0; j < max_vcpu; ++j)
-			__vm_vcpu_add(vms[i], j);
+			vcpus[i][j] = __vm_vcpu_add(vms[i], j);
 	}
 
 	/* Check stats read for every VM and VCPU */
 	for (i = 0; i < max_vm; ++i) {
 		vm_stats_test(vms[i]);
 		for (j = 0; j < max_vcpu; ++j)
-			vcpu_stats_test(vms[i], j);
+			vcpu_stats_test(vcpus[i][j]);
 	}
 
 	for (i = 0; i < max_vm; ++i)
-- 
2.35.1.723.g4982287a31-goog

