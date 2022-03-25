Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C54E7843
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiCYPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377713AbiCYPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6CB2464
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e189so8530980oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SO4NtNPVMmeqAxc0EqkfXLpRBgdCzQvRwVxIGc2RV5E=;
        b=EoFi5gb730L1oqiKmygyZpcnwFty6+8JsOJD1CGDO3QRwEzmwnyk3J0R0XP9iKo6fR
         ySM2m5AgSSfW7q2qCnu6ahptyUPyzGlUDWbKZ5REyhwaOt8TKgOum9pehoJqsa05yP7V
         QLV5QL5A7+lx6qb47YbQq7BrBTxNzlejR+8gjUPUeDU2PHSB+jlsOs7dLxrvithVkdCe
         Uh1zVoMcT5x67uAkzyI2sKQlVCFGO2Hm0sDo486YyNuhBjvJ7+gpR/XwHNnBzocmhTgZ
         fAtA6iN1fpcdioRUeYMiYwMbBVtk2U2tYGbSnEDUvf27B1IEPlRAKnr5ekklYlz9S6QG
         1HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SO4NtNPVMmeqAxc0EqkfXLpRBgdCzQvRwVxIGc2RV5E=;
        b=Qi4YjBDAtGJPtwUwIktL6ASmzFAP22GDBb/mPzvzOniAblPY2XoPBM4mP4JD6YUN0v
         STHskyxOxtdKdVjbZymlOk6sqSe1rFiybHc4UkdYAcYPkeP57o3Z9NJNlezfdHEUT+v4
         cLvnPPdWhuDH9LUI691YAv2pM/NFRISRtKoxpG5UegbgWvhhLmGux7/p45B2bsrHVfhC
         DBYIuZIJs+SRMFfYa7bBnSByqehSfmgpndy+kiqkw3JluDqqmcHtmtEIk13TnXU9Ur2v
         X8X9AYXE/6m/N9Nc+7FQyjn/vCymjY6HKNa+3kgfqIoFeGyTTdKkBVMAdDExYvSr1iaw
         PnlQ==
X-Gm-Message-State: AOAM533xN1nNOKvrN7OKnU5S+Mk9cOUDjMtR3P693+FdQMBqNtlapfRo
        H/C1kGWvmEFuXvlpkOctAUfugM9Gfw==
X-Google-Smtp-Source: ABdhPJxKA/ddrMiWPETjz2E219aSYqtfjumCW7tkD4WPImOKu1qVRgjdsahnSWdEgVWZ0aoi1qPuTQ==
X-Received: by 2002:a05:6808:1287:b0:2da:5cea:fb11 with SMTP id a7-20020a056808128700b002da5ceafb11mr5408521oiw.147.1648222808522;
        Fri, 25 Mar 2022 08:40:08 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm1709566oab.52.2022.03.25.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:40:08 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/4] x86: Merge load_gs_index()
Date:   Fri, 25 Mar 2022 11:39:53 -0400
Message-Id: <20220325153953.162643-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
References: <20220325153953.162643-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the 32- and 64-bit implementations of load_gs_index().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/segment.h       | 7 -------
 arch/x86/include/asm/special_insns.h | 7 ++++---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 617b3663e4dd..2e7890dd58a4 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -350,13 +350,6 @@ static inline void __loadsegment_fs(unsigned short value)
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
-/*
- * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
- */
-#ifdef CONFIG_X86_32
-# define load_gs_index(v)		loadsegment(gs, (v))
-#endif	/* X86_32 */
-
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..45b18eb94fa1 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -184,14 +184,15 @@ static inline void wbinvd(void)
 	native_wbinvd();
 }
 
-#ifdef CONFIG_X86_64
 
 static inline void load_gs_index(unsigned int selector)
 {
+#ifdef CONFIG_X86_64
 	native_load_gs_index(selector);
-}
-
+#else
+	loadsegment(gs, selector);
 #endif
+}
 
 #endif /* CONFIG_PARAVIRT_XXL */
 
-- 
2.35.1

