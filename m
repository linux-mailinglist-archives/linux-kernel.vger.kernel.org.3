Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C265520D64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiEJF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiEJF7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:59:23 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491D266F34;
        Mon,  9 May 2022 22:55:26 -0700 (PDT)
X-UUID: 84347a7a319042fa9812bdcc02531991-20220510
X-UUID: 84347a7a319042fa9812bdcc02531991-20220510
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 937845475; Tue, 10 May 2022 13:58:44 +0800
X-ns-mid: postfix-6279FE4C-2811404153
Received: from localhost.localdomain (unknown [172.30.60.211])
        by cs2c.com.cn (NSMail) with ESMTPSA id 3C244383E604;
        Tue, 10 May 2022 05:55:24 +0000 (UTC)
From:   Haoran Jiang <jianghaoran@kylinos.cn>
To:     chenhuacai@kernel.org
Cc:     jiaxun.yang@flygoat.com, tglx@linutronix.de, maz@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianghaoran@kylinos.cn
Subject: [PATCH] irqchip/loongson-liointc: 4 cores correspond to different interrupt status registers
Date:   Tue, 10 May 2022 13:53:03 +0800
Message-Id: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the loongson cpu manual,different cpu cores
correspond to different interrupt status registers

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 649c58391618..f4e015b50af0 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -195,7 +195,7 @@ static int __init liointc_of_init(struct device_node *node,
 		}
 
 		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
+			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS + i*8;
 	}
 
 	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
-- 
2.25.1

