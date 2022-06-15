Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473FF54C650
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbiFOKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348791AbiFOKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:34:13 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EDD852B22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/8K3T
        5y+ohmn9H6J0pjAY51Fti4HVcDrKSSJgq06u3Y=; b=bEJfMzH8xP1jIn1p35gyJ
        /pOpT5kOnArp3StGdlM3zNzbByqnMNTdS0oJIVkjUQRFcxR1qVi7q1+eOl8jM171
        pTqyjQpC3kzIQMtLXv4N25dM+LD0SmbCANBlo/o9x3V6H6vCJ4hKpf2BSNANy6Jt
        j8uTvrpKYOnXfNzZO4gqG0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAD31d58tali3pekEQ--.56629S2;
        Wed, 15 Jun 2022 18:33:33 +0800 (CST)
From:   heliang <windhl@126.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] [Re-PATCH] arch: arm: mach-pxa: Add missing of_node_put in irq.c
Date:   Wed, 15 Jun 2022 18:33:32 +0800
Message-Id: <20220615103332.3963303-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAD31d58tali3pekEQ--.56629S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45XFW5WFWDuw4rZryUAwb_yoW8Jw1xpr
        Wj9340yr18ur40gayjyay8ZrWYyF4vgF4jkayrC3W7Jw4rA3yjva10k3s3Z3WrKFW8Xa95
        AF1Fya48uF95CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_ucMdUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuB4hF2JVj35vHgAAsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pxa_dt_irq_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put in
fail path or when it is not used anymore. This goto-label patch
style is advised by Daniel.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-pxa/irq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 96f33ef1d9ea..338356b9f37c 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -247,13 +247,13 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 				   &pxa_internal_irq_nr);
 	if (ret) {
 		pr_err("Not found marvell,intc-nr-irqs property\n");
-		return;
+		goto out_put;
 	}
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
 		pr_err("No registers defined for node\n");
-		return;
+		goto out_put;
 	}
 	pxa_irq_base = io_p2v(res.start);
 
@@ -263,9 +263,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
 	if (ret < 0) {
 		pr_err("Failed to allocate IRQ numbers\n");
-		return;
+		goto out_put;
 	}
 
 	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
+	
+out_put:
+	of_node_put(node);	
 }
 #endif /* CONFIG_OF */
-- 
2.25.1

