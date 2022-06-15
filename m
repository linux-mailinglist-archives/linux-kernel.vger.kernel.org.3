Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6954C37B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiFOIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiFOIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:30:16 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D26543D1D1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6XYTK
        65YYA041u3n47xiUBJnCEL7R1gjEAopSqJFnTU=; b=h5G4RUJqKu0pON261uWGi
        nWk+hINyCYlYXaYqqdry/9XFQgc7X3V6PNv/Ax6ZlWUWPZW/YlYk88ozQr+UQYZP
        gYzw3dRP8eOw5+7l/+VD7GIAnOS1s3VjWiKQWiOo+H1yDJ6ZtqGfleoaiLFLtHkl
        hqmgCtUIcIcrT9Bx3ZDmI4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAB3fSl0mKlip6ubEQ--.52717S2;
        Wed, 15 Jun 2022 16:29:45 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linus.walleij@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] drivers: clk: Add missing of_node_put() in clk-nomadik.c
Date:   Wed, 15 Jun 2022 16:29:40 +0800
Message-Id: <20220615082940.3960612-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAB3fSl0mKlip6ubEQ--.52717S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1fKFW7Jr4UZF4UGFWUtwb_yoWDJrbEqF
        1fWrsrCFW29F4kurW2vF1fG3y5u3Z5uFs3X3Wxt3W3A34jvF4UCF4avFs3Xw1UWrW2gFy7
        XFnrKF4UArWj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREq2M7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhkhF18RPS+kqAAAsx
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

Signed-off-by: heliang <windhl@126.com>
---
 drivers/clk/clk-nomadik.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index bad2677e11ae..b3b8855d8890 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -97,6 +97,7 @@ static void __init nomadik_src_init(void)
 	}
 	src_base = of_iomap(np, 0);
 	if (!src_base) {
+		of_node_put(np);
 		pr_err("%s: must have src parent node with REGS (%pOFn)\n",
 		       __func__, np);
 		return;
@@ -130,6 +131,7 @@ static void __init nomadik_src_init(void)
 		val &= ~SRC_XTALCR_MXTALEN;
 		pr_info("disabling MXTALO\n");
 	}
+	of_node_put(np);
 	writel(val, src_base + SRC_XTALCR);
 	register_reboot_notifier(&nomadik_clk_reboot_notifier);
 }
-- 
2.25.1

