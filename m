Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3749AD21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442460AbiAYHIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392027AbiAYHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE57C041893
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id p37so18475349pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=LO862MGLZ98yDMJuhIxpC+uCv5HOIsIT2XWQzc4wEOD+YhgYfLo3fi4T5OMdr3NyZ7
         A8O4BNSuvPu2biUcI3i/RduDrb4T2uoieId0tDlckIQLE7exdUA495AHhNsTdiLkj/ZA
         bPj5q1SQmtzslwSTrAV4I9sb/APKJ82aqoPaPoh1P2wQemDGCOWt4QkPVQ6YPLXG90si
         civyFeqF5H3+kSujPucwrJjcE7ob0yyNVvuTUZxZskPKqFlAn32Ox7BIHCXv4Fty7coZ
         G66E3Fkh4CHX6tgmcvl0Nai5KSgDK6QHja5vJ6dzqluNdDCvnltpiW7v4zsp2yc1iAIM
         p18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=Z5Nztcs05vP0Z57JA9KzokJPhwzK8n1SGJehXBUz6hyGHKHYpwZNYkpHF1U9q/cHWk
         8fCqmQ4wDhdwYORZhctCbd2BMG2qVNWiRCCUHG7Asx6z5ihMwZCIpbrpP+tZnlBmzyTZ
         ZkdyXPd3JHEPyHtTWtCkqN4UYw4CQWpxu8zR3wMtzOEAYoFoFoSfIPaXlqK56UYNORtL
         96E5l9tnp57hmzqrMw+NRbBlo/4vQlUD1TH8JM9umIVwD3yzh7p1As0BNFXLOdRsqf4+
         4QpYz2tMlBtkW0KiQia6bYmy+vrvv6F/c8Ckcen0ttfFrjNvvtaCXNkqgHsPTt1IF05k
         pStQ==
X-Gm-Message-State: AOAM530CTIpIRQ+xPu8wsA6DVxNwQsunIB/gl55uk0phbSUKdlvJy+pZ
        j5+tfoXPnSBCBtyh/kI5NSPjeQ==
X-Google-Smtp-Source: ABdhPJzphGPGqBO0jlMxyVd+9rd16Zr9VCh1WBhVt4TakprQyTunIWpOtLENkHSXyjkQ5cHwI/DeaQ==
X-Received: by 2002:a05:6a00:124b:b0:4c7:4d6d:7c88 with SMTP id u11-20020a056a00124b00b004c74d6d7c88mr15604002pfi.85.1643089460806;
        Mon, 24 Jan 2022 21:44:20 -0800 (PST)
Received: from localhost.localdomain ([122.179.14.218])
        by smtp.gmail.com with ESMTPSA id c6sm19524508pfl.200.2022.01.24.21.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 21:44:20 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 6/6] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue, 25 Jan 2022 11:12:17 +0530
Message-Id: <20220125054217.383482-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125054217.383482-1-apatel@ventanamicro.com>
References: <20220125054217.383482-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IPI calls are injected using SBI IPI calls then remote icache flush
using SBI RFENCE calls is much faster because using IPIs for remote
icache flush would still endup as SBI IPI calls with extra processing
on the kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA
and RISC-V ACLINT) which allows S-mode software to directly inject
IPIs without any assistance from M-mode runtime firmware.

This patch extends remote icache flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..7c7e44aaf791 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -18,7 +18,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -66,7 +66,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.25.1

