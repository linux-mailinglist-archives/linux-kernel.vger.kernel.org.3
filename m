Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08C954C8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiFOMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiFOMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:39:56 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 358543F308
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aGlwT
        pJzDJp35gUCkFaGCu1AAXCT+U62kQKsYj5c2C0=; b=AwHCpk2FIq9EyzKxyneVF
        M7nmt8aQnX8yADa7h/+p5/aT2UJMOokEUN1KhwFBXsUhMGPvaHTqsgTcZrQ2MdPR
        Cy2Gb1LT8iOcQJyz7UKW22NhskkzOez5l4u9++EIlNCufHzy0AjFdgLDjn6MSdRk
        84GevR0IgsQwV7+31WHf9M=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowAAHmJ3w0qli+QOKDQ--.43766S2;
        Wed, 15 Jun 2022 20:39:13 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vireshk@kernel.org, shiraz.linux.kernel@gmail.com, soc@kernel.org,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-spear: Add missing of_node_put() in time.c
Date:   Wed, 15 Jun 2022 20:39:12 +0800
Message-Id: <20220615123912.3965902-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAHmJ3w0qli+QOKDQ--.43766S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3Gryxtr43tFy8AFWrXwb_yoWDXwc_GF
        1xWa9xGr40gF1Uua9rua1fGwsFyw15Cr4xWFyxZ3W7Kayjvr1UCF1kt3429ry7Zw4YgrW8
        tFWDCayayw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREyCGUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhIhF18RPTEOUgAAs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/mach-spear/time.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d1fdb6066f7b..a1b6635b4ecb 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -217,16 +217,20 @@ void __init spear_setup_of_timer(void)
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
+		of_node_put(np);
 		pr_err("%s: No irq passed for timer via DT\n", __func__);
 		return;
 	}
 
 	gpt_base = of_iomap(np, 0);
 	if (!gpt_base) {
+		of_node_put(np);
 		pr_err("%s: of iomap failed\n", __func__);
 		return;
 	}
-
+	
+	of_node_put(np);
+	
 	gpt_clk = clk_get_sys("gpt0", NULL);
 	if (IS_ERR(gpt_clk)) {
 		pr_err("%s:couldn't get clk for gpt\n", __func__);
-- 
2.25.1

