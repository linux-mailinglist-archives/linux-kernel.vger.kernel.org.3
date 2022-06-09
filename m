Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE9545251
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiFIQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344342AbiFIQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D272A269
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:27 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bh4eJRNdgGTUfZn4xwMUqkmN8FD3XtnIILzUSXEo9no=;
        b=BlZMM6py6ZkXifUNhyaWo+htLX/VM5Q/YWQPR0kkkrnkiW7WyPNfmb7b6WO6Qt/jwy2cIy
        5mVym3LGDUhfWEfflTBXSI/tH6VmZQ68RAMrLTq73vtbrerymaQ1ZMhQR+Gy4gwOZ20L8S
        gMoIAXm04bkh1MKVuEmD++uTDXQRjBnklitlUgkqr2r0uyeE57Se/eOt/eCpa1i+z3f7gz
        7LpT2zS+2Do6KOh6kVsu7qIhH4jKPQ+ud2aW3vd4Al6Ou6QSYBdcbfXdb5C3MdnjeMRbbV
        E8jgc2Z681Vos/P+H0M7E2SOjpIe44zpuOcpCjhjNyKXX1j5h8L4GUvq06zI2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bh4eJRNdgGTUfZn4xwMUqkmN8FD3XtnIILzUSXEo9no=;
        b=2DqsXjuiTGl6Wmqeu+lzwtbcxg9nks2mXRdU0/2f47KICjuN8waG+xis7RSwuXEpxogDaZ
        6/On7SlvEVaZ+xCw==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Fix refcount leak in
 gic_populate_ppi_partitions
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220601080930.31005-6-linmq006@gmail.com>
References: <20220601080930.31005-6-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165479342499.4207.15119028629653278712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     fa1ad9d4cc47ca2470cd904ad4519f05d7e43a2b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fa1ad9d4cc47ca2470cd904ad4519f05d7e43a2b
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 12:09:29 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:36:57 +01:00

irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions

of_find_node_by_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: e3825ba1af3a ("irqchip/gic-v3: Add support for partitioned PPIs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220601080930.31005-6-linmq006@gmail.com
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1d5b475..5c1cf90 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1973,12 +1973,15 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 				continue;
 
 			cpu = of_cpu_node_to_id(cpu_node);
-			if (WARN_ON(cpu < 0))
+			if (WARN_ON(cpu < 0)) {
+				of_node_put(cpu_node);
 				continue;
+			}
 
 			pr_cont("%pOF[%d] ", cpu_node, cpu);
 
 			cpumask_set_cpu(cpu, &part->mask);
+			of_node_put(cpu_node);
 		}
 
 		pr_cont("}\n");
