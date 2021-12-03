Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C404673D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbhLCJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:22:14 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:41139
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351316AbhLCJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUu166ijO0YdIV7Yvfsb2KgUfra0FB+VeKUZqvwWeinDHl3goaM+nczIcOnutOghwUhGsA8VQagzphqdMVRD5uhMNBQkelr9d1Y0cwMU+pnHOPoaqgKGABNNitUTYDDsNc6T+rVrsEkmgfJ2FQHFjwHCIVkaDzUe43xYF5kMDzUj43YPTVwyFzkywHPnHF0sqFk8TxrK7VRVOGtaRwcsdNVStYsNYj+MFSUSMIbSTM6Bk4WhEOWY9DaD7RO7eLwRweZTuMAjmVwgG+cSJNGfB+79s2SHouuFdWNhCZDdzcjhPWFID6pLje0PKaiDJ70YJM2XE+wjj2nHoYASppJTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqaYaWuEYFgX1UZvwZroKwFDmdV0FX5Nc1SK1bVci2Q=;
 b=UY56C0r+e7gJ4Kwuccf2lZw7qKSSfjlQMROKJsXtApEpg9E6i5vCq56bBv27SmDiiuBwa3L8aixrjyvGPdsNYmNEnNHMvdHFTu7hNwUvSpViv8l1KL+rBsJF09sfBP0N3ewMMeWt4qoQrTbWxIUIHNDQGIih6Qzmw8hUmV5uYpbj2cWMt3VbzHPFpqfURlkvFy7H9XTbrFpmW44/kGZDTHTQdd87XGqX+SR/14PGP7dnaeN2gnicLPANbz7I8KmxF0AIYUErsiuRFXlprQcQm9FLJ9lNQCrpVi3P7H77mBiLBI3lc1fiIBGPPMAozUqn9r0uN0IyGE8NTbVidxHJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqaYaWuEYFgX1UZvwZroKwFDmdV0FX5Nc1SK1bVci2Q=;
 b=d4otx6olUZ0dXJKizUKddAzr2VQYX+uZ6tHry5mTb2eff54F3PFg/nFb5M7IhPPrYVO7Yia6zRbUVjP9VXN1vuyK+cHQyPKIkxNAP+/qK6WhOiquzX0TrIFgRTHAIwRns2RCg81cfFKCIyecxAbAtVZg7usTK/vmaVK2zvLNaEc=
Received: from DM6PR14CA0045.namprd14.prod.outlook.com (2603:10b6:5:18f::22)
 by SA2PR02MB7546.namprd02.prod.outlook.com (2603:10b6:806:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 09:18:26 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::fd) by DM6PR14CA0045.outlook.office365.com
 (2603:10b6:5:18f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 09:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 09:18:25 +0000
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
        id 1mt4i1-0007wj-16; Fri, 03 Dec 2021 01:18:25 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v3 1/3] firmware: xilinx: Add support for runtime features
Date:   Fri, 3 Dec 2021 01:18:12 -0800
Message-ID: <20211203091814.15582-2-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211203091814.15582-1-ronak.jain@xilinx.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c00a73a7-99f8-42c9-8dfb-08d9b63ddc90
X-MS-TrafficTypeDiagnostic: SA2PR02MB7546:
X-Microsoft-Antispam-PRVS: <SA2PR02MB754608278C7D1C0B1F6FA475A46A9@SA2PR02MB7546.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GllEROfdEYNAGPbu/1VhP04vmPmyxf4BZcldts6HRVwVdylJCNpGgjXz4D9Uc9sylGeKW8Kn0qYkz8W9JjxpsNZuze95wetv107ZXMDq8KK5LkF0hE5TpfvGofPo2em7qiN/XDBkzzhlj2GlDSIfs9CuvbpC6hPZanRnPYRiraNOnjPVyaoyI0RsUukbM3ZPUeO0CJMvLLnWpET5Gi5nQ2bNrPtquY/3+1mS+89dp4fMGOZVZBoHn3QoJa3htss02HOWpjItgOAP4B1HOOWdBcOz0jQbjGiP346k5a7vFL+eD/fEC18v34/Hfmu486+I00aCRHt6xZ+hp0J3iwfZ/hxmJD9pqhHvSqhrqBISi7c4Qtz2QlhpplnlZOQskcMtkTIx4wN5NxGUeIBKzP1pTQrTQ9KUk0AE6RS3PIuSi3yOEItFVcN9w5EHLDIp5t2xYm1eqVZ+h9rgxHWjvELJE+fwf+K80dzufHO9/g5BNj8eEtCvENxbRpIfY0ZM8dZXBs0qHUeebRawILLCMiz63k45JPNAwtFS4m1j34Cl29aVb0165JhsmwKO55kvUCYL/Dg1LdhGAP+1rBxuNsEo0PDNR6ZElL3k8XVgExYBXPwNMbBHJ8MFT6Ab5WNWzRZ7FQ1++FSBZWUyuQXL4au9B2pd/SagOlWFTY+hg3osiNRtGUdByvqWlVylf/WEoJFveqV/vodGXJcEWfQXw3waoYu5Rk5KLmmYWFQ9MxNQVQM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(8676002)(26005)(107886003)(5660300002)(54906003)(2906002)(110136005)(44832011)(36860700001)(7636003)(2616005)(6666004)(7696005)(9786002)(8936002)(70206006)(82310400004)(316002)(426003)(47076005)(70586007)(336012)(356005)(1076003)(36756003)(508600001)(4326008)(186003)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:18:25.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00a73a7-99f8-42c9-8dfb-08d9b63ddc90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime features by using an IOCTL call. The features
 can be enabled or disabled on the firmware as well as the features
 can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
 Similarly, the user can get the configured values of features by
 querying IOCTL_GET_FEATURE_CONFIG id.

Here, the support is added for the over temperature and external
 watchdog features only.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v3:
- Resolved merged conflict

Changes in v2:
- Resolved merged conflict
- Update commit message
---
 drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 3dd45a7420dc..6b05844e67d7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1129,6 +1129,33 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 				   0, 0, NULL);
 }
 
+/**
+ * zynqmp_pm_set_feature_config - PM call to request IOCTL for feature config
+ * @id:         The config ID of the feature to be configured
+ * @value:      The config value of the feature to be configured
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
+				   id, value, NULL);
+}
+
+/**
+ * zynqmp_pm_get_feature_config - PM call to get value of configured feature
+ * @id:         The config id of the feature to be queried
+ * @payload:    Returned value array
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
+				 u32 *payload)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
+				   id, 0, payload);
+}
+
 /**
  * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
  * @subtype:	Shutdown subtype
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 47fd4e52a423..772f7d6ba682 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -126,6 +126,9 @@ enum pm_ioctl_id {
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
 	IOCTL_OSPI_MUX_SELECT = 21,
+	/* Runtime feature configuration */
+	IOCTL_SET_FEATURE_CONFIG = 26,
+	IOCTL_GET_FEATURE_CONFIG = 27,
 };
 
 enum pm_query_id {
@@ -359,6 +362,14 @@ enum ospi_mux_select_type {
 	PM_OSPI_MUX_SEL_LINEAR = 1,
 };
 
+enum pm_feature_config_id {
+	PM_FEATURE_INVALID = 0,
+	PM_FEATURE_OVERTEMP_STATUS = 1,
+	PM_FEATURE_OVERTEMP_VALUE = 2,
+	PM_FEATURE_EXTWDT_STATUS = 3,
+	PM_FEATURE_EXTWDT_VALUE = 4,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -427,6 +438,8 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value);
 int zynqmp_pm_load_pdi(const u32 src, const u64 address);
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -658,6 +671,18 @@ static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_set_feature_config(enum pm_feature_config_id id,
+					       u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
+					       u32 *payload)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.32.0.93.g670b81a

