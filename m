Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC694FFE48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiDMS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiDMS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:59:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A76B0B9;
        Wed, 13 Apr 2022 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876220; x=1681412220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lAetsBuWgswU7u+YkwA4as4H1nfbpfGF8R6Greju+tw=;
  b=nqD3ev5H2quVaBs2+YyBuXPj6tgFbA26s6Th4sqagQhm1UECbF6t2JBL
   3LA4eav2Li+fAg85ej6LNlLmKXy718NOgL6IoLgKZMjxyoYhUTFr0OMBO
   MgbrEFV9aMrbaG3FGW9vn4c2gJJB3qdwzcFLf7NjoLD+0zDKnAegt+NOH
   KloyNkNy8yReI12FL78hFPg8X0YnjqrCma2iyprQjZ7Rq669kYGfCaAzA
   8GEvzP0Fd/eySyCvitACD5w6pDjntJXegQX1Gp2ZWt11v2enghBFWTGB6
   1qvz232IeH4A4sDBSAinuI7EX1YzuomIkGkbWSoj1hjpJYmSSA6alvxel
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349184940"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="349184940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="612002913"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2022 11:56:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66F9512C; Wed, 13 Apr 2022 21:56:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v1 1/1] iio: trigger: stm32-lptimer-trigger: Make use of device properties
Date:   Wed, 13 Apr 2022 21:56:56 +0300
Message-Id: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/trigger/stm32-lptimer-trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index 98cdc7e47f3d..af46c10cea92 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 /* List Low-Power Timer triggers */
 static const char * const stm32_lptim_triggers[] = {
@@ -77,7 +78,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	if (of_property_read_u32(pdev->dev.of_node, "reg", &index))
+	if (device_property_read_u32(&pdev->dev, "reg", &index))
 		return -EINVAL;
 
 	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
-- 
2.35.1

