Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7000F4AF2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiBINhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiBINh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68BC03E97C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413823; x=1675949823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9b8JHkYj+KtYod5bk+/rj8l+qCSYgtxEN28/BKbsXw=;
  b=j15faYMOWzfHz938/a6PgVP2n0rVmztS2DR8vDZ2Pi8RfoA+nogWMeTk
   1FtiNXS+9m0Zu6LsgPOExi0rdxKrq4hYzzrxsfkBubsWUU/OEvyV1KUoJ
   EYAZ0CfsZLDtaH1dXWvPsUitZ+fOCL9JJWXF3/udpD1QrNrzzGE/qIZ0a
   bImxJEa2889oXIlK0Ra9HBbPRT1sfBCsDD9l/Jg5dCkZ68vm8ouAFh/z8
   C9B1zUNLXrIcEihUi+Kx53dMXcwcRmWm6fg9SwODJUrdd/ceqECrIfsEk
   AOHuhaoItGoLq/dLrP96g1tJloo0mwrOiWoLlH6/7TzXYA29thxbA3ZdE
   g==;
IronPort-SDR: XH8mXKbysT/5q1qveQ850+9rxuZ9yh6lwOOVuOezhwfItBYY85zNaHbIQR+mO25nILeEMHpyav
 bo3suScZxbho0s2egzoI1wxgvzxgX5j2phSa5i+N0XginVq1VJdd+hNgBpmMlW4OQOO/azZ6pW
 687vX2TfGho1mtDBVuvPaNv/eMFG2LPl2k/8guI8w/AxENBH8rrKr6Mq3UZIQbeJLw+C1bRUoe
 fnnR9++/NG8ybb9coXm/zqXkkTwb49BtCsMzS+iI/FY/Xhbmk+drJfH+MHm6P13Cq0XykowDiA
 vdY0LrOLNXfDnAJ/cSbZZ1Gl
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="161629928"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:02 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:36:57 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 0/7] mtd: spi-nor: Prepare core and add support for mx66lm1g45g
Date:   Wed, 9 Feb 2022 15:36:49 +0200
Message-ID: <20220209133656.374903-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made some core work as a prerequisite for mx66lm1g45g addition.
I've cleaned the RDID op and the flash detection. I introduced
SPI_NOR_READID_OP to ease the spi_mem_op filling. I would like to
follow the idea and introduce macros for all the SPI NOR ops, but
after we'll integrate Michael's SR patches.

Cheers,
ta

v6: complete rework

Tudor Ambarus (7):
  mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
  mtd: spi-nor: Introduce spi_nor_match_id()
  mtd: spi-nor: core: Use auto-detection only once
  mtd: spi-nor: core: Introduce method for RDID op
  mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
  mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET flash_info fixup_flag
  mtd: spi-nor: macronix: Add support for mx66lm1g45g

 drivers/mtd/spi-nor/core.c      | 115 +++++++++++++++++-----------
 drivers/mtd/spi-nor/core.h      |  14 ++++
 drivers/mtd/spi-nor/macronix.c  | 131 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/micron-st.c |  13 +---
 drivers/mtd/spi-nor/spansion.c  |  13 +---
 5 files changed, 221 insertions(+), 65 deletions(-)

-- 
2.25.1

