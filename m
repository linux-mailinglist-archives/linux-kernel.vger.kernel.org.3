Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5675E4E65DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351236AbiCXPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351230AbiCXPPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:15:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393994E389
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so4977992pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=YH0pga0nH+hTQEyIpNZBYZatw8FxQm2nGkd2/zpBue/3WRbXwcKiiYjIG9ax+XvKIN
         MWjR7uEOiwOBkq7D3ClmPUehk7iAHqVpV4pR9IFRe6klZ7St78eBtj0DMEwUAXyVaKQD
         OUnac9ZmcBxSHPEPOX8RI7gCBOhjrc9dxXGIwhkNO4dIsWb4CG5WE+sCgkyliupA9nPi
         cUDzGaoBypyQjftTYm2rQy5AGqUFilAf6nyVXRkG+QHPmu/mNQh/Q3j5PqkqwnwTf7ah
         10tnnG49mAw1el9XrIW4aZXmsV3uNSCBVXdvIfHIsKSZpvRYCHgweGW5ePh9NzulDNt0
         fr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXY/vIDKe6DGMfSlwt+/9lV29k2hg5m2ZOntq1vLjB8=;
        b=1408qsAXco/jR1yWMRCeOYGAyAt0bjDgQabyvAO4ZVyB9KiDW6R/d/t44OOcc863Gu
         RRA+tPrbMAdoevVGm+R/sPjBRzv5qhtONSYzOJK/SUfFCTyC4QdM7ZuADdZbk6zf4JTA
         bhMjR75k6tbQDxhipbOIsR36ne7730jrSTcrLCaX2XuRX+LG/KY/7HUrTu5K1lBkaq69
         25WgmEevTlKF/Nit0C3jHsVyCqMcQ+EAVaDDhzzg4bBBweA+DFCdn6wGHXobKOFHOmpD
         4gS0LBaJdj4O1efvzFPtxauB24ZVUrd/+KXEVKypYJCUTaSRiDznV1QN6zfJsytCr4MC
         h1QA==
X-Gm-Message-State: AOAM531UMdXZjPLIxX+elZ7o3B1Fle4khZfrnF6wXwnE+MzQMrS9dwN8
        QfZZB28dtJS8l+R0m6pEfbSbgg==
X-Google-Smtp-Source: ABdhPJwHZOgsKhQJ7Ku0lsVbVm2H7/rpiV59GL6iAn9aKaGBEUj/tWKXjIuMiznBvk0IxlzTEVuL+g==
X-Received: by 2002:a17:902:b948:b0:153:9994:b587 with SMTP id h8-20020a170902b94800b001539994b587mr6392779pls.68.1648134847714;
        Thu, 24 Mar 2022 08:14:07 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4166065pfc.41.2022.03.24.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:14:07 -0700 (PDT)
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
Subject: [PATCH v5 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Thu, 24 Mar 2022 20:42:52 +0530
Message-Id: <20220324151258.943896-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324151258.943896-1-apatel@ventanamicro.com>
References: <20220324151258.943896-1-apatel@ventanamicro.com>
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

