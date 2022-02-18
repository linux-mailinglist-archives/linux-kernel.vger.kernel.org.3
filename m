Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F84BB82F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiBRLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:35 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8292B0B09
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:16 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5AD9A22239;
        Fri, 18 Feb 2022 12:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9TlnQxnR88dBx+W0DgIZNYVu/Pyuax2FALjMy5Y26hA=;
        b=fKlNwt/jYJrztVEeI5/UTMOCNQbgUyqv6daQaEtdYPHx7VJXfnkPUjmtfDEEhvcK92uoXK
        w5m0T1mOTNqiLV+veF9sllwGLfl9Us35dcM++Y4Uhoj/J67fZRSDIIyIk8ReubJ2vAyR5a
        uSCYNgWgOl7DrcfNp3AsAwZwz6mXcsg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 00/32] mtd: spi-nor: move vendor specific code into vendor modules
Date:   Fri, 18 Feb 2022 12:35:35 +0100
Message-Id: <20220218113607.1360020-1-michael@walle.cc>
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
 drivers/mtd/spi-nor/spansion.c   | 154 +++++++++++++-----
 drivers/mtd/spi-nor/sst.c        |  20 +--
 drivers/mtd/spi-nor/winbond.c    |  26 +--
 drivers/mtd/spi-nor/xilinx.c     |  93 +++++++++--
 drivers/mtd/spi-nor/xmc.c        |   6 +-
 include/linux/mtd/spi-nor.h      |  18 ---
 19 files changed, 555 insertions(+), 502 deletions(-)

-- 
2.30.2

