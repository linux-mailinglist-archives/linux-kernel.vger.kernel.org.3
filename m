Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFE4D5B45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiCKGB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiCKFzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B71045B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:54 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v4-20020a63f844000000b003745fd0919aso4213867pgj.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=n6MVcBp9xF00LuCwzBhnfGyYw6cwlL4e+hz2gsv1tH0=;
        b=pyxdEO9F3FP7xAgGgt1/oJekPIzt1FBQXaReU39K22pjrZhYTlxK/j6Mt5ctVKCZRt
         CAeL/cSURQpYTH6VT5rGmjVaYf0XUUnyTB9+v25Zyo/MmjXXury7MgJGh9cUNgG3JfOW
         uo886/We5zDTTFWSWp93RF1x4qv8EbBzJKQnbRlvUNnpegHr+6wk57DEfaFBesGRtkzV
         M92gmNtyMT+/WwbPF8SgFUtU78lHwF+kBRx+tsBUdp7zShYRP/2EakgWh6P8dBoINp/w
         WLMdVjoZ5Jl0xuC425RetQpmnGchCP01Ayft8uG1WzqPYgeV7cdap8pINeptigwv/aqR
         gPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=n6MVcBp9xF00LuCwzBhnfGyYw6cwlL4e+hz2gsv1tH0=;
        b=hsIdk24drW6xVuZuBd9aTzk8OdwwSHn4mFJBJ+zPRvx1kt9V6hoscb36Wv2DlWoZH8
         WEoXLIfZ5PeISFpp4GkBZKyfsYr0KlrKvFlW1z+/ZgjpSr4ogbvyoVosF52Jp4OdKWka
         3hM4NLYN5+jrCoC6IuZbtXxmjPaH44sRZ/Vv8YGvDA3q7kWIrthIa8NFyAB2Nn5b22O1
         84tmgfc1XhMvRKNNytVstgMhLYb325CcmYINrnc6c2FPQJeqOQHE/BNQr1QgfogyxQKO
         hm8xyWCbSBTh3NT/fFtdQEY3QpgMaEacsUeDOyskAoIcQ1pt7AwdmjZfmFbmzrx5OB3Z
         QCQw==
X-Gm-Message-State: AOAM531FdqIom/BAbLXJ3xOppNu7kXCf5FlOrxZDkSnvijljDWzIgHJY
        ujxoO5gZ9QcLG4got4yjFeR9hlFtYRXs3jNRBQ449RKGDk2lw9jrJIsNdKIshWGwOevHNOdiA99
        Zi2XKW3yrQk+oHGIbFWEgu9+0fgeba3xnUgf4DkXxSmG/LkGV0QweOY1hcvrOePLA0GtZ6w==
X-Google-Smtp-Source: ABdhPJz/c7ZdvJfr7lmo/fQkf9d/zyTPhjXn+vUCORaETFy5iwpKKTesUOeCTuNUvdpKDg/QcrkglxaFXLs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5ae4:b0:1bf:9c61:6973 with SMTP id
 n91-20020a17090a5ae400b001bf9c616973mr9155539pji.73.1646978034000; Thu, 10
 Mar 2022 21:53:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:51 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-101-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 100/105] KVM: selftests: Remove vcpu_get() usage from dirty_log_test
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
 tools/testing/selftests/kvm/dirty_log_test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index e480b503c08b..7bc2c027492d 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -668,7 +668,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 	}
 }
 
-static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 				uint64_t extra_mem_pages, void *guest_code)
 {
 	struct kvm_vm *vm;
@@ -682,7 +682,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	vm_create_irqchip(vm);
 #endif
 	log_mode_create_vm_done(vm);
-	vm_vcpu_add(vm, vcpuid, guest_code);
+	*vcpu = vm_vcpu_add(vm, 0, guest_code);
 	return vm;
 }
 
@@ -716,10 +716,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * (e.g., 64K page size guest will need even less memory for
 	 * page tables).
 	 */
-	vm = create_vm(mode, 0,
-		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K),
-		       guest_code);
-	vcpu = vcpu_get(vm, 0);
+	vm = create_vm(mode, &vcpu,
+		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K), guest_code);
 
 	guest_page_size = vm_get_page_size(vm);
 	/*
-- 
2.35.1.723.g4982287a31-goog

