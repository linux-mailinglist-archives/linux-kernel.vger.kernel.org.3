Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35B4A38BA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356026AbiA3Thg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:37:36 -0500
Received: from ptr.189.cn ([183.61.185.104]:11596 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbiA3Thd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:37:33 -0500
HMM_SOURCE_IP: 10.64.8.43:33340.1172243748
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 1767A1001DC;
        Mon, 31 Jan 2022 03:37:27 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 036610d50f3c4c03a09489c6a03ad3a0 for l.stach@pengutronix.de;
        Mon, 31 Jan 2022 03:37:30 CST
X-Transaction-ID: 036610d50f3c4c03a09489c6a03ad3a0
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
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
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 0/1] drm/lsdc: add drm driver for loongson display controller
Date:   Mon, 31 Jan 2022 03:37:22 +0800
Message-Id: <20220130193723.2923-1-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: fix more grammar mistakes in Kconfig reported by Randy Dunlap and give
    more details about lsdc.
v2: fixup warnings reported by kernel test robot

There is a display controller in loongson's LS2K1000 SoC and LS7A1000
bridge, and the DC in those chip is a PCI device. This display controller
have two display pipes but with only one hardware cursor. Each way has a
DVO output interface and the CRTC is able to scanout from 1920x1080
resolution at 60Hz.

  +----------+          +-----------------------+------------+
  | LS3A4000 |<-------->|         LS7A1000      |    DDR3    |   +------+
  |    CPU   |  HT Bus  | +--------+  +-------+ |    1333    |<->| VRAM |
  | LS3A5000 |<-------->| | GC1000 |  |  LSDC | | controller |   +------+
  +----------+          | +--------+  +-+---+-+ +------------|
                        +---------------|---|----------------+
                                        |   |
                    +-------+    DVO0   |   |  DVO1  +------+
                    |ADV7125|-----------+   +------->|TFP410|--> DVI/HDMI
                    +-------+                        +------+

The above picture give a simple usage, the encoder is not necessary adv7125
or tfp410, it is a choice of the downstream board manufacturer. Other
candicate encoder can be ch7034b, sil9022 and ite66121 etc this is the
reason why we still need device to provide board specific information.
The downstream kernel use self made vbios instead of device tree which
is hard to upstream. The display controller is uncommon outside of china,
it don't have rich document either. Nevertheless, this patch try to provided
a minimal support for this display controller which is for graphic
environment bring up. Hope that the code can speak for itself.

For ls7a1000, there are 4 gpios who register is located at dc register
space which is used to emulation i2c. LS2K1000 and LS2K0500 SoC don't
have those hardware, they use general purpose gpio or hardware i2c to
serve this purpose. For ladc, there is only a 1:1 mapping of encoders
and connectors.

     +-------------------+                                      _________
     |                   |                                     |         |
     |  CRTC0 --> DVO0 ---------> Encoder0 --> Connector0 ---> | Monotor |
     |                   |           ^            ^            |_________|
     |                   |           |            |
     |                <----- i2c0 ----------------+
     |   LSDC IP CORE    |
     |                <----- i2c1 ----------------+
     |                   |           |            |             _________
     |                   |           |            |            |         |
     |  CRTC1 --> DVO1 ---------> Encoder1 --> Connector1 ---> |  Panel  |
     |                   |                                     |_________|
     +-------------------+

Below is a brief introduction of loongson's CPU, bridge chip and SoC.
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

Reported-by: Randy Dunlap <rdunlap@infradead.org>
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
 drivers/gpu/drm/lsdc/lsdc_plane.c     | 688 +++++++++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_pll.c       | 605 +++++++++++++++++++
 drivers/gpu/drm/lsdc/lsdc_pll.h       | 109 ++++
 drivers/gpu/drm/lsdc/lsdc_regs.h      | 242 ++++++++
 18 files changed, 4149 insertions(+)
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

