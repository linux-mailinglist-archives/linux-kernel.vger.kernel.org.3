Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EB74C824D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiCAE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiCAE3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:29:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B34EA0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ay10so627580wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=l9W+NGbgxdapkSDh1674O7D8QLnibie0+u3PaStrMsDolQoNXQay/fD6eG7haTMIex
         9hjRC1bPjXL+ev46XF0WqEfHSvHTI+AuD2lrFA7vLF1nc+s2uyeXiNlNj2JJec7gGgUn
         2JES8wdSB7kl8EW3lDrqR+StUYnr+zca0owdBvyFARzpwItdzw+AfPumhlGKDM3pXQ30
         QLa59UPT2zCDE4YnRQ2OACeI3iJFAqeiSAVc6dg9DX2q4W6goTjqVMDCKbvl4mKCSYBH
         b2givfpcsF2VQPBwZy/zWEwsP0GS9pyXxCiqkO8t7LeOKA2HHjJBnCjucp/WssWGSUI1
         dqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=qe3mVotArASa2sRMLhnTLjU8s/RVydAIX3GpEbWX4uMkh2G5fFJDoss0hKrEG6UUKo
         jINHubk7Pmo9Q5VwbxIaj+bncHublIhX2LFUy59HYpMfN395E++hdVjvBG1WfLIOGJSY
         5IzeqRFLlL38TL5E98jSy5QSHge8mzpkYeGt86EHZPlAMB64nAJ9mH3Ln0ReL6tpl6jC
         x5qFgE4Q20AGdf4WHOkK7VhyDgboRkNIv6V1GDrs5t2QpAIyySHdqtR0adhI/QP941lL
         oEZwlO0MmrZIIpoPUKJH7xzNNk1zbdj3XfhZ2PGF7KQqTUiBWlxen5ezRquNA++1vif8
         eeVw==
X-Gm-Message-State: AOAM532qIOHQYeqTYWZLUrGqAzxbWBUADX3Xx5sl8twWTHKzHiPyUPTA
        rpfe95OijkgQFUokQT3Ph59FdA==
X-Google-Smtp-Source: ABdhPJyGhlMwmtEnqXiAm8QiDsDHXaZmhEWG6M8Am41WiNmn6yrzFFympTA20zKYu+3kv7rh5608sg==
X-Received: by 2002:a5d:4606:0:b0:1ed:d3c0:19f4 with SMTP id t6-20020a5d4606000000b001edd3c019f4mr18570799wrq.555.1646108922741;
        Mon, 28 Feb 2022 20:28:42 -0800 (PST)
Received: from localhost.localdomain ([122.179.35.69])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm1209107wmz.43.2022.02.28.20.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:28:42 -0800 (PST)
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
Subject: [PATCH v4 6/6] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue,  1 Mar 2022 09:57:22 +0530
Message-Id: <20220301042722.401113-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301042722.401113-1-apatel@ventanamicro.com>
References: <20220301042722.401113-1-apatel@ventanamicro.com>
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

