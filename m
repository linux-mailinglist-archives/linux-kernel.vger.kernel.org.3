Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42059ABD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiHTGz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbiHTGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:55:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A99C04E7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:50 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p128so6969753oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tQCr/IgKCdRHY8LSP1T2xhus9TIrH4sruSlDTlO3guE=;
        b=ei8+a9amYDoCpz1QI5IeR7TYam6l5ohxbZI/T1kt/X1fsxq0YHMoqW0v47Oz3RAAAg
         xqTBjui/X0e6KsM/aQoYTgFSvGmF99FFNS9LZ9IUUFXqS+2SsqVFFtlcCCus00feE1zn
         177JILJY5e9+mryKtBTtj6NEu3ew9G6pHpLNrGFtD75A/u7hyrlSrR2XB5HFYvS0WYpY
         rBvo9BaAWW58MQee7u1gevoo7SGHaBNpW9Z9OEUMw7wNbhzZ6vNcgkxJLop7lKC9ir4j
         91RjGjhY5ljxNPiJmQ7gCbcwEM4b0f+BBaOto7yzD/0WEU/f23NVdizyHYhVKRoQONRo
         X0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tQCr/IgKCdRHY8LSP1T2xhus9TIrH4sruSlDTlO3guE=;
        b=57/iP6Q8FcEHMtgmNQt+ZzGvyrwbPpbQyWXgEPgFrEoCIt8uR7Xfdu8mTNrPZSIx0Z
         XLkXrzT1oH7fnQfuF+LndOTEw86lW0LIAH7vLmfej58v/fyOp5qtew+CmmHXdqJVlu08
         8rMiuws+MasMY91SrHSmTsECZnDSys6cHD2Hk3QC/KaN61dzSmBbHJkRKRQrIMhnGODM
         jc4AnfgtAQviesagp6HqYwS6sWDkAmYw/ci48Pwqx1xvYkg26hK63ompzOPIM/oN7zTQ
         un6mRmVqb6WOakYEFVZ3moLwWa4L5V/XJ3WzmBQhxz+oVeKDC9XWpMHWT68NGSnNAFDn
         jaDQ==
X-Gm-Message-State: ACgBeo0OOX+d8trbNoavJZ6auNxS5f5vOzxGqJaemtJNdtVDRNprMWjw
        3MrvotWQ3R1JBfkkdpYcwnymKg==
X-Google-Smtp-Source: AA6agR5Oo0DXXb5svYgvBBGq7lg7ZNVbU0D0Ks8xh5M92bnwe0csVlpM4h+ggVcAl9pbcv+gygl2kA==
X-Received: by 2002:a05:6808:19a4:b0:343:300c:a1b2 with SMTP id bj36-20020a05680819a400b00343300ca1b2mr5420429oib.253.1660978549973;
        Fri, 19 Aug 2022 23:55:49 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.68])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b00636faf5e2d9sm1661098otl.39.2022.08.19.23.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:55:49 -0700 (PDT)
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
        Anup Patel <apatel@ventanamicro.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v8 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sat, 20 Aug 2022 12:24:40 +0530
Message-Id: <20220820065446.389788-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820065446.389788-1-apatel@ventanamicro.com>
References: <20220820065446.389788-1-apatel@ventanamicro.com>
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

The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
S-mode but read-only for M-mode so we clear this bit only when using
SBI IPI operations.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 arch/riscv/kernel/sbi.c | 8 +++++++-
 arch/riscv/kernel/smp.c | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 775d3322b422..fc614650a2e3 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
 	sbi_send_ipi(target);
 }
 
+static void sbi_ipi_clear(void)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
 static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi
+	.ipi_inject = sbi_send_cpumask_ipi,
+	.ipi_clear = sbi_ipi_clear
 };
 
 void __init sbi_init(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 760a64518c58..c56d67f53ea9 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.34.1

