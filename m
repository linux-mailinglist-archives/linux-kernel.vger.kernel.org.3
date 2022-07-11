Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06D570963
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGKRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGKRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE945F59
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso5634951pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sgv21IkQ0c7ss/RxtMygO/Q/cken8+hd9VuAl5/nl8=;
        b=P89IaPfDJiWRHSo6zBLmhQbd7XMH8r0EWsEPfpbVk058AetLSOhGT4lo6XqgrqrFWb
         sDdmQ8iv8OQJ+f+UPcasXaE3zwfls6tI8MEJZXBJMzhxKzjmMtl1QyzKQ+2YNdH/H9Op
         Wse9yuEdi5cG2/XkKhxCaE/RY5qhXxlas2fAx9nbgzmZgBYg15cmGDSGHUVRE4oIbSEn
         R8AAxy/VJUdjXFuG6uNGt8OrbPltXQ9eT0njiqwzZD6MrOk6JYuWtZHqG6+xhsr1+0XV
         0Yh43ZONbPS0WrHxLVMhlu0sEMrKhjQeTyv+mqW8+LgZEQEytI7LCs2Q6aB19a3QKmRt
         MoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sgv21IkQ0c7ss/RxtMygO/Q/cken8+hd9VuAl5/nl8=;
        b=fatoO+Q4q2bhtIfiBGazsVI8EYYuUtI8J6XY5wB/uJRyn8pFfiIk2VM3NXJN1UTqCu
         4eohD5DMaxUeA1WorTsXP2p7Ho2EQY0Xg4tAk/LKiHx5PJ+budVQ767xxcUCrTHJluiD
         LAukyyfbv1/ryfOhCHtXTMogtXkk4BSAKb7AcmR0JML20YMtVz9lPNJVq7Jmbl5TeFqB
         ACBMFzeP2tMdQcYlq7nGRWWj43owel4Y0eqEsQr16l80JVrscrmvfg7ijR9AnjeKh5gn
         uF/m5TtyB4UwvaS7FY1w+QRAvLRLoh04oQMMlrP20gBsiBoV2XcTK91yczcwcHrQZOWn
         PlQQ==
X-Gm-Message-State: AJIora8+5wF+HyGltjMAJ5wNYAITxDpQ5LQnB/v1LM02bCNyJ/RO3vmV
        oPMzG6BrhvtD9BtCrdsQGYZ2VyyG/UGiyw==
X-Google-Smtp-Source: AGRyM1uwy4SqoGXdZSGU9XupDTj6fIsTxcyHyFsJGzm31lf/2arfzc6EF4NjRqb/sNjEgUsL0zKFFg==
X-Received: by 2002:a17:902:ab96:b0:16a:6db6:2715 with SMTP id f22-20020a170902ab9600b0016a6db62715mr20279922plr.141.1657561603713;
        Mon, 11 Jul 2022 10:46:43 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:43 -0700 (PDT)
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
Subject: [v3  1/5] RISC-V: Fix counter restart during overflow for RV32
Date:   Mon, 11 Jul 2022 10:46:28 -0700
Message-Id: <20220711174632.4186047-2-atishp@rivosinc.com>
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

Pass the upper half of the initial value of the counter correctly
for RV32.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dca3537a8dcc..0cb694b794ae 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -525,8 +525,13 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
 			init_val = local64_read(&hwc->prev_count) & max_period;
+#if defined(CONFIG_32BIT)
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
+				  flag, init_val, init_val >> 32, 0);
+#else
 			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
 				  flag, init_val, 0, 0);
+#endif
 		}
 		ctr_ovf_mask = ctr_ovf_mask >> 1;
 		idx++;
-- 
2.25.1

