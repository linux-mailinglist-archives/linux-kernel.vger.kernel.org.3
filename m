Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E713D46B5C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhLGI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:29:01 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:47406
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232635AbhLGI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1qJsX3KnQTilTVBLvxfMxHzgdU/Gla9GxQ32m2yMKzTC3QUMNo9Cf7heG7JzQwR6ZxEhce4vLC9DHDYQOIgkOAkSVM3TcfAia+pePxUuoxDdyU99tExBkF0mgjXINAo3hJVQBdOq915NuPIROdO6NtLYMs/ctXO1uFSCdMTNJSvOb4t5Y8mp1VIlu/vgqHoMJ5VI2jX86qJeQNMSqnteqCVCj6X7CB2CTJjv9rrto8JCtZHtEmHOtjpa67yefQd+VHHoVyooaO7psw1b4fqNKxBRSbVxKc5U1PrsfNezazwE1p91ZPh9tehQlJYLVL5RhwIQduzo6LSsN/aMxoI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niB5tKQOTkszVQ0B8v9WkTClxOb8sfeecAIHWWSjzag=;
 b=lzyMFv94yZRntpDQtBTE9r9OBqrOUCGGzSpvQG01p8PSwKc0wvsZ73rq4CMsSgOQolVE8ZRd9DvjNUiGV78xDq9wfzbHpFwjOj6mlahDnAnNUEbCQBxwr3UudK9kAJde2dAgfP34r52gt56tBd0dp1+aYdwHhLDWEfJGS821zGFB6DWr/seMU8guhGxk1/uE0gZgQKxEiJoTXOG543p92PVuhXoKJexjpcraDwhRY44lT+MDTJMPM5C1EusGvfbdRnuKv3Wjb0L+O3Plxen79SuxLhdrsxjAN8UemOfXbyLo+WuAmxknS8y0VSFcI13dvyIceF6Ftd7gRKZ0XBK1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niB5tKQOTkszVQ0B8v9WkTClxOb8sfeecAIHWWSjzag=;
 b=eMN+GIH6ltFDPr63OpH55038iKjTvNejKbpl0KJ/gcOIjFWtGXheF3HcDbvfPEOzr3feGdTyFhr9phUMXJVASTa2HL8XMny8xBUFwa6TdKaI/QBTSyzSddhJsqkLkXcQVKBGeQqB67kXKM5Vk/oeM5WTVkU86FUmB+11qvjIpms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB2978.eurprd04.prod.outlook.com (2603:10a6:206:5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 08:25:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 03/13] media: amphion: add amphion vpu device driver
Date:   Tue,  7 Dec 2021 16:24:18 +0800
Message-Id: <92d52e6e83c3c37bfbedd40c99f41e3c25dd84fe.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d5aa110-a2e4-4ebb-dda1-08d9b95b182a
X-MS-TrafficTypeDiagnostic: AM5PR04MB2978:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB29780A8B7B794518ACA206A9E76E9@AM5PR04MB2978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oN+ccz2US3tlgo1KxDeb7fOjhVthmfSv0FOd+84gn9UJDjfsBJXMHGAL+dyF9F4/UQjd/RfFZWhUpewfu1O7lTm3wRs/DWXTtyA3egdDQf5iY42EyI9wGrtQWLwRf3EcQgQuqCliNnWZmC6wWjm+2pBw10ZAzta+7Udp0n6/iDudjFa+j5JZdvVQMZl4HGv2fygaTQZJ+s+OWpFan+H22HtJ8aLLd1zPxshCjaZPONHSRItPuLUVHJPsnmE/Mi38RBjxxYCyhh3w1rXXE1jEYg0Y1qZzBNQWcq3rp1ZjAuSQSnRh24PuQTjg1w9PSXKjCV/RfeXp1f31k2XtbB9cRTTlzLNUAgfvoRrGRJmC3gXJdLGoLTA6f2ehVobtVTwX6g64funwb2b2WrnEdCQRrhYdKoJA70zbYTILf/JuL4mCixOmJL5U7b7260HsyN6VZQtsmHv6qKtI5BTzXut6/oxH7YbyRpgPeGIejHL9wPMeAAw4/xZeWqnFAqxZ0sdRBmu9wXiY8vSZX5R4gzHLI9ixOigJFN7IG119INhMIvcOtVE5xz1i6SdJl7mCkq3gvisYzhsUFcFHnBj9EeWrQDvkIMHmJkrqMrlrK+S4n4rIpJr8gAfYblcWuyTnjLA6uybE/hS1iTT87Z+8RYsDfbNE5W9Vf1AjiF5bsgKEn9kY1d132H7qSjdmg3sQvsui4bRThB3QOzIw6IqXm9a1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(7696005)(44832011)(508600001)(316002)(5660300002)(7416002)(4326008)(8676002)(36756003)(956004)(38350700002)(38100700002)(186003)(2616005)(83380400001)(26005)(2906002)(66946007)(66476007)(30864003)(8936002)(86362001)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkcWs6tiTi6IQvKMyYZU1+tIYYTuWrFV//mUdUawXhTZAn/c0KciL8tEK1YX?=
 =?us-ascii?Q?mltfjtDgOdd4Nng2Oz0vDNZZiJ6anBsKSr0wDEYaJJFioOpdiGR/5rYcsmO8?=
 =?us-ascii?Q?3YWMsAV7XFt8WAWiqNheBW4+nIyguwUGTFf79wah441PEoM4coFe0L/oqTBi?=
 =?us-ascii?Q?tZGY7aThAFkYC1xc3o6wgqtz6Fgsg/ZPAExMazwiCnl9XIMs3eXTfzsbPsVj?=
 =?us-ascii?Q?5X0mz1qnYm/rF2OFAPOi4GcSiGImb/P50RJ2vjnc5QgwPLe4fcWiRWKwhebI?=
 =?us-ascii?Q?HGCCtRqTCFDI+4rt7Dxv6c201pBZ9vGbGWRF/oT5QCdz4v4iNwksb9/ry0mJ?=
 =?us-ascii?Q?XfiFD+o/riecqfXsF/WnhZSa4Z2B4IDTE4Ev+ZV9pA99Bmz0nPrnaxFLpXXE?=
 =?us-ascii?Q?3uUAhe7IVDp/N5gb2jgbX4eQ0jRIqtiNGcShFqnuKVInVx8gpdxtCtH+Fsot?=
 =?us-ascii?Q?y18Iu3vx85ea6PgVoD2Crqgyx7JJBcNTzRhXFRhuFK3sAuQg9JVAe/qXiH8K?=
 =?us-ascii?Q?+DlN1A6JBrOKAjis4muUQzdK/G2JXblbLl7vXJWvRHIlb+O9qnPW3TPNaG5I?=
 =?us-ascii?Q?pOkNyuEhQK7ZvQ2UFdgy+cjUapzf/kcke1GSXstk8JKpc3PHF4V2PPrU4wDz?=
 =?us-ascii?Q?3EGqNz4eSQzfGiKK5hpiAxWEZFhDUFrRzForSRA47pOywW9huiPHmB2UP2VE?=
 =?us-ascii?Q?El9sNIDbnBoCNp7+3U91URRYFC2cmmtQ6sikSTh8AF+LuJ1hqyxmPlBs+5GO?=
 =?us-ascii?Q?2ggjGqOJ1Ng6TDF353OWwgwhpRztav0v/Ne+4cIIUIsAxMtSEeIGL2RZ2OEY?=
 =?us-ascii?Q?qxkF7I5PJ+V5d8p1tyWirXShMiMQKwM+dCNrWrDBIoP+R9K9SLFYoURBNJyY?=
 =?us-ascii?Q?RA8BR4/idwDXdWiCfIJzxGjNH3bLi3wuZUZDvh7SS0ugJ7+2SM7MI8UqrsAJ?=
 =?us-ascii?Q?xxPhLT5Hl9SIKcz2Z8mkD+7nIwg8LpPFZIkNva18+UVDxtsLoauKQW+h8LvY?=
 =?us-ascii?Q?CJuc7nnRgVRmnj5Ono3013FqvXlQfmt50BrIOnxTHzw6Tt1X6iesw7Pf8kQ3?=
 =?us-ascii?Q?3hSntTK1zcYoRZbs/i2WdKi1KaT1Limdi9zZz7KgWqedfXSPOF1f6uXc1Qg/?=
 =?us-ascii?Q?ozkz5ZTd0fnNaAGcVwMJfwTsrB36s+ZRSoDwmsAUaZDF0g07gMgxvafNhX6R?=
 =?us-ascii?Q?Rs0l92X0hUTPpXUqM0fDvwgODZs+4ZkAqfWvHQYXcYBBx+WF0SBLq4+1dZjw?=
 =?us-ascii?Q?qzhMTgrvqp4JJ3LGtbzeJu0+sHo2YGBV180fmh/o4gS9+vz/I4FnLficL2Xu?=
 =?us-ascii?Q?RC58Wdk8ff8yORDpLK09p0HnzJOb+fr+74x4yle7nBiroNvxDnxQ9UGgABTE?=
 =?us-ascii?Q?iI4migZrwXICj19zvVTONg1uqvS0CmQc7THwZr3ruZFFMMysEwpTmp3NJOjs?=
 =?us-ascii?Q?p0/WDm8aoIKU26uxpBu1SrvuiFVwguuGC6XxaRRX9WgZDjeoYOy0YiSYSBgT?=
 =?us-ascii?Q?6YWB2bt5DHNkU/J/lYXNtRddgIEdyUw4MgR8odTwYxfyC6WGwagX6wk30CBi?=
 =?us-ascii?Q?Clnfq59YTIiRMXoWJabPRNb5Uh5GnwEI52OKgFm5EUENC9KllbRU01HdOU4o?=
 =?us-ascii?Q?+c2ABwJN9sxexKMWDfb4EMY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5aa110-a2e4-4ebb-dda1-08d9b95b182a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:15.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIxrP86y+luHujLJORCZzhyJWvKueEajhGLs9DSPimv6Oi5t+RGMsbitoQJ1+T6UOP2zorEK3egZFLZnQCiS4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2978
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amphion vpu codec ip contains encoder and decoder.
Windsor is the encoder, it supports to encode H.264.
Malone is the decoder, it features a powerful
video processing unit able to decode many formats,
such as H.264, HEVC, and other formats.

This Driver is for this IP that is based on the v4l2 mem2mem framework.

Supported SoCs are: IMX8QXP, IMX8QM

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/arm64/configs/defconfig               |   1 +
 drivers/media/platform/Kconfig             |  19 ++
 drivers/media/platform/Makefile            |   2 +
 drivers/media/platform/amphion/Makefile    |  20 ++
 drivers/media/platform/amphion/vpu.h       | 356 +++++++++++++++++++++
 drivers/media/platform/amphion/vpu_defs.h  | 186 +++++++++++
 drivers/media/platform/amphion/vpu_drv.c   | 260 +++++++++++++++
 drivers/media/platform/amphion/vpu_imx8q.c | 271 ++++++++++++++++
 drivers/media/platform/amphion/vpu_imx8q.h | 116 +++++++
 9 files changed, 1231 insertions(+)
 create mode 100644 drivers/media/platform/amphion/Makefile
 create mode 100644 drivers/media/platform/amphion/vpu.h
 create mode 100644 drivers/media/platform/amphion/vpu_defs.h
 create mode 100644 drivers/media/platform/amphion/vpu_drv.c
 create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
 create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..cc3633112f3f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -657,6 +657,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_RCAR_CSI2=m
 CONFIG_VIDEO_RCAR_VIN=m
 CONFIG_VIDEO_SUN6I_CSI=m
+CONFIG_VIDEO_AMPHION_VPU=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9fbdba0fd1e7..947ae16c73f5 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -216,6 +216,25 @@ config VIDEO_RCAR_ISP
 	  To compile this driver as a module, choose M here: the
 	  module will be called rcar-isp.
 
+config VIDEO_AMPHION_VPU
+	tristate "Amphion VPU (Video Processing Unit) Codec IP"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on MEDIA_SUPPORT
+	depends on VIDEO_DEV
+	depends on VIDEO_V4L2
+	select MEDIA_CONTROLLER
+	select V4L2_MEM2MEM_DEV
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	help
+	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
+	  Windsor is encoder that supports H.264, and Malone is decoder
+	  that supports H.264, HEVC, and other video formats.
+	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
+	  It accelerates encoding and decoding operations on
+	  various NXP SoCs.
+	  To compile this driver as a module choose m here.
+
 endif # V4L_PLATFORM_DRIVERS
 
 menuconfig V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 19bcbced7382..53709df654ee 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -88,3 +88,5 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 obj-y					+= sunxi/
 
 obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
+
+obj-$(CONFIG_VIDEO_AMPHION_VPU)		+= amphion/
diff --git a/drivers/media/platform/amphion/Makefile b/drivers/media/platform/amphion/Makefile
new file mode 100644
index 000000000000..80717312835f
--- /dev/null
+++ b/drivers/media/platform/amphion/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for NXP VPU driver
+
+amphion-vpu-objs += vpu_drv.o \
+			vpu_core.o \
+			vpu_mbox.o \
+			vpu_v4l2.o \
+			vpu_helpers.o \
+			vpu_cmds.o \
+			vpu_msgs.o \
+			vpu_rpc.o \
+			vpu_imx8q.o \
+			vpu_windsor.o \
+			vpu_malone.o \
+			vpu_color.o \
+			vdec.o  \
+			venc.o \
+			vpu_dbg.o
+
+obj-$(CONFIG_VIDEO_AMPHION_VPU) += amphion-vpu.o
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
new file mode 100644
index 000000000000..a268da710180
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu.h
@@ -0,0 +1,356 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#ifndef _AMPHION_VPU_H
+#define _AMPHION_VPU_H
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-mem2mem.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/kfifo.h>
+
+#define VPU_TIMEOUT		msecs_to_jiffies(1000)
+#define VPU_INST_NULL_ID	(-1L)
+#define VPU_MSG_BUFFER_SIZE	(8192)
+
+enum imx_plat_type {
+	IMX8QXP = 0,
+	IMX8QM  = 1,
+	IMX8DM,
+	IMX8DX,
+	PLAT_TYPE_RESERVED
+};
+
+enum vpu_core_type {
+	VPU_CORE_TYPE_ENC = 0,
+	VPU_CORE_TYPE_DEC = 0x10,
+};
+
+struct vpu_dev;
+struct vpu_resources {
+	enum imx_plat_type plat_type;
+	u32 mreg_base;
+	int (*setup)(struct vpu_dev *vpu);
+	int (*setup_encoder)(struct vpu_dev *vpu);
+	int (*setup_decoder)(struct vpu_dev *vpu);
+	int (*reset)(struct vpu_dev *vpu);
+};
+
+struct vpu_buffer {
+	void *virt;
+	dma_addr_t phys;
+	u32 length;
+	u32 bytesused;
+	struct device *dev;
+};
+
+struct vpu_func {
+	struct video_device *vfd;
+	struct v4l2_m2m_dev *m2m_dev;
+	enum vpu_core_type type;
+	int function;
+};
+
+struct vpu_dev {
+	void __iomem *base;
+	struct platform_device *pdev;
+	struct device *dev;
+	struct mutex lock;
+	const struct vpu_resources *res;
+	struct list_head cores;
+
+	struct v4l2_device v4l2_dev;
+	struct vpu_func encoder;
+	struct vpu_func decoder;
+	struct media_device mdev;
+
+	struct delayed_work watchdog_work;
+	void (*get_vpu)(struct vpu_dev *vpu);
+	void (*put_vpu)(struct vpu_dev *vpu);
+	void (*get_enc)(struct vpu_dev *vpu);
+	void (*put_enc)(struct vpu_dev *vpu);
+	void (*get_dec)(struct vpu_dev *vpu);
+	void (*put_dec)(struct vpu_dev *vpu);
+	atomic_t ref_vpu;
+	atomic_t ref_enc;
+	atomic_t ref_dec;
+
+	struct dentry *debugfs;
+};
+
+struct vpu_format {
+	u32 pixfmt;
+	unsigned int num_planes;
+	u32 type;
+	u32 flags;
+	u32 width;
+	u32 height;
+	u32 sizeimage[VIDEO_MAX_PLANES];
+	u32 bytesperline[VIDEO_MAX_PLANES];
+	u32 field;
+};
+
+struct vpu_core_resources {
+	enum vpu_core_type type;
+	const char *fwname;
+	u32 stride;
+	u32 max_width;
+	u32 min_width;
+	u32 step_width;
+	u32 max_height;
+	u32 min_height;
+	u32 step_height;
+	u32 rpc_size;
+	u32 fwlog_size;
+	u32 act_size;
+};
+
+struct vpu_mbox {
+	char name[20];
+	struct mbox_client cl;
+	struct mbox_chan *ch;
+	bool block;
+};
+
+enum vpu_core_state {
+	VPU_CORE_DEINIT = 0,
+	VPU_CORE_ACTIVE,
+	VPU_CORE_SNAPSHOT,
+	VPU_CORE_HANG
+};
+
+struct vpu_core {
+	void __iomem *base;
+	struct platform_device *pdev;
+	struct device *dev;
+	struct device *parent;
+	struct device *pd;
+	struct device_link *pd_link;
+	struct mutex lock;
+	struct mutex cmd_lock;
+	struct list_head list;
+	enum vpu_core_type type;
+	int id;
+	const struct vpu_core_resources *res;
+	unsigned long instance_mask;
+	u32 supported_instance_count;
+	unsigned long hang_mask;
+	u32 request_count;
+	struct list_head instances;
+	enum vpu_core_state state;
+	u32 fw_version;
+
+	struct vpu_buffer fw;
+	struct vpu_buffer rpc;
+	struct vpu_buffer log;
+	struct vpu_buffer act;
+
+	struct vpu_mbox tx_type;
+	struct vpu_mbox tx_data;
+	struct vpu_mbox rx;
+	unsigned long cmd_seq;
+
+	wait_queue_head_t ack_wq;
+	struct completion cmp;
+	struct workqueue_struct *workqueue;
+	struct work_struct msg_work;
+	struct delayed_work msg_delayed_work;
+	struct kfifo msg_fifo;
+	void *msg_buffer;
+	unsigned int msg_buffer_size;
+
+	struct vpu_dev *vpu;
+	void *iface;
+
+	struct dentry *debugfs;
+	struct dentry *debugfs_fwlog;
+};
+
+enum vpu_codec_state {
+	VPU_CODEC_STATE_DEINIT = 1,
+	VPU_CODEC_STATE_CONFIGURED,
+	VPU_CODEC_STATE_START,
+	VPU_CODEC_STATE_STARTED,
+	VPU_CODEC_STATE_ACTIVE,
+	VPU_CODEC_STATE_SEEK,
+	VPU_CODEC_STATE_STOP,
+	VPU_CODEC_STATE_DRAIN,
+	VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE,
+};
+
+struct vpu_frame_info {
+	u32 type;
+	u32 id;
+	u32 sequence;
+	u32 luma;
+	u32 chroma_u;
+	u32 chroma_v;
+	u32 data_offset;
+	u32 flags;
+	u32 skipped;
+	s64 timestamp;
+};
+
+struct vpu_inst;
+struct vpu_inst_ops {
+	int (*ctrl_init)(struct vpu_inst *inst);
+	int (*start)(struct vpu_inst *inst, u32 type);
+	int (*stop)(struct vpu_inst *inst, u32 type);
+	int (*abort)(struct vpu_inst *inst);
+	bool (*check_ready)(struct vpu_inst *inst, unsigned int type);
+	void (*buf_done)(struct vpu_inst *inst, struct vpu_frame_info *frame);
+	void (*event_notify)(struct vpu_inst *inst, u32 event, void *data);
+	void (*release)(struct vpu_inst *inst);
+	void (*cleanup)(struct vpu_inst *inst);
+	void (*mem_request)(struct vpu_inst *inst,
+				u32 enc_frame_size,
+				u32 enc_frame_num,
+				u32 ref_frame_size,
+				u32 ref_frame_num,
+				u32 act_frame_size,
+				u32 act_frame_num);
+	void (*input_done)(struct vpu_inst *inst);
+	void (*stop_done)(struct vpu_inst *inst);
+	int (*process_output)(struct vpu_inst *inst, struct vb2_buffer *vb);
+	int (*process_capture)(struct vpu_inst *inst, struct vb2_buffer *vb);
+	int (*get_one_frame)(struct vpu_inst *inst, void *info);
+	void (*on_queue_empty)(struct vpu_inst *inst, u32 type);
+	int (*get_debug_info)(struct vpu_inst *inst, char *str, u32 size, u32 i);
+	void (*wait_prepare)(struct vpu_inst *inst);
+	void (*wait_finish)(struct vpu_inst *inst);
+};
+
+struct vpu_inst {
+	struct list_head list;
+	struct mutex lock;
+	struct vpu_dev *vpu;
+	struct vpu_core *core;
+	struct device *dev;
+	int id;
+
+	struct v4l2_fh fh;
+	struct v4l2_ctrl_handler ctrl_handler;
+	atomic_t ref_count;
+	int (*release)(struct vpu_inst *inst);
+
+	enum vpu_codec_state state;
+	enum vpu_core_type type;
+
+	struct workqueue_struct *workqueue;
+	struct work_struct msg_work;
+	struct kfifo msg_fifo;
+	u8 msg_buffer[VPU_MSG_BUFFER_SIZE];
+
+	struct vpu_buffer stream_buffer;
+	bool use_stream_buffer;
+	struct vpu_buffer act;
+
+	struct list_head cmd_q;
+	void *pending;
+
+	struct vpu_inst_ops *ops;
+	const struct vpu_format *formats;
+	struct vpu_format out_format;
+	struct vpu_format cap_format;
+	u32 min_buffer_cap;
+	u32 min_buffer_out;
+
+	struct v4l2_rect crop;
+	u32 colorspace;
+	u8 ycbcr_enc;
+	u8 quantization;
+	u8 xfer_func;
+	u32 sequence;
+	u32 extra_size;
+
+	u32 flows[16];
+	u32 flow_idx;
+
+	pid_t pid;
+	pid_t tgid;
+	struct dentry *debugfs;
+
+	void *priv;
+};
+
+#define call_vop(inst, op, args...)					\
+	((inst)->ops->op ? (inst)->ops->op(inst, ##args) : 0)		\
+
+enum {
+	VPU_BUF_STATE_IDLE = 0,
+	VPU_BUF_STATE_INUSE,
+	VPU_BUF_STATE_DECODED,
+	VPU_BUF_STATE_READY,
+	VPU_BUF_STATE_SKIP,
+	VPU_BUF_STATE_ERROR
+};
+
+struct vpu_vb2_buffer {
+	struct v4l2_m2m_buffer m2m_buf;
+	dma_addr_t luma;
+	dma_addr_t chroma_u;
+	dma_addr_t chroma_v;
+	unsigned int state;
+	u32 tag;
+};
+
+void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val);
+u32 vpu_readl(struct vpu_dev *vpu, u32 reg);
+
+static inline struct vpu_vb2_buffer *to_vpu_vb2_buffer(struct vb2_v4l2_buffer *vbuf)
+{
+	struct v4l2_m2m_buffer *m2m_buf = container_of(vbuf, struct v4l2_m2m_buffer, vb);
+
+	return container_of(m2m_buf, struct vpu_vb2_buffer, m2m_buf);
+}
+
+static inline const char *vpu_core_type_desc(enum vpu_core_type type)
+{
+	return type == VPU_CORE_TYPE_ENC ? "encoder" : "decoder";
+}
+
+static inline struct vpu_inst *to_inst(struct file *filp)
+{
+	return container_of(filp->private_data, struct vpu_inst, fh);
+}
+
+#define ctrl_to_inst(ctrl)	\
+	container_of((ctrl)->handler, struct vpu_inst, ctrl_handler)
+
+const struct v4l2_ioctl_ops *venc_get_ioctl_ops(void);
+const struct v4l2_file_operations *venc_get_fops(void);
+const struct v4l2_ioctl_ops *vdec_get_ioctl_ops(void);
+const struct v4l2_file_operations *vdec_get_fops(void);
+
+int vpu_add_func(struct vpu_dev *vpu, struct vpu_func *func);
+void vpu_remove_func(struct vpu_func *func);
+
+struct vpu_inst *vpu_inst_get(struct vpu_inst *inst);
+void vpu_inst_put(struct vpu_inst *inst);
+struct vpu_core *vpu_request_core(struct vpu_dev *vpu, enum vpu_core_type type);
+void vpu_release_core(struct vpu_core *core);
+int vpu_inst_register(struct vpu_inst *inst);
+int vpu_inst_unregister(struct vpu_inst *inst);
+const struct vpu_core_resources *vpu_get_resource(struct vpu_inst *inst);
+
+int vpu_inst_create_dbgfs_file(struct vpu_inst *inst);
+int vpu_inst_remove_dbgfs_file(struct vpu_inst *inst);
+int vpu_core_create_dbgfs_file(struct vpu_core *core);
+int vpu_core_remove_dbgfs_file(struct vpu_core *core);
+void vpu_inst_record_flow(struct vpu_inst *inst, u32 flow);
+
+int vpu_core_driver_init(void);
+void vpu_core_driver_exit(void);
+
+extern bool debug;
+#define vpu_trace(dev, fmt, arg...)					\
+	do {								\
+		if (debug)						\
+			dev_info(dev, "%s: " fmt, __func__, ## arg);	\
+	} while (0)
+
+#endif
diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
new file mode 100644
index 000000000000..9b7e26eefc33
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_defs.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#ifndef _AMPHION_VPU_DEFS_H
+#define _AMPHION_VPU_DEFS_H
+
+enum MSG_TYPE {
+	INIT_DONE = 1,
+	PRC_BUF_OFFSET,
+	BOOT_ADDRESS,
+	COMMAND,
+	EVENT,
+};
+
+enum {
+	VPU_IRQ_CODE_BOOT_DONE = 0x55,
+	VPU_IRQ_CODE_SNAPSHOT_DONE = 0xa5,
+	VPU_IRQ_CODE_SYNC = 0xaa,
+};
+
+enum {
+	VPU_CMD_ID_NOOP = 0x0,
+	VPU_CMD_ID_CONFIGURE_CODEC,
+	VPU_CMD_ID_START,
+	VPU_CMD_ID_STOP,
+	VPU_CMD_ID_ABORT,
+	VPU_CMD_ID_RST_BUF,
+	VPU_CMD_ID_SNAPSHOT,
+	VPU_CMD_ID_FIRM_RESET,
+	VPU_CMD_ID_UPDATE_PARAMETER,
+	VPU_CMD_ID_FRAME_ENCODE,
+	VPU_CMD_ID_SKIP,
+	VPU_CMD_ID_PARSE_NEXT_SEQ,
+	VPU_CMD_ID_PARSE_NEXT_I,
+	VPU_CMD_ID_PARSE_NEXT_IP,
+	VPU_CMD_ID_PARSE_NEXT_ANY,
+	VPU_CMD_ID_DEC_PIC,
+	VPU_CMD_ID_FS_ALLOC,
+	VPU_CMD_ID_FS_RELEASE,
+	VPU_CMD_ID_TIMESTAMP,
+	VPU_CMD_ID_DEBUG
+};
+
+enum {
+	VPU_MSG_ID_NOOP = 0x100,
+	VPU_MSG_ID_RESET_DONE,
+	VPU_MSG_ID_START_DONE,
+	VPU_MSG_ID_STOP_DONE,
+	VPU_MSG_ID_ABORT_DONE,
+	VPU_MSG_ID_BUF_RST,
+	VPU_MSG_ID_MEM_REQUEST,
+	VPU_MSG_ID_PARAM_UPD_DONE,
+	VPU_MSG_ID_FRAME_INPUT_DONE,
+	VPU_MSG_ID_ENC_DONE,
+	VPU_MSG_ID_DEC_DONE,
+	VPU_MSG_ID_FRAME_REQ,
+	VPU_MSG_ID_FRAME_RELEASE,
+	VPU_MSG_ID_SEQ_HDR_FOUND,
+	VPU_MSG_ID_RES_CHANGE,
+	VPU_MSG_ID_PIC_HDR_FOUND,
+	VPU_MSG_ID_PIC_DECODED,
+	VPU_MSG_ID_PIC_EOS,
+	VPU_MSG_ID_FIFO_LOW,
+	VPU_MSG_ID_FIFO_HIGH,
+	VPU_MSG_ID_FIFO_EMPTY,
+	VPU_MSG_ID_FIFO_FULL,
+	VPU_MSG_ID_BS_ERROR,
+	VPU_MSG_ID_UNSUPPORTED,
+	VPU_MSG_ID_TIMESTAMP_INFO,
+
+	VPU_MSG_ID_FIRMWARE_XCPT,
+};
+
+enum VPU_ENC_MEMORY_RESOURSE {
+	MEM_RES_ENC,
+	MEM_RES_REF,
+	MEM_RES_ACT
+};
+
+enum VPU_DEC_MEMORY_RESOURCE {
+	MEM_RES_FRAME,
+	MEM_RES_MBI,
+	MEM_RES_DCP
+};
+
+enum VPU_SCODE_TYPE {
+	SCODE_PADDING_EOS = 1,
+	SCODE_PADDING_BUFFLUSH = 2,
+	SCODE_PADDING_ABORT = 3,
+	SCODE_SEQUENCE = 0x31,
+	SCODE_PICTURE = 0x32,
+	SCODE_SLICE = 0x33
+};
+
+struct vpu_pkt_mem_req_data {
+	u32 enc_frame_size;
+	u32 enc_frame_num;
+	u32 ref_frame_size;
+	u32 ref_frame_num;
+	u32 act_buf_size;
+	u32 act_buf_num;
+};
+
+struct vpu_enc_pic_info {
+	u32 frame_id;
+	u32 pic_type;
+	u32 skipped_frame;
+	u32 error_flag;
+	u32 psnr;
+	u32 frame_size;
+	u32 wptr;
+	u32 crc;
+	s64 timestamp;
+};
+
+struct vpu_dec_codec_info {
+	u32 pixfmt;
+	u32 num_ref_frms;
+	u32 num_dpb_frms;
+	u32 num_dfe_area;
+	u32 color_primaries;
+	u32 transfer_chars;
+	u32 matrix_coeffs;
+	u32 full_range;
+	u32 vui_present;
+	u32 progressive;
+	u32 width;
+	u32 height;
+	u32 decoded_width;
+	u32 decoded_height;
+	struct v4l2_fract frame_rate;
+	u32 dsp_asp_ratio;
+	u32 level_idc;
+	u32 bit_depth_luma;
+	u32 bit_depth_chroma;
+	u32 chroma_fmt;
+	u32 mvc_num_views;
+	u32 offset_x;
+	u32 offset_y;
+	u32 tag;
+	u32 sizeimage[VIDEO_MAX_PLANES];
+	u32 bytesperline[VIDEO_MAX_PLANES];
+	u32 mbi_size;
+	u32 dcp_size;
+	u32 stride;
+};
+
+struct vpu_dec_pic_info {
+	u32 id;
+	u32 luma;
+	u32 start;
+	u32 end;
+	u32 pic_size;
+	u32 stride;
+	u32 skipped;
+	s64 timestamp;
+	u32 consumed_count;
+};
+
+struct vpu_fs_info {
+	u32 id;
+	u32 type;
+	u32 tag;
+	u32 luma_addr;
+	u32 luma_size;
+	u32 chroma_addr;
+	u32 chromau_size;
+	u32 chromav_addr;
+	u32 chromav_size;
+	u32 bytesperline;
+	u32 not_displayed;
+};
+
+struct vpu_ts_info {
+	s64 timestamp;
+	u32 size;
+};
+
+#define BITRATE_STEP		(1024)
+#define BITRATE_MIN		(16 * BITRATE_STEP)
+#define BITRATE_MAX		(240 * 1024 * BITRATE_STEP)
+#define BITRATE_DEFAULT		(2 * 1024 * BITRATE_STEP)
+
+#endif
diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
new file mode 100644
index 000000000000..83ca04452c02
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dma-map-ops.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <linux/of_reserved_mem.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <linux/debugfs.h>
+#include "vpu.h"
+#include "vpu_imx8q.h"
+
+bool debug;
+module_param(debug, bool, 0644);
+
+void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val)
+{
+	writel(val, vpu->base + reg);
+}
+
+u32 vpu_readl(struct vpu_dev *vpu, u32 reg)
+{
+	return readl(vpu->base + reg);
+}
+
+static void vpu_dev_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_vpu) == 1 && vpu->res->setup)
+		vpu->res->setup(vpu);
+}
+
+static void vpu_dev_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_vpu);
+}
+
+static void vpu_enc_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_enc) == 1 && vpu->res->setup_encoder)
+		vpu->res->setup_encoder(vpu);
+}
+
+static void vpu_enc_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_enc);
+}
+
+static void vpu_dec_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_dec) == 1 && vpu->res->setup_decoder)
+		vpu->res->setup_decoder(vpu);
+}
+
+static void vpu_dec_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_dec);
+}
+
+static int vpu_init_media_device(struct vpu_dev *vpu)
+{
+	vpu->mdev.dev = vpu->dev;
+	strscpy(vpu->mdev.model, "amphion-vpu", sizeof(vpu->mdev.model));
+	strscpy(vpu->mdev.bus_info, "platform: amphion-vpu", sizeof(vpu->mdev.bus_info));
+	media_device_init(&vpu->mdev);
+	vpu->v4l2_dev.mdev = &vpu->mdev;
+
+	return 0;
+}
+
+static int vpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vpu_dev *vpu;
+	int ret;
+
+	dev_dbg(dev, "probe\n");
+	vpu = devm_kzalloc(dev, sizeof(*vpu), GFP_KERNEL);
+	if (!vpu)
+		return -ENOMEM;
+
+	vpu->pdev = pdev;
+	vpu->dev = dev;
+	mutex_init(&vpu->lock);
+	INIT_LIST_HEAD(&vpu->cores);
+	platform_set_drvdata(pdev, vpu);
+	atomic_set(&vpu->ref_vpu, 0);
+	atomic_set(&vpu->ref_enc, 0);
+	atomic_set(&vpu->ref_dec, 0);
+	vpu->get_vpu = vpu_dev_get;
+	vpu->put_vpu = vpu_dev_put;
+	vpu->get_enc = vpu_enc_get;
+	vpu->put_enc = vpu_enc_put;
+	vpu->get_dec = vpu_dec_get;
+	vpu->put_dec = vpu_dec_put;
+
+	vpu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vpu->base))
+		return PTR_ERR(vpu->base);
+
+	vpu->res = of_device_get_match_data(dev);
+	if (!vpu->res)
+		return -ENODEV;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret)
+		goto err_runtime_disable;
+
+	pm_runtime_put_sync(dev);
+
+	ret = v4l2_device_register(dev, &vpu->v4l2_dev);
+	if (ret)
+		goto err_vpu_deinit;
+
+	vpu_init_media_device(vpu);
+	vpu->encoder.type = VPU_CORE_TYPE_ENC;
+	vpu->encoder.function = MEDIA_ENT_F_PROC_VIDEO_ENCODER;
+	vpu->decoder.type = VPU_CORE_TYPE_DEC;
+	vpu->decoder.function = MEDIA_ENT_F_PROC_VIDEO_DECODER;
+	vpu_add_func(vpu, &vpu->decoder);
+	vpu_add_func(vpu, &vpu->encoder);
+	ret = media_device_register(&vpu->mdev);
+	if (ret)
+		goto err_vpu_media;
+	vpu->debugfs = debugfs_create_dir("amphion_vpu", NULL);
+
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
+	return 0;
+
+err_vpu_media:
+	vpu_remove_func(&vpu->encoder);
+	vpu_remove_func(&vpu->decoder);
+	v4l2_device_unregister(&vpu->v4l2_dev);
+err_vpu_deinit:
+err_runtime_disable:
+	pm_runtime_set_suspended(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int vpu_remove(struct platform_device *pdev)
+{
+	struct vpu_dev *vpu = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	debugfs_remove_recursive(vpu->debugfs);
+	vpu->debugfs = NULL;
+
+	pm_runtime_disable(dev);
+
+	media_device_unregister(&vpu->mdev);
+	vpu_remove_func(&vpu->decoder);
+	vpu_remove_func(&vpu->encoder);
+	media_device_cleanup(&vpu->mdev);
+	v4l2_device_unregister(&vpu->v4l2_dev);
+	mutex_destroy(&vpu->lock);
+
+	return 0;
+}
+
+static int __maybe_unused vpu_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops vpu_pm_ops = {
+	SET_RUNTIME_PM_OPS(vpu_runtime_suspend, vpu_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vpu_suspend, vpu_resume)
+};
+
+struct vpu_resources imx8qxp_res = {
+	.plat_type = IMX8QXP,
+	.mreg_base = 0x40000000,
+	.setup = vpu_imx8q_setup,
+	.setup_encoder = vpu_imx8q_setup_enc,
+	.setup_decoder = vpu_imx8q_setup_dec,
+	.reset = vpu_imx8q_reset
+};
+
+struct vpu_resources imx8qm_res = {
+	.plat_type = IMX8QM,
+	.mreg_base = 0x40000000,
+	.setup = vpu_imx8q_setup,
+	.setup_encoder = vpu_imx8q_setup_enc,
+	.setup_decoder = vpu_imx8q_setup_dec,
+	.reset = vpu_imx8q_reset
+};
+
+static const struct of_device_id vpu_dt_match[] = {
+	{ .compatible = "nxp,imx8qxp-vpu", .data = &imx8qxp_res },
+	{ .compatible = "nxp,imx8qm-vpu", .data = &imx8qm_res },
+	{}
+};
+MODULE_DEVICE_TABLE(of, vpu_dt_match);
+
+static struct platform_driver amphion_vpu_driver = {
+	.probe = vpu_probe,
+	.remove = vpu_remove,
+	.driver = {
+		.name = "amphion-vpu",
+		.of_match_table = vpu_dt_match,
+		.pm = &vpu_pm_ops,
+	},
+};
+
+static int __init vpu_driver_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&amphion_vpu_driver);
+	if (ret)
+		return ret;
+
+	return vpu_core_driver_init();
+}
+
+static void __exit vpu_driver_exit(void)
+{
+	vpu_core_driver_exit();
+	platform_driver_unregister(&amphion_vpu_driver);
+}
+module_init(vpu_driver_init);
+module_exit(vpu_driver_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Linux VPU driver for Freescale i.MX8Q");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/amphion/vpu_imx8q.c b/drivers/media/platform/amphion/vpu_imx8q.c
new file mode 100644
index 000000000000..92c0948fe0f7
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_imx8q.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_imx8q.h"
+#include "vpu_rpc.h"
+
+#define IMX8Q_CSR_CM0Px_ADDR_OFFSET			0x00000000
+#define IMX8Q_CSR_CM0Px_CPUWAIT				0x00000004
+
+#ifdef CONFIG_IMX_SCU
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/svc/misc.h>
+
+#define VPU_DISABLE_BITS			0x7
+#define VPU_IMX_DECODER_FUSE_OFFSET		14
+#define VPU_ENCODER_MASK			0x1
+#define VPU_DECODER_MASK			0x3UL
+#define VPU_DECODER_H264_MASK			0x2UL
+#define VPU_DECODER_HEVC_MASK			0x1UL
+
+static u32 imx8q_fuse;
+
+struct vpu_sc_msg_misc {
+	struct imx_sc_rpc_msg hdr;
+	u32 word;
+} __packed;
+#endif
+
+int vpu_imx8q_setup_dec(struct vpu_dev *vpu)
+{
+	const off_t offset = DEC_MFD_XREG_SLV_BASE + MFD_BLK_CTRL;
+
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_SET, 0x1f);
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_RESET_SET, 0xffffffff);
+
+	return 0;
+}
+
+int vpu_imx8q_setup_enc(struct vpu_dev *vpu)
+{
+	return 0;
+}
+
+int vpu_imx8q_setup(struct vpu_dev *vpu)
+{
+	const off_t offset = SCB_XREG_SLV_BASE + SCB_SCB_BLK_CTRL;
+
+	vpu_readl(vpu, offset + 0x108);
+
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_SCB_CLK_ENABLE_SET, 0x1);
+	vpu_writel(vpu, offset + 0x190, 0xffffffff);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_XMEM_RESET_SET, 0xffffffff);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_SCB_CLK_ENABLE_SET, 0xE);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_CACHE_RESET_SET, 0x7);
+	vpu_writel(vpu, XMEM_CONTROL, 0x102);
+
+	vpu_readl(vpu, offset + 0x108);
+
+	return 0;
+}
+
+static int vpu_imx8q_reset_enc(struct vpu_dev *vpu)
+{
+	return 0;
+}
+
+static int vpu_imx8q_reset_dec(struct vpu_dev *vpu)
+{
+	const off_t offset = DEC_MFD_XREG_SLV_BASE + MFD_BLK_CTRL;
+
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_RESET_CLR, 0xffffffff);
+
+	return 0;
+}
+
+int vpu_imx8q_reset(struct vpu_dev *vpu)
+{
+	const off_t offset = SCB_XREG_SLV_BASE + SCB_SCB_BLK_CTRL;
+
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_CACHE_RESET_CLR, 0x7);
+	vpu_imx8q_reset_enc(vpu);
+	vpu_imx8q_reset_dec(vpu);
+
+	return 0;
+}
+int vpu_imx8q_set_system_cfg_common(struct vpu_rpc_system_config *config,
+		u32 regs, u32 core_id)
+{
+	if (!config)
+		return -EINVAL;
+
+	switch (core_id) {
+	case 0:
+		config->malone_base_addr[0] = regs + DEC_MFD_XREG_SLV_BASE;
+		config->num_malones = 1;
+		config->num_windsors = 0;
+		break;
+	case 1:
+		config->windsor_base_addr[0] = regs + ENC_MFD_XREG_SLV_0_BASE;
+		config->num_windsors = 1;
+		config->num_malones = 0;
+		break;
+	case 2:
+		config->windsor_base_addr[0] = regs + ENC_MFD_XREG_SLV_1_BASE;
+		config->num_windsors = 1;
+		config->num_malones = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (config->num_windsors) {
+		config->windsor_irq_pin[0x0][0x0] = WINDSOR_PAL_IRQ_PIN_L;
+		config->windsor_irq_pin[0x0][0x1] = WINDSOR_PAL_IRQ_PIN_H;
+	}
+
+	config->malone_base_addr[0x1] = 0x0;
+	config->hif_offset[0x0] = MFD_HIF;
+	config->hif_offset[0x1] = 0x0;
+
+	config->dpv_base_addr = 0x0;
+	config->dpv_irq_pin = 0x0;
+	config->pixif_base_addr = regs + DEC_MFD_XREG_SLV_BASE + MFD_PIX_IF;
+	config->cache_base_addr[0] = regs + MC_CACHE_0_BASE;
+	config->cache_base_addr[1] = regs + MC_CACHE_1_BASE;
+
+	return 0;
+}
+
+int vpu_imx8q_boot_core(struct vpu_core *core)
+{
+	csr_writel(core, IMX8Q_CSR_CM0Px_ADDR_OFFSET, core->fw.phys);
+	csr_writel(core, IMX8Q_CSR_CM0Px_CPUWAIT, 0);
+	return 0;
+}
+
+int vpu_imx8q_get_power_state(struct vpu_core *core)
+{
+	if (csr_readl(core, IMX8Q_CSR_CM0Px_CPUWAIT) == 1)
+		return 0;
+	return 1;
+}
+
+int vpu_imx8q_on_firmware_loaded(struct vpu_core *core)
+{
+	u8 *p;
+
+	p = core->fw.virt;
+	p[16] = core->vpu->res->plat_type;
+	p[17] = core->id;
+	p[18] = 1;
+
+	return 0;
+}
+
+u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size)
+{
+	const struct vpu_rpc_region_t imx8q_regions[] = {
+		{0x00000000, 0x08000000, VPU_CORE_MEMORY_CACHED},
+		{0x08000000, 0x10000000, VPU_CORE_MEMORY_UNCACHED},
+		{0x10000000, 0x20000000, VPU_CORE_MEMORY_CACHED},
+		{0x20000000, 0x40000000, VPU_CORE_MEMORY_UNCACHED}
+	};
+	int i;
+
+	if (addr < base)
+		return VPU_CORE_MEMORY_INVALID;
+
+	addr -= base;
+	for (i = 0; i < ARRAY_SIZE(imx8q_regions); i++) {
+		const struct vpu_rpc_region_t *region = &imx8q_regions[i];
+
+		if (addr >= region->start && addr + size < region->end)
+			return region->type;
+	}
+
+	return VPU_CORE_MEMORY_INVALID;
+}
+
+#ifdef CONFIG_IMX_SCU
+static u32 vpu_imx8q_get_fuse(void)
+{
+	static u32 fuse_got;
+	struct imx_sc_ipc *ipc;
+	struct vpu_sc_msg_misc msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	if (fuse_got)
+		return imx8q_fuse;
+
+	ret = imx_scu_get_handle(&ipc);
+	if (ret) {
+		pr_err("error: get sct handle fail: %d\n", ret);
+		return 0;
+	}
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_OTP_FUSE_READ;
+	hdr->size = 2;
+
+	msg.word = VPU_DISABLE_BITS;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return 0;
+
+	imx8q_fuse = msg.word;
+	fuse_got = 1;
+	return imx8q_fuse;
+}
+
+bool vpu_imx8q_check_codec(enum vpu_core_type type)
+{
+	u32 fuse = vpu_imx8q_get_fuse();
+
+	if (type == VPU_CORE_TYPE_ENC) {
+		if (fuse & VPU_ENCODER_MASK)
+			return false;
+	} else if (type == VPU_CORE_TYPE_DEC) {
+		fuse >>= VPU_IMX_DECODER_FUSE_OFFSET;
+		fuse &= VPU_DECODER_MASK;
+
+		if (fuse == VPU_DECODER_MASK)
+			return false;
+	}
+	return true;
+}
+
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt)
+{
+	u32 fuse = vpu_imx8q_get_fuse();
+
+	if (type == VPU_CORE_TYPE_DEC) {
+		fuse >>= VPU_IMX_DECODER_FUSE_OFFSET;
+		fuse &= VPU_DECODER_MASK;
+
+		if (fuse == VPU_DECODER_HEVC_MASK && pixelfmt == V4L2_PIX_FMT_HEVC)
+			return false;
+		if (fuse == VPU_DECODER_H264_MASK && pixelfmt == V4L2_PIX_FMT_H264)
+			return false;
+		if (fuse == VPU_DECODER_MASK)
+			return false;
+	}
+
+	return true;
+}
+#else
+bool vpu_imx8q_check_codec(enum vpu_core_type type)
+{
+	return true;
+}
+
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt)
+{
+	return true;
+}
+#endif
diff --git a/drivers/media/platform/amphion/vpu_imx8q.h b/drivers/media/platform/amphion/vpu_imx8q.h
new file mode 100644
index 000000000000..c50d055da233
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_imx8q.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#ifndef _AMPHION_VPU_IMX8Q_H
+#define _AMPHION_VPU_IMX8Q_H
+
+#define SCB_XREG_SLV_BASE                               0x00000000
+#define SCB_SCB_BLK_CTRL                                0x00070000
+#define SCB_BLK_CTRL_XMEM_RESET_SET                     0x00000090
+#define SCB_BLK_CTRL_CACHE_RESET_SET                    0x000000A0
+#define SCB_BLK_CTRL_CACHE_RESET_CLR                    0x000000A4
+#define SCB_BLK_CTRL_SCB_CLK_ENABLE_SET                 0x00000100
+
+#define XMEM_CONTROL                                    0x00041000
+
+#define	MC_CACHE_0_BASE					0x00060000
+#define	MC_CACHE_1_BASE					0x00068000
+
+#define DEC_MFD_XREG_SLV_BASE                           0x00180000
+#define ENC_MFD_XREG_SLV_0_BASE				0x00800000
+#define ENC_MFD_XREG_SLV_1_BASE				0x00A00000
+
+#define MFD_HIF                                         0x0001C000
+#define MFD_HIF_MSD_REG_INTERRUPT_STATUS                0x00000018
+#define MFD_SIF                                         0x0001D000
+#define MFD_SIF_CTRL_STATUS                             0x000000F0
+#define MFD_SIF_INTR_STATUS                             0x000000F4
+#define MFD_MCX                                         0x00020800
+#define MFD_MCX_OFF                                     0x00000020
+#define MFD_PIX_IF					0x00020000
+
+#define MFD_BLK_CTRL                                    0x00030000
+#define MFD_BLK_CTRL_MFD_SYS_RESET_SET                  0x00000000
+#define MFD_BLK_CTRL_MFD_SYS_RESET_CLR                  0x00000004
+#define MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_SET           0x00000100
+#define MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_CLR           0x00000104
+
+#define VID_API_NUM_STREAMS				8
+#define VID_API_MAX_BUF_PER_STR				3
+#define VID_API_MAX_NUM_MVC_VIEWS			4
+#define MEDIAIP_MAX_NUM_MALONES				2
+#define MEDIAIP_MAX_NUM_MALONE_IRQ_PINS			2
+#define MEDIAIP_MAX_NUM_WINDSORS			1
+#define MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS		2
+#define MEDIAIP_MAX_NUM_CMD_IRQ_PINS			2
+#define MEDIAIP_MAX_NUM_MSG_IRQ_PINS			1
+#define MEDIAIP_MAX_NUM_TIMER_IRQ_PINS			4
+#define MEDIAIP_MAX_NUM_TIMER_IRQ_SLOTS			4
+
+#define WINDSOR_PAL_IRQ_PIN_L				0x4
+#define WINDSOR_PAL_IRQ_PIN_H				0x5
+
+struct vpu_rpc_system_config {
+	u32 cfg_cookie;
+
+	u32 num_malones;
+	u32 malone_base_addr[MEDIAIP_MAX_NUM_MALONES];
+	u32 hif_offset[MEDIAIP_MAX_NUM_MALONES];
+	u32 malone_irq_pin[MEDIAIP_MAX_NUM_MALONES][MEDIAIP_MAX_NUM_MALONE_IRQ_PINS];
+	u32 malone_irq_target[MEDIAIP_MAX_NUM_MALONES][MEDIAIP_MAX_NUM_MALONE_IRQ_PINS];
+
+	u32 num_windsors;
+	u32 windsor_base_addr[MEDIAIP_MAX_NUM_WINDSORS];
+	u32 windsor_irq_pin[MEDIAIP_MAX_NUM_WINDSORS][MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS];
+	u32 windsor_irq_target[MEDIAIP_MAX_NUM_WINDSORS][MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS];
+
+	u32 cmd_irq_pin[MEDIAIP_MAX_NUM_CMD_IRQ_PINS];
+	u32 cmd_irq_target[MEDIAIP_MAX_NUM_CMD_IRQ_PINS];
+
+	u32 msg_irq_pin[MEDIAIP_MAX_NUM_MSG_IRQ_PINS];
+	u32 msg_irq_target[MEDIAIP_MAX_NUM_MSG_IRQ_PINS];
+
+	u32 sys_clk_freq;
+	u32 num_timers;
+	u32 timer_base_addr;
+	u32 timer_irq_pin[MEDIAIP_MAX_NUM_TIMER_IRQ_PINS];
+	u32 timer_irq_target[MEDIAIP_MAX_NUM_TIMER_IRQ_PINS];
+	u32 timer_slots[MEDIAIP_MAX_NUM_TIMER_IRQ_SLOTS];
+
+	u32 gic_base_addr;
+	u32 uart_base_addr;
+
+	u32 dpv_base_addr;
+	u32 dpv_irq_pin;
+	u32 dpv_irq_target;
+
+	u32 pixif_base_addr;
+
+	u32 pal_trace_level;
+	u32 pal_trace_destination;
+
+	u32 pal_trace_level1;
+	u32 pal_trace_destination1;
+
+	u32 uHeapBase;
+	u32 uHeapSize;
+
+	u32 cache_base_addr[2];
+};
+
+int vpu_imx8q_setup_dec(struct vpu_dev *vpu);
+int vpu_imx8q_setup_enc(struct vpu_dev *vpu);
+int vpu_imx8q_setup(struct vpu_dev *vpu);
+int vpu_imx8q_reset(struct vpu_dev *vpu);
+int vpu_imx8q_set_system_cfg_common(struct vpu_rpc_system_config *config,
+		u32 regs, u32 core_id);
+int vpu_imx8q_boot_core(struct vpu_core *core);
+int vpu_imx8q_get_power_state(struct vpu_core *core);
+int vpu_imx8q_on_firmware_loaded(struct vpu_core *core);
+u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size);
+bool vpu_imx8q_check_codec(enum vpu_core_type type);
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt);
+
+#endif
-- 
2.33.0

