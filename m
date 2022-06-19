Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531085508B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 06:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFSEyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 00:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSEys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 00:54:48 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DDB2F5B4;
        Sat, 18 Jun 2022 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Z9bpe
        gj2PLCMxSrP9Wmvpb4Z13yyZp3UPvP7FlEHtbg=; b=RyXw7Aldjg2gSNAakGJjp
        kebNmGK0xU7ZM8CVex3uriI0AYPZUPg1BLfLMwVQE4C59UTsqDw5Mk81++cT8kax
        LaSACtSflhG9OOBZgA0jf5uARmWO9uibmLbUU3F4mp7g/OiLNjDryNgxrPbRG/oR
        AbmxH8lKZoCEqjRYQHAAQs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAAna_oFrK5ik2fCDg--.45446S2;
        Sun, 19 Jun 2022 12:54:31 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tsbogend@alpha.franken.de, yangtiezhu@loongson.cn
Cc:     windhl@126.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mips/pic32/pic32mzda: Fix refcount leak bugs
Date:   Sun, 19 Jun 2022 12:54:27 +0800
Message-Id: <20220619045427.4064946-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAAna_oFrK5ik2fCDg--.45446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWUKF4DZFy7Zr4UtFW5Wrg_yoW8WFyDp3
        y5CFyfJFy8ur17tF9ayFyDXrs0qFykXrWUZay0kFy3A3WDXFn5Zr4xtrn8J3WDAFWfW3Wr
        Xr4FvFW5WF4vya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4CJdUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgclF18RPUvQFQAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node(), of_find_compatible_node() and
of_find_node_by_path() will return node pointers with refcout
incremented. We should call of_node_put() when they are not
used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog: 
 
 v2: (1) merge pic32/pic32mzda bugs into one patch
     (2) fix leak bug related to of_find_node_by_path.
 v1: use two patch for intit.c and time.c

 arch/mips/pic32/pic32mzda/init.c | 7 ++++++-
 arch/mips/pic32/pic32mzda/time.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 129915616763..d9c8c4e46aff 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -98,13 +98,18 @@ static int __init pic32_of_prepare_platform_data(struct of_dev_auxdata *lookup)
 		np = of_find_compatible_node(NULL, NULL, lookup->compatible);
 		if (np) {
 			lookup->name = (char *)np->name;
-			if (lookup->phys_addr)
+			if (lookup->phys_addr) {
+				of_node_put(np);
 				continue;
+			}
 			if (!of_address_to_resource(np, 0, &res))
 				lookup->phys_addr = res.start;
+			of_node_put(np);
 		}
 	}
 
+	of_node_put(root);
+
 	return 0;
 }
 
diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 7174e9abbb1b..777b515c52c8 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -32,6 +32,9 @@ static unsigned int pic32_xlate_core_timer_irq(void)
 		goto default_map;
 
 	irq = irq_of_parse_and_map(node, 0);
+
+	of_node_put(node);
+
 	if (!irq)
 		goto default_map;
 
-- 
2.25.1

