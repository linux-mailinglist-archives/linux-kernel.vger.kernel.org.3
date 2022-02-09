Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3384AF660
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiBIQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiBIQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB28C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:56 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TtwJx9AVx6uukIol50AhI0AFPylO1cfq4nylzpatFw=;
        b=YAe8Nk8d7JfRaoKS8wvjKTPuSDv//PJOnSWvYHWo889ddtpBUc+Wc9UNeTVAfKMsKvzDSv
        bzlIt4Fe0NYTDLGShy9/js9+l0vNLKTVQFCIW++1+w3wDZLoeUkbKk3kxTUF1FRD1N91SL
        21EkYSygk/cC2NPHrPgcaXebicrKHuplp/5IwiDxLEO3wfMLtoGTGscEHdJeC6+aUbjwDU
        EUn6D2QOaDoPgbathXkDhOq5YpaO7ZsoAK3xYF9hZ1qLIvc8HJmpqXqW5V8Nq6dwrkSqJj
        Jlaww0hmlErL+tiUmGrehrXTfsqduAiMCgvRsVLGtsFDowgTZi0RliiS1Obsyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TtwJx9AVx6uukIol50AhI0AFPylO1cfq4nylzpatFw=;
        b=Tk/vPPp7o2ZKL33u8Pp888BFWzWn5hxnanP7GiL3pt+x64Vh2MFmkp6mn1EvmbfhZsiQvI
        2KF9uklt1lEzcdCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: tpmx86: Move PM device over to irq domain
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        tglx@linutronix.de
In-Reply-To: <20220201120310.878267-10-maz@kernel.org>
References: <20220201120310.878267-10-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347382.16921.7555196240601561130.tip-bot2@tip-bot2>
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

Commit-ID:     924610607f191bee4379bc3775b0fd025ad7e922
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/924610607f191bee4379bc3775b0fd025ad7e922
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:07 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:54 

gpio: tpmx86: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-10-maz@kernel.org
---
 drivers/gpio/gpio-tqmx86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 5b10322..fa4bc74 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -281,7 +281,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		u8 irq_status;
 
 		irq_chip->name = chip->label;
-		irq_chip->parent_device = &pdev->dev;
 		irq_chip->irq_mask = tqmx86_gpio_irq_mask;
 		irq_chip->irq_unmask = tqmx86_gpio_irq_unmask;
 		irq_chip->irq_set_type = tqmx86_gpio_irq_set_type;
@@ -316,6 +315,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		goto out_pm_dis;
 	}
 
+	irq_domain_set_pm_device(girq->domain, dev);
+
 	dev_info(dev, "GPIO functionality initialized with %d pins\n",
 		 chip->ngpio);
 
