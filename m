Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7E589C92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiHDN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiHDN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:26:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919FCBF46
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:26:06 -0700 (PDT)
Date:   Thu, 04 Aug 2022 13:26:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659619564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdPWVUBtAY5XDPqTb7MBjnd11Ik1Ikrh+ckLI7Cdx9A=;
        b=qJHmLSo7Hl/uXIOsdfXjrKWS8tLgB9y33FAusjNBiavHULsSaV5s+522vJe9EjrwJ9Cj6K
        gmkOm7OfY0CwgVnnSVAJKTNaNQOcQL1uQ6wd7B76KSSe29/ImWnRKWrN0oGFf+ZtD/7+MK
        5F/7Yb7nWlCoRyU5SdMUi9wjdCmXBAc4v6+uJwGSM0pwbR8TUIW2wPOs+tUonk12J9t7V7
        pN4KVYTJSdWPwGhcfKFADR2QymOe4bBVQW6IhyazCCxSxPLxX+ZmkVc0/1Orq+zCORGyC9
        4yaEwvxz5oabtbV0oy2QSo100yJ+B95u9s73kqPZi60CnD766/xdpgx1SCRSww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659619564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdPWVUBtAY5XDPqTb7MBjnd11Ik1Ikrh+ckLI7Cdx9A=;
        b=ZtY0l2B4ka1LO+nOhyatA4kKx/UGHLRo5AoZAmELX0V73/BxzDmzCK4XtccqhN6LZTWIOn
        bsuwzIVXnZqa7sAA==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-eiointc: Fix irq
 affinity setting
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220804025421.211958-1-chenhuacai@loongson.cn>
References: <20220804025421.211958-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <165961956351.15455.1740780387604969029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e260cfe6fb503292f183a43b51177664b222435d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e260cfe6fb503292f183a43b51177664b222435d
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 04 Aug 2022 10:54:21 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Aug 2022 10:04:03 +01:00

irqchip/loongson-eiointc: Fix irq affinity setting

In multi-node case, csr_any_send() should set EIOINTC_REG_ENABLE of
the first core of target node, not the first core of the whole.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220804025421.211958-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 80d8ca6..3174678 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -111,11 +111,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
 
 	/* Mask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)), 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
+			0x0, priv->node * CORES_PER_EIO_NODE);
+
 	/* Set route for target vector */
 	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
 	/* Unmask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE, 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+			0x0, priv->node * CORES_PER_EIO_NODE);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
