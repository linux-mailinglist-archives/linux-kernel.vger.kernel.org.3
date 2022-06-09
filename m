Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC2544357
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiFIFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiFIFzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:55:40 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C56141;
        Wed,  8 Jun 2022 22:55:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VFrDhR7_1654754134;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VFrDhR7_1654754134)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 13:55:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     conor.dooley@microchip.com, lewis.hanly@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] spi: fix platform_no_drv_owner.cocci warning
Date:   Thu,  9 Jun 2022 13:55:32 +0800
Message-Id: <20220609055533.95866-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove .owner field if calls are used which set it automatically.

Eliminate the following coccicheck warning:
./drivers/spi/spi-microchip-core.c:624:3-8: No need to set .owner here.
The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-microchip-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b2aee30fa04..3bd285dd4964 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -621,7 +621,6 @@ static struct platform_driver mchp_corespi_driver = {
 		.name = "microchip-corespi",
 		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
-		.owner = THIS_MODULE,
 	},
 	.remove = mchp_corespi_remove,
 };
-- 
2.20.1.7.g153144c

