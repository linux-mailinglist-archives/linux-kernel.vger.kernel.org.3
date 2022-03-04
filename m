Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E924CDE44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiCDUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiCDUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157223D02C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:52:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc44b6dc9dso47594327b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n2NqcUHbJsWardOwH6kbWHzl6hZnl0/7q7/h4tOTkqg=;
        b=brNL5BLowTA5Lbs7SQfkYniaerH4AtPVOQyQtLOhaKCY+l1sZObrIKaasUtJdUshpz
         l5GtEpc7cEqUNN4fTLs2aVsDy7MSdip6q1Y6KrqiLZrbhcKQWz2hiNcluZVqTmwNN+t3
         Sx60dpGknsXUv9EI3xsoZC7cR2ExQu6dml82GFAgLfs94MIVQ8w32ld6wyYnVT3YlrEs
         EuQFRD3g526TZxoRI/QZM2xr3pSmQ8xVE44t4hpsc5YGwdFq7V4owU5iBw3Nkgz95u7u
         ArbzhhNSNMKFB+uv0mfVwgePqhyxBXGGWLzKUdyxKgXGZoS5Rn7JmKSMZh4e8sdg/wDG
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n2NqcUHbJsWardOwH6kbWHzl6hZnl0/7q7/h4tOTkqg=;
        b=Lssohv0atmNAEmjELWsAmuYBjr4b9/3sJoEiy8MG4s/DFmUWoyANB41IPg4nCm6vdt
         H7NFExbQlgVrBtNdDce3Z89mlZQQuHQNLYKc+MIO4C1+uP8Y9kct0hsGdiUeu2ujzy85
         SB/48E4hjbh99Z89sBlPRZPpj0fKxR60KuuxOV2bfDWOwuJ+ytA8lUmcJ9DNT5oKGr5d
         PVSMa9UXMyFW8tAGEFAke81P181JPc+kBhOCdyL1CSny2u4DSj7Yaf16p4sYac9J6fcZ
         kor9PVVGCnO7Aj5BEdqAKGylCxpWA3NOy/lKcyRgoKS7xFngpEXr7/XP4NXlcgvz9F9m
         mYzA==
X-Gm-Message-State: AOAM5303hxO0+RaENj8aKIAtgJsMExH/7HRBbTtHMhTY1yxTUX8TaxT8
        kEdiXXeogv6IuUGkeZegStgf4mK+4g==
X-Google-Smtp-Source: ABdhPJyc9COjNjk++hBy8X04xgiuTrsxUwxw4yNtOBmi2JhrnOMaTg5HtQuo6HkG1pLfJbiDlQcPlToz2Q==
X-Received: from decot.svl.corp.google.com ([2620:15c:2c5:11:5d36:3405:ac8a:5148])
 (user=decot job=sendgmr) by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id
 t6-20020a5b07c6000000b0060ba0ce019bmr42008ybq.407.1646423569785; Fri, 04 Mar
 2022 11:52:49 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:52:38 -0800
Message-Id: <20220304195238.1141725-1-decot+git@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v1 1/1] irqchip/gic-v3-its: fixup IRQ affinities to account
 for online CPUs
From:   David Decotigny <decot+git@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     David Decotigny <ddecotig@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Decotigny <ddecotig@google.com>

In some cases (eg. when booting with maxcpus=X), it is possible that
the preset IRQ affinity masks don't intersect with the set of online
CPUs. This patch extends the fallback strategy implemented when
IRQD_AFFINITY_MANAGED is not set to all cases. This is logged the
first time that happens.

Fixes: c5d6082d35e0 ("irqchip/gic-v3-its: Balance initial LPI affinity across CPUs")

---
 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd772973114a..de862fd9ad73 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1618,11 +1618,6 @@ static int its_select_cpu(struct irq_data *d,
 		/* Try the intersection of the affinity and online masks */
 		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
 
-		/* If that doesn't fly, the online mask is the last resort */
-		if (cpumask_empty(tmpmask))
-			cpumask_copy(tmpmask, cpu_online_mask);
-
-		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	} else {
 		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
 
@@ -1630,9 +1625,13 @@ static int its_select_cpu(struct irq_data *d,
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
 		    node != NUMA_NO_NODE)
 			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
-
-		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	}
+
+	/* If that doesn't fly, the online mask is the last resort */
+	if (WARN_ON_ONCE(cpumask_empty(tmpmask)))
+		cpumask_copy(tmpmask, cpu_online_mask);
+
+	cpu = cpumask_pick_least_loaded(d, tmpmask);
 out:
 	free_cpumask_var(tmpmask);
 
-- 
2.35.1.616.g0bdcbb4464-goog

