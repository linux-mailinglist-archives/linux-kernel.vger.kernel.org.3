Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FB53EC22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiFFNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiFFNDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:03:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070E369F6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:03:33 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGtt04QCpzfbbk;
        Mon,  6 Jun 2022 21:01:44 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:03:30 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:03:29 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH v6 2/2] Documentation: Add document for UltraSoc SMB drivers
Date:   Mon, 6 Jun 2022 21:02:23 +0800
Message-ID: <20220606130223.57354-3-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220606130223.57354-1-liuqi115@huawei.com>
References: <20220606130223.57354-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch bring in a documentation for UltraSoc SMB drivers.
It simple descripts the device, sysfs interface and the
firmware bindings.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 .../trace/coresight/ultrasoc-smb.rst          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst

diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
new file mode 100644
index 000000000000..b4cfea82deb8
--- /dev/null
+++ b/Documentation/trace/coresight/ultrasoc-smb.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+UltraSoc - HW Assisted Tracing on SoC
+======================================
+   :Author:   Qi Liu <liuqi115@huawei.com>
+   :Date:     March 2022
+
+Introduction
+------------
+
+UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a way to buffer and store
+CPU trace messages in a region of shared system memory. SMB is plugged as
+a coresight sink device and the corresponding trace generators (ETM) are
+plugged in as source devices.
+
+Sysfs files and directories
+---------------------------
+
+The SMB devices appear on the existing coresight bus alongside the other
+coresight devices::
+
+	$# ls /sys/bus/coresight/devices/
+	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
+
+The ``ultra_smb<N>`` named SMB associated with SCCL.::
+
+	$# ls /sys/bus/coresight/devices/ultra_smb0
+	enable_sink   mgmt
+	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
+	buf_size  buf_status  read_pos  write_pos
+
+*Key file items are:-*
+   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
+   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
+   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
+		     BIT(0) is zero means buffer is empty.
+   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
+
+Firmware Bindings
+---------------------------
+
+Firmware binding of SMB device describes SMB device indentifier, resource
+information and graph structure.
+
+SMB is platform device and device id is "HISI03A1", resource of device is
+declared using the _CRS method. Each SMB must present two base address,
+the first one is the configuration base address of SMB device, the second
+one is the base address of shared system memory.
+
+examples::
+
+    Device(USMB) {                                               \
+      Name(_HID, "HISI03A1")                                     \
+      Name(_CRS, ResourceTemplate() {                            \
+          MEM_RESRC(0x95100000, 0x951FFFFF, 0x100000)            \
+          MEM_RESRC(0x50000000, 0x53FFFFFF, 0x4000000)           \
+      })                                                         \
+      Name(_DSD, Package() {                                     \
+        ToUUID("ab02a46b-74c7-45a2-bd68-f7d344ef2153"),          \
+	/* Use CoreSight Graph ACPI bindings to describe connections topology */
+        Package() {                                              \
+          0,                                                     \
+          1,                                                     \
+          Package() {                                            \
+            1,                                                   \
+            ToUUID("3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"),      \
+            8,                                                   \
+            Package() {0x8, 0, \_SB.S00.SL11.CL28.F008, 0},       \
+            Package() {0x9, 0, \_SB.S00.SL11.CL29.F009, 0},       \
+            Package() {0xa, 0, \_SB.S00.SL11.CL2A.F010, 0},       \
+            Package() {0xb, 0, \_SB.S00.SL11.CL2B.F011, 0},       \
+            Package() {0xc, 0, \_SB.S00.SL11.CL2C.F012, 0},       \
+            Package() {0xd, 0, \_SB.S00.SL11.CL2D.F013, 0},       \
+            Package() {0xe, 0, \_SB.S00.SL11.CL2E.F014, 0},       \
+            Package() {0xf, 0, \_SB.S00.SL11.CL2F.F015, 0},       \
+          }                                                      \
+        }                                                        \
+      })                                                         \
+    }
-- 
2.24.0

