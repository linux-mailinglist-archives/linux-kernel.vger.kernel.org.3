Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A84590627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiHKSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiHKSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:00:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6D85A8E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:00:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r13-20020aa7988d000000b0052ed235197bso7169218pfl.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=AHPdF2iNp843/qxwt9o0Z5Yx70qagBEm5XUA1AZJq3s=;
        b=hUouphILeY+7ZcreKxlU1ukdbwKI/z0PLnXdxgXRyGG+IFml1nB8pn1mmAe2cXc0XR
         FMB3hhPzAuGQtoJxfAw5hwOsTQmpXmtOFkydYbAXW7d6pcehx4QDo49aKDsCj5o8A324
         /VCxSnrbNVogJeIsO+bCb970/vWvnt5k/acHwbkLauSk5dpHDBgRKIdR2Bkj4PH/QF37
         ypfexny7+yt3N7PuLCfp3J9Tmb25wfvkeAm7zojmAueiEHE+y+xz1lf/57Ohd4orIeK5
         k+zd6pTc3V3h7Ji5hdleQh8BRWqLkmVw5x17GN10XTcnp6/GW/uMVMsVg/H2DMpjWpZY
         3ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=AHPdF2iNp843/qxwt9o0Z5Yx70qagBEm5XUA1AZJq3s=;
        b=wdLvZJKCI/L4Y3fFpTLEbHx0MT1egxzKDU3loZN8x194jLB2DFHSiLj469rz9vakC+
         d4ogpX+f4V810RmCkQt+k7i/4LxXTLnOOL3Xga5YbQXsFjlDNHBpTSOUn9peW6HfjgE3
         BM6ZMpuGBPLwQlsz3nDwTWuLMmKjqdY0btadqcbJ+RgdPlWCyCJqAhSXZcksHKGvC+Ow
         BZNHx3fpfwanAYnjEMb8DlB0DXEs/2B/sCyMf17IEx5XNel8X6NoR72IJRxmliuvMHua
         RGAQl9NNJChaxKjU7+QS33sX2NOuCCCaewU6yRsMUjzgdDnewEGZ2SjIL8GjOxQahSO7
         uPug==
X-Gm-Message-State: ACgBeo2c7HxdAeotyj69fvVlVOtSSj8upJiVo7qhkyU2Gf5zHL2nrQl4
        jjr3z4wvM0YiOItMYZJGmzD3pb6WXx1kvA==
X-Google-Smtp-Source: AA6agR6WWvqchDPxP5kAGNu/Ulq/79XUJejAqx8e373GcLQEy+qt6A+bV5PazXaTWuXtO6rWlR/bUqmxn0Ytqg==
X-Received: from acdunlap03.bve.corp.google.com ([2620:15c:29:203:7899:c3d8:a49a:7086])
 (user=acdunlap job=sendgmr) by 2002:a17:90b:20e:b0:1f5:26b0:f506 with SMTP id
 fy14-20020a17090b020e00b001f526b0f506mr187731pjb.65.1660240847029; Thu, 11
 Aug 2022 11:00:47 -0700 (PDT)
Date:   Thu, 11 Aug 2022 11:00:10 -0700
Message-Id: <20220811180010.3067457-1-acdunlap@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] x86/asm: Force native_apic_mem_read to use mov
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
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Jacob Xu <jacobhxu@google.com>
---
 arch/x86/include/asm/apic.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321c8240..281db79e76a9 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -109,7 +109,18 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
+	u32 out;
+
+	/*
+	 * Functionally, what we want to do is simply return *addr. However,
+	 * this accesses an MMIO which may need to be emulated in some cases.
+	 * The emulator doesn't necessarily support all instructions, so we
+	 * force the read from addr to use a mov instruction.
+	 */
+	asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
+
+	return out;
 }
 
 extern void native_apic_wait_icr_idle(void);
-- 
2.37.1.559.g78731f0fdb-goog

