Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B3573D30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiGMTeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiGMTeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:34:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA40F33;
        Wed, 13 Jul 2022 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657740838; x=1689276838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v/dMg5+l4XYOjhyI1fbX9+hbRpNVINVMf60AkdLWhL8=;
  b=uQ+KlOY2tnVke4XlWvb77FIHVLCiFUCMHZYTDZB3fYb6HnmheViZ4Eji
   zEpge926LiE3fdifpoCE8WEnRLKkDrkcLE4tr+skjTZYNRVh/bY5vHABh
   UkcsSnoqUaB+6J+jzZREJanhYdp/doRvHUGMyIaBGhvXPHUphoxJGX5hD
   cdddg0pW02Een6EZ0iN58s+To1KebQJSs2mDvXDEr5s7cDIYeix0WGtCn
   BLXnqvAkEAlMsaNny8GWnxak4MZ4gm5GApo2w4XdEutaTViJH9WjpzOYH
   z/kCd/psE9wrH2NEmC2MK4+F8ftNArdEoDGeCG/09E7LJawIgVeBzoJMf
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="167716403"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 12:33:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 12:33:51 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 12:33:49 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <kavyasree.kotagiri@microchip.com>,
        <colin.foster@in-advantage.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>, <michael@walle.cc>,
        <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v5 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Wed, 13 Jul 2022 21:37:48 +0200
Message-ID: <20220713193750.4079621-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series fixes 2 issues with pincfg.
- first issue is that on lan966x uses different offsets than sparx5
  so it can't use directly the ocelot_confops
- second issue is pincfg stop working when regmap support was added.

v4->v5:
- add Reviewed-by, Acked-by tags for patch 2
- clean the indentation mess inside ocelot_pinconf_set

v3->v4:
- add missing check for NULL pointer when doing devm_kmemdup
- remove devm_kmemdup for pincfg_data as it can be const
- remove has_schmitt field, because we can use schmitt_bit for checking
  if it has support for PIN_CONFIG_INPUT_SCHMITT_ENABLE
- change the declaration of ocelot_pinctrl_create_pincfg

v2->v3:
- reorder ocelot_pincfg_data fields, mandatory fields go first
- move the field pincfg_data inside ocelot_pinctrl
- add back max_register for regmap_config for pincfg.
- make struct ocelot_match_data const and drop the cast.

v1->v2:
- use regmap_get_reg_stride instead of making regmap_config global
- update how ocelot_match_data structs are initialized

Horatiu Vultur (2):
  pinctrl: ocelot: Fix pincfg for lan966x
  pinctrl: ocelot: Fix pincfg

 drivers/pinctrl/pinctrl-ocelot.c | 214 ++++++++++++++++++++-----------
 1 file changed, 137 insertions(+), 77 deletions(-)

-- 
2.33.0

