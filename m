Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8178570965
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiGKRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGKRqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536492B60B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e132so5336401pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDSNj3lh6sTDX65OlCD100Y9q85i9QCNDNF32ttMwM0=;
        b=u3VR8WAkynCBOJ8n0dSu67CSUM1scF+iq2HkJHHwWNCnCzIicRNMFcHK+9f0MZBUKQ
         2aXzF3fJ2mSF/+/pXnxqh2DTiPjFsIQHBlpw9mwaQZQwXWVMG1Tm8cmVlOY07txFp/dW
         ZD1VpBG/GdY26VU7j8RIWu88xaedmSxqrUubsg6pCNJxJUjE6UhSZsXkVVtzmdGuQ0e9
         zx/pZSfjxadzXscPBqTtjVyAGHeqKieBkSg3veGkPyQD6B3MwJJuS1NbTFiUg3ak5Jwd
         XKyyefVrH/G6lP4dpA8Y9wSPXHR3C5iUpIV+fwToNTXH+opA8A8zr5fKwNdlhvhludvn
         nHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDSNj3lh6sTDX65OlCD100Y9q85i9QCNDNF32ttMwM0=;
        b=H1q5UPWACNS5zBJsqN61gorwJcA8Z+JXLpoRur9Yie0lqz5khkhSDMbb9nQ+/q9orL
         WzMrSwy71cx4b0lXifKaAMDVY/cyM8VqhaL1SMOFtda0gxhwFxnNwaVllItpcN/U7sbg
         MPrIG6KH0HYVE+UDu5V+/L2LpRrpqiWGBc+9U8KZI0S8lChaDYQZKnfKidLFahTf3fB6
         4grcrby8Jeyqan2xhPO/IbqvBMK4c5F49pDjMrm5hj4SKNeLaqMnQPjEjDJChvvFt3o0
         6VYlutkPW6lZkn4dsFrIoZLSuxAvccPVZML015VjUNP4cmkUTXEmGIW2f1EeVZCOzcne
         Rm3w==
X-Gm-Message-State: AJIora9prtwgsWqcoCBvpeCFG57XLEprqYm830SzApDrBgTnIdhuiTVh
        qEBFZ8PjxwAcr+Fx668+ItYAavOyoyFLVg==
X-Google-Smtp-Source: AGRyM1sIjQ1yNU2YHO1M9vKkr0zih6h/RokRxyqSx3Rq6iQfnUyNXXET1eBJmKXi1sEon9yRbHennQ==
X-Received: by 2002:a05:6a00:1d18:b0:52a:c350:6538 with SMTP id a24-20020a056a001d1800b0052ac3506538mr10510717pfx.7.1657561606627;
        Mon, 11 Jul 2022 10:46:46 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:46 -0700 (PDT)
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
Subject: [v3  4/5] RISC-V: Move counter info definition to sbi header file
Date:   Mon, 11 Jul 2022 10:46:31 -0700
Message-Id: <20220711174632.4186047-5-atishp@rivosinc.com>
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

Counter info encoding format is defined by the SBI specificaiton.
KVM implementation of SBI PMU extension will also leverage this definition.
Move the definition to common sbi header file from the sbi pmu driver.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 14 ++++++++++++++
 drivers/perf/riscv_pmu_sbi.c | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9e3c2cf1edaf..d633ac0f5a32 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -122,6 +122,20 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_FW_READ,
 };
 
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index bae614c73b14..24124546844c 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -21,20 +21,6 @@
 #include <asm/sbi.h>
 #include <asm/hwcap.h>
 
-union sbi_pmu_ctr_info {
-	unsigned long value;
-	struct {
-		unsigned long csr:12;
-		unsigned long width:6;
-#if __riscv_xlen == 32
-		unsigned long reserved:13;
-#else
-		unsigned long reserved:45;
-#endif
-		unsigned long type:1;
-	};
-};
-
 /*
  * RISC-V doesn't have hetergenous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
-- 
2.25.1

