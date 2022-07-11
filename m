Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611EE570964
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiGKRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGKRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA642B637
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v21so2543531plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEKWlCC7AAQFkN2lQOBvhkrAmVJAiIHFQ4je7dwmiQk=;
        b=2A9Jrfj4QVotrraU60+KHLujeQqELkBCK2o0SIBWPzhzCkkHCw+z8s0bbAF0KbeYxc
         zbVZelo4wIQOgJAdaUr7IR7bsty4mvle+P+vWkHvPPztirQRuk+aX4pul4bXl4AjBdic
         imIEgWcf+p+9JjAsfKIerhclb/r9lB6t59zkrgNAswZSUXRyzf3CqJ1L/iRrmkpiI7NM
         3Zc8AIUmQjWzoyBrJi2LhUzBgWt3Fs/NwejCUXcnMSDSf5RqEm75DexU1hoeN3T4sUge
         7cHa2vTeM6N7sIxrWDQF/2YbULcMwE8DfBJi8CMeC6jtd1x6y0LIQCbfqKw77qdv+2ku
         V+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEKWlCC7AAQFkN2lQOBvhkrAmVJAiIHFQ4je7dwmiQk=;
        b=Q4YWjelzNPJtP8aA3JYF6RCtfkrth8IHm+LgvsHEVz6kyWbxsoKCw7WYK8yPwLvxSX
         wdQPqSIQeBtLIyggdEJpqeG8H73LQV5vwc28kYtQ+GRkS5bV/JpsCK7IY4yZVhfk1yZx
         fEpqJI1ohZoOxZ6tM3KtBHxfowFzRrJSu+t56fUC9Zol0HNDRf1yTQVxksERSPW02/yX
         CR43xN5t7sKl6ARwJmACjGn2mkWRzWO3kjfwYdNtyUBIAgClYf2Se2Rnc7v5Tc0YN5Uw
         y6lQv381nluEDi73Ab9Z6BbY5sqf/lqqXh4GQAfbdOrvWSTNCIdlOHA+0Qkc15PLBbQ8
         PcVg==
X-Gm-Message-State: AJIora+6ciD35MmTZN2gWBVoZia1n+d/wMCmZDOz5xGbJRVgy8ja76NT
        osOKUGiqvcFnXpVWsf+OTdLvxRdqWa+Dng==
X-Google-Smtp-Source: AGRyM1vDlkAyeYhMVtonPQR3SHvSE41Bb3Dw5m4IwtJFN0pmrxdwI062w3PGSAnkB/fmansJQkKpng==
X-Received: by 2002:a17:902:d651:b0:16b:f55e:c626 with SMTP id y17-20020a170902d65100b0016bf55ec626mr20295734plh.78.1657561607597;
        Mon, 11 Jul 2022 10:46:47 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:47 -0700 (PDT)
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
Subject: [v3  5/5] RISC-V: Improve SBI definitions
Date:   Mon, 11 Jul 2022 10:46:32 -0700
Message-Id: <20220711174632.4186047-6-atishp@rivosinc.com>
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

Fixed few typos and bit fields not aligned with the spec. Define other
related macros that will be useful in the future.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d633ac0f5a32..2a0ef738695e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -136,7 +136,7 @@ union sbi_pmu_ctr_info {
 	};
 };
 
-#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
 /** General pmu event codes specified in SBI PMU extension */
@@ -203,12 +203,26 @@ enum sbi_pmu_ctr_type {
 	SBI_PMU_CTR_TYPE_FW,
 };
 
+/* Helper macros to decode event idx */
+#define SBI_PMU_EVENT_IDX_OFFSET 20
+#define SBI_PMU_EVENT_IDX_MASK 0xFFFFF
+#define SBI_PMU_EVENT_IDX_CODE_MASK 0xFFFF
+#define SBI_PMU_EVENT_IDX_TYPE_MASK 0xF0000
+#define SBI_PMU_EVENT_RAW_IDX 0x20000
+#define SBI_PMU_FIXED_CTR_MASK 0x07
+
+#define SBI_PMU_EVENT_CACHE_ID_CODE_MASK 0xFFF8
+#define SBI_PMU_EVENT_CACHE_OP_ID_CODE_MASK 0x06
+#define SBI_PMU_EVENT_CACHE_RESULT_ID_CODE_MASK 0x01
+
+#define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
+
 /* Flags defined for config matching function */
 #define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
 #define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
 #define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
 #define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSNH	(1 << 4)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
 #define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
 #define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
 #define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
-- 
2.25.1

