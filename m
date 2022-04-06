Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3354F6088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiDFNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDFNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:45:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E02F3D3A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/+yO1RUMjJNCZMLWeV1nHL1K/rRA2VdVT78WhJJsNZqAf1M82aHY9GK28mTSSAJJ9fxrEdvdaYgEPR2kE7jLmZYtSAbRKBzTwokITHTUCN9mPuVqlIocalwZFngs4u6U21C6nb/4A3gs7a3Yi5q7wl46xHhtNj1EYUPPiVH3Rw7ECtqVc2mumJJQITLvNe9aL9CK/4LBxkqOjVOy9AQYVLmOkvOWcvwxu3Xd88oECZgeeNNa/cbCrY47UUS9fLtjAKafWcByL6rD2VTpXXxXr1AIdLE9Je3i7UDGzbb9KmFtmCFvxomsON6xlQ+AHEz6I8TWMYqvQ23EATcLefh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO+jUIaGvM5ZJK+HD/Jm6o7kbY8rMhX74xWFDbh+/pM=;
 b=gFB0csABya8HBFeG2F+ObM+Z1JoNNJFcvNfOcGFzq1pxrXCxaKDrtQLBnHNOTvtZ0UPe47BqyvqYw+WfiovhyoH6XXS6E1b8xiPYexpHSElSpnmu7+4y1NOMgn0Qf+ZGUImWwVrCToU3r6b53jxDHeho/WHI1BaG/SUKtLHXE/w5W6yDchb9RH7Stk0N+erGRIhrcbuGqXX+llfUYC6VyH764/8l3EQCeGUtbCqTyAL1RViaCktN27zKE6StCc8Am3esGILSdpJZ2ffYq/VCcHwBxwTY+3E9Elvz0qmBU3NZ5w27Sef3K6zuTIOL0jM/U1bn5+0igxBf3QA3qYT2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO+jUIaGvM5ZJK+HD/Jm6o7kbY8rMhX74xWFDbh+/pM=;
 b=szJieitmDNl8dAFz+c7qPD+f+bBsEcDkQNURDnxYWC7rypvV+ViO2FYfgmW9HEQujHf3Iqs0UGjCJyJQ3J6PqnRsrOoz24cx2VFu7O76c/A7NRZxbiXvewYvVbZKfxNFGm+aLzNZWguA4FRE8P9l7Vz/hX+sq5zR1h5ar7WRTx0=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by SN4PR0201MB3438.namprd02.prod.outlook.com (2603:10b6:803:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:37 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::5d) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 10:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Wed, 6 Apr 2022 10:55:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Apr 2022 03:55:33 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Apr 2022 03:55:33 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.243] (port=36060 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nc3K1-0007fI-Fy; Wed, 06 Apr 2022 03:55:33 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 1/4] firmware: xilinx: add support for IOCTL and QUERY ID feature check
Date:   Wed, 6 Apr 2022 03:55:23 -0700
Message-ID: <1649242526-17493-2-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79b984c1-245c-499b-fde0-08da17bbfb9f
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3438:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3438925D76E13933886E3CE2A4E79@SN4PR0201MB3438.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsopqFQ5aNaPie63WnQuJXKjIUKAz45AdY9jC2FkR7S/LXNI3w+I6EZ+6a8+wN8K0KnEeB8JLCeZEOVQUi7/9BcQgFU+QDZBwL7Ttke+NLJW4YGkYzK5LoLsxPglq3LsF0RnpmcPsRkRMSy5HeYrUFKceWX8T8qWUGlsimUV6tkkJ4xB3xVrCB0234s5315TWyGH27ZyvQst4gPziS2+AFqpmdoXyy6DH885ESffXi6g2Z3YewSzXhkkvfF3MSCyO/dHTVfGn26J3IcyYJaq/SsZMcHg0b5tv7dcIoA4fl7kTlw+W5WFspXk0GoiZii4++Mbwpx3gSKA5YVeRu4wzD+Uwy7GhZtqt0DrtwmqDkcNQRW4ivW6L76ET/LvGANxzV0bl+6vtVEz2PVRhWCdsC70fN7CSOMK6vybdG5ROcv9MgHZcLXnupdvfQTjRwkOi856EZ7G1q3TENzslaJWEWSMH+emvM1fQEKETjzmMc5spZj4Ztm3zuH+2b5v5JHMpkSmYTwMKYPzPns5D1ICCHracbEVkIPb8tef0JaTOlk7RG39M/R1rxbyxEw/UhOHaIBqWDYlteoFEZg43eSSOh08JzkJsowgIwCfuwrlPfYwAusbx1MMeZc1rPBBgDVbzQTyu8mDXLqrdaG6jLplx6oFweGtv5Taabo9RYP0kxrfxKsAj0v01NXhdvxu7TcvPxTGkK1yTo1jZGKKwRd6kg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7636003)(107886003)(508600001)(6666004)(110136005)(44832011)(316002)(2616005)(5660300002)(336012)(83380400001)(426003)(54906003)(26005)(40460700003)(36756003)(82310400005)(7696005)(8676002)(2906002)(4326008)(70586007)(36860700001)(47076005)(356005)(70206006)(8936002)(186003)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 10:55:37.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b984c1-245c-499b-fde0-08da17bbfb9f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to check if IOCTL ID or QUERY ID is supported in firmware
or not.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 62 +++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h | 11 +++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f21ece56695e..41ca41697790 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -36,8 +36,16 @@
 /* BOOT_PIN_CTRL_MASK- out_val[11:8], out_en[3:0] */
 #define CRL_APB_BOOTPIN_CTRL_MASK	0xF0FU
 
+/* IOCTL/QUERY feature payload size */
+#define FEATURE_PAYLOAD_SIZE		2
+
+/* Firmware feature check version mask */
+#define FIRMWARE_VERSION_MASK		GENMASK(15, 0)
+
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
+static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
+static u32 query_features[FEATURE_PAYLOAD_SIZE];
 
 static struct platform_device *em_dev;
 
@@ -168,7 +176,8 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
 }
 
 /**
- * zynqmp_pm_feature() - Check weather given feature is supported or not
+ * zynqmp_pm_feature() - Check whether given feature is supported or not and
+ *			 store supported IOCTL/QUERY ID mask
  * @api_id:		API ID to check
  *
  * Return: Returns status, either success or error+reason
@@ -208,11 +217,62 @@ int zynqmp_pm_feature(const u32 api_id)
 	feature_data->feature_status = ret;
 	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
 
+	if (api_id == PM_IOCTL)
+		/* Store supported IOCTL IDs mask */
+		memcpy(ioctl_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
+	else if (api_id == PM_QUERY_DATA)
+		/* Store supported QUERY IDs mask */
+		memcpy(query_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
 
 /**
+ * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
+ *				       is supported or not
+ * @api_id:		PM_IOCTL or PM_QUERY_DATA
+ * @id:			IOCTL or QUERY function IDs
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
+{
+	int ret;
+	u32 *bit_mask;
+
+	/* Input arguments validation */
+	if (id >= 64 || (api_id != PM_IOCTL && api_id != PM_QUERY_DATA))
+		return -EINVAL;
+
+	/* Check feature check API version */
+	ret = zynqmp_pm_feature(PM_FEATURE_CHECK);
+	if (ret < 0)
+		return ret;
+
+	/* Check if feature check version 2 is supported or not */
+	if ((ret & FIRMWARE_VERSION_MASK) == PM_API_VERSION_2) {
+		/*
+		 * Call feature check for IOCTL/QUERY API to get IOCTL ID or
+		 * QUERY ID feature status.
+		 */
+		ret = zynqmp_pm_feature(api_id);
+		if (ret < 0)
+			return ret;
+
+		bit_mask = (api_id == PM_IOCTL) ? ioctl_features : query_features;
+
+		if ((bit_mask[(id / 32)] & BIT((id % 32))) == 0U)
+			return -EOPNOTSUPP;
+	} else {
+		return -ENODATA;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
+
+/**
  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
  *			   caller function depending on the configuration
  * @pm_api_id:		Requested PM-API call
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..1ec73d5352c3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -29,6 +29,11 @@
 
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
+
+/* PM API versions */
+#define PM_API_VERSION_2	2
+
+/* ATF only commands */
 #define PM_GET_TRUSTZONE_VERSION	0xa03
 #define PM_SET_SUSPEND_MODE		0xa02
 #define GET_CALLBACK_DATA		0xa01
@@ -460,6 +465,7 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable);
 int zynqmp_pm_feature(const u32 api_id);
+int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 #else
@@ -678,6 +684,11 @@ static inline int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
 {
 	return -ENODEV;
-- 
2.7.4

