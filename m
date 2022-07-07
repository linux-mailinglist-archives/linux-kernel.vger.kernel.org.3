Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D756AB06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiGGSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiGGStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:49:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134202124D;
        Thu,  7 Jul 2022 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657219792; x=1688755792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pvJunDBsIn7RdpHLctPDPVxQZI1uLLjQpB8iFbP0Gyk=;
  b=FkhZuhXxF9PRyfHdVSGYWoEPVg6pl4rKLVbiDLLB5Xtoe8ao8W5KMI5S
   fWkCAALKJVuslK+dMQ8JQb9wZFUlq+BYnjknVzths1sKq/o+FAca7/JS5
   Ujk3nch1Pv5Avxv+8w4lR/qePx0LxKflQD58mKh335TAQb+6RksR8qcNR
   dqeh+b7HJI4uQ93O1lS8lDJPq/gXJk6RZ0i38Om0AEAiMVizeerQ+B+Fi
   PlrVabTDJaT09D4VLCEo1qrla2fItsM1t9nO6BIUv1xLyNzggZIooZ9J6
   w7yT5pTjYSREV825lqKGXVMdTOeMZ7NfQGXH5OlCRTYifBVg2TEkdi6gT
   A==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="163810703"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 11:49:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 11:49:50 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 11:49:48 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Thu, 7 Jul 2022 20:53:40 +0200
Message-ID: <20220707185342.2697569-1-horatiu.vultur@microchip.com>
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

Horatiu Vultur (2):
  pinctrl: ocelot: Fix pincfg for lan966x
  pinctrl: ocelot: Fix pincfg

 drivers/pinctrl/pinctrl-ocelot.c | 222 +++++++++++++++++++------------
 1 file changed, 138 insertions(+), 84 deletions(-)

-- 
2.33.0

