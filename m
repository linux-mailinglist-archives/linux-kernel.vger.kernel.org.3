Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF424F4BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392587AbiDEXFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457389AbiDEQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1795FD1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:40:03 -0700 (PDT)
Date:   Tue, 05 Apr 2022 15:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649173202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNbbUHgi/gK/PTQ31pgIOB6t17WinOBxdwpVyjEkEbM=;
        b=Z9Vy1nch1xK52dTad/qeqNBSy96OTq/6V6Ki7EAESoEmIRVvWGB5pCn1o64AGRSBh9HqgP
        lHjbdDSynxcEVk83OY6mqdu4IYQzwyHJwiNshZZRY336jCtFcVb4gxmzPsI4FCl4cFL3k+
        OJd9W3oZ7Geoa+PT8e/YktJe/SGf7ksqH9aBJA3iuKapeiUjY5aBOqSyRrXTeg8SXr6qzQ
        znYMWJ8GNzhbQ7SRdrq+RlCOBoj/RrEFvdiT2oHYQDqOmIanwoR2I/pge1FxH/ywdiiC/K
        4yxTb/Hfnk/60HuSKVWIaFF0wsp30rejvAkLw9ig4LbYdPEiTDKX9s5Zd/ZRoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649173202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNbbUHgi/gK/PTQ31pgIOB6t17WinOBxdwpVyjEkEbM=;
        b=5d5Dz9wJbqo7KdfzbHn0Bl4Xr46bk2sJ6vWZ54OojqflVYA2orxDazMcEQ1EItwYZXqf60
        xLDAWIoZPlQLRWDA==
From:   "irqchip-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/irq-qcom-mpm: fix return value
 check in qcom_mpm_init()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220316025100.1758413-1-yangyingliang@huawei.com>
References: <20220316025100.1758413-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <164917320118.389.3735346894420767089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     76ff614a79152cee07a2c48080c3dc91c56f0f1d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/76ff614a79152cee07a2c48080c3dc91c56f0f1d
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 16 Mar 2022 10:51:00 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 05 Apr 2022 16:33:13 +01:00

irqchip/irq-qcom-mpm: fix return value check in qcom_mpm_init()

If devm_platform_ioremap_resource() fails, it never returns
NULL, replace NULL check with IS_ERR().

Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220316025100.1758413-1-yangyingliang@huawei.com
---
 drivers/irqchip/irq-qcom-mpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index eea5a75..d306146 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -375,7 +375,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	raw_spin_lock_init(&priv->lock);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!priv->base)
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
 	for (i = 0; i < priv->reg_stride; i++) {
