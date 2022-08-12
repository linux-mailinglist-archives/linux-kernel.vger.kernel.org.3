Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77867591585
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiHLSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiHLSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:35:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276631345
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:35:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so1316456ybp.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Tb/TR0D6+TZRh/xClS3B2006d7nEi2kvzg0PMDr41zU=;
        b=KIghjEhyq/uIEoA7hzxjHhXLoqudiVh4T6m4iV1J2c3fc55bZphi7EKB/TpFkXOqXQ
         faOb1XHILmMqgqAmbtc8yyI/hQowyxK+dKydpikpEZycSxHUryf7rXRSujoIWYiQEZGU
         mjwcT3XbvILiUetjMLaSrR7jioVy+UEsVk3wtFtdEgyUo7gceVjULI0IkP5sSXvkzvsI
         ZSEXjbbFjpbWw5UyRn7RPqXWfq0V+FX1js0+oghrkMoyer5wm195HOxfdIW1poBoeiVg
         1qRxbN4wyrI3125UQZfUJD0aMsn7Z6Cn4SBGKpiKS5DEt3lQoTP+t06zvMX5F2octugZ
         +8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Tb/TR0D6+TZRh/xClS3B2006d7nEi2kvzg0PMDr41zU=;
        b=Jn8RsMVr+YHhE8FiFOHJf07VhbgHX1Pq861Yh2a1RMSAkGXQg72TEy/hCBCW6t0ZrU
         fRudzqXynVNSkdI9NfYLLNAXss2rOFxu3MlaYOgH1wSmTDJJFgVZflfoE9TaKtqEZqiu
         0mwoa43+BojeinsLGBNj1/9jBGHRQY4lScB81uHprxJc3HRCgQcdiXl7KfYJAX7VP6TC
         NQ5HLHGqvvP5wSw6gTqGcGd69DPwCN1tbHr1eQTvfahAo6gL+2HYi5j7aUYKHlDr54vF
         iZL0HzxgU51nTGAfVXp34pjC65LQMzKKYL4p8X7AOzgh9IDtCM/R+/zxP3gYQ32IQwKD
         HWhw==
X-Gm-Message-State: ACgBeo3+f83364qlNipg3FBXLeGR7SE42S5zVjeJIwC2DjKCKDeK/IR6
        k3qOhwFjoqpkZ5Epx8kUDEp92PoCOEuC6g==
X-Google-Smtp-Source: AA6agR7MVw6eGihEXYg3t88QaXWHs6AKeaTDDCWkXOHbSefgFAjKbrQSw+ldMMN4sYHzIbVkKO0X/Ph4mdFH7w==
X-Received: from acdunlap03.bve.corp.google.com ([2620:15c:29:203:1024:e472:db0f:a5f3])
 (user=acdunlap job=sendgmr) by 2002:a25:408a:0:b0:677:3543:ca4e with SMTP id
 n132-20020a25408a000000b006773543ca4emr4642131yba.164.1660329326241; Fri, 12
 Aug 2022 11:35:26 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:35:01 -0700
In-Reply-To: <CAMBK9=b1ALFYOB1iTUW7BHgq=sg=x9t8sTnC5YgQ5bePF+UvNg@mail.gmail.com>
Message-Id: <20220812183501.3555820-1-acdunlap@google.com>
Mime-Version: 1.0
References: <CAMBK9=b1ALFYOB1iTUW7BHgq=sg=x9t8sTnC5YgQ5bePF+UvNg@mail.gmail.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] x86/asm: Force native_apic_mem_read to use mov
From:   Adam Dunlap <acdunlap@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>,
        Marc Orr <marcorr@google.com>
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

Previously, when compiled with clang, native_apic_mem_read gets inlined
into __xapic_wait_icr_idle and optimized to a testl instruction. When
run in a VM with SEV-ES enabled, it attempts to emulate this
instruction, but the emulator does not support it. Instead, use inline
assembly to force native_apic_mem_read to use the mov instruction which
is supported by the emulator.

Signed-off-by: Adam Dunlap <acdunlap@google.com>
---
V1 -> V2: Replaced asm with readl function which does the same thing

 arch/x86/include/asm/apic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321c8240..b4c9034aa073 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -12,6 +12,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -109,7 +110,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 extern void native_apic_wait_icr_idle(void);
-- 
2.37.1.559.g78731f0fdb-goog

