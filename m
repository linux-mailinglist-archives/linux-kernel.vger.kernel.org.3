Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02E4F4E97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835731AbiDFAdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573315AbiDESwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:52:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1DB1AB7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B3BBB81FA2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48244C385A3;
        Tue,  5 Apr 2022 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184645;
        bh=2pq6znDDwTPrws53shxITQ/dvLLKRa5w89+EvNf5cJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=og5ypzWByBszzByi63oVJK93kiLlbax4+fz+A5CwFLVQUDtQpAAJ2uKKT66u9Sciu
         +3z6dMSFhYm0HB09BlPxRYx7MWFiuFnk+7da4jDGGJxPRD1ErD4mGLY72lX2bTZvxM
         U+3FObd+AtSdxYuCfBCJg5PhxzghPa7wo+GzgY77NJBmkXEHos/9ccvOvSsEQo2rtH
         QDUuN+pIHHX43x7kB9FZkLu+a8uC2Om88KyXz+PksCm1qgk2K2L4n9lxh9u9aJ5qlX
         or3qNDId0kejyO5uZ/Wvd/CVkHtgCMLDvMty/hs1+gNOHjQ8s4smVllfJgTjcdanw2
         5N5w+2QsxHtpw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nboGJ-001tpg-Al; Tue, 05 Apr 2022 19:50:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Date:   Tue,  5 Apr 2022 19:50:39 +0100
Message-Id: <20220405185040.206297-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405185040.206297-1-maz@kernel.org>
References: <20220405185040.206297-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index c03f71d5ec10..f71ecc100545 100644
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
 	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
-		const struct cpumask *hk_mask, *prog_mask;
-
-		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-		static struct cpumask tmp_mask;
+		const struct cpumask *hk_mask;
 
 		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 
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

