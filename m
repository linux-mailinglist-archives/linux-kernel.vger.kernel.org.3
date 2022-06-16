Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB954DE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiFPJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFPJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:31:03 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 176463BA67
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2oWt2
        H9WAPMkG7oNEcwGjV07/1fUD/DB+viS6p1c6Jk=; b=H3pJKR4G1hHrlcp3eV55r
        7JebDMoYFyjVJp7PgyFEEyDXeIy9SLFGoIQPPCLdvM7n9DupZorWREwv0aDIvtN1
        dw9tFegFegrIKw8b9/e4soxkYqR7W5cJyD/cbCXsbLRSeA7rRwhQsO8OWZnFQGJJ
        LlYcrovxoU6wvPE1hbhtsw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgAXNq41+KpiNnoVEw--.35290S2;
        Thu, 16 Jun 2022 17:30:30 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vireshk@kernel.org, shiraz.linux.kernel@gmail.com, soc@kernel.org,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] arm: mach-spear: Add missing of_node_put() in time.c
Date:   Thu, 16 Jun 2022 17:30:27 +0800
Message-Id: <20220616093027.3984903-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgAXNq41+KpiNnoVEw--.35290S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8uw1UJF13ArWUKFW3Jrb_yoW8Gr4xpr
        W7uwsYvr48G3srXr4vyFZ7uw1vy3WDGFs7Ca9YkFyDAFs7Aa4UJF4rKa4DAay5tF4kZayx
        Cw1ftF1fZ3WDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_ucMdUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QUiF1pEANb65QABsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spear_setup_of_timer(), of_find_matching_node() will return a
node pointer with refcount incrementd. We should use of_node_put()
in each fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 
 v2: use goto-label patch style suggested by Viresh.
 v1: use plain of_node_put in each fail path.

 arch/arm/mach-spear/time.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d1fdb6066f7b..c7c17c0f936c 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -218,13 +218,13 @@ void __init spear_setup_of_timer(void)
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		pr_err("%s: No irq passed for timer via DT\n", __func__);
-		return;
+		goto err_put_np;
 	}
 
 	gpt_base = of_iomap(np, 0);
 	if (!gpt_base) {
 		pr_err("%s: of iomap failed\n", __func__);
-		return;
+		goto err_put_np;
 	}
 
 	gpt_clk = clk_get_sys("gpt0", NULL);
@@ -239,6 +239,8 @@ void __init spear_setup_of_timer(void)
 		goto err_prepare_enable_clk;
 	}
 
+	of_node_put(np);
+
 	spear_clockevent_init(irq);
 	spear_clocksource_init();
 
@@ -248,4 +250,6 @@ void __init spear_setup_of_timer(void)
 	clk_put(gpt_clk);
 err_iomap:
 	iounmap(gpt_base);
+err_put_np:
+	of_node_put(np);
 }
-- 
2.25.1

