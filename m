Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FC54C7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiFOLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiFOLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:49:36 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C10D948331
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ugEks
        OHdiqvTpGzXbyzi14a59i2iFby4bXf0fShIeO4=; b=YXELok+h712YtIVfbzt2k
        FULzizJuNaCE7rrbV/kz+tdoMqz0YJL5h+F8YEJ8lrzIqBcmXaZGkPLgIQA6jwe9
        cG+vc5cHyy+rRWEfXtUxM27+7ZRwIjHr2Yk9XGVLZWQQcbR+eeYM3svZDfYn4cFs
        tT4i4eI/JPm4YOAvxHjlK4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgCHU0gdx6liftSeFg--.49947S2;
        Wed, 15 Jun 2022 19:48:45 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v3] arch: arm: mach-pxa: Add missing of_node_put in irq.c
Date:   Wed, 15 Jun 2022 19:48:44 +0800
Message-Id: <20220615114844.3964639-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCHU0gdx6liftSeFg--.49947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45XFW5WFWDuF18trWkWFg_yoW8Xrykpr
        Wj934Yyr18JF109ayqyay8Z390yFs7XF4jkFW0k3W7Jw4rA3yjya18K34fZ3W5GFW8Aa95
        AF1Fya48uayDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR3Ef7UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizh0hF18RPTDM4wAAsJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pxa_dt_irq_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put in
fail path or when it is not used anymore. This goto-label patch
style is advised by Daniel.

Signed-off-by: Liang He <windhl@126.com>
---
  changelog:
    v3: (1) use formal name (2) use -v N for format-patch (3) add
this changelog
    v2: use goto-label patch style advised by Daniel
    v1: add of_node_put in each fail path

 arch/arm/mach-pxa/irq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 96f33ef1d9ea..5d7dd307013e 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -247,13 +247,13 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 				   &pxa_internal_irq_nr);
 	if (ret) {
 		pr_err("Not found marvell,intc-nr-irqs property\n");
-		return;
+		goto out_put;
 	}
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
 		pr_err("No registers defined for node\n");
-		return;
+		goto out_put;
 	}
 	pxa_irq_base = io_p2v(res.start);
 
@@ -263,9 +263,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
 	if (ret < 0) {
 		pr_err("Failed to allocate IRQ numbers\n");
-		return;
+		goto out_put;
 	}
 
 	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
+	
+out_put:
+	of_node_put(node);
 }
 #endif /* CONFIG_OF */
-- 
2.25.1

