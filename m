Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48364BC8D1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiBSONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:13:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiBSONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:13:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF648329;
        Sat, 19 Feb 2022 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645279991; x=1676815991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l7w+kDiu9ua6ey6n5akjPZ0PY6ySIMf6qO2bjcuckyU=;
  b=Bhg2h+GwfCOZY3tWLXYVGCo1xxyS4BRT4O84tU6y7QyKGq3cv2PXbrnw
   eAz+lycwcvTQJQ9bXj7cHDJ7Adsr+0YG9hTfHmVfFQPWKACphnra/O0q/
   KhDSGaxoFlawIRgYboqR38djFihAwr3hKBcgHPB80CFVTv6ge+YdsBYc2
   OL7onr3SAmQWKuJQXwyzmuJFT0wsaCgd4Y+b0oRA3s7tu/Qpg7DMM0xah
   8ZhKkTyykRerAmXXVcRxfCJN+gQo9fifK26RRyqr40g3HXn5NwtsCeAAE
   hQane4B9XrT3B9DlwKsGMAi0xOqiQIc58pOGPr4smekkOlXBLKYi9uAYq
   A==;
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="154162965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Feb 2022 07:13:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 19 Feb 2022 07:13:10 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sat, 19 Feb 2022 07:13:09 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: lan966x: Fix linking error
Date:   Sat, 19 Feb 2022 15:15:36 +0100
Message-ID: <20220219141536.460812-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the config options HAS_IOMEM is not set then the driver fails to link
with the following error:
clk-lan966x.c:(.text+0x950): undefined reference to
`devm_platform_ioremap_resource'

Therefor add missing dependencies: HAS_IOMEM and OF.

Fixes: 54104ee02333 ("clk: lan966x: Add lan966x SoC clock driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/clk/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4a8451f61f37..6f03c29c40be 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -232,6 +232,8 @@ config COMMON_CLK_GEMINI
 
 config COMMON_CLK_LAN966X
 	bool "Generic Clock Controller driver for LAN966X SoC"
+	depends on HAS_IOMEM
+	depends on OF
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.33.0

