Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB057D7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiGVAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:42:36 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900C91CD4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:42:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VK2qfq8_1658450552;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VK2qfq8_1658450552)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 08:42:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] LoongArch: Fix unsigned comparison with less than zero
Date:   Fri, 22 Jul 2022 08:42:31 +0800
Message-Id: <20220722004231.91114-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to get_timer_irq() is int, it can be
a negative error code, however this is being assigned to an
unsigned int variable 'irq', so making 'irq' an int.

Eliminate the following coccicheck warning:
./arch/loongarch/kernel/time.c:146:5-8: WARNING: Unsigned expression compared with zero: irq < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/loongarch/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 79dc5eddf504..786735dcc8d6 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -135,7 +135,7 @@ static int get_timer_irq(void)
 
 int constant_clockevent_init(void)
 {
-	unsigned int irq;
+	int irq;
 	unsigned int cpu = smp_processor_id();
 	unsigned long min_delta = 0x600;
 	unsigned long max_delta = (1UL << 48) - 1;
-- 
2.20.1.7.g153144c

