Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7B4D5AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbiCKFyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbiCKFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679FF9FB3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:37 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so4205675pgg.16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=mSaO6+QnMWWeIwCnlQiy3I7psXBlkN5aFHPmI5GJrpE=;
        b=FCGnqjPbkseOrMYyCHrqxAIaVqtnLi8AxjGKJPZX3S5j3a66lxzSyS/yD62o0BjUPi
         D7bf3dIefvNcU97dei7CR+FUF4vB9txnMqMrE1ZfVmj/OI8ZWE3X9DVCvSX88KrsowqU
         UOBxu+rvxAl5/Nqx49/Tl5HkRLDedWQRZZLfidlpqIMrnXPdv0UWUm0cJ7u8sDK1tZgM
         e7YnxFLQuQApbNg5yA9XvELEOIWooHpkYs+JDjDMr/hMF++VutHq/NAN7U7r/Xo5Oo24
         pY+kwEr6u8xXcdhQlWCtV2b/PlmpDdOd7pD8/YcEKSUwceX65jmEMJIZg4/PODi6pMKa
         0uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=mSaO6+QnMWWeIwCnlQiy3I7psXBlkN5aFHPmI5GJrpE=;
        b=UhpZdSxz+N8/SaWGUEFyUw9nKPKlYuRjUPVpIN562m2S5D6Z11Qdv+57WPLbH+6Qqz
         /B1Jku0KlNhUee1OM9PVHIXuUXrdENd/RF8xQ9Y2nf2VFMWcKG4pPTcRzBZqln3atKqp
         LxJqEhpQgUiD/glXTm7q6Dcb4P6Ihun8NVP1EBzRPOzvDqBvhjQpvff51X9y9Ao+NKhh
         A3q5dNpO+5whCURMmgqcP0ULZeG7Qb+hAHOTcyGvHQEQoul0pFfdHpNUdGe+YUidvIxV
         XGm4BJjrct6iVNloW2yYfu9GJfmiLh31DxyMKW30343ribAu6ZPDFiRKgae+HNOqt7t7
         DREA==
X-Gm-Message-State: AOAM533/7sS9dJcNPyc5X5SSM2PuXgK+ktfanH38p9uUg7XDe4QLjJIQ
        2b8oEONjnVc/kKXm+4tY3fC3DCQ86t7Osq77eAXy4TPIZzgVnghmv90hEipHur6F89DUFc30jv5
        z6d0lOcQh8d8uH9z4Wj/QK8Wp4BhnyBbhKvk6FKdpOMzwqA4GtSbLu/MNbxR+rgAiL6nACg==
X-Google-Smtp-Source: ABdhPJwIafp9cvM1AbG13Srks7eDiQ4MqalsNr6N4Rrx/YQJKV3EBpTT9sxVnkvvt67S1nAllnBuda+MnlY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id
 mi10-20020a17090b4b4a00b001bf083d6805mr20581582pjb.174.1646977897282; Thu, 10
 Mar 2022 21:51:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:30 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-20-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 019/105] KVM: selftests: Use KVM_IOCTL_ERROR() for one-off
 arm64 ioctls
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
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 6fa52e141e1b..5f6967058647 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -472,15 +472,15 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
 
 	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
-	TEST_ASSERT(vcpu_fd >= 0, "Can't create vcpu");
+	TEST_ASSERT(vcpu_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu_fd));
 
 	err = ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
-	TEST_ASSERT(err == 0, "Can't get target");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_PREFERRED_TARGET, err));
 	err = ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
-	TEST_ASSERT(err == 0, "Can't get init vcpu");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_VCPU_INIT, err));
 
 	err = ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
-	TEST_ASSERT(err == 0, "Can't get MMFR0");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_GET_ONE_REG, vcpu_fd));
 
 	*ps4k = ((val >> 28) & 0xf) != 0xf;
 	*ps64k = ((val >> 24) & 0xf) == 0;
-- 
2.35.1.723.g4982287a31-goog

