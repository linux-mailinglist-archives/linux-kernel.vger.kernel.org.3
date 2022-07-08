Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71356C2AC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiGHTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiGHTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:52:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78E8736D;
        Fri,  8 Jul 2022 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657309944; x=1688845944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vJM5XO6vf+R4PpfJbYDPCYOewQOmfAzMGpJ+4oCDX50=;
  b=P8EC6Gmk8bHat7prB4Y2vs6eMEK0rDiJGQfMsSxNdHf3h0N8Vp8Yr7qc
   vRYSEcIjmiKBZAy2OGUPJxTpg3wGNGCmPgqYRk8R50FPvMg6AGRWZKnRh
   jnZgVphDLfRNvmWa5J2e5iH1HIQG3KmsopOxqQsIaZOnYjaNc58Y/T2il
   Uo8UGbKWX1Zj0B3ZhRYjFv+oB+f/7AFz7E4okfSYxJ5ZPDm5q55yzKDC4
   T7j3Ybq/EZtENX0OnsOjrbgkidLd5dY4F5JdpCdfpvJfyKK8dk25TBRed
   9eVyEYrxMyWfSaqEDEAOLvyT0maTOK7+qCjk4NYLMu272oAd51J8Z/F4N
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="103703677"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 12:52:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 12:52:20 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Jul 2022 12:52:18 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        <michael@walle.cc>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Fri, 8 Jul 2022 21:55:08 +0200
Message-ID: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- second issue is pincfg stop working when regmap support was addded.

v1->v2:
- use regmap_get_reg_stride instead of making regmap_config global
- update how ocelot_match_data structs are initialized

Horatiu Vultur (2):
  pinctrl: ocelot: Fix pincfg for lan966x
  pinctrl: ocelot: Fix pincfg

 drivers/pinctrl/pinctrl-ocelot.c | 207 ++++++++++++++++++++-----------
 1 file changed, 132 insertions(+), 75 deletions(-)

-- 
2.33.0

