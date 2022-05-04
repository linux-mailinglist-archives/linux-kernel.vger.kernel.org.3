Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8051B35A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382017AbiEDXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379787AbiEDW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:58:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD8056214
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:52:16 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w3-20020a17090ac98300b001b8b914e91aso1320333pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=36MP1emo2zk5OGkKkF+DZacxN5PgxLSoE7Zm4l3PLFU=;
        b=PCvMrfENqwL4KF2jfXrzGcapgqFJoYJzEm5QdV5NI7q49HboZ6ibIpXBIEicTJ1v7l
         4Ee0BgY9mIqHvgzwuFGPvfr/KT1FOiSGWDm9JSrKpiYFD7GPpCbxdF549ge+oKiInoUX
         mXfwLp3ETc4j0sJcJBP/tyzhnhW3Yo65DVYb4UK1IS3O5BlvspyND/eem7w84Bw05xhq
         6J34qZlFtA6OEsxsx4+hbPS1MCcqMHXu3OxHyvKnHihm6aGH91pr23QQ6foLP1y7d6Tw
         LPzRTR/9WknJuYuzi4KuGsESlE58zwHh+ZERamrzTvGpyP8HeDmWZHGmA9Xmmxhdhypd
         uJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=36MP1emo2zk5OGkKkF+DZacxN5PgxLSoE7Zm4l3PLFU=;
        b=7u8DxoHX0g/Jk668sXx3pI84ZEliRpiF68i1w4pJUvhCPy/qhJVRRfuwtv10Mq1bBj
         z/RUP0Ii1OWnss/qMi7h+/WRCn3rBegfjRoV5yw22DoHG8OyCRik3xDXIeC+gs8Zs7NF
         rfzq8NBHodhs3E2D6TVKc6fFYMs6CdyEOvbAaMvTZIq1CjAMHYcAsT7IfjVkJDGcRpGl
         TMbWSu6PyYg4gtDdKlZQm9iuuzqpAUA71qkJ6von1L6gdTnGxSD+NECLrGOWIPVtOtms
         n4GhgZk1AOO6vrFGIxXveu1FWdwANJOurMrviNU7Gsc18+fJSOEQmN5oTlRXGRBmdZJA
         4ZUw==
X-Gm-Message-State: AOAM532kaKNACPL1ItPR2AEf/KWXosIzhTftI+wYxrhU5fVVgu4GySaV
        tjJ/efVhjlnd7J3REg0s+piXI6UAIWw=
X-Google-Smtp-Source: ABdhPJx0yf6Wd7rpduiwh8C1FljRINilw9SerEN7Zutz2ba9UwqHPrm8AF+xI+kFOwdfZOpAf4UvwFQBims=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b83:b0:15d:1ea2:4f80 with SMTP id
 p3-20020a1709026b8300b0015d1ea24f80mr23518012plk.41.1651704725816; Wed, 04
 May 2022 15:52:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:36 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-91-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 090/128] KVM: selftests: Make arm64's guest_get_vcpuid()
 declaration arm64-only
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

Move the declaration of guest_get_vcpuid() to include/aarch64/processor.h,
it is implemented and used only by arm64.

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
index 4487d5bce9b4..f621f7ffc150 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -706,6 +706,4 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
-uint32_t guest_get_vcpuid(void);
-
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
-- 
2.36.0.464.gb9c8b46e94-goog

