Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A15ABFB5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiICQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiICQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:13:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913157894
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:13:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q3so4654192pjg.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tQCr/IgKCdRHY8LSP1T2xhus9TIrH4sruSlDTlO3guE=;
        b=dp+XfjjPEpFz8l3g+2HRPu6/Oxxe7BWROkQFfLregsYeoPEgBgNA9LY5Wx17C2B7r/
         uVnHBAul6Kfkuuh/+ckgiUFUDg/eIIXDw9ShHVNqOTGgtMLjQ7S8xtSI19lYjbrAot4N
         9/ffzt+I37vNqdvdkeX6QLwCniN+Evxbt5C8aFv3BYfSXpcnyX/nMwgL/JIGwTEeTgIL
         49cUUOkn9dZbcWnm/wfJY/1MLpYY0BS8Jl6VVvVCw7N8uCwXm9/osbwHWr89vVpRAz51
         kUXbdtLbyAZwilcEPudiQfgAq+ZjYvtHbjVCs/aDRe3XIgdXZbKgPa2VXDN3qdFCgPFt
         W2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tQCr/IgKCdRHY8LSP1T2xhus9TIrH4sruSlDTlO3guE=;
        b=kwh6ldKbVl0sbRSLgfcPExmQ06cWI6KBQ1FdyVBhvyYtx6SxvhfuVftfKGynV471vp
         LlJKASPbKuO/eOYLj6Ibz+p/pQq0OIXhsI1xnzAsyMT3Cfd++oSPvIPNgrQ580Hr074S
         PdOGB1dXYc1mJVi4km4nNVruB9/gt378ZTbZj5JWZ0GhbAPN7V8Idb/kA9sEg2tLH6kk
         vr+dGa1XEaX0CEQRGeF1S/Ufzpaj/F9F6cdtRQYEQ312U8sYBfYeA9n2CQ/OeVTMf9CG
         BqLCQrz0elZMrGEY2lPoVZydaZytP8uSjVdBC15aNmLWvUqEeT2CI/L/h4zNx6kpFA64
         v78w==
X-Gm-Message-State: ACgBeo2zYedVXRePbznNWz4zlJzKvWGVM+aT7kkhT+miDatS00iW6MQI
        0cF7wsDsHbedeDvMm6mWGMTDGfWhZx7k6Q==
X-Google-Smtp-Source: AA6agR7gAEvd9lsPIHkr5H0TaXFmE4KOtqHNX4fnAfzULbOARkqHXBkFV681PeajUyNHenoxCI8JEQ==
X-Received: by 2002:a17:902:8347:b0:176:6597:85f0 with SMTP id z7-20020a170902834700b00176659785f0mr8999030pln.169.1662221609329;
        Sat, 03 Sep 2022 09:13:29 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.86.115])
        by smtp.gmail.com with ESMTPSA id 4-20020a620504000000b00537b1aa9191sm4166738pff.178.2022.09.03.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 09:13:28 -0700 (PDT)
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
Subject: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sat,  3 Sep 2022 21:43:03 +0530
Message-Id: <20220903161309.32848-2-apatel@ventanamicro.com>
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

