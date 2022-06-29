Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE255FEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiF2LbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiF2La7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:30:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123A3EF2F;
        Wed, 29 Jun 2022 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502254; x=1688038254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SttLpnekTpHLqf0jeO2Z9mBo/959BLBoXWIJOeVu4ec=;
  b=D0qT0yFyAwG8IprbcW6zvA/t5AQUSjB6D8VjtLddz36Gz2Bt433RvhfN
   iQMOC5cmOhoEnErmshiZsmDXJ7Lo1nwlbpXnAzZD+H7caYzKbVcWM7VlA
   5a/S2XsDRBpxNemG2ZBg9pNj5bU8bOcEm1dTdhKFqP5HCg6ZWbiU7QKAs
   EncVAW+YAEo4tQ5p0ONAq/2/9xyGAUCv3moZW4GTvi8zA3xlgZ3IqTql5
   Xokacc6eGgFVbwyCWcL72X9DpVOpAaM/n/kDXQtRAKSnQVtrAXLbCF3YT
   ksbvVknOsaBaA6Z8BYXEPOiw82DfzrN1ZYWOc85HhMmjXWS/rUJXb3iFi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261807987"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="261807987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595204434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 04:30:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 482BAF1; Wed, 29 Jun 2022 14:30:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: of: Use device_match_of_node() helper
Date:   Wed, 29 Jun 2022 14:30:58 +0300
Message-Id: <20220629113058.79617-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding, use device_match_of_node() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 3d6c3ffd5576..23b8de98bf7c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -720,7 +720,7 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 
 static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
 {
-	return chip->gpiodev->dev.of_node == data;
+	return device_match_of_node(&chip->gpiodev->dev, data);
 }
 
 static struct gpio_chip *of_find_gpiochip_by_node(struct device_node *np)
-- 
2.35.1

