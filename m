Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8455D114
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiF0Pbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiF0Pb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:31:27 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C419C29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:31:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id oFXH2700K4C55Sk01FXHYh; Mon, 27 Jun 2022 17:31:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-0014yX-Ve; Mon, 27 Jun 2022 17:31:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jEG-Dr; Mon, 27 Jun 2022 17:31:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] memory: renesas-rpc-if: Rebind and s2ram fixes
Date:   Mon, 27 Jun 2022 17:31:07 +0200
Message-Id: <cover.1656341824.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The Renesas RPC-IF provides either HyperFlash or SPI host access.
To handle this, three drivers are used:
  1. The RPC-IF core diver,
  2. An HyperFlash child driver,
  3. An SPI child driver.

Currently this driver collection has the following issues:
  1. After manually unbinding the child driver, rebinding the child
     driver fails with -EBUSY,
  2. During PSCI system suspend, the SoC may be powered down, losing
     RPC-IF register state, and causing data corruption after resume.

This patch series aims to fix this:
  - Patches 1-4 contain preparatory cleanups and improvements,
  - Patch 5 fixes unbind/rebind,
  - Patch 6 cleans up the internal API between the RPC-IF core diver,
    and the HF and SPI child drivers, and thus touches the MTD/HYPERBUS
    and SPI subsystems, too,
  - Patch 7 adds system suspend/resume support to the RPC-IF core
    driver.

This has been tested on the Salvator-XS (HyperFlash) and Falcon (QSPI
FLASH) development boards.

At least with HyperFlash, successful RPC-IF operation after s2ram is
still not guaranteed (more details below).
I do not have physical access to a board that uses the RPC-IF in SPI
mode, so I could not test s2ram with RPC-SPI.  I am wondering if it
suffers from similar problems, or if these are purely related to
HyperFlash?

Findings:

  - Sometimes RPC-HF still works after resume from s2ram

  - Sometimes RPC-HF read data is corrupted after resume from s2ram:

      - Data read looks like (for each block of 16 bytes at offset i):
          - 8 bytes of data stored at offset (i % 262144) * 256,
	  - 8 bytes duplicate of the above.

      - After that, unbind/rebind fails:

          # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
	  # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
	  rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

      - After doing s2ram again, rebind (usually) succeeds again, and
	reading from HF returns the expected data again:

	  # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
	  rpc-if-hyperflash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000001 Chip ID 0x007000

      - When doing unbind before s2ram, rebind after resume usually
	works (better success rate than without unbind), but not always.

Things I have tried:

  - Always resetting the device in rpcif_hw_init(), like is done on
    RZ/G2L, does not make a difference.

  - Dumping the full RPC register space before/after s2ram, but there
    does not seem to be any relation between register contents (which
    vary) and successful operation.

  - Adding HF calibration like hbmc-am654 (and never setting the
    controller's calibrated flag) does not help: either calibration
    succeeds with 5 passes on 5 tries, or fails with 0 passes on 25
    tries.

  - Browsing the TF/A and U-Boot sources also didn't help.

Thanks for your comments!

Geert Uytterhoeven (7):
  memory: renesas-rpc-if: Always use dev in rpcif_sw_init()
  memory: renesas-rpc-if: Add dev helper to rpcif_probe()
  memory: renesas-rpc-if: Improve Runtime PM handling
  memory: renesas-rpc-if: Split-off private data from struct rpcif
  memory: renesas-rpc-if: Move resource acquisition to .probe()
  memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
  memory: renesas-rpc-if: Reinitialize registers during system resume

 drivers/memory/renesas-rpc-if.c | 167 +++++++++++++++++++++-----------
 drivers/mtd/hyperbus/rpc-if.c   |  18 ++--
 drivers/spi/spi-rpc-if.c        |  14 +--
 include/memory/renesas-rpc-if.h |  32 ++----
 4 files changed, 137 insertions(+), 94 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
