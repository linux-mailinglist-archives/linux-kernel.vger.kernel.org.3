Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123124D7CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiCNIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E077B41980;
        Mon, 14 Mar 2022 00:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C61611EE;
        Mon, 14 Mar 2022 07:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C83C341DF;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244563;
        bh=CG9uAjVdPXiUWjH3qQXR/bMbwuprj1OVOqMx1CbvvGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTl4znB3nadho8hykHnZnOAG2QHFWqDB2oNfSaw8qzAxqVu98VuJp02nOeS+Lmd2y
         KeskzAqbZTKS60sGMXAbW/mNA1kC8NQD/pIkePyJzKPu9B6rP27Vqeqjx+Wmtk4UmX
         VdjLEAVGScnQoL8p0CKFhCMpXS5qGx7U166mb6cEWVnjA3EezB6pAHonzZa2gYmX+D
         yJkiz1fSniI02cqAzJ1RvfXL79m7OQgy0etwdtqY/q/BrY5lEoElL/lPEcXuxP5f3v
         qewuwaKhN2+aQu4DfucyL48e7A4ubNq2AkDMzJBm1XdcRZ15OkSHONSgrvrKKQUG0t
         twuw2AJG7W6eg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kYB-Vh; Mon, 14 Mar 2022 08:56:00 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
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
        Ming Qian <ming.qian@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 62/64] media: platform: Create vendor/{Makefile,Kconfig} files
Date:   Mon, 14 Mar 2022 08:55:54 +0100
Message-Id: <08f24bffc56840cd2d07905338efcab68872795d.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
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
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig             | 27 ++++-------------
 drivers/media/platform/Makefile            | 35 +++++-----------------
 drivers/media/platform/amlogic/Kconfig     |  2 ++
 drivers/media/platform/amlogic/Makefile    |  2 ++
 drivers/media/platform/mediatek/Kconfig    |  5 ++++
 drivers/media/platform/mediatek/Makefile   |  5 ++++
 drivers/media/platform/nvidia/Kconfig      |  2 ++
 drivers/media/platform/nxp/Kconfig         |  1 +
 drivers/media/platform/nxp/Makefile        |  1 +
 drivers/media/platform/nxp/amphion/Kconfig |  1 +
 drivers/media/platform/qcom/Makefile       |  3 ++
 drivers/media/platform/rockchip/Makefile   |  3 ++
 drivers/media/platform/samsung/Kconfig     |  7 +++++
 drivers/media/platform/samsung/Makefile    |  7 +++++
 drivers/media/platform/sti/Kconfig         |  1 +
 drivers/media/platform/sti/Makefile        |  6 ++++
 drivers/media/platform/ti/Kconfig          |  6 ++++
 drivers/media/platform/ti/Makefile         |  6 ++++
 18 files changed, 71 insertions(+), 49 deletions(-)
 create mode 100644 drivers/media/platform/amlogic/Kconfig
 create mode 100644 drivers/media/platform/amlogic/Makefile
 create mode 100644 drivers/media/platform/mediatek/Kconfig
 create mode 100644 drivers/media/platform/mediatek/Makefile
 create mode 100644 drivers/media/platform/nvidia/Kconfig
 create mode 100644 drivers/media/platform/qcom/Makefile
 create mode 100644 drivers/media/platform/rockchip/Makefile
 create mode 100644 drivers/media/platform/samsung/Kconfig
 create mode 100644 drivers/media/platform/samsung/Makefile
 create mode 100644 drivers/media/platform/sti/Makefile
 create mode 100644 drivers/media/platform/ti/Kconfig
 create mode 100644 drivers/media/platform/ti/Makefile

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 05b720ac0961..8bd92e4f4d9b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,41 +62,24 @@ config VIDEO_MUX
 	  This driver provides support for N:1 video bus multiplexers.
 
 # Platform drivers - Please keep it alphabetically sorted
-
-# TODO: create per-manufacturer directories
-
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/allwinner/Kconfig"
-source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
+source "drivers/media/platform/amlogic/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
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
-source "drivers/media/platform/nxp/amphion/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
-source "drivers/media/platform/samsung/exynos4-is/Kconfig"
-source "drivers/media/platform/samsung/s3c-camif/Kconfig"
-source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
-source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
-source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
+source "drivers/media/platform/samsung/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
-source "drivers/media/platform/sti/stm32/Kconfig"
-source "drivers/media/platform/ti/am437x/Kconfig"
-source "drivers/media/platform/ti/davinci/Kconfig"
-source "drivers/media/platform/ti/omap/Kconfig"
-source "drivers/media/platform/ti/omap3isp/Kconfig"
-source "drivers/media/platform/ti/vpe/Kconfig"
+source "drivers/media/platform/ti/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 1e62a4009b6c..5b14b231140b 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,41 +7,22 @@
 # (e. g. LC_ALL=C sort Makefile)
 obj-y += allegro-dvt/
 obj-y += allwinner/
-obj-y += amlogic/meson-ge2d/
+obj-y += amlogic/
 obj-y += aspeed/
 obj-y += atmel/
 obj-y += cadence/
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
-obj-y += nxp/amphion/
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
-obj-y += sti/bdisp/
-obj-y += sti/c8sectpfe/
-obj-y += sti/delta/
-obj-y += sti/hva/
-obj-y += sti/stm32/
-obj-y += ti/am437x/
-obj-y += ti/davinci/
-obj-y += ti/omap/
-obj-y += ti/omap3isp/
-obj-y += ti/vpe/
+obj-y += rockchip/
+obj-y += samsung/
+obj-y += sti/
+obj-y += ti/
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
diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
index df52d32ebe50..e82bfcd97ac7 100644
--- a/drivers/media/platform/nxp/Kconfig
+++ b/drivers/media/platform/nxp/Kconfig
@@ -63,4 +63,5 @@ config VIDEO_MX2_EMMAPRP
 	    memory to memory. Operations include resizing and format
 	    conversion.
 
+source "drivers/media/platform/nxp/amphion/Kconfig"
 source "drivers/media/platform/nxp/imx-jpeg/Kconfig"
diff --git a/drivers/media/platform/nxp/Makefile b/drivers/media/platform/nxp/Makefile
index efc38c6578ce..c90de5b873ab 100644
--- a/drivers/media/platform/nxp/Makefile
+++ b/drivers/media/platform/nxp/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-y += amphion/
 obj-y += imx-jpeg/
 
 obj-$(CONFIG_VIDEO_IMX_MIPI_CSIS) += imx-mipi-csis.o
diff --git a/drivers/media/platform/nxp/amphion/Kconfig b/drivers/media/platform/nxp/amphion/Kconfig
index 13899649f766..679a5f8eb1a1 100644
--- a/drivers/media/platform/nxp/amphion/Kconfig
+++ b/drivers/media/platform/nxp/amphion/Kconfig
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
 config VIDEO_AMPHION_VPU
 	tristate "Amphion VPU (Video Processing Unit) Codec IP"
 	depends on V4L_MEM2MEM_DRIVERS
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
diff --git a/drivers/media/platform/sti/Kconfig b/drivers/media/platform/sti/Kconfig
index 9fb5e78a92cf..d5423743d905 100644
--- a/drivers/media/platform/sti/Kconfig
+++ b/drivers/media/platform/sti/Kconfig
@@ -3,3 +3,4 @@ source "drivers/media/platform/sti/bdisp/Kconfig"
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
 source "drivers/media/platform/sti/delta/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
+source "drivers/media/platform/sti/stm32/Kconfig"
diff --git a/drivers/media/platform/sti/Makefile b/drivers/media/platform/sti/Makefile
new file mode 100644
index 000000000000..f9ce8169b040
--- /dev/null
+++ b/drivers/media/platform/sti/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += bdisp/
+obj-y += c8sectpfe/
+obj-y += delta/
+obj-y += hva/
+obj-y += stm32/
diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform/ti/Kconfig
new file mode 100644
index 000000000000..f422c68f4a99
--- /dev/null
+++ b/drivers/media/platform/ti/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/ti/am437x/Kconfig"
+source "drivers/media/platform/ti/davinci/Kconfig"
+source "drivers/media/platform/ti/omap/Kconfig"
+source "drivers/media/platform/ti/omap3isp/Kconfig"
+source "drivers/media/platform/ti/vpe/Kconfig"
diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platform/ti/Makefile
new file mode 100644
index 000000000000..f04e371869a1
--- /dev/null
+++ b/drivers/media/platform/ti/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += am437x/
+obj-y += davinci/
+obj-y += omap/
+obj-y += omap3isp/
+obj-y += vpe/
-- 
2.35.1

