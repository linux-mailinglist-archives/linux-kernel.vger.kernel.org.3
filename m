Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133A587216
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiHAUMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiHAULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:11:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488243D599
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:11:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q30-20020a17090a17a100b001f31cc4ccfbso6422738pja.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wPIJC0kH8Rr28qz9cI6ptFgd7ftpiJ73tbDRbiXcB8I=;
        b=qs4eB9s3lwhhSxqXr3+IIqX1g9QuZMjEDi6wYfdXQy6yKNUcBcBnN99NyZlyFogPr5
         IE0HX7r7hzwoS4Szkr9eUvt7FTLaKBzzn2cEGWXuRPQGi4it4YwhYEDC8oF45U1sUV08
         ysiMAfQu4DIO2cs0JvVVawSrpYNJFSMIguF4rWcecR73XFZQPn91+Kdct1SKkJStr74L
         yvGrmVRS/kQsB9RXsCg66XbvyWXYWjUutbAAk3IofJqdXX7tOdD6E/pdnkXCk7sdtYi6
         1n2KpMUMQdmb/vDuLd3nTkYB1szzHk3WXoMr7U1huFK5VGFAgjieHcXaZsTkZwinNy0D
         a7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wPIJC0kH8Rr28qz9cI6ptFgd7ftpiJ73tbDRbiXcB8I=;
        b=3RE7kYGHwa3J4F1TnCBZsNkns7mo6lmX+yu+AsNKtEorVeGm1vtZzWt7rr/kGPP8hk
         dpbZZ45hOBDM+2SQM1CvKji4s05mzR8d+mnQ/kEDAXSn+GNbkNS2WPsLkPE18IAgGK4I
         p69V539IgbQCSwdp3OL1QQCdvUz6VdYKqtyRpq3lq0iPdeQZsWEQNjmQdR/gXf/R+TYy
         Qi6AnNbmDyNq6vzWMZ/Zcesl2LBaGOkxJzvHIZtXA3Hvrtz53g6JWplZd6NZlVoB4QM0
         lA9lfutgeCQAYtKmEDAieE/VeSeAg4d7J+BNqBECLdld2FTduAHHVV4iJ7Rw42LEmyF8
         DAfA==
X-Gm-Message-State: ACgBeo2YzoQNH4EFWOIPXvUeYesoAEbWT7S/NuEVJCeYQnirsy/Y/Zrp
        uR1mymi3VnWHG0NFRbKwPqYUh7qyLa4=
X-Google-Smtp-Source: AA6agR602aRiSFjdoUoSaxddQh4yvPJntXGflHCl3KfVcNOfyEwRIrD5A0oTb1nJKSU50uuKeZvxzZvWcnA=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:6be2:f99c:e23c:fa12])
 (user=pgonda job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr911864pje.0.1659384687606; Mon, 01 Aug
 2022 13:11:27 -0700 (PDT)
Date:   Mon,  1 Aug 2022 13:11:06 -0700
In-Reply-To: <20220801201109.825284-1-pgonda@google.com>
Message-Id: <20220801201109.825284-9-pgonda@google.com>
Mime-Version: 1.0
References: <20220801201109.825284-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [V2 08/11] tools: Add atomic_test_and_set_bit()
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 tools/arch/x86/include/asm/atomic.h | 7 +++++++
 1 file changed, 7 insertions(+)

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
-- 
2.37.1.455.g008518b4e5-goog

