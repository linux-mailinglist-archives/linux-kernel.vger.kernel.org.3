Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55A4C65D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiB1Jn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiB1JnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:43:24 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D176370
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:44 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so18149781oot.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6aEUd2HwY01Z/Ayysg23IOPYksH4V6g17VAVrgQgx8=;
        b=QttJ8t7TITQ2h7Ebdmmos+aCJd8z+mdY+gYBE9OXcz3VtELeg8yeb2r9KlX97+UQZm
         FkD3pWYae7/w96EZSwtGEcBFxzIbXKFRN8ZqW6yrwVDCHZJmOoWAyiwauxOgNuv9KFdt
         fEHZw0Bzjcc8wiJD0EUsG/4QcKbv5no1c5Y5IBtU8mllCzL8CnrUcqS/1nDqI3sAspeR
         dHx95QAyhg1Zv/CNj4+gKrfD/Mv+nd+vOHbkcSGDdWooH3y+Lorm1kRQklALI2yCrjUt
         68f489zNBlCjFINmVQP2WdblHuwCgM7OooYO/LVtdZVP4jtNo2L8jK3AFDartb9tntE9
         1zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6aEUd2HwY01Z/Ayysg23IOPYksH4V6g17VAVrgQgx8=;
        b=P6wYaZGwDj8zHRLNUm1OKMfDv33/kxK2Wz2mJlKRoeIHoq+Kus3Mq09z5qlkSqjbIm
         7CMCay2rzmvOgLh+W8rI+c+Cgx41bpcnb4C7A+fBLB2iSjnyKnAZf3bh4hTofQ0+hkyU
         FEgVS8hZ5vt73GhFm08cTlONRBBsaYI0/v/invCMOItGJNq2nWJ7N2JOyneZe/a3VlXY
         Pyadpz0foDxkj+QsljtTytSIdS1bvZbNagWB4ZZdTJ+WnUn2JlmTq86L2mkjCNUvF69r
         59lTLWLzi66C9nhxN+MFefxB1sTN6kok33Z5ihccHuQIWSRGxalnBYvZAYtPM5GBP6kt
         sF7A==
X-Gm-Message-State: AOAM533Or1WerjAMsLgWow5lInw6UClqQbalyxGQHW1j6oFaErvyAuhs
        vOoJRYZCmniB92OG/ftyQukY+iZA5D1z/Q==
X-Google-Smtp-Source: ABdhPJws12zANoUoy54YotfRDiZF8JoPqN8gjYBlUZXs1PyXbDn6CYXx07jUGMqa4XLO8eSHxbA3xA==
X-Received: by 2002:a05:6870:1486:b0:d6:d70c:a4ff with SMTP id k6-20020a056870148600b000d6d70ca4ffmr7151638oab.185.1646041363830;
        Mon, 28 Feb 2022 01:42:43 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm5936852oib.19.2022.02.28.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:42:43 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 1/6] RISC-V: Add SSTC extension CSR details
Date:   Mon, 28 Feb 2022 01:42:28 -0800
Message-Id: <20220228094234.3773153-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228094234.3773153-1-atishp@rivosinc.com>
References: <20220228094234.3773153-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just introduces the required CSR fields related to the
SSTC extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index ae711692eec9..8f37c063a205 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -165,6 +165,9 @@
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
 
+#define CSR_STIMECMP		0x14D
+#define CSR_STIMECMPH		0x15D
+
 #define CSR_VSSTATUS		0x200
 #define CSR_VSIE		0x204
 #define CSR_VSTVEC		0x205
@@ -174,6 +177,8 @@
 #define CSR_VSTVAL		0x243
 #define CSR_VSIP		0x244
 #define CSR_VSATP		0x280
+#define CSR_VSTIMECMP		0x24D
+#define CSR_VSTIMECMPH		0x25D
 
 #define CSR_HSTATUS		0x600
 #define CSR_HEDELEG		0x602
@@ -189,6 +194,8 @@
 #define CSR_HTINST		0x64a
 #define CSR_HGATP		0x680
 #define CSR_HGEIP		0xe12
+#define CSR_HENVCFG		0x60A
+#define CSR_HENVCFGH		0x61A
 
 #define CSR_MSTATUS		0x300
 #define CSR_MISA		0x301
@@ -247,6 +254,10 @@
 #define IE_TIE		(_AC(0x1, UL) << RV_IRQ_TIMER)
 #define IE_EIE		(_AC(0x1, UL) << RV_IRQ_EXT)
 
+/* ENVCFG related bits */
+#define HENVCFG_STCE	63
+#define HENVCFGH_STCE	31
+
 #ifndef __ASSEMBLY__
 
 #define csr_swap(csr, val)					\
-- 
2.30.2

