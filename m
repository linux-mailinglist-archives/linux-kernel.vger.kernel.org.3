Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25592581624
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiGZPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGZPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:12:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BEC2F00F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658848331; x=1690384331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Etd9mR3RlNpLZNJF6k1X1j8+2T4Syh+GGlJFfNnbx/o=;
  b=OiQm4wwlzC5YVOC02ecOxOgM+si3Gdw3GcTI6N49i3zpMxC2zDZj94iq
   UdNMHsNYH30mksxac1FbBzPsaiTlaNDuXQos5EbwWsPR1l4m9r+jREl5S
   Yhg4LKsQGqtKv6l4H/mtF7gn+n5p+pH0dSHVWIJybUEbpN5jyClFXXJND
   QIgHJeyaRPEIkyB2q98CISqXJObZbGZUW9VukGZZcgaEQKwLHVUi29eqw
   F0wtGQcWd8jp/WgBT6fE/tPsdomo4BfHvt+SXBoHllXS1dF03S9GWtw9E
   +Wx4XzGrjFWbhZnUxUih3qOloGN0zFyPYc6B6UmV6RlpURIaLHnsLcGpt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271017301"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="271017301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702929163"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2022 08:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA034F1; Tue, 26 Jul 2022 18:12:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: Make use of get_unaligned_be24(), put_unaligned_be24()
Date:   Tue, 26 Jul 2022 18:12:13 +0300
Message-Id: <20220726151213.71712-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a proper endianness converters for BE 24-bit data use
them. While at it, format the code using switch-cases as it's done
for the rest of the endianness handlers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fee221c5008c..e371acea7e0e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -288,15 +288,9 @@ static void regmap_format_16_native(void *buf, unsigned int val,
 	memcpy(buf, &v, sizeof(v));
 }
 
-static void regmap_format_24(void *buf, unsigned int val, unsigned int shift)
+static void regmap_format_24_be(void *buf, unsigned int val, unsigned int shift)
 {
-	u8 *b = buf;
-
-	val <<= shift;
-
-	b[0] = val >> 16;
-	b[1] = val >> 8;
-	b[2] = val;
+	put_unaligned_be24(val << shift, buf);
 }
 
 static void regmap_format_32_be(void *buf, unsigned int val, unsigned int shift)
@@ -380,14 +374,9 @@ static unsigned int regmap_parse_16_native(const void *buf)
 	return v;
 }
 
-static unsigned int regmap_parse_24(const void *buf)
+static unsigned int regmap_parse_24_be(const void *buf)
 {
-	const u8 *b = buf;
-	unsigned int ret = b[2];
-	ret |= ((unsigned int)b[1]) << 8;
-	ret |= ((unsigned int)b[0]) << 16;
-
-	return ret;
+	return get_unaligned_be24(buf);
 }
 
 static unsigned int regmap_parse_32_be(const void *buf)
@@ -991,9 +980,13 @@ struct regmap *__regmap_init(struct device *dev,
 		break;
 
 	case 24:
-		if (reg_endian != REGMAP_ENDIAN_BIG)
+		switch (reg_endian) {
+		case REGMAP_ENDIAN_BIG:
+			map->format.format_reg = regmap_format_24_be;
+			break;
+		default:
 			goto err_hwlock;
-		map->format.format_reg = regmap_format_24;
+		}
 		break;
 
 	case 32:
@@ -1064,10 +1057,14 @@ struct regmap *__regmap_init(struct device *dev,
 		}
 		break;
 	case 24:
-		if (val_endian != REGMAP_ENDIAN_BIG)
+		switch (val_endian) {
+		case REGMAP_ENDIAN_BIG:
+			map->format.format_val = regmap_format_24_be;
+			map->format.parse_val = regmap_parse_24_be;
+			break;
+		default:
 			goto err_hwlock;
-		map->format.format_val = regmap_format_24;
-		map->format.parse_val = regmap_parse_24;
+		}
 		break;
 	case 32:
 		switch (val_endian) {
-- 
2.35.1

