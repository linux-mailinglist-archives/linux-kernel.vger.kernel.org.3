Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E94A4673D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbhLCJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:22:32 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:15073
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379506AbhLCJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9jfy0icU8tooxeCy98wftaCt/oB1lQmXm4R37pnrH1qCvlvmkTfKl3j/vDATHudQSo/G1PRChf+EYIO+bHRpSoP7WDxkau1NmqqBE6gMSmS6MTrX2kzKM1VfE5tGwvcTtXgcHDkxhocb87Btj+rezk/J9Mt7vQmN+lyaiaLqmBa2Mmrl2uSpsCXyRCoqf6xjUZCxNwzdI+OHkiXi02y7MtHEnLhaVzbVqcRCfABxOaTSDrls29/o83wPOJlzd2Gbh3+dlvDOKl16JawBkaMygrSxEJXaXaL682a9BGe1WFGjpeM4Tz3avkj/vKm2MeZNn2UzC4iaMVY5FBic27svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHSLDRo1JJ5Sr/2XsfofvF4NfHiOVbHpi2wbsIaa0g8=;
 b=ogDYU2rSyAIQdjr9MZ0mhOL7mEijRHOqEM4SDP1VujB3WRJ7IhL/k/aUILfvHYlWVLXZIkdL2Km1gDPrYkAIfhJlornPH9mBCykG8Idg1ai74NZlN0xRApnw/A7uFBxh23e3E9TnbVE003U7Cx+ciEUov1F8X76X55yUMFVq5skqAl67aEuY4mcnbY5sYOjrQKwI1UZHVPU2aBs7fqTHMqTpK2i0ZzI5Fz229kiNOSiI5X7OCBcXwrfQfFE2dkPWWjzEAc4jz2Z4hxFAVRBv3YnpRP69lZbb5sY+LUm7id0d5RzwF4GoUKpmf+WyMFW0fmUYN4Jqt0WXHhlpvrIqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHSLDRo1JJ5Sr/2XsfofvF4NfHiOVbHpi2wbsIaa0g8=;
 b=akMuDgwOzkjPm1VcMuN/J++OqVfQKFfYBuHYyxwsPM2skDtLvy/wQHqIK8w7dicFOfjYXWabkr/ONMZFnDX//Fem8gewYwPkhU1a9olo7Z4Q82/+DE1WqMsupZKiKrQn6aVQuK675wnDp3qh0MZzftWPVxGIrCd/rfSsMOCWD6M=
Received: from DM5PR13CA0062.namprd13.prod.outlook.com (2603:10b6:3:117::24)
 by DM8PR02MB8008.namprd02.prod.outlook.com (2603:10b6:8:19::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Fri, 3 Dec 2021 09:18:33 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::8e) by DM5PR13CA0062.outlook.office365.com
 (2603:10b6:3:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Fri, 3 Dec 2021 09:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 09:18:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 01:18:25 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 01:18:25 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=37656 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mt4i1-0007wj-3T; Fri, 03 Dec 2021 01:18:25 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v3 3/3] firmware: xilinx: Add sysfs support for feature config
Date:   Fri, 3 Dec 2021 01:18:14 -0800
Message-ID: <20211203091814.15582-4-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211203091814.15582-1-ronak.jain@xilinx.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81f55aa-0984-4a80-521e-08d9b63de0e4
X-MS-TrafficTypeDiagnostic: DM8PR02MB8008:
X-Microsoft-Antispam-PRVS: <DM8PR02MB800865234672E10DC175BA24A46A9@DM8PR02MB8008.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Op8Z5+hzT9CeSsX2Vru9xDqD/5kffjM1fmK0y3F9W8z1EnOhgZj5nF2SRn6FZDTn4O2f6LWMte7CFdPdnw0Gmb1HNY1ue8Nmx2cuwWfjN/Q74n3xXbYnyufcnB/X9XKsYHf/EByiPQ3nNzI0XQK9ffJBd4aGf0IbgS0s7/AG7SXgiUa5UL/tKOM4zcFY/9Y2ZrDeO9IOG9agg9liiHlPKwTzUEuEikl04JMZwBhndyoErD3p3YDgBENWLU509RS97qEUa0rK0CyqDRPYefilEfxFXMEIQO6eeDdUttWGQJp3oG6hn6wiY5/RuSkVAKQVUksyMR2X9Bx0WnET3r7z8ioJAV7M+cIL1vy1KSN8ocofuys+HV5lEOFN7h8a+7tE0aVAXqt0EhPXT9bA/tG0UZLDYoPf6SFGxwb9Tb8vTTJOg8+h9ZAN6vb9vlEuUuELXgi3DSc6rzj13nvWaI97l4CzJEEgYk38ffh2vTdqpsfa4j5Kx3lrfHMqNWAtMwY8XlzQsJbsydXaxL7XyK1HZ4Z9NkI33sjt68MfWmK5B87dyLGOMHwxn6M/YXJ0/deCsTsDXv9h1bKEmlokx9d2wIpp4/Rx76e9Ma8tsNYMRpbzh7Fhn0MPh8gyyK3o539535aRb2PHZBWGkuorBfk2KmvBbBj03Q0XuxTdZ9IKImPh3wb6mwtole7DE2WvEuA8NPMuIGDYHZETLllzVs/zXqlNH5McL8SOc/BMv7hwTmY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(316002)(110136005)(44832011)(26005)(54906003)(83380400001)(36860700001)(2906002)(107886003)(9786002)(4326008)(7696005)(508600001)(8936002)(6666004)(1076003)(36756003)(70206006)(82310400004)(2616005)(70586007)(336012)(47076005)(5660300002)(7636003)(426003)(8676002)(356005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:18:33.1018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f55aa-0984-4a80-521e-08d9b63de0e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sysfs interface for runtime features configuration.
 The user can configure the features at runtime. First the user need
 to select the config id of the supported features and then the user
 can configure the parameters of the feature based on the config id.
 So far the support is added for the over temperature and external
 watchdog features.

Added zynqmp_devinfo structure to handle muliple driver instances
 when accessed by multiple devices.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v3:
- Added zynqmp_devinfo structure to store device instances
- Modified feature_conf_id from atomic variable to u32
- Update commit message
- Resolved merge conflicts

Changes in v2:
- Update commit message
---
 drivers/firmware/xilinx/zynqmp.c | 93 ++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 6b05844e67d7..f37a8e805cd7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -38,6 +38,16 @@
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 
+/**
+ * struct zynqmp_devinfo - Structure for Zynqmp device instance
+ * @dev:		Device Pointer
+ * @feature_conf_id:	Feature conf id
+ */
+struct zynqmp_devinfo {
+	struct device *dev;
+	u32 feature_conf_id;
+};
+
 /**
  * struct pm_api_feature_data - PM API Feature data
  * @pm_api_id:		PM API Id, used as key to index into hashmap
@@ -1424,6 +1434,78 @@ static DEVICE_ATTR_RW(pggs1);
 static DEVICE_ATTR_RW(pggs2);
 static DEVICE_ATTR_RW(pggs3);
 
+static ssize_t feature_config_id_show(struct device *device,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
+
+	return sysfs_emit(buf, "%d\n", devinfo->feature_conf_id);
+}
+
+static ssize_t feature_config_id_store(struct device *device,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	u32 config_id;
+	int ret;
+	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &config_id);
+	if (ret)
+		return ret;
+
+	devinfo->feature_conf_id = config_id;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_id);
+
+static ssize_t feature_config_value_show(struct device *device,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
+
+	ret = zynqmp_pm_get_feature_config(devinfo->feature_conf_id,
+					   ret_payload);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", ret_payload[1]);
+}
+
+static ssize_t feature_config_value_store(struct device *device,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	u32 value;
+	int ret;
+	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_feature_config(devinfo->feature_conf_id,
+					   value);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_value);
+
 static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_ggs0.attr,
 	&dev_attr_ggs1.attr,
@@ -1435,6 +1517,8 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_pggs3.attr,
 	&dev_attr_shutdown_scope.attr,
 	&dev_attr_health_status.attr,
+	&dev_attr_feature_config_id.attr,
+	&dev_attr_feature_config_value.attr,
 	NULL,
 };
 
@@ -1444,6 +1528,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
+	struct zynqmp_devinfo *devinfo;
 	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
@@ -1460,6 +1545,14 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
+	if (!devinfo)
+		return -ENOMEM;
+
+	devinfo->dev = dev;
+
+	platform_set_drvdata(pdev, devinfo);
+
 	/* Check PM API version number */
 	zynqmp_pm_get_api_version(&pm_api_version);
 	if (pm_api_version < ZYNQMP_PM_VERSION) {
-- 
2.32.0.93.g670b81a

