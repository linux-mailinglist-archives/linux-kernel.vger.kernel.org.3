Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA504FFF27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiDMT2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiDMT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:28:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97A72446;
        Wed, 13 Apr 2022 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649877972; x=1681413972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9GeykygBX2XsPll3z/idRMNXQouDNfFpUOOZSeb5K00=;
  b=FOohxZP1YIbf3u2uBX19EnnJpXHk+blV9Xo2EqITgOhVG7yESPpyb9Nv
   G7E3aihnwGS1A5Wx/n0RTFcQRFYkAOPr7VZ/Np+qsqbDVVF0SXX8VYZVK
   Xs/THocvqep6KV002mT+e4RnYTohcvPUPT8HFe4oysMuhS2sAhe7vdeBZ
   R9Jeb1g9F29kIGK15ViQ7QfF2EY1tnFMox8Tl04js/E4TtX9y93g+hP8W
   YbKcMY7BJV56UdXOEwZplxxFq42BPWlEKDC6MRdMYLjroQ6gzB/QhG8/W
   BsA3P3IYYb72R19X4I7AXLv97dlB83zb0ZRpUlr1F+MPH0VbttmFFWfBT
   w==;
X-IronPort-AV: E=Sophos;i="5.90,257,1643698800"; 
   d="scan'208";a="160448666"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 12:26:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 12:26:11 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Apr 2022 12:26:10 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] pinctrl: ocelot: Fix for lan966x
Date:   Wed, 13 Apr 2022 21:29:18 +0200
Message-ID: <20220413192918.3777234-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lan966x, the GPIO 35 has the wrong function for alternate mode 2.
The mode is not none but is PTP sync.

Fixes: 531d6ab36571c2 ("pinctrl: ocelot: Extend support for lan966x")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 51261f1231cc..40f76e4144e4 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -130,6 +130,7 @@ enum {
 	FUNC_PTP1,
 	FUNC_PTP2,
 	FUNC_PTP3,
+	FUNC_PTPSYNC_0,
 	FUNC_PTPSYNC_1,
 	FUNC_PTPSYNC_2,
 	FUNC_PTPSYNC_3,
@@ -253,6 +254,7 @@ static const char *const ocelot_function_names[] = {
 	[FUNC_PTP1]		= "ptp1",
 	[FUNC_PTP2]		= "ptp2",
 	[FUNC_PTP3]		= "ptp3",
+	[FUNC_PTPSYNC_0]	= "ptpsync_0",
 	[FUNC_PTPSYNC_1]	= "ptpsync_1",
 	[FUNC_PTPSYNC_2]	= "ptpsync_2",
 	[FUNC_PTPSYNC_3]	= "ptpsync_3",
@@ -984,7 +986,7 @@ LAN966X_P(31,   GPIO,   FC3_c,     CAN1,      NONE,   OB_TRG,   RECO_b,      NON
 LAN966X_P(32,   GPIO,   FC3_c,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,      NONE,        R);
 LAN966X_P(33,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,    MIIM_b,        R);
 LAN966X_P(34,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,    MIIM_b,        R);
-LAN966X_P(35,   GPIO,   FC1_b,     NONE,   SGPIO_a,   CAN0_b,     NONE,      NONE,        R);
+LAN966X_P(35,   GPIO,   FC1_b,  PTPSYNC_0, SGPIO_a,   CAN0_b,     NONE,      NONE,        R);
 LAN966X_P(36,   GPIO,    NONE,  PTPSYNC_1,    NONE,   CAN0_b,     NONE,      NONE,        R);
 LAN966X_P(37,   GPIO, FC_SHRD0, PTPSYNC_2, TWI_SLC_GATE_AD, NONE, NONE,      NONE,        R);
 LAN966X_P(38,   GPIO,    NONE,  PTPSYNC_3,    NONE,     NONE,     NONE,      NONE,        R);
-- 
2.33.0

