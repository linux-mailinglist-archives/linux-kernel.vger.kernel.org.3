Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20E588680
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiHCE1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiHCE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19756BA3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585896131A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C560EC433C1;
        Wed,  3 Aug 2022 04:27:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/2] irqchip/loongson-eiointc: Fix irq affinity setting
Date:   Wed,  3 Aug 2022 12:27:28 +0800
Message-Id: <20220803042728.3230346-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220803042728.3230346-1-chenhuacai@loongson.cn>
References: <20220803042728.3230346-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-node case, csr_any_send() should set EIOINTC_REG_ENABLE of the
first core of target node, not the first core of the whole.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index f8060e58ee06..58c1cf47b3d7 100644
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
 
-- 
2.31.1

