Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7036570962
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiGKRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGKRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98C509FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso5622440pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDh5YVCvGcySEdAssqtNk1GISfqzMGhm55Nr/hwr5wA=;
        b=VKrPvmFHCte+ybcIGCeHbEr1nkOxUZuXHYKbPyClalUQRnUtRYiQPMbKs7VFU5pv3t
         6B9RbI7HZfr0cExKC2Rr5FauJpdROREDktC8bopXp7TPTlJEwMoeVAFKhN9eoVgdAMwt
         hd/JZRe72ROYBr30l9ePQ+Xfdv2KDIAgo2BnVnbKgqAHmROaj3UtEwLbM3p5BVq96iKh
         H3fhMZyE33b7pcdhLGxXWvb+RDAAlL1P+LqxNHgQaa0Fdi5snAYPZwfF2cTQlzAyAoav
         YhO2ubCffUa8wv6OxVo/TDJCtKxpdsiXTteySTCA2Vtb3tKcq4y8w5ZkeGIgcPiGtsXL
         nIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDh5YVCvGcySEdAssqtNk1GISfqzMGhm55Nr/hwr5wA=;
        b=jkxlB3qP88Uw1coO/sKJ+oAMN/0XAeDa73Yk6KUOrT5GmkhSa+VCW0HEG4Iy0b3u62
         6DU9U0JZ7uc34MBqsZqVMENRSNDsuaRS/9gRtnM2TfnQU+bvspTBeAEF69nEVDSHI0KA
         TlJjCwHYhj2K1W0X6sdoAJMmq+e31RlncZ7VNfvrOiAUDZxdwWLaZGC1DLxDroyG5/M5
         4eeNfUH+IK9iqp1L2n+vxoTCTuLtmv94cpEyO9rjNRHIg2AmiqbANRLNhTzVaykg7K7L
         n5yVIWd2f+vcDXgQ4KnW6ZLEOEM2zO9qMVpIaqTN3aNLCEcsCUEsQb5jO1Hoyag8uUkL
         gHsg==
X-Gm-Message-State: AJIora9M9khkaFzFX615BaNbZVQPfmX+kSaUNAsvt9czmBj3CwFoqd59
        +pwGgSOGlfhbGj1ym1o9MCpzI/c6L0/MUw==
X-Google-Smtp-Source: AGRyM1uUdg0luGzLmisAjzt01bCPhHy3/uI8TPvejk8VYxoPSmO1DV6ej9sDbjQtr8T/9tuzYcmaIQ==
X-Received: by 2002:a17:903:2683:b0:16b:f38b:16df with SMTP id jf3-20020a170903268300b0016bf38b16dfmr19945118plb.94.1657561604692;
        Mon, 11 Jul 2022 10:46:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:44 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [v3  2/5] RISC-V: Update user page mapping only once during start
Date:   Mon, 11 Jul 2022 10:46:29 -0700
Message-Id: <20220711174632.4186047-3-atishp@rivosinc.com>
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

Currently, riscv_pmu_event_set_period updates the userpage mapping.
However, the caller of riscv_pmu_event_set_period should update
the userpage mapping because the counter can not be updated/started
from set_period function in counter overflow path.

Invoke the perf_event_update_userpage at the caller so that it
doesn't get invoked twice during counter start path.

Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c     | 1 -
 drivers/perf/riscv_pmu_sbi.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index b2b8d2074ed0..130b9f1a40e0 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -170,7 +170,6 @@ int riscv_pmu_event_set_period(struct perf_event *event)
 		left = (max_period >> 1);
 
 	local64_set(&hwc->prev_count, (u64)-left);
-	perf_event_update_userpage(event);
 
 	return overflow;
 }
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 0cb694b794ae..3735337a4cfb 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -532,6 +532,7 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
 				  flag, init_val, 0, 0);
 #endif
+			perf_event_update_userpage(event);
 		}
 		ctr_ovf_mask = ctr_ovf_mask >> 1;
 		idx++;
-- 
2.25.1

