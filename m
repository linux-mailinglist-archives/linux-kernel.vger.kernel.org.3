Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCEF570961
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGKRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiGKRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1272AC69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r6so2615522plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOTmDUkpz+mPbUuokk0QP2W08wgjCdIdsM+mPgDGou0=;
        b=V3fp0VSk9gvbvNZrW10f40Ews5n1xiSMtpJLcvEJcjL4jfDI8R2TfjOjLurvL4a4Kq
         asHseIaY3FLyAeWFMiKkq0kSBrv5HX+CVWLg2bcTMK6rqrTNY9ZaT/VnugE9FK6xBpZx
         gQcwByn7AW4Y130Y5S7itIxIX36fnfT0Oc4UMjhaMyVK0ugJ6+vJ2UipWRSj0sjWCUUm
         Z5HiKKnYAQDZ7BDFqjV9T5OOyPNvMNnMg/dA0L+ND0cf8DCb1TuPQgSofpxZG3h543tu
         4Ln4NjBamXgFyUsiOGtTQsVl8lFrvfSHHlVbqN6VXz2N2850DfkpvZqP/QihGroIj8lQ
         clmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOTmDUkpz+mPbUuokk0QP2W08wgjCdIdsM+mPgDGou0=;
        b=sskKLpwgiDI0jvbbDS1M6rFaJ0jOr+2DIT4wlA2/1+6xnyWGW0w2Af+W0zlIswk3ym
         0xQph2pr5LZzGk1XgMQmpTGA4VVVRA9w7RlMOru6hkmRW2PLOEr5zcYZ26TcdmWDVB8q
         UYMFsvIzsL0js/kK/tniFmIojcsCda4xZ/uZt2gvKLZRshKd17tJa/hbEatRNu98vTjo
         qKmBjILOE7j0p6ix5I9e3iSfMp2wGQ+3G0x0IQAy3rnStGvl3lpJGPRoRk4wKHSehOFw
         spsJxySQTJ1TdG6S86jPI5Qo9f3tMz238aUqo4PePhPWsbWAOUWsXWJ9YMPenZnFYa9l
         TfIw==
X-Gm-Message-State: AJIora8XqJKtfqp1AxhRi30rKkxPvb4uzWrv5+0XwAP4TgODoNAhy/sn
        ejrreH0n31So4Sovz7d6TPWi6n9SDNqsaA==
X-Google-Smtp-Source: AGRyM1sK7JtXLDkoMbF7C0EBnsfOqSTLfT/Hz3fUBzvyeiD8bJ+TTXzlwwJKP5VkY0rN4NQcrJVdZw==
X-Received: by 2002:a17:902:ef4f:b0:16b:8744:6c5f with SMTP id e15-20020a170902ef4f00b0016b87446c5fmr20376864plx.60.1657561605667;
        Mon, 11 Jul 2022 10:46:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:45 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [v3  3/5] RISC-V: Fix SBI PMU calls for RV32
Date:   Mon, 11 Jul 2022 10:46:30 -0700
Message-Id: <20220711174632.4186047-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711174632.4186047-1-atishp@rivosinc.com>
References: <20220711174632.4186047-1-atishp@rivosinc.com>
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
index 3735337a4cfb..bae614c73b14 100644
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

