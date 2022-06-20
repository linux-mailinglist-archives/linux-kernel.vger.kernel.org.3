Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16337552111
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiFTPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiFTPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:32:24 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1B2C42;
        Mon, 20 Jun 2022 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=orVf9
        QAUEK/mAacbw3F+OkprSRQY40n/7fcqDeWpMuU=; b=j6x3zR0luu1u2Q2641mXf
        Uol0ORJYn1vGR3JbCRhn9jiVskm9U0pCrMZmrj/Q2/pqR6niHQn8RiH5K3VSR1Sa
        NV5KjpVC9G6IXUPRImp/1jHq+eiRg6MWrErf9Vaj1M93smW18qtPbsi7o4qz9mHb
        ojoL3V+OtZzsHGSs8nfMHE=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowADnxd74krBiuLARFA--.39297S2;
        Mon, 20 Jun 2022 23:32:09 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net
Cc:     windhl@126.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sbus/char: Fix refcount leak bugs in openprom.c
Date:   Mon, 20 Jun 2022 23:32:08 +0800
Message-Id: <20220620153208.4075636-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowADnxd74krBiuLARFA--.39297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43uFyrCF43AF43Ar45GFg_yoW8Gw4rpF
        W7GFWYyw47Kws2qFnYya4kuFW3G3W8W3yrKay2y3s5X3sxX34rZrWrt34YgrW5JFyfCF10
        ywnava47WF1jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5l1PUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgMmF18RPVdM4wABs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In opiocgetnext(), we need a of_node_put() to keep refcount balance.

NOTE: we should not change 'dp' as it will used as the arg of
of_node_put().

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: (1) consider of_find_node_by_path() and of_find_node_by_phandle()
 v1: this is a wrong patch as dp has been updated by its sibling or
child.


 drivers/sbus/char/openprom.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..b5907e0c24e5 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -494,7 +494,7 @@ static int opiocset(void __user *argp, DATA *data)
 
 static int opiocgetnext(unsigned int cmd, void __user *argp)
 {
-	struct device_node *dp;
+	struct device_node *dp, *tp;
 	phandle nd;
 
 	BUILD_BUG_ON(sizeof(phandle) != sizeof(int));
@@ -506,18 +506,24 @@ static int opiocgetnext(unsigned int cmd, void __user *argp)
 		if (cmd != OPIOCGETNEXT)
 			return -EINVAL;
 		dp = of_find_node_by_path("/");
+		if (dp)
+			nd = dp->phandle;
 	} else {
 		dp = of_find_node_by_phandle(nd);
 		nd = 0;
 		if (dp) {
 			if (cmd == OPIOCGETNEXT)
-				dp = dp->sibling;
+				tp = dp->sibling;
 			else
-				dp = dp->child;
+				tp = dp->child;
 		}
+
+		if (tp)
+			nd = tp->phandle;
 	}
-	if (dp)
-		nd = dp->phandle;
+
+	of_node_put(dp);
+
 	if (copy_to_user(argp, &nd, sizeof(phandle)))
 		return -EFAULT;
 
-- 
2.25.1

