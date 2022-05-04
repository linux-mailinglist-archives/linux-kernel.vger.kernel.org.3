Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB751B294
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382841AbiEDXGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380243AbiEDW7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:59:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7E56F82
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a170903124800b0015195a5826cso1377506plh.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=MNZdk2aHSD0+/6jdlwq8oD++DPnxxVbOOlc8/sNiKFA=;
        b=ZKIxJhXhvZd4cu4L7JuNvGEuDMhzKvxLPk/FNK22bZ//xghJdK/P4zAhVxs9XYW09h
         XXzIRVlrqtbFXhbPaE7M0ieMY0tPptOFVgo+t9ysWX5H3pUEwiW0Yg1BWJR9VoFejRIg
         EP2lEB4zFyAzUoNpsfKZVbbuBemBHJClQ6fYpzxZdoI0N5fcKUYXn8y0CrnbJxzLAbqv
         zttcGSEMEyzfZ+1ETbYc6OVasMsQfsJu0iuYwuvxUIHyPUN+4yJBfb7TZVE4YJbTPjgk
         3qQ9mYbICDMsiucBh/8IXaBMol6sQmIaxPIqoqhH22nzyToM3UNJ4Bq//TtJswqNnQ83
         NG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=MNZdk2aHSD0+/6jdlwq8oD++DPnxxVbOOlc8/sNiKFA=;
        b=aHhtsfCnN2KJepCKTCWwKMiE9hjlyv3HbwHwYe0xvty5z6KhFT6Gp37monXyUaQ+fQ
         ocJGiK1xarh/zB/OUPGsQ86oBxtuXnJ44+A/VuXLiVOSmdVFq0/11FTSQnh2MoFxt/Ts
         ka18jgu6e3eHfzqvZSm6FeB3AlZ96e6NeWyYLGDj+upQ9Aq0o/Ce0NXv7r4iBhI7XvoJ
         La4qJs+qrBJpjc0TeU6mH6oFfiRolkiQ0MD23nX4+CVrGwtog3XEFc/ucHf7DTjlJPG5
         9w1wWr5eg0Y/5kHrYkcQWfKL4tCQfg+hUoCyrRacdZAwzh65Q1TABvyn5FmYWGb/GdrS
         SHoA==
X-Gm-Message-State: AOAM533A2xsyBPnGGoJjg1BUBco2OsgbwSPz1GHD8eYkHeFFNEKBK/KZ
        pZZ+V/SQEh3PInLeI75ohaxng7iPd70=
X-Google-Smtp-Source: ABdhPJwSHCMREXRH2Tvkn6eXDT23uVtw8KQn1QdMWGkH/AvP5uBScHKAz1RmshpKZNvUz9o9NjUGOTkV1zE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:215:b0:15e:cae9:7622 with SMTP id
 r21-20020a170903021500b0015ecae97622mr4283626plh.28.1651704755765; Wed, 04
 May 2022 15:52:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:53 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-108-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 107/128] KVM: selftests: Convert s390x/diag318_test_handler
 away from VCPU_ID
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.36.0.464.gb9c8b46e94-goog

