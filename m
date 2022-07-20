Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64257B98B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiGTPYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiGTPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:24:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8C5C94E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn24so3705843pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHl3w50eHPbDg8ZW9/eV6YU7JVWrKk8VX9CvtFNZ+jA=;
        b=CRupW9tTNawaIQTrxX8Gz790wRJKCLMsKZHqI4BYN6FTc/X1mqQ53iS5jjJT545EKa
         knnqpNlH1IJn1r0oT/mGT7ID0LMZt/hPrOEDFWXGxLJcAgrA+GTjyOSFe5oEAA1zmxGq
         qiG0H+7DcalIICdNFdMBc5b/mgfhXD8ESWbLk1YSsEQ6PUcPoZ3/UpJd6wnsJfhiSLFU
         OTEZDuunttdQhu8chXvv5I46P6m4Cwa4cS38gBgbFijPruzGiq5yQPuc1AQOYDF70tyR
         0SCFQsO4M1P4iiMUEQxiQBKGw4lVPr0tAcS19wMRx6CqjEA44zD61MAi73klmTNSba5C
         N4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHl3w50eHPbDg8ZW9/eV6YU7JVWrKk8VX9CvtFNZ+jA=;
        b=GqrHcHEzZp5OWkVUF+JbivzwZPOa8VtE+dyIdNUvF8UxO/Vtyr6O/qSikNoxC72FVp
         3VpIn6uTIRpWEaffuQIe3ocwxZ+s/Mqqk2/q28353GPsoOAzy1hSfgvHlm2t0xZhKAE/
         kOivZ2XSaMW4dqoAxuawBwwbwFVbGfvXfofNopY0D/dkbYXXxlW5YC4ggg/I2U87b1Hq
         JsQj/7Rd424iaMubxcpoD+WGWc1oB2xrmp6aHmVBLjH2S3soMTu7eVWTt1TH0inhJoVL
         DiXKXNUo++Sb8hoKkr1ZZPEqLbVYti+VvAfgOIo0RTtdqjCG4y1+V/3SzWg6hocbxjf+
         O4kA==
X-Gm-Message-State: AJIora82UI4UP4E05CmHYyRv5wvPhihCH1SDGQAxh82wPQ+OD+YN/gGZ
        2Mh7B/ARVLx/ZXakT7kNrT6Ibw==
X-Google-Smtp-Source: AGRyM1vb6D/rdAEnHi7mvaOCx/awuQho72gqkUgQnU7xQI4Im1bHybG17U2f/wflrhirS5zSlkZMcA==
X-Received: by 2002:a17:90a:6404:b0:1f1:f935:7878 with SMTP id g4-20020a17090a640400b001f1f9357878mr5918503pjj.218.1658330666925;
        Wed, 20 Jul 2022 08:24:26 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.179.42.230])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0016cf8f0bdd5sm6013031plk.108.2022.07.20.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:24:26 -0700 (PDT)
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
Subject: [PATCH v7 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Wed, 20 Jul 2022 20:53:42 +0530
Message-Id: <20220720152348.2889109-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720152348.2889109-1-apatel@ventanamicro.com>
References: <20220720152348.2889109-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

