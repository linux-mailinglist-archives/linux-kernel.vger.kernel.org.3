Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C466B4694EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbhLFLYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:24:49 -0500
Received: from mail-mw2nam08on2042.outbound.protection.outlook.com ([40.107.101.42]:63200
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241969AbhLFLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rebhs/QBTuOigumsTBu6Lr66IE00ukgfZAJcus7kBq1tRPC8wJ2NNL16ATo9SWSfkop7LRg2ZbcPWD9UxDdoVeM/PbFsNbwTwTTgH0cL1fyCMpKFQAePNJgI8R7wUZrp2W2C3OciOBDFtFJ0jhoiQG2qOQHlfsaOSNYi1bAqho3yzk/v2BevzIj5BP6aQiHr53SLoC3mgF1msZbsf9vAAUUZXklBGwY/bMuebHT7uC30++4NUmICl95ap9DvTDCmhqN1EkSkUCbcbE4EW88zjq0LnqWozIr4txkMrX/DzGHUPTddwDGNvUE9cWYI7TXZZootTzfnHWz7Zef9ZjZE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDGMIdqIc7EnVyJL268D+/EW57SVwFrXHsVM8L119gU=;
 b=lC8tbFYBjInX6LRTPJEWqKDrqSWKcKhwgKDl6iZcyViatHZDzZWbr7jfNKtAeTgTqmC8FV7F8n9dtacfGt9YAAfb9VJsZXuW0i8tJ6b+nT/OLnqpPo88jg8G2pUHEp26D+hZBvQIZgHHIwCtwtP3uh5Vy3Buqch636OhV6etbRwx3tdL48VAQwVZbM3kQB+FtPbAYhbWKGGHNKGbNNK4gfaZNE6Numf9MITPZhUEH//V0Xc66uuy5rorHbWlCF7djnrznSvDJ5wKsC9p01W9YmOn50We6twbUyYlGSRlybgBS+WQOiPXq5gBaID7gL1tHDXAf8fo6qAm08JwNZg7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDGMIdqIc7EnVyJL268D+/EW57SVwFrXHsVM8L119gU=;
 b=gAJEe/iROqZYrmIKRG3TeBTITvNbDK6/C0pKuurMS12P++R816cKghvY/y6N34vg03UgBOCYPohx1rqneA/3ml5wvnVJqilQT3HFVQ0Df5z6TP/phZIQOHH4+Dy6cfsJ9x98mOk8x/iMpF8uuKVzP2VZLqFctoT/fmdtlXIxCKE=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by DM6PR02MB4076.namprd02.prod.outlook.com (2603:10b6:5:9d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Mon, 6 Dec
 2021 11:21:15 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ea) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Mon, 6 Dec 2021 11:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:21:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1muC3V-00050V-IP; Mon, 06 Dec 2021 03:21:13 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v4 1/3] firmware: xilinx: Add support for runtime features
Date:   Mon, 6 Dec 2021 03:20:59 -0800
Message-ID: <20211206112101.24955-2-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211206112101.24955-1-ronak.jain@xilinx.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102552ce-59e2-44bc-49d5-08d9b8aa8412
X-MS-TrafficTypeDiagnostic: DM6PR02MB4076:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4076C9CE07CBA10FFD7E1705A46D9@DM6PR02MB4076.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Va2JGEtlcVPQZQwhU0+GKDd+I/SjOTqTddOxtG6tYsENfawMagP39Le5nbkIaBACqDFkP6En+jSMlqERCBPU0Y7NG9vp/5NnKQZ7rqQ2Cv8m6v9UhfiRwCKJ3SUEm7RJ/0bUBoAsMgcEs65V8uQ/RN03eiqKOwISlW1CPkr95HV8UanvN+JbjGoAMa+Utr8Atm4y8SUIxlDq6sTXK3m3UITjHQXsLLuWscLGYukiL6ooaQvDh/qOH51fChE1DqMEHkiDiv74r/50RTOfzrOR5C1aQaHT0KTvRSYjxHeXPmmFg/FZ09y91hfU7k7DeznAgaXyWoChbzQtLvNLiDl7jXz0tMBq79lh69zzmeJUhgN8c7LcgmQGi3l1Xt3FGrJ7QAKshJFvrIuRpp7FOwdoo6UMf4aQ4JqArGjpcep+YG1pNodLDZUe+6hwR+SyAYaa82p50QNy+DDl625GJRHPbTGb44lqJcGEjM9WV6yjN15kIG0VI3/gMmDYSJN+DVe36MHT6plHC9Uyift5rgE/b3jNoEZbkNWSORfmHe6rjt2uAlTiq/jOMKdm/Hf8sSDt9x5m5L1KkrZilV9OK/jbeqPzJzJJT+IZkTmlNKDZVMf4OvEO/ZPBpn/51OXc0VuCRt7UBV18e8GB6MHmIXTmFQEZh7MHneMWRHb+sk9lAEYwt3fhKAiN9IqmPjAV8WgjZjYfxxsKAfUrCgB5AJyH90XKzzAjMWubciyTYxy2wfA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(186003)(26005)(54906003)(6666004)(70586007)(36860700001)(47076005)(110136005)(8676002)(82310400004)(1076003)(2906002)(70206006)(83380400001)(8936002)(316002)(356005)(508600001)(7696005)(426003)(7636003)(36756003)(2616005)(5660300002)(4326008)(9786002)(336012)(107886003)(44832011)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:21:14.7971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102552ce-59e2-44bc-49d5-08d9b8aa8412
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4076
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

