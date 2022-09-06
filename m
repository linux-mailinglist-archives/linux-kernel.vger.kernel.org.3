Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C35AED22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiIFOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiIFOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:19:26 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006243E49
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v3ozdKl00Zk3pGYhPltXKnY62thad7R3U2qnCg2ZWmA=; b=TejASX/tUfb05N0Rr03cDfUJ4z
        c86onR0QHJHnqqOSViQP28CVl6Vw8eKFGdmSoybLPFtoagFjXer4+jRDQNVL6J5ioZmA7Ip/F7Xoa
        5cYLC+4wcSBeZGwdlBM2f9yvgsJiaMCH1qppoCCxklP/40vjmwLNxmgrvMbgsxxK28yuPfeVARAAr
        pNiNAAQokoAu6QoqI0J7i7dRSJ5oFrOF0GB7+xJRK0x9zr2XOLIwV19zEwF4vI8TR/WY1CTk0/8U6
        DZ+O6ZBxkID6uZ2kD6jB8lhM9NjiuII827ydnCZwmaCmBJUCvpuzxsv2PqgwqU6fItVWn6P0JvQ1a
        hCjXF2Fw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oVYdW-008sZV-CB; Tue, 06 Sep 2022 16:29:06 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Support for NVDEC on Tegra234
Date:   Tue,  6 Sep 2022 16:28:15 +0300
Message-Id: <20220906132823.2390953-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Hi all,

this series adds support for the HW video decoder, NVDEC,
on Tegra234 (Orin). The main change is a switch from Falcon
to RISC-V for the internal microcontroller, which brings along
a change in how the engine is booted. Otherwise it is backwards
compatible with earlier versions.

In previous iterations, firmware was simply loaded from disk and
written into engine internal memory. Now, the engine has a
bootrom that loads the firmware from a carveout where it has been
loaded by the system bootloader; however, we still need to tell it
where that carveout is loaded and some offsets into it. For that,
the first patch adds a new memory controller API to query the
carveout address. The offsets are read from device tree -- the
expectation is that at flashing time (when the firmware is also
flashed), the flasher also delivers a device tree overlay with
values corresponding to the flashed firmware.

The currently available Linux for Tegra release doesn't yet
include this device tree overlay flashing, and the firmware version
it contains is incompatible with this series. The plan is to fix
that for the next Linux for Tegra release, but if necessary, we
can postpone merging of this series to once those changes are
available.

Thanks!
Mikko

Mikko Perttunen (8):
  memory: tegra: Add API for retrieving carveout bounds
  dt-bindings: Add headers for NVDEC on Tegra234
  dt-bindings: Add bindings for Tegra234 NVDEC
  arm64: tegra: Add NVDEC on Tegra234
  gpu: host1x: Add stream ID register data for NVDEC on Tegra234
  drm/tegra: nvdec: Support multiple clocks
  drm/tegra: Add code for booting RISC-V based engines
  drm/tegra: Add Tegra234 support to NVDEC driver

 .../gpu/host1x/nvidia,tegra210-nvdec.yaml     | 118 ++++++++++--
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  27 +++
 drivers/gpu/drm/tegra/Makefile                |   3 +-
 drivers/gpu/drm/tegra/drm.c                   |   1 +
 drivers/gpu/drm/tegra/nvdec.c                 | 171 +++++++++++++++---
 drivers/gpu/drm/tegra/riscv.c                 | 106 +++++++++++
 drivers/gpu/drm/tegra/riscv.h                 |  30 +++
 drivers/gpu/host1x/dev.c                      |  12 ++
 drivers/memory/tegra/mc.c                     |  23 +++
 drivers/memory/tegra/tegra234.c               |   5 +
 include/dt-bindings/clock/tegra234-clock.h    |   4 +
 include/dt-bindings/memory/tegra234-mc.h      |   3 +
 .../dt-bindings/power/tegra234-powergate.h    |   1 +
 include/dt-bindings/reset/tegra234-reset.h    |   1 +
 include/soc/tegra/mc.h                        |  11 ++
 15 files changed, 470 insertions(+), 46 deletions(-)
 create mode 100644 drivers/gpu/drm/tegra/riscv.c
 create mode 100644 drivers/gpu/drm/tegra/riscv.h

-- 
2.37.0

