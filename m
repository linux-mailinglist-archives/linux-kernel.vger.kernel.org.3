Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0B5726B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiGLTwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiGLTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:52:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2913B38E4;
        Tue, 12 Jul 2022 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657655213; x=1689191213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRDgHZtDC4SaIuBHhgPngaDyNqpryV7HmbUHd3Q7SuU=;
  b=R5k9Nxx+2hNFMTLpJsUpLm00o1HBW7lklrnzJPXMufj4jI2mAeVj2Jif
   SHkyyeQw42u01PrfAUvlg395o8miJX1cQTJwh2OuJY22/1pgsEU1RoP7B
   PT7NXv+a0NqXMz2H38LAvIUp0MzGkKqTDYvK6vPPWhp1f41U/wb/6hHgp
   Mfo1WQMNMgSgYi/+ZcffD3u8FnvZpCdP1Ix/ZTNoudVbqefoEoFEld2J/
   S4x3Wwkfno0r6DXH6q/pc1qmtJ27jxx6TWu66qsXl6giqXcdjMHGMEaon
   PjG2DSGH7fH7I/mQJWs2MGOhAirXekw3UwX+rV+Nzr4W56SpeQEgzYSg7
   g==;
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="171822250"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 12:46:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 12:46:49 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 12 Jul 2022 12:46:47 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <kavyasree.kotagiri@microchip.com>,
        <colin.foster@in-advantage.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>, <michael@walle.cc>,
        <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Tue, 12 Jul 2022 21:50:41 +0200
Message-ID: <20220712195043.3842081-1-horatiu.vultur@microchip.com>
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

 drivers/pinctrl/pinctrl-ocelot.c | 213 ++++++++++++++++++++-----------
 1 file changed, 136 insertions(+), 77 deletions(-)

-- 
2.33.0

