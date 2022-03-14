Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB64D89EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiCNQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243272AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EE1DA4A;
        Mon, 14 Mar 2022 09:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B7D614A7;
        Mon, 14 Mar 2022 16:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F099DC36AF3;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275710;
        bh=6J1DzTdLkt+wtXSOn8LeDPwVonbZUY5PijYr2Jghub0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFhfASKbQ5Adc/Ua36MwdM8AQZphIR6W+Klt0QtRYncnRVPrahg+uIVqSqJEo0h8r
         5WjnQ+TO2B/G/kp+F11CdfsRGR0pr0jx/5nuSOzRBhNpJAlld/vslHa1k19KX/PlOb
         lZcE1/UO4c5xAa0xFzIF9KaM8yAyqk+f3d/Zn1ipDT+qgkZ0GRMn+GWQDrXdZDpu/9
         c2108w2hJIXtl0tTl95H3zXASEF8cF+SGpc25+ZFFRRQSbiI9PGDLJHgM/PiRNVdpX
         8YZ+dti1GEgCFhVcIcEf1zw0SgK88ZPzCZ4Z+ssG1yVdjiQTxm4pehLzVzTFuNcI9d
         +TtaZegWIh9Tw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x4O-Mk; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>, Pratyush Yadav <p.yadav@ti.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 63/67] media: platform: Create vendor/{Makefile,Kconfig} files
Date:   Mon, 14 Mar 2022 17:34:58 +0100
Message-Id: <619701b36108067a84c606d7a2016cf8c3ec33b9.1647274407.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of placing multiple per-vendor entries at the
platform/{Makefile,Kconfig}, create them at the per-vendor
directories.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 28 +++++-------------------
 drivers/media/platform/Makefile          | 28 ++++++------------------
 drivers/media/platform/amlogic/Kconfig   |  2 ++
 drivers/media/platform/amlogic/Makefile  |  2 ++
 drivers/media/platform/amphion/Kconfig   |  3 +++
 drivers/media/platform/mediatek/Kconfig  |  5 +++++
 drivers/media/platform/mediatek/Makefile |  5 +++++
 drivers/media/platform/nvidia/Kconfig    |  2 ++
 drivers/media/platform/qcom/Makefile     |  3 +++
 drivers/media/platform/rockchip/Makefile |  3 +++
 drivers/media/platform/samsung/Kconfig   |  7 ++++++
 drivers/media/platform/samsung/Makefile  |  7 ++++++
 drivers/media/platform/stm/Kconfig       |  4 ++++
 drivers/media/platform/stm/Makefile      |  7 ++++++
 drivers/media/platform/stm/sti/Makefile  |  6 +++++
 drivers/media/platform/ti/Kconfig        |  5 +++++
 drivers/media/platform/ti/Makefile       |  6 ++++-
 17 files changed, 79 insertions(+), 44 deletions(-)
 create mode 100644 drivers/media/platform/amlogic/Kconfig
 create mode 100644 drivers/media/platform/amlogic/Makefile
 create mode 100644 drivers/media/platform/mediatek/Kconfig
 create mode 100644 drivers/media/platform/mediatek/Makefile
 create mode 100644 drivers/media/platform/nvidia/Kconfig
 create mode 100644 drivers/media/platform/qcom/Makefile
 create mode 100644 drivers/media/platform/rockchip/Makefile
 create mode 100644 drivers/media/platform/samsung/Kconfig
 create mode 100644 drivers/media/platform/samsung/Makefile
 create mode 100644 drivers/media/platform/stm/Kconfig
 create mode 100644 drivers/media/platform/stm/Makefile
 create mode 100644 drivers/media/platform/stm/sti/Makefile

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 43a654e87613..3a5211d8e59a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,12 +62,9 @@ config VIDEO_MUX
 	  This driver provides support for N:1 video bus multiplexers.
 
 # Platform drivers - Please keep it alphabetically sorted
-
-# TODO: create per-manufacturer directories
-
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/allwinner/Kconfig"
-source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
+source "drivers/media/platform/amlogic/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
@@ -75,28 +72,15 @@ source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/chips-media/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
-source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
-source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
-source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
-source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
-source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
+source "drivers/media/platform/mediatek/Kconfig"
+source "drivers/media/platform/nvidia/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
-source "drivers/media/platform/samsung/exynos4-is/Kconfig"
-source "drivers/media/platform/samsung/s3c-camif/Kconfig"
-source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
-source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
-source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
-source "drivers/media/platform/stm/sti/Kconfig"
-source "drivers/media/platform/stm/stm32/Kconfig"
-source "drivers/media/platform/ti-vpe/Kconfig"
-source "drivers/media/platform/ti/am437x/Kconfig"
-source "drivers/media/platform/ti/davinci/Kconfig"
-source "drivers/media/platform/ti/omap/Kconfig"
-source "drivers/media/platform/ti/omap3isp/Kconfig"
+source "drivers/media/platform/samsung/Kconfig"
+source "drivers/media/platform/stm/Kconfig"
+source "drivers/media/platform/ti/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 2c5713ddac09..e5060cb891de 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,7 +7,7 @@
 # (e. g. LC_ALL=C sort Makefile)
 obj-y += allegro-dvt/
 obj-y += allwinner/
-obj-y += amlogic/meson-ge2d/
+obj-y += amlogic/
 obj-y += amphion/
 obj-y += aspeed/
 obj-y += atmel/
@@ -15,28 +15,14 @@ obj-y += cadence/
 obj-y += chips-media/
 obj-y += intel/
 obj-y += marvell/
-obj-y += mediatek/mtk-jpeg/
-obj-y += mediatek/mtk-mdp/
-obj-y += mediatek/mtk-vcodec/
-obj-y += mediatek/mtk-vpu/
-obj-y += nvidia/tegra-vde/
+obj-y += mediatek/
+obj-y += nvidia/
 obj-y += nxp/
-obj-y += qcom/camss/
-obj-y += qcom/venus/
+obj-y += qcom/
 obj-y += renesas/
-obj-y += rockchip/rga/
-obj-y += rockchip/rkisp1/
-obj-y += samsung/exynos-gsc/
-obj-y += samsung/exynos4-is/
-obj-y += samsung/s3c-camif/
-obj-y += samsung/s5p-g2d/
-obj-y += samsung/s5p-jpeg/
-obj-y += samsung/s5p-mfc/
-obj-y += stm/sti/bdisp/
-obj-y += stm/sti/c8sectpfe/
-obj-y += stm/sti/delta/
-obj-y += stm/sti/hva/
-obj-y += stm/stm32/
+obj-y += rockchip/
+obj-y += samsung/
+obj-y += stm/
 obj-y += ti/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/amlogic/Kconfig b/drivers/media/platform/amlogic/Kconfig
new file mode 100644
index 000000000000..c67e00df6202
--- /dev/null
+++ b/drivers/media/platform/amlogic/Kconfig
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
diff --git a/drivers/media/platform/amlogic/Makefile b/drivers/media/platform/amlogic/Makefile
new file mode 100644
index 000000000000..d3cdb8fa4ddb
--- /dev/null
+++ b/drivers/media/platform/amlogic/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += meson-ge2d/
diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/amphion/Kconfig
index 13899649f766..e0e8098965bd 100644
--- a/drivers/media/platform/amphion/Kconfig
+++ b/drivers/media/platform/amphion/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+comment "Amphion drivers"
+
 config VIDEO_AMPHION_VPU
 	tristate "Amphion VPU (Video Processing Unit) Codec IP"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/mediatek/Kconfig b/drivers/media/platform/mediatek/Kconfig
new file mode 100644
index 000000000000..6d74839df3d6
--- /dev/null
+++ b/drivers/media/platform/mediatek/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
+source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
+source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
+source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
diff --git a/drivers/media/platform/mediatek/Makefile b/drivers/media/platform/mediatek/Makefile
new file mode 100644
index 000000000000..403d5ecd2b10
--- /dev/null
+++ b/drivers/media/platform/mediatek/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += mtk-jpeg/
+obj-y += mtk-mdp/
+obj-y += mtk-vcodec/
+obj-y += mtk-vpu/
diff --git a/drivers/media/platform/nvidia/Kconfig b/drivers/media/platform/nvidia/Kconfig
new file mode 100644
index 000000000000..1162e272b5f9
--- /dev/null
+++ b/drivers/media/platform/nvidia/Kconfig
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
diff --git a/drivers/media/platform/qcom/Makefile b/drivers/media/platform/qcom/Makefile
new file mode 100644
index 000000000000..4f055c396e04
--- /dev/null
+++ b/drivers/media/platform/qcom/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += camss/
+obj-y += venus/
diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/platform/rockchip/Makefile
new file mode 100644
index 000000000000..4f782b876ac9
--- /dev/null
+++ b/drivers/media/platform/rockchip/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += rga/
+obj-y += rkisp1/
diff --git a/drivers/media/platform/samsung/Kconfig b/drivers/media/platform/samsung/Kconfig
new file mode 100644
index 000000000000..94f30c1bca9b
--- /dev/null
+++ b/drivers/media/platform/samsung/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
+source "drivers/media/platform/samsung/exynos4-is/Kconfig"
+source "drivers/media/platform/samsung/s3c-camif/Kconfig"
+source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
+source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
+source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
diff --git a/drivers/media/platform/samsung/Makefile b/drivers/media/platform/samsung/Makefile
new file mode 100644
index 000000000000..21fea3330e4b
--- /dev/null
+++ b/drivers/media/platform/samsung/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += exynos-gsc/
+obj-y += exynos4-is/
+obj-y += s3c-camif/
+obj-y += s5p-g2d/
+obj-y += s5p-jpeg/
+obj-y += s5p-mfc/
diff --git a/drivers/media/platform/stm/Kconfig b/drivers/media/platform/stm/Kconfig
new file mode 100644
index 000000000000..27942626a630
--- /dev/null
+++ b/drivers/media/platform/stm/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "drivers/media/platform/stm/sti/Kconfig"
+source "drivers/media/platform/stm/stm32/Kconfig"
diff --git a/drivers/media/platform/stm/Makefile b/drivers/media/platform/stm/Makefile
new file mode 100644
index 000000000000..a1f75b2a8225
--- /dev/null
+++ b/drivers/media/platform/stm/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += sti/bdisp/
+obj-y += sti/c8sectpfe/
+obj-y += sti/delta/
+obj-y += sti/hva/
+obj-y += stm32/
diff --git a/drivers/media/platform/stm/sti/Makefile b/drivers/media/platform/stm/sti/Makefile
new file mode 100644
index 000000000000..f9ce8169b040
--- /dev/null
+++ b/drivers/media/platform/stm/sti/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += bdisp/
+obj-y += c8sectpfe/
+obj-y += delta/
+obj-y += hva/
+obj-y += stm32/
diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform/ti/Kconfig
index 82e285c2de64..e1ab56c3be1f 100644
--- a/drivers/media/platform/ti/Kconfig
+++ b/drivers/media/platform/ti/Kconfig
@@ -62,3 +62,8 @@ config VIDEO_TI_VPE_DEBUG
 	depends on VIDEO_TI_VPE
 	help
 	  Enable debug messages on VPE driver.
+
+source "drivers/media/platform/ti/am437x/Kconfig"
+source "drivers/media/platform/ti/davinci/Kconfig"
+source "drivers/media/platform/ti/omap/Kconfig"
+source "drivers/media/platform/ti/omap3isp/Kconfig"
diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platform/ti/Makefile
index bbc737ccbbea..98c5fe5c40d6 100644
--- a/drivers/media/platform/ti/Makefile
+++ b/drivers/media/platform/ti/Makefile
@@ -1,3 +1,7 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += am437x/
 obj-y += cal/
 obj-y += vpe/
+obj-y += davinci/
+obj-y += omap/
+obj-y += omap3isp/
-- 
2.35.1

