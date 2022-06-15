Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D054C928
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiFOMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiFOMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:52:02 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 484E62AE28;
        Wed, 15 Jun 2022 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o/uSO
        7xwMw4EWmWjL/U5fM0M1YDyMNo/GHzEpChY0v4=; b=OxNZxuwS/5jG1kcovY291
        2ywGSvMe9cD9cbA1fhpCjv0zXOfZHSp7lCwyNbqBUgfoZZpnYuNND6WDZXwwIcqj
        1e7rGvCxQ6wlI03EPxqXm4OeGvcbS6B0rVHP2SIK0VIcmQ1pFpmpsltL9onvSPDS
        IfPPVTV5uCGI7XBAkCTex4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowABH5pe51aliopuKDQ--.43463S2;
        Wed, 15 Jun 2022 20:51:06 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] drivers: w1: Add missing of_node_put() in w1.c
Date:   Wed, 15 Jun 2022 20:51:05 +0800
Message-Id: <20220615125105.3966317-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowABH5pe51aliopuKDQ--.43463S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw17KFyUWF43tF15trW8WFg_yoWxuFg_Cr
        yruFnrXFsYkr4kJF9xWF13ZryrurnFgr4xuF10qa93C34Yqr1fW34DZr1Uta47urZ2kFZI
        yF9xWrZ0yr4F9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_5l1JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgYhF1-HZTacMgABsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __w1_attach_slave_device, we really need not to use of_node_put
in normal path as the reference is escaped by sl. However, we need
of_node_put in the fail path before put_device.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/w1/w1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..44a0587105a8 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -702,6 +702,7 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 		dev_err(&sl->dev,
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
+		of_node_put(sl->dev.of_node);			
 		put_device(&sl->dev);
 		return err;
 	}
-- 
2.25.1

