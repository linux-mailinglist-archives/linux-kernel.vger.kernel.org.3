Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9415540F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356599AbiFVDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFVDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:42:51 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A1502FFD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OblDE
        bI6Vnx4aX5Y3rFJGJS4W15Uyfu6AFvbUOpbMY0=; b=UJVERuCkH6x66NmbsDoNW
        NR5kWvbcGtaiGMIH0q0IOAvJVXVygYZ0C8uEEArbPCV32M3qXhQTUxlG7LIYNDwb
        IEL0vL6Nuey2m0bMhBvlu9bz4rYMkWB6bJBB8j9kzMTt502LB3bbEz1SV0WI+R3y
        uCn+qJ7bnExjfNdpNHGzjc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowABnbzetj7Ji_HVhFA--.33457S2;
        Wed, 22 Jun 2022 11:42:39 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     zbr@ioremap.net, windhl@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] w1: Add missing of_node_put() and of_node_get()
Date:   Wed, 22 Jun 2022 11:42:38 +0800
Message-Id: <20220622034238.4093806-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowABnbzetj7Ji_HVhFA--.33457S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW7tF18tryxJry7Aw1DKFg_yoWktwc_Cr
        1ruF9rXr47Gw4kZ3ZagFsxu397WrsFgrsrWF1IqF97u34YqrsFgrs8ZryDJ3yUu3yxJFWa
        krsxGrZ0yr4IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMUDJDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhAoF18RPWNc6gAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __w1_attach_slave_device(), we need to add the of_node_put() for
the reference returned by of_find_matching_node() in fail path.

Besides, we will also need a of_node_get() for the first argument of
of_find_matching_node() which will decrease its refcount.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: add missing put and get
 v1: only add missing put

 drivers/w1/w1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..378996d947cc 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -680,6 +680,8 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 	sl->dev.groups = w1_slave_groups;
+
+	of_node_get(sl->master->dev.of_node);
 	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
 						sl->family->of_match_table);
 
@@ -702,6 +704,7 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 		dev_err(&sl->dev,
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
+		of_node_put(sl->dev.of_node);
 		put_device(&sl->dev);
 		return err;
 	}
-- 
2.25.1

