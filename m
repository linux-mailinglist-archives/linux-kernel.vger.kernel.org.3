Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D841489E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiAJRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:10:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237934AbiAJRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:10:15 -0500
X-UUID: 219266a0adf046259f1f7bfeeb831682-20220111
X-UUID: 219266a0adf046259f1f7bfeeb831682-20220111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 701850342; Tue, 11 Jan 2022 01:10:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 01:10:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 01:10:10 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/3] clk: mediatek: support COMMON_CLK_MT8192 module build
Date:   Tue, 11 Jan 2022 01:09:59 +0800
Message-ID: <20220110171000.24316-4-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110171000.24316-1-miles.chen@mediatek.com>
References: <20220110171000.24316-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support COMMON_CLK_MT8192* module build,
add MODULE_LICENSE and include module.h.

Cc: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                  | 26 +++++++++----------
 drivers/clk/mediatek/clk-mt8192-aud.c         |  4 ++-
 drivers/clk/mediatek/clk-mt8192-cam.c         |  4 ++-
 drivers/clk/mediatek/clk-mt8192-img.c         |  4 ++-
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  4 ++-
 drivers/clk/mediatek/clk-mt8192-ipe.c         |  4 ++-
 drivers/clk/mediatek/clk-mt8192-mdp.c         |  4 ++-
 drivers/clk/mediatek/clk-mt8192-mfg.c         |  4 ++-
 drivers/clk/mediatek/clk-mt8192-mm.c          |  4 ++-
 drivers/clk/mediatek/clk-mt8192-msdc.c        |  4 ++-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |  4 ++-
 drivers/clk/mediatek/clk-mt8192-vdec.c        |  4 ++-
 drivers/clk/mediatek/clk-mt8192-venc.c        |  4 ++-
 drivers/clk/mediatek/clk-mt8192.c             |  2 ++
 14 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 3ce6fb04d8ff..b2205caf673f 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -496,7 +496,7 @@ config COMMON_CLK_MT8183_VENCSYS
 	  This driver supports MediaTek MT8183 vencsys clocks.
 
 config COMMON_CLK_MT8192
-	bool "Clock driver for MediaTek MT8192"
+	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARM64
@@ -504,73 +504,73 @@ config COMMON_CLK_MT8192
 	  This driver supports MediaTek MT8192 basic clocks.
 
 config COMMON_CLK_MT8192_AUDSYS
-	bool "Clock driver for MediaTek MT8192 audsys"
+	tristate "Clock driver for MediaTek MT8192 audsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 audsys clocks.
 
 config COMMON_CLK_MT8192_CAMSYS
-	bool "Clock driver for MediaTek MT8192 camsys"
+	tristate "Clock driver for MediaTek MT8192 camsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 camsys and camsys_raw clocks.
 
 config COMMON_CLK_MT8192_IMGSYS
-	bool "Clock driver for MediaTek MT8192 imgsys"
+	tristate "Clock driver for MediaTek MT8192 imgsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 imgsys and imgsys2 clocks.
 
 config COMMON_CLK_MT8192_IMP_IIC_WRAP
-	bool "Clock driver for MediaTek MT8192 imp_iic_wrap"
+	tristate "Clock driver for MediaTek MT8192 imp_iic_wrap"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 imp_iic_wrap clocks.
 
 config COMMON_CLK_MT8192_IPESYS
-	bool "Clock driver for MediaTek MT8192 ipesys"
+	tristate "Clock driver for MediaTek MT8192 ipesys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 ipesys clocks.
 
 config COMMON_CLK_MT8192_MDPSYS
-	bool "Clock driver for MediaTek MT8192 mdpsys"
+	tristate "Clock driver for MediaTek MT8192 mdpsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mdpsys clocks.
 
 config COMMON_CLK_MT8192_MFGCFG
-	bool "Clock driver for MediaTek MT8192 mfgcfg"
+	tristate "Clock driver for MediaTek MT8192 mfgcfg"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mfgcfg clocks.
 
 config COMMON_CLK_MT8192_MMSYS
-	bool "Clock driver for MediaTek MT8192 mmsys"
+	tristate "Clock driver for MediaTek MT8192 mmsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mmsys clocks.
 
 config COMMON_CLK_MT8192_MSDC
-	bool "Clock driver for MediaTek MT8192 msdc"
+	tristate "Clock driver for MediaTek MT8192 msdc"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 msdc and msdc_top clocks.
 
 config COMMON_CLK_MT8192_SCP_ADSP
-	bool "Clock driver for MediaTek MT8192 scp_adsp"
+	tristate "Clock driver for MediaTek MT8192 scp_adsp"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 scp_adsp clocks.
 
 config COMMON_CLK_MT8192_VDECSYS
-	bool "Clock driver for MediaTek MT8192 vdecsys"
+	tristate "Clock driver for MediaTek MT8192 vdecsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 vdecsys and vdecsys_soc clocks.
 
 config COMMON_CLK_MT8192_VENCSYS
-	bool "Clock driver for MediaTek MT8192 vencsys"
+	tristate "Clock driver for MediaTek MT8192 vencsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 vencsys clocks.
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index f28d56628045..ea512fa3d4b9 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
@@ -115,4 +116,5 @@ static struct platform_driver clk_mt8192_aud_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_aud_drv);
+module_platform_driver(clk_mt8192_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index fc74cd80b4b0..04a0de364408 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -104,4 +105,5 @@ static struct platform_driver clk_mt8192_cam_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_cam_drv);
+module_platform_driver(clk_mt8192_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index 7ce3abe42577..54713a5f3dfc 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -67,4 +68,5 @@ static struct platform_driver clk_mt8192_img_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_img_drv);
+module_platform_driver(clk_mt8192_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index 700356ac6a58..94fdb3c1a963 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -116,4 +117,5 @@ static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_imp_iic_wrap_drv);
+module_platform_driver(clk_mt8192_imp_iic_wrap_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 730d91b64b3f..7f8a7a60e2bd 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -54,4 +55,5 @@ static struct platform_driver clk_mt8192_ipe_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_ipe_drv);
+module_platform_driver(clk_mt8192_ipe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index 93c87ae2f332..9eab7337fabe 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -79,4 +80,5 @@ static struct platform_driver clk_mt8192_mdp_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_mdp_drv);
+module_platform_driver(clk_mt8192_mdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index 3bbc7469f0e4..8b44f0779a8c 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -47,4 +48,5 @@ static struct platform_driver clk_mt8192_mfg_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_mfg_drv);
+module_platform_driver(clk_mt8192_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 4a0b4c4bc06a..506beb5a410d 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "clk-mtk.h"
@@ -105,4 +106,5 @@ static struct platform_driver clk_mt8192_mm_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_mm_drv);
+module_platform_driver(clk_mt8192_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 87c3b79b79cf..a467885abbf8 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -82,4 +83,5 @@ static struct platform_driver clk_mt8192_msdc_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_msdc_drv);
+module_platform_driver(clk_mt8192_msdc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 58725d79dd13..87fbd0131aed 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -47,4 +48,5 @@ static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_scp_adsp_drv);
+module_platform_driver(clk_mt8192_scp_adsp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index b1d95cfbf22a..4d223ecca2c8 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -91,4 +92,5 @@ static struct platform_driver clk_mt8192_vdec_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_vdec_drv);
+module_platform_driver(clk_mt8192_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index c0d867bff09e..0e8092802771 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
@@ -50,4 +51,5 @@ static struct platform_driver clk_mt8192_venc_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt8192_venc_drv);
+module_platform_driver(clk_mt8192_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 552fae4f0fd5..a221834db347 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -1313,3 +1314,4 @@ static int __init clk_mt8192_init(void)
 }
 
 arch_initcall(clk_mt8192_init);
+MODULE_LICENSE("GPL");
-- 
2.18.0

