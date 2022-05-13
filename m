Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA04652598A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376426AbiEMBzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376412AbiEMBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:55:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B828F1EF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so9468081pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLnu5Z1M7spTOfkxmzGNMq9mvJnGiQu2ymVbvg/7Y4o=;
        b=Gw9bQQPrN9NnofVD2CZg8l8560k0Eu4jmDNZcgA5mtLk3BTLKuqBahKfJOhcT/w+HK
         OcHyg8B7V8t/tKMDwTCzbyIZqlz41e7HY0vrshiOofh2SCWGRGU6vp7WVjGtfXB902AH
         CvA/5xrCJeVoELhc/hwxxiuF91TqeRLlf9GEUXrd4NGWXyRx5ENi2UYWvI8LeCTlzGB1
         4SPJ3vbr5iDzq93NHAszxeIOOrsK8dPPL+s0r2HpwNazNR713H3ZnADeh33QR+NuNBpt
         QBO36hJEof9BEbvyFpe58WHDLZKbz1SmRN2r3IA6v8MjIRrqD1A2SHafZvpWEt36WyDL
         3BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLnu5Z1M7spTOfkxmzGNMq9mvJnGiQu2ymVbvg/7Y4o=;
        b=P7sXKxC0N0g/2siBqwbt2jctsLB2hnuBE7R3piLGh2lXJYNDbZl0FA8X4HqhyFmhJ6
         gF4ANolwyUbIRALleqommlSmVe99JLflXDY4soMwp6Ub6cRaEGjYY3e95C0AbxjJHp8P
         3aNjyRh4pRN7pEbrhNPSEDHeu8exiP/CTSke1k65kVrrbL5yTpOn0k6dET393Z9Y8xHT
         GGMogVoSugHuKjUUfBJTMzrPsslZZHnoM3X9GedNzd3xm6jMStIMCmMbgj3haErNmduz
         m7yozcdAalXx2h3EO2X6GaoOIYnnKeUOxi0/xjieVWQ2q7BvzKzgo5h0y7ThBq3LsgtP
         px9Q==
X-Gm-Message-State: AOAM5324I2C1lO27tzB3JudGv6qnJQnkbdS/V9Y8eWFYrqvXtqmMRaDS
        cSCeK0kxR81qQApZ2/q2vVjHX9YOE5A7og==
X-Google-Smtp-Source: ABdhPJzO+Hcgg8hisxLU7ADgG8gGPtljLastMpjQQFp1cgf81i34Pr2jRZcEr4RkNp+OCFqqJd9VjA==
X-Received: by 2002:a17:902:8504:b0:15d:2c7c:ceac with SMTP id bj4-20020a170902850400b0015d2c7cceacmr2623328plb.130.1652406936838;
        Thu, 12 May 2022 18:55:36 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm365883pgv.87.2022.05.12.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:55:36 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2  1/3] RISC-V: Fix counter restart during overflow for RV32
Date:   Thu, 12 May 2022 18:55:20 -0700
Message-Id: <20220513015522.910856-2-atishp@rivosinc.com>
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

Pass the upper half of the initial value of the counter correctly
for RV32.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a1317a483512..1e6c150c892a 100644
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

