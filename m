Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC3504F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiDRK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiDRK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A96165AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:53:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5so12749696pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=QXXTOyqVuuKkoq8b1kO8880sqs4cB30u1SB+JN6mvVX9aOsBZVj0DMSBhaBOEPo50L
         k5kDTVeo3AQ7lB9xPQ+Jrj1eu0wk1MyHAqGHKndl168NltYb7EbkMcwM5ABxpeidGnmM
         oQttTT+Uqn5jSiTXPDmlDFaZzda/rrKLdVIQVO+QnSkg/t+sgiAJmqIUZkgkKaUZ/4ny
         I4UCGSd98jAjVdiXOEOHXlyzuN64aNnxDYdQ3u96e36NPN0r3UPHCc/kb4RQmB98lTiB
         ayJFyZ7AhCoqaGOOXlYULvOEn7eLChsDcOavWZEKFQFUv3/ACMd/A2Bv8/ztDxvvnKmZ
         /Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=k8lPmVPrn6p8bYQ7C10Ni/i/d8Ad/QFu7AxLwS4nyqEdhi0aBVt0yw8DUDktPvLWcb
         YFy8JfoJGOTMaMDcdJicJQrziUWwZhHUN9bu+I2kgSZJQu+AiKonY7Fdvvr18LNTFnVP
         NQt5uHneMDrc1nM4wRIN03IlgQ03RMAIIRR3fyZ0a1PFSSvELdgi/v+Finq5a1PqghAX
         7unDAZjQFDEE6q5PEIe/uqGXWnWlMURrCthqR1Wy22xmLnpavGBLCnjlF6ziQOLxFFW2
         Yk5DsNkSLqBaj3S58oQHlX8b8plgj3LQaLxUI+FWgf1bCb8KTC//FYFWW9zRPsR4Za6o
         e1uA==
X-Gm-Message-State: AOAM532pS3Mt/JSMiQUke086d78W8LY7s0hAjqIJPnc3RACv9rTYjDCi
        C7AH+4ILw2zVWFbZRYbEGhpW5Q==
X-Google-Smtp-Source: ABdhPJxHoV7pRbGuX0v6KWZJcBc+2b+ZE6cVGbSFaA0unByQ9Zz3d2AYJMzP97oILzqzuXejkluWVg==
X-Received: by 2002:a17:90b:1d8a:b0:1d2:7aae:33fc with SMTP id pf10-20020a17090b1d8a00b001d27aae33fcmr8359944pjb.242.1650279227826;
        Mon, 18 Apr 2022 03:53:47 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:53:47 -0700 (PDT)
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
Subject: [PATCH v6 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Mon, 18 Apr 2022 16:22:59 +0530
Message-Id: <20220418105305.1196665-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

