Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990555DFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiF1CRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiF1CRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:17:07 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8DEB22BF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4TMOa
        laagtufXqneCE0TjllSga3ga0jXdfSKQ7YOa4M=; b=ULkMJZxbSLVoAmV6tHV4k
        6a1eJBt3JtOb6GtDfk1A5AiaNWST+2c3diBecX4Pa0orCsoS3TH1C7vlK6PZugcI
        JTs1objZB3s2CAcrDYq4mP5Lofey6DaIq9FyNmE1P2hXGeDXWH9OSQCImrdE/Q4X
        DB8/UP2SHSzCBJwxoDRmaE=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAHFbqJZLpi7Z+LFg--.557S2;
        Tue, 28 Jun 2022 10:16:42 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org,
        ckeepax@opensource.cirrus.com, michal.simek@xilinx.com,
        abhyuday.godhasara@xilinx.com, simont@opensource.cirrus.com,
        ronak.jain@xilinx.com, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org
Cc:     windhl@126.com
Subject: [PATCH v2] firmware: Hold a reference for of_find_compatible_node()
Date:   Tue, 28 Jun 2022 10:16:40 +0800
Message-Id: <20220628021640.4015-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAHFbqJZLpi7Z+LFg--.557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF43urW3Cw1xGr1DAFWfAFb_yoW8Gw18pF
        n5uFWrAFWxX3s7Ary8CF4fZFySgF4rKF4UGryUWwn7tr1DJF1ktFW2qrWYyF1vvFW8Cr15
        WF9Fgw4jga4IyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziF1vfUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgouF18RPY7kSAAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_register_trusted_foundations(), we need to hold the reference
returned by of_find_compatible_node() and then use it to call
of_node_put() for refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 v2: use 'check-and-put' coding style
 v1: hold ref returned by of_find_xxx
 
 v1 link: https://lore.kernel.org/all/20220621032625.4078445-1-windhl@126.com/



 include/linux/firmware/trusted_foundations.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/firmware/trusted_foundations.h b/include/linux/firmware/trusted_foundations.h
index be5984bda592..931b6c5c72df 100644
--- a/include/linux/firmware/trusted_foundations.h
+++ b/include/linux/firmware/trusted_foundations.h
@@ -71,12 +71,16 @@ static inline void register_trusted_foundations(
 
 static inline void of_register_trusted_foundations(void)
 {
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
+
+	if (!np)
+		return;
+	of_node_put(np);
 	/*
 	 * If we find the target should enable TF but does not support it,
 	 * fail as the system won't be able to do much anyway
 	 */
-	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
-		register_trusted_foundations(NULL);
+	register_trusted_foundations(NULL);
 }
 
 static inline bool trusted_foundations_registered(void)
-- 
2.25.1

