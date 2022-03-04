Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BE4CDE40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiCDUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiCDUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:36 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FB31AF58
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id bt3so8414993qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=La2sWt3lJ51N8aiXaLxTZ81rzxffeRmbKmdg2xjj9EM=;
        b=llfQGxUrGrIoejHojVcb0Y3KUScFEeqhQN64bg0W4G16w2e2xy20xTh4VNEgip99So
         7EIAnl+l6HMTK+Y1H2tYXX0B0OANzxweW3TS6UmqFdhSes5f/e8/muPvXtpilTy1Rl/Q
         MCtur+l2VFqXJM3gqXE0SmrsJqMVydFtm0mH8+Fqn4YEFDSSuwa3n5LubdlQRqcop1X7
         tLDTiG7PokjlHkftXZrmY/k420PmVZKPhGp32eo3k4QrC/G3XmzH3l6HB2PMpG+2WFQL
         JZIwTm9my8jlHWQiiVx4InmFOJMfvlxtaRbhDWCMF7nO2chX8XlnOlmlEf5nQOaQXQfS
         7HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=La2sWt3lJ51N8aiXaLxTZ81rzxffeRmbKmdg2xjj9EM=;
        b=q7Q5NM7ld02sNwCn15P2J/GlkhTFb2CCDoZvlQMVfYFOw4gP6GcvauizkWQwkzNF+/
         WU3KsLFwcV/1n1Bd4SfHUuuW+gz0lnu8D3qaAAcjPaJN8wztnHJzg2WnyJq//JcZ70Mt
         lGW6KKi5tusyPPbzZ0ZQVwNeOyM+Nama4ci30dDx8XNefX0jl15VZHuydxurBaOruNtt
         FceoMufqpVchq1U01mrz5nnZXHDgwojV1GQcO2PEgaP01EPRYHMDZaS5iMoYG7P+2Z/L
         hck93LxG++Jij98OjnkLa3vmGHCBSyUh6xuTdV4+lqR0E03LUehK6KKXozVraBikSKjd
         rQlQ==
X-Gm-Message-State: AOAM532nInIWfkIWyooOhHrb2B/akB/9KDXUvdFRonT9X+p9KIYxCzZl
        NQgawSgdYYjm+ogKCB77uWekq/cdjXgxyg==
X-Google-Smtp-Source: ABdhPJySb8vTeaMNOaVqmNeyuKGat3EV0t1E2R+ui2Q6dQN1/Nz3MPMm95v3MmBjR1PmrcRFvR5rTA==
X-Received: by 2002:ac8:7ed2:0:b0:2de:6f9b:5c3a with SMTP id x18-20020ac87ed2000000b002de6f9b5c3amr388493qtj.203.1646424643609;
        Fri, 04 Mar 2022 12:10:43 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:43 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 3/7] RISC-V: Prefer sstc extension if available
Date:   Fri,  4 Mar 2022 12:10:16 -0800
Message-Id: <20220304201020.810380-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304201020.810380-1-atishp@rivosinc.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
2.30.2

