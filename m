Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3A5ABFB8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiICQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiICQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:13:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB857E16
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:13:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so4809583pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c13eLILpK8GkWj7laTCqdhoKnHDkAb339eaJW9sNtYg=;
        b=F3pJLPmaaleiWpOrar+aNNoD6kReHeL2nIkQ1y3pClTWIK/ur7vNg1ZPMpAw5jBI8X
         zSkJ+onNFYa5GL26sFC+CF4JLGYVM/L+F5I172rOAiH9tjqPRDYanlM+84zKtG3dlXnB
         6uSBOxWzVSAgFRve7id+WFj8XZaFgWbBvflt0ppClxSMmbwX/24JpzpcRIPTFCVzMpeQ
         4JTvOBDVvKnxRjsS4HLwQvQ665q1P7pGxNtG4Tz1bijFxyvgsYnI0QG+8DlCOP8fXYJ2
         RwEyvaGPaLF7TKz69h2AaGTZVrXg9JmU1Rkd7Mm2Gtkdu1euF2dzv4t55J/DHYYLV1Qo
         mfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c13eLILpK8GkWj7laTCqdhoKnHDkAb339eaJW9sNtYg=;
        b=2q3P9bOZjfcNgQAtdHOg2wkFDeBX9ynHcB3tFmowJvOo6kD74Ao84bp1wqvQrKWx3Z
         oEpV3JG3Ef2PG/cP+DLt9qGwO7oIUS22k9+fZM+p9kH/HxdpKcjmSaEQ4z/gXmM4mZa3
         LWHh+knqktLMElPBzvqY8cEH4R5OL1/RHj6XpwLlF2oEPzlR9CLF8F/2Z0kLvNzRgbeN
         LcKR06ILgaHBm+P/D3Ihnz2/JkGVuBrhinN2siQKXcVCLAfD9MxizPCHChTTvLuXWmB6
         wc0fqgdfNu40DxsqVH3GguSmagBgGsbmqJCrQr0QWynE8Lf1ElgB5eI6BjPIXQdNtim3
         /NpA==
X-Gm-Message-State: ACgBeo0i8eTDJqLBhq9zHqn4q813jZqGoUzBqs6Iu6QpASLC9gMP9Ejk
        uY+kd3TsdLQlxD9A7Z1y473jltFm7sIA8Q==
X-Google-Smtp-Source: AA6agR6PtvLxGxJcxENhOmNOJYeB70nAWUBQoJLM8Ad8i0xbh9HyPThAT/ATycvrWLqkF2ekFSuJQg==
X-Received: by 2002:a17:902:a60c:b0:171:407d:16f8 with SMTP id u12-20020a170902a60c00b00171407d16f8mr40576670plq.58.1662221637625;
        Sat, 03 Sep 2022 09:13:57 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.86.115])
        by smtp.gmail.com with ESMTPSA id 4-20020a620504000000b00537b1aa9191sm4166738pff.178.2022.09.03.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 09:13:57 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Sat,  3 Sep 2022 21:43:09 +0530
Message-Id: <20220903161309.32848-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220903161309.32848-1-apatel@ventanamicro.com>
References: <20220903161309.32848-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 336c5deea870..45bcf1f635c5 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -20,7 +20,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -68,7 +68,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
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
2.34.1

