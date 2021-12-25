Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6A47F24B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 06:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhLYFri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 00:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 00:47:33 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD0C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:47:32 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v4so6463608qtk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYG08HWhp/w3HJAB/PpsmwbdfV4UxRTXBTvkLs9BXx8=;
        b=DAfVzeOH11h3mhrP0Y+HZbzxl/rfj9bypDv+mZsXsN7JUSOTs+ZOzDBAnwVu0Cy50y
         ZqT2MPJXdpl5rJgCYPWxlRlNYLedoBTLdBssuV+7601vhtoshAqvAuMfQpqCaerXsQkV
         lwjs91s8VH2dQWveiY77BWUrQ5/1CMFG6iah8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYG08HWhp/w3HJAB/PpsmwbdfV4UxRTXBTvkLs9BXx8=;
        b=S1MKq5HRDhzq5UnhoV5dpf5XMo+5/pHTskLm9vYePXB+8w+ccV/JHafSTi0z77ywiO
         70dLbkTjeF+9A+y5o+RJHJBpfvISKTve3IHdRP0ECTy+8b0xnPA7NIxAVrIRUjc4iWiA
         AflIEHfRw4BATn0EdVcud3iCXSU5kr1iJVlwuoz2RjlvJ+CxpX/pkFjiNRmDLLDK01pJ
         u86ffjP8yDjalcj3WRXAbzjuHzAqZY3WNPi+guOfCrO0eZbEiN5b6Ak/SaFjDOj9ggkX
         RAzEJ4BvJxV6MBrRJdARA+Zx7W+AK306q+TLyZEEpP8JpJlBvjyO9pnRYrwxYZzf8NPg
         KcTA==
X-Gm-Message-State: AOAM531h3CpPfyci4YBd3omjvJSd+6cSbf1XS+wCdYpqXTVYt0b5YVZa
        nu0FGGjuFlpP/VkIYz+ySUzX//95TQ0V
X-Google-Smtp-Source: ABdhPJzkZUUzVgbSWkYXrQFZQJ+D+n4Ff0PsJTxva9PevrVsU4qfevxCuNB71KsDyixPeCwMJaDfWg==
X-Received: by 2002:ac8:5803:: with SMTP id g3mr7732037qtg.317.1640411251970;
        Fri, 24 Dec 2021 21:47:31 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id c7sm8492780qtx.67.2021.12.24.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 21:47:31 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v5 2/9] RISC-V: Add CSR encodings for all HPMCOUNTERS
Date:   Fri, 24 Dec 2021 21:46:40 -0800
Message-Id: <20211225054647.1750577-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211225054647.1750577-1-atishp@rivosinc.com>
References: <20211225054647.1750577-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Linux kernel can directly read these counters as the HPMCOUNTERS CSRs are
accessible in S-mode.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 87ac65696871..e4d369830af4 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -89,9 +89,67 @@
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
2.33.1

