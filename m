Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE444F7AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiDGJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiDGJDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:03:25 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F252E78;
        Thu,  7 Apr 2022 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649322080;
        bh=Z9pMcqz9PcDTm7oWvk9GqY4NaqgI4eR0toGt5vtlbW4=;
        h=From:To:Cc:Subject:Date;
        b=haIP9U+GA29bAgfGUyTWqmPbnOF9FxzvVPxJnuRs1gbBwCzrcF4inxO3IZOFeP29I
         p2S/iXORSgM/woOB+3QA4B5wHQ6lSN+S0sBJhJjAXAESEoLOXd85bNPgfp+QkQlL4u
         pOFGGFsEGtCL/ZjsVuDfhuAY8prm0WZY6z4xRjq0=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 50B1A45; Thu, 07 Apr 2022 17:01:16 +0800
X-QQ-mid: xmsmtpt1649322076tfjkopifx
Message-ID: <tencent_BD8B1CF914FDE1104AFDFFEA200DCC0EB908@qq.com>
X-QQ-XMAILINFO: MOwr6TNsEdeBxNTJKWZPE4J5SMyu2l167fUiO/OWz+5vIbAc87uSegMPpk0cbb
         7iIF/BI5MZ5Dj9Uu01oqG/6M0XIq8HPTYij1IcuIdlArPBN41hUzcj5V6D1pVjl0LhmZvjVQMev1
         1tOSe8qT0ruG7t+WScxEXrfGDujvpbCqhcTrK3mGg1UQw9gq6Zpn6bcMzDJyc90t5Sr+jKau0yq7
         Q2T/p6sr7jw8A86xlaQxjwV1Vrhmv6ZUd9Te0i9h5BM3pWZxX1r0EEEPC8D+yiTkCXwMA4O4lHOG
         Pq5J0hm/r3fKGDbZV0U9tlMBcisEmeEhs0yr/K7asDwphayN0mIawe/5WUfLqIr8gyqfeI+67SQK
         vBbA7/YwkWkjzJRJqgUUIQOypSu3nMibAv1pq0vGQjMVrr37RvlJPGRQ3Z61h5BjSBDjQ+/ygsUG
         98lgqHsjLFEpoHRos6Z8oAJGU5Vj4eXmM7Vdcv/OQyIerVlo6VAYFx42tPQR3JKzE0ZM0gHAnNoH
         HPOOt30/qCFSwOE5hAF3r3F57IAhDVxJSOyfa+Cap2cYo0IZ6p6dgATlCLCx0mgPfVWX4tfbwpCN
         SX8fRlsNzOzecg8vSpgpBLPXb3/t9Jcr4/HrG10W51k7Fp6sXyhA6MYM6Mqg2x6ap19JljxMy0SI
         wDkb9xiI3JMOxB0tK6FxODYEUjhgbQ3wPc7CaG/BJWp69RhDCFbdCBY1SR9TaKP2ttj1TBIc2tZC
         r1ESZ5bB7c4A4yGXQBFFgFThJUecqQPHEgrfDVvapvCgCJlpa6Oc0b8+LFdYN6qc/xzeXTFY67dp
         aiF1FZuEb5XCtNt2PF9Nhv+Ito1RJT/4PEoFR9xRazUqqLNZyrFUma7tKndCjRna4XX0ok1amIZX
         DvpoLRiOdUYXGpLBZbv8h4ugRwmm/qmVKTFmO98jhnyAmd6wWKF5z+LWWQY8JbtgxEns1dch35
From:   xkernel.wang@foxmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] clk: mmp: pxa168: fix potential memory leaks in pxa168_clk_init()
Date:   Thu,  7 Apr 2022 17:01:05 +0800
X-OQ-MSGID: <20220407090105.14361-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In pxa168_clk_init(), except for the first error path, the other error
paths directly return without releasing the allocated resources, which
can lead to memory leaks.

This patch unifies the error handling code and each error will jump to
the corresponding tag to release the resources.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/clk/mmp/clk-of-pxa168.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02..05b96cf 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,19 +258,19 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
-		return;
+		goto free_memory;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
-		return;
+		goto unmap_mpmu_region;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
-		return;
+		goto unmap_apmu_region;
 	}
 
 	mmp_clk_init(np, &pxa_unit->unit, PXA168_NR_CLKS);
@@ -282,6 +282,15 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa168_axi_periph_clk_init(pxa_unit);
 
 	pxa168_clk_reset_init(np, pxa_unit);
+
+	return;
+
+unmap_apmu_region:
+	iounmap(pxa_unit->apmu_base);
+unmap_mpmu_region:
+	iounmap(pxa_unit->mpmu_base);
+free_memory:
+	kfree(pxa_unit);
 }
 
 CLK_OF_DECLARE(pxa168_clk, "marvell,pxa168-clock", pxa168_clk_init);
-- 
