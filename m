Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663884A7416
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiBBO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiBBO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:03 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC62AC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:59:02 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1FEF422247;
        Wed,  2 Feb 2022 15:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TY7Wrnm/WHimiGDX0u4wyobL0QT4VxUa6F+zVTftJjU=;
        b=DDT5KuEp90oEdhuX6vaJ9ObisD1ds7fRwJ631WZZMi5Nfls8BVzVxCm+BlQrks0GfOcumZ
        KONVefzg6JiUyOb9k00p1eMpeMuv9/FBdMq7FByhUAc8Psdwp3k+RcPJLO4OD3tHhOYUQ2
        RPKBqB2doec5L8PCCb95n0XvgZ1QD7c=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 00/14] mtd: spi-nor: move vendor specific code into vendor modules
Date:   Wed,  2 Feb 2022 15:58:39 +0100
Message-Id: <20220202145853.4187726-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that most of the special status register handling is
specific for a particular vendor. I.e. Xilinx has some different
opcodes for the status register read, Micron has an additional FSR
register and Spansion has these flags integrated into the SR.

Create a callback to ready() where a flash chip can register its
own function. This will let us move all the vendor specific stuff
out of the core into the vendor modules.

Please note that this is only compile-time tested.

For sake of consistency and better readability of the code flow,
I also converted the setup() callback to be optional.

Michael Walle (14):
  mtd: spi-nor: export more function to be used in vendor modules
  mtd: spi-nor: slightly refactor the spi_nor_setup()
  mtd: spi-nor: allow a flash to define its own ready() function
  mtd: spi-nor: move all xilinx specifics into xilinx.c
  mtd: spi-nor: xilinx: rename vendor specific functions and defines
  mtd: spi-nor: xilinx: correct the debug message
  mtd: spi-nor: move all micron-st specifics into micron-st.c
  mtd: spi-nor: micron-st: convert USE_FSR to a manufacturer flag
  mtd: spi-nor: micron-st: fix micron_st prefix
  mtd: spi-nor: micron-st: rename vendor specific functions and defines
  mtd: spi-nor: spansion: slightly rework control flow in late_init()
  mtd: spi-nor: move all spansion specifics into spansion.c
  mtd: spi-nor: spansion: convert USE_CLSR to a manufacturer flag
  mtd: spi-nor: renumber flags

 drivers/mtd/spi-nor/core.c      | 265 ++------------------------------
 drivers/mtd/spi-nor/core.h      |  70 ++++-----
 drivers/mtd/spi-nor/micron-st.c | 225 ++++++++++++++++++++++-----
 drivers/mtd/spi-nor/spansion.c  | 133 ++++++++++++----
 drivers/mtd/spi-nor/xilinx.c    |  79 +++++++++-
 include/linux/mtd/spi-nor.h     |  18 ---
 6 files changed, 417 insertions(+), 373 deletions(-)

-- 
2.30.2

