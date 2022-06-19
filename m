Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC495507E4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 03:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiFSBls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 21:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 21:41:47 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2A011274E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=flj0R
        IwXryIUZMJnV2yyv11kxWUnQjLtxVsxF7GsEQo=; b=AVjbbZJaJKC9mKXHianN3
        9NRGeYvDYXAJE5Di9bKN3MQHXHPYzsCtu7DA30PvvS84NnU1y7T0DrFdlEwZjMTq
        pSu3qzQut3Cjt2XNpJIQpAbY+1IlUn4SnQP6kjJW9C5QXWpvycuuSnPjZv+wLtUJ
        c4KSQhtJpM0nPknXDg1a+4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBXdq5efq5iRiXBEw--.61393S2;
        Sun, 19 Jun 2022 09:39:44 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        wangkefeng.wang@huawei.com, ardb@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, rppt@kernel.org
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm/mm: Fix refcount leak bugs in cache
Date:   Sun, 19 Jun 2022 09:39:41 +0800
Message-Id: <20220619013941.4061894-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBXdq5efq5iRiXBEw--.61393S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxGF4UGF4fGr47Cr1rZwb_yoW8CF1Dpa
        43C3sxAr1Fgws7CryUtF4xJF40yF1kKayq9ryUuryjyF15Wry5Jr109w1F93Z8GFWrGayF
        vF4rKryrXr18Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirWrtUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AAlF1pEDwBdtAAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In feroceon_of_init() and tauros2_init(), of_find_matching_node()
will return a node pointer with refcount incremented. We should
use of_node_put() in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v3: (1) merge arm/mm leak bugs (2) fix bugs intro-ed by v2
 v2: (1) use real name (2) normalize coding style
 v1: (1) fix leak bug


 arch/arm/mm/cache-feroceon-l2.c | 6 +++++-
 arch/arm/mm/cache-tauros2.c     | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af6..d5b7878094fd 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -376,8 +376,10 @@ int __init feroceon_of_init(void)
 	node = of_find_matching_node(NULL, feroceon_ids);
 	if (node && of_device_is_compatible(node, "marvell,kirkwood-cache")) {
 		base = of_iomap(node, 0);
-		if (!base)
+		if (!base) {
+			of_node_put(node);
 			return -ENOMEM;
+		}
 
 		if (l2_wt_override)
 			writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
@@ -385,6 +387,8 @@ int __init feroceon_of_init(void)
 			writel(readl(base) & ~L2_WRITETHROUGH_KIRKWOOD, base);
 	}
 
+	of_node_put(node);
+
 	feroceon_l2_init(l2_wt_override);
 
 	return 0;
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e4..05eab6e44cfc 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -294,6 +294,7 @@ void __init tauros2_init(unsigned int features)
 		pr_info("Not found marvell,tauros2-cache, disable it\n");
 	} else {
 		ret = of_property_read_u32(node, "marvell,tauros2-cache-features", &f);
+		of_node_put(node);
 		if (ret) {
 			pr_info("Not found marvell,tauros-cache-features property, "
 				"disable extra features\n");
-- 
2.25.1

