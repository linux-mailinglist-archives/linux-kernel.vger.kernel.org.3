Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4D591115
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiHLMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:55:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8DAB40C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:55:01 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:54:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660308899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6iK031Q/w7O2dMNGO39P6U/sBtfl3ACcZLNK118kcE=;
        b=3GFZT+U+sfUjCyWT1eOmqp9Ojgs+8SaslagRPsplsvhwJVkzj8cRPSxkVFdoNRj2uHTW5i
        roYlhqrNt4nLDRcJT+HZ1qCf3s/iHX6e7+NU01isjq7q8x3KMr6/FigYsGqcwSGUrg6hT/
        E6tPvnw6n68/tFHoxeD5Z1uCu+n+2vCTDtMcn+QGOpfq/zcvnVx0x7LLXDg3Lpu9MAgaFl
        Z9O8ztNBtxsX1BQV8fKCryOE0BmXkWHtb1NXeB0hIMkgRUVFlSCSMjpqr1UuUB0KHlSmvp
        3RIskkcvEEuq/pC9Lgd+FHD3wde4W9S3IywIOQSwnUplmRn7H1SDxquxFah/sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660308899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6iK031Q/w7O2dMNGO39P6U/sBtfl3ACcZLNK118kcE=;
        b=NHJs/HGyj93/0nT/Gw0wnhHVOsIxf6mc/EzvON2i8pekcjMPivt8wjyTNidoQSm4RrC2w9
        N83fCYnzVmobPsAA==
From:   "irqchip-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-liointc: Fix an error
 handling path in liointc_init()
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C1a6d74ab70712279023aa7bdbd31bd3aec103bc0=2E16593?=
 =?utf-8?q?82063=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C1a6d74ab70712279023aa7bdbd31bd3aec103bc0=2E165938?=
 =?utf-8?q?2063=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <166030889787.401.669462867278419781.tip-bot2@tip-bot2>
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

Commit-ID:     a9084d888fbaaed65ded56f11d052cf8b04519a5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a9084d888fbaaed65ded56f11d052cf8b04519a5
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Mon, 01 Aug 2022 21:28:07 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 12 Aug 2022 13:47:21 +01:00

irqchip/loongson-liointc: Fix an error handling path in liointc_init()

All errors lead to the error handling path, except the one dealing
with "reg-names" in DT.

Fix it and release some resources before returning if this test fails.

Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
[maz: fix commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1a6d74ab70712279023aa7bdbd31bd3aec103bc0.1659382063.git.christophe.jaillet@wanadoo.fr
---
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index acd1a4b..0da8716 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -207,7 +207,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 					"reg-names", core_reg_names[i]);
 
 			if (index < 0)
-				return -EINVAL;
+				goto out_iounmap;
 
 			priv->core_isr[i] = of_iomap(node, index);
 		}
