Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51454534D04
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiEZKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbiEZKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:11:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB021145
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so1349695pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbBG7lEDJH2LFVXucK5oQ/R2hCfil/fSiH5Kza4Gi8k=;
        b=V5XR0cYmYpPHz45TXlrQdMJrLi9mC6lsy2W+x/KJ31gATxWb3Jcl0MrAB+D24bI7f3
         4cWVas5pCyylxxCZLBWe4mQfSoke/VDU2WYlrymgElTYZAOaG723fCyOoELiQShkPJOT
         1JZwGsy0Lp23kfxFyXK4dhbP3HKfGwYOKkJB0bxLkU+akzyGUbizbF/W22JUzStz/kvb
         /YZE17RoALpfuH1WSU7xai3fAWdlXw2P6hUoIe1PwT4W09BwfsX4JWi9svdHWlFZSnTi
         XZgvOErgNi8zbTcAf6Ej1LPhdSLC9CuCpS7dDMCmuN5koT27cwVrnYTiCV3TrhPaZwT8
         /aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbBG7lEDJH2LFVXucK5oQ/R2hCfil/fSiH5Kza4Gi8k=;
        b=4h0y+7hxUYLdtVZxu6Bt2p/UET5DKt+jYdvbxOEANlRKikn7SpBpCXfPzmljUa7w4i
         sKL7lWkxqnHER8qdTwOtWMu/eU+yrLIX6WboTrQiRhYbhd+x6HELFEZ+o9bcfWJQAwp/
         ++gze/tRnP8n/ASsEHWeNFM6Ym0siLuKfv8nxHmSkzegmvZMa6yd9OhefO/jOd2berfT
         ufEmsV88+D7IBGLMRl6tN5LiOCtfgXiSC/c0jf9jLzGaZsVVHbaN/a/5jr35f48/UfHq
         npcxL2NVv2ytsmdphN0KiEQ8GN2EuQiPkxQ1xkhK5rvSM0Y6MrJ5qeAEcshTnM4L6+Z6
         BH+A==
X-Gm-Message-State: AOAM533O0Q6iP4qtdxUKOm3xiybrCZN+a7oEkb8ssUG2MS+B6pn4zRbQ
        nFv64YT5u/DyCeiLlAgg86QsEQ==
X-Google-Smtp-Source: ABdhPJwr+qQVKMcopGMW+cRM74SlJB+kkVtaSsSNVzIL44tSlSNiDBT302sF2fUP6vTOWuit+8GjCQ==
X-Received: by 2002:a17:902:d50e:b0:163:80b4:30a3 with SMTP id b14-20020a170902d50e00b0016380b430a3mr937520plg.159.1653559907098;
        Thu, 26 May 2022 03:11:47 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:46 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>, stable@vger.kernel.org
Subject: [PATCH V2 2/5] riscv: spinwait: Fix hartid variable type
Date:   Thu, 26 May 2022 15:41:28 +0530
Message-Id: <20220526101131.2340729-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hartid variable is of type int but compared with
ULONG_MAX(INVALID_HARTID). This issue is fixed by changing
the hartid variable type to unsigned long.

Fixes: c78f94f35cf6 ("RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method")
Cc: stable@vger.kernel.org

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpu_ops_spinwait.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index 346847f6c41c..3ade9152a3c7 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -18,7 +18,7 @@ void *__cpu_spinwait_task_pointer[NR_CPUS] __section(".data");
 static void cpu_update_secondary_bootdata(unsigned int cpuid,
 				   struct task_struct *tidle)
 {
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 
 	/*
 	 * The hartid must be less than NR_CPUS to avoid out-of-bound access
@@ -27,7 +27,7 @@ static void cpu_update_secondary_bootdata(unsigned int cpuid,
 	 * spinwait booting is not the recommended approach for any platforms
 	 * booting Linux in S-mode and can be disabled in the future.
 	 */
-	if (hartid == INVALID_HARTID || hartid >= NR_CPUS)
+	if (hartid == INVALID_HARTID || hartid >= (unsigned long) NR_CPUS)
 		return;
 
 	/* Make sure tidle is updated */
-- 
2.25.1

