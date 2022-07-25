Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F157FB80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiGYIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiGYIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:40:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A97814095
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ku18so9756942pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHG5WLJXoefEp1rBIYi3cGiQrYB7FX8IJTWGZ213f6w=;
        b=oKvYNiy1a+B/y9HqhMS1eeDAuKnP/B7jW4Edzu3YQyc2TAbENzdFRYsH/9lNY8kWnv
         mDlx1UTjYca33UMNa2+p/+myi0hxsLQCasyKkMq1x8zl+YEaPYMhwxaMj58FfiJQkuem
         oY7MdUKQxELSYp92yDUBkKgkRKS8izlCQYk+7v76P0U8k8YBea+7YQXsWcTyurNEw6+h
         g7Hjv+yxgV99jZT+HZxNmp1iEIFgYtKfT6SxHsrN3SkrcdYdnshla+dW249GJ/IUi3U+
         WuJc6bRxEjWXYuxp5MZLGXyU+w+1HAYCMZ0gYpDElGaSKspUa6sKF1m4l4DG677dRYU2
         G8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHG5WLJXoefEp1rBIYi3cGiQrYB7FX8IJTWGZ213f6w=;
        b=EJVV0UzpgyifHQuJ0X8NR0Sxq54jtjSE9GnMv9oQjNPFhhDwW+Lz5R80EmHDsRSGPK
         pG6eG8x6D6/1bnIU9Pvh5KOA1ncpiba6HK1W1fcOH2F3kVNEtr/nQF0/a9wTuceme3AJ
         WLychrYobB9Z12Z7/Jqw7airc4sN22UO9nG+BLCUZnT3hyE08ZxsSOFhADCGet4CDIKR
         OjeNv3+hvvEqIoN0AG9jGv/+qQI8yTPwRpo0yHHWU5pXWE0P02TmZVo8b9LXSOK0s58N
         wNsBGTLV1wKBRqrXCY1Gh9kD0o9pAnI2YWsfiCGYwdtRkfiwPSJ8yfQJ5T0oMGQR6X5q
         0Gjg==
X-Gm-Message-State: AJIora+NtOkE/uw2YqYEX2tGBGL4pctWiQlcSEJhd5jaeEgZBpSS7y5X
        3ge0Vt2Vc1B+AiD6GzDYVNVVWw==
X-Google-Smtp-Source: AGRyM1sbSkqOWAM8qvsfiZmn6OqYnP2aJAsp+Ac/PTrZCoO3LlsIuCdT88SmUqcbCQVOLPgNlQ5J8g==
X-Received: by 2002:a17:90a:c4f:b0:1df:a178:897f with SMTP id u15-20020a17090a0c4f00b001dfa178897fmr13156990pje.19.1658738403592;
        Mon, 25 Jul 2022 01:40:03 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.39.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:40:03 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
Date:   Mon, 25 Jul 2022 16:38:54 +0800
Message-Id: <20220725083904.56552-3-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

the verify_sha256_digest may cost 300+ ms in my test environment:
bzImage: 53M initramfs:28M

We can add a macro to control whether to enable this check. If we
can confirm that the data in this will not change, we can turn off
the check and get a faster startup.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/Kconfig               | 9 +++++++++
 arch/x86/purgatory/purgatory.c | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..adbd3a2bd60f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2052,6 +2052,15 @@ config KEXEC_BZIMAGE_VERIFY_SIG
 	help
 	  Enable bzImage signature verification support.
 
+config KEXEC_PURGATORY_SKIP_SIG
+	bool "skip kexec purgatory signature verification"
+	depends on ARCH_HAS_KEXEC_PURGATORY
+	help
+	  this options makes the kexec purgatory do  not signature verification
+	  which would get hundreds of milliseconds saved during kexec boot. If we can
+	  confirm that the data of each segment loaded by kexec will not change we may
+	  enable this option
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on X86_64 || (X86_32 && HIGHMEM)
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8..b3f15774d86d 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -20,6 +20,12 @@ u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(".kexec-purgatory");
 
 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section(".kexec-purgatory");
 
+#ifdef CONFIG_KEXEC_PURGATORY_SKIP_SIG
+static int verify_sha256_digest(void)
+{
+	return 0;
+}
+#else
 static int verify_sha256_digest(void)
 {
 	struct kexec_sha_region *ptr, *end;
@@ -39,6 +45,7 @@ static int verify_sha256_digest(void)
 
 	return 0;
 }
+#endif
 
 void purgatory(void)
 {
-- 
2.31.1

