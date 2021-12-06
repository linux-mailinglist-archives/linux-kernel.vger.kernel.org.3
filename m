Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED64694EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhLFLYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:24:52 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:46144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242318AbhLFLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVu/rqnwfyH5CCP9Dr/qUS5dq9FoIH0G6UV2bLUfHAUn3LJqCc8gPburInaQIZqvTSi2gpkQy7iVBqA8VeoyiEhoU4GWR6f2GGVvaDvKaJYYPW9Tv/4nIf+BpiHAFhEwnW3ZZUxMRW7iv4ydWhmKfj3g0LfJcYlTwocXfr+YAAckIhIO5veLyZnSDOONIrkp2Ejqu14sUw4iSns/Jg8SuHVlBp0NSGTNSzAFGPoPNKtJX993bgQgaRitBqgOaBHUFDD2KyQfhcAdanLpa+ArAq5IXzzddCEw7UgctsYDnIJBX0cPSruo2ufwGnzM7F2iAfGJifqEHCrGEobzofx7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y4+jdZX9PlyDsBohYKp3zGFLIp8wu0WHrhqGZKTfg8=;
 b=a2HDFyzZ+90FzHBQcF8W4ITuWEsgk1/ogH6PQeSNEqhHeZvSRKAZZ6BXY4xZ9HXIvxlNZ6zd8AkdGCsIIrSGf4I+I3wLMW4fdwLLy4uFwDeK1Bw0uhDanPIibL1hxsQ3AvYIGNieuQ9P4mjTUH9gDpdgQkPBaKzEqyR8m6FPRAD03Fo3nbHoC0HNaxOfgvUF1hwTgJkMXH9Wv/WRXfkESBLJesOWhxWoYNBXHDM0Ohdlav9Eb2QzZwIOBYOvXFcHu8ZIjwzxHSbPTafQLyT/xTWO/wpB6A5cZ86PZAnMmpi7vG5N8t8n5THVlt9R5G2j5hMi8lcNaN+mWe3/oVRgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y4+jdZX9PlyDsBohYKp3zGFLIp8wu0WHrhqGZKTfg8=;
 b=gTQc3MYRIOUPKSAeT8S9mGF5FbTGF4MLh6XhEqYIPpDmwa0GOKQKdrPZz5mZsvow/M7OvXsNvVN0CheZesE2VNZ6T7NqVuzw3GKky6RXH0rTzBPlDktXzstDXn4lGDaJt0Em9fSjgpEQc/AS3b8xzqDj0q3vnnlFnyKke6cVLYg=
Received: from SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) by DM5PR02MB2266.namprd02.prod.outlook.com
 (2603:10b6:3:4e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 6 Dec
 2021 11:21:15 +0000
Received: from SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::95) by SN4PR0401CA0023.outlook.office365.com
 (2603:10b6:803:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Mon, 6 Dec 2021 11:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0019.mail.protection.outlook.com (10.97.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:21:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Dec 2021 03:21:13 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Dec 2021 03:21:13 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=40272 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1muC3V-00050V-KK; Mon, 06 Dec 2021 03:21:13 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v4 3/3] firmware: xilinx: Add sysfs support for feature config
Date:   Mon, 6 Dec 2021 03:21:01 -0800
Message-ID: <20211206112101.24955-4-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211206112101.24955-1-ronak.jain@xilinx.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb75ba0f-92df-403c-1529-08d9b8aa843c
X-MS-TrafficTypeDiagnostic: DM5PR02MB2266:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB22665067B05A788DE3EE5973A46D9@DM5PR02MB2266.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0m3QYc0LEWj1IxCbbGUGMWA7dBxM1jCUTEnPn7mSARGRVCLJspUdYbAlFNoqS/DRszIdfY7hFDhU7WrHSJJG6qTrOdbIU3N5Z6U7fiCy7F0w6X+Yjoid54KDLycT+7FTyZpXMM5Lk4wC/GatOb+a7tv9+5oFiL0JieKvN91Ew9AnzK7bUrfSu11B2xbR+Z8fa/1WYMSEtvaEKNVtUTg5JcbaAwDmSo7TtrqY8psM968/zNZ2Huwvy81DrvEF6BA9wkoO2BO9It/sz93ON2OuH53OreWhYN3+HEE5SA69Ika6auNlEYT1h1lpyh6OaG4afJAaqTu95lMcrq7v7yKY0iv03NW1IofSJCVOWHpfKAW9qjLnfLq0YuZU0+blexUr7KxHjciJ0208RQSrvIIPL/d8udtcob+eMMLSP+YdWzgXrdDND98IDf4BJ+I/1Uz8cVwSa34t20xLbaRED7fKNHVYcA8ZgbL6T5+WY6fJxe6Ir+jV9RIL4BK0nl0HQMmgssXiwAiYlZz0WNus/wYWfZcAu5hnum83s5mctJ8FGIRxk3ZGexFaNFsnVWY6WL462QVPsqycXx06DwImXUDVXkEB95QJqjEGqG9GSyMN/dGhT4gwDMstxdxnSb/3y2ce+Xra+wdKp7plDhth/Ci0LG/ciXlxOijHCxGZ8ocJAJfZnsKyMP7Jz2oqE0YdIJlHR4/8pv2HXwHyD1S96BShP53WRnuYy9hfVCjN19dRbE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(7696005)(336012)(110136005)(9786002)(5660300002)(36860700001)(44832011)(47076005)(4326008)(36756003)(107886003)(83380400001)(54906003)(1076003)(356005)(6666004)(186003)(7636003)(82310400004)(426003)(2906002)(508600001)(70206006)(316002)(70586007)(26005)(2616005)(8676002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:21:15.1023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb75ba0f-92df-403c-1529-08d9b8aa843c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2266
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sysfs interface for runtime features configuration.
 The user can configure the features at runtime. First, the user need
 to select the config id of the supported features and then the user
 can configure the parameters of the feature based on the config id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v4:
- Update commit message

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
index 6b05844e67d7..f78711f09338 100644
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

