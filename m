Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7054D8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiFPDDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiFPDC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:02:57 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31D6C17A9C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mqJbs
        XLKJyovyR04zCb3Sxx6qLVpngMFn949ve1ky9A=; b=MAAmG2z+cwKuF09xtsA5D
        DdfnpFNILakoaoZ1MCwPLKxjRtASkX7CyUEkJxWA6M3LorKVWg6fpvOiQi6MDvmh
        /Px5KDbY9YOllQPvmfOlu5HlQ6ahLhN946DYomBl/4611WDiLgqOPHDkWJQ9hvkV
        fTIZsoslKn6gscmqcOU8ig=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAA3dvVInapi_3aXDQ--.63644S2;
        Thu, 16 Jun 2022 11:02:33 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: mm: (cache-feroceon-l2) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:02:32 +0800
Message-Id: <20220616030232.3974254-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAA3dvVInapi_3aXDQ--.63644S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45XFW5WFWDur45Jr45trb_yoW8XF15pF
        yrC3y3Zr4rWrn7ur97tayxZFW7KF4ktFWj9ryUur1rAr45XFyYqrWrKw1Y9wsrtrWrAayF
        vFWFgr18Za48ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pENtxnUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QoiF1pEANSNYAAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In feroceon_of_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 v2: (1) use real name (2) fix errors reported by with scritps/checkpatch.pl
     (3) use goto-label patch style
 v1: add of_node_put() in fail path 

 arch/arm/mm/cache-feroceon-l2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af6..ff17b7df4b09 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -368,6 +368,7 @@ int __init feroceon_of_init(void)
 	struct device_node *node;
 	void __iomem *base;
 	bool l2_wt_override = false;
+	int ret;
 
 #if defined(CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH)
 	l2_wt_override = true;
@@ -376,8 +377,10 @@ int __init feroceon_of_init(void)
 	node = of_find_matching_node(NULL, feroceon_ids);
 	if (node && of_device_is_compatible(node, "marvell,kirkwood-cache")) {
 		base = of_iomap(node, 0);
-		if (!base)
-			return -ENOMEM;
+		if (!base) {
+			ret = -ENOMEM;
+			goto out_put;
+		}
 
 		if (l2_wt_override)
 			writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
@@ -386,7 +389,10 @@ int __init feroceon_of_init(void)
 	}
 
 	feroceon_l2_init(l2_wt_override);
+	ret = 0;
 
-	return 0;
+output:
+	of_node_put(node);
+	return ret;
 }
 #endif
-- 
2.25.1

