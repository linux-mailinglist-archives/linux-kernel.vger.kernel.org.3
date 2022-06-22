Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519B5542BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiFVGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiFVGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:22:14 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 238E62F02F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KNm6r
        djgI3fZb458Vh2B3XGihON4TOae3lbBQT12LPA=; b=GihQyMCj7YH0xlL/cIptn
        4at0fGwV485O97ItxX/Jh9s//WrsQFurBvfAoReP8kYTkb8ynNpvqBFauiO3nbn6
        9gQtFoEbAs8qAncGijF5A6zRpx5/jQop0mz3rLbicwKxphTG2X5Fw595vaEAS33e
        VKt92U23z7/ZitrCWBY5g0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADH953ztLJi_i9QDw--.64468S2;
        Wed, 22 Jun 2022 14:21:40 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] irqchip: Add missing of_ndoe_get() in its_of_probe()
Date:   Wed, 22 Jun 2022 14:21:38 +0800
Message-Id: <20220622062138.4095598-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADH953ztLJi_i9QDw--.64468S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UtryDuw4fGr17Zr18Zrb_yoWkWFc_Cr
        18WF9rXr40kF4rt393ZF43ZFn8Jw4vgrWrur4Iyas3Xa42v3W7GFZrJr97XayrWF42vryf
        Grs0vr4Ykr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_hL03UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RQoF1pEAQOF6gAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to add missing of_node_get() for of_find_matching_node() to
keep refcount balance.

Note: of_find_matching_node() will decrease the refcount of its first
arg.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..829893cc5e10 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5309,6 +5309,7 @@ static int __init its_of_probe(struct device_node *node)
 	 * reset, don't even try to go any further, as this could
 	 * result in something even worse.
 	 */
+	of_node_get(node);
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		int err;
@@ -5323,6 +5324,7 @@ static int __init its_of_probe(struct device_node *node)
 			return err;
 	}
 
+	of_node_get(node);
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		if (!of_device_is_available(np))
-- 
2.25.1

