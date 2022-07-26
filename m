Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29C5812C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiGZMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiGZMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F714008;
        Tue, 26 Jul 2022 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837154; x=1690373154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMC2wNGyqJFQfBamjOwEaaiV4YpyT3KOmIURe2y6h6U=;
  b=X8AmgrsL3mix3YyCOk3YocMksYLpgJ05+peM1yymXF8ccswIHE3cTIGe
   L95njfrNpIgTbPdWC2rA6akUYT1wQqihKGwVwfFnUeIuZEtpWG98u70yp
   Al3/soEYF48RYPEvpR9jJS4bS64lOJ1bfDhQ7TxaiLUTlo2tQ4N5I4Sqb
   W8gLIf04Fbwf9Dkr2pcRkD5v7du85ZIiJM3dPDEAdR4lRaIbKp05zJWrd
   RknMDML3J9zAa/rm7Qz9WiPHmggC5NtBL4FECQyfGOdbrq/TSro5TruVE
   PZkEfiZih7v9ksvJtUneRQ/z08Y8Jw4cOLGnsCkCvcGmXLUeM3RT6oqca
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267703529"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267703529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="845854992"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2022 05:05:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DBAB86; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with understandle flow
Date:   Tue, 26 Jul 2022 15:05:50 +0300
Message-Id: <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides not being understandable at the first glance, the code
might provoke a compiler or a static analyser tool to warn about
out-of-bound access (when len == 0).

Replace it with clear flow an understandable intention.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index c975db1bbe8c..81c0ab220339 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -377,10 +377,10 @@ static int ov2740_read_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 *val)
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
 	struct i2c_msg msgs[2];
 	u8 addr_buf[2];
-	u8 data_buf[4] = {0};
+	u8 data_buf[4];
 	int ret = 0;
 
-	if (len > sizeof(data_buf))
+	if (len > 4)
 		return -EINVAL;
 
 	put_unaligned_be16(reg, addr_buf);
@@ -391,13 +391,22 @@ static int ov2740_read_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 *val)
 	msgs[1].addr = client->addr;
 	msgs[1].flags = I2C_M_RD;
 	msgs[1].len = len;
-	msgs[1].buf = &data_buf[sizeof(data_buf) - len];
+	msgs[1].buf = data_buf;
 
 	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 	if (ret != ARRAY_SIZE(msgs))
 		return ret < 0 ? ret : -EIO;
 
-	*val = get_unaligned_be32(data_buf);
+	if (len == 4)
+		*val = get_unaligned_be32(data_buf);
+	else if (len == 3)
+		*val = get_unaligned_be24(data_buf);
+	else if (len == 2)
+		*val = get_unaligned_be16(data_buf);
+	else if (len == 1)
+		*val = data_buf[0];
+	else
+		return -EINVAL;
 
 	return 0;
 }
@@ -412,7 +421,16 @@ static int ov2740_write_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 val)
 		return -EINVAL;
 
 	put_unaligned_be16(reg, buf);
-	put_unaligned_be32(val << 8 * (4 - len), buf + 2);
+	if (len == 4)
+		put_unaligned_be32(val, buf + 2);
+	else if (len == 3)
+		put_unaligned_be24(val, buf + 2);
+	else if (len == 2)
+		put_unaligned_be16(val, buf + 2);
+	else if (len == 1)
+		buf[2] = val;
+	else
+		return -EINVAL;
 
 	ret = i2c_master_send(client, buf, len + 2);
 	if (ret != len + 2)
-- 
2.35.1

