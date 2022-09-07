Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7425AFECC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIGIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:16:56 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1F7FE6F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:16:50 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id CJY00143;
        Wed, 07 Sep 2022 16:16:43 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.12; Wed, 7 Sep 2022 16:16:44 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <alistair@popple.id.au>,
        <eajames@linux.ibm.com>
CC:     <linux-fsi@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] fsi: check ida_simple_get() return value
Date:   Wed, 7 Sep 2022 04:16:42 -0400
Message-ID: <20220907081642.6599-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20229071616436611dd7efa7824043a16c52a6b2b427a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ida_simple_get() can fail, we should check the return value.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/fsi/fsi-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 0d11a17c53a0..c009c9b30ba1 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1313,7 +1313,10 @@ int fsi_master_register(struct fsi_master *master)
 	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
-	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
+	rc = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+	master->idx = rc;
 	dev_set_name(&master->dev, "fsi%d", master->idx);
 	master->dev.class = &fsi_master_class;
 
-- 
2.27.0

