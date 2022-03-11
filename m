Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684B4D5B23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiCKGAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346682AbiCKFyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8DFBA40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dbd2b5e180so60958177b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=QNnRoJhZKEQyM/+E7bB1cN1LmMxMwC2JWJu27WTAeTM=;
        b=Ry+dEZKN+MH4zff16isFV3FfMvQ+BCkZ32pitHXN2VEamd2AJiR9FphyjNg88P9VuP
         8nvTXjSCfBCvopww/LlHrgabXXcLMSCZ84lxQIJ6oQLWjF/RmSIDl10AyoJgUKzKri03
         NAzEUV0PPow9po5JjaMnFg24lGgc7WpD7RsC36w8ULy6EHpxBYL2vmSjklcvAPX26+Xy
         vy4aGAQWQYjxGA0QK+lexwp6iIX/PQkgwX85YSxdGO0XBzeXIz/N6P65kCesqfXSOox/
         Lq3vq9Q4A5UpyHZa4BxHaRiuJizQLI1VpY5FYxDbzle+cn0PAWFTClDHVxAU2YoSPXCO
         u9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=QNnRoJhZKEQyM/+E7bB1cN1LmMxMwC2JWJu27WTAeTM=;
        b=4clJFHclZEMiZ6CORHnGmqMJblFz/nbGfr/46RR54mGKQJ3C5N0Uo2XhQJFJKpyAdW
         uPjkHNjNenVUmQYAc7SDPZqwznDMkhdhTVQ7gZl9vPdSxqFoSP076JC5LL5bvUnB898B
         6L8lCJ0w7Aq8ZB+Na99Aq77R0meM37Xh8TNJesepi9R/FF4CXv3agaJi0iK0ERTuzHL3
         jNG0l0EKvjEDxeXyg8irgkUOk9SB7YKVP5yhUNdRaww/tEWVJxzV21MNZZ+6pnK8FdyF
         GdiJHfSl4hzxYOuPimbFPlSOQau6Tz9ezg1Pao0Q56/ILDFRPLIScUQWUmQRoUySuHT/
         43vg==
X-Gm-Message-State: AOAM530FEbtPbvgL0MgzSadj3Of6jWPWWChL5juiFcUk88tyqW8LCzVp
        ZA/l17SlmuJ6WxaTuCpRqulL2J20HbT2ybCbTgrEDVaAMVTc4rstJYrCFINs/tzPZjwK/J25shC
        mZOWN4YcdyRPI+UKzhAqsSe7sxwd/k/Jg5GShYl/ex8Jr3Z+/7bVK8jmtcQIzYiJJRO2/jw==
X-Google-Smtp-Source: ABdhPJyyEB4J3/QUI+gHEPET1+jXWCa7sRxei7S9luq6Lzr95phlO6T30+GGBVDQpCwT4yY23CoEf61XufU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6902:108:b0:621:165e:5c1e with SMTP id
 o8-20020a056902010800b00621165e5c1emr6589152ybh.204.1646978006526; Thu, 10
 Mar 2022 21:53:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:34 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-84-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 083/105] KVM: selftests: Convert hardware_disable_test
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
 .../selftests/kvm/hardware_disable_test.c     | 25 ++++++-------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index c31af07fae97..70cd22485357 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -27,12 +27,6 @@
 
 sem_t *sem;
 
-/* Arguments for the pthreads */
-struct payload {
-	struct kvm_vm *vm;
-	uint32_t index;
-};
-
 static void guest_code(void)
 {
 	for (;;)
@@ -42,14 +36,14 @@ static void guest_code(void)
 
 static void *run_vcpu(void *arg)
 {
-	struct payload *payload = (struct payload *)arg;
-	struct kvm_run *state = vcpu_state(payload->vm, payload->index);
+	struct kvm_vcpu *vcpu = arg;
+	struct kvm_run *run = vcpu->run;
 
-	vcpu_run(payload->vm, payload->index);
+	vcpu_run(vcpu->vm, vcpu->id);
 
 	TEST_ASSERT(false, "%s: exited with reason %d: %s\n",
-		    __func__, state->exit_reason,
-		    exit_reason_str(state->exit_reason));
+		    __func__, run->exit_reason,
+		    exit_reason_str(run->exit_reason));
 	pthread_exit(NULL);
 }
 
@@ -92,11 +86,11 @@ static inline void check_join(pthread_t thread, void **retval)
 
 static void run_test(uint32_t run)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	cpu_set_t cpu_set;
 	pthread_t threads[VCPU_NUM];
 	pthread_t throw_away;
-	struct payload payloads[VCPU_NUM];
 	void *b;
 	uint32_t i, j;
 
@@ -110,12 +104,9 @@ static void run_test(uint32_t run)
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
 	for (i = 0; i < VCPU_NUM; ++i) {
-		vm_vcpu_add(vm, i, guest_code);
-		payloads[i].vm = vm;
-		payloads[i].index = i;
+		vcpu = vm_vcpu_add(vm, i, guest_code);
 
-		check_create_thread(&threads[i], NULL, run_vcpu,
-				    (void *)&payloads[i]);
+		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
 		check_set_affinity(threads[i], &cpu_set);
 
 		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
-- 
2.35.1.723.g4982287a31-goog

