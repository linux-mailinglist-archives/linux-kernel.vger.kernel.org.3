Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D08531F62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiEWXvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiEWXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8901CDF35
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so615006pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYLWZ0AYEvI9FBKwXnehy1Q/hHHMEHlwZRLdtpEy/kg=;
        b=sItjCSHmuTcjv0HZtuTy4cynqcrDMdVZMPhGfhT7V7FPPBevqwLQ2cTIj17sNPKpWN
         wBGVKdYUr8OPJt5OFY0U6AXwHi8BwzLPwGoFCkC+BMTogcLnwZs3AgKFG6eSNfxegisY
         8Nx/rYnkzrpYb5R+paEIxsvVKynl36SIUlXWQLBZ4/Oa+usmvIv7O3+oopf7ufiJaMe6
         AHqtbLmbsdk9ZQclHM3fFZiWS16RpuNIsCDWljEx4BvtX3PASyI1jqjr2hHMXYVxV6aG
         ejygkovdgN2BHs1Put/5hWW+XtyCwtn1hJ5+eDtCT5x1HORXHDMSg5urkdydXYWIhhT4
         ybKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYLWZ0AYEvI9FBKwXnehy1Q/hHHMEHlwZRLdtpEy/kg=;
        b=XlPNPQC97O5pkaeY6ODZSVxqmk+XH60z73xdw+U1SXq1jNFSeOAImPUaO89s1+kOGW
         Pnw6Fzx7UXURllcUkcz8SP0gkbhy9844er6PX+CCvYyVcBBIqkxEAG6rTJUugpQp5Kr4
         5FwuNkk7gnE2EH158PIiXfi/QT9VGvEZkqgIZJ7zjzf0C9VG7hdsPaDJrNVq50OheCsH
         mqWIo67NZMRQ/p+Jm97JwJBm12vBiHQMUfywcmHZIBnczNHL2eLWPlBw+vPo4KVmWkWC
         X5nPucvjcA4Q26ufSFvlxzxE4paJcU6JfGH5idHzaDkaVOdzZVSxVpeNLKCL6daB71gV
         sLYw==
X-Gm-Message-State: AOAM532fS+uQv7hbh5ht1WCFTcTkw8uOHCQbVaI8YfIPFMyyxM3uXbGz
        Ry+UNmPDZxbc6eT6jfxnS0OV9Qi+CRP6DQ==
X-Google-Smtp-Source: ABdhPJxOUA7piwTA/VD+dvrXjbNR1vhFH7nkxpwh94PzJQps5o5qlaiiaN57gFkgcmoVENYQDGj57g==
X-Received: by 2002:a17:902:ccc5:b0:15e:f75e:6ce with SMTP id z5-20020a170902ccc500b0015ef75e06cemr24775678ple.104.1653349889755;
        Mon, 23 May 2022 16:51:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:29 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 03/12] target/riscv: pmu: Rename the counters extension to pmu
Date:   Mon, 23 May 2022 16:50:48 -0700
Message-Id: <20220523235057.123882-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
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

From: Atish Patra <atish.patra@wdc.com>

The PMU counters are supported via cpu config "Counters" which doesn't
indicate the correct purpose of those counters.

Rename the config property to pmu to indicate that these counters
are performance monitoring counters. This aligns with cpu options for
ARM architecture as well.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 +-
 target/riscv/csr.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ccacdee21575..5ad17b40189f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -822,7 +822,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),
     DEFINE_PROP_BOOL("h", RISCVCPU, cfg.ext_h, true),
-    DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
+    DEFINE_PROP_BOOL("pmu", RISCVCPU, cfg.ext_pmu, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_BOOL("Zfh", RISCVCPU, cfg.ext_zfh, false),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fe6c9a2c9238..09a0c71093c5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -391,7 +391,7 @@ struct RISCVCPUConfig {
     bool ext_zksed;
     bool ext_zksh;
     bool ext_zkt;
-    bool ext_counters;
+    bool ext_pmu;
     bool ext_ifencei;
     bool ext_icsr;
     bool ext_svinval;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d175fe3f1af3..c625b17dd58e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -74,8 +74,8 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
     RISCVCPU *cpu = RISCV_CPU(cs);
     int ctr_index;
 
-    if (!cpu->cfg.ext_counters) {
-        /* The Counters extensions is not enabled */
+    if (!cpu->cfg.ext_pmu) {
+        /* The PMU extension is not enabled */
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-- 
2.25.1

