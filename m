Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39D53C1BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbiFCA7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbiFCAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409B24BC8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:11 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 35-20020a631563000000b003fc09751ce5so3042248pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=atArEiJp1kb8rVKjSaRcbMKJL55Q7qDngNFebbBXIus=;
        b=a4XpsL8IxxkJ+JjrZIOeRkTqsKontYyIJN3q84RteOSVBDdZlYMxWdTZwTHTHMPQEa
         RaRdV7i9NZKle0Rmz7tf/limvDNcWuu2Zr+TwvkIkwW16FSXNDS394uZclLKYk7nOy0t
         JSTbPgbjb6RQz6F44umXnb2QdnKeZ8xvHan50z698w74JneNTfCHVQHn/F+hPGA3hetg
         6HDPegIZl9Ie6X90WI9yrjXo0dKo3fdqDl8Jth1VaAwwuGHQd4PIWKwZI0RGrrULlwmA
         hLUKcC/B1+meOqS5qOXXS3po5TWa/9gKlv74R/Hkcy1LFLKe6rJ4qjKPU1ylqx0uloYH
         zILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=atArEiJp1kb8rVKjSaRcbMKJL55Q7qDngNFebbBXIus=;
        b=gVzLcqHNNEGn+aSmIGoiaH/xrUv+G1ZrdbMdic3vWzSgS0150YSfGeyZGJzNUUIP1L
         i0MBMicwKT5LZKJi6RKBauFslaaxKymvZf3xU3lohpAkWcA2sCXPZ7sN7LTouhyvijpo
         FnQz++/M7UhUn4LtXLefFn2BqTejzjCjNcEPiU6/joRDslecX0OmnzPH7ENUWdEkVdbR
         IN6MYFbmXa3rH0rA6KgrMnGFVBbGb7kzIMOgGHyCKvTv7dFc/xlbYAjsfJopoW8h87Rh
         ltJ9N9ueSL4cyBR7Lcs39ngury29eiZimLt3SOQJa777aakOYkUXckq+v1EQrK1w9UKy
         +9uw==
X-Gm-Message-State: AOAM533qpwAJTNrZJO5G0l2PLIxMeRcXcOScBx/zi45daS2mQ8jJwiBe
        5Tluw8PIKUC32B0Gajq/Ia004+g9QPg=
X-Google-Smtp-Source: ABdhPJyNb8kAM+QHeYchzj+F8Cq3TlF26hN8NFqs8SmsmkHxITbp+A0uJYgT7Ah/Ak3tRlido5K9J7Qt7Sw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:120a:b0:15f:99f:95bc with SMTP id
 l10-20020a170903120a00b0015f099f95bcmr7650867plh.48.1654217231179; Thu, 02
 Jun 2022 17:47:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:06 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-120-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 119/144] KVM: selftests: Convert s390x/diag318_test_handler
 away from VCPU_ID
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

Convert diag318_test_handler to use vm_create_with_vcpus() and pass around a
'struct kvm_vcpu' object instead of passing around vCPU IDs.  Note, this is
a "functional" change in the sense that the test now creates a vCPU with
vcpu_id==0 instead of vcpu_id==6.  The non-zero VCPU_ID was 100% arbitrary
and added little to no validation coverage.  If testing non-zero vCPU IDs
is desirable for generic tests, that can be done in the future by tweaking
the VM creation helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/s390x/diag318_test_handler.c       | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
index 86b9e611ad87..21c31fe10c1a 100644
--- a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
+++ b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
@@ -8,8 +8,6 @@
 #include "test_util.h"
 #include "kvm_util.h"
 
-#define VCPU_ID	6
-
 #define ICPT_INSTRUCTION	0x04
 #define IPA0_DIAG		0x8300
 
@@ -27,14 +25,15 @@ static void guest_code(void)
  */
 static uint64_t diag318_handler(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	uint64_t reg;
 	uint64_t diag318_info;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	vcpu_run(vm, VCPU_ID);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_run(vm, vcpu->id);
+	run = vcpu->run;
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "DIAGNOSE 0x0318 instruction was not intercepted");
-- 
2.36.1.255.ge46751e96f-goog

