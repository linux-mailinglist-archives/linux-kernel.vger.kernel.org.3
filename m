Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2B4D6C77
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCLEo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 23:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLEoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 23:44:25 -0500
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741961FF41C;
        Fri, 11 Mar 2022 20:43:18 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1887753|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00849406-0.00236518-0.989141;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.N2bFkqv_1647060194;
Received: from sunxibot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.N2bFkqv_1647060194)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sat, 12 Mar 2022 12:43:15 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org (maintainer:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...,commit_signer:11/9=100%,authored:4/9=44% 
        ,added_lines:26/61=43%,removed_lines:25/35=71%),
        adrian.hunter@intel.com (commit_signer:3/9=33%,authored:4/9=44% 
        ,added_lines:26/61=43%,removed_lines:25/35=71%),
        avri.altman@wdc.com (commit_signer:2/9=22%,authored:4/9=44% 
        ,authored:2/9=22%,added_lines:26/61=43%,added_lines:16/61=26% 
        ,removed_lines:25/35=71%),
        beanhuo@micron.com (commit_signer:1/9=11%,authored:4/9=44% 
        ,authored:1/9=11%,added_lines:26/61=43%,removed_lines:25/35=71%),
        porzio@gmail.com (commit_signer:1/9=11%,authored:4/9=44% 
        ,authored:1/9=11%,added_lines:26/61=43%,added_lines:4/61=7% 
        ,removed_lines:25/35=71%,removed_lines:3/35=9%),
        michael@allwinnertech.com (authored:1/9=11%,added_lines:26/61=43% 
        ,added_lines:14/61=23%,removed_lines:25/35=71%,removed_lines:6/35=17%)
Cc:     Michael Wu <michael@allwinnertech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Luca Porzio <porzio@gmail.com>,
        lixiang <lixiang@allwinnertech.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Date:   Sat, 12 Mar 2022 12:43:13 +0800
Message-Id: <20220312044315.7994-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc core enable cache on default. But it only enables cache-flushing
when host supports cmd23 and eMMC supports reliable write.
For hosts which do not support cmd23 or eMMCs which do not support
reliable write, the cache can not be flushed by `sync` command.
This may leads to cache data lost.
This patch enables cache-flushing as long as cache is enabled, no
matter host supports cmd23 and/or eMMC supports reliable write or not.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/core/block.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..1e508c079c1e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2279,6 +2279,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
+	bool enable_cache = false;
+	bool enable_fua = false;
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
@@ -2375,12 +2377,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 			md->flags |= MMC_BLK_CMD23;
 	}
 
-	if (mmc_card_mmc(card) &&
-	    md->flags & MMC_BLK_CMD23 &&
-	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
-	     card->ext_csd.rel_sectors)) {
-		md->flags |= MMC_BLK_REL_WR;
-		blk_queue_write_cache(md->queue.queue, true, true);
+	if (mmc_card_mmc(card)) {
+		if (md->flags & MMC_BLK_CMD23 &&
+			((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
+			card->ext_csd.rel_sectors)) {
+			md->flags |= MMC_BLK_REL_WR;
+			enable_fua = true;
+		}
+
+		if (mmc_cache_enabled(card->host))
+			enable_cache = true;
+
+		blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);
 	}
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
-- 
2.29.0

