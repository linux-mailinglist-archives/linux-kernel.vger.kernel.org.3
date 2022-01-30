Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83924A34A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354185AbiA3GE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 01:04:26 -0500
Received: from ptr.189.cn ([183.61.185.103]:11466 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233771AbiA3GEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 01:04:25 -0500
HMM_SOURCE_IP: 10.64.8.31:42436.1478280989
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 22C881001DD;
        Sun, 30 Jan 2022 14:04:17 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 93f8625f5ef34d5db5f52ead6b8105e1 for l.stach@pengutronix.de;
        Sun, 30 Jan 2022 14:04:18 CST
X-Transaction-ID: 93f8625f5ef34d5db5f52ead6b8105e1
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 0/1] drm/lsdc: add drm driver for loongson display controller
Date:   Sun, 30 Jan 2022 14:04:11 +0800
Message-Id: <20220130060412.12100-1-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: fixup warnings reported by kernel test robot

There is a display controller in loongson's LS2K1000 SoC and LS7A1000
bridge, and the DC in those chip is a PCI device. This display controller
have two display pipes but with only one hardware cursor.

This display controller is uncommon outside of china, it don't have rich
document either. This patch try to provided a minimal support for this
display controller which is for graphic environment bring up. Hope the
code can speak for itself.

For ls7a1000, there are 4 gpios who register is located at dc register
space which is used to emulation i2c. LS2K1000 and LS2K0500 SoC don't
have those hardware, they use general purpose gpio or hardware i2c to
serve this purpose.

LS2K1000 is a double core 1.0Ghz mips64r2 compatible SoC[1]. LS7A1000 is
a bridge chip made by Loongson corporation which act as north and/or south
bridge of loongson's desktop and server level processor. It is equivalent
to RS780E or something like that. More details can be read from its user
manual[2].

This bridge chip is typically use with LS3A3000, LS3A4000 and LS3A5000 cpu.
LS3A3000 is 4 core 1.45gHz mips64r2 compatible cpu.
LS3A4000 is 4 core 1.8gHz mips64r5 compatible cpu.
LS3A5000 is 4 core 2.5gHz loongarch cpu[3].

[1] https://wiki.debian.org/InstallingDebianOn/Lemote/Loongson2K1000
[2] https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanual-EN.html
[3] https://loongson.github.io/LoongArch-Documentation/Loongson-3A5000-usermanual-EN.html

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>

suijingfeng (1):
  drm/lsdc: add drm driver for loongson display controller

 drivers/gpu/drm/Kconfig               |   2 +
 drivers/gpu/drm/Makefile              |   1 +
 drivers/gpu/drm/lsdc/Kconfig          |  38 ++
 drivers/gpu/drm/lsdc/Makefile         |  15 +
 drivers/gpu/drm/lsdc/lsdc_connector.c | 439 ++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_connector.h |  60 ++
 drivers/gpu/drm/lsdc/lsdc_crtc.c      | 438 ++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_drv.c       | 824 ++++++++++++++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_drv.h       | 214 +++++++
 drivers/gpu/drm/lsdc/lsdc_encoder.c   |  79 +++
 drivers/gpu/drm/lsdc/lsdc_i2c.c       | 220 +++++++
 drivers/gpu/drm/lsdc/lsdc_i2c.h       |  61 ++
 drivers/gpu/drm/lsdc/lsdc_irq.c       |  77 +++
 drivers/gpu/drm/lsdc/lsdc_irq.h       |  37 ++
 drivers/gpu/drm/lsdc/lsdc_plane.c     | 694 ++++++++++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_pll.c       | 605 +++++++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_pll.h       | 109 ++++
 drivers/gpu/drm/lsdc/lsdc_regs.h      | 242 ++++++++
 18 files changed, 4155 insertions(+)
 create mode 100644 drivers/gpu/drm/lsdc/Kconfig
 create mode 100644 drivers/gpu/drm/lsdc/Makefile
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_connector.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_connector.h
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_crtc.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_drv.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_drv.h
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_encoder.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_i2c.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_i2c.h
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_irq.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_irq.h
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_plane.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_pll.c
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_pll.h
 create mode 100644 drivers/gpu/drm/lsdc/lsdc_regs.h

-- 
2.20.1

