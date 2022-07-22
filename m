Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C857E4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiGVQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiGVQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:51:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4229812
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:50:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso4682251pjk.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhiEUpY832dBqpBZs6lVDJUJh/wPjhRPH5Wz0gZOdjs=;
        b=dlpFbmXItlUG9AvAKQ4H72BXu7Ec0gAYulbojqhVRlPlmOQtGwb0eiZ2TMO2TCDDrj
         DnL31uggr5tjrAfWw7V9MNiEU/aMiiaCv86V7QRe6dTtRLRyvr/Myez57yefVPu79b9a
         R3r744egp5g760mv20a1p2v3LqLYnEICd03OzMW1NmHz9mgyBnS6xXAycfkF/JmOa7V0
         pBu2teIE9lF7a0FyNp+c9fI/Em3+ZOb4oRMHK4OnKeF3P4aKM5aDtdfr56IcgqXK2kHP
         by52M9Tm29aOBwPMFiHW4YZ2DWiSLPoihmkCKzsL7cyyoHA4euIFOr/SEF/GcVFvmD2j
         O6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhiEUpY832dBqpBZs6lVDJUJh/wPjhRPH5Wz0gZOdjs=;
        b=bYsKWH4Ik2S07rUCi7HzOOepjXvqhYaIJh/1ZU3k5r5T0ugTETNpYPTNany8n1ouM6
         NPvbIUXf9ii7SaUqvKZnyewoT9b0kgHj/qD9Xz0FGkeMwdr0U7K+odhVMb7KEfvBquLt
         4jFEDSneXj4uEn4T3Y/KOCWye8QPOfbV16yJG7D0g4YmDcSQYxRGcnWEHRvNRNCJfQ7s
         9kKm1qb+RRU8TKmENDjtApjGIRQvOPS4TEaD1TMWkAhQ2fnRtPlqJ5diy+m7NJSICh/0
         qq9cEFKx6+LdnszgAYuedAhVmrs4QV0WJMoMFmgq5tgy6rLOr2D4XCY6nlNKkPbWoBp/
         y01A==
X-Gm-Message-State: AJIora9MlMEr0IvfkKc7E6iYFgK1xzEn9sBVGZUb9xemjz7Ie58ra9hp
        XNYMqaeW/bRkje4FFFCYZKQVPHjpJIV/dQ==
X-Google-Smtp-Source: AGRyM1vRTM3hIrzt2q2YQt5RlR51I0fFh7y/0/pkqJWtGugoh6yMC2nGJ0JNrvJjfz1pnKXpBNa4Nw==
X-Received: by 2002:a17:902:70cc:b0:16c:60e0:50fb with SMTP id l12-20020a17090270cc00b0016c60e050fbmr443033plt.156.1658508658489;
        Fri, 22 Jul 2022 09:50:58 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b0016a3f9e4865sm4028476plg.148.2022.07.22.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:50:58 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>
Subject: [PATCH v7 3/4] RISC-V: Prefer sstc extension if available
Date:   Fri, 22 Jul 2022 09:50:46 -0700
Message-Id: <20220722165047.519994-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722165047.519994-1-atishp@rivosinc.com>
References: <20220722165047.519994-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V ISA has sstc extension which allows updating the next clock event
via a CSR (stimecmp) instead of an SBI call. This should happen dynamically
if sstc extension is available. Otherwise, it will fallback to SBI call
to maintain backward compatibility.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/clocksource/timer-riscv.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 593d5a957b69..05f6cf067289 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -7,6 +7,9 @@
  * either be read from the "time" and "timeh" CSRs, and can use the SBI to
  * setup events, or directly accessed using MMIO registers.
  */
+
+#define pr_fmt(fmt) "riscv-timer: " fmt
+
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -20,14 +23,28 @@
 #include <linux/of_irq.h>
 #include <clocksource/timer-riscv.h>
 #include <asm/smp.h>
+#include <asm/hwcap.h>
 #include <asm/sbi.h>
 #include <asm/timex.h>
 
+static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
+	u64 next_tval = get_cycles64() + delta;
+
 	csr_set(CSR_IE, IE_TIE);
-	sbi_set_timer(get_cycles64() + delta);
+	if (static_branch_likely(&riscv_sstc_available)) {
+#if defined(CONFIG_32BIT)
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
 
@@ -165,6 +182,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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

