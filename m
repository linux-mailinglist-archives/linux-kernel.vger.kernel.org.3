Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31F146945E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbhLFK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:56:54 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45848
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhLFK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:56:53 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 439CC3F1F0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788004;
        bh=gG/WhBjtCMK9Juy/cpLoUS+Fz+e97sYPeCnLmIYCPu8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=asObokCf90fsDpuNacvxsmD3GYtI4o5fXM55ZEVyMDeuG/xOqyVthKEWW5zjckipm
         VYJDqA6wvXGUzJK+dGgGIbTOpaDdAvokMp/6BKUi/k9ZvIxgYVUoH4x+LdADG6RGRy
         H2+irsG6iFi/NBB6pEKrq7Yw3JO5GplVLMOL9Zs9z28LYSCyB9epzyYnfTQ07KFzWP
         KyIN6Av+rZJvXhSFao8PAKM3HLOz2mPGXvBjh+rMOzemWfrK91e71SKu7ZgpI/oHjB
         0OhFb2QvayQi8vbsGoUCh+7MTOW4et3CGzKEqmKWMpmZkoZpg91c2szktNZoDv87IY
         edHfF20/x6rKA==
Received: by mail-wr1-f72.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so1885386wro.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gG/WhBjtCMK9Juy/cpLoUS+Fz+e97sYPeCnLmIYCPu8=;
        b=zbd4GaBILcuoBj9LKL76iAMr55C7Omj4oz2t+AWe1Q2qM0MDZ8kNRZYkQrHc6gEd6k
         tCGS4s8eqxlWJjvAR4941gDEoGSIlwX2YNfGFwjlzK6hFtAIwpCh7+a4WHbEAtYSuHCh
         cKHF5/Q7yQaOyrNAVW35TgJTM5IMC96WCdce9CquZuDfDmHJY+hBa2tiygQ/XlG6hHyC
         5iJ7yng4iOLPg+ajP283ehpMwNO5AJ8HJ7JW3GPh/vxpIqOov0Hq4u+jw/9AN5UIc2md
         J+uMGASHHOapalsPUqtKYq9CW2ZxlFb90HyWyJ7NttJI5vE9arebEukSm8YrkkzKSOFm
         kWZg==
X-Gm-Message-State: AOAM533BW2VrU991dXdamuIHhV7dxhI7NEORnMONcDgf5jr3PmzY0sqy
        dhUwS8F+prpxO4RE+ncl+vzEbruxRHTIbkhxGyZh8+vV74K4mgUC6Ne9XXj6t5AtbU9Dx6F1LmG
        tpOZCXeEnm+4ST2xzd0VH7k4fsjMuA0LiVJ+bmqMWbQ==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr37750652wmi.151.1638788003992;
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxopdWj9u1iMI/f8aQI95EBYjbHFU9+o6qbVXkckCCLscAAHiW0VAZVryb3dDIQkey6IRVgJg==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr37750632wmi.151.1638788003798;
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id p5sm11021231wrd.13.2021.12.06.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 06/13] asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
Date:   Mon,  6 Dec 2021 11:46:50 +0100
Message-Id: <20211206104657.433304-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following commits, riscv will almost use the generic versions of
pud_alloc_one and pud_free but an additional check is required since those
functions are only relevant when using at least a 4-level page table, which
will be determined at runtime on riscv.

So move the content of those functions into other functions that riscv
can use without duplicating code.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 include/asm-generic/pgalloc.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 02932efad3ab..977bea16cf1b 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -147,6 +147,15 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
+static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (pud_t *)get_zeroed_page(gfp);
+}
+
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
 /**
  * pud_alloc_one - allocate a page for PUD-level page table
@@ -159,20 +168,23 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
  */
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_PGTABLE_USER;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	return __pud_alloc_one(mm, addr);
 }
 #endif
 
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
 	free_page((unsigned long)pud);
 }
 
+#ifndef __HAVE_ARCH_PUD_FREE
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	__pud_free(mm, pud);
+}
+#endif
+
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
 
 #ifndef __HAVE_ARCH_PGD_FREE
-- 
2.32.0

