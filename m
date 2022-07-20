Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D758057B98F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiGTPZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiGTPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:24:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE5B61D4A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so2894288plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paOW2t9hSvLN0qsX4domrqdnSMll+/S/rhUQM1pkWRg=;
        b=J/uVoLcikLQJBT0xFlEg8ajNs9xL7ALWFsR00tgd24MEUI1aGZ3l6lzti4x33yK4+2
         iqS5uh9A+CkGE4S7Z/Bmp87ddJQl3GtMIEYQ8kR+M1PvKMRZFOeEzXYS85r2YNBgCMbs
         eAfFbeRsoH4G+AlVPZ4CkuCVXoDLhTYHyxrTWgZnXBFUgYby1SGBARog5+91t2PM7azE
         E5S96BykwsNAlUFT9ABNe0sKb2kGI9UugvUfNCgpBbB663pybDDw4SiMH7YYSp6pCtTm
         pJ161coo/nnBKqlzh/bFkbZAteaNHg+Fcl5pUMd5XiCL1ZS2RzjmvED8eOqSqmHku8d6
         yBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paOW2t9hSvLN0qsX4domrqdnSMll+/S/rhUQM1pkWRg=;
        b=U7QBHEC3b74Qi4UnG1PY247jj+oIFSUD5S6Z1pljZe4PRmxm0MxzsAL5m9pPvgKuGD
         5K+F0+9yKpTwPIYI5qT4UY3epr3hDhKvYvmcBixqIPApuBPkbjZFEBQ0e7zZhT9yCKau
         ahjF2rmgEQIInrQfSzxSh4YmARfBd3aGnBKmvTO7xo/uPOMsy6hnAi+gQvSO1ZAuWS5h
         dSc4nJEEAU/UIhrRd/FI1G8MQP+ZHTTDJXqO8AYiLsyW2viL13U2ShvO2JoCGcfpwBVb
         gWC1WRObztPY5j2wq9q6oJ1w7gQ731yhdNfmw0OlUUrOwjPBqNfzwAntaoxch08Z73OX
         Q7MQ==
X-Gm-Message-State: AJIora8wBNrP3sNfWbfBfa7lOpHEyjbRQE3BFNEC+C3Djxsyb/iOhTOG
        1kje4zq1F6KCiX4Ub4vRp9lbfw==
X-Google-Smtp-Source: AGRyM1u4d16rlHJpppdsGywOQ/RadLyXax3bndrtIMo0GKwoWAiSsXDREMxWjq/nSDRqbIuWX8wb7A==
X-Received: by 2002:a17:902:db11:b0:16c:3e90:12e5 with SMTP id m17-20020a170902db1100b0016c3e9012e5mr38763407plx.73.1658330690712;
        Wed, 20 Jul 2022 08:24:50 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.179.42.230])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0016cf8f0bdd5sm6013031plk.108.2022.07.20.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:24:50 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Wed, 20 Jul 2022 20:53:48 +0530
Message-Id: <20220720152348.2889109-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720152348.2889109-1-apatel@ventanamicro.com>
References: <20220720152348.2889109-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..7c7e44aaf791 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -18,7 +18,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -66,7 +66,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.34.1

