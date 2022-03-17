Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213204DCA11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiCQPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCQPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:35:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B91788F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:34:00 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647531239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmfvRc9g5bLRQcU5mUbsyU2skozRH90l+W7VUJrSNkY=;
        b=3KDAXI9s6uOMQ6ymG0XbP6WqrAVXuBfzEiFQ8WfJA/aSa90JJkcRifFrErBEkPEfOjprKJ
        SlE9xgzOLLkixm8CVimEqOdoRJUm27y1RdjBNHQBpNfA6X505aFgiCi8yM57Z63BFHVsRk
        rnyNbLCgts1EJTLsgnlw2RG3RJF6jajoZzBT/TmEajct1dlVzL44jS35f2XmhLuqT12/Uk
        FFKgInTIm9sS4JtIJGIeozufm8LxbQx0g+35Yn8fQWt1aJ51pgg5+Yt/1eInJnAkQZ2sjO
        TB13+z+DQXAZDYUR3pqjbNDRmCMW79QAYKizVenZiS2cvGcr+uYm6mDzcB5IKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647531239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmfvRc9g5bLRQcU5mUbsyU2skozRH90l+W7VUJrSNkY=;
        b=lbYtxVNniht6eJQCMRQpXwotBUYvhGLi/MBcXGmn9mQjEQk2aySGIk8F2rZloqj4N7da7K
        wrHqypG7ETG6N8DQ==
From:   "irqchip-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-qcom-mpm: fix return value
 check in qcom_mpm_init()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220316025100.1758413-1-yangyingliang@huawei.com>
References: <20220316025100.1758413-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <164753123809.389.16541550679620677780.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     294aee8ab6cb5d44cde4defcda43324a25c64118
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/294aee8ab6cb5d44cde4defcda43324a25c64118
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 16 Mar 2022 10:51:00 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Mar 2022 15:30:35 

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
