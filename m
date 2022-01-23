Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB264974AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiAWSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiAWSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:53 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E724C0613EE;
        Sun, 23 Jan 2022 10:41:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u130so9498904pfc.2;
        Sun, 23 Jan 2022 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fUD3By+Q+kq98PS9J46Zo9V/GV4St0mmKcFfwwO9Pb8=;
        b=K1iIT+1E2cEHkTf9YJEGufFMzj+1Eh7+cQ1FoYkqUeKs/xVJZ8bsBzPqbE+az5UcOF
         3N8dLMXOE9d+QRCy7gbLXLdF0+I4cTggikREfhOztuJnumxxAHkt4rbDqPCOopgasrHg
         CifKAdMoNw1LqCWQI9py1vRrOdGwG43vlNKwIAPHLqcdjgI+EHDWFVHNzP5YykPOq44x
         9QKl41c3DWud2s6j5qb22F4E30o25hALFnzf108ytQymFZ1W+tpflr656JLCzb7dZlaq
         79StCTlGk+PiEDZ2KwRGMk+GircEjWTnb9bYlBtUG0HBcuVDzYqTHzylz2vMtMmszbQ1
         F0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUD3By+Q+kq98PS9J46Zo9V/GV4St0mmKcFfwwO9Pb8=;
        b=2W74cVVt6RL4kW+puBFgmctKrbpNfDzLAlgQTYjzDP/frJQFsiGZCmjClqFQxgKl5Y
         b1rzcfo87K1LBxmKuU2e1kZYeUA7sH1i0UezQJ8cjuHU8wIS+t+SEzoj5yEWNLBMI1Z3
         u48jvDPDS8A/i+zkXuG+rnjDH/C+MqoTwd2czNcVJG290Al0d9QSZo8RO3X4IVkwqOx5
         lT+N1lg7at8UM+uFmcC7NwwrIwmvUWR3vuH0MlfJgc0HGJdkWWd+Y1hOXOPsgXXepNYU
         e142jc7UL5VymSJc5m9w9au4wdRbK1NIIKfo7hqrheZO0cvRKh7IB6suJj/sKFiUgvjL
         Eelg==
X-Gm-Message-State: AOAM533wAKPtJhBmFsCzCIApw+vpMwtaRzXpoxcBCUuFPjSxJsv2O+r9
        5A9IuC2fChmNwMXrTWX3s6iMkx5LbLw=
X-Google-Smtp-Source: ABdhPJzgui0t/epPuAWCm48+9aVBhNRSHTduGzhQc69xdNO0+dJyfJfNKcCZ70W6D4Q4vze3O9f0vA==
X-Received: by 2002:a63:3710:: with SMTP id e16mr9494755pga.507.1642963306975;
        Sun, 23 Jan 2022 10:41:46 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id mm24sm11135471pjb.20.2022.01.23.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:46 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 38/54] arch/mips: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Sun, 23 Jan 2022 10:39:09 -0800
Message-Id: <20220123183925.1052919-39-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mips code uses calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 4 ++--
 arch/mips/kernel/crash.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 844f882096e6..914871f15fb7 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -763,7 +763,7 @@ static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
 	if (!cpumask_test_cpu(cpu, mask))
 		return;
 
-	if (cpumask_weight(mask) > 1) {
+	if (cpumask_weight_gt(mask, 1)) {
 		/*
 		 * It has multi CPU affinity, just remove this CPU
 		 * from the affinity set.
@@ -795,7 +795,7 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
 	 * This removes the need to do locking in the .ack/.eoi
 	 * functions.
 	 */
-	if (cpumask_weight(dest) != 1)
+	if (!cpumask_weight_eq(dest, 1))
 		return -EINVAL;
 
 	if (!enable_one)
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 81845ba04835..5b690d52491f 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -72,7 +72,7 @@ static void crash_kexec_prepare_cpus(void)
 	 */
 	pr_emerg("Sending IPI to other cpus...\n");
 	msecs = 10000;
-	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
+	while (cpumask_weight_lt(&cpus_in_crash, ncpus) && (--msecs > 0)) {
 		cpu_relax();
 		mdelay(1);
 	}
-- 
2.30.2

