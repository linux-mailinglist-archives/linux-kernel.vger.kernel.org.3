Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C079949F2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbiA1FZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiA1FZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:25:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g20so4250872pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=hQLDE2JK5PLVwi5sPyGY3DuU3dDGa+74zauWKpxlzHdPT/TGezkvqGqSvfuD595csv
         kqNMjLttFs5lGF0n40ZTpPmdfB7fyDVhneRr8/zMOG20QU+ULpLB+yWRJ096c9si7nZ7
         J0Q6Vy+zuuguvNEh5x7jlj+AXFceYt6nu2rm5gfL81v0+yBVkBZXcuhyrY/k9HxAQoZq
         tDuE/GqS01lp1JlXU1HPzR7mDQn7AjdBc5sfNbqOQ2Rz2Em1n6COI/3OIjiD15nPcB4i
         L1OH95QNZKCBNHHgBStcVEgwoHHuU/Jnme5yW4Psn6X9Oma1m6LPdbOwvYDpMRkSNHnD
         Cf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=lCXp6k+FQh8qxAVGuwYjzPYY9L1OcdUxVAkOv++UTmq16yXVFKEtIwdB8Tzw3U0+jH
         ZsV46hSSwM1+cZ6Jnevbxhbc9RIaoDnL4rbOh2RCFXQrlSfdF0bRv4+Py9tcsUa/F2zq
         n5im7A+muCU6xdiSRg/pZq+gYydSgeNp95jIMb/zWq7iLjokFgN/Zj1tx40Y4jhC8eUJ
         6qze8PzszM+GtqiBTIPr98vd6PA4CwIxXdkVcHWcabxiAK7EKQmAGpm/seIBoYs007Rj
         W+s2lrAHzBAVWnvE66g1QRZ7xWQVxr5vr+Mcef5tOIRMzsEljfGUgvtl+C1IDY+vViL7
         hMqw==
X-Gm-Message-State: AOAM532mYcgGdbRhvvTyZTcy+IDta/qJ7MugMj4BewLKteJK+DASoJ9A
        DPjCW3Ij7Mg5TUs2QlvuLCvmhg==
X-Google-Smtp-Source: ABdhPJyDPeruoVE6AI2zH5VGYkjVLdK85RQIuEj5RjEPrwpWiMZ2TMq+S9dZ8srKOXbrkEivf38XXw==
X-Received: by 2002:a65:68c3:: with SMTP id k3mr5390261pgt.353.1643347550561;
        Thu, 27 Jan 2022 21:25:50 -0800 (PST)
Received: from localhost.localdomain ([122.171.184.231])
        by smtp.gmail.com with ESMTPSA id b20sm7731744pfv.134.2022.01.27.21.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:25:50 -0800 (PST)
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
Subject: [PATCH v2 1/6] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Fri, 28 Jan 2022 10:55:00 +0530
Message-Id: <20220128052505.859518-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128052505.859518-1-apatel@ventanamicro.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

