Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF74A8CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353845AbiBCToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353828AbiBCToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:44:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD27C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:44:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f1-20020a170902ab8100b0014cb6c5b6a2so1755983plr.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=LyDIgi01ztBZeHVT+kJLlc/orBiiEVzwDL/6sC1TQxs=;
        b=MmyW1Jy2+00swY71fuBbBWYtQ36QkBate/qU1BG9S33IaXHWIHwfXQ9qeGrQVFpNdX
         uE16+pM98laPjTL/vSnvroYV5LM75/rAZOsg/m9VJDbqaKb6Kxw8bYE/tjnwgMGyItxY
         uI3ZeJiMASBVWqvMiSGaK/eKuUe1+m3obiGR1cpH7Lwop3/88ALXEM9o5dOXwfiuNA+F
         Vx5jL01bGrLtkOEhXSDybJR7yr15Yx2h6T5iLKU/mxZKF7YKGIAATDFxBMx72xzTncQc
         LIYYKA3in9xHCkTec3BS4X3vFkNQCOIOQDXdu5ZTsA4DY2KXYK0h4nq+bF4vqvO2cCRg
         htiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=LyDIgi01ztBZeHVT+kJLlc/orBiiEVzwDL/6sC1TQxs=;
        b=HX5t8bcG0+sdrd8UVee9OPijtu+P2Fxg9fUCjeHf2o2NxsmA1TP+wg58/qDtr96+na
         MvIDgt/jvX75U9a3F0tyA+YKJoZFfK2MD4SvjTZGORE0530rXF7QOfKAjMOGIf3kdmjv
         6aQJZdHdj8sy1XmvdpbdXHfeMuvPE9GhOUOew/pUMzjtqvWFlpnQuldDgYbn4z4YOvL0
         /5h8wccPQHolc/OYSiudB8aCLH0U+ma0ufQ1km6HpXo6Cdp6AcvVfR7H2P9DPX1B7hUq
         JDzN1IOFq+QJ0kovbB79Z3XApD4EMHe+jcVsq9v52wzoOyG2pOMj6mFlFV4QfWHTns5B
         rBRg==
X-Gm-Message-State: AOAM531y2zizBIfmxPqhKvJ4rfxFOR5B2ljgbMMp1b1wowjpn+swfdur
        E5ZciyUTb4epCc4D1JH0ngBGfO8RHoewNQ==
X-Google-Smtp-Source: ABdhPJy48beIej93m9oHIOWXK4L3a/d+/GG19hiatQ3TYGLHQdXde238qNuGdb71IYvPh9Hg0ijkTWLA3IN2rg==
X-Received: from tortoise.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1a0d])
 (user=jmattson job=sendgmr) by 2002:a17:902:ec86:: with SMTP id
 x6mr37592346plg.96.1643917453271; Thu, 03 Feb 2022 11:44:13 -0800 (PST)
Date:   Thu,  3 Feb 2022 11:43:08 -0800
In-Reply-To: <20220203194308.2469117-1-jmattson@google.com>
Message-Id: <20220203194308.2469117-2-jmattson@google.com>
Mime-Version: 1.0
References: <20220203194308.2469117-1-jmattson@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 2/2] x86/cpufeatures: Add macros for Intel's new fast rep
 string features
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Babu Moger <babu.moger@amd.com>,
        Jing Liu <jing2.liu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if no one else cares, these features should be exposed to kvm
guests, and the code for the KVM_GET_SUPPORTED_CPUID ioctl is more
readable if the bits have corresponding X86_FEATURE macros.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d7b51ddc8db3..138a50bc7bbd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,6 +299,9 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
+#define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
+#define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.35.0.263.gb82422642f-goog

