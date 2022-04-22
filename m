Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494B250C228
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiDVWKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiDVWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0FD2DFD37;
        Fri, 22 Apr 2022 13:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnwrqAoLH3Z4ULLA8ezLrdMgopaNDSDbkpFC1dGmahE/wAyOKzxSHUmglf8E+s4XaoIApaho1n4M1BkFnqd9YxZ9xFhk+0OHQ/2wuSJ+WSa6DXYjDdra38w//2wEomHcUXY6CXHDNX3b3GmX5s3Oyz6zNzDa4rGX0/GxdEeBRyDAuNgrdN/4HHL1b88LrRtKQa6X5Ch21HOeNDFBcAnZhp1I6F2bUdvDfuBAVALtAahKvNG/1Eptpw0jWSzVHnJ4EXZEzqcGm1ulFSIQy9iC7La8FQ3zFg+CJBvKQyRDhXiQoBIzh4jufrnbfetioApkwvI2DXW3UUZKnV76TBVn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oCmEsBPLuTlfBnV0WyOx4ghZzXsQYyc0hgk4XzWEuw=;
 b=NhjoIFUkhtRB1YQNZZpGDX+1R10gBUbgKdyRiiuwA86A6M9Ze/HpldCzsSUW+mFJcUjaQXxFYj/1O5bvZHqLcFKkHGKl13ky5j3TZQQadGhGKWOJPE+gM3FvZtZ3xno1DeZZRjwJNUK38tMyapVHqnZrBJ2oAs8+RvgOkhiW/Pja0V9vY+ZU7D4cPzW80aLCMtFFS+rrAJLsY14cUpjdu50L+en0RYhpah5cRVC6Zt0HmNytpqvCOLyebuG2pM/UcKUyj5H3TOXHnM93IDONy4FWkwfLDQgBhttJtUZyySvjEeqVSeiYKMCpmIEZEiq1w7nB6mlU5ZQ2DXbSnGyH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oCmEsBPLuTlfBnV0WyOx4ghZzXsQYyc0hgk4XzWEuw=;
 b=R+iBq+AZMXmXExlMLvtqfZIgVC6RvyA5Hnwnfc+krmaay72ePYCt4T1W1geEKwRl+H30KMr1YbvMMBtmoEgrgvJQzOw5iq9Y6EU3lf4wYGI08sEeoKK2RE5iiN7/3de1PICujDslf3p80dUFAcRS5aqsDUx+F6KcU559/sdWQOeYnPB3ZMWjquvBloUDI7YPvsvmWKK8KKKAhSxeOphKZ55to3GB52505NGwFrjjx0xs+KPalWtgkp3yrDSwN2tAZH+a3v9nkFNPp0sFkjfrMxeUT5+hxJcsINdXVmu0avm7U0VagbqBcGOq9LoIgSV0E/4h6M5iwDbejJWpC3eIzQ==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:52:22 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::7f) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:19 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:19 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 02/10] drivers: Add hardware timestamp engine (HTE)
Date:   Fri, 22 Apr 2022 13:52:13 -0700
Message-ID: <20220422205221.952-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c74ef91-9f2d-466c-3ea6-08da24a1fef4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4103:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4103E7AFCAA54248E60B0782AEF79@CH2PR12MB4103.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EShgE8IKzDli0dc/+Gw5KjcutGeNcPmB2dL7r7+p9iRlHQrJuHqLhmHE8KMr0d27CpfWT11RAmX+5BkwjuhmQAja394PQmiOglNL7m5AeLYMsSs2omZTK10ua55YgiO4EtVkdgEVs5BRJB372wxNxkAs3p8+KRuZv2sePo1vC4z3dUjsVhjaWt6QuWFtaMwxTuf0R9wsyahdcdZH6oLAHI67GeGYNZS30Fssss7HjV7bag00ZOl94i1w8D7vAUzPZ5ep5QLR1xW8juAaRdRLKLKD6eHnGnM2a/ZwPNo8H6nmRcio4imVZL5dCYBuvSiD+HUcG9zPh41gDpGbWfJuOxbvQfZzU5M7IYvAX+PzQLRFxjOkZYSDnpElrxh1OdeYW5vo/P/4wx4VbVoo1IAHuMiYx/ahR30MaOKAUE1rVUueFBYs70tIsHHkoopVgQxfa3A/0GaoQA6+Hh4aW9i43SZVI+8zS6CeQAMh4Nv2TQC4v+NayU7ByadUii8raiu4HJFLzgf+8a8VoSdElktTPDahTl0tJfRF62U+pEuJplNaU7WTvfjI/xBN//UR2kxxhRSofq/qMfgTiqajJY9cRezZiVS0IyFxt0a6n7mPTgg+G1NWTJSj1+qQeEhMzpLWGNZcz6hMg8Xt+z6okHJT5hSG7riieW3SnpVTJX+CQQAu3vDnt7HocI1RGD+xqD68ZhHFDgIDLlXHE4QmAwDP4DX3JGctNvK1vEELp8dGW16YoVzexWBgaZiiy2nYMMlM2gyVDv5Thu53TFWzOQvLUA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(336012)(5660300002)(426003)(47076005)(30864003)(36860700001)(316002)(2906002)(7416002)(26005)(81166007)(921005)(356005)(70206006)(70586007)(4326008)(107886003)(6666004)(2616005)(86362001)(1076003)(7696005)(508600001)(40460700003)(8936002)(36756003)(82310400005)(83380400001)(186003)(110136005)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:21.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c74ef91-9f2d-466c-3ea6-08da24a1fef4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices can timestamp system lines/signals/Buses in real-time
using the hardware counter or other hardware means which can give
finer granularity and help avoid jitter introduced by software
timestamping. To utilize such functionality, this patchset creates
HTE subsystem where devices can register themselves as providers so
that the consumers devices can request specific line from the
providers. The patch also adds compilation support in Makefile and
menu options in Kconfig.

The provider does following:
- Registers chip with the framework.
- Provides translation hook to convert logical line id.
- Provides enable/disable, request/release callbacks.
- Pushes timestamp data to HTE subsystem.

The consumer does following:
- Initializes line attribute.
- Gets HTE timestamp descriptor.
- Requests timestamp functionality.
- Puts HTE timestamp descriptor.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v2:
- Removed buffer abstraction layer as well related APIs, HTE now will not store
any data, instead will pass to consumer as soon as it is available.
- Removed unnecessary dynamical allocations
- Removed timestamp retrieve API
- Removed release, unregister related APIs as their counterpart are resource
managed.
- Added kernel thread implementation if consumer indicates threaded callback
during request API time.
- Changed hte_req_ts_by_dt_node API to remove device node exposure from the
interface, instead consumer will their device node with property name that
indicates the provider it wants to use.

Changes in v3:
- Addressed grammatical/spelling errors.

Changes in v4:
- Added hte_req_ts_by_linedata_ns and removed hte_req_ts_by_hte_name.
- Corrected API descriptions based on review comments.
- Droped HTE_CB_ERROR and HTE_CB_TS_DROPPED enums.
- Added line attribute structure in hte ts descriptor.
- Added raw_level field in hte ts data structure.
- Added match_from_linedata callback for the providers.
- Added edge setup related flags should consumer requests, HTE now
can help setup should provider supports it.

Changes in v5:
- Replaced kernel thread with workqueue.

Changes in v6:
- Added line attribute initializer.
- Added API to obtain HTE descriptor.
- Added request count helper API.
- Renamed existing APIs to reflect above changes.

 drivers/Kconfig      |   2 +
 drivers/Makefile     |   1 +
 drivers/hte/Kconfig  |  14 +
 drivers/hte/Makefile |   2 +
 drivers/hte/hte.c    | 948 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hte.h  | 272 +++++++++++++
 6 files changed, 1239 insertions(+)
 create mode 100644 drivers/hte/Kconfig
 create mode 100644 drivers/hte/Makefile
 create mode 100644 drivers/hte/hte.c
 create mode 100644 include/linux/hte.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8d6cd5d08722..a5a7768f95d2 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -239,4 +239,6 @@ source "drivers/most/Kconfig"
 
 source "drivers/peci/Kconfig"
 
+source "drivers/hte/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 020780b6b4d2..368a09b6020a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -188,3 +188,4 @@ obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_PECI)		+= peci/
+obj-$(CONFIG_HTE)		+= hte/
diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
new file mode 100644
index 000000000000..478a80a2f384
--- /dev/null
+++ b/drivers/hte/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig HTE
+	bool "Hardware Timestamping Engine (HTE) Support"
+	help
+	  Hardware Timestamping Engine (HTE) Support.
+
+	  Some devices provide a hardware timestamping engine which can
+	  timestamp certain device lines/signals in realtime. It comes with a
+	  benefit for the applications needing accurate timestamping event with
+	  less jitter. This framework provides a generic interface to such HTE
+	  providers and consumer devices.
+
+	  If unsure, say no.
+
diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
new file mode 100644
index 000000000000..fc03bdf44427
--- /dev/null
+++ b/drivers/hte/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_HTE)		+= hte.o
+
diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
new file mode 100644
index 000000000000..82c3a65c35e5
--- /dev/null
+++ b/drivers/hte/hte.c
@@ -0,0 +1,948 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2022 NVIDIA Corporation
+ *
+ * Author: Dipen Patel <dipenp@nvidia.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <linux/hte.h>
+#include <linux/delay.h>
+#include <linux/debugfs.h>
+
+#define HTE_TS_NAME_LEN		10
+
+/* Global list of the HTE devices */
+static DEFINE_SPINLOCK(hte_lock);
+static LIST_HEAD(hte_devices);
+
+enum {
+	HTE_TS_REGISTERED,
+	HTE_TS_REQ,
+	HTE_TS_DISABLE,
+	HTE_TS_QUEUE_WK,
+};
+
+/**
+ * struct hte_ts_info - Information related to requested timestamp.
+ *
+ * @xlated_id: Timestamp ID as understood between HTE subsys and HTE provider,
+ * See xlate callback API.
+ * @flags: Flags holding state informations.
+ * @hte_cb_flags: Callback related flags.
+ * @seq: Timestamp sequence counter.
+ * @line_name: HTE allocated line name.
+ * @free_attr_name: If set, free the attr name.
+ * @cb: A nonsleeping callback function provided by clients.
+ * @tcb: A secondary sleeping callback function provided by clients.
+ * @dropped_ts: Dropped timestamps.
+ * @slock: Spin lock to synchronize between disable/enable,
+ * request/release APIs.
+ * @cb_work: callback workqueue, used when tcb is specified.
+ * @req_mlock: Lock during timestamp request/release APIs.
+ * @ts_dbg_root: Root for the debug fs.
+ * @gdev: HTE abstract device that this timestamp information belongs to.
+ * @cl_data: Client specific data.
+ */
+struct hte_ts_info {
+	u32 xlated_id;
+	unsigned long flags;
+	unsigned long hte_cb_flags;
+	u64 seq;
+	char *line_name;
+	bool free_attr_name;
+	hte_ts_cb_t cb;
+	hte_ts_sec_cb_t tcb;
+	atomic_t dropped_ts;
+	spinlock_t slock;
+	struct work_struct cb_work;
+	struct mutex req_mlock;
+	struct dentry *ts_dbg_root;
+	struct hte_device *gdev;
+	void *cl_data;
+};
+
+/**
+ * struct hte_device - HTE abstract device
+ * @nlines: Number of entities this device supports.
+ * @ts_req: Total number of entities requested.
+ * @sdev: Device used at various debug prints.
+ * @dbg_root: Root directory for debug fs.
+ * @list: List node to store hte_device for each provider.
+ * @chip: HTE chip providing this HTE device.
+ * @owner: helps prevent removal of modules when in use.
+ * @ei: Timestamp information.
+ */
+struct hte_device {
+	u32 nlines;
+	atomic_t ts_req;
+	struct device *sdev;
+	struct dentry *dbg_root;
+	struct list_head list;
+	struct hte_chip *chip;
+	struct module *owner;
+	struct hte_ts_info ei[];
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *hte_root;
+
+static int __init hte_subsys_dbgfs_init(void)
+{
+	/* creates /sys/kernel/debug/hte/ */
+	hte_root = debugfs_create_dir("hte", NULL);
+
+	return 0;
+}
+subsys_initcall(hte_subsys_dbgfs_init);
+
+static void hte_chip_dbgfs_init(struct hte_device *gdev)
+{
+	const struct hte_chip *chip = gdev->chip;
+	const char *name = chip->name ? chip->name : dev_name(chip->dev);
+
+	gdev->dbg_root = debugfs_create_dir(name, hte_root);
+
+	debugfs_create_atomic_t("ts_requested", 0444, gdev->dbg_root,
+				&gdev->ts_req);
+	debugfs_create_u32("total_ts", 0444, gdev->dbg_root,
+			   &gdev->nlines);
+}
+
+static void hte_ts_dbgfs_init(const char *name, struct hte_ts_info *ei)
+{
+	if (!ei->gdev->dbg_root || !name)
+		return;
+
+	ei->ts_dbg_root = debugfs_create_dir(name, ei->gdev->dbg_root);
+
+	debugfs_create_atomic_t("dropped_timestamps", 0444, ei->ts_dbg_root,
+				&ei->dropped_ts);
+}
+
+#else
+
+static void hte_chip_dbgfs_init(struct hte_device *gdev)
+{
+}
+
+static void hte_ts_dbgfs_init(const char *name, struct hte_ts_info *ei)
+{
+}
+
+#endif
+
+/**
+ * hte_ts_put() - Release and disable timestamp for the given desc.
+ *
+ * @desc: timestamp descriptor.
+ *
+ * Context: debugfs_remove_recursive() function call may use sleeping locks,
+ *	    not suitable from atomic context.
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int hte_ts_put(struct hte_ts_desc *desc)
+{
+	int ret = 0;
+	unsigned long flag;
+	struct hte_device *gdev;
+	struct hte_ts_info *ei;
+
+	if (!desc)
+		return -EINVAL;
+
+	ei = desc->hte_data;
+
+	if (!ei || !ei->gdev)
+		return -EINVAL;
+
+	gdev = ei->gdev;
+
+	mutex_lock(&ei->req_mlock);
+
+	if (unlikely(!test_bit(HTE_TS_REQ, &ei->flags) &&
+	    !test_bit(HTE_TS_REGISTERED, &ei->flags))) {
+		dev_info(gdev->sdev, "id:%d is not requested\n",
+			 desc->attr.line_id);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (unlikely(!test_bit(HTE_TS_REQ, &ei->flags) &&
+	    test_bit(HTE_TS_REGISTERED, &ei->flags))) {
+		dev_info(gdev->sdev, "id:%d is registered but not requested\n",
+			 desc->attr.line_id);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (test_bit(HTE_TS_REQ, &ei->flags) &&
+	    !test_bit(HTE_TS_REGISTERED, &ei->flags)) {
+		clear_bit(HTE_TS_REQ, &ei->flags);
+		desc->hte_data = NULL;
+		ret = 0;
+		goto mod_put;
+	}
+
+	ret = gdev->chip->ops->release(gdev->chip, desc, ei->xlated_id);
+	if (ret) {
+		dev_err(gdev->sdev, "id: %d free failed\n",
+			desc->attr.line_id);
+		goto unlock;
+	}
+
+	kfree(ei->line_name);
+	if (ei->free_attr_name)
+		kfree_const(desc->attr.name);
+
+	debugfs_remove_recursive(ei->ts_dbg_root);
+
+	spin_lock_irqsave(&ei->slock, flag);
+
+	if (test_bit(HTE_TS_QUEUE_WK, &ei->flags)) {
+		spin_unlock_irqrestore(&ei->slock, flag);
+		flush_work(&ei->cb_work);
+		spin_lock_irqsave(&ei->slock, flag);
+	}
+
+	atomic_dec(&gdev->ts_req);
+	atomic_set(&ei->dropped_ts, 0);
+
+	ei->seq = 1;
+	ei->flags = 0;
+	desc->hte_data = NULL;
+
+	spin_unlock_irqrestore(&ei->slock, flag);
+
+	ei->cb = NULL;
+	ei->tcb = NULL;
+	ei->cl_data = NULL;
+
+mod_put:
+	module_put(gdev->owner);
+unlock:
+	mutex_unlock(&ei->req_mlock);
+	dev_dbg(gdev->sdev, "release id: %d\n", desc->attr.line_id);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hte_ts_put);
+
+static int hte_ts_dis_en_common(struct hte_ts_desc *desc, bool en)
+{
+	u32 ts_id;
+	struct hte_device *gdev;
+	struct hte_ts_info *ei;
+	int ret;
+	unsigned long flag;
+
+	if (!desc)
+		return -EINVAL;
+
+	ei = desc->hte_data;
+
+	if (!ei || !ei->gdev)
+		return -EINVAL;
+
+	gdev = ei->gdev;
+	ts_id = desc->attr.line_id;
+
+	mutex_lock(&ei->req_mlock);
+
+	if (!test_bit(HTE_TS_REGISTERED, &ei->flags)) {
+		dev_dbg(gdev->sdev, "id:%d is not registered", ts_id);
+		ret = -EUSERS;
+		goto out;
+	}
+
+	spin_lock_irqsave(&ei->slock, flag);
+
+	if (en) {
+		if (!test_bit(HTE_TS_DISABLE, &ei->flags)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		spin_unlock_irqrestore(&ei->slock, flag);
+		ret = gdev->chip->ops->enable(gdev->chip, ei->xlated_id);
+		if (ret) {
+			dev_warn(gdev->sdev, "id: %d enable failed\n",
+				 ts_id);
+			goto out;
+		}
+
+		spin_lock_irqsave(&ei->slock, flag);
+		clear_bit(HTE_TS_DISABLE, &ei->flags);
+	} else {
+		if (test_bit(HTE_TS_DISABLE, &ei->flags)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		spin_unlock_irqrestore(&ei->slock, flag);
+		ret = gdev->chip->ops->disable(gdev->chip, ei->xlated_id);
+		if (ret) {
+			dev_warn(gdev->sdev, "id: %d disable failed\n",
+				 ts_id);
+			goto out;
+		}
+
+		spin_lock_irqsave(&ei->slock, flag);
+		set_bit(HTE_TS_DISABLE, &ei->flags);
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&ei->slock, flag);
+out:
+	mutex_unlock(&ei->req_mlock);
+	return ret;
+}
+
+/**
+ * hte_disable_ts() - Disable timestamp on given descriptor.
+ *
+ * The API does not release any resources associated with desc.
+ *
+ * @desc: ts descriptor, this is the same as returned by the request API.
+ *
+ * Context: Holds mutex lock, not suitable from atomic context.
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int hte_disable_ts(struct hte_ts_desc *desc)
+{
+	return hte_ts_dis_en_common(desc, false);
+}
+EXPORT_SYMBOL_GPL(hte_disable_ts);
+
+/**
+ * hte_enable_ts() - Enable timestamp on given descriptor.
+ *
+ * @desc: ts descriptor, this is the same as returned by the request API.
+ *
+ * Context: Holds mutex lock, not suitable from atomic context.
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int hte_enable_ts(struct hte_ts_desc *desc)
+{
+	return hte_ts_dis_en_common(desc, true);
+}
+EXPORT_SYMBOL_GPL(hte_enable_ts);
+
+static void hte_do_cb_work(struct work_struct *w)
+{
+	unsigned long flag;
+	struct hte_ts_info *ei = container_of(w, struct hte_ts_info, cb_work);
+
+	if (unlikely(!ei->tcb))
+		return;
+
+	ei->tcb(ei->cl_data);
+
+	spin_lock_irqsave(&ei->slock, flag);
+	clear_bit(HTE_TS_QUEUE_WK, &ei->flags);
+	spin_unlock_irqrestore(&ei->slock, flag);
+}
+
+static int __hte_req_ts(struct hte_ts_desc *desc, hte_ts_cb_t cb,
+			hte_ts_sec_cb_t tcb, void *data)
+{
+	int ret;
+	struct hte_device *gdev;
+	struct hte_ts_info *ei = desc->hte_data;
+
+	gdev = ei->gdev;
+	/*
+	 * There is a chance that multiple consumers requesting same entity,
+	 * lock here.
+	 */
+	mutex_lock(&ei->req_mlock);
+
+	if (test_bit(HTE_TS_REGISTERED, &ei->flags) ||
+	    !test_bit(HTE_TS_REQ, &ei->flags)) {
+		dev_dbg(gdev->chip->dev, "id:%u req failed\n",
+			desc->attr.line_id);
+		ret = -EUSERS;
+		goto unlock;
+	}
+
+	ei->cb = cb;
+	ei->tcb = tcb;
+	if (tcb)
+		INIT_WORK(&ei->cb_work, hte_do_cb_work);
+
+	ret = gdev->chip->ops->request(gdev->chip, desc, ei->xlated_id);
+	if (ret < 0) {
+		dev_err(gdev->chip->dev, "ts request failed\n");
+		goto unlock;
+	}
+
+	ei->cl_data = data;
+	ei->seq = 1;
+
+	atomic_inc(&gdev->ts_req);
+
+	ei->line_name = NULL;
+	if (!desc->attr.name) {
+		ei->line_name = kzalloc(HTE_TS_NAME_LEN, GFP_KERNEL);
+		if (ei->line_name)
+			scnprintf(ei->line_name, HTE_TS_NAME_LEN, "ts_%u",
+				  desc->attr.line_id);
+	}
+
+	hte_ts_dbgfs_init(desc->attr.name == NULL ?
+			  ei->line_name : desc->attr.name, ei);
+	set_bit(HTE_TS_REGISTERED, &ei->flags);
+
+	dev_dbg(gdev->chip->dev, "id: %u, xlated id:%u",
+		desc->attr.line_id, ei->xlated_id);
+
+	ret = 0;
+
+unlock:
+	mutex_unlock(&ei->req_mlock);
+
+	return ret;
+}
+
+static int hte_bind_ts_info_locked(struct hte_ts_info *ei,
+				   struct hte_ts_desc *desc, u32 x_id)
+{
+	int ret = 0;
+
+	mutex_lock(&ei->req_mlock);
+
+	if (test_bit(HTE_TS_REQ, &ei->flags)) {
+		dev_dbg(ei->gdev->chip->dev, "id:%u is already requested\n",
+			desc->attr.line_id);
+		ret = -EUSERS;
+		goto out;
+	}
+
+	set_bit(HTE_TS_REQ, &ei->flags);
+	desc->hte_data = ei;
+	ei->xlated_id = x_id;
+
+out:
+	mutex_unlock(&ei->req_mlock);
+
+	return ret;
+}
+
+static struct hte_device *of_node_to_htedevice(struct device_node *np)
+{
+	struct hte_device *gdev;
+
+	spin_lock(&hte_lock);
+
+	list_for_each_entry(gdev, &hte_devices, list)
+		if (gdev->chip && gdev->chip->dev &&
+		    gdev->chip->dev->of_node == np) {
+			spin_unlock(&hte_lock);
+			return gdev;
+		}
+
+	spin_unlock(&hte_lock);
+
+	return ERR_PTR(-ENODEV);
+}
+
+static struct hte_device *hte_find_dev_from_linedata(struct hte_ts_desc *desc)
+{
+	struct hte_device *gdev;
+
+	spin_lock(&hte_lock);
+
+	list_for_each_entry(gdev, &hte_devices, list)
+		if (gdev->chip && gdev->chip->match_from_linedata) {
+			if (!gdev->chip->match_from_linedata(gdev->chip, desc))
+				continue;
+			spin_unlock(&hte_lock);
+			return gdev;
+		}
+
+	spin_unlock(&hte_lock);
+
+	return ERR_PTR(-ENODEV);
+}
+
+/**
+ * of_hte_req_count - Return the number of entities to timestamp.
+ *
+ * The function returns the total count of the requested entities to timestamp
+ * by parsing device tree.
+ *
+ * @dev: The HTE consumer.
+ *
+ * Returns: Positive number on success, -ENOENT if no entries,
+ * -EINVAL for other errors.
+ */
+int of_hte_req_count(struct device *dev)
+{
+	int count;
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	count = of_count_phandle_with_args(dev->of_node, "timestamps",
+					   "#timestamp-cells");
+
+	return count ? count : -ENOENT;
+}
+EXPORT_SYMBOL_GPL(of_hte_req_count);
+
+static inline struct hte_device *hte_get_dev(struct hte_ts_desc *desc)
+{
+	return hte_find_dev_from_linedata(desc);
+}
+
+static struct hte_device *hte_of_get_dev(struct device *dev,
+					 struct hte_ts_desc *desc,
+					 int index,
+					 struct of_phandle_args *args,
+					 bool *free_name)
+{
+	int ret;
+	struct device_node *np;
+	char *temp;
+
+	if (!dev->of_node)
+		return ERR_PTR(-EINVAL);
+
+	np = dev->of_node;
+
+	if (!of_find_property(np, "timestamp-names", NULL)) {
+		/* Let hte core construct it during request time */
+		desc->attr.name = NULL;
+	} else {
+		ret = of_property_read_string_index(np, "timestamp-names",
+						    index, &desc->attr.name);
+		if (ret) {
+			pr_err("can't parse \"timestamp-names\" property\n");
+			return ERR_PTR(ret);
+		}
+		*free_name = false;
+		if (desc->attr.name) {
+			temp = skip_spaces(desc->attr.name);
+			if (!*temp)
+				desc->attr.name = NULL;
+		}
+	}
+
+	ret = of_parse_phandle_with_args(np, "timestamps", "#timestamp-cells",
+					 index, args);
+	if (ret) {
+		pr_err("%s(): can't parse \"timestamps\" property\n",
+		       __func__);
+		return ERR_PTR(ret);
+	}
+
+	of_node_put(args->np);
+
+	return of_node_to_htedevice(args->np);
+}
+
+/**
+ * hte_ts_get() - The function to initialize and obtain HTE desc.
+ *
+ * The function initializes the consumer provided HTE descriptor. If consumer
+ * has device tree node, index is used to parse the line id and other details.
+ * The function needs to be called before using any request APIs.
+ *
+ * @dev: HTE consumer/client device, used in case of parsing device tree node.
+ * @desc: Pre-allocated timestamp descriptor.
+ * @index: The index will be used as an index to parse line_id from the
+ * device tree node if node is present.
+ *
+ * Context: Holds mutex lock.
+ * Returns: Returns 0 on success or negative error code on failure.
+ */
+int hte_ts_get(struct device *dev, struct hte_ts_desc *desc, int index)
+{
+	struct hte_device *gdev;
+	struct hte_ts_info *ei;
+	const struct fwnode_handle *fwnode;
+	struct of_phandle_args args;
+	u32 xlated_id;
+	int ret;
+	bool free_name;
+
+	if (!desc)
+		return -EINVAL;
+
+	fwnode = dev ? dev_fwnode(dev) : NULL;
+
+	if (is_of_node(fwnode))
+		gdev = hte_of_get_dev(dev, desc, index, &args, &free_name);
+	else
+		gdev = hte_get_dev(desc);
+
+	if (IS_ERR(gdev)) {
+		pr_err("%s() no hte dev found\n", __func__);
+		return PTR_ERR(gdev);
+	}
+
+	if (!try_module_get(gdev->owner))
+		return -ENODEV;
+
+	if (!gdev->chip) {
+		pr_err("%s(): requested id does not have provider\n",
+		       __func__);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (is_of_node(fwnode)) {
+		if (!gdev->chip->xlate_of)
+			ret = -EINVAL;
+		else
+			ret = gdev->chip->xlate_of(gdev->chip, &args,
+						   desc, &xlated_id);
+	} else {
+		if (!gdev->chip->xlate_plat)
+			ret = -EINVAL;
+		else
+			ret = gdev->chip->xlate_plat(gdev->chip, desc,
+						     &xlated_id);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	ei = &gdev->ei[xlated_id];
+
+	ret = hte_bind_ts_info_locked(ei, desc, xlated_id);
+	if (ret)
+		goto out;
+
+	ei->free_attr_name = free_name;
+
+	return 0;
+
+out:
+	module_put(ei->gdev->owner);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hte_ts_get);
+
+static void __devm_hte_release_ts(void *res)
+{
+	hte_ts_put(res);
+}
+
+/**
+ * hte_request_ts_ns() - The API to request and enable hardware timestamp in
+ * nanoseconds.
+ *
+ * The entity is provider specific for example, GPIO lines, signals, buses
+ * etc...The API allocates necessary resources and enables the timestamp.
+ *
+ * @desc: Pre-allocated and initialized timestamp descriptor.
+ * @cb: Callback to push the timestamp data to consumer.
+ * @tcb: Optional callback. If its provided, subsystem initializes
+ * workqueue. It is called when cb returns HTE_RUN_SECOND_CB.
+ * @data: Client data, used during cb and tcb callbacks.
+ *
+ * Context: Holds mutex lock.
+ * Returns: Returns 0 on success or negative error code on failure.
+ */
+int hte_request_ts_ns(struct hte_ts_desc *desc, hte_ts_cb_t cb,
+		      hte_ts_sec_cb_t tcb, void *data)
+{
+	int ret;
+	struct hte_ts_info *ei;
+
+	if (!desc || !desc->hte_data || !cb)
+		return -EINVAL;
+
+	ei = desc->hte_data;
+	if (!ei || !ei->gdev)
+		return -EINVAL;
+
+	ret = __hte_req_ts(desc, cb, tcb, data);
+	if (ret < 0) {
+		dev_err(ei->gdev->chip->dev,
+			"failed to request id: %d\n", desc->attr.line_id);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hte_request_ts_ns);
+
+/**
+ * devm_hte_request_ts_ns() - Resource managed API to request and enable
+ * hardware timestamp in nanoseconds.
+ *
+ * The entity is provider specific for example, GPIO lines, signals, buses
+ * etc...The API allocates necessary resources and enables the timestamp. It
+ * deallocates and disables automatically when the consumer exits.
+ *
+ * @dev: HTE consumer/client device.
+ * @desc: Pre-allocated and initialized timestamp descriptor.
+ * @cb: Callback to push the timestamp data to consumer.
+ * @tcb: Optional callback. If its provided, subsystem initializes
+ * workqueue. It is called when cb returns HTE_RUN_SECOND_CB.
+ * @data: Client data, used during cb and tcb callbacks.
+ *
+ * Context: Holds mutex lock.
+ * Returns: Returns 0 on success or negative error code on failure.
+ */
+int devm_hte_request_ts_ns(struct device *dev, struct hte_ts_desc *desc,
+			   hte_ts_cb_t cb, hte_ts_sec_cb_t tcb,
+			   void *data)
+{
+	int err;
+
+	if (!dev)
+		return -EINVAL;
+
+	err = hte_request_ts_ns(desc, cb, tcb, data);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, __devm_hte_release_ts, desc);
+	if (err)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_hte_request_ts_ns);
+
+/**
+ * hte_init_line_attr() - Initialize line attributes.
+ *
+ * Zeroes out line attributes and initializes with provided arguments.
+ * The function needs to be called before calling any consumer facing
+ * functions.
+ *
+ * @desc: Pre-allocated timestamp descriptor.
+ * @line_id: line id.
+ * @edge_flags: edge flags related to line_id.
+ * @name: name of the line.
+ * @data: line data related to line_id.
+ *
+ * Context: Any.
+ * Returns: 0 on success or negative error code for the failure.
+ */
+int hte_init_line_attr(struct hte_ts_desc *desc, u32 line_id,
+		       unsigned long edge_flags, const char *name, void *data)
+{
+	if (!desc)
+		return -EINVAL;
+
+	memset(&desc->attr, 0, sizeof(desc->attr));
+
+	desc->attr.edge_flags = edge_flags;
+	desc->attr.line_id = line_id;
+	desc->attr.line_data = data;
+	if (name) {
+		name =  kstrdup_const(name, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+	}
+
+	desc->attr.name = name;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hte_init_line_attr);
+
+/**
+ * hte_get_clk_src_info() - Get the clock source information for a ts
+ * descriptor.
+ *
+ * @desc: ts descriptor, same as returned from request API.
+ * @ci: The API fills this structure with the clock information data.
+ *
+ * Context: Any context.
+ * Returns: 0 on success else negative error code on failure.
+ */
+int hte_get_clk_src_info(const struct hte_ts_desc *desc,
+			 struct hte_clk_info *ci)
+{
+	struct hte_chip *chip;
+	struct hte_ts_info *ei;
+
+	if (!desc || !desc->hte_data || !ci) {
+		pr_debug("%s:%d\n", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	ei = desc->hte_data;
+	if (!ei->gdev || !ei->gdev->chip)
+		return -EINVAL;
+
+	chip = ei->gdev->chip;
+	if (!chip->ops->get_clk_src_info)
+		return -ENOTSUPP;
+
+	return chip->ops->get_clk_src_info(chip, ci);
+}
+EXPORT_SYMBOL_GPL(hte_get_clk_src_info);
+
+/**
+ * hte_push_ts_ns() - Push timestamp data in nanoseconds.
+ *
+ * It is used by the provider to push timestamp data.
+ *
+ * @chip: The HTE chip, used during the registration.
+ * @xlated_id: entity id understood by both subsystem and provider, this is
+ * obtained from xlate callback during request API.
+ * @data: timestamp data.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
+		   struct hte_ts_data *data)
+{
+	hte_return_t ret;
+	int st = 0;
+	struct hte_ts_info *ei;
+	unsigned long flag;
+
+	if (!chip || !data || !chip->gdev)
+		return -EINVAL;
+
+	if (xlated_id > chip->nlines)
+		return -EINVAL;
+
+	ei = &chip->gdev->ei[xlated_id];
+
+	spin_lock_irqsave(&ei->slock, flag);
+
+	/* timestamp sequence counter */
+	data->seq = ei->seq++;
+
+	if (!test_bit(HTE_TS_REGISTERED, &ei->flags) ||
+	    test_bit(HTE_TS_DISABLE, &ei->flags)) {
+		dev_dbg(chip->dev, "Unknown timestamp push\n");
+		atomic_inc(&ei->dropped_ts);
+		st = -EINVAL;
+		goto unlock;
+	}
+
+	ret = ei->cb(data, ei->cl_data);
+	if (ret == HTE_RUN_SECOND_CB && ei->tcb) {
+		queue_work(system_unbound_wq, &ei->cb_work);
+		set_bit(HTE_TS_QUEUE_WK, &ei->flags);
+	}
+
+unlock:
+	spin_unlock_irqrestore(&ei->slock, flag);
+
+	return st;
+}
+EXPORT_SYMBOL_GPL(hte_push_ts_ns);
+
+static int hte_register_chip(struct hte_chip *chip)
+{
+	struct hte_device *gdev;
+	u32 i;
+
+	if (!chip || !chip->dev || !chip->dev->of_node)
+		return -EINVAL;
+
+	if (!chip->ops || !chip->ops->request || !chip->ops->release) {
+		dev_err(chip->dev, "Driver needs to provide ops\n");
+		return -EINVAL;
+	}
+
+	gdev = kzalloc(struct_size(gdev, ei, chip->nlines), GFP_KERNEL);
+	if (!gdev)
+		return -ENOMEM;
+
+	gdev->chip = chip;
+	chip->gdev = gdev;
+	gdev->nlines = chip->nlines;
+	gdev->sdev = chip->dev;
+
+	for (i = 0; i < chip->nlines; i++) {
+		gdev->ei[i].gdev = gdev;
+		mutex_init(&gdev->ei[i].req_mlock);
+		spin_lock_init(&gdev->ei[i].slock);
+	}
+
+	if (chip->dev->driver)
+		gdev->owner = chip->dev->driver->owner;
+	else
+		gdev->owner = THIS_MODULE;
+
+	of_node_get(chip->dev->of_node);
+
+	INIT_LIST_HEAD(&gdev->list);
+
+	spin_lock(&hte_lock);
+	list_add_tail(&gdev->list, &hte_devices);
+	spin_unlock(&hte_lock);
+
+	hte_chip_dbgfs_init(gdev);
+
+	dev_dbg(chip->dev, "Added hte chip\n");
+
+	return 0;
+}
+
+static int hte_unregister_chip(struct hte_chip *chip)
+{
+	struct hte_device *gdev;
+
+	if (!chip)
+		return -EINVAL;
+
+	gdev = chip->gdev;
+
+	spin_lock(&hte_lock);
+	list_del(&gdev->list);
+	spin_unlock(&hte_lock);
+
+	gdev->chip = NULL;
+
+	of_node_put(chip->dev->of_node);
+	debugfs_remove_recursive(gdev->dbg_root);
+	kfree(gdev);
+
+	dev_dbg(chip->dev, "Removed hte chip\n");
+
+	return 0;
+}
+
+static void _hte_devm_unregister_chip(void *chip)
+{
+	hte_unregister_chip(chip);
+}
+
+/**
+ * devm_hte_register_chip() - Resource managed API to register HTE chip.
+ *
+ * It is used by the provider to register itself with the HTE subsystem.
+ * The unregistration is done automatically when the provider exits.
+ *
+ * @chip: the HTE chip to add to subsystem.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int devm_hte_register_chip(struct hte_chip *chip)
+{
+	int err;
+
+	err = hte_register_chip(chip);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(chip->dev, _hte_devm_unregister_chip,
+				       chip);
+	if (err)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_hte_register_chip);
diff --git a/include/linux/hte.h b/include/linux/hte.h
new file mode 100644
index 000000000000..8bde9c165fd2
--- /dev/null
+++ b/include/linux/hte.h
@@ -0,0 +1,272 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_HTE_H
+#define __LINUX_HTE_H
+
+#include <linux/errno.h>
+
+struct hte_chip;
+struct hte_device;
+struct of_phandle_args;
+
+/**
+ * enum hte_edge - HTE line edge flags.
+ *
+ * @HTE_EDGE_NO_SETUP: No edge setup. In this case consumer will setup edges,
+ * for example during request irq call.
+ * @HTE_RISING_EDGE_TS: Rising edge.
+ * @HTE_FALLING_EDGE_TS: Falling edge.
+ *
+ */
+enum hte_edge {
+	HTE_EDGE_NO_SETUP = 1U << 0,
+	HTE_RISING_EDGE_TS = 1U << 1,
+	HTE_FALLING_EDGE_TS = 1U << 2,
+};
+
+/**
+ * enum hte_return- HTE subsystem return values used during callback.
+ *
+ * @HTE_CB_HANDLED: The consumer handled the data.
+ * @HTE_RUN_SECOND_CB: The consumer needs further processing, in that case
+ * HTE subsystem calls secondary callback provided by the consumer where it
+ * is allowed to sleep.
+ */
+enum hte_return {
+	HTE_CB_HANDLED,
+	HTE_RUN_SECOND_CB,
+};
+typedef enum hte_return hte_return_t;
+
+/**
+ * struct hte_ts_data - HTE timestamp data.
+ *
+ * @tsc: Timestamp value.
+ * @seq: Sequence counter of the timestamps.
+ * @raw_level: Level of the line at the timestamp if provider supports it,
+ * -1 otherwise.
+ */
+struct hte_ts_data {
+	u64 tsc;
+	u64 seq;
+	int raw_level;
+};
+
+/**
+ * struct hte_clk_info - Clock source info that HTE provider uses to timestamp.
+ *
+ * @hz: Supported clock rate in HZ, for example 1KHz clock = 1000.
+ * @type: Supported clock type.
+ */
+struct hte_clk_info {
+	u64 hz;
+	clockid_t type;
+};
+
+/**
+ * typedef hte_ts_cb_t - HTE timestamp data processing primary callback.
+ *
+ * The callback is used to push timestamp data to the client and it is
+ * not allowed to sleep.
+ *
+ * @ts: HW timestamp data.
+ * @data: Client supplied data.
+ */
+typedef hte_return_t (*hte_ts_cb_t)(struct hte_ts_data *ts, void *data);
+
+/**
+ * typedef hte_ts_sec_cb_t - HTE timestamp data processing secondary callback.
+ *
+ * This is used when the client needs further processing where it is
+ * allowed to sleep.
+ *
+ * @data: Client supplied data.
+ *
+ */
+typedef hte_return_t (*hte_ts_sec_cb_t)(void *data);
+
+/**
+ * struct hte_line_attr - Line attributes.
+ *
+ * @line_id: The logical ID understood by the consumers and providers.
+ * @line_data: Line data related to line_id.
+ * @edge_flags: Edge setup flags.
+ * @name: Descriptive name of the entity that is being monitored for the
+ * hardware timestamping. If null, HTE core will construct the name.
+ *
+ */
+struct hte_line_attr {
+	u32 line_id;
+	void *line_data;
+	unsigned long edge_flags;
+	const char *name;
+};
+
+/**
+ * struct hte_ts_desc - HTE timestamp descriptor.
+ *
+ * This structure is a communication token between consumers to subsystem
+ * and subsystem to providers.
+ *
+ * @attr: The line attributes.
+ * @hte_data: Subsystem's private data, set by HTE subsystem.
+ */
+struct hte_ts_desc {
+	struct hte_line_attr attr;
+	void *hte_data;
+};
+
+/**
+ * struct hte_ops - HTE operations set by providers.
+ *
+ * @request: Hook for requesting a HTE timestamp. Returns 0 on success,
+ * non-zero for failures.
+ * @release: Hook for releasing a HTE timestamp. Returns 0 on success,
+ * non-zero for failures.
+ * @enable: Hook to enable the specified timestamp. Returns 0 on success,
+ * non-zero for failures.
+ * @disable: Hook to disable specified timestamp. Returns 0 on success,
+ * non-zero for failures.
+ * @get_clk_src_info: Hook to get the clock information the provider uses
+ * to timestamp. Returns 0 for success and negative error code for failure. On
+ * success HTE subsystem fills up provided struct hte_clk_info.
+ *
+ * xlated_id parameter is used to communicate between HTE subsystem and the
+ * providers and is translated by the provider.
+ */
+struct hte_ops {
+	int (*request)(struct hte_chip *chip, struct hte_ts_desc *desc,
+		       u32 xlated_id);
+	int (*release)(struct hte_chip *chip, struct hte_ts_desc *desc,
+		       u32 xlated_id);
+	int (*enable)(struct hte_chip *chip, u32 xlated_id);
+	int (*disable)(struct hte_chip *chip, u32 xlated_id);
+	int (*get_clk_src_info)(struct hte_chip *chip,
+				struct hte_clk_info *ci);
+};
+
+/**
+ * struct hte_chip - Abstract HTE chip.
+ *
+ * @name: functional name of the HTE IP block.
+ * @dev: device providing the HTE.
+ * @ops: callbacks for this HTE.
+ * @nlines: number of lines/signals supported by this chip.
+ * @xlate_of: Callback which translates consumer supplied logical ids to
+ * physical ids, return 0 for the success and negative for the failures.
+ * It stores (between 0 to @nlines) in xlated_id parameter for the success.
+ * @xlate_plat: Same as above but for the consumers with no DT node.
+ * @match_from_linedata: Match HTE device using the line_data.
+ * @of_hte_n_cells: Number of cells used to form the HTE specifier.
+ * @gdev: HTE subsystem abstract device, internal to the HTE subsystem.
+ * @data: chip specific private data.
+ */
+struct hte_chip {
+	const char *name;
+	struct device *dev;
+	const struct hte_ops *ops;
+	u32 nlines;
+	int (*xlate_of)(struct hte_chip *gc,
+			const struct of_phandle_args *args,
+			struct hte_ts_desc *desc, u32 *xlated_id);
+	int (*xlate_plat)(struct hte_chip *gc, struct hte_ts_desc *desc,
+			 u32 *xlated_id);
+	bool (*match_from_linedata)(const struct hte_chip *chip,
+				    const struct hte_ts_desc *hdesc);
+	u8 of_hte_n_cells;
+
+	struct hte_device *gdev;
+	void *data;
+};
+
+#if IS_ENABLED(CONFIG_HTE)
+/* HTE APIs for the providers */
+int devm_hte_register_chip(struct hte_chip *chip);
+int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
+		   struct hte_ts_data *data);
+
+/* HTE APIs for the consumers */
+int hte_init_line_attr(struct hte_ts_desc *desc, u32 line_id,
+		       unsigned long edge_flags, const char *name,
+		       void *data);
+int hte_ts_get(struct device *dev, struct hte_ts_desc *desc, int index);
+int hte_ts_put(struct hte_ts_desc *desc);
+int hte_request_ts_ns(struct hte_ts_desc *desc, hte_ts_cb_t cb,
+		      hte_ts_sec_cb_t tcb, void *data);
+int devm_hte_request_ts_ns(struct device *dev, struct hte_ts_desc *desc,
+			   hte_ts_cb_t cb, hte_ts_sec_cb_t tcb, void *data);
+int of_hte_req_count(struct device *dev);
+int hte_enable_ts(struct hte_ts_desc *desc);
+int hte_disable_ts(struct hte_ts_desc *desc);
+int hte_get_clk_src_info(const struct hte_ts_desc *desc,
+			 struct hte_clk_info *ci);
+
+#else /* !CONFIG_HTE */
+static inline int devm_hte_register_chip(struct hte_chip *chip)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_push_ts_ns(const struct hte_chip *chip,
+				 u32 xlated_id,
+				 const struct hte_ts_data *data)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_init_line_attr(struct hte_ts_desc *desc, u32 line_id,
+				     unsigned long edge_flags,
+				     const char *name, void *data)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_ts_get(struct device *dev, struct hte_ts_desc *desc,
+			     int index)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_ts_put(struct hte_ts_desc *desc)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_request_ts_ns(struct hte_ts_desc *desc, hte_ts_cb_t cb,
+				    hte_ts_sec_cb_t tcb, void *data)
+{
+	return -ENOTSUPP;
+}
+
+static inline int devm_hte_request_ts_ns(struct device *dev,
+					 struct hte_ts_desc *desc,
+					 hte_ts_cb_t cb,
+					 hte_ts_sec_cb_t tcb,
+					 void *data)
+{
+	return -ENOTSUPP;
+}
+
+static inline int of_hte_req_count(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_enable_ts(struct hte_ts_desc *desc)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_disable_ts(struct hte_ts_desc *desc)
+{
+	return -ENOTSUPP;
+}
+
+static inline int hte_get_clk_src_info(const struct hte_ts_desc *desc,
+				       struct hte_clk_info *ci)
+{
+	return -ENOTSUPP;
+}
+#endif /* !CONFIG_HTE */
+
+#endif
-- 
2.17.1

