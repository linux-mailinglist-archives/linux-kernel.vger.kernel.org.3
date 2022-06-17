Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8654EEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiFQBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379789AbiFQBnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:43:37 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D1926541;
        Thu, 16 Jun 2022 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DI+WC
        bTryVSUwE4AJeh6OWVzHOzOvSO0HxklZbRyl3k=; b=dva0AQ1IFaf7I2q4kud7S
        wZutFVLuDWFe+CChYT+e4kN5FGaxFNlNXk7LMp7pkiE7/A8JHAvE/nyfftt3KKcA
        j1OVb8lBo9icRYznJ7UoK7HXDnKGAqlJyRsHHuFzeRv43rh/o0ob5TE4lzjnqxHR
        76j5YTWffQmgw6pxY9TYwM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgBHTpot3Ktio_HDEw--.8636S2;
        Fri, 17 Jun 2022 09:43:10 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] clk: nomadik: Add missing of_node_put()
Date:   Fri, 17 Jun 2022 09:43:08 +0800
Message-Id: <20220617014308.4001511-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgBHTpot3Ktio_HDEw--.8636S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryDJF17trb_yoWkAFb_WF
        4rWrnrCFW2kF4kur4jvF13u39I9r1rur4xX3Wxt3W3J342vF1DGFsFvFs3uw1UWrW2gry7
        ZFsrKr4jyrWj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibyZUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizg4jF18RPTzJKAAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nomadik_src_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 v4: split v3 into nmadik and tegra
 v3: merge clk 'missing of_node_put()' patches into one commit.
 v2: use Liang He as real name for S-o-b.
 v1: fix the missing of_node_put().
 
 drivers/clk/clk-nomadik.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index bad2677e11ae..71fbe687fa7b 100644
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
+out_put:
+	of_node_put(np);
 }
 
 /**
-- 
2.25.1

