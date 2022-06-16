Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B754D7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358024AbiFPCBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbiFPCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:01:48 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797205933D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Atn7
        fZcqnvSgGIlwBuPlL0MZEzYhI5kcoueR1+mD/o=; b=nUI9OGAV7FLPRLIz8jaYc
        9+LZ+XwiDZL7mv+zByXaU2bv1Sc/cMI5YbxCsAb+iBAiXz5Ciig/hHNIi+mxrhlt
        zwl/jzH4ZlNjYG2w3e2BtrgCiQh5Mn6S96EirAHYrQwgpZr9DRYwSJ6d6EZox5r8
        T/IuYKXE6DAn+2mtqaddqs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAX9loBj6piLpPcFg--.13778S2;
        Thu, 16 Jun 2022 10:01:39 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     pali@kernel.org, lpieralisi@kernel.org
Cc:     windhl@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bus: (mvebu-mbus) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 10:01:35 +0800
Message-Id: <20220616020135.3973141-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAX9loBj6piLpPcFg--.13778S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr18Cw4xAFy7uw48KrW3Jrb_yoW8ur18pa
        y7WrW3try0qr4fJFZayryfZFyakFn7WFWjqFsFkFnrAanxGry5Jry2kryrAF98AFW09w15
        tr10ya1xWF9rAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoSotUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAgiF2JVj4ze6AABsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mvebu_mbus_dt_init(), of_find_matching_node_and_match() and
of_find_node_by_phandle() will both return node pointers with
refcount incremented. We should use of_node_put() in fail path
or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

  v2: (1) use real name (2) add of_node_put when not used anymore

  v1: add of_node_put in fail path


 drivers/bus/mvebu-mbus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index db612045616f..e168c8de2ae8 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -1327,22 +1327,28 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 
 	prop = of_get_property(np, "controller", NULL);
 	if (!prop) {
+		of_node_put(np);
 		pr_err("required 'controller' property missing\n");
 		return -EINVAL;
 	}
 
 	controller = of_find_node_by_phandle(be32_to_cpup(prop));
 	if (!controller) {
+		of_node_put(np);
 		pr_err("could not find an 'mbus-controller' node\n");
 		return -ENODEV;
 	}
 
 	if (of_address_to_resource(controller, 0, &mbuswins_res)) {
+		of_node_put(np);
+		of_node_put(controller);
 		pr_err("cannot get MBUS register address\n");
 		return -EINVAL;
 	}
 
 	if (of_address_to_resource(controller, 1, &sdramwins_res)) {
+		of_node_put(np);
+		of_node_put(controller);
 		pr_err("cannot get SDRAM register address\n");
 		return -EINVAL;
 	}
@@ -1360,6 +1366,8 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 			pr_warn(FW_WARN "deprecated mbus-mvebu Device Tree, suspend/resume will not work\n");
 	}
 
+	of_node_put(controller);	
+
 	mbus_state.hw_io_coherency = is_coherent;
 
 	/* Get optional pcie-{mem,io}-aperture properties */
@@ -1378,6 +1386,11 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 		return ret;
 
 	/* Setup statically declared windows in the DT */
-	return mbus_dt_setup(&mbus_state, np);
+	ret = mbus_dt_setup(&mbus_state, np);
+
+	of_node_put(np);
+	
+	return ret;
+
 }
 #endif
-- 
2.25.1

