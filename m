Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5D4C8246
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiCAE3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiCAE26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:28:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6744B1F7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d17so18433336wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=YbnXH3Ozn3b9HuBAgiYG8VYMa0eOjwf/1cC77kCVzifGNvBgFVcGkgDMYeYYXRH8KX
         es6Pci779Tb3Cls9xAqKDX7GugD/Dsd0qxsy1LhmQWF/bbrE8sLledQ46d/t+kJLM2h0
         2nmhVFLz2WzopUZldR98pJSf/E8XpEbqU48o35VqiBNyAyxKX2DN3GSu0MMBnvkRciC/
         O1IwurKtAWLHLohAVHuabupg3Ft23YKFTT8vUUIwDPmZTFyiRoY6XHjAEbOmT27Df7Bw
         gFWwGDuJ/qUEX+T6jMQDGDhAN8v10v8UUjwEqgGcdip8k1mxrmdUrLi+barpR2/V09sJ
         1Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=tvB/e2CSsbCB49v+6byxgkL6jAyV+d9HgMEjHIDnRNfvzR/m4Sk3CyVhT1+o8RRiVF
         50ivBXAVtryrTPg82RG9ZKyzVn3mYIjDqg2KXJz0gjgUSk7wdMwCSRnFJmuREDzqKzFj
         PfcB2JiMEnyp0buxHuZVq7438IogSsjxLx8tXPyB594/RNuQDLEsWAkF3pgJ2g9LXITa
         0QALt4nv84mjvK2R4T3U8w+640ib7oKT66kcMfBov5RSheDpCkyv4SkvgyA2vmqdssS+
         ySCXfRMD3HaWa+8YwkNzQQ3qnLVvx+FLmyrQddQ0HxQxehxLjHr2Ck7niMj6kjHRgg3E
         s2IQ==
X-Gm-Message-State: AOAM531zlZX3Ib1rQZoW7a3XcIIBGQVMYQS2cWNXVFAQz3z9vY/vWwvF
        gTakZHdmcF/4uzl/46++5BqaYQ==
X-Google-Smtp-Source: ABdhPJyDCf0PIM7Cz+LWsyEXEFiULxZskjWLp/zzvJEeRGlDKz00FVkpH24DcxMgGallV6oJWtBFeQ==
X-Received: by 2002:a05:6000:11c8:b0:1f0:d64:fb0c with SMTP id i8-20020a05600011c800b001f00d64fb0cmr908247wrx.279.1646108896435;
        Mon, 28 Feb 2022 20:28:16 -0800 (PST)
Received: from localhost.localdomain ([122.179.35.69])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm1209107wmz.43.2022.02.28.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:28:16 -0800 (PST)
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
Subject: [PATCH v4 1/6] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue,  1 Mar 2022 09:57:17 +0530
Message-Id: <20220301042722.401113-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301042722.401113-1-apatel@ventanamicro.com>
References: <20220301042722.401113-1-apatel@ventanamicro.com>
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

