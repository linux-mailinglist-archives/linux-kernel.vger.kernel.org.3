Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE24D5E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbiCKJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbiCKJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0A1BD051
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:42 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biqCa2wK0y8jzYUEIskT5LvVqKF2o1w4BelHcSOhH3Q=;
        b=M7xcAdUa+2Q+TbgcJTu90NcCq5Q+iwFZaW1kyFLDiGXpuV0Qe0klk3WbfqY2ltKc81mY1A
        C4dsC2cLjn8Sbt6c6RiyBHnggBJN22SSvceDSwehmFtjhKxsGvaNsdzWf3CNcidRlnyOCG
        BseWh1CTN73zd5rriq/VmVf3OtS4uINmh0Ob6CJYuuMLUqGb2vj8MoZIMN3Ytd1STME8RG
        +hHhrdnlGJPjPkqNx2Yss6TgSREoS8mPQ6TiEt7baUUXIFOTQph21IWmT85ZGKd8NOHQy4
        5K713ss3gwJdLXHupCRN/m2Eoyi3e4bIL2A4m3x0eR2+iFbCgqSsJxPD30eOLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biqCa2wK0y8jzYUEIskT5LvVqKF2o1w4BelHcSOhH3Q=;
        b=2XJibOIHlDQheiKACV1OY6TDOmA1QduAN/M1pclGoFaZh9sWoUsTnfcpgtSODlFxPa8Woj
        qk6aYibd+fLDnrAQ==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] PCI: apple: Change MSI handling to handle
 4-cell AIC fwspec form
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220309192123.152028-2-marcan@marcan.st>
References: <20220309192123.152028-2-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699044041.16921.50682772081546341.tip-bot2@tip-bot2>
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

Commit-ID:     89eb1681b73ff584c5678f7185a2d8e3070e9b78
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/89eb1681b73ff584c5678f7185a2d8e3070e9b78
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:17 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Mar 2022 09:49:03 

PCI: apple: Change MSI handling to handle 4-cell AIC fwspec form

AIC2 changes the IRQ fwspec to add a cell. Always use the second-to-last
cell for the MSI handling, so it will work for both AIC1 and AIC2 devices.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-2-marcan@marcan.st
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 854d951..a2c3c20 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -219,7 +219,7 @@ static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq < 0)
 		return -ENOSPC;
 
-	fwspec.param[1] += hwirq;
+	fwspec.param[fwspec.param_count - 2] += hwirq;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
 	if (ret)
