Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB74E30D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352769AbiCUTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiCUTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:38:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1210F5F4D4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6F860DEA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE7FC340F4;
        Mon, 21 Mar 2022 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647891427;
        bh=SEYzK4vSPeMJtzy43JQGZXAJd12jPg80CMxvL3TbA+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r846iCeB6K3PL1kLU1vH2gs6a0PdIpzad36VDkx9u7cQEhYoP7Jz2uHj6EmCP3PDh
         FZRxAvWV9kSDFGrSVbX/XXZOc88F1CnddJpESghMwKrB4CvElhttUUG6qwqUU33+Cf
         hS2u1Y+BXRPXWkuVCXJOP3MsKPSpAU9T+2WTdTXolpP2QOBAVyuraAU0pgNTWl8B1a
         ahFuDiaEXVIKAQwwAWwEKiE2B/0ZlDRSFeVR3wBpOnoVVmig0lAsPajF+JKSAQy00v
         VanAANIldemXRhCskV3UrPkOxEGR+8GDw2mTDEHv9rpH0je46UmBtvtF8ZrGSaYdvN
         +BMezvI1JakXg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWNpx-00G5T9-0T; Mon, 21 Mar 2022 19:37:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v2 3/3] irqchip/gic-v3: Always trust the managed affinity provided by the core code
Date:   Mon, 21 Mar 2022 19:36:08 +0000
Message-Id: <20220321193608.975495-4-maz@kernel.org>
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

Now that the core code has been fixed to always give us an affinity
that only includes online CPUs, directly use this affinity when
computing a target CPU.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd772973114a..2656efd5d2b6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,7 +1624,7 @@ static int its_select_cpu(struct irq_data *d,
 
 		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	} else {
-		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpumask_copy(tmpmask, aff_mask);
 
 		/* If we cannot cross sockets, limit the search to that node */
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
-- 
2.34.1

