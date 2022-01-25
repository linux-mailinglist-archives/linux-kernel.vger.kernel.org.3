Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3D49AD20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442159AbiAYHIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378294AbiAYHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58972C041880
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:43:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y27so14352203pfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=JdjRBwA2ItC7x0XF8RUVHHfxzCxU1kMYhD6JAiAK4X1ZK/YVkC41CJ+dEp+zaG6MJQ
         Q4MxXzgel3SyV06z9ylbKff9jbTBYKtAVzoW/XHVqEAo7sG1iDDymGM/liKP46p5IuTf
         CE6LdggyIu3fHhOgeL9jofga7qXco/xs1JJjTHD1BZU9wICkTYUycnBMqRDhhkfpJ2mG
         aQ1eFN+HcDK69CWs42a63Gry5MqDCrzW9Q1nCNc+cHVGrBs5Me7W+yNheC6JKNW4RIyP
         Rdiw/1zqVLC9XUuPX5lyVylwTVu/14fOMxrPSwaXOz98UsaNb9Vie6OcTqEpvvOxOM7n
         f2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e9yogaMLiWmOvC9vxOUuPR1xHD22ef7smp5tanFg+4=;
        b=PTneUwbiuZGFkgpAF9LdaMbL9BuEsGdr0Cm6RyZmSQJtmLYLmIDAt2LZ4GWzrH0baX
         5/khvW4t3hUlrs9ZKu+ou3RG+SMjKpy/+CxGg6nniuLYWVCj5RJ3r13O6ZW4qYSS0jMG
         Ysj/KW2SLtWTJg3WedjUTHKmKGd9ZZgrMA676Rx2qNXWtrB+MDlfM5orI9JrLCor1KJp
         5M6T7yrBV/Oy1sgjBaC1kwX8YtL0XDYyPDsJeC4DKdfICYmVzKiviAV4o8bH3yKiOr6q
         FJvnDZSAnXnjpW4k7t1yXtB3eS6V5WRkqwUz0+M4uIVvJwJgsJWhao2jjy5xYhA8FNTy
         mrgQ==
X-Gm-Message-State: AOAM533aJAxIXv+X5WSncjzdxLpxzsA6hp7O/8xJdNJBo7isPKQhFDoH
        fmGk4OPC8fFUzjHfUJmktY0RDg==
X-Google-Smtp-Source: ABdhPJwK3m1JgrMY4NThERVx9U54lSUa4lAfAW78tm/S+5/b0ojZID3Q2xcUGyh6aGHE08T6WnKLbQ==
X-Received: by 2002:a05:6a00:180e:b0:4c8:f0b8:2382 with SMTP id y14-20020a056a00180e00b004c8f0b82382mr8832309pfa.59.1643089435789;
        Mon, 24 Jan 2022 21:43:55 -0800 (PST)
Received: from localhost.localdomain ([122.179.14.218])
        by smtp.gmail.com with ESMTPSA id c6sm19524508pfl.200.2022.01.24.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 21:43:55 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 1/6] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue, 25 Jan 2022 11:12:12 +0530
Message-Id: <20220125054217.383482-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125054217.383482-1-apatel@ventanamicro.com>
References: <20220125054217.383482-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
S-mode but read-only for M-mode so we clear this bit only when using
SBI IPI operations.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 arch/riscv/kernel/sbi.c | 8 +++++++-
 arch/riscv/kernel/smp.c | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f72527fcb347..9786fc641436 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -621,8 +621,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
 	sbi_send_ipi(target);
 }
 
+static void sbi_ipi_clear(void)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
 static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi
+	.ipi_inject = sbi_send_cpumask_ipi,
+	.ipi_clear = sbi_ipi_clear
 };
 
 void __init sbi_init(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b5d30ea92292..6fd8b3cbec1b 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -89,8 +89,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.25.1

