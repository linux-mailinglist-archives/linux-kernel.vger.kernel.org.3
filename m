Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6351A52C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353196AbiEDQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353225AbiEDQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E446B24
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:11 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wn6i4x/SQPrM4uJ1GO05X80Z9y6k/LaQTzxEk91WqaI=;
        b=3EiTyNBeAp/UBg1LbkNNT4Ma8o/DCvQkoRIW7GqRpGEKzYzYlnNg/v3535ll18CgvyfORi
        XtGf+Gp66UhsLT6z2NwUtdhl+WRb7ePuSwCg8QMr5WEqwR93yQPP1gQPiqzQuGcK9qeF6T
        pWrp9yaNG3TAkKgT2SbgnKPrk5kh5o0ktWjmrRVDiXHpJouppQmvsPANf2Z2shgIVr77U2
        Ni1INovabQ8h/iZLsq0EyjDt6ZJ4g7isXMbh5oU4ve8eMZhCyoQdWqyahJIT4cbPinbGeU
        ccunDwSvIpvTtHTjj6Ixiln7MT4jNxm5cpj4j25LOc1bpVbeSHb9O7nQbyr61w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wn6i4x/SQPrM4uJ1GO05X80Z9y6k/LaQTzxEk91WqaI=;
        b=DWpFXQiJtSW8hagOwG9M1HcpEtk7FUmjCj3zZLwEvcDd0tu1skQw8jqzEydsJA9RbldO9i
        K02IvdlLzol9oyCg==
From:   "irqchip-bot for Lucas Stach" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imx-irqsteer: Constify irq_chip struct
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220406163701.1277930-1-l.stach@pengutronix.de>
References: <20220406163701.1277930-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Message-ID: <165168090890.4207.17877828283652120760.tip-bot2@tip-bot2>
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

Commit-ID:     e9a50f12e579a48e124ac5adb93dafc35f0a46b8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e9a50f12e579a48e124ac5adb93dafc35f0a46b8
Author:        Lucas Stach <l.stach@pengutronix.de>
AuthorDate:    Wed, 06 Apr 2022 18:37:00 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:44:45 +01:00

irqchip/imx-irqsteer: Constify irq_chip struct

The imx_irqsteer_irq_chip struct is constant data.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220406163701.1277930-1-l.stach@pengutronix.de
---
 drivers/irqchip/irq-imx-irqsteer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 8d91a02..e286e7c 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -70,7 +70,7 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static struct irq_chip imx_irqsteer_irq_chip = {
+static const struct irq_chip imx_irqsteer_irq_chip = {
 	.name		= "irqsteer",
 	.irq_mask	= imx_irqsteer_irq_mask,
 	.irq_unmask	= imx_irqsteer_irq_unmask,
