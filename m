Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D64BE106
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357328AbiBUMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:08:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357308AbiBUMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F6201BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:22 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0E84622175;
        Mon, 21 Feb 2022 13:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kDZecnFpvJUn7GdYa3/jLktDDxiEIEndxgKV+PElY/A=;
        b=MHLP8OP2TVJh871sv3ypV0XbQIdY7v8cN9VvvDUWi4uXmoZ1DNnPgMwyHtCzE3HE9AlDiY
        f438QK7zkwEuOBdgwe1HRVLfUrc8SzG56t/JyTcG6QXIBLQKYYgPLkrDj8F4NeJVU3wPvV
        HAUGQfKPH/2My8J/AIdmn1SLm4ZnE58=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 00/32] mtd: spi-nor: move vendor specific code into vendor modules
Date:   Mon, 21 Feb 2022 13:07:37 +0100
Message-Id: <20220221120809.1531502-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

As a preparation step, unify all function and object names in the
vendor modules. For the sake of consistency and better readability
of the code flow, I also converted the setup() callback to be
optional.

Please note that this is only compile-time tested.

Changes since v3:
 - fix spansion.c compilation, messed up the patch export. Sorry
   for the noise

Changes since v2:
 - use family_nor_ instead of just family_ prefix
 - fix function doc

Changes since v1:
 - rename/unify function names inside the vendor modules.
 - make local functions static
 - fix function doc typo
 - use late_init hook to set fsr_ready op
 - Use uppercase and period in comments
 - Add comments for the vendor flags
 - move coding style change in spi_nor_sr_ready() into own patch
 - new patch to add missing parenthesis in S3AN_INFO()
 - add missing function prefix rename patch for the spansion module

Michael Walle (32):
  mtd: spi-nor: atmel: unify function names
  mtd: spi-nor: catalyst: unify function names
  mtd: spi-nor: eon: unify function names
  mtd: spi-nor: esmt: unify function names
  mtd: spi-nor: everspin: unify function names
  mtd: spi-nor: fujitsu: unify function names
  mtd: spi-nor: gigadevice: unify function names
  mtd: spi-nor: intel: unify function names
  mtd: spi-nor: issi: unify function names
  mtd: spi-nor: macronix: unify function names
  mtd: spi-nor: micron-st: unify function names
  mtd: spi-nor: spansion: unify function names
  mtd: spi-nor: sst: unify function names
  mtd: spi-nor: winbond: unify function names
  mtd: spi-nor: xilinx: unify function names
  mtd: spi-nor: xmc: unify function names
  mtd: spi-nor: slightly refactor the spi_nor_setup()
  mtd: spi-nor: allow a flash to define its own ready() function
  mtd: spi-nor: export more function to be used in vendor modules
  mtd: spi-nor: guard _page_size parameter in S3AN_INFO()
  mtd: spi-nor: move all xilinx specifics into xilinx.c
  mtd: spi-nor: xilinx: rename vendor specific functions and defines
  mtd: spi-nor: xilinx: correct the debug message
  mtd: spi-nor: move all micron-st specifics into micron-st.c
  mtd: spi-nor: micron-st: convert USE_FSR to a manufacturer flag
  mtd: spi-nor: micron-st: rename vendor specific functions and defines
  mtd: spi-nor: spansion: slightly rework control flow in late_init()
  mtd: spi-nor: move all spansion specifics into spansion.c
  mtd: spi-nor: spansion: convert USE_CLSR to a manufacturer flag
  mtd: spi-nor: spansion: rename vendor specific functions and defines
  mtd: spi-nor: slightly change code style in spi_nor_sr_ready()
  mtd: spi-nor: renumber flags

 drivers/mtd/spi-nor/atmel.c      |  81 +++++-----
 drivers/mtd/spi-nor/catalyst.c   |   6 +-
 drivers/mtd/spi-nor/core.c       | 265 ++-----------------------------
 drivers/mtd/spi-nor/core.h       |  70 ++++----
 drivers/mtd/spi-nor/eon.c        |   6 +-
 drivers/mtd/spi-nor/esmt.c       |   6 +-
 drivers/mtd/spi-nor/everspin.c   |   6 +-
 drivers/mtd/spi-nor/fujitsu.c    |   6 +-
 drivers/mtd/spi-nor/gigadevice.c |   6 +-
 drivers/mtd/spi-nor/intel.c      |   6 +-
 drivers/mtd/spi-nor/issi.c       |  10 +-
 drivers/mtd/spi-nor/macronix.c   |  14 +-
 drivers/mtd/spi-nor/micron-st.c  | 258 ++++++++++++++++++++++++------
 drivers/mtd/spi-nor/spansion.c   | 168 +++++++++++++++-----
 drivers/mtd/spi-nor/sst.c        |  44 ++---
 drivers/mtd/spi-nor/winbond.c    |  29 ++--
 drivers/mtd/spi-nor/xilinx.c     |  97 +++++++++--
 drivers/mtd/spi-nor/xmc.c        |   6 +-
 include/linux/mtd/spi-nor.h      |  18 ---
 19 files changed, 578 insertions(+), 524 deletions(-)

-- 
2.30.2

