Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AB50174E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiDNP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiDNOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25F3614A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C8761E5C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC5C385A1;
        Thu, 14 Apr 2022 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649944821;
        bh=yZzfIMgMmACle5FvcjBY14F1kiew6Oh0EdfQGa1Lu/w=;
        h=From:To:Cc:Subject:Date:From;
        b=GdNzy7tEXojYjxjcPiyL7svP/TCkJEWu6yG63EQMWofMlPfJQsBuxBVi8/xMnXY0d
         ncCKQ0xbxP927jda8qOO026FeLLhQItV3c27LPro+FTnVaQ0Ba+2pur7vwE44iDoCH
         OnbbPtn4O04Xq3Afq7XTh18N1KURud6bGemG6phHzNMSuxAt9u7loCocopMiOKOdoV
         B3b9a2xoECZ62Yix1Ut/6xpI1i49XMYPcv2c44B+TfoG/8rgx4+07l6zdSQX9L0uUQ
         237p+iFX9dZM7WGgIwROssl5dNg1D/cR+F0dirDTOLCyGGeiFrIVe6SEtysubDuSMR
         z3HqsRGh9AhQA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nf01C-004JJB-S2; Thu, 14 Apr 2022 15:00:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] genirq: Take the proposed affinity at face value if force==true
Date:   Thu, 14 Apr 2022 15:00:11 +0100
Message-Id: <20220414140011.541725-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, m.szyprowski@samsung.com
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

Although setting the affinity of an interrupt to a set of CPUs
that doesn't have any online CPU is generally frowned apon,
there are a few limited cases where such affinity is set from
a CPUHP notifier, setting the affinity to a CPU that isn't online
yet.

The saving grace is that this is always done using the 'force'
attribute, which gives us a hint that we really shouldn't worry
too much about the affinity at this stage, and that the caller
knows best. Or so we hope.

This restores the expected behaviour on Marek's system.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link:: https://lore.kernel.org/r/4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com
---
 kernel/irq/manage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f71ecc100545..f1d5a94c6c9f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -266,10 +266,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		prog_mask = mask;
 	}
 
-	/* Make sure we only provide online CPUs to the irqchip */
+	/*
+	 * Make sure we only provide online CPUs to the irqchip,
+	 * unless we are being asked to force the affinity (in which
+	 * case we do as we are told).
+	 */
 	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!cpumask_empty(&tmp_mask))
+	if (!force && !cpumask_empty(&tmp_mask))
 		ret = chip->irq_set_affinity(data, &tmp_mask, force);
+	else if (force)
+		ret = chip->irq_set_affinity(data, mask, force);
 	else
 		ret = -EINVAL;
 
-- 
2.34.1

