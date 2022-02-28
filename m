Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635D4C65DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiB1Jnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiB1Jn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:43:28 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1764B844
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id z7so12651639oid.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZwHRuTuQHHbyYlmVo+wQ56EPoPlbAZZW/TgYQjt6EQ=;
        b=KxbNxI6daxarqDSPoYJrgu16gYJElhaFFKqjm0lQ+eTNJ5pyfjlXpLMB50fYeDtwww
         NstSnpNuRFCiV+ymuW5x73HIl3hpt1IZKmviLs7TOxSVAlw67xkFc7ZCNpAgxhL8OD+K
         qfWdvT8xdStfW/CIHFYW3d0hvFb8JwryRbocRJrzme+9qGlQhFslkXsfixPDdCy8Tk90
         UBpC1ypuc9dxsasUJ0PMVaFw26CcB/VvAmIUhQMs+mvWnCymmgozneCHLJ8+SkDIlxop
         EE/9sxjtQUbIk4pPv5DAipCk/vgo4T86nNGNrYjQnbcIA9qe0YodJk7C4++9wugV2Lvj
         SBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZwHRuTuQHHbyYlmVo+wQ56EPoPlbAZZW/TgYQjt6EQ=;
        b=mEYIO4yCBruQTpaKZawn8Oi30rrPkVd35NiWlyoW3XXbal2fUU63ehXUP5GV9Hu07K
         lsCIFnand36GIGXqBS9dNOXpBjtQzKuqvBUHQtuqf68Ym6hVkKuR7ZhI65bshuuSanHV
         laqW5RAoSngkxtcwCTSjkLcRRBs51MRQknHaqBTGfHWNv/m1Mznqo9kxZ8laPMkG66fZ
         XRwQ1h9cmIJlvQXIJLiuNsG/gWFEb/1xVGNg+XAhKryNpED50WdwMwxDdEZsEXP7ya/J
         Ybe1xstncKy6w6up+zvN+odWpi63wicQCMcx9Pj9wdgOgmF0g41pHmMbt4TZNoU7e+NU
         6Pig==
X-Gm-Message-State: AOAM531zaSNDcuebU2nbcwPYAp+G9y2IcuyZaaUJP24nVcZViPccJRkr
        SDg6Td33g6Id0D57Vdf96/WRCupz9VM+OQ==
X-Google-Smtp-Source: ABdhPJyLIFFgNymyuMZ2b8GlMCcdf2pTdM5RU1i0+xsx0tOzZUQL6nDHFWoz72TNTT3cndvEUXQqUg==
X-Received: by 2002:a05:6808:208b:b0:2d3:a5cc:540 with SMTP id s11-20020a056808208b00b002d3a5cc0540mr7723881oiw.41.1646041367488;
        Mon, 28 Feb 2022 01:42:47 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm5936852oib.19.2022.02.28.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:42:47 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 3/6] RISC-V: Prefer sstc extension if available
Date:   Mon, 28 Feb 2022 01:42:30 -0800
Message-Id: <20220228094234.3773153-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228094234.3773153-1-atishp@rivosinc.com>
References: <20220228094234.3773153-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V ISA has sstc extension which allows updating the next clock event
via a CSR (stimecmp) instead of an SBI call. This should happen dynamically
if sstc extension is available. Otherwise, it will fallback to SBI call
to maintain backward compatibility.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/timex.h    |  2 ++
 drivers/clocksource/timer-riscv.c | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 507cae273bc6..dc0ffed04ea1 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -48,6 +48,8 @@ static inline unsigned long random_get_entropy(void)
 
 #else /* CONFIG_RISCV_M_MODE */
 
+extern struct static_key_false cpu_sstc_available;
+#define cpu_sstc_ext_available static_branch_likely(&cpu_sstc_available)
 static inline cycles_t get_cycles(void)
 {
 	return csr_read(CSR_TIME);
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..f032da8a4272 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -23,11 +23,25 @@
 #include <asm/sbi.h>
 #include <asm/timex.h>
 
+DEFINE_STATIC_KEY_FALSE(cpu_sstc_available);
+EXPORT_SYMBOL(cpu_sstc_available);
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
+	uint64_t next_tval = get_cycles64() + delta;
+
 	csr_set(CSR_IE, IE_TIE);
-	sbi_set_timer(get_cycles64() + delta);
+	if (cpu_sstc_ext_available) {
+#if __riscv_xlen == 32
+		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
+		csr_write(CSR_STIMECMPH, next_tval >> 32);
+#else
+		csr_write(CSR_STIMECMP, get_cycles64() + delta);
+#endif
+	} else
+		sbi_set_timer(get_cycles64() + delta);
+
 	return 0;
 }
 
@@ -165,6 +179,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (error)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
+
+	if (riscv_isa_extension_available(NULL, SSTC)) {
+		pr_info("S-mode timer interrupt mode is available via sstc extension\n");
+		static_branch_enable(&cpu_sstc_available);
+	}
+
 	return error;
 }
 
-- 
2.30.2

