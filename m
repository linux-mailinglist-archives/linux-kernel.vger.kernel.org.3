Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA151B2B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383552AbiEDXHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380509AbiEDXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:00:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6857B3A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z11-20020a17090a468b00b001dc792e8660so1320270pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Y0ltxz1n+cyN9oREkFOZuEteikspMaetU0xjw3Z41ek=;
        b=aUFgP/bFtY1euxIu3o+lcaoKK4P/6/CaCsFszu3Zqslm0vfXNjHvwREDNYSy79i9hw
         JkiVnd36bY57O6fq8Ope5Z0RvUawzJM+Pv+Fe3DiZZHSn+/TLZJZe5tTTjzrQsVrAy0R
         RyuMQtrYBqQmSp832a9nz6c7Em8uJ7Tlw4qEXzXTKMLKIfZK9oJgphZnJbFHwO6WfK6I
         z0p65ncHT+sX9s/NXV4HImEg1qQEk5asvqsk/G26KsDXTKfZD0XPAqi+yEZLOaB1NkHf
         Pd4y/H6vtaVy87NB2NhjVBfLKJ+AZ4lFQfPuYZH7YNUuZ1gax1sAhuUdK1clShZApbyc
         990w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Y0ltxz1n+cyN9oREkFOZuEteikspMaetU0xjw3Z41ek=;
        b=CgRXVeblBBuw3ULsourQhZsgSCbC8nbtn/ar0BB1rBzSLpuHrzemITDSr8bD9TTGdK
         jfmt4ixLg9/2iIS9D34bQpktlMsf9aqnuTyaGcJy+PfACB9suAt6ZBgICPvaaejDNw7m
         hdgPbejug+NCz5QOCwttsFM2qREmpHW1CV1GBrpUpwHnKpzAfRwb4/6tlGl+jTmoScNI
         6LXnpDF5Q4QqMfa0jh1+In3LqmjPNN7aRtM3Ok+3jejUGhNDDxbSC0lio7Rr2S+u73g+
         9inXhd/Gb2yjAL6XDcisz1SplA+Py45eURouZ1NRXqWbFhsxl+qUcweM7bT4i98rB6sM
         t6Tg==
X-Gm-Message-State: AOAM531NL2JlzACa644Sbo2ryiXc47Bbf+wgyK4XxGqHtfEhUutYKDKT
        LUmZr0OfizFz7MMS+hYpdMcbD04/PGs=
X-Google-Smtp-Source: ABdhPJw0c4fwBdmtI5STNhQu6KndxT4eTv+v+03HIZdr9hfcfayqBDensfmmaO+7Jn8mEt4lc5hIl5jNexY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5d2:b0:15e:9467:187 with SMTP id
 u18-20020a170902e5d200b0015e94670187mr21683068plf.123.1651704776410; Wed, 04
 May 2022 15:52:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:49:05 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-120-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 119/128] KVM: selftests: Require vCPU output array when
 creating VM with vCPUs
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

Require the caller of __vm_create_with_vcpus() to provide a non-NULL
array of vCPUs now that all callers do so.  It's extremely unlikely a
test will have a legitimate use case for creating a VM with vCPUs without
wanting to do something with those vCPUs, and if there is such a use case,
requiring that one-off test to provide a dummy array is a minor
annoyance.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ccd194007e90..9cc1eacacb4e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -306,10 +306,11 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 				      struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
-	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
 
+	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
+
 	/* Force slot0 memory size not small than DEFAULT_GUEST_PHY_PAGES */
 	if (slot0_mem_pages < DEFAULT_GUEST_PHY_PAGES)
 		slot0_mem_pages = DEFAULT_GUEST_PHY_PAGES;
@@ -330,11 +331,8 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 
 	vm = __vm_create(mode, pages);
 
-	for (i = 0; i < nr_vcpus; ++i) {
-		vcpu = vm_vcpu_add(vm, i, guest_code);
-		if (vcpus)
-			vcpus[i] = vcpu;
-	}
+	for (i = 0; i < nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
 
 	return vm;
 }
-- 
2.36.0.464.gb9c8b46e94-goog

