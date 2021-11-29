Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD84622D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhK2VF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhK2VDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:03:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB695C12530D;
        Mon, 29 Nov 2021 10:26:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so38830808wrw.10;
        Mon, 29 Nov 2021 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMHGW0dp6anAYz4rgdfyvi7/royFZ1sMFGeiqfNvQIU=;
        b=gElgIbxSyC9FCiyNceHH6WUzrchdMEEscgLDLdrverSUlSVn0bMJs72FU1EHG3PXbF
         jvP2hmBCSfjUma2EpXMyAigpBf9S6fcuwf4LXInhKDjOqwv9n7BfbywQYwdNcZJh984L
         IeshE+w+JmothVVWlpUkzzLq31xIxU1GC8LiJ8/NmMBw7Tuvva/wk4fUXcanzEr507YY
         8V53voQSb0zVnXOUmUcTf08RR+VsHzmXsiXYsUg0HZeouzUy7TkkPfIz/hSNeSod1hUB
         Lfg2THnoQvQGe9KDd8XDSWEomXsOz55vZ3l41+OhY4r1U7wN1VXAduXAvxJzwnd3VaKe
         gJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMHGW0dp6anAYz4rgdfyvi7/royFZ1sMFGeiqfNvQIU=;
        b=i+vpBXXCuglwKJBEi2SF8qLTWrrExs/jWBqsEtJWecIh7vUUjce6V8i4pGaN1RbKiL
         7Fdw56Zk1OK4K2Q9csLhG/DB+69FG1FXw5sllsDQBq6ZEUVkXFwTlF3WD3UxBUyMAoeZ
         8S8sAdMCSmFWn60Za6OWnMWh2nkkQI6tyXT8QNwpgXrwfP2L36cqV2Hy8kUs6XhTA20N
         dJeftONnLCiBQ16jW4LW0rWAoZ+BD/kHIh4DoCQ6tAS6/b8S8tXxRuRN5UWpWZ1C9CDx
         tdpek8hqG5yti/bkHvi9G7tK4B0Jcydt7z6mQSh6aUX/1bCupRgferxmyCmh46CZPDcY
         1eLA==
X-Gm-Message-State: AOAM5323jqNE+rxGDz28M7HDBKDtcG7iKRuDT11oEigU/gOSfKETnmBR
        pEM1N4Ez/d4nyC1EmmpEa19e60T+u5fGtg==
X-Google-Smtp-Source: ABdhPJw+PDB4R36ntcKkMsy30k0CBQkS2mehLtHVZDkx2QtUgjFMVp+NBWOFc4VjG75Bch+WIoFIZQ==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr37209227wrn.521.1638210409597;
        Mon, 29 Nov 2021 10:26:49 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:49 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 8/9] media: hantro: Add support for Allwinner H6
Date:   Mon, 29 Nov 2021 19:26:32 +0100
Message-Id: <20211129182633.480021-9-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a Hantro G2 core used for VP9 decoding. It's not clear
at this time if HEVC is also supported or not.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/Kconfig        | 10 ++-
 drivers/staging/media/hantro/Makefile       |  3 +
 drivers/staging/media/hantro/hantro_drv.c   |  3 +
 drivers/staging/media/hantro/hantro_hw.h    |  1 +
 drivers/staging/media/hantro/sunxi_vpu_hw.c | 86 +++++++++++++++++++++
 5 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/media/hantro/sunxi_vpu_hw.c

diff --git a/drivers/staging/media/hantro/Kconfig b/drivers/staging/media/hantro/Kconfig
index 00a57d88c92e..3c5d833322c8 100644
--- a/drivers/staging/media/hantro/Kconfig
+++ b/drivers/staging/media/hantro/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config VIDEO_HANTRO
 	tristate "Hantro VPU driver"
-	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select MEDIA_CONTROLLER
 	select MEDIA_CONTROLLER_REQUEST_API
@@ -40,3 +40,11 @@ config VIDEO_HANTRO_ROCKCHIP
 	default y
 	help
 	  Enable support for RK3288, RK3328, and RK3399 SoCs.
+
+config VIDEO_HANTRO_SUNXI
+	bool "Hantro VPU Allwinner support"
+	depends on VIDEO_HANTRO
+	depends on ARCH_SUNXI || COMPILE_TEST
+	default y
+	help
+	  Enable support for H6 SoC.
diff --git a/drivers/staging/media/hantro/Makefile b/drivers/staging/media/hantro/Makefile
index 28af0a1ee4bf..ebd5ede7bef7 100644
--- a/drivers/staging/media/hantro/Makefile
+++ b/drivers/staging/media/hantro/Makefile
@@ -33,3 +33,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_SAMA5D4) += \
 
 hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) += \
 		rockchip_vpu_hw.o
+
+hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
+		sunxi_vpu_hw.o
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 33bf78be145b..6a51f39dde56 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -620,6 +620,9 @@ static const struct of_device_id of_hantro_match[] = {
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
 	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
+#endif
+#ifdef CONFIG_VIDEO_HANTRO_SUNXI
+	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index c33b1f5df37b..c92a6ec4b187 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -308,6 +308,7 @@ extern const struct hantro_variant rk3288_vpu_variant;
 extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
+extern const struct hantro_variant sunxi_vpu_variant;
 
 extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
 extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
new file mode 100644
index 000000000000..90633406c4eb
--- /dev/null
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner Hantro G2 VPU codec driver
+ *
+ * Copyright (C) 2021 Jernej Skrabec <jernej.skrabec@gmail.com>
+ */
+
+#include <linux/clk.h>
+
+#include "hantro.h"
+
+static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.codec_mode = HANTRO_MODE_NONE,
+		.postprocessed = true,
+	},
+};
+
+static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
+		.codec_mode = HANTRO_MODE_VP9_DEC,
+		.max_depth = 2,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
+static int sunxi_vpu_hw_init(struct hantro_dev *vpu)
+{
+	clk_set_rate(vpu->clocks[0].clk, 300000000);
+
+	return 0;
+}
+
+static void sunxi_vpu_reset(struct hantro_ctx *ctx)
+{
+	struct hantro_dev *vpu = ctx->dev;
+
+	reset_control_reset(vpu->resets);
+}
+
+static const struct hantro_codec_ops sunxi_vpu_codec_ops[] = {
+	[HANTRO_MODE_VP9_DEC] = {
+		.run = hantro_g2_vp9_dec_run,
+		.done = hantro_g2_vp9_dec_done,
+		.reset = sunxi_vpu_reset,
+		.init = hantro_vp9_dec_init,
+		.exit = hantro_vp9_dec_exit,
+	},
+};
+
+static const struct hantro_irq sunxi_irqs[] = {
+	{ NULL, hantro_g2_irq },
+};
+
+static const char * const sunxi_clk_names[] = { "mod", "bus" };
+
+const struct hantro_variant sunxi_vpu_variant = {
+	.dec_fmts = sunxi_vpu_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(sunxi_vpu_dec_fmts),
+	.postproc_fmts = sunxi_vpu_postproc_fmts,
+	.num_postproc_fmts = ARRAY_SIZE(sunxi_vpu_postproc_fmts),
+	.postproc_ops = &hantro_g2_postproc_ops,
+	.codec = HANTRO_VP9_DECODER,
+	.codec_ops = sunxi_vpu_codec_ops,
+	.init = sunxi_vpu_hw_init,
+	.irqs = sunxi_irqs,
+	.num_irqs = ARRAY_SIZE(sunxi_irqs),
+	.clk_names = sunxi_clk_names,
+	.num_clocks = ARRAY_SIZE(sunxi_clk_names),
+	.double_buffer = 1,
+	.legacy_regs = 1,
+	.late_postproc = 1,
+};
-- 
2.34.1

