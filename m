Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655F51B32D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381871AbiEDXFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379676AbiEDW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:58:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198753B49
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:52:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id y17-20020a637d11000000b003ab06870074so1336701pgc.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JuSB6I15ZhVqlzJm9dB6xmEsKq4c3QIfjVdXnbIX1uc=;
        b=f+sE+6mGX/smmSPNXPjARqw/YAoc+kPcExZzb7PZZ4ZLPERBNyRyt4chK9qVK0Mq2G
         R27dsT7UAp9Amh4eZyMdMptcUg+PzehAOVisNmgAoWTFINhBSwisJQF305pONj0zqLez
         c07e2v63pE3qtdgT7uxg5QJnhQF1gZV2D/9Oq20pS2bvZm3w8LZ7SOXbGTn4REB3tQAQ
         K2n8pn7yjiuc7Ghf10qYjVvj4F3/LMlGDZCaAiaQMyiw6R8YoA9xwmhkOL58Q/18SmTt
         kgTbD/mEbe5oTDMaa5IXb0oo8SZ+cDfERJsQAI0n88w1xxtEyA9tpbcCev9d4ZHha5wH
         2hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JuSB6I15ZhVqlzJm9dB6xmEsKq4c3QIfjVdXnbIX1uc=;
        b=GonmXAysmqwGa44RQtfG4fnhWrnjCHfJgkcTDhTRjS1mHgF5MLEZMQbUNZvoVMcl56
         eQ3/vmuMyrSsBT7xbTZSBNsU1iK8XR82RZrOx3grpG39eB4rxirEyOM0dnNEd+05rybB
         33nNIac8ixKCr/yG8vNAsUFlADYHYwv/Dj44CnzWpYUx8R1wxleVD7ZF0vWxiURL5Vqi
         zecYRP/XZqewMPdF7Itzc2boFiPjU0iN1u9Ng+cle5ien870pDee2pYAwGfOqeyQ+ZmA
         rNPB7XO+wioBG+Bur01SzH9W1IGCOM0uAAyQKP3cE8SrL+z+Dx0n5sTugMUAIIkUve7Q
         8xbw==
X-Gm-Message-State: AOAM530ESnHAbm7OPwVCkJ4SJDUu4788lBN+u4YEXurQDuMuKzLhLT9Q
        xUV5gd015KbufbSBi9lppfGI3bZ+Jyo=
X-Google-Smtp-Source: ABdhPJxruw3LauMi/kdqcd0a1xbkf42wJZ3sPtgbnfUtrwW4m7ceco7H0S2yw+oYuIIOwZ56ISyiBqA0Dus=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP id
 t16-20020a17090ae51000b001d9ee239fa1mr140465pjy.0.1651704720721; Wed, 04 May
 2022 15:52:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:33 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-88-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 087/128] KVM: selftests: Convert debug-exceptions away from VCPU_ID
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

Convert debug-exceptions to use vm_create_with_one_vcpu() and pass around
a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/aarch64/debug-exceptions.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 63b2178210c4..b69db0942169 100644
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
@@ -240,27 +238,28 @@ static void guest_svc_handler(struct ex_regs *regs)
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
@@ -278,9 +277,9 @@ int main(int argc, char *argv[])
 				ESR_EC_SVC64, guest_svc_handler);
 
 	for (stage = 0; stage < 11; stage++) {
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == stage,
 				"Stage %d: Unexpected sync ucall, got %lx",
-- 
2.36.0.464.gb9c8b46e94-goog

