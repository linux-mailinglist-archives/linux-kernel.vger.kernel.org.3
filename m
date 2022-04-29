Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CB51466E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357288AbiD2KUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbiD2KUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:20:17 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C37C667E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/M7jzL3rW2tROLpSs8SRL967eAfUgAlc/jNoq3dYnKXG6LM3j5Dyyt7Vo7V8UA6fYnwy3GC5hKsQzDEgvbkMxbFAmKDLvczaIxsCyrqx0RbdxhONY50Pb7rX4DAyQPyG8C6QtEL96VzLZU/NvFMEEy0x8k103YliWqlZP1KjPBYGeIFySpYRrJS0X6tlRVZTN1235IbZ0egCvUYsyMleLvTzGxMka1WupI2PrvsxsjAmL+Z45sT9xdLuUhBnLbEqEM2FftuJHgZ37oZXMFeMMwvHiBMwPw8ja9Mu3SJCVJI1f7R9/xap32LQLelIIltJazstD3iVg7PyNJ6w493TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak33UqpAZuouqnr/mOurX0fo44zDWvZg5BQ5QkIsaB0=;
 b=KpX84YwIb/UB55dsfAvEg6lJDcdyf1pNfL7UKJfJUVvgYnAIsjYYs9yNIPnQGv0NgjjDtI4/3D0vqaSGgUTS5JkffYkN67Q3sqm4gYX7ceEQoX1kvFlCfOOUCQOuNR20fOMN0Q/vrk+PfBA2b50XQcWwaYw080mbSlOksqFg1KkpN+Phvn30eGff4GWIm+Rom8wLSttoSkkOoa2LQcLN3KSDjc4steZk5ECZER2A2lU9gv1cAxB25WuomWDEwC1TcMlTQ+pfpTAs4iLNKFJvQPdSRQ8OBMjzjZYTSz6gWid3hHwQjZToNQ6plaLsX+p1KScZWYfOu/Lbsr5J1LBcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak33UqpAZuouqnr/mOurX0fo44zDWvZg5BQ5QkIsaB0=;
 b=Y9XQA2QIcDzI0Y3VE04b4U6dELRAOj7dhq/1bBbHeRGqhepPyQl89qYID/JMKS2QHyTCih6zzTv8UpS6JkvOm9ipn1+b/ScBfYf+mWmIoi9q6BC4Xt90Z429DJeC6uOQ+uHDI3jrqQ2HTP3ldZnnaDv+JqUhni/RQjf9/kes3/0=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by BL0PR02MB4548.namprd02.prod.outlook.com (2603:10b6:208:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Fri, 29 Apr
 2022 10:16:55 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::f) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 10:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 10:16:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 03:16:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 03:16:53 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.243] (port=60302 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nkNgD-0005I4-LY; Fri, 29 Apr 2022 03:16:53 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        <agodhasa@xilinx.com>, Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH] firmware: xilinx: add support for sd/usb/gem config
Date:   Fri, 29 Apr 2022 03:16:42 -0700
Message-ID: <1651227402-17658-1-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62fdabe-0b56-46be-0579-08da29c962f0
X-MS-TrafficTypeDiagnostic: BL0PR02MB4548:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB45481DCF2813EEF6F2211365A4FC9@BL0PR02MB4548.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTiX/HRclnTzmWnFhidV3JuXPmd91xiXQIJgU0JpqqaoVysHM8HCqEce2MBTU2DIZWkcLKeU01FTqV/lIXoteAb1LxKDbs/AXB5uxdBfIXjSh/sWeeNKXfYQu+xtnWGSVTnbJtPwhwxChmrPNOU5iOi6vANyxf7AnSx44zWBWHbyvMnIon6eVzBJE+E73+gccis3QK+7fDp0E1ktdeavgR2IBI4hlW55/zHd7sWh3/GUSwomoYxeiBpQDwMEVNt+UxYp9utVkUcCv87iHK+HDWG5bintQKW9QQthxKiE81cwkmkqSmkUj06Sk/s91bnw/iOg71peieopoq2ttLYFdGfeqg18phQIFZpjqwKkFQMqaUeOZGBNYZj9zT/sdHjhm1+0BoSytLwjxZC7Y5wpXA/VP8ERFi4krfJlCUCIcDCeetxaUkl7TrbjrqKMinpo0rGOvla+c/849VF3SAeEhRMKJ7j2OMyQts0PoHl7RXAYDkZ6rPrOB2HUBtDPXYNjtE2JMt7HcIlr1SOVqcB2SOiXfXD2HA5xTuMsXuhdZKBfg3U7HV6zzBpIeQYRn+Nb4qylrd2+3HuwbMFuYQeh5wTcpSoSqD2KlubSuXwscu6DCQx145fSn6RE8jgAzSUv/QClv+0kyftSaejiALl8nILvkmBeyDjco9Zx4varE7wrUuGYf4l8lmZof334DfCn/iMTFz1xDdhO/CPsxLi8Tg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(336012)(356005)(40460700003)(5660300002)(82310400005)(7636003)(6666004)(7696005)(316002)(26005)(110136005)(186003)(54906003)(508600001)(426003)(44832011)(8936002)(9786002)(2906002)(47076005)(2616005)(107886003)(70586007)(4326008)(8676002)(70206006)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 10:16:55.0159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62fdabe-0b56-46be-0579-08da29c962f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4548
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new APIs in firmware to configure SD/GEM/USB registers. Internally
it calls PM IOCTL for below SD/GEM/USB register configuration:
- SD/EMMC select
- SD slot type
- SD base clock
- SD 8 bit support
- GEM SGMII Mode
- SD fixed config
- GEM fixed config
- USB fixed config

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 47 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f21ece56695e..f8a46aad9392 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1220,6 +1220,53 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 }
 
 /**
+ * zynqmp_pm_set_sd_config - PM call to set value of SD config registers
+ * @node:	SD node ID
+ * @config:	The config type of SD registers
+ * @value:	Value to be set
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
+				   config, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
+
+/**
+ * zynqmp_pm_set_gem_config - PM call to set value of GEM config registers
+ * @node:	GEM node ID
+ * @config:	The config type of GEM registers
+ * @value:	Value to be set
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
+			     u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
+				   config, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_gem_config);
+
+/**
+ * zynqmp_pm_set_usb_config - PM call to set value of USB config registers
+ * @node:	USB node ID
+ * @config:	The config type of USB registers
+ * @value:	Value to be set
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_usb_config(u32 node, enum pm_usb_config_type config,
+			     u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_USB_CONFIG,
+				   config, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_usb_config);
+
+/**
  * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
  * @subtype:	Shutdown subtype
  * @name:	Matching string for scope argument
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..71188af75f1a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -147,6 +147,10 @@ enum pm_ioctl_id {
 	/* Runtime feature configuration */
 	IOCTL_SET_FEATURE_CONFIG = 26,
 	IOCTL_GET_FEATURE_CONFIG = 27,
+	/* Dynamic SD/GEM/USB configuration */
+	IOCTL_SET_SD_CONFIG = 30,
+	IOCTL_SET_GEM_CONFIG = 31,
+	IOCTL_SET_USB_CONFIG = 32,
 };
 
 enum pm_query_id {
@@ -388,6 +392,22 @@ enum pm_feature_config_id {
 	PM_FEATURE_EXTWDT_VALUE = 4,
 };
 
+enum pm_sd_config_type {
+	SD_CONFIG_EMMC_SEL = 1, /* To set SD_EMMC_SEL in CTRL_REG_SD and SD_SLOTTYPE */
+	SD_CONFIG_BASECLK = 2, /* To set SD_BASECLK in SD_CONFIG_REG1 */
+	SD_CONFIG_8BIT = 3, /* To set SD_8BIT in SD_CONFIG_REG2 */
+	SD_CONFIG_FIXED = 4, /* To set fixed config registers */
+};
+
+enum pm_gem_config_type {
+	GEM_CONFIG_SGMII_MODE = 1, /* To set GEM_SGMII_MODE in GEM_CLK_CTRL register */
+	GEM_CONFIG_FIXED = 2, /* To set fixed config registers */
+};
+
+enum pm_usb_config_type {
+	USB_CONFIG_FIXED = 1, /* To set fixed config registers */
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -462,6 +482,11 @@ int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
+int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
+			     u32 value);
+int zynqmp_pm_set_usb_config(u32 node, enum pm_usb_config_type config,
+			     u32 value);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -722,6 +747,27 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_set_sd_config(u32 node,
+					  enum pm_sd_config_type config,
+					  u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_gem_config(u32 node,
+					   enum pm_gem_config_type config,
+					   u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_usb_config(u32 node,
+					   enum pm_usb_config_type config,
+					   u32 value)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

