Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7C4BCC37
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiBTFKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBTFKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6B517FA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y5so5816100pfe.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=iUiAv4bXiYHpbD8Iy22OVVQzO/lShGPSsHELrw40Cev5/d0169c2Kzh9M/D3b1GmrY
         gU5sNkUYtlvk4sIXy5/vAzD/FPg2Fb7oong+2RNqn3QYqD+WcQ3KlpXAwYyvz6zbmqwa
         wHpem/shCx4LD0JpcduBvqgtlrZDbA5Jm2LhXzrUhksDyV2U6WGjXtzN0keSRiNZcy4P
         MPOlh++kLYkoyagnFbCZ2s750bSth4PB3yAwR38fYZ2ANKHIrmMLr+KpvbmqAz2hr5hE
         W8Z028CQ++CrFI8RtfWASxK+hgkm0XRWyI5RH82Shz6kDkp+OdIAKrVaoTtf+B/CEtJZ
         PGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=y2jxwgKvEiwydJ60tgZ2LJfEef+8K2+nBUG26f2O6QbU1thaluuukrYzZ47z1VwM1w
         HI9HQvYy4pUjlvhrNStWU1KeDfxmVayB0/s6D4sbbH9DqTEodjU2NBcFPTm3FVnsnADE
         MiMdwvCCf87rEnHFHtSNqocaKaXtSrXGcXMrVgs0Rtbp9db8PyD60KeLDbcNMMB5s189
         vD66rVkvYpq3n+V7GC7oXgPnySSzsvXlDnoJccjQZAuVc0yp4OEud1gdFIqDgXX90FOb
         Zx4JHol4js4RnVmvjmE+HwBgsLTOF/+AkO6ezlnwWHZ9WWHqLO4b5Eg6kHyi5TSKluZs
         EERg==
X-Gm-Message-State: AOAM5336W2WoqE4w5bUmRlpBf32URSlWx9uUBq/XednZZL+GE9GEC4L4
        GpqZInPrWg4sKsMU6+vdmUYjgg==
X-Google-Smtp-Source: ABdhPJwLfIY4gUQEEHqxuCTuVUUam/mxgVLs5JFIHSajj1op+Lwp6ydPyR3Zl76lIhTmnExi6v7CHQ==
X-Received: by 2002:a65:6794:0:b0:36c:460e:858d with SMTP id e20-20020a656794000000b0036c460e858dmr11800885pgr.418.1645333799658;
        Sat, 19 Feb 2022 21:09:59 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:09:59 -0800 (PST)
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
Subject: [PATCH v3 1/6] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sun, 20 Feb 2022 10:38:49 +0530
Message-Id: <20220220050854.743420-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220050854.743420-1-apatel@ventanamicro.com>
References: <20220220050854.743420-1-apatel@ventanamicro.com>
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
index f72527fcb347..9786fc641436 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -621,8 +621,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
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
index b5d30ea92292..6fd8b3cbec1b 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -89,8 +89,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.25.1

