Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14AD4AEC41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiBII2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiBII1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:27:51 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92648C05CBB9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aozV1DZodN49KUQQTG3sDYu68PWERUBxZf03oI0zT6hpPL4TeQDY32RyCMB6pKMvWKp5T8yy5W2AtFfmOMFdUWDKw7yBhSydJVBnZLsHwWTRX+iz9jr2GFPhObpG4n33gho11ov04P8QS7q/5Z6IUEJePUa3gp+sR8Do3UEnqvL/LecPkP/3K/54HDMd1W/2YEVrZTShm3HI7fqIcDtbtaNCG3XbAE0Qjo3/Ib7t6T1YNjKy93PBDyy+EIQR3ags8NZleehEa5hYIeayVDhMDCuAwUURO/YaPKKM7oyidpw08irPk6vr5j6qb2TrPoL65S+IS7W+865C+nWaou4g6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hEHYpCeIzyIxsQ3kFeZpjVqPsBV5OhXACBcFZTt08M=;
 b=VhCqMavgkQUb4DQe5dE8znKUR/06lqPBhsCLEPjB84Wye4gRmJNjiwvFnFzdEjd6R2XfjeP/JVrm5ZXb5RaU6WRk3EO+OZmDVIWqb7kFmGgrV/bRGNw13bu+6OinTe8XrR8ToHL1kwNsx1Hc+V9h9yHLxVEXpwzWeG8rbaSBpbKvempP+v9bCjJH/O6aD5s3UQJ6Bz/tSdvDF+fHKYgtkSZZKJymUlj5kcv2qa1QXGetAGKUShGdv54eIJpyXjO9doZzoo/gsJbVYgDm+MAD1doCLP1Ba8VnHu4wIC0fh5M59In5PcaWhm4XHWFIVvqBnu8zQ24nZAYJZ59zrquKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hEHYpCeIzyIxsQ3kFeZpjVqPsBV5OhXACBcFZTt08M=;
 b=bLz+HZazjCZ6Ta0i6dybDoSp0GjYepoLkLYuN6QDLNtseaoyp2uqMIkVcutAmvfFFA/2AcazmBATho/OvUwRvxnuDauc8VpQyljmsoRiEdqQxx0xW8tS0NEa+4Skweij/eDuCoara9IYBFM0IvZKu/P87cwVt1U0UY4SYnhJ8Ok=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by DM8PR02MB7973.namprd02.prod.outlook.com (2603:10b6:8:12::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 08:27:36 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::b) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 08:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:27:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 00:27:12 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 00:27:12 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=40310 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nHiJk-0003T0-Ey; Wed, 09 Feb 2022 00:27:12 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v5 3/3] firmware: xilinx: Add sysfs support for feature config
Date:   Wed, 9 Feb 2022 00:27:09 -0800
Message-ID: <20220209082709.32378-4-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20220209082709.32378-1-ronak.jain@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf61540a-463e-469e-0b69-08d9eba606e2
X-MS-TrafficTypeDiagnostic: DM8PR02MB7973:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB7973BD9EFE6EB28782873CAAA42E9@DM8PR02MB7973.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX+fgG3WV7Ton9fDavsoJ+yXJueGOxDf4bZ2XztD5T+G5Znwf8Db74MkGVRrHiWovqZ6nK5rXm7bp+Kui+AXhK5lLzphE4hqiU6yIPh8If+PucaCYAI5YWBiwEngFHTENDOxZEIPsp+cXypBDIJAPaHjQBDrsI9V8AgK9sOEKO9kiiZ0NFvNjHWOP42TUt44jfEaJAvgNgu3qX9jbcE8C6iehm8UbapfRSCMNOTOqEqzS2bxaNid0sKUrUFo0J3NAasn51xBjbVN0ngIG66pJJBwetKDWcaKlJcBi2t+jxXfEcNPVI8K7BaDE8pSUl/F4cmbyerwQvCIGLAJt4A9bDr4j7n6ZQA9b7Qhvcmxv8mFRvgsJkQRS8/caUU0nlxz/MEtLSgbzvWTJoD8si1czAUbkwIB9kCUFrV36IybyGvC/5F188gX67/tBMaq0StM6ogqPWea7uqhxDrMBS2fTydR7/ax6ZtoDGyj3e9k8wIBsSrtCk363MIwBAnskeey7zKm4YVquGHEvVxRNSFcXInmxvZKitBoTN3a3SlclAU0TdUM8EXHRxu9Kl0RS485n6ms51s2ckMzQGe4yI1WV5UQxBwQ76hUq9iyB2KDXCIrKZ0bBdrdfNxcXQ0BAHiiuxvz6lO6W9UvIHd3TZ1fifGIiByGmxW4jyrUVsd3pmfN4IwVXKgj3D8C6FApDsYvCpmuuEdvt4NcFLXcGEtTxQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(426003)(70586007)(6666004)(7696005)(336012)(9786002)(8936002)(83380400001)(4326008)(8676002)(47076005)(316002)(70206006)(26005)(7636003)(54906003)(110136005)(356005)(82310400004)(36756003)(186003)(2616005)(44832011)(107886003)(508600001)(1076003)(5660300002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:27:36.0649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf61540a-463e-469e-0b69-08d9eba606e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7973
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sysfs interface for runtime features configuration.
 The user can configure the features at runtime. First, the user need
 to select the config id of the supported features and then the user
 can configure the parameters of the feature based on the config id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v5:
- None

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
index 0fa6cae4969d..7d8cb2ec6f8e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -41,6 +41,16 @@ static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 
 static struct platform_device *em_dev;
 
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
@@ -1451,6 +1461,78 @@ static DEVICE_ATTR_RW(pggs1);
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
@@ -1462,6 +1544,8 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_pggs3.attr,
 	&dev_attr_shutdown_scope.attr,
 	&dev_attr_health_status.attr,
+	&dev_attr_feature_config_id.attr,
+	&dev_attr_feature_config_value.attr,
 	NULL,
 };
 
@@ -1471,6 +1555,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
+	struct zynqmp_devinfo *devinfo;
 	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
@@ -1487,6 +1572,14 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
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
 	ret = zynqmp_pm_get_api_version(&pm_api_version);
 	if (ret)
-- 
2.32.0.93.g670b81a

