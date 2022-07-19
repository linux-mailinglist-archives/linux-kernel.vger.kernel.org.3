Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C725792A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiGSFsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiGSFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:48:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1779B2CDF8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s21so13722308pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlHFWO4BUKOhkSLA3ixeUG8K1wKBWBAz4fLmjE1iQBA=;
        b=ZBkkCxufH7ydH8OKvcGhQe+q/xQvww1z1TdeoI+35Id+tJRpE/dbzKRO4vJ5pWvPwZ
         p7sdoPv4pe3n1JOvVjFNLo/7AeFaoKNbq+cvIurPcAx/C7bjAjAoKL295axJKCLcrzPX
         bBulGkELrm14unIvVSkLLxfAdEGa6DDBDeeHB8NdAC8zAYqfOOaushPnMmqT7cC44Vaj
         1FM5Z76yv7FOnMOI8p801088ELpLTMTUY5r6qHN0QunIZtJebSVjCGR/gIZPVmtVMvgw
         fsVkxX56YVN4t6oXJ+kAvKHWDmvF/scTky3P6ws6shrPyGguRWvpptiBwsOjecnCoFGa
         c6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlHFWO4BUKOhkSLA3ixeUG8K1wKBWBAz4fLmjE1iQBA=;
        b=asxYHigXnyduyQW+imWfzEziJxTFtTkv60znGUdDdUZwwsnDnJS0OUlbxXQaWIPaGJ
         NwlhdqHFgGQDR3dS0kxowIf3pAIE3jzck1IJ5Bp7vrbsooYCGMiOkdiqiKmtaYJtSsrQ
         gF1qbG1vOH04fnrJOy/SxFxl2x1nWlwgwCFtSsHgf6chDnP5TK7rjjhQPVQ81uYsDXX+
         nSDnzujsvQAjp3mL5V0BAM6o8hNMOb66S8FyDRi58d6eDwOpiUkZSmcvMmWyXa1qoeRZ
         8u0isf1yfo7p5ZCO49jl8+VybtNWYQdJeVDGgo3ynVGX1mA0zAetr5OCZjH8CJdXO/R6
         Jhcg==
X-Gm-Message-State: AJIora9l0XmxhwZJR7sJF7CyHOI1sJ1jwdXPbir4CEHccWXhWbCWD1si
        5cwhuJ9p1r36lADekKaWsBIJ6A==
X-Google-Smtp-Source: AGRyM1tbCDz5SQoHGY0Cz35UcNtVlaAQaLE3yMTc5wyWn7kRDXfNXmJbqvJWzumgav4UYhPSSq5bfQ==
X-Received: by 2002:a17:902:ce09:b0:16c:c7b6:8b63 with SMTP id k9-20020a170902ce0900b0016cc7b68b63mr21511826plg.35.1658209709512;
        Mon, 18 Jul 2022 22:48:29 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.93.102])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b0050dc7628171sm10374129pfg.75.2022.07.18.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:48:28 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/2] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT property
Date:   Tue, 19 Jul 2022 11:17:29 +0530
Message-Id: <20220719054729.2224766-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719054729.2224766-1-apatel@ventanamicro.com>
References: <20220719054729.2224766-1-apatel@ventanamicro.com>
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

We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only when
riscv,timer-always-on DT property is not present for the corresponding
CPU.

This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
based on RISC-V platform capabilities rather than having it set for
all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 593d5a957b69..3015324f2b59 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 };
@@ -65,9 +65,13 @@ static struct clocksource riscv_clocksource = {
 static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
+	struct device_node *np = of_get_cpu_node(cpu, NULL);
 
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
+	if (!of_property_read_bool(np, "riscv,timer-always-on"))
+		ce->features |= CLOCK_EVT_FEAT_C3STOP;
+	of_node_put(np);
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
 	enable_percpu_irq(riscv_clock_event_irq,
-- 
2.34.1

