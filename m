Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0F54EFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379871AbiFQC4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379728AbiFQC4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:56:23 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EDF6E0BC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aTdIn
        RxfYkL/Bf5dwKSX31T/KQuPHI8eY4IcEkq32c0=; b=VpXeBlUCkhJHeIM2UKbYy
        wTyuLZ1ioa2FRgveEu1GuCa1oUxfjpfHuiawM7hrZHyAkEg80OwvEzVPqVTV6cUl
        wXKasa4D01DiBBEvVsNZZIx7RPq5UGDetKhh2BFePb07iQYE+RPg7s0wW92Bl/pL
        F/2gvA7trHZvyhCswqdDHY=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAB3U9wL7atieDncEg--.18233S2;
        Fri, 17 Jun 2022 10:55:13 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     lpieralisi@kernel.org, pali@kernel.org,
        christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH v3] bus: mvebu-mbus: Add missing of_node_put()
Date:   Fri, 17 Jun 2022 10:55:07 +0800
Message-Id: <20220617025507.4002557-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAB3U9wL7atieDncEg--.18233S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr18Cw47AFyDtr4kWFW7Jwb_yoW8ZFy7pF
        W7Wr43try0qrWfJFZaka4xua4YkFn7WFWUXa9rCwn3AF13AayYvrWFyFyrZFZ8AFW09w1Y
        yw1jy3WxuasrAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pENtxnUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIjF1pEDvLfOgAAs9
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
 v3: (1) use goto-label patch style (2) fix v2 error reported by CJ 
 v2: (1) use real name (2) add of_node_put when not used anymore
 v1: add of_node_put in fail path

 drivers/bus/mvebu-mbus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index db612045616f..739f850cfcf1 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -1328,23 +1328,27 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 	prop = of_get_property(np, "controller", NULL);
 	if (!prop) {
 		pr_err("required 'controller' property missing\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_np_put;
 	}
 
 	controller = of_find_node_by_phandle(be32_to_cpup(prop));
 	if (!controller) {
 		pr_err("could not find an 'mbus-controller' node\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_np_put;
 	}
 
 	if (of_address_to_resource(controller, 0, &mbuswins_res)) {
 		pr_err("cannot get MBUS register address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_controller_put;
 	}
 
 	if (of_address_to_resource(controller, 1, &sdramwins_res)) {
 		pr_err("cannot get SDRAM register address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_controller_put;
 	}
 
 	/*
@@ -1375,9 +1379,16 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 				     resource_size(&mbusbridge_res),
 				     is_coherent);
 	if (ret)
-		return ret;
+		goto err_controller_put;
 
 	/* Setup statically declared windows in the DT */
-	return mbus_dt_setup(&mbus_state, np);
+	ret = mbus_dt_setup(&mbus_state, np);
+
+err_controller_put:
+	of_node_put(controller);
+err_np_put:
+	of_node_put(np);
+
+	return ret;
 }
 #endif
-- 
2.25.1

