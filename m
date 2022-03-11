Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E794D5B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbiCKGAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiCKFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15BEC5C0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dd2c5ef10eso60196057b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zLf3U3X5JZYsMDSdUgQiDaIVL0JiAkLrePe1XVgJWV0=;
        b=pikXvfRzsvUZMp7Naom7qO6c4qw9bajKzo/LX3wS/th4BOcTm6NWV7JI5vwfCUjuWr
         PJGsDjn3F8IJlk9LT8+jgQ4B+UjEJNooibMvuhIEM5JU+GlZU8AqHbB1K37IGmKd0Dic
         qTuA7n0FYgyj5/HMfgJ0A9rSZKOtYEltUUQFHd4nCeSYcDi5plUe8dnPplSfP9jBjvFm
         0Ov+uSzfi1yq3MLdKX6zXhsC9hEDDheqbDAlrYs481sfMeqA7rXa7K0FFEFBDMfI9VYf
         MZHlwQbaLaHnw/WHm1S168yHJEKAhX5Bxv8w9eAs4yGICTFIdqXSee77LgqIvyLlWYQN
         Uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zLf3U3X5JZYsMDSdUgQiDaIVL0JiAkLrePe1XVgJWV0=;
        b=6nbSFRv4gU5L+p8G6yzaFJSlOj651Q/NqJ39EiU24jIMye5mtD3mpHppDsmsHhCkLW
         0mglDV80HC7LShSxxONVMHfODxOtiWOs40plQfDEEUKCcLrTdRZU52oijKcBpY+O8cb4
         8HWQPIcIpOcanbAKoEb3OBHNPiQnJFsVV0RrBpsyDLbgO8tGPRy3YoSZTed5fV7lNqx5
         uw30NaY1qrOUXQcGpvjoqgheO66Mv2hrGenHiURD4tDrlSBm4L3S5JR9gOCgQHOI6ZOD
         w9RJrNrX2cxtFpRkrqEhqDmCucb4wrQHOz0wGH89sNHlnNPN3hjbkGO1C5WP0iq365zm
         7I+Q==
X-Gm-Message-State: AOAM532Tge4T/drJRPgDZkgqQ54EvA8NCBTdyK2UAZqUTxVYIjzns2WZ
        qi99pltdEFv2ml+qZmBorPUH6s6uXhMnxUjy029i09+cN9L4lMs4fZBA1XcOF9SZAhetoPagChg
        UAYGLKfOb8hA2VVwlmlOBFwdgacX73AnCS8c1KcLpKAyH+ltYP8uWGmZBFvost1UGEAzaTw==
X-Google-Smtp-Source: ABdhPJzDS2ZnTpyuv5B86K8sNOM8I1m0l0v75LrXwF3pqugMznd+Epb2gwN2t9SBLf5syQfA46Kkp6CqnXY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a0d:d9c9:0:b0:2dc:22e:74a5 with SMTP id
 b192-20020a0dd9c9000000b002dc022e74a5mr7119116ywe.338.1646977991236; Thu, 10
 Mar 2022 21:53:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:25 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-75-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 074/105] KVM: selftests: Convert debug-exceptions away
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
 .../selftests/kvm/aarch64/debug-exceptions.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index ea189d83abf7..d27f30dc57b6 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -3,8 +3,6 @@
 #include <kvm_util.h>
 #include <processor.h>
 
-#define VCPU_ID 0
-
 #define MDSCR_KDE	(1 << 13)
 #define MDSCR_MDE	(1 << 15)
 #define MDSCR_SS	(1 << 0)
@@ -186,27 +184,28 @@ static void guest_svc_handler(struct ex_regs *regs)
 	svc_addr = regs->pc;
 }
 
-static int debug_version(struct kvm_vm *vm)
+static int debug_version(struct kvm_vcpu *vcpu)
 {
 	uint64_t id_aa64dfr0;
 
-	get_reg(vm, VCPU_ID, KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &id_aa64dfr0);
+	get_reg(vcpu->vm, vcpu->id, KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &id_aa64dfr0);
 	return id_aa64dfr0 & 0xf;
 }
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 	int stage;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
-	if (debug_version(vm) < 6) {
+	if (debug_version(vcpu) < 6) {
 		print_skip("Armv8 debug architecture not supported.");
 		kvm_vm_free(vm);
 		exit(KSFT_SKIP);
@@ -224,9 +223,9 @@ int main(int argc, char *argv[])
 				ESR_EC_SVC64, guest_svc_handler);
 
 	for (stage = 0; stage < 7; stage++) {
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == stage,
 				"Stage %d: Unexpected sync ucall, got %lx",
-- 
2.35.1.723.g4982287a31-goog

