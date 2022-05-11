Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F8523FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbiEKWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348453AbiEKWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DA16D105
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 7so2908273pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYLWZ0AYEvI9FBKwXnehy1Q/hHHMEHlwZRLdtpEy/kg=;
        b=8XVsZqYqvgsyuCbAmC1P7WtONitrDbyuIo6rXd6Vjw7OBoyosds369O2yhggZJcP3C
         rc1nReAOZlfa822CuuzChjdpOcwLTz3xWhUrQAieqN5kFkys2vbbHGNu3S1IyG4GK8GQ
         iBNHlej70AmqdzwzfpLN1nPqEqs/Pz2SI4w+y+z25Aowk2fEILVFu6+w393JMzknZge1
         d/XKEZDs9XNSZNx6YBUM9ywMl/iMz60ptOQE3Wn/7aLoY9MobXYHIEilqCfWpG59hj2S
         B6nloDA2L48vKKqS9lU4yPGNiG3fKurPv8+7RHFqxjltRdxsTaZU+dXAggKMsvx97qFg
         MX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYLWZ0AYEvI9FBKwXnehy1Q/hHHMEHlwZRLdtpEy/kg=;
        b=3pkm0UBSwVpLXXBfMcZfvCGz5Ql+sq5uhl+BbI9TmfQZu01LrGofwP6qI8YSVArmqP
         YcJoGbZBW/Y3LeQ9AtAorb6QEFGX8q2ks5an3QoGAND4RFATzo+df1Fu/StD/x20B28l
         Hzre2gFWI42k6IQe06euQ8I0NFlBDsW9YLfx/oLOX50KAKDUfN0dSIiRurutHfUh096A
         NlMDKs/vYd8uvN0bixGgcsffhOWv14YoFqX4Lgre4Zx6l5e1Gp73uPz+No0/SrP92bTW
         QAoiL15rxzFPRBTCUrwICXbAW3cTuUCN85b4kOq3cF4/tFM0JxKjZIklmqUy6+YHwONa
         dLAg==
X-Gm-Message-State: AOAM531cte/AhdFHrncc94Dk2U0c0qdQ1qebdyjeAksqokp+FjNKAVU9
        pfhRw4csbk6ollgZOMlSORYDRd1Tw2l9og==
X-Google-Smtp-Source: ABdhPJzRXGY9IIhw1vr6kOjOGeJN1WZT7FkL5PWxwXudYM+a6J+4P/o7WA3ynuu5ZsYU6vd8WXjwcA==
X-Received: by 2002:a05:6a00:a1e:b0:50d:bb0c:2e27 with SMTP id p30-20020a056a000a1e00b0050dbb0c2e27mr27009583pfh.49.1652306413555;
        Wed, 11 May 2022 15:00:13 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:13 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 03/12] target/riscv: pmu: Rename the counters extension to pmu
Date:   Wed, 11 May 2022 14:59:47 -0700
Message-Id: <20220511215956.2351243-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511215956.2351243-1-atishp@rivosinc.com>
References: <20220511215956.2351243-1-atishp@rivosinc.com>
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

