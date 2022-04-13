Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749AF4FFE37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiDMS4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiDMS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:56:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ACE5EBDE;
        Wed, 13 Apr 2022 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876019; x=1681412019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vROWOqlnompVQlKZn/1JujcHrK9zpeA4VUB/N6E30Zc=;
  b=mm/eJVGmY1SsPfTnLH/4uIf09AXcOphT2xWoOaDPmqz/4SgLWERbEq+k
   whv4WqPKfUfALFx1s48PCLuPn2F0Zelc/0lAmUD632/PSZdHf9P/kVClf
   h0vCUTW99oQAKuIhJn5X60Fq+QTY61vwnrKji4yO/MqleWu7FhWTvfjJk
   PKcbeIlObrkjLXVDtF/gLnKTSdGMUFFhQWKdAQughDBqg6FgKhydopXUS
   Vku3R/ZuQfZv/efNtid6sP5oJgSUl8fLrUXdu+baUF89X4KudCl7TKbhx
   rb1IAF1fFVgDb9UGfqYz857a43jUdKT0ZHajQOUgYY3ti78hVExmrRKir
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262188768"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262188768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="527059128"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2022 11:53:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9AD312C; Wed, 13 Apr 2022 21:53:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: temperature: max31865: Make use of device properties
Date:   Wed, 13 Apr 2022 21:53:35 +0300
Message-Id: <20220413185335.21743-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/temperature/max31865.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
index 86c3f3509a26..e3bb78184c6e 100644
--- a/drivers/iio/temperature/max31865.c
+++ b/drivers/iio/temperature/max31865.c
@@ -12,9 +12,11 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <asm/unaligned.h>
 
@@ -305,7 +307,7 @@ static int max31865_probe(struct spi_device *spi)
 	indio_dev->channels = max31865_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
 
-	if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
+	if (device_property_read_bool(&spi->dev, "maxim,3-wire")) {
 		/* select 3 wire */
 		data->three_wire = 1;
 	} else {
-- 
2.35.1

