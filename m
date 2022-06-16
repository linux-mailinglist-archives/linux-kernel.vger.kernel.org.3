Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8FA54D8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358267AbiFPDZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiFPDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:25:10 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDFE82F669
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mkfgB
        VBFBgrdtGMDaUnf029gNd3JieIaFgdH3qOE0Pg=; b=B/vp724jl7RCqMtXoVPA5
        OVySZPHKLhdjrTSV2ZVG21Gu7XOIDE3MbIm6v7jDwwFdNx5w73HN4F1Z0jMAVEMp
        SG0mkgiC4kPNaPHKR7MbKLdbqZaI7fxblUWr4wP1MMGJKfDHoDALLlM1rpO1o50r
        9rgxI2wsK7Jcs/80199H88=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDn8baBoqpiZehnEw--.25236S2;
        Thu, 16 Jun 2022 11:24:50 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH v2] drivers: clk: (clk-nomadik) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:24:48 +0800
Message-Id: <20220616032448.3974916-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDn8baBoqpiZehnEw--.25236S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKw4UJryDKFW5CrWDtwb_yoWkGFb_XF
        4rWrnrCFW2kF47ur4jvF13K3ya9Fn5ur4xZ3Wxt3W3Ja42vF47Ca12vFsIgw1UWrW2gFy2
        vrsrGr4ayr4UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREKsj7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QIiF1pEANS6OQAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nomadik_src_init, of_find_matching_node() return a node pointer
with refcount incremented. We should use of_node_put() in fail path
or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog: 

 v2: (1) use real name for Sob (2) use goto-label patch style
     (3) use proper subject title
 v1: use two of_node_put() in fail path and normal-return

 drivers/clk/clk-nomadik.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index bad2677e11ae..48d5772b36a5 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -99,7 +99,7 @@ static void __init nomadik_src_init(void)
 	if (!src_base) {
 		pr_err("%s: must have src parent node with REGS (%pOFn)\n",
 		       __func__, np);
-		return;
+		goto out_put;
 	}
 
 	/* Set all timers to use the 2.4 MHz TIMCLK */
@@ -132,6 +132,9 @@ static void __init nomadik_src_init(void)
 	}
 	writel(val, src_base + SRC_XTALCR);
 	register_reboot_notifier(&nomadik_clk_reboot_notifier);
+	
+output:
+    of_node_put(np);	
 }
 
 /**
-- 
2.25.1

