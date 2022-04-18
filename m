Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978B504F18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiDRK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiDRK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2816519C2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k62so12158976pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=dfq5nxRHRr6Vx5qEgX57IF65zgE2vVmhCiwB5zffgAqsMWTu6wr1CGxCNlu8DTUa0t
         DTvlRdOymlFXFt06/SzX29Vm8lZvm8Pyu8QrvBgX56wA4ds/WDOAaihVGK5qGPG2dxvb
         nGv2r6YjuIsulVRF2Q6Og5Ftk5FeuGQOMDjWH08IexikHcBNlJ1gdPuUMuJnka7VRbek
         mmYv5dNZCLa0qClq4I3MTTY/MOP2gRYD6vVe7Or1sjkxeOGGw3bMtD1mH6Pj5F+EDtwG
         mVFSMv/wt7jILCuDfg/yqBLjcL8UTqcNejXS4SbEFzmMni5ubNGpfLvQVDXVxjNaq1AI
         QjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=cZBg/nlsNx4Y2lG2HL0NR7otaa/YPHUoMiBbCjrVTcKMLfanf3IMUrn807k6l4ycpM
         slD3JLksiCDLfa6iHqk1IHPzAqj+PmGi4lbUVFR8T89ylP3vDiv0w8pVKXGjx6E6YK3d
         56NGt8LhxxRCKGNRfIN5XQ0iliFENiESqa5LDT+L6lxiTX+gzM97lZBQdSfajmzHSbrU
         1AqppTtdndMcL+gdyLXW/vqEBNnN7LiuFwt11jffD/5EdhHNS5ugbaYHm6px/EsoM9pd
         OZf7CrcMfHTWoCcjXwtRpoFED3IFB7ePPpNiIKohYTSixmaVVABQrZ1KSCbbSqliy01w
         Y7IQ==
X-Gm-Message-State: AOAM530faDSZr79eTLvFb8R5BgCo91oRJvqewTrNpGY5fSvgkvJkyhbw
        b9hFry94QYeECkc5RS0Qa5hYwA==
X-Google-Smtp-Source: ABdhPJwLL+wp8GjQBIxTmwnulmQuTS6sDMH8dVFmsKsJdWwsnXB7OAisEOQpLEWJBpXDRZiR9Rbvgw==
X-Received: by 2002:a05:6a00:1ad2:b0:50a:8181:fed4 with SMTP id f18-20020a056a001ad200b0050a8181fed4mr1628046pfv.16.1650279255667;
        Mon, 18 Apr 2022 03:54:15 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:54:15 -0700 (PDT)
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
Subject: [PATCH v6 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Mon, 18 Apr 2022 16:23:05 +0530
Message-Id: <20220418105305.1196665-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
2.25.1

