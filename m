Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B115B2432
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIHRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIHRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:05:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873A56BB0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:05:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-345188a7247so116360687b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Tb/TR0D6+TZRh/xClS3B2006d7nEi2kvzg0PMDr41zU=;
        b=l/IF7eiywF7DijJmWs32L+ESvrnZzL6ujSjiN4HQb8jq2jnV9CuVwrYRyvUmVouiKs
         dGSq7+5JV1/331c4SHuQ2axXuzASrDRiCykmau7/YAB/h6yuoUJiLQiruNz9QYPfH8s2
         apumrVo03AcQF5HCpuvcGKBX/1SNMHAlDD7IV3vX5W8EA7ON01T6LZh8nicXY/7IQoKM
         xuWfWbi13xBh4AXn6zSGIR0w7R6RuDoAjqYWFYkloXL6cUmtKc1e4RpCXKFg2bLwmaHz
         XIDDK3wKIdm72pwRN+zg7whNxAZ+Y5CxkEjF3byH2rZImMcabz/7ubpQxqPOiisegwgm
         Qlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Tb/TR0D6+TZRh/xClS3B2006d7nEi2kvzg0PMDr41zU=;
        b=cRkYnZaDFkNLbgwLsWNRX945imt3DNRrURFKwxYj8ckIp2dfkbYf7M0ik4HmBZN4gv
         wePrEOpXs1qv0POiyFTkogn+d8qxwzr586HYm+KUZb8vjkjmq98CN9sdERJY/JpqLHsA
         G9EItDW8D6BAHBrG9YWaYD+vTWnqY/4Aa1jLl48xQVAdiwcuytdxtLfyk6LUSSapP+ZO
         rA0yxmZnlfd4+PodFgMicf9cKWqN1URrbij/+j7JRoUraN+FsGG3QshRP4D6leQmaIyi
         PonmA+Zin1OGPV+PFRvzzLvYDfq+p8Cp90VW55aRZdC9DxvMkXbuOrIVop/6Bts0RphX
         HTyw==
X-Gm-Message-State: ACgBeo0cqcL474/hUfEdlcQ/f72lqTCof8KfoPaPlm775Rx+rW9Zopr/
        nZffwHaZ2pkj6Lra98ac0rBTeSk2VJq/sQ==
X-Google-Smtp-Source: AA6agR708d+P/Ik0lcxvg0vQvB6mz9WCwn4p5mhIR5Ov5qTjPmwpUuCMLzpOMl7grh7S3VO9/1R1FkTtJXMFWw==
X-Received: from acdunlap03.bve.corp.google.com ([2620:15c:29:203:b753:a87e:9aa4:f86e])
 (user=acdunlap job=sendgmr) by 2002:a05:6902:3c6:b0:694:1088:5448 with SMTP
 id g6-20020a05690203c600b0069410885448mr8476959ybs.410.1662656725853; Thu, 08
 Sep 2022 10:05:25 -0700 (PDT)
Date:   Thu,  8 Sep 2022 10:04:56 -0700
In-Reply-To: <20220812183501.3555820-1-acdunlap@google.com>
Mime-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220908170456.3177635-1-acdunlap@google.com>
Subject: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
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
        llvm@lists.linux.dev, Peter Gonda <pgonda@google.com>
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

