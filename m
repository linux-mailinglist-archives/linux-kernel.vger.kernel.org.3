Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93D550924
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiFSHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiFSHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:30:42 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E59FB1FD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B1gcf
        g6uWh2Ydy18lGJ3Uf96MEQ9OMrXAXzfxSAidlQ=; b=NS7T67PfHb3EfxrOk4hKM
        yiY3bYY7uhsTCxBQF0RnCkNcSGjfCKAcybHhfbD1Omw635Ffs10cOe1CfX6kS+oa
        hI//73I0bIlfqXc6Z9cHMHutTnnMZOtFM8NWzBQpyTO7Bg32wyo5FpO9bzsCVBTS
        56avT8vTqgcIGFE6OsRWZU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgBHEcad0K5iLak4FA--.119S2;
        Sun, 19 Jun 2022 15:30:37 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     dmitry.torokhov@gmail.com
Cc:     windhl@126.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] input/serio: Fix refcount leak bug in i8042-sparcio
Date:   Sun, 19 Jun 2022 15:30:36 +0800
Message-Id: <20220619073036.4067872-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgBHEcad0K5iLak4FA--.119S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWkCrW7JFW3Cw4fJF1UZFb_yoWkZrX_ur
        Wkur97JFWkC3Zay3Z2yr4Sq390yw4vgayFqrySqr4a9a4ayr9xtryrZr97Aw47Wr9avryj
        krsxGrWFkw4UCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUkhL7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7R0lF1pEAOvxsgAAs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i8042_platform_init() and i8042_platform_exit(), we need call
of_node_put() to keep refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/input/serio/i8042-sparcio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index fce76812843b..a2a9db9220d7 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -108,6 +108,8 @@ static int __init i8042_platform_init(void)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *name = of_get_property(root, "name", NULL);
 
+	of_node_put(root);
+
 	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
@@ -139,6 +141,8 @@ static inline void i8042_platform_exit(void)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *name = of_get_property(root, "name", NULL);
 
+	of_node_put(root);
+
 	if (!name || strcmp(name, "SUNW,JavaStation-1"))
 		platform_driver_unregister(&sparc_i8042_driver);
 }
-- 
2.25.1

