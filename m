Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A614E65DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351281AbiCXPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351280AbiCXPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:16:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80069CCA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so416049pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=gpAjqtAs/CMCFYARUt91j9dwYBp7kop9q3skoKNqjx3CyCpsH5capaNKZB2s3KtrgF
         InywL3AK1oN3rwIFie+KLNYK9fxaGbFY5Jh32IuBj2HiIeYwXBqqXvcIhPUPVuwm+JS6
         f+od+jsOz1k6SOhWeZRTylBbfmxyBUqIJ5tOTKqkXSW6QU8LLM/Bf8VDxL7LG2pJBU9i
         NUsyTwJPM2JJK4EvY9usKAe7GH9fdsPUfVSUfFiRjc67GArUHiQw9UzhUcYoJxNtd+Xg
         vYJdbhGM70igS3HGexUZW46dlh993NUFYyVgPpLWSpevNWdKv/fLj4ua0szXwJ1zSf8u
         tEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX9W0jJI3V+TTQxrILZfbGus1iz/Yao2DvXh0KaNAVk=;
        b=cvko71oJTJXZ8H9a49xdF0xk6XeoWyXLstZBPe7xXmZaodIiwldPxlqPNisbRrdZiQ
         EObb1BGQSVPxUfBBY7hjmeK9g3o5eopmL7Ph4/ZyN0h9iZdOp7L7OSvgR0lhCL61lreD
         BET4P/HiTm7s3Z30KdoNb9re0M7h5caWibdsKXWWyhEZ/az62sO48tfgexfdaWwXFOOV
         JD+VbaogtcS2hIAF4bd6MVxwOjdlx1OLoo6uDCfcJMJRcVqp2K6DZIFZ+gBtDbWoT8/q
         ikkKi6EXY3yLl9xzjyGyt2s10XxmZ1oE9SOd7nLnWHinR1OUp5+QoCOqOKhbXj+khZhu
         tl7Q==
X-Gm-Message-State: AOAM533iJJTjX33ntuk9RYOhcd/vueFrmdv3J5Xiyv3lVwdPcmnmKeU5
        zaF1SoihwhrhP8wGPcUsgcE+ye5Gzg0waw==
X-Google-Smtp-Source: ABdhPJwvUWFP9fjVbmuW8smT32M8pSxwW2UY70TQr8HUafEViM0ns0c8WcusCbvLPd3lTLGS9DktJQ==
X-Received: by 2002:a17:902:bd88:b0:14f:8ddf:e373 with SMTP id q8-20020a170902bd8800b0014f8ddfe373mr6576185pls.89.1648134875096;
        Thu, 24 Mar 2022 08:14:35 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4166065pfc.41.2022.03.24.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:14:34 -0700 (PDT)
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
Subject: [PATCH v5 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Thu, 24 Mar 2022 20:42:58 +0530
Message-Id: <20220324151258.943896-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324151258.943896-1-apatel@ventanamicro.com>
References: <20220324151258.943896-1-apatel@ventanamicro.com>
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

