Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E68570A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiGKTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:17:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750F57261;
        Mon, 11 Jul 2022 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657567059; x=1689103059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fjAA30j8y1cx45lIbqee/5lNlNMTMCRpWdNQgufbK4U=;
  b=XqN9Mo2rXPB6ste49Ray1OHtJpEoao8EnEYDR0fek3FQwueZTEExKXeM
   VMoqf0MCG4Ou25YlTJjNdvulKyeQjrEgrN+eK7LGAaNa4NOwLdZgIYU5M
   gSRm03bwVRRbqzVLL9PW65C6+zpnx4zxwFmZ1a2NRPXhViv5P0yVpwJ6P
   D9NXHWE8Ww7WZiyf0waRm1E06U1dzIttKxVnfXUt07bGaEJB9po71L6Om
   JkakIqhpkHnSV2S348OJmjMeWNeeYuB6Th+U+y0MMgxT416ARKw7AgFZW
   prWTHl4J+P6zUuHRXPWv7Eesa21hBNOahUSmNtJwFc2cHJb2Jmg9P7wa1
   w==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="181678604"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 12:17:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 12:17:38 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 12:17:36 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        <michael@walle.cc>, <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Mon, 11 Jul 2022 21:21:11 +0200
Message-ID: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
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

 drivers/pinctrl/pinctrl-ocelot.c | 215 ++++++++++++++++++++-----------
 1 file changed, 138 insertions(+), 77 deletions(-)

-- 
2.33.0

