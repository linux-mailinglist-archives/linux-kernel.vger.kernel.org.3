Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F54B1A35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbiBKANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:13:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiBKANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:13:35 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE426DA;
        Thu, 10 Feb 2022 16:13:34 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h11so5699490ilq.9;
        Thu, 10 Feb 2022 16:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P9CQld7JqGJfJXS61tcHY1+Q0rrT2ByYuWx5h8QfDxg=;
        b=Si1YTbH4uVu7arrxfMdWslaIjgTMOegSVuC2K771A/Gpc/h4LY+Ug2RAq06koXGaGB
         19raDUJ4IbyL5UxNmkSlCjq8yC0/MQs7ny+ceRdiPJgWKRUH/g18HGx76TR+d4u5aMzn
         wHojbv8airUCDg2dFG2TbYE125EbBMUIDn3GuuP1WbW788400zH6+9vtkV/0b0LEQHXH
         hSz7xK8WHhKcCHAo+/a9VIqRueI+LX7YZgdAseKgEsfWPcC9ycBltcYUnix/qjFGgExK
         TIgNvHH3qNwC7XplpKn5TZgIeG+RXXAOipR9U+RCHjmeX2WVTrja7/7RtroVmHPwzzgT
         KOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9CQld7JqGJfJXS61tcHY1+Q0rrT2ByYuWx5h8QfDxg=;
        b=DQmyz7j565RKn7ovZ2VBATROAmt1KOcPfCnTt0W0fxdNzgD1ATBFregAi8sP4SLYg1
         G5tRJ0caFLFzl/Bav3COONZkY07bp5fLuNKHiCQ/HcKgvq1k0Xi+Cx6YEDBvBh+Ci0SQ
         kZnYvqh2picx9PxGFBQCK2nOMt3oGyB+h+/Wz/4WcDyuvcyJ762yCBAi7imVWiA1AHaV
         Po2Xe/g1zyi4FjZx2WnPlfDQDdCuH3WsiqKjuZcczchTJ2Zad2a2EhZSZEEDIuPBMUUC
         cLlzIllWz7nJLkHf7cKTPmLYpGC929apoDoehtYdD5kDnJpeH9w1ucxcWO6LP1btULpq
         fGrQ==
X-Gm-Message-State: AOAM532EeUtBAr+BGqXc49rR9h8jDqOYjpMuOj4yH04esSRN74gtSceP
        Dj7+AQldqYJcj/3EoiFBwvU=
X-Google-Smtp-Source: ABdhPJxfWUlPP3bz5Kd/ubQZOjy0O9kW3lT//YIrBrMf5tL4x2+m9mGFhShROfdFB+0MnnI9PBIWKg==
X-Received: by 2002:a92:d944:: with SMTP id l4mr4723853ilq.2.1644538413618;
        Thu, 10 Feb 2022 16:13:33 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id c11sm7148530iln.56.2022.02.10.16.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:13:33 -0800 (PST)
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
Subject: [PATCH 37/49] arch/mips: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Thu, 10 Feb 2022 14:49:21 -0800
Message-Id: <20220210224933.379149-38-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mips code uses calls cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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
2.32.0

