Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D64E30D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiCUTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352776AbiCUTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:38:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91845F8FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AEEEB819C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3222C340F2;
        Mon, 21 Mar 2022 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647891427;
        bh=1ZwAePmWdIAmK6iGwl3RMQhIQ7Z0QG8CpgBItccv0tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/ukm3JmCXrqOs1wjURUAMD3n6CrXsvCXPmRnhMur5TWPGk4odgr+w8PCI3HFo5IX
         dAvg+IlScuQVBHImfwFVPq3TuIrHfYl5P1lEifay0FUOr2YfxWh4xI0PatvtKEQPKu
         SgWjSXXDQvabcn+MlytRExeoXwlqtPkcGtC4HuZ1X+clUTnBq/CBjVNoEpqQ6rRJJ4
         oKquwyx4YOgqOjxAbIzRkVJ5cm3/ankcrO7xMVNRt4KTZr3RkRhDUiQpZvuiEpcGbn
         akMH/c8Xlp2BC63Pyye9WMeOOkJIiPuh0fQBgTGNuvDaUyZ88es1znH0oa0NRXP9yb
         yKRuNAYaxgWSw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWNpw-00G5T9-Qt; Mon, 21 Mar 2022 19:37:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v2 2/3] genirq: Always limit the affinity to online CPUs
Date:   Mon, 21 Mar 2022 19:36:07 +0000
Message-Id: <20220321193608.975495-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321193608.975495-1-maz@kernel.org>
References: <20220321193608.975495-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with maxcpus=<small number> (or even loading a driver
while most CPUs are offline), it is pretty easy to observe managed
affinities containing a mix of online and offline CPUs being passed
to the irqchip driver.

This means that the irqchip cannot trust the affinity passed down
from the core code, which is a bit annoying and requires (at least
in theory) all drivers to implement some sort of affinity narrowing.

In order to address this, always limit the cpumask to the set of
online CPUs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/manage.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f23ffd30385b..351024253ce8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -222,11 +222,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	const struct cpumask  *prog_mask;
 	int ret;
 
+	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+	static struct cpumask tmp_mask;
+
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
+	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -248,24 +253,28 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 */
 	if (irqd_affinity_is_managed(data) &&
 	    housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
-		const struct cpumask *hk_mask, *prog_mask;
-
-		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-		static struct cpumask tmp_mask;
+		const struct cpumask *hk_mask;
 
 		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
 
-		raw_spin_lock(&tmp_mask_lock);
 		cpumask_and(&tmp_mask, mask, hk_mask);
 		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
 			prog_mask = mask;
 		else
 			prog_mask = &tmp_mask;
-		ret = chip->irq_set_affinity(data, prog_mask, force);
-		raw_spin_unlock(&tmp_mask_lock);
 	} else {
-		ret = chip->irq_set_affinity(data, mask, force);
+		prog_mask = mask;
 	}
+
+	/* Make sure we only provide online CPUs to the irqchip */
+	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
+	if (!cpumask_empty(&tmp_mask))
+		ret = chip->irq_set_affinity(data, &tmp_mask, force);
+	else
+		ret = -EINVAL;
+
+	raw_spin_unlock(&tmp_mask_lock);
+
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
-- 
2.34.1

