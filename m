Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710F4C1891
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiBWQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiBWQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:24:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DCC622F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:23:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g12-20020a17090a714c00b001bc25476de3so1031717pjs.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=Zq5O8IKBkl9yeultGadXfU2kv4EOG3DlmV7KiCyDcKM=;
        b=crEwl8LrnedZBA2+Md/f5sPIkTNDd3HYfHlrpjl5H/7KtrpKygDWvmlRLs4DvoXySZ
         B4oBmQ3HULN70w4taFlDvkgBuurBxC3QH9oshKsZ6UeJKsve0PTZdHGCMKIbR/A8Akd8
         fYcloBZvCg7y9iwDTa8g0OBJ1uuYqzyg+LAWyGZtCZbUQ5p8Fl65UCP3NR31QEZRHE7l
         PBrFDDztQdyQhT1PTlBKCLawcgtH/F5Z8zmU03CqPk5yRRuRh0PiJUkmzcD2RjOB7eg9
         6zCDwQfOTxiDUgMMN7TP9lrdV5zphFC5iM5NjO0qVJaLrNIyqpYMEjnw/JYRxSJOMhsD
         lYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=Zq5O8IKBkl9yeultGadXfU2kv4EOG3DlmV7KiCyDcKM=;
        b=xXyEEZP0RMfkGp/fqyuaJxHU6Cj38fWeckgh6TA0eo2w5hTBff6maiTfBEus4vXDR2
         elZbUbPnK1rk00woT5E/zRjLy+7LPVb5ojqWhOkd/aXif4Ka0vdgIZBGvQoPMgpXHN8M
         KkKDFHuRAhU8jfiPkfaBNx2JmYSPsX/aDGNMsKicynQARRrBNUPkHYdRwtHy2hA6OHMn
         Hh0YLK1hXELp0VKU9kcXEMiMYVWuXXv/FUpguITpgQq+r0EoGK/5EiZ7MCcI7rlGktcJ
         K2r4wR0pjpIJ3GmWAH1JlS+O/gw9dGY0eReNjdfotAqY+5KeFXopYAvgZ6pfNBvSFEQO
         uNmA==
X-Gm-Message-State: AOAM531OiEnaNtN/Y0CkA7DsJk49T/o0qPeeMj8yXDEbFO7jYsGkDZN5
        YpiFNN3TYCDhmZzclSOnsFiHGSvrRQg=
X-Google-Smtp-Source: ABdhPJzZQ0B8p6pIOm8+cCuTOJozWKUbW01GUCzK1dfNF6PIug84YVze+NcLDSwys7PuOxQ3ArOXBy0YDUA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP id
 pj3-20020a17090b4f4300b001bc7e5ce024mr57612pjb.0.1645633437536; Wed, 23 Feb
 2022 08:23:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Feb 2022 16:23:55 +0000
Message-Id: <20220223162355.3174907-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] KVM: x86: Fix pointer mistmatch warning when patching RET0
 static calls
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast kvm_x86_ops.func to 'void *' when updating KVM static calls that are
conditionally patched to __static_call_return0().  clang complains about
using mismatching pointers in the ternary operator, which breaks the
build when compiling with CONFIG_KVM_WERROR=y.

  >> arch/x86/include/asm/kvm-x86-ops.h:82:1: warning: pointer type mismatch
  ('bool (*)(struct kvm_vcpu *)' and 'void *') [-Wpointer-type-mismatch]

Fixes: 5be2226f417d ("KVM: x86: allow defining return-0 static calls")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 713e08f62385..f285ddb8b66b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1547,8 +1547,8 @@ static inline void kvm_ops_static_call_update(void)
 	WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
 #define KVM_X86_OP_OPTIONAL __KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0(func) \
-	static_call_update(kvm_x86_##func, kvm_x86_ops.func ? : \
-			   (void *) __static_call_return0);
+	static_call_update(kvm_x86_##func, (void *)kvm_x86_ops.func ? : \
+					   (void *)__static_call_return0);
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 }

base-commit: f4bc051fc91ab9f1d5225d94e52d369ef58bec58
-- 
2.35.1.473.g83b2b277ed-goog

