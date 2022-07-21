Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7157D58D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiGUVHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGUVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:07:40 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 14:07:39 PDT
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E351904C6;
        Thu, 21 Jul 2022 14:07:39 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdOT-001tMd-0R;
        Thu, 21 Jul 2022 22:07:37 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] power: supply: bq27xxx: fix __be16 warnings
Date:   Thu, 21 Jul 2022 22:07:35 +0100
Message-Id: <20220721210735.451138-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bq27xxx_dm_reg_ptr() should return a __be16 as the result
is being passed to be16_to_cpup() to convert to the proper
cpu endian value. Move to using __be16 as appropriate to fix
the following sparse warnings:

drivers/power/supply/bq27xxx_battery.c:1293:26: warning: incorrect type in argument 1 (different base types)
drivers/power/supply/bq27xxx_battery.c:1293:26:    expected restricted __be16 const [usertype] *p
drivers/power/supply/bq27xxx_battery.c:1293:26:    got unsigned short [usertype] *prev
drivers/power/supply/bq27xxx_battery.c:1304:17: warning: incorrect type in argument 1 (different base types)
drivers/power/supply/bq27xxx_battery.c:1304:17:    expected restricted __be16 const [usertype] *p
drivers/power/supply/bq27xxx_battery.c:1304:17:    got unsigned short [usertype] *prev
drivers/power/supply/bq27xxx_battery.c:1316:15: warning: incorrect type in assignment (different base types)
drivers/power/supply/bq27xxx_battery.c:1316:15:    expected unsigned short [usertype]
drivers/power/supply/bq27xxx_battery.c:1316:15:    got restricted __be16 [usertype]

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/power/supply/bq27xxx_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index dccc2683455a..8bf048fbd36a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1044,12 +1044,12 @@ struct bq27xxx_dm_buf {
 	.block = (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
 }
 
-static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
+static inline __be16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
 				      struct bq27xxx_dm_reg *reg)
 {
 	if (buf->class == reg->subclass_id &&
 	    buf->block == reg->offset / BQ27XXX_DM_SZ)
-		return (u16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
+		return (__be16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
 
 	return NULL;
 }
@@ -1275,7 +1275,7 @@ static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
 {
 	struct bq27xxx_dm_reg *reg = &di->dm_regs[reg_id];
 	const char *str = bq27xxx_dm_reg_name[reg_id];
-	u16 *prev = bq27xxx_dm_reg_ptr(buf, reg);
+	__be16 *prev = bq27xxx_dm_reg_ptr(buf, reg);
 
 	if (prev == NULL) {
 		dev_warn(di->dev, "buffer does not match %s dm spec\n", str);
-- 
2.35.1

