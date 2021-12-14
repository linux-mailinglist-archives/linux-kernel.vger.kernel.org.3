Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5074745FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhLNPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhLNPGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C40EB81A01
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C9AC34605;
        Tue, 14 Dec 2021 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494363;
        bh=TdbOS8K6Z+aJHbCxdSmB2jTjSiPt8bbAFeALG8nz7sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp3um7h/TnqkRD2N8x1ujD4GqyiMjAtQxM38JQ3Tmdmas9SsDtMj1JVBJRC6dv4xx
         ZRcLUjlfDmhQSu4zw/9E6xz8STJtRYtrSaZfot7THGDtDFfMV/wulXtbRE2pqEtriT
         kW9z0LtipG7qNsIPJ3irPyqy5hpCCbpGa2NpH2v0o+jvmzW9EopKdtVO8bnGvciJA9
         kXZ3wSMA8z0RS/qmNLEAbpOTI6nrR7m0XN4MKqKh1Ra5sGz+6LIK0vrc0p0Yx+qwlB
         7Vi1wgGxYEJMKe+ONAV02puScXy4cs7JKBnITV405YP12sGqglfr/TTCEGo8cy21pB
         e2KTViyYzX9xg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/11] habanalabs: sysfs support for two infineon versions
Date:   Tue, 14 Dec 2021 17:05:46 +0200
Message-Id: <20211214150551.1568192-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently sysfs support dumping a single infineon version, in
future asics we will have two infineon versions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/sysfs.c            |  9 +++++++--
 drivers/misc/habanalabs/include/common/cpucp_if.h | 13 ++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 15e4ae65e515..39d449c712b6 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -163,8 +163,13 @@ static ssize_t infineon_ver_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "0x%04x\n",
-			hdev->asic_prop.cpucp_info.infineon_version);
+	if (hdev->asic_prop.cpucp_info.infineon_version2)
+		return sprintf(buf, "%#04x %#04x\n",
+			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_version),
+			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_version2));
+	else
+		return sprintf(buf, "%#04x\n",
+			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_version));
 }
 
 static ssize_t fuse_ver_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 078fb4bd0316..e4f44c4d20b5 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2021 HabanaLabs, Ltd.
+ * Copyright 2020-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -761,6 +761,7 @@ struct cpucp_security_info {
  * @fuse_version: silicon production FUSE information.
  * @thermal_version: thermald S/W version.
  * @cpucp_version: CpuCP S/W version.
+ * @infineon_version2: Infineon 2nd stage DC-DC version.
  * @dram_size: available DRAM size.
  * @card_name: card name that will be displayed in HWMON subsystem on the host
  * @sec_info: security information
@@ -770,6 +771,10 @@ struct cpucp_security_info {
  * @dram_binning_mask: DRAM binning mask, 1 bit per dram instance
  *                     (0 = functional 1 = binned)
  * @memory_repair_flag: eFuse flag indicating memory repair
+ * @edma_binning_mask: EDMA binning mask, 1 bit per EDMA instance
+ *                     (0 = functional 1 = binned)
+ * @xbar_binning_mask: Xbar binning mask, 1 bit per Xbar instance
+ *                     (0 = functional 1 = binned)
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -782,7 +787,7 @@ struct cpucp_info {
 	__u8 fuse_version[VERSION_MAX_LEN];
 	__u8 thermal_version[VERSION_MAX_LEN];
 	__u8 cpucp_version[VERSION_MAX_LEN];
-	__le32 reserved2;
+	__le32 infineon_version2;
 	__le64 dram_size;
 	char card_name[CARD_NAME_MAX_LEN];
 	__le64 reserved3;
@@ -790,7 +795,9 @@ struct cpucp_info {
 	__u8 reserved5;
 	__u8 dram_binning_mask;
 	__u8 memory_repair_flag;
-	__u8 pad[5];
+	__u8 edma_binning_mask;
+	__u8 xbar_binning_mask;
+	__u8 pad[3];
 	struct cpucp_security_info sec_info;
 	__le32 reserved6;
 	__u8 pll_map[PLL_MAP_LEN];
-- 
2.25.1

