Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB2593A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbiHOTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345033AbiHOT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:27:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AC5C359;
        Mon, 15 Aug 2022 11:43:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FHiuJI010929;
        Mon, 15 Aug 2022 18:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Mh7Y4USC1d7L8QNdWdLQgG/3ut7oqCwy46/BkS3TzvY=;
 b=L/j8RTudLgxBC+ngv7q2dcNSpcvgj157sHkBKCYEXN05UePZ/kujbaP1X6G6KNl6jGWF
 rZiAatrALaV9xB+CO6HmtvhZGObLspVhMf5cuAbn0YmdkaqeYFOodonIo73WyqfjEPLn
 HrgF2I/qpOiV6yhfZasDhzuoxMnuqZKBVhFcMZiHExi3BGgidrRT9xnSlXb70Ibqex4O
 KC8dTwlp4FdgGmCbTHlm6EXm0i9S7zF0pXAb3UgtquWLdWO3Lf40HInUe4Ea1k/GlgXx
 ejO+nVlvEnrLaBgHbsU7e5vpBiQYcPdPxEgoBuseV8pHEo/eyOdp9SrgyVfZqrxbIDT/ zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx2wxx74d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 18:43:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FIhN9r028407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 18:43:23 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 11:43:22 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>
CC:     <quic_carlv@quicinc.com>, <quic_ajitpals@quicinc.com>,
        <quic_pkanojiy@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [RFC PATCH 13/14] drm/qaic: Add qaic driver to the build system
Date:   Mon, 15 Aug 2022 12:42:35 -0600
Message-ID: <1660588956-24027-14-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
References: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iEkPC_91KBgWnqbZv4TuugVKsNIMsjP-
X-Proofpoint-GUID: iEkPC_91KBgWnqbZv4TuugVKsNIMsjP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=598
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the infrastructure that allows the QAIC driver to be built.

Change-Id: I5b609b2e91b6a99939bdac35849813263ad874af
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/gpu/drm/Kconfig       |  2 ++
 drivers/gpu/drm/Makefile      |  1 +
 drivers/gpu/drm/qaic/Kconfig  | 33 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/qaic/Makefile | 17 +++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 drivers/gpu/drm/qaic/Kconfig
 create mode 100644 drivers/gpu/drm/qaic/Makefile

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b1f22e4..b614940 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -390,6 +390,8 @@ source "drivers/gpu/drm/gud/Kconfig"
 
 source "drivers/gpu/drm/sprd/Kconfig"
 
+source "drivers/gpu/drm/qaic/Kconfig"
+
 config DRM_HYPERV
 	tristate "DRM Support for Hyper-V synthetic video device"
 	depends on DRM && PCI && MMU && HYPERV
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 301a44d..28b0f1b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -135,3 +135,4 @@ obj-y			+= xlnx/
 obj-y			+= gud/
 obj-$(CONFIG_DRM_HYPERV) += hyperv/
 obj-$(CONFIG_DRM_SPRD) += sprd/
+obj-$(CONFIG_DRM_QAIC) += qaic/
diff --git a/drivers/gpu/drm/qaic/Kconfig b/drivers/gpu/drm/qaic/Kconfig
new file mode 100644
index 0000000..eca2bcb
--- /dev/null
+++ b/drivers/gpu/drm/qaic/Kconfig
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm Cloud AI accelerators driver
+#
+
+config DRM_QAIC
+	tristate "Qualcomm Cloud AI accelerators"
+	depends on PCI && HAS_IOMEM
+	depends on MHI_BUS
+	depends on DRM
+	depends on MMU
+	select CRC32
+	help
+	  Enables driver for Qualcomm's Cloud AI accelerator PCIe cards that are
+	  designed to accelerate Deep Learning inference workloads.
+
+	  The driver manages the PCIe devices and provides an IOCTL interface
+	  for users to submit workloads to the devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qaic.
+
+config QAIC_HWMON
+	bool "Qualcomm Cloud AI accelerator telemetry"
+	depends on DRM_QAIC
+	depends on HWMON
+	help
+	  Enables telemetry via the HWMON interface for Qualcomm's Cloud AI
+	  accelerator PCIe cards.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/drm/qaic/Makefile b/drivers/gpu/drm/qaic/Makefile
new file mode 100644
index 0000000..4a5daff
--- /dev/null
+++ b/drivers/gpu/drm/qaic/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm Cloud AI accelerators driver
+#
+
+obj-$(CONFIG_DRM_QAIC)	:= qaic.o
+
+qaic-y := \
+	qaic_drv.o \
+	mhi_controller.o \
+	qaic_control.o \
+	qaic_data.o \
+	qaic_debugfs.o \
+	qaic_telemetry.o \
+	qaic_ras.o \
+	qaic_ssr.o \
+	qaic_sysfs.o
-- 
2.7.4

