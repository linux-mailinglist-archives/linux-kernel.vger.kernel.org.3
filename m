Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049915529C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiFUD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:27:43 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8452517AB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GzVgp
        sAUqnpJ4ghJLSX1HCwiVWXy7WhXVh4xCTWMQWw=; b=mON60WB+BgXpYxZnoMQ9B
        Ry5aKo/xTKKsUzNFtava1WkFeNkmSnlskuRRTDxeM5GP52uyWsyYTW01XuGd9NIs
        vKnwBAiRJew85bRx0q2yuo26g2eEUK4+ETTPgKwoRNuC7+7MWatKKpG/TOATunSw
        qOqF+tfJhctaLSysTvhGms=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgAHboJiOrFinEUwFA--.34259S2;
        Tue, 21 Jun 2022 11:26:28 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org,
        ckeepax@opensource.cirrus.com, michal.simek@xilinx.com,
        abhyuday.godhasara@xilinx.com, simont@opensource.cirrus.com,
        ronak.jain@xilinx.com, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org
Cc:     Liang He <windhl@126.com>
Subject: [PATCH] firmware: Hold a reference for of_find_compatible_node()
Date:   Tue, 21 Jun 2022 11:26:25 +0800
Message-Id: <20220621032625.4078445-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgAHboJiOrFinEUwFA--.34259S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw47Zw1rZr1xGryrGFW7Arb_yoW8JF1rpF
        n5uayrAayxX3s7ArykCFsayFyfWF4rGF4UGFWUWwn7tr1DJF1ktFW2qFWYyF1vvFW8Ar15
        WFyUWw1jga42yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziF1vfUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAQnF2JVj9yzfwAAsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/firmware/trusted_foundations.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/firmware/trusted_foundations.h b/include/linux/firmware/trusted_foundations.h
index be5984bda592..399471c2f1c7 100644
--- a/include/linux/firmware/trusted_foundations.h
+++ b/include/linux/firmware/trusted_foundations.h
@@ -71,12 +71,16 @@ static inline void register_trusted_foundations(
 
 static inline void of_register_trusted_foundations(void)
 {
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
+
+	of_node_put(np);
+	if (!np)
+		return;
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

