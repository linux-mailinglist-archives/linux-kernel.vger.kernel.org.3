Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D352598B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbiEMBzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376420AbiEMBzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:55:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E932E28F1D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c9so6608170plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwpzunAvrzpyNJwdCWF/epnILRDBBON3y9jarpPPVEU=;
        b=jn21sS9XmXyewU4HqxnDpg8Clt6oVSJiJy9/dzvwizTppgxJ4ATD5W8DkzU4MK4uGG
         RXp7gz1Tfo+f+k9qSNtOp4+qIl3++tOFwLmhSiqOr5oBSZ5ivYPXQ8LFk7qXNjDS9vq6
         kzydwxWF4Ivso12ENq3uSgByo/9DaPpCDbfCcpgBkqYTU+Su5s4iJwaxddAr86ZK5Wi7
         381m+o3ZHxVm8iYaSh/NygFxI9wjCXeGHZ4nin5B6ZlpPelKDPC3jSuu1xBsM1R2mvMa
         dK3OVNw438WaKzrUjF6y3PK5L2RGN3JP95T8qtHYZ2PqY3CFRYO2CZpo6UXlzOm5O2jT
         PwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwpzunAvrzpyNJwdCWF/epnILRDBBON3y9jarpPPVEU=;
        b=YhYWmIwspsLjyMKJeTmqstJIXqLmFvq5wZ+D9YD6Ymb5erQkFxm1yTOB4tOLJ5ty3d
         IBiwAUWjolxxs1jEx6y8r55CkfQIjFpBj5ZZRPoi72v4USwSf3YTmYY1dvuEdbamU3VP
         qN4Iwl44Pvw7cL3RlPnfZgytugs6Q59VecUP6dt1cPElyYkmE/ZooAnDYZ0tLu7FFHMn
         sSoV+GwKnXZwwov1Fp71Z/Ycmh1k5OAjvOnJZ+vnc23mNWr8o6xM4dqW7vijLr7avmrP
         ejkNq3JZB/Sigba7FVRJ0idzx0/RveTSR7hDJyaH7tjF3vrUqfngtaOtarCD8nyue0GQ
         oKxw==
X-Gm-Message-State: AOAM531p6iktj/MEeD0aCiok02D3nRkCoBC5FS13itomyyvYcJ4pik3C
        NWmlv5tqZJ3w+SCtJhLm5TvPnNE8YcbKDw==
X-Google-Smtp-Source: ABdhPJw4gZ6OHEXgL59faCpkeiUSlt9ozUYGPPPvK4t1UxngjnGeG6isTHOmFxPQjvPQmoPyltbyag==
X-Received: by 2002:a17:902:d54f:b0:15f:22cd:c6d2 with SMTP id z15-20020a170902d54f00b0015f22cdc6d2mr2572023plf.170.1652406938015;
        Thu, 12 May 2022 18:55:38 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm365883pgv.87.2022.05.12.18.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:55:37 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2  2/3] RISC-V: Update user page mapping only once during start
Date:   Thu, 12 May 2022 18:55:21 -0700
Message-Id: <20220513015522.910856-3-atishp@rivosinc.com>
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
index 1e6c150c892a..7ad92039a718 100644
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

