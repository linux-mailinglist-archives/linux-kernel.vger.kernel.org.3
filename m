Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492844D5B22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbiCKF7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiCKFyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0190260
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p5-20020a17090a748500b001bee6752974so4596741pjk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fm4Ez6oGyl4LPe9mYSi8bmbgLSQ68BKOeDO53IkpUIM=;
        b=h2CP2Jb+1kLR3+tIB5df6wfhbrMGxGnDLUSNLhNxdM2RsuHjfcoet0BNBwRXOAeK2f
         szCSLE93OqwEegMEjnRTq10gpQIHmafLmv01EJyA7aVKAD4gkg71WQ0S+Kz9sUvWHtk7
         QqGqEthqNkBq9m0haZMwagHBuYi6ony/jB3d9SO+H2I+QKvTi0YlQG6D+vGxgiL2zFLU
         jc8m5iU0J8R9YWyUMo1a5XmpkFHij3b9IOao0gFWXDaPJV4EAS6Nrg6V/MHm/E4XmdYi
         F0EmkuNDV8mHn5A0toFk3SoZQpEPojbmm+OV5tryDVpCKdDRF0GcsH6cFzl9Q0SJssw+
         VOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fm4Ez6oGyl4LPe9mYSi8bmbgLSQ68BKOeDO53IkpUIM=;
        b=KialOnRalucgAa8vApHqrUHlkczQkzGmfeb2LBPLEq2CGeMz6XdqObtU3C6VtuFuPz
         b/r9yjluD0+1mT/Jgn/RJ7PT4kZIOe4PeQ+X50Ah0j1ZDYFXwSSUcoFYWqv3K004l9aR
         V96yDX+8qcQgdPkEd9fPbG5kPdk1G5FmzK7JCsd7zeMWHngngsZ28oPv17SbUEzDIt4g
         TOU+9ssbvX7IIirJG7AB+Sv6Dgp2ZCyBrsLJ01c+dvjq9dZzJsZnfXdXhXpKPmHcqY+7
         m7NckWbevd9FN1oQiGEFCD2aR7+IR11Ww/Vtz5G2m7LrEpCv38QvHS+10/nMCXNflLBW
         7fSw==
X-Gm-Message-State: AOAM531sEUY2SoOYzYajPqEDRlMssr9LWUkHbarBa4Sstnv4votEKdYV
        Kw/v9Qo73ZKCxIHdmwVFQvBXhZzm2ysMjw5CBLQwkraqEhxgynjmIh70MDCMGFl/NaMIxtgaeJp
        /gjqLZz5WSEUjA4RaP2hyAn01sVoGXZgt9x9W1Kg2qION4+5lH6hjjx0HemyJs75ADGGlmA==
X-Google-Smtp-Source: ABdhPJzdtT0AWT0bvZgzHoaNplzt1NmCVMJtRt66d8Nt4cxwnXp20DzahHhYlQsC6SnyOiu32qDl8l/vBec=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460945pjb.1.1646977979005; Thu, 10 Mar
 2022 21:52:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:18 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-68-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 067/105] KVM: selftests: Convert userspace_io_test away
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
 .../selftests/kvm/x86_64/userspace_io_test.c   | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
index e4bef2e05686..0ba774ed6476 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
@@ -10,8 +10,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID			1
-
 static void guest_ins_port80(uint8_t *buffer, unsigned int count)
 {
 	unsigned long end;
@@ -52,31 +50,29 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_regs regs;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
-	int rc;
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
 	memset(&regs, 0, sizeof(regs));
 
 	while (1) {
-		rc = _vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
-		TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		if (get_ucall(vm, VCPU_ID, &uc))
+		if (get_ucall(vm, vcpu->id, &uc))
 			break;
 
 		TEST_ASSERT(run->io.port == 0x80,
@@ -89,13 +85,13 @@ int main(int argc, char *argv[])
 		 * scope from a testing perspective as it's not ABI in any way,
 		 * i.e. it really is abusing internal KVM knowledge.
 		 */
-		vcpu_regs_get(vm, VCPU_ID, &regs);
+		vcpu_regs_get(vm, vcpu->id, &regs);
 		if (regs.rcx == 2)
 			regs.rcx = 1;
 		if (regs.rcx == 3)
 			regs.rcx = 8192;
 		memset((void *)run + run->io.data_offset, 0xaa, 4096);
-		vcpu_regs_set(vm, VCPU_ID, &regs);
+		vcpu_regs_set(vm, vcpu->id, &regs);
 	}
 
 	switch (uc.cmd) {
-- 
2.35.1.723.g4982287a31-goog

