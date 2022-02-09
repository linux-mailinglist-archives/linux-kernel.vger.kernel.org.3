Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DB4AEC3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiBII11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiBII1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:27:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D3C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:27:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfLBW/6TgWRB7MugzkLCtWVN3P1G6DMmE7k6nCfnCvNGk3GK4MjWH+zBUnpUAeHAAILx0hWCHNkGFCcGd5q9ZPmGMkG5pjktAUVnBDt7/wEONdU88nQU2gJ4THIAn+cufQUkvSAxFw3xQX3vqV0JsqI2L1XEkCBjObMsmiDhI5gOTyJe34oO2nFSo1mBO54CGBeVy3tAjueYoHkYI3mO1R2Mv1hna/dZjJBQdEGNYPSmkij0E9LoRHG7qA99+OPm0xeFbcPuF+I7/Tnz7uYKpa/xv00R2ZnpR7pUy8k9zGv/xWCU8t1Iu7z4ae4Dxro6K9ufvfi65HERr6TkBpv17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjuchD44P/5PkxHuJbQ27b3bs9bb9qfdjlVHF227NLY=;
 b=i9g3WZ/svilc+TNQtEg9M3TzRvI7Psdp7FvoW3ZUiZb7Galpo3vdFaNHEmMmWe1/3gLdxN+dfTz0KN/ahrdmTUnskhtsYzqnIhz9uJORfR0U2htp/MZPgSk8CGVc1C42YafQsQpLZra9cIcenuxPS9naTy/ZrDMQr71TJL0DtUPkFBdCZRftKc7dLpU9kXmSi7XE7lWNA6/YRnKq82619JH0z9lnz799opgZflBiLqq64C5pb0XlPmL5xcEZRHh3ikMKOxcXvwDSJUSdSlt1MlsZwd1l86vTbMHXvGmCoV24vQsY5kMrKc9WzjO6AR+5WjaUbimnNCcTJ22Qcmo4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjuchD44P/5PkxHuJbQ27b3bs9bb9qfdjlVHF227NLY=;
 b=TR8Vy1tM0l1Bcnds58zLsWfoa8sDrkH4gcnTh2jLEASZsHGznsQlRlSPaKlY2Zj/u0AtkEb/5g0rJq+gOlrcVBHIasavZHI2FesL2VLdcngDLJP5H62CRs5x+zh8xeKKqeG+NCzptyZ2achTshIxeTxpYTpUf2VQz2DqLFP9N3I=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by SN1PR02MB3775.namprd02.prod.outlook.com (2603:10b6:802:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 08:27:16 +0000
Received: from BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::2b) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 08:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT023.mail.protection.outlook.com (10.13.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:27:15 +0000
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
        id 1nHiJk-0003T0-D9; Wed, 09 Feb 2022 00:27:12 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v5 1/3] firmware: xilinx: Add support for runtime features
Date:   Wed, 9 Feb 2022 00:27:07 -0800
Message-ID: <20220209082709.32378-2-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20220209082709.32378-1-ronak.jain@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab5c01f-d24e-44bf-8a33-08d9eba5faae
X-MS-TrafficTypeDiagnostic: SN1PR02MB3775:EE_
X-Microsoft-Antispam-PRVS: <SN1PR02MB3775F5CD8DE8A553838A252DA42E9@SN1PR02MB3775.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRL881/QA04n/W5TSQBUUmwN6877x7J7GOuctoTkDRwayoiioQdlYmXQ0GF6pGz8S5k3rSPQa/bEzkBaIn015D5MThzVAv1sK/xeiMa7uHFD9CVoGxbzGPjAUXjB2f4xU0fIc9tm576F2JzgzB8jPXx+vCJlBr9iNZ3NRIfTP00chkijcU+x/Dd+KWXFNb5yzNi9/4xMC0u9Zh8dbQOJwc4S2xTplqBDTQQVjURIAfcv/Uf2kLmE6HhZpA9BO/TDkY+x32vLWw5rkB7Y9q5dxv5wCmYjfuaP3cEFn1hoinhNTQATh8BLfbzvwqku9IBSa7tcFNrA1E8qxC2Wz89027Kqq/gBjC+HiAU4whsnCOZMegPUJDJxoDrk7gD2fviPnUeqN8PN5reKagz+FG1M9owB42pw5GLcXnGtrUpKRyk2Z98ioK7JCZQXPLXYnav7No2I0cdty+uirBSq1X3pUapYbZj2WZNy3IViEjF1Znd0GbOoioI44JFeH2RWM9v8H0PoVZfLF1nd4bR4IC+7aV4dQUJIse2Bx4NLnsiiqlGS802VeIOyb+/XD+EjCt0Rkesc2ppuXJf3j8MprR7GtgsvNlZkD+/W+1hv8rlmhxcnHSXm8LOBfu/u7Ft161ppXiMEjxJmWhpfyi5a6dY6l/EzVvn+OoNgqEhTe7oGfd/q2gPvHC6UnUJ5HhKZy5kJZWM1VJDeDCMH681IG1s2WA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(186003)(4326008)(70586007)(1076003)(6666004)(83380400001)(2616005)(7696005)(44832011)(9786002)(5660300002)(426003)(36756003)(8936002)(54906003)(2906002)(107886003)(8676002)(26005)(70206006)(7636003)(508600001)(110136005)(40460700003)(36860700001)(356005)(316002)(47076005)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:27:15.6103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5c01f-d24e-44bf-8a33-08d9eba5faae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3775
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime features by using an IOCTL call. The features
 can be enabled or disabled from the firmware as well as the features
 can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
 Similarly, the user can get the configured values of features by
 querying IOCTL_GET_FEATURE_CONFIG id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v5:
- Resolved merge conflicts

Changes in v4:
- Update commit message

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
index 450c5f6a1cbf..0fa6cae4969d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1156,6 +1156,33 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
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
index 907cb01890cf..cf557fbeb8c7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -143,6 +143,9 @@ enum pm_ioctl_id {
 	IOCTL_OSPI_MUX_SELECT = 21,
 	/* Register SGI to ATF */
 	IOCTL_REGISTER_SGI = 25,
+	/* Runtime feature configuration */
+	IOCTL_SET_FEATURE_CONFIG = 26,
+	IOCTL_GET_FEATURE_CONFIG = 27,
 };
 
 enum pm_query_id {
@@ -376,6 +379,14 @@ enum ospi_mux_select_type {
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
@@ -447,6 +458,8 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable);
 int zynqmp_pm_feature(const u32 api_id);
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -689,6 +702,18 @@ static inline int zynqmp_pm_feature(const u32 api_id)
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

