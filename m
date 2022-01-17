Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D664901E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiAQGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiAQGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:23:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:23:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t18so20226012plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QqJjAI/kAmQwOZQvl4CrsRLn3ori+ZW6zwV6pUINpM=;
        b=gPUJKy/vq1ZEe3k6AZarFPLnM8k8q23ka4fKO5nk5UWIpfE+DmtCee1SXWwd4aQGiF
         mrTBBPe4f132fyUaLlB5JUqGjZSAulC0Aama8XpyPjRNqvDRf5th/gzC8gTDJTYu3Jir
         x9ZTz8iNp6jVP3OnhaS6/8cMCJq1Vo3VDgrG35yZ6FobTqEGeiX/Lv2LKuSV5IOAJT/j
         sHmk71x70xro+V7zDEnY1hnKRCmD4UHYZXC0UKZ7s241Vm47cgi4WcxRQ3y9cRmzYgCA
         xhqeueZLPfw9Hys4bJARzz1HQonyuLX23du0+h8bdYairEcXW6Uztr9r+fzI+jnkRf26
         z8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QqJjAI/kAmQwOZQvl4CrsRLn3ori+ZW6zwV6pUINpM=;
        b=WYndGmJ/PtT8I5UFemb6sjuDNStsrx2j7LWHAupjGljLS6kprkg0w9i/UnZRoT9EbC
         R/qs5uXYEoHvuq+GDMaulVYxa21Pbrnx6gSgaTevNhPmReOWCFW02SWo6aTu745IYlD0
         8F/OR+bbMwvlXTORsV17iAF5uKktnZYomcX+fKb2jzzY5nT2rWwusEy5xBWTSPetQ+nQ
         mR+IJq8D0hCb6dEOekSQslW3aREI9crioluDlsQaBH5Ln/XiRfXBNIaloNhinI3B4bvD
         /Gom4ncxirp+a4YN3DNvoi6BYYt94KgUGWV2joPjCHOg6nLyBLnGv5+ma3Fb1gKHTF6H
         3gSQ==
X-Gm-Message-State: AOAM5320qZLnAc5O0UVgawWScl1uL0o8mQXOGrNA37ronLkJPt2FQcyw
        sWJZbr2ilnE1cXEwzkYC7j0=
X-Google-Smtp-Source: ABdhPJw9n3gs4A8B25nVDndTlVccwalg6kT4AjcxdZD2JedL4Rkzrfb4lhtnZm7sjANxloheYY8KMA==
X-Received: by 2002:a17:90a:ab02:: with SMTP id m2mr20738683pjq.4.1642400636967;
        Sun, 16 Jan 2022 22:23:56 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id y124sm12005134pfg.127.2022.01.16.22.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:23:56 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_* to the word 18
Date:   Mon, 17 Jan 2022 14:23:44 +0800
Message-Id: <20220117062344.58862-1-likexu@tencent.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

We have defined the word 18 for Intel-defined CPU features from CPUID level
0x00000007:0 (EDX). Let's move the definitions of X86_FEATURE_AMX_* to the
right entry to prevent misinterpretation. No functional change intended.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/include/asm/cpufeatures.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..5cd22090e53d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,9 +299,6 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
-#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
-#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -390,7 +387,10 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-- 
2.33.1

