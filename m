Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B943053C1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiFCA42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiFCArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:18 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C237BDB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso3522317pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+G2Mc4uEcLEuvE511QGrYZMpWnJKj8uJhsUqAFoxTaU=;
        b=EBLFg8LOEt1v0b5uPUhfA/B0DzhK9G1oKVuAkjEz231j2/rvpCjYbhxnr5eI2uTCpm
         EVEtevDkYmRjSs5HF+28JrrFY0iKWrPfZ9x5CTRqrRtdYei/6tMu2a6rUh3bNERJV6gJ
         1opPS19FyXErT41xNTCistoenSWK/CKJVUXomQrc6xnNx/7ZJKQX1GL4oQh97/2KvITt
         mMG+/ajz7BdHnzsaaFTE/YhdbcT2hljQpifggYUYszNeoNQ75aGvYDdcPvwCASW0hs7X
         06vz263LGPlW61tCaUdpNrcnXU99u2H8Kc2tPNMudf1BnUY9icW3l0Eva7EA3eyNFRQp
         PChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+G2Mc4uEcLEuvE511QGrYZMpWnJKj8uJhsUqAFoxTaU=;
        b=LjRQxJqDpDXPpML32/t+PyCjVjOZDB7RO307Wi+raYl6/nbYG2du0aLU7uQc5qBngX
         paDyfnxnMPx93hFSBG3s2dzL762pFRQtEnMYotBRd5piQ5A6318DU3n1soOphSu8j5CT
         PVQusT4MF8C/TZNsHfCKpS9AuV3xG2sXeMICMFbz17zFs0Mbe1ZMzzEgKrxoaPLZYCj3
         QFlW5W7TSBk943VGImK+8475J2xII7UalR/eGvzQaDVOdm9xhoEZaMrXzqEEk+NDf5t7
         nAvWFvDjF7QvKi+GnvB05MtgE+pnLYzydcRrrb8VfNEcQfegdHT6rBL6m9Q9btr61rz6
         Ehow==
X-Gm-Message-State: AOAM533X+1woqqiQ7D6LCl4FsDj0hhzE3vfoubo6oaz+3fM4/beRBOIC
        TXQXniLNXZ1E7srCipudqqsK/HWZJCc=
X-Google-Smtp-Source: ABdhPJweTcqTwf2ATxClTWmQRZJVLDRFJGLzBz9z4YK5OB+B7IeRWYC2yi9kbkHYoqLThNSOHLiFf9AQvjU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3841:b0:1e2:f16a:a117 with SMTP id
 nl1-20020a17090b384100b001e2f16aa117mr27262446pjb.130.1654217193862; Thu, 02
 Jun 2022 17:46:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:45 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-99-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 098/144] KVM: selftests: Make arm64's guest_get_vcpuid()
 declaration arm64-only
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

Move the declaration of guest_get_vcpuid() to include/aarch64/processor.h,
it is implemented and used only by arm64.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 2 ++
 tools/testing/selftests/kvm/include/kvm_util_base.h     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 59ece9d4e0d1..4d2d474b6874 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -207,4 +207,6 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
 	       uint64_t arg6, struct arm_smccc_res *res);
 
+uint32_t guest_get_vcpuid(void);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index fbc54e920383..d94b6083d678 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -707,6 +707,4 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
-uint32_t guest_get_vcpuid(void);
-
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
-- 
2.36.1.255.ge46751e96f-goog

