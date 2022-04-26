Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4345107AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353403AbiDZS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbiDZS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:56:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037F1569F9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:53:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso2961036pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+SXwT/SJ1BJbq87GGWyit7MKCT0yhEbjDVEHkS9JaY=;
        b=Z9GOxXKVlrR5xV0gHPbY+4kKmmF1WY+8H+M9B0psxISWmGz2FVgBqU9huy3KkQTC3V
         6bFgG7obRq96JTn8NkAYyml28WP2VHD9d/+A+rqpT96V3DLLPpHwRV7XeeOkj+s25kx6
         TJ4Holc+whFhjUX0Gsmza/Wzb7jz00dboknTTWY0oha7C2dcZuPhkqMuEnqlYWWH1lIX
         Juuy8ObgdDHPqRAFmGp5wCC1zlYuYDF+W2W+m+2TcowHRc+yRIheJtG0+PlOyAy8aJpY
         JXrUdgOc6WjB5VwDUBExmoEkoLEcmbh79m5h5PksiZ62NmruVMZRl2dokqfkj2USAktx
         mZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+SXwT/SJ1BJbq87GGWyit7MKCT0yhEbjDVEHkS9JaY=;
        b=mJ0SIChQer96GWjIXbI5WKuaM5Sd2mHs1GKj8j8ney1sDD5HuVJsxLX+zWf88xxTV/
         QSUeHIYLuF4Utyvcyz0FzpSOcdLC2EKEbjGPG4uWpwM5ODOpECdOS+zYzUPgtX7UhbLn
         Ars3Q1zC6U39UUTWRgj7cXnXYrk6oOBCNJEJPe5FO+eWVGM12FLk8HeEE+vWmINUkVcw
         C1tjkKXAGqhBSL/CKbq3UYP5DCSVmOv1IFHrns140Hhf1w4d+JGiGH50WWvGq/SFxdfh
         ArCCD7mFJkN6yJyMTJdBuCwtAdogqtZwQAYAyEhmEWoOW6Zovqt0/U2WPsphzh8WLcPf
         gTlw==
X-Gm-Message-State: AOAM530IWLmoF41rWgsN63JPzQZpLZksHNK9RQ9lUnP7p4LgDiDe04cP
        fZmXTZlpolaLtAJ4ipZAMO1J6Z5WgjZr4Q==
X-Google-Smtp-Source: ABdhPJzuRCCRkiCXmkQ4uct0ET1s6jpxuw4eppcALK9l9iv3G2BJT4A0mDWv47ZfhzCx8cMo3QuMAQ==
X-Received: by 2002:a17:90a:f3c7:b0:1d9:6832:7be0 with SMTP id ha7-20020a17090af3c700b001d968327be0mr14406860pjb.209.1650999192070;
        Tue, 26 Apr 2022 11:53:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id cl18-20020a17090af69200b001cd4989ff5asm3839664pjb.33.2022.04.26.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:53:11 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 3/4] RISC-V: Prefer sstc extension if available
Date:   Tue, 26 Apr 2022 11:52:44 -0700
Message-Id: <20220426185245.281182-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426185245.281182-1-atishp@rivosinc.com>
References: <20220426185245.281182-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/clocksource/timer-riscv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..d9398ae84a20 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -23,11 +23,24 @@
 #include <asm/sbi.h>
 #include <asm/timex.h>
 
+static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
+	uint64_t next_tval = get_cycles64() + delta;
+
 	csr_set(CSR_IE, IE_TIE);
-	sbi_set_timer(get_cycles64() + delta);
+	if (static_branch_likely(&riscv_sstc_available)) {
+#if __riscv_xlen == 32
+		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
+		csr_write(CSR_STIMECMPH, next_tval >> 32);
+#else
+		csr_write(CSR_STIMECMP, next_tval);
+#endif
+	} else
+		sbi_set_timer(next_tval);
+
 	return 0;
 }
 
@@ -165,6 +178,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (error)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
+
+	if (riscv_isa_extension_available(NULL, SSTC)) {
+		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
+		static_branch_enable(&riscv_sstc_available);
+	}
+
 	return error;
 }
 
-- 
2.25.1

