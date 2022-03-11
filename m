Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3294D5AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbiCKFyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346629AbiCKFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24578F47EA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:50 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d145-20020a621d97000000b004f7285f67e8so4625108pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=iI4XTc/wR6t2j4zmaPouy0Ex+zWaKMJ1wxjoKdDM8s0=;
        b=TcFWlrsfKB4Ni5oft6Gi/P58XgEfWqvJIGiKdVIBM37zoyL9baSvAPQ9b5AYs4bWcy
         mlnwbCIvpURi8OdSxQEMyRFpl0eHyO3SyASQNpJZQtEtqWg9bl6psDtx9XFlTfsgfbb9
         L95ebIUdrK4+AP82ez6XL0ma+VdlJ9al+CJIa6WWCc9wPHpFlNcjOYEcz/FeZHlcxikk
         kZ0NW+SXFwZKl+NflJVnVRF4ahyqCBZfSthLau400xUccnSR9YPx1SksMmqih1+ncAlA
         RhgeVgbzeMucp8hvLzAQlUciywClyoqSWDfZKi89DBcDd71fLVyqK1NPN2MWjJJr9Cks
         fb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=iI4XTc/wR6t2j4zmaPouy0Ex+zWaKMJ1wxjoKdDM8s0=;
        b=XUBK3+4YfDtyXgi9jDdaQVhwLw6So+H7Me3eGkdzyT0ufGjBG6cl7etSCS7al1Bk4i
         5+KE86pOKqDmahbFGNIWIUJYqFMOkElrhHsDrYw9SMSGHpYdsJ09Jt8bHoY0K1y2fG+2
         V3D/5jEVa4O7bSm2xpAH37qFqspY/ALQ97+UwTvkjlnR3KUfwoumlEQKX3/DpzSd5EUs
         jcMNvSJoCGzwfoVDNbSqbVZzpP71N5gsjomttz1UV+y7w8AdvOnFejKxduBdUe5qlYC9
         mv8aVMC5dJsf5zZ+WLpEvRnE8XIu/W9/xDrwGr0BH3Cwh9xhj1bh4cdlVV+m/z3zBLXt
         exXA==
X-Gm-Message-State: AOAM5302JZJPj/rKO5yQL9mKusjUJeRnKtYN/YAS/vQUK3jLu16sTSCY
        ZOWXGIsHWxM+4TgoE8IArAz1u4aRHOnvGLxdmXyGKAb4/YojBbjaxSZLFQGPwtMMq0T5ZHjywuS
        ws/7yqPBjp/YcayP16PGnSADswTofuqHbHMP6o0OvP4HnVqsLUcpcxwXRr2ITEcGPXYV5rw==
X-Google-Smtp-Source: ABdhPJx3FkLzWSbRDV3YpRaCRYf7Re45glg1XPevAsRxd0jqPrSD3CE+NHSAs6HX658gxxpy21AN7PhR3CI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1501:b0:4f7:948d:14fa with SMTP id
 q1-20020a056a00150100b004f7948d14famr94271pfu.74.1646977909517; Thu, 10 Mar
 2022 21:51:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:37 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-27-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 026/105] KVM: selftests: Add a VM backpointer to 'struct vcpu'
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
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index f81443666f8c..21020d6a4f01 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -47,6 +47,7 @@ struct vcpu {
 	struct list_head list;
 	uint32_t id;
 	int fd;
+	struct kvm_vm *vm;
 	struct kvm_run *state;
 	struct kvm_dirty_gfn *dirty_gfns;
 	uint32_t fetch_index;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e2427b51375d..ed7e2c5b0062 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1070,6 +1070,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	vcpu = calloc(1, sizeof(*vcpu));
 	TEST_ASSERT(vcpu != NULL, "Insufficient Memory");
 
+	vcpu->vm = vm;
 	vcpu->id = vcpuid;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpuid);
 	TEST_ASSERT(vcpu->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu->fd));
-- 
2.35.1.723.g4982287a31-goog

