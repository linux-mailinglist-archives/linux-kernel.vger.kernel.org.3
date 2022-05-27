Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE3535877
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiE0EaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiE0E34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:29:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD49EC335
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q4so3136728plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sz8Wl/RrPE6IxYREExHJEvcGrtIm/VscBM/l+yLFVg0=;
        b=O8Ot85XQfFBVKkDqvEOJGeHmdMBuVSr4MPIFzwpcNxuB68h0dXMLEofL+CLpF5g+Hv
         S3iwmZm+iyRtWBRkd0acwDIrdJJb8PLyilM2z4tRl98SGNb5s5KD0cV7quTasQP4Jz2Y
         j+PRYtjWKLAx9Sosd/LRZB7HjrFZkx7OptRBEXBhYtMSeV6y+XBa2+46XvPV6RanwGXF
         m79pH2FNC74yoHkOyBa/u5zoSaC7CPbjgvB8poKQOaM0P3WmoteW99ppT68oQRSlN7ap
         5G62RcS5oj9ml4GqKw7B5+j2pUH+oym+VgWFqv8dBtHXRMLXqs3kCvw9OV8tXWgBr4ia
         fMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sz8Wl/RrPE6IxYREExHJEvcGrtIm/VscBM/l+yLFVg0=;
        b=1f3PMrSmNYBBe3Pn4gP7g0om7PsAK411WsMyEpUjEjN5U2N3hmkEOj2Y8Qof0/gs4K
         cxEQMAeHSJ0i2DB+nLs4XE0kZlYrZnAXEmN17T8WzYFJJgJ4CO8+dHKgVjOQG1pktbo0
         4+hfJK5oTv1tu41Lo3Ej0XH6nyYqYp0BOFMl6P2MXiKCY0GkINlr4cs0z8qDrvxLYL8Y
         bkOI/iS8RBI90MVhiAf4zqW7DAvmusQ5hxnifOKuyuAJBlaph8eehH5kJ2Xp7IyjBN+S
         357pL2rmM8aoyBsUC2DVOsBEV0Dah62XXdylyTuOQi5x3Ze8Nvp1vBEAlmWd16SHT4RY
         3uUQ==
X-Gm-Message-State: AOAM531Ahs2vY5yJkEg2wq8DQFCWTD4F0SNjOz618o8w+Gv24+nqEl0I
        UlsMosKGaghQXgyvd5SUmunY4wuoIO0cRA==
X-Google-Smtp-Source: ABdhPJx6ek+jDxXvyWji9WIdx2QzKtt1rf6kKQxEPnGvkNB4j6S3Y5drdcqAN/BXPbdO5S4ajBGpFQ==
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:ece7 with SMTP id x10-20020a170902ec8a00b001617ca5ece7mr41422447plg.141.1653625794246;
        Thu, 26 May 2022 21:29:54 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b003fadfd7be5asm2352307pgd.18.2022.05.26.21.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 21:29:53 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 3/4] RISC-V: Prefer sstc extension if available
Date:   Thu, 26 May 2022 21:29:36 -0700
Message-Id: <20220527042937.1124009-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527042937.1124009-1-atishp@rivosinc.com>
References: <20220527042937.1124009-1-atishp@rivosinc.com>
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
 drivers/clocksource/timer-riscv.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..881d9335c92d 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -7,6 +7,9 @@
  * either be read from the "time" and "timeh" CSRs, and can use the SBI to
  * setup events, or directly accessed using MMIO registers.
  */
+
+#define pr_fmt(fmt) "timer: " fmt
+
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -23,11 +26,24 @@
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
 
@@ -165,6 +181,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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

