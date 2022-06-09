Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1123544654
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiFIInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiFIIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:41:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6B255BC;
        Thu,  9 Jun 2022 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654764017; x=1686300017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UnfjKrEfwOguxSlRW9Y1YKoPzQz/hSYyMcMrhzmc50Q=;
  b=p9ZgcE2dxJCnxrxQNXTsoVD87NN16VobH07tL9hKV2n8ufWUXW+HROng
   juJFpjWobpAGam/BloVwBHeCXlEhGh4zyNgb4uq8x1hPCfh8oa6psSXXW
   au4qpgCF2C/9UrAUGEAAyuXszyMeFgJz+E4ZPpGChUpbfubCYZM7md+yn
   N4vO4oafvgq/z16jlrOt6HAtaz69HIj6RR1IsxtL1NwZbwE0wXbCv9fG6
   Je6z+4YQ8D5SKj2LlG4FBD12kXjD3XHpIY0FqGMpd1r1JgqaRv1rbMRua
   cYEtKJLFNUsuHlUI8omTSABgRl98cpbbAYJuFSVkmEZky7ZbPgtKfXv6z
   w==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="177214862"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:40:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:40:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:40:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <tudor.ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] spi: atmel-quadspi: add runtime pm support
Date:   Thu, 9 Jun 2022 11:42:43 +0300
Message-ID: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series adds runtime PM support for atmel-quadspi driver.
clk_disable()/clk_enable() is called on proper
runtime_suspend()/runtime_resume() ops. Along with it 2 minor cleanups
were added (patches 2/3, 3/3).

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  spi: atmel-quadspi: add runtime pm support
  spi: atmel-quadspi: use pm_ptr()
  spi: atmel-quadspi: align condition to parenthesis

 drivers/spi/atmel-quadspi.c | 104 ++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 11 deletions(-)

-- 
2.34.1

