Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25F58EF55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiHJPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiHJPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:21:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D352DE4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:20:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v65-20020a626144000000b0052f89472f54so3272470pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ZH7CdRWCIwNg0rfB6pUeUyBV2qfCWplRtlLFdh/iMUI=;
        b=apwXC/ww4j5CUuVFoJyNaoq+BSpD4U+4DscUXqUrLk78d+ARYidpwEa5ihZfml/1pS
         RF9y0n45tYrpC3MIhhZk0erLNzoxOIB7yzKbM9hLF4yWG1H6+9Be3jII4QPCzX71NspY
         8ER7PYUunxvMsZrp0iN+lF1j90zPZWLsyqTjoMMP+PVuK77dG36lodOSzGEJgc44BByN
         tMp2OicDylCbNQIB+0UYfBDeESFY7Ao0DoUwQ8bcyxrduRXq6sMIbzo34wx5Hsjgwe+l
         Rh0mEqgTh4Trsb8m8VoKxipFaGY2oEPhPnr0B4daIm7vKJzhcnby9pV09OHAUFyG4oEQ
         zHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ZH7CdRWCIwNg0rfB6pUeUyBV2qfCWplRtlLFdh/iMUI=;
        b=SN9N+ukAgjrDXGnar85IdVfxd9mThVISmi8toeagD9rZhCpDiPTSKViJ6zyS0blA/J
         HBf5s6TJ9Aayucrg+OuoJ3y5fLkWObxrfMHM9s1sG9Hnw/E+5BZpHe/2226wBSJJ5Vk6
         iVq3laRYRUjWaSNg33T+Row2oX8i7otcCGnpK0RFH/VV+9n+xl2T9WoHkMahByduXDTK
         LpzfU8Azwrhg7WIfE0Nf5KpIQWvJGVCxNSubXmD0VkSH6fGhJONlbYeu9anjvzKg+Zmg
         LwgZ/MXfItzEgEDSCp3pi5nThp7HDs0/TDj82WD3vKSmOYzHKf346TGmq747NVEw/inn
         De9g==
X-Gm-Message-State: ACgBeo30ZGxyoMQT0xkyUxcMU+Uzv/0+3ZobbD52M+hZpKBDlHCgKYLj
        pIUadS07npENGtzg3X2Z/OqDvL/nv1s=
X-Google-Smtp-Source: AA6agR7/peE3sNp+8R/sQNztbFbtY9gi/ShTyBHi6GxvE2QcV08n2v2+coOQi5Gc9nYsEInoAH6es2+2RJY=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:b185:1827:5b23:bbe2])
 (user=pgonda job=sendgmr) by 2002:a63:6cc4:0:b0:41a:ff04:661f with SMTP id
 h187-20020a636cc4000000b0041aff04661fmr23530639pgc.600.1660144853502; Wed, 10
 Aug 2022 08:20:53 -0700 (PDT)
Date:   Wed, 10 Aug 2022 08:20:31 -0700
In-Reply-To: <20220810152033.946942-1-pgonda@google.com>
Message-Id: <20220810152033.946942-10-pgonda@google.com>
Mime-Version: 1.0
References: <20220810152033.946942-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [V3 09/11] tools: Add atomic_test_and_set_bit()
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, vannapurve@google.com,
        Peter Gonda <pgonda@google.com>
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

atomic_test_and_set_bit() allows for atomic bitmap usage from KVM
selftests.

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/asm/atomic.h    |  7 +++++++
 tools/include/asm-generic/atomic-gcc.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index 1f5e26aae9fc..01cc27ec4520 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -8,6 +8,7 @@
 
 #define LOCK_PREFIX "\n\tlock; "
 
+#include <asm/asm.h>
 #include <asm/cmpxchg.h>
 
 /*
@@ -70,4 +71,10 @@ static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return cmpxchg(&v->counter, old, new);
 }
 
+static inline int atomic_test_and_set_bit(long nr, unsigned long *addr)
+{
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
+
+}
+
 #endif /* _TOOLS_LINUX_ASM_X86_ATOMIC_H */
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 4c1966f7c77a..8d9b2d1768bf 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/bitops.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -69,4 +70,18 @@ static inline int atomic_cmpxchg(atomic_t *v, int oldval, int newval)
 	return cmpxchg(&(v)->counter, oldval, newval);
 }
 
+static inline int atomic_test_and_set_bit(long nr, unsigned long *addr)
+{
+	long old, val;
+	unsigned long mask = BIT_MASK(nr);
+
+	addr += BIT_WORD(nr);
+	val = READ_ONCE(*addr);
+	if (val & mask)
+		return 1;
+
+	old = cmpxchg(addr, val, val & mask);
+	return !!(old & mask);
+}
+
 #endif /* __TOOLS_ASM_GENERIC_ATOMIC_H */
-- 
2.37.1.559.g78731f0fdb-goog

