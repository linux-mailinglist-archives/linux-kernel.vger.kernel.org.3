Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD29545256
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiFIQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbiFIQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABC6A046
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:30 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iY8vB1XlqCDxCqFoUzzJxG9prTdgHGid2Dgoqo6UO+Y=;
        b=XfFeC5EGtIYKnqcm3YSIgfI/l7/3B9dM9I3MVsLjndah2RRj97MUj7Zip57c1xhlmklkNU
        QcBej5YaizA2vPUPVxc7jBK2+gjy0FjvmYLH8KyqinPbiAWkFV71BezelpntS4hCjWXye2
        Nog18We3BcJZWCnLnW1f7NMfaMBgirJ3uKsJNWvh2fV4t1VBFkV+Kp3u9oNiWA39zS9Ga2
        tXXnt1YBnkxbJfj2JiBstC+jIOmVIePyy3PIfGd+fm3cWwu5UQx+iSxGE54MJUFZ1GhFIv
        ltpPIYJzYv7zkJu3gJImVOjbKjfS6BxDV589Y5xWsSsO+s8LmSMFa81U+KCZjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iY8vB1XlqCDxCqFoUzzJxG9prTdgHGid2Dgoqo6UO+Y=;
        b=Y444xISojZDalxIrdcSdrKfR4XbtXA2J//YZZLGd+dUch/SQPT3eXGZaFCN0LNpC4JXG3X
        snf8lYr4cfUcuJCA==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/apple-aic: Fix refcount leak in
 build_fiq_affinity
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220601080930.31005-3-linmq006@gmail.com>
References: <20220601080930.31005-3-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165479342813.4207.13989343963234082027.tip-bot2@tip-bot2>
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

Commit-ID:     b1ac803f47cb1615468f35cf1ccb553c52087301
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b1ac803f47cb1615468f35cf1ccb553c52087301
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 12:09:26 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:36:57 +01:00

irqchip/apple-aic: Fix refcount leak in build_fiq_affinity

of_find_node_by_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a5e8801202b3 ("irqchip/apple-aic: Parse FIQ affinities from device-tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220601080930.31005-3-linmq006@gmail.com
---
 drivers/irqchip/irq-apple-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 12dd487..478d0af 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1035,6 +1035,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
 			continue;
 
 		cpu = of_cpu_node_to_id(cpu_node);
+		of_node_put(cpu_node);
 		if (WARN_ON(cpu < 0))
 			continue;
 
