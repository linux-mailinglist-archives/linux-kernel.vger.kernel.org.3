Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9457649F302
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiA1F0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbiA1F0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:26:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E02C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:26:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i17so5107757pfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=nPYUl33j0ee7Kq5gbqwe83BWemErmLc/3Kq+aDr+MRD5LbbPVMAzBY/NHW5wRgjVJI
         WulApXD8BzDsYVrTw+k5T96ICTVuoQnan3bNtcvoI6BB3WQaHwvWXXZ0Q6ZOX+/gkuiy
         Hg/qgQ2ehjY8Tukmd6Mh8kIQJpUHPIS2XGhfvU4jDLxtM1mQbZtncVaM0aCl0pg63may
         B4lbQ4S+h7PiQ0zviIVuhJ89N6uRHTvhnWqdaS6xCPEe8rUIJLacExjphyZGFutPKIE9
         Tcyj2FAgjHdyF61Xz+TxcgRcguT4xkRekO6N0alV51K5RQiVjXXWIhmQO+GQ4E/wP7ae
         w8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=1W1+fqybsUESbqFpLxBx+zeLQYc7ktOvcH1nXlWexWp0dooH1ei7pYzWcvzc5ibf/7
         miOC8Bi8psXfaJcPb1MZG72NYmKQ0t81sfZuebl97bIT2eeegZhPoCJkUsAlHe5GEco9
         4ZuMpx6KTwSkDaZvkCysYwqq0XplLiucokOyAA54X2TetAGkWHdjMfhs/eylTpVgkrlv
         zc7kKHyvWA4uMRIHbrirkm4XMgUjXWK70FzgDQ/yROsyRgv8RRjwLjN805uCnhTcKds4
         7fzOoCzzl0UmU1iM7kOKczC+0UCxrhN1+aX8EXmCz+x7wtbN5CWBJ+K7wFv8rbc2mViu
         fP7w==
X-Gm-Message-State: AOAM532CVrb7tiqG3qBxW9gf/qkaKiNXb8N+nmPCdyS+6dwRdEpojUcP
        JpehV5UM7kUHmL5lhtb44RYtBQ==
X-Google-Smtp-Source: ABdhPJzYX/E/+1Ii5C7/P/RfG4Wu+dw2puTY0ls2sj7WmEvNYlOE5J6ASYDVweN8TpwIu3F89ogstw==
X-Received: by 2002:a05:6a00:1952:: with SMTP id s18mr6683685pfk.54.1643347577383;
        Thu, 27 Jan 2022 21:26:17 -0800 (PST)
Received: from localhost.localdomain ([122.171.184.231])
        by smtp.gmail.com with ESMTPSA id b20sm7731744pfv.134.2022.01.27.21.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:26:16 -0800 (PST)
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
Subject: [PATCH v2 6/6] RISC-V: Use IPIs for remote icache flush when possible
Date:   Fri, 28 Jan 2022 10:55:05 +0530
Message-Id: <20220128052505.859518-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128052505.859518-1-apatel@ventanamicro.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IPI calls are injected using SBI IPI calls then remote icache flush
using SBI RFENCE calls is much faster because using IPIs for remote
icache flush would still endup as SBI IPI calls with extra processing
on the kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA
and RISC-V ACLINT) which allows S-mode software to directly inject
IPIs without any assistance from M-mode runtime firmware.

This patch extends remote icache flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

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

