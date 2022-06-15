Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19BC54C2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiFOHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiFOHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:55:03 -0400
X-Greylist: delayed 1833 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 00:54:55 PDT
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E3D483AE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=87keS
        6uBfC+apPlQLJjIZduN5M2vxYxrur70owcFKC8=; b=UDpocjkK4sVBDsZgmtVKH
        17U1gXLYVAz/4vezd8EGpUPe8K19QhcJh53FeEnzJ5382lV6jYtOTsQxw3dX5mnN
        wZ05Xp21HZjRi84eQnCVf0CN+LGIO5pAAgjxsQ4mEAriIMTmMSLijCfy1Xss35G4
        t3DlWibgivJ86MCvF7+eZs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAAXWvkYialip3paDQ--.36376S2;
        Wed, 15 Jun 2022 15:24:09 +0800 (CST)
From:   heliang <windhl@126.com>
To:     lpieralisi@kernel.org, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] bus: mvebu-mbus: Add missing of_node_put in fail path
Date:   Wed, 15 Jun 2022 15:24:07 +0800
Message-Id: <20220615072407.3959470-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAAXWvkYialip3paDQ--.36376S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW8Gw43tF4UKr47JFyrWFg_yoW8Jw18pF
        W7WrWayry0qr4fXFsYy343WFW3KFn7WrWq9FsFk3ZxAa13XFyUJ3y7C34rZF95AFyF9w15
        tr1Uta1xWF97JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UY_MfUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hkhF1uwMNN+PwAAs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mvebu_mbus_dt_init, of_find_matching_node_and_match() and
of_find_node_by_phandle() will return node pointer with refcounter
incremented. We should use of_node_put in fail path.

Signed-off-by: heliang <windhl@126.com>
---
 drivers/bus/mvebu-mbus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index db612045616f..7b16ede5097f 100644
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
-- 
2.25.1

