Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAA4ED4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiCaHeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCaHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:34:15 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E041F2DCC;
        Thu, 31 Mar 2022 00:32:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2316432|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00797514-0.00208816-0.989937;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.NGpUuXy_1648711941;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.NGpUuXy_1648711941)
          by smtp.aliyun-inc.com(33.38.168.42);
          Thu, 31 Mar 2022 15:32:23 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, axboe@kernel.dk, adrian.hunter@intel.com,
        avri.altman@wdc.com, kch@nvidia.com, beanhuo@micron.com,
        swboyd@chromium.org, digetx@gmail.com, bigeasy@linutronix.de,
        CLoehle@hyperstone.com, cjb@laptop.org, arnd@arndb.de,
        andreiw@motorola.com, tgih.jun@samsung.com, jh80.chung@samsung.com,
        linus.walleij@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH v2] mmc: block: enable cache-flushing when mmc cache is on
Date:   Thu, 31 Mar 2022 15:32:23 +0800
Message-Id: <20220331073223.106415-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc core enables cache by default. But it only enables
cache-flushing when host supports cmd23 and eMMC supports
reliable-write.
For hosts which do not support cmd23 or eMMCs which do not support
reliable-write, the cache can not be flushed by `sync` command.
This may leads to cache data lost.
This patch enables cache-flushing as long as cache is enabled,
no matter host supports cmd23 and/or eMMC supports reliable write
or not.
For SD cards, backwards compatibility is guaranteed. Newer components
like SD5.0 which have cache are also supported in advance, which means
this patch will also be applicable if SD5.0 cache is added to the mmc
core in the future.

Fixes: f4c5522b0a88 ("mmc: Reliable write support.")
Fixes: 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device")
Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")
Fixes: d0c97cfb81eb ("mmc: core: Use CMD23 for multiblock transfers when we can.")
Fixes: e9d5c746246c ("mmc/block: switch to using blk_queue_write_cache()")

Reviewed-by: Avri Altman <Avri.Altman@wdc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/core/block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4e67c1403cc9..ec76ed82abb9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2350,6 +2350,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
+	bool cache_enabled = false;
+	bool fua_enabled = false;
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
@@ -2429,13 +2431,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 			md->flags |= MMC_BLK_CMD23;
 	}
 
-	if (mmc_card_mmc(card) &&
-	    md->flags & MMC_BLK_CMD23 &&
+	if (md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
 	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
-		blk_queue_write_cache(md->queue.queue, true, true);
+		fua_enabled = true;
+		cache_enabled = true;
 	}
+	if (mmc_cache_enabled(card->host))
+		cache_enabled  = true;
+
+	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
-- 
2.29.0

