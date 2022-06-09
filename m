Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EE54448C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiFIHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiFIHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:12:58 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160E2428ED;
        Thu,  9 Jun 2022 00:12:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VFrcIPJ_1654758771;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VFrcIPJ_1654758771)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 15:12:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     andi@etezian.org, broonie@kernel.org, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] spi: Return true/false (not 1/0) from bool function
Date:   Thu,  9 Jun 2022 15:12:50 +0800
Message-Id: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
function.

As reported by coccicheck:
./drivers/spi/spi-s3c64xx.c:385:9-10: WARNING: return of 0/1 in function
's3c64xx_spi_can_dma' with return type bool

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 82558e37c735..28e7b7cb68a7 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -382,7 +382,7 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 	} else {
-		return 0;
+		return false;
 	}
 
 }
-- 
2.20.1.7.g153144c

