Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA251B272
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379379AbiEDWzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379320AbiEDWxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6554190
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id g12-20020a170902740c00b0015d243ff163so1365483pll.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Djm5rmkimpppk7KGwmY5ydPxurjwLb8khy4Eso/pVfI=;
        b=Ek4WZXxNk4G1y/bYgSjgqG8wi2hJ1ktpeFX4P/lNsi+IO3jrVW9I+vU/Y6OVOxagVs
         /p4uwbp7UYn06bYGrdWEwBDafyFZkmU2yleSpbR5W/ZFHaoXYDUtl297ER4mcNJ75iF8
         aDCf69EQCA66L9Qs+EoJlZOiclGfKUn3mJVGMmq9nYVNY1ohpYNbgaG6ill0AA4r9Q+s
         cvxPNN124BV3b+k05YVbS3EetyY/McX4ZRwYJ8uZLY5H5T2R/ryjgXCNvcMcTKYFwziF
         Jn0vYjq6qIA3gmeVfsOl7EZRzWtmK+LYvrU4FEjDlvJ5YuWmRYdUOFx+PuEUrDYFD7Cp
         +ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Djm5rmkimpppk7KGwmY5ydPxurjwLb8khy4Eso/pVfI=;
        b=2tR1pbDtpmpVQ5M8y6omz+qtTEn03hSVbFOdyyA7/Fq5wqbOYQZqvo+IIwY9mVMyDO
         GpbwCQfQZcAGGQhty273HCbeQNgTeL32Fgsc9VKB6VhIx9lhAEl5cKxayw2MsPWWruqY
         3yVjVqA8OINixFXI4yvGJ1pUSLf2xIIBCHWj+Jk59A2jlCjtUA5DqtBFrNnig5JGXKc5
         E8uRAG/JLv8WBRHNY60gJpIh5Q4OXepyeTrRW6cSsqPhLheFn/YX0aQsqW0QL05w0TwK
         MwR25d/5+ish3RMDzUsQfdqIkfxO2Iu0Ycvvz5GlUhKiU19CDHwdsweWFgUVwnksdKIi
         Jq4w==
X-Gm-Message-State: AOAM533rCy9jT5RkWQfCGGMZ6TAYwPCl/9B0937VWFgy4etKjw/TYZBw
        AObhms95EwXA5zBKpcGs6TKPt9UAYac=
X-Google-Smtp-Source: ABdhPJxSjkxb1rTGdXpAgcLyiC0IoEq1IUDNIgnOtURf/eWK4K4TRTGcjNe6NFG682MgKIXHEbXhF2mHRWg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:601:b0:1d9:5a0f:2017 with SMTP id
 gb1-20020a17090b060100b001d95a0f2017mr2253310pjb.162.1651704607534; Wed, 04
 May 2022 15:50:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:27 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-22-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 021/128] KVM: selftests: Use KVM_IOCTL_ERROR() for one-off
 arm64 ioctls
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

Use the KVM_IOCTL_ERROR() macro to generate error messages for a handful
of one-off arm64 ioctls.  The calls in question are made without an
associated struct kvm_vm/kvm_vcpu as they are used to configure those
structs, i.e. can't be easily converted to e.g. vcpu_ioctl().

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
2.36.0.464.gb9c8b46e94-goog

