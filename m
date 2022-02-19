Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839204BC3B4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiBSArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:47:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbiBSArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:47:35 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82B27790E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:17 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so3100169otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7d4QHjy8919ZRO4h3tQp6Y7b0B32ou2+EpX+fwfcw0=;
        b=H5zVwRUMuUl8xTvBteU92vszT+9z+34Em7K2/0F2cVdhe0MoDgAQaqvP3mHRucqsWp
         rA2/izndo3IyBWZRwfiyt0nMsK9oCF3q/PDCTZ7m461ySLC+BRbsXVJ9vvSpevCmys17
         BzedNLS9HgvioOxo3gTMvDW2TcYNY36UzgBtLV3f/A4qqW9ootmfEk5ecFf2IikTXC25
         jTy96vlOIVJATC/ScT1HAhMvCVCEa3lw98zuuu13suvXTaUaL7XtLrr4VhmnDWGqvkr2
         v0UcTqFs/ZAKjUbYY8Zslth24mIZs8u+vkQdhNF5Ot51dvdpjOAwQpmfwo1WZX3o7XfK
         4YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7d4QHjy8919ZRO4h3tQp6Y7b0B32ou2+EpX+fwfcw0=;
        b=zvCJ8w1ZrPZJbIGsQadRFjzv819d4F1JClJ42f2kyby6E3XHuxNXX3nHL1Qhio6SDj
         lmDL95OdnV/PRx60WNVsCtJFNNoUbCMRuIaHWjoodETA4osiGP7CU14nq3L2NUbNVzBe
         jo/DJ/LaFGrQQVrOQYkEe0UqRVWurA1K5FzbZH9tNeT/QH5JFJDxZE1aBuggRZUjLbnU
         KdSfLmobw8kYtVZIbYnSwIhLqtMrlKcInkMtkitH2hBu+/eexmCcgpIKNQ1cm9G3VNGJ
         vtwprCz887xaXc0Y+sWqPDrvo5Cq3D4X67vb335oqCgZq0QeKb/uzZzPy7jWcP69r0vx
         A6iw==
X-Gm-Message-State: AOAM530rj0ZEDvvZV+KXqsnuBbwUA8CIGFJiZ1QhcKyS63cllev8Pv17
        nR9PCG4+d5aAwqkmf/uNziZ85xeB7iXfXrFq
X-Google-Smtp-Source: ABdhPJz6BmwRNZxitWawKhsyA+xW3K3g0bNI73vzKxIaOxa8TFDi5IWy52wKfsY2ar7Rhy8z+SQNqw==
X-Received: by 2002:a05:6830:43a9:b0:5a4:9dbb:645d with SMTP id s41-20020a05683043a900b005a49dbb645dmr3244988otv.138.1645231637078;
        Fri, 18 Feb 2022 16:47:17 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id n11sm11360794oal.1.2022.02.18.16.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:47:16 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v6 2/9] RISC-V: Add CSR encodings for all HPMCOUNTERS
Date:   Fri, 18 Feb 2022 16:46:53 -0800
Message-Id: <20220219004700.1973682-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
References: <20220219004700.1973682-1-atishp@rivosinc.com>
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

From: Atish Patra <atish.patra@wdc.com>

Linux kernel can directly read these counters as the HPMCOUNTERS CSRs are
accessible in S-mode.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index ae711692eec9..ce493df11177 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -150,9 +150,67 @@
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
 #define CSR_INSTRET		0xc02
+#define CSR_HPMCOUNTER3		0xc03
+#define CSR_HPMCOUNTER4		0xc04
+#define CSR_HPMCOUNTER5		0xc05
+#define CSR_HPMCOUNTER6		0xc06
+#define CSR_HPMCOUNTER7		0xc07
+#define CSR_HPMCOUNTER8		0xc08
+#define CSR_HPMCOUNTER9		0xc09
+#define CSR_HPMCOUNTER10	0xc0a
+#define CSR_HPMCOUNTER11	0xc0b
+#define CSR_HPMCOUNTER12	0xc0c
+#define CSR_HPMCOUNTER13	0xc0d
+#define CSR_HPMCOUNTER14	0xc0e
+#define CSR_HPMCOUNTER15	0xc0f
+#define CSR_HPMCOUNTER16	0xc10
+#define CSR_HPMCOUNTER17	0xc11
+#define CSR_HPMCOUNTER18	0xc12
+#define CSR_HPMCOUNTER19	0xc13
+#define CSR_HPMCOUNTER20	0xc14
+#define CSR_HPMCOUNTER21	0xc15
+#define CSR_HPMCOUNTER22	0xc16
+#define CSR_HPMCOUNTER23	0xc17
+#define CSR_HPMCOUNTER24	0xc18
+#define CSR_HPMCOUNTER25	0xc19
+#define CSR_HPMCOUNTER26	0xc1a
+#define CSR_HPMCOUNTER27	0xc1b
+#define CSR_HPMCOUNTER28	0xc1c
+#define CSR_HPMCOUNTER29	0xc1d
+#define CSR_HPMCOUNTER30	0xc1e
+#define CSR_HPMCOUNTER31	0xc1f
 #define CSR_CYCLEH		0xc80
 #define CSR_TIMEH		0xc81
 #define CSR_INSTRETH		0xc82
+#define CSR_HPMCOUNTER3H	0xc83
+#define CSR_HPMCOUNTER4H	0xc84
+#define CSR_HPMCOUNTER5H	0xc85
+#define CSR_HPMCOUNTER6H	0xc86
+#define CSR_HPMCOUNTER7H	0xc87
+#define CSR_HPMCOUNTER8H	0xc88
+#define CSR_HPMCOUNTER9H	0xc89
+#define CSR_HPMCOUNTER10H	0xc8a
+#define CSR_HPMCOUNTER11H	0xc8b
+#define CSR_HPMCOUNTER12H	0xc8c
+#define CSR_HPMCOUNTER13H	0xc8d
+#define CSR_HPMCOUNTER14H	0xc8e
+#define CSR_HPMCOUNTER15H	0xc8f
+#define CSR_HPMCOUNTER16H	0xc90
+#define CSR_HPMCOUNTER17H	0xc91
+#define CSR_HPMCOUNTER18H	0xc92
+#define CSR_HPMCOUNTER19H	0xc93
+#define CSR_HPMCOUNTER20H	0xc94
+#define CSR_HPMCOUNTER21H	0xc95
+#define CSR_HPMCOUNTER22H	0xc96
+#define CSR_HPMCOUNTER23H	0xc97
+#define CSR_HPMCOUNTER24H	0xc98
+#define CSR_HPMCOUNTER25H	0xc99
+#define CSR_HPMCOUNTER26H	0xc9a
+#define CSR_HPMCOUNTER27H	0xc9b
+#define CSR_HPMCOUNTER28H	0xc9c
+#define CSR_HPMCOUNTER29H	0xc9d
+#define CSR_HPMCOUNTER30H	0xc9e
+#define CSR_HPMCOUNTER31H	0xc9f
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
-- 
2.30.2

