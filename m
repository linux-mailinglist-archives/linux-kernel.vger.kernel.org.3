Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE4463E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhK3S7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbhK3S7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:59:07 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:55:47 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d11so43034063ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwKc/hRfdcj3XDaEE7f0sihSmR08fCl/ZpK4J3rfU5k=;
        b=TnRt8OXpIPI/irqyhwl27gtLgUJopHrRv4C9fvpA7d7/5dz8LIoe5kqdOKG9Aer1f6
         KKuyRh3m1OU18q8vOP0jZnUS9ksoYctXHAQpj/qfP3l9m6UwOYEnDnB31VNyciE22IJj
         fu26WTwbFWwi1p8Wf1LpifI9cszdtw3BTTADFRZVL/OxMnVTAIV7i0u3GLHHGUVsqzFZ
         MfwXvHjA6WW/LG7UwmyILXingiTGxNw4XJ7IbO48babXghTi4L+L5DWdFibYTb+nuDwI
         BwX5yuSG/QhbFB43wg/NodHe5FpB9zJGLJD9ZCE4avVb+VRkY1jD1m+4JPQiQ44Xw8W4
         jrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwKc/hRfdcj3XDaEE7f0sihSmR08fCl/ZpK4J3rfU5k=;
        b=S666Xcl1ynnl60Fv5EOtejd7s9c3o5W4sCunNe2iE6BKlrtGP38ju+B6mZa0KrUSJB
         Iqo4VichbbYEMlGhSB0s1ts6pVU1z5lv6CvfGrA13ajFHJvk30Pjk0rVypkS0ohzs1Ih
         nVZy53VQiFeBDv3ddlP9z60Mf9Kisgfd9O36IBs2SI33iv4pXPTOyCG0iHSnF/cpHdYH
         X80byCzS6fqaS5y9mVqaTUij9cqBtjAvXREqOG77GztZSQgeZAg/8+Jrry9KRikJ6hcO
         Rb5y76GEsfVawb4CScnYSeKW/s4hLXnCRvr77QNJhVdaT+6OiaqJEyo6JwZ6W/Ntl/QK
         ZufA==
X-Gm-Message-State: AOAM531EZBW4F09IMqDDQDbTIC1tFdEybz2Mxt3E7LRqVvfW8WKV0Xkw
        NFVZCpqXZgOFkBcQyZ4DOWw7yw==
X-Google-Smtp-Source: ABdhPJzyIO+kTVCQXl5PXLpWVSaTESgQyBZP3HHu8I8G5KYzz2puEulqZJgzG6yXo45rIadlSrDzLg==
X-Received: by 2002:a2e:8502:: with SMTP id j2mr721584lji.191.1638298545668;
        Tue, 30 Nov 2021 10:55:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i16sm1801488lfv.244.2021.11.30.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:55:45 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 8D433103666; Tue, 30 Nov 2021 21:55:46 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCHv2] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Date:   Tue, 30 Nov 2021 21:55:32 +0300
Message-Id: <20211130185533.32658-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel fails to compile with PARAVIRT_XXL=y if XEN_PV is not enabled:

	ld.lld: error: undefined symbol: xen_iret

It happens because INTERRUPT_RETURN defined to use xen_iret if
CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.

The issue is not visible in the current kernel because CONFIG_XEN_PV is
the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
separately.

Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
CONFIG_PARAVIRT_XXL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Deep Shah <sdeep@vmware.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>
---
 v2:
  - Drop mention of TDX. TDX will not use PARAVIRT_XXL, but the patch is
    still valid.
  - Reviewed-by from Juergen;
---
 arch/x86/include/asm/irqflags.h | 7 +++++--
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5ce9845c999..87761396e8cc 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -114,8 +114,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define SAVE_FLAGS		pushfq; popq %rax
 #endif
 
-#define INTERRUPT_RETURN	jmp native_iret
-
 #endif
 
 #endif /* __ASSEMBLY__ */
@@ -143,8 +141,13 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
 #define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
+#define INTERRUPT_RETURN						\
+	ANNOTATE_RETPOLINE_SAFE;					\
+	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
+		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
 #define SWAPGS	swapgs
+#define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 21c4a694ca11..27d276232c80 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -752,11 +752,6 @@ extern void default_banner(void);
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
-#define INTERRUPT_RETURN						\
-	ANNOTATE_RETPOLINE_SAFE;					\
-	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
-		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
-
 #ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
-- 
2.32.0

