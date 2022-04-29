Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFE515603
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381024AbiD2UsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiD2UsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:48:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4583B0E;
        Fri, 29 Apr 2022 13:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1310B837C2;
        Fri, 29 Apr 2022 20:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3B7C385A7;
        Fri, 29 Apr 2022 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651265092;
        bh=gGXIvvgxFW+Na9moMutj5XsbabuqPY64zDFdjd/JUcU=;
        h=From:To:Cc:Subject:Date:From;
        b=Xbnte5eyHQ6MW41LrxxDqK0dIC1TgXH6co9ZIDMWeEYxdV/0/3IDBonFK5HTkvUAe
         KFHs63Tuu37RPEG3xqeXELcy0lpIvPWIcZNXq611kIzKUx3izsNQGHSbLf2N/Cq2pS
         fpccFA0L84RDS/b7TKg7ZM6O5LME8W9eS1BDCNrPOTTzWi4NWVdX5JWJkIXsCfPYE7
         5GVUuxYkOHyqfuw4R0X6g4NMkd5DBvbmexWMq88b9iYJcHX8iGfoDuN2Wuq/YLgBnz
         PI418JfOdwSzVZqoxbJM/NnTYSQUl10GdUdkwIveyWMMPsrjQkwg0dxIWdJHgUvScW
         MWSvQrKWN0V2Q==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.18-rc4
Date:   Fri, 29 Apr 2022 13:44:51 -0700
Message-Id: <20220429204451.2794649-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a91b05f6b928e8fab750fc953d7df0aa6dc43547:

  Merge tag 'sunxi-clk-fixes-for-5.18-2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2022-04-25 16:47:24 -0700)

----------------------------------------------------------------
A semi-large pile of clk driver fixes this time around. Nothing is
touching the core so these fixes are fairly well contained to specific
devices that use these clk drivers.

 - Some Allwinner SoC fixes to gracefully handle errors and mark an RTC
   clk as critical so that the RTC keeps ticking.

 - Fix AXI bus clks and RTC clk design for Microchip PolarFire SoC
   driver introduced this cycle. This has some devicetree bits acked by
   riscv maintainers. We're fixing it now so that the prior bindings
   aren't released in a major kernel version.

 - Remove a reset on Microchip PolarFire SoCs that broke when enabling
   CONFIG_PM.

 - Set a min/max for the Qualcomm graphics clk. This got broken by the
   clk rate range patches introduced this cycle.

----------------------------------------------------------------
Conor Dooley (10):
      clk: microchip: mpfs: don't reset disabled peripherals
      clk: microchip: mpfs: fix parents for FIC clocks
      clk: microchip: mpfs: mark CLK_ATHENA as critical
      riscv: dts: microchip: fix usage of fic clocks on mpfs
      dt-bindings: clk: mpfs document msspll dri registers
      dt-bindings: clk: mpfs: add defines for two new clocks
      dt-bindings: rtc: add refclk to mpfs-rtc
      clk: microchip: mpfs: re-parent the configurable clocks
      clk: microchip: mpfs: add RTCREF clock control
      riscv: dts: microchip: reparent mpfs clocks

Dmitry Baryshkov (1):
      clk: qcom: clk-rcg2: fix gfx3d frequency calculation

Samuel Holland (1):
      clk: sunxi-ng: sun6i-rtc: Mark rtc-32k as critical

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-5.18-2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes

Wan Jiabing (1):
      clk: sunxi-ng: fix not NULL terminated coccicheck error

Yang Yingliang (1):
      clk: sunxi: sun9i-mmc: check return value after calling platform_get_resource()

 .../devicetree/bindings/clock/microchip,mpfs.yaml  |  13 +-
 .../bindings/rtc/microchip,mfps-rtc.yaml           |  15 +-
 .../boot/dts/microchip/microchip-mpfs-fabric.dtsi  |  16 +-
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    |   2 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  |  10 +-
 drivers/clk/microchip/clk-mpfs.c                   | 195 +++++++++++++++++----
 drivers/clk/qcom/clk-rcg2.c                        |   2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |   2 +
 drivers/clk/sunxi/clk-sun9i-mmc.c                  |   2 +
 include/dt-bindings/clock/microchip,mpfs-clock.h   |   5 +-
 10 files changed, 216 insertions(+), 46 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
