Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881EA4D5B17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347772AbiCKF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbiCKFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F2F3284
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a23-20020aa794b7000000b004f6a3ac7a87so4583209pfl.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/WQ/0mOujKZ36BCdIZx9sI/vMxrt+4LV8z0YUs+nqw8=;
        b=N4cvXe8EbhS/+75CxW7kF1EHZ7Xr9VdS5zvE3jK2zHzelPN0omdZjQEfjWpOAMn2vx
         kkJpwDvZ8HbJFScDb4r1BlBGh0Dc/nHsoYvvDLhZRMNlzfrS4pO2tpM/RZS0fAFis/lM
         yhK5u/znRjTvBMXIddmA6hxdEtEqRNh7GORTpkSAuehB4KYSPj8DWVMwChc4IIZhmhm7
         N/RS6Z7qO8+MVTLbmcq6R47fziCcP3tNcOZuCJY2njA+ABQFW14TpZa7tttMNANxntmt
         a49+qosrbjtsnP6vw7pC1v9i8ao8T7PiSFIcylouJVUcOM0aT34+D2MiukD5Mn8ENdf3
         f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/WQ/0mOujKZ36BCdIZx9sI/vMxrt+4LV8z0YUs+nqw8=;
        b=R9m4IFepXuayvT5I9wlMPdQVtUqxPTo9mliiVqtfGz03E0YpsJArd9ZZnau6HcghRf
         vT+nfF7EEoCVwHbdaQiF4Qo8QcyU4UEnw7h0DH4JqIRsVgSoyuTFwchiVB9cruUKCHlV
         32Stc5UpPZSqWZKfJGLhi9anwv70ic1FxJ9RKkvw9S1the1cNFRWa4Xp+b5aHiyWXioU
         gd3Zik1+LndSoQyVMbZP7IJnaUm6CTWO2scp8B5o3aXxGJFngZ+vdf1qXHr6FfPxxKxE
         wORq4B/8G3KCUp57XWkwUk/kOqTnF6vi5E7pndpOlYekZbnRHjakk/7ApBjxXpkulPDj
         upEQ==
X-Gm-Message-State: AOAM532kmHm6pEsTTIO6Gp+B0yJRC6j5McbCMIsdlZWxD7wwoLZSuKHo
        xSOJA6wrlRocm1BFqiNYyGW6gVH6cxBZ5tzL22EYSH2lo+6Rn1/ofxmF0mXzs6YZEfxv2ZDjaLN
        86lwrfshrSHKJafa5XIRvlV6skZ4Q0NnR9xaELE5MQhKXrIf8u2xCrcz/kppg5l1dRH5xjQ==
X-Google-Smtp-Source: ABdhPJyPLbR6ORW8inWJGmqblVriXBMezUrwzT/HHG7N529A2poFo1YjB0SDB/YlfR/Wgh0Z6vn+9+ZKqXs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr461050pjb.1.1646977994704; Thu, 10 Mar
 2022 21:53:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:27 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-77-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 076/105] KVM: selftests: Make arm64's guest_get_vcpuid()
 declaration arm64-only
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
 tools/testing/selftests/kvm/include/aarch64/processor.h | 2 ++
 tools/testing/selftests/kvm/include/kvm_util_base.h     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 8f9f46979a00..9a430980100e 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -185,4 +185,6 @@ static inline void local_irq_disable(void)
 	asm volatile("msr daifset, #3" : : : "memory");
 }
 
+uint32_t guest_get_vcpuid(void);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c64e99b9b6b3..e1e25ec09158 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -694,6 +694,4 @@ void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
 int vm_get_stats_fd(struct kvm_vm *vm);
 
-uint32_t guest_get_vcpuid(void);
-
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
-- 
2.35.1.723.g4982287a31-goog

