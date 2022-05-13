Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184D52598C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376420AbiEMBzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376421AbiEMBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:55:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DAFC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv2so6782755pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPoRCiwoBINJx2a5XFW6qeMxXLBrBULI+jQkr1qktFo=;
        b=yeI2vNN+2d/X/8BAKhk7NJTErNc0t3Ri4UeoW4oeDLfEfpOVAFzJbZEdJd4OL5zlBt
         16CUDGhYrbnSYKwz5l4yd+yJBt2LGu1GYKKuQlU0JXxCrFhc0y0nLHz5FdBG0Cs/EC9Q
         2PipFMEIgbgErRSSzo9pc90GpReM2RdMLVJ4wjj5s3T1kCqIHw4Gtn8LQHJ6hBclILTU
         eJ7PTZ7bi5WndFmDlxxf7NSTRrTcclZvJ/IHeF4p/XPtcyM4vfikQtmi6VqmJqgBGTXK
         Hr0r7MsGu0t773x6K2OfWDTIoChx6ZbNlZ+vb2Xj4VxnpND6eIUNLaTpZDztoDBFnqlZ
         MrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPoRCiwoBINJx2a5XFW6qeMxXLBrBULI+jQkr1qktFo=;
        b=JUmf6hkJt+/AQGjAGoQwoPGCyamOuYe1bQFC/9tmgAGiZmiPMeTO4Wp7Fmp/VXmnWl
         CTbZ5JXbaF7jBW7mWPDVS+dzvnHkKzuB5bmGRjomb9Z8e88doQkLn9pXtIt9eHM72/te
         qhkbp9Qa06zpKgJdKHKT/uWMOtsCsPqZcJFYkFy5rIyq28TmxWDYjdI2MpDLzAqzpuxs
         8FWegqe5Zs+O+cRqA5JwgCwMsMNusiIRz9E6MCDW5Y4ORntxT7BAtrQBC56vt/yBmXlo
         Al7sNeal8Y+zpkt9zj+UXxSsnWjkwYsWeedGTZJptfU7z6wTUYnR4JzsQacTe/jc2VOJ
         oghQ==
X-Gm-Message-State: AOAM530zr175REF31Clpbw4q9F77KAPLLakvrIo869nduIiwxL/fq5DU
        oLHpLg2RezTGxWpzZGZm0nFjJJqEKlZ+BA==
X-Google-Smtp-Source: ABdhPJwufGXGbLuIccz3+zyq2wHIQcgZXVxMmyj1l/g/wWcffrG37DEvEdIXB93ZMBkLn+2Hl79Afw==
X-Received: by 2002:a17:902:850b:b0:15f:2a59:1c02 with SMTP id bj11-20020a170902850b00b0015f2a591c02mr2595813plb.27.1652406939289;
        Thu, 12 May 2022 18:55:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm365883pgv.87.2022.05.12.18.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:55:38 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2  3/3] RISC-V: Fix SBI PMU calls for RV32
Date:   Thu, 12 May 2022 18:55:22 -0700
Message-Id: <20220513015522.910856-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513015522.910856-1-atishp@rivosinc.com>
References: <20220513015522.910856-1-atishp@rivosinc.com>
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

Some of the SBI PMU calls does not pass 64bit arguments
correctly and not under RV32 compile time flags. Currently,
this doesn't create any incorrect results as RV64 ignores
any value in the additional register and qemu doesn't support
raw events.

Fix those SBI calls in order to set correct values for RV32.

Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI PMU extension")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7ad92039a718..fab0dd497393 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -274,8 +274,13 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 		cflags |= SBI_PMU_CFG_FLAG_SET_UINH;
 
 	/* retrieve the available counter index */
+#if defined(CONFIG_32BIT)
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
+			cflags, hwc->event_base, hwc->config, hwc->config >> 32);
+#else
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
 			cflags, hwc->event_base, hwc->config, 0);
+#endif
 	if (ret.error) {
 		pr_debug("Not able to find a counter for event %lx config %llx\n",
 			hwc->event_base, hwc->config);
@@ -417,8 +422,13 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 
+#if defined(CONFIG_32BIT)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
 			1, flag, ival, ival >> 32, 0);
+#else
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
+			1, flag, ival, 0, 0);
+#endif
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
 		pr_err("Starting counter idx %d failed with error %d\n",
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
-- 
2.25.1

