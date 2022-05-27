Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF6535875
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiE0E37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiE0E3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:29:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A591EC32D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x12so2967729pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nR9+lFDVWdG+A4IFcYjo6WmhDE582l71q5vLoqIpBj4=;
        b=62xDO5IB4clHRS64CC/NW1NkIku48BMqmgn/77ptmXH/0phmqWwYEjuqlSxKo4TopR
         UZpWEb9vx8561TtxrVLtvv3+53/e2ImY9Ep9j2At8bVUmgTHfjqbM7Hd61Wycp/ZDabl
         mBxR83pkyVSWffv5K90+ii/yyPQ0A3PuvLSGJu+q4qsfLgYq8ofHCdFGiNOT0q8L13YK
         qvQY75RW7DuVBnVKXHLrNZ2qPYOuDeSZVb43p+eu1mAICjo8TConZOVMcCuDhtV9Kud/
         FHmrEKJx4QYRAplRkkBy0oh+JZJxQwuPJIPK/1Ui8QqitmiaEiVvhzwG07qRTu8C6ciJ
         FmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nR9+lFDVWdG+A4IFcYjo6WmhDE582l71q5vLoqIpBj4=;
        b=ctsryL3Wi+VyW4gkl45Cgyu0UWup8bw9cRejtvJcJ6JTHLltgIb3ERCmk4ivJ+5vx+
         4v1Z0ADvekr1IRRa5lA6jEs7ZLqV1EhWPGNOQ684+ftZO8Nj+NsZ3B4yHvt6VgRz2c2d
         Nh2vWFv6bcg40H74WPomc42PM+RXLsQwR27tZBjPQGT6mFLU3NPAPTqcYtwxRNowl2xU
         gIrDnhBoEawUhnmLvkGF6c99hlHLEfHe1fi433szZDg92xNeyzF1CEOzY4dmG6dJCfQj
         Jb+lRMjtajvbcyzQhDMIlghmcMWRffV01gmshSZw2B+stpCRa6jxgMNGBRQjcJgUnrGH
         u3/w==
X-Gm-Message-State: AOAM532xLK0I/t26QBi/sf1O512yIfroC9UB+jcgnRRkKBdD1q5D/w18
        D7W2flMgDpkauJs0fkakt5G1l9i6Y4DY6Q==
X-Google-Smtp-Source: ABdhPJxsxHivtXd3dZpXsXY5uBossZvXRjKhw57nDDKiHoqjVeDwvonR4ougYayiJMDZJTdPbmx8Lw==
X-Received: by 2002:aa7:9047:0:b0:519:36a2:9f63 with SMTP id n7-20020aa79047000000b0051936a29f63mr1461473pfo.60.1653625791220;
        Thu, 26 May 2022 21:29:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b003fadfd7be5asm2352307pgd.18.2022.05.26.21.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 21:29:50 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/4] RISC-V: Add SSTC extension CSR details
Date:   Thu, 26 May 2022 21:29:34 -0700
Message-Id: <20220527042937.1124009-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527042937.1124009-1-atishp@rivosinc.com>
References: <20220527042937.1124009-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just introduces the required CSR fields related to the
SSTC extension.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index e935f27b10fd..10f4e1c36908 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -227,6 +227,9 @@
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
 
+#define CSR_STIMECMP		0x14D
+#define CSR_STIMECMPH		0x15D
+
 #define CSR_VSSTATUS		0x200
 #define CSR_VSIE		0x204
 #define CSR_VSTVEC		0x205
@@ -236,6 +239,8 @@
 #define CSR_VSTVAL		0x243
 #define CSR_VSIP		0x244
 #define CSR_VSATP		0x280
+#define CSR_VSTIMECMP		0x24D
+#define CSR_VSTIMECMPH		0x25D
 
 #define CSR_HSTATUS		0x600
 #define CSR_HEDELEG		0x602
@@ -251,6 +256,8 @@
 #define CSR_HTINST		0x64a
 #define CSR_HGATP		0x680
 #define CSR_HGEIP		0xe12
+#define CSR_HENVCFG		0x60A
+#define CSR_HENVCFGH		0x61A
 
 #define CSR_MSTATUS		0x300
 #define CSR_MISA		0x301
@@ -312,6 +319,10 @@
 #define IE_TIE		(_AC(0x1, UL) << RV_IRQ_TIMER)
 #define IE_EIE		(_AC(0x1, UL) << RV_IRQ_EXT)
 
+/* ENVCFG related bits */
+#define HENVCFG_STCE	63
+#define HENVCFGH_STCE	31
+
 #ifndef __ASSEMBLY__
 
 #define csr_swap(csr, val)					\
-- 
2.25.1

