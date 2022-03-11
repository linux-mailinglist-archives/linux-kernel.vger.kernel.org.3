Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62B4D5B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbiCKGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346756AbiCKFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:08 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A37FFFB8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j15-20020a633c0f000000b00380ed7c5e91so1973418pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ofFBB4c5rOaIb3neyIo33ooJpytj9xkzw7AbqyDBID4=;
        b=Smz1YUw/PJiXcA87/XZNdy5svGjVCUkkW3++TDKBW/XYFuBCMra2fgtXR1k0Kk1Rvi
         1ef9WSEhi37Ikxl8VZ/7Ah+0sbqMRdORA1n20U6viuR9Af9m7AKGDWpGKhMI6Viq7aDj
         Qa+OOILTygq4RMOiYNsuZSwJERxcGAzDb3qkADLZkuSMkmd7Nh2+Ht8dQ7So6tnIF1c4
         +c7wJAlEl4OKBxyH5sBvICQfp9byb8vGq9pTRGRPcL8BHGtT0BsNFPPpuuMWWmRGoKOR
         S0rLSNzIgdLYJe5R5fUkrvaSIR1wdV/Qkn8HI/QHdwLpMoonUfKO96XYnAJ8ea3muTCU
         ltLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ofFBB4c5rOaIb3neyIo33ooJpytj9xkzw7AbqyDBID4=;
        b=Lpm6qFlrXCGJY8ihTM1q4UEW20GZGRHzxO9oOkOY9ml28YPGrWUutkBRcqr2K6epxm
         fddZ1+HGTClboHbZLgLqP7pvFks/8VVm5FD2dUdRUtJEQIKW1TpSLa/xeft8SBS5FQ7p
         GTIzWF55Jxxnw1+OOercZm0puVS5FcdGiybmCyzo/+IPSy38pFpY6u6trNdoLW6Gem4S
         hTZPLyvwf6QcXfvdmBJOvERd6Vziou7Aswpy9RTn+JZsmiiZ1lK5nf8bO4RDFvTDSQ4/
         G6UXpr6Du7uOSPPdV5sFVYMMlcWnjEHE19pWjw9Sue/oTsBNWbDKPpsph+Degig+HSiE
         l0gQ==
X-Gm-Message-State: AOAM533vpAkn3R7Sp60c4y/nkM1FKvHvkt9gzTIYhnJWvKale3sKNDMY
        qdLkvPom+WjQVtkTzMYtv353RNAQ82EVhbt5h5cs/UKdnMqjf1DGYLMYMDPyP4U8schuIfRcH1G
        BrUUE6tjtU/oUbo2k132qBVNgXuQGEc+0Sk2dkP3ruNk3Sr4hw8uRjvDG3y+JA/iPNf0AlQ==
X-Google-Smtp-Source: ABdhPJw3VG2mNuYAKP64VB8P2+kRw8QsRSzhKaC6Lp1Qa74aomTuMMVxlBTjADhVIWTKhFZmQnHMBq1XYBA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:174f:b0:4f3:fe06:61b5 with SMTP id
 j15-20020a056a00174f00b004f3fe0661b5mr8491682pfc.50.1646978022977; Thu, 10
 Mar 2022 21:53:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:44 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-94-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 093/105] KVM: selftests: Convert s390x/diag318_test_handler
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
2.35.1.723.g4982287a31-goog

