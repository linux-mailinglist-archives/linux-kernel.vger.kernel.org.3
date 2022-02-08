Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE734AD2A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiBHIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiBHIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:01:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53968C0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:01:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x65so3023964pfx.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qu7iA3Wa5YWg2W4QquHiK5jhMuH5wnm3DpGR8sEaMe0=;
        b=CoegZFJI8ydYMCiGdiv+EU1ZpSTw1Zb4QZdnnv3VNfUuMx3J4W8/6RMUib5yOPf/v/
         W8GKDlMAQuSkKt02hcf8gUdO9glQ40xfPgfI+WO9fs4XvgNavBFVVJl4b1rPla9lCPYK
         H5ZeUzTsH69q2VENFT9k/O7nruMroZZwdqttHS8an8ZVFbDnPm/aNQPJ4XIC/eVi34aL
         w4XuOZ22Ab8+RXbz8aw+nBS11VW8yIfkvrfK624ylpAdsIm/PAwQj+RMjGVQcTOiIydZ
         c+sfDTy9YcgiP0/KHX/Wa2UgS2RjPq6jMKlaQzpJ0XzoCrKmZqKC7RcOdeyR13ACp0XA
         KdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qu7iA3Wa5YWg2W4QquHiK5jhMuH5wnm3DpGR8sEaMe0=;
        b=Csm6YgYGKC8Jwt6qaqaNRVaggZJRKMDpCY9QbsbkRWnck4W4O0WVsQ2/6WP70Y6dov
         jKrGXptHj6SanZ4p7EED0C6vJhbQwy9Jf4V/QibZWLPkdHpYhTgE5x/SXy71hOM/DR3s
         RzLT434+N54ED3SjToV8VzVpLfC27czPLZTB2HMtJgTg63uE80zM0/vW7AohDKb66oh3
         enLsACkZ2+/ASilMfd4DUoexUARaoIWfmlrQWfMIc8VrjSSyDIcB7re2o69euIsZ6TzM
         geMTFXa9+6mSLry/xex5eKqL6iHxlWPL8OO6sP3vlh944ioSPyZFDRVB+ylYB5ACv3O2
         k7uw==
X-Gm-Message-State: AOAM533XtbHCrdKRox0Wc6Sc5zp0lkIhdRhSg3yGGpxY0HJ169OPINXj
        42XQm2S0fyzCroMY3Xzg2Rg=
X-Google-Smtp-Source: ABdhPJzm/t/kbc6wnnPHUekWRtMWwr3Hu3bt5YkTO2t0fCiMW/00B07MDLNr4pdA7j9cFJz3tiGl6A==
X-Received: by 2002:a05:6a00:1514:: with SMTP id q20mr3401181pfu.74.1644307272802;
        Tue, 08 Feb 2022 00:01:12 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id 14sm8280428pgk.85.2022.02.08.00.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:01:12 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jing Liu <jing2.liu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/cpufeatures: Move AMX CPU feature defines to correct word location
Date:   Tue,  8 Feb 2022 16:01:03 +0800
Message-Id: <20220208080103.8119-1-likexu@tencent.com>
X-Mailer: git-send-email 2.35.0
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

From: Like Xu <likexu@tencent.com>

The word 18 for Intel-defined CPU features from CPUID level 0x7:0 (EDX) has
been defined in the same file. Move the definitions of X86_FEATURE_AMX_* to
the right entry to prevent misinterpretation.

No functional change intended.

Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/cpufeatures.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..473905aadbe6 100644
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
+#define X86_FEATURE_AMX_BF16        (18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE        (18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8        (18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-- 
2.35.0

