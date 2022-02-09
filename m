Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2684AEC39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiBII1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiBII1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:27:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3AC05CB85
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq8GQh4y4jc21cKeHAuWeaTFbXlITi9z1GtO6UDhve6b7P29MlGfB7nV7C34edRObL9b1Dv4azsy/BUvxexOLIfUAF9mLechBlQDtjZuiLUaYgUpVOkB6dJYQQs0SyMc7BCNOrCN9m1J/jhzXV7KyXFBySUY501IAAZTsxb+BueIfRmLrDSk0EBy63M/EPRfUufiyY8cjUsMeFtVpxmATVpys1+AyBFSl51hf38hA0oKrog/d1sD2MHfXkFaIkHc6rkSHU2kp9JJh1tOmvPQtAjgh+pnXW87I6REGcL+30y5TdkH+Z/uZTFSnbVafZ94ubsG3PY0r7GvDHRwXHzYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4xkKo8LcBxnqo2hVPx4Tj8aAmM93UUPnAiSr2pifXo=;
 b=Vj9bZB6GgZrkJs/UU0/krlVMCG0wPqnoQ9F4ojhGL8wTc3118frho1sf+7GupbX8tcPStJPQ83hAzZLTCV4lJYvbTOaJ+qyasfqtWebOmNE8whkzhHLvtdhuqwRNUKG7EsQwTEgg4KsM41WmAEbZpTUhfauUhly5Kg6q1EvA4MxdvV747SaAFz9SBUtm2tVgTQgZJVdVqeUwMxPSy3KbJTOwU8YHR+HAfqIqcYPneoAfy7gwfyLSVgqn9OCdSblMWzOcW3WN9TvUo+YSIaRTAIzhzqVpUJfeD9ttmeWh6N/6f3iOH6sl+EzMZ3dcfuzOdZHltIuBowYPCc5n/FXo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4xkKo8LcBxnqo2hVPx4Tj8aAmM93UUPnAiSr2pifXo=;
 b=iDXF40HgyAm8L6KeZFe/0mSCURp0JhsJ8T8+4BFy9OHXaErM+1qabWl1OKq191fWxcEVfy+hflE2H2fgH6d7jCGbYBEDgDMw4rTHJZMsAXNTEEBiqfmADuB6w5dfzN/mhpaElAzfdS1/14Y+N3sSW2MLVwmlhxzwSTDzbdlrQGE=
Received: from BN9PR03CA0899.namprd03.prod.outlook.com (2603:10b6:408:13c::34)
 by SA0PR02MB7129.namprd02.prod.outlook.com (2603:10b6:806:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:27:13 +0000
Received: from BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::b4) by BN9PR03CA0899.outlook.office365.com
 (2603:10b6:408:13c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 08:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT035.mail.protection.outlook.com (10.13.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:27:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1nHiJk-0003T0-E5; Wed, 09 Feb 2022 00:27:12 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v5 2/3] firmware: zynqmp: Add documentation for runtime feature config
Date:   Wed, 9 Feb 2022 00:27:08 -0800
Message-ID: <20220209082709.32378-3-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20220209082709.32378-1-ronak.jain@xilinx.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2b1bec-1975-43fd-180e-08d9eba5f917
X-MS-TrafficTypeDiagnostic: SA0PR02MB7129:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB71295692E86491C034C88EE0A42E9@SA0PR02MB7129.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfU5oq2aAXo7Sb+gg3TqQYPZbhpavPRr1mI/KqbX+RVOCATGoEhqdlgYU8NX35z9ZS/Ex0CLtJpieA96MmaCOKtk37/EJJbPgBEbSpApkEGjgNh/KY49GSrakftvl0i5kwU0F++l9DTIDv07fxwRvP/MWc7rfT6N7Z3X4l9RH1rMZ4R/AIMCgZoCoK8NuiaHq0OGs1doJcEdwpTUvDA0/iwLBaVW1XoFJQvPt6GV4gvBoY0cQXVT0A9GmmwvbAW9oqwAG3QNupvU6m1gRpK+Z9zUo6LimUsNR+nclS95+gXo8cybLXQVifjVcGkFsYcJApLBqXAsrY8gjG+czTz0Q3fdWkf0w5+mdKo9DloDtJt4NAVScyyCD3rDmgkamhRMVwREFG38jmWTxRra48tJbKabW6jhxVZ6dN9vGXklmjlLBrbLMiEBvrhv1dWY8WRtIwYAGisZxXnmxsP4TuAGvs+DffxTGw/nmXw6vIYxc3ZKZum1G0fQwZKHbMM7pmJnAQH7qkBS65icp4EgOjlubPTbsXwl1IwOAGNtsclLB6k2rUJdKkrLRP6Ifiw7uEiNho/tjfCmJJSBqjcn8elZU0kQHEuiHIGKY13D4ppibf7iMqSKiR9dp8vGlXXmE2GiM21zA7IJap6Xk5dI6xtMy8DH4/QucIeCd6d9YfL2B2cGSLi5rnRwwfT1gp68TdWlPyPxmYDAoy0cI/SMLnN0aQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(54906003)(5660300002)(70586007)(6666004)(36860700001)(83380400001)(316002)(7696005)(110136005)(9786002)(508600001)(356005)(8936002)(36756003)(40460700003)(4326008)(107886003)(8676002)(2906002)(1076003)(26005)(2616005)(186003)(336012)(426003)(7636003)(82310400004)(44832011)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:27:12.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2b1bec-1975-43fd-180e-08d9eba5f917
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for sysfs entries like feature_config_id and
 feature_config_value for runtime feature configuration. The support is
 added for an over temperature and external watchdog features.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v5:
- Update kernel version for sysfs documentation

Changes in v4:
- Add separate sysfs entries for runtime feature config
- Update commit message

Changes in v3:
- None

Changes in v2:
- Update commit message
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index f5724bb5b462..c3fec3c835af 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -113,3 +113,144 @@ Description:
 		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
+Description:
+		This sysfs interface allows user to configure features at
+		runtime. The user can enable or disable features running at
+		firmware as well as the user can configure the parameters of
+		the features at runtime. The supported features are over
+		temperature and external watchdog. Here, the external watchdog
+		is completely different than the /dev/watchdog as the external
+		watchdog is running on the firmware and it is used to monitor
+		the health of firmware not APU(Linux). Also, the external
+		watchdog is interfaced outside of the zynqmp soc.
+
+		The supported config ids are for the feature configuration is,
+		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
+		disable the over temperature feature.
+		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
+		over temperature limit in Degree Celsius.
+		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
+		the external watchdog feature.
+		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
+		external watchdog feature.
+
+		Usage:
+
+		Select over temperature config ID to enable/disable feature
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+
+		Check over temperature config ID is selected or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		The expected result is 1.
+
+		Select over temperature config ID to configure OT limit
+		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+
+		Check over temperature config ID is selected or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		The expected result is 2.
+
+		Select external watchdog config ID to enable/disable feature
+		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+
+		Check external watchdog config ID is selected or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		The expected result is 3.
+
+		Select external watchdog config ID to configure time interval
+		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+
+		Check external watchdog config ID is selected or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		The expected result is 4.
+
+Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
+Description:
+		This sysfs interface allows to configure features at runtime.
+		The user can enable or disable features running at firmware.
+		Also, the user can configure the parameters of the features
+		at runtime. The supported features are over temperature and
+		external watchdog. Here, the external watchdog is completely
+		different than the /dev/watchdog as the external watchdog is
+		running on the firmware and it is used to monitor the health
+		of firmware not APU(Linux). Also, the external watchdog is
+		interfaced outside of the zynqmp soc.
+
+		By default the features are disabled in the firmware. The user
+		can enable features by querying appropriate config id of the
+		features.
+
+		The default limit for the over temperature is 90 Degree Celsius.
+		The default timer interval for the external watchdog is 570ms.
+
+		The supported config ids are for the feature configuration is,
+		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
+		disable the over temperature feature.
+		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
+		over temperature limit in Degree Celsius.
+		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
+		the external watchdog feature.
+		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
+		external watchdog feature.
+
+		Usage:
+
+		Enable over temperature feature
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature feature is enabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 1.
+
+		Disable over temperature feature
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature feature is disabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 0.
+
+		Configure over temperature limit to 50 Degree Celsius
+		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 50 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature limit is configured or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 50.
+
+		Enable external watchdog feature
+		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog feature is enabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 1.
+
+		Disable external watchdog feature
+		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog feature is disabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 0.
+
+		Configure external watchdog timer interval to 500ms
+		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 500 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog timer interval is configured or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 500.
+
+Users:		Xilinx
-- 
2.32.0.93.g670b81a

