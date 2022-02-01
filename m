Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15824A60BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiBAPwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:52:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59968 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiBAPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:52:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748F3616F1;
        Tue,  1 Feb 2022 15:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F08C340EE;
        Tue,  1 Feb 2022 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643730750;
        bh=xyFhpr3jvuzfAfpWx0n2Wv4o630FQUkyQbxBuxBpSVk=;
        h=From:To:Cc:Subject:Date:From;
        b=iYHe3715YCWF1ECJD8Pe9Od2ok7aYNlHptsmXCAWMU596LiLZCiyBzPExknvQeguf
         QcKR9Ie/WTQZWG0TVHchawCku/4Tbk3PC3pJEmYKlYj1X5C/zMzWFGnTB1+EJ0u+YU
         JkXV4Asgtgu2v9U9ClzdTqc/QBf8yf5B4dVp+vVhNDh6Ym4x5IMbdfv3HabsYGIG1n
         hK8qz/4cPtSPlogC7WEuaFfWvkg4b1VtN5phpIROu0IOiKTJDejKUfoLBqN8DMhtFZ
         BGvWFNnXNML6zXciya8BB2EmuLxwIbf5Hi9AjarqycE5c4e0rPwYtge3qtJwMviPhT
         q7315rdlChTEw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.17-rc2
Date:   Tue, 01 Feb 2022 15:52:16 +0000
Message-Id: <20220201155230.56F08C340EE@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44ea62813f0ab3d718de480504f4dfd0bdd01858:

  spi: don't include ptp_clock_kernel.h in spi.h (2022-01-07 17:14:30 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc2

for you to fetch changes up to f83a96e5f033fbbd21764705cb9c04234b96218e:

  spi: mediatek: Avoid NULL pointer crash in interrupt (2022-01-31 15:24:05 +0000)

----------------------------------------------------------------
spi: Fixes for v5.17

There are quite a few fixes that have accumilated since the merge window
here, all driver specific and none super urgent, plus a new device ID
for the Rockchip driver.

----------------------------------------------------------------
Alain Volmat (2):
      spi: stm32: remove inexistant variables in struct stm32_spi_cfg comment
      spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4

Benjamin Gaignard (1):
      spi: mediatek: Avoid NULL pointer crash in interrupt

Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

Kamal Dasu (1):
      spi: bcm-qspi: check for valid cs before applying chip select

Kunihiko Hayashi (1):
      spi: uniphier: Fix a bug that doesn't point to private data correctly

Miaoqian Lin (1):
      spi: meson-spicc: add IRQ check in meson_spicc_probe

Nicolas Frattaroli (1):
      spi: spi-rockchip: Add rk3568-spi compatible

Patrice Chotard (1):
      spi: stm32-qspi: Update spi registering

Rob Herring (1):
      spi: dt-bindings: Fix 'reg' child node schema

Xin Xiong (1):
      spi: uniphier: fix reference count leak in uniphier_spi_probe()

 .../bindings/spi/spi-peripheral-props.yaml         |  5 ++-
 .../devicetree/bindings/spi/spi-rockchip.yaml      |  1 +
 drivers/spi/spi-armada-3700.c                      |  2 +-
 drivers/spi/spi-bcm-qspi.c                         |  2 +-
 drivers/spi/spi-meson-spicc.c                      |  5 +++
 drivers/spi/spi-mt65xx.c                           |  2 +-
 drivers/spi/spi-stm32-qspi.c                       | 47 ++++++++--------------
 drivers/spi/spi-stm32.c                            |  7 ++--
 drivers/spi/spi-uniphier.c                         | 29 ++++++++-----
 9 files changed, 53 insertions(+), 47 deletions(-)
