Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0B4BD058
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbiBTRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:33:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbiBTRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F08CF2;
        Sun, 20 Feb 2022 09:32:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t14so11458211ljh.8;
        Sun, 20 Feb 2022 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHRzTpt0uTYjv6UOxYxxg4YmNjXznV7r810Egh7wHFk=;
        b=j0wYUju45caLnf7rlT0OnKV0Sweov8K0HyGOXo+ufClRZAq09o+t27Oe15MHbUHbH9
         TY1p0f1eukLzlFU59DuQwd/C0MKhhL1g/nQ8NDN053ttQAJPVH9V/8ufnN+B6P+pSfpd
         5nJCfamORlvB+fwu+O4m4VrjVa0vfHuG8s2bFAMeOiO2QLONaAyj1dEcskfqjJ/OejnV
         lr9zMnKTKGUKRKjqjM1huEiDCaiwAxCFhE+Npm07X9WaCUToDW9+WIXEOguRhyU/Av+N
         T+ibrq3Qg/lROoqGhuIB16bY90DNxXmLYkm8qvyayXQOjjl2mqb57YtUt8nYGw9jwMEV
         CSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHRzTpt0uTYjv6UOxYxxg4YmNjXznV7r810Egh7wHFk=;
        b=w8dAoR1f54jnBVBU90oL12R9iCtQBAXp3gt0+Kc9Q9EWS84/mNdl6dozPOlZ+0S5X9
         iZ3Zk2PW9a4WR6g2zxzh/bVKolBkHaRc6kvufWug+YEjow1jfdhop1ggl50ctaFJ7sm1
         /0fStJAow2g8RHHTteWWvr/hOD9Dk3fkKVotqzCid55eoBcceawk6IEqA7olA5OQiVAp
         nyGn/6SafmFh7J4wEWwhsUdVcfiOLWdgSttMnRJGzBChPPAQfc1jY+nnF0JrRJJ3UBaY
         LPku9LvNCjzgCmx+I4Z8hQ8lTR4dy/EtVTVABoFOa5wWeZ1Esyw2Y4FOgNS35Lzi6SA6
         +J/A==
X-Gm-Message-State: AOAM532tsVUrYykVpcZN4qOqA/Aohme/ubaUtl0J5jUJFeIUIAZtHdOM
        uPxQ/Ggjmlz5ztXSkksAPts=
X-Google-Smtp-Source: ABdhPJw8iIlCbMEAgLB9yCGhbjcYgeDnlPocYNDBrBp+Sa1SWKbJgKl0NDib8lj4dpOlNW/ZuTM5UQ==
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id n19-20020a2ebd13000000b002461ff86da1mr9700590ljq.219.1645378328499;
        Sun, 20 Feb 2022 09:32:08 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] media: staging: tegra-vde: De-stage driver
Date:   Sun, 20 Feb 2022 20:29:48 +0300
Message-Id: <20220220172950.3401-7-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220172950.3401-1-digetx@gmail.com>
References: <20220220172950.3401-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TODO of tegra-vde driver has been completed, driver now supports
V4L2 stateless video decoding API. Relocate driver to drivers/media.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS                                     |  2 +-
 drivers/media/platform/Kconfig                  | 17 +++++++++++++++++
 drivers/media/platform/Makefile                 |  2 ++
 .../platform/tegra/vde}/Makefile                |  2 +-
 .../platform/tegra/vde}/dmabuf-cache.c          |  0
 .../platform/tegra/vde}/h264.c                  |  0
 .../platform/tegra/vde}/iommu.c                 |  0
 .../platform/tegra/vde}/trace.h                 |  2 +-
 .../platform/tegra/vde}/v4l2.c                  |  0
 .../platform/tegra/vde}/vde.c                   |  0
 .../platform/tegra/vde}/vde.h                   |  0
 drivers/staging/media/Kconfig                   |  2 --
 drivers/staging/media/Makefile                  |  1 -
 drivers/staging/media/tegra-vde/Kconfig         | 17 -----------------
 drivers/staging/media/tegra-vde/TODO            |  4 ----
 15 files changed, 22 insertions(+), 27 deletions(-)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/Makefile (67%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/dmabuf-cache.c (100%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/h264.c (100%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/iommu.c (100%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/trace.h (97%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/v4l2.c (100%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/vde.c (100%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/vde.h (100%)
 delete mode 100644 drivers/staging/media/tegra-vde/Kconfig
 delete mode 100644 drivers/staging/media/tegra-vde/TODO

diff --git a/MAINTAINERS b/MAINTAINERS
index aa0f6cbb634e..1f210d2227f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12071,7 +12071,7 @@ L:	linux-tegra@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
-F:	drivers/staging/media/tegra-vde/
+F:	drivers/media/platform/tegra/vde/
 
 MEDIA DRIVERS FOR RENESAS - CEU
 M:	Jacopo Mondi <jacopo@jmondi.org>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9fbdba0fd1e7..97a191a3c0a1 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -630,6 +630,23 @@ config VIDEO_SUN8I_ROTATE
 	   Support for the Allwinner DE2 rotation unit.
 	   To compile this driver as a module choose m here.
 
+config VIDEO_TEGRA_VDE
+	tristate "NVIDIA Tegra Video Decoder Engine driver"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	select DMA_SHARED_BUFFER
+	select IOMMU_IOVA
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_REQUEST_API
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
+	select V4L2_H264
+	select V4L2_MEM2MEM_DEV
+	help
+	   Support for the NVIDIA Tegra video decoder unit.
+	   To compile this driver as a module choose m here.
+
 endif # V4L_MEM2MEM_DRIVERS
 
 # TI VIDEO PORT Helper Modules
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 28eb4aadbf45..4c6fdca75b9f 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 obj-y					+= sunxi/
 
 obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
+
+obj-$(CONFIG_VIDEO_TEGRA_VDE)		+= tegra/vde/
diff --git a/drivers/staging/media/tegra-vde/Makefile b/drivers/media/platform/tegra/vde/Makefile
similarity index 67%
rename from drivers/staging/media/tegra-vde/Makefile
rename to drivers/media/platform/tegra/vde/Makefile
index 1758aa201baa..4e96f3305567 100644
--- a/drivers/staging/media/tegra-vde/Makefile
+++ b/drivers/media/platform/tegra/vde/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 tegra-vde-y := vde.o iommu.o dmabuf-cache.o h264.o v4l2.o
-obj-$(CONFIG_TEGRA_VDE)	+= tegra-vde.o
+obj-$(CONFIG_VIDEO_TEGRA_VDE)	+= tegra-vde.o
diff --git a/drivers/staging/media/tegra-vde/dmabuf-cache.c b/drivers/media/platform/tegra/vde/dmabuf-cache.c
similarity index 100%
rename from drivers/staging/media/tegra-vde/dmabuf-cache.c
rename to drivers/media/platform/tegra/vde/dmabuf-cache.c
diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/media/platform/tegra/vde/h264.c
similarity index 100%
rename from drivers/staging/media/tegra-vde/h264.c
rename to drivers/media/platform/tegra/vde/h264.c
diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/media/platform/tegra/vde/iommu.c
similarity index 100%
rename from drivers/staging/media/tegra-vde/iommu.c
rename to drivers/media/platform/tegra/vde/iommu.c
diff --git a/drivers/staging/media/tegra-vde/trace.h b/drivers/media/platform/tegra/vde/trace.h
similarity index 97%
rename from drivers/staging/media/tegra-vde/trace.h
rename to drivers/media/platform/tegra/vde/trace.h
index e5714107db58..77358ddfdb8f 100644
--- a/drivers/staging/media/tegra-vde/trace.h
+++ b/drivers/media/platform/tegra/vde/trace.h
@@ -90,6 +90,6 @@ TRACE_EVENT(vde_ref_l1,
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../drivers/staging/media/tegra-vde
+#define TRACE_INCLUDE_PATH ../../drivers/media/platform/tegra/vde
 #define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/staging/media/tegra-vde/v4l2.c b/drivers/media/platform/tegra/vde/v4l2.c
similarity index 100%
rename from drivers/staging/media/tegra-vde/v4l2.c
rename to drivers/media/platform/tegra/vde/v4l2.c
diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/media/platform/tegra/vde/vde.c
similarity index 100%
rename from drivers/staging/media/tegra-vde/vde.c
rename to drivers/media/platform/tegra/vde/vde.c
diff --git a/drivers/staging/media/tegra-vde/vde.h b/drivers/media/platform/tegra/vde/vde.h
similarity index 100%
rename from drivers/staging/media/tegra-vde/vde.h
rename to drivers/media/platform/tegra/vde/vde.h
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index b81cfa74edb7..1fd6a0c6e1d8 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -36,8 +36,6 @@ source "drivers/staging/media/rkvdec/Kconfig"
 
 source "drivers/staging/media/sunxi/Kconfig"
 
-source "drivers/staging/media/tegra-vde/Kconfig"
-
 source "drivers/staging/media/zoran/Kconfig"
 
 source "drivers/staging/media/tegra-video/Kconfig"
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index 7e2c86e3695d..91be8370cad0 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_VIDEO_MESON_VDEC)	+= meson/vdec/
 obj-$(CONFIG_VIDEO_OMAP4)	+= omap4iss/
 obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC)	+= rkvdec/
 obj-$(CONFIG_VIDEO_SUNXI)	+= sunxi/
-obj-$(CONFIG_VIDEO_TEGRA)	+= tegra-video/
 obj-$(CONFIG_TEGRA_VDE)		+= tegra-vde/
 obj-$(CONFIG_VIDEO_HANTRO)	+= hantro/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
diff --git a/drivers/staging/media/tegra-vde/Kconfig b/drivers/staging/media/tegra-vde/Kconfig
deleted file mode 100644
index 07dbc1f44ca8..000000000000
--- a/drivers/staging/media/tegra-vde/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config TEGRA_VDE
-	tristate "NVIDIA Tegra Video Decoder Engine driver"
-	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	select DMA_SHARED_BUFFER
-	select IOMMU_IOVA
-	select MEDIA_CONTROLLER
-	select MEDIA_CONTROLLER_REQUEST_API
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_DMA_SG
-	select V4L2_H264
-	select V4L2_MEM2MEM_DEV
-	help
-	    Say Y here to enable support for the NVIDIA Tegra video decoder
-	    driver.
diff --git a/drivers/staging/media/tegra-vde/TODO b/drivers/staging/media/tegra-vde/TODO
deleted file mode 100644
index 31aaa3e66d80..000000000000
--- a/drivers/staging/media/tegra-vde/TODO
+++ /dev/null
@@ -1,4 +0,0 @@
-TODO:
-	- Implement V4L2 API once it gains support for stateless decoders.
-
-Contact: Dmitry Osipenko <digetx@gmail.com>
-- 
2.34.1

