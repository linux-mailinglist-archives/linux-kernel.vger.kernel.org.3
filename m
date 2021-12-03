Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A94673D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbhLCJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:21:57 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:17888
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351210AbhLCJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B08Hx64BoI1948j+HUFo1n2Lzm3g/2mHVSu3p5+vGmgwhnOgNRRdWulkMoQEJxhQzFCtLWThAXoQOJ3yah3zHB+XofG1AJPDkfGbcYMnvqCEVYuGbmlH8vsK5ULkNo0izYy7rxfXCMcq2jGwOTXfxgAEyuiKadY+Aj/PospJI9JuNRc4T32MfQrxoaej9jD1ReZAYxH+ZrGqnx7wd3uAiu4fNzbWV+6V2hCqCv00B7sYjYofG2JqT0JmqFsLyu8lrHmN7PxDUJNr3YNUcVSMyDxS8DLQe8qrSsk27LWoBcsugd9FcbJQ2od2R9/OsmAlAlS8jFKuRPePj/j0n2ME5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX+nRqHNti5IOXHyQBtw1lZm7A02+B+sUQgfhqvQ1vU=;
 b=SO/TxVcBru5whVELGigpjla2y/zcWLy2VF2oMJwvBP2y2mnjb4wd1qavIVmUyjyMavi1X5K7+mhqRNabvsbjiSvnFZd2kZwjgqTxvtuUnVZFedhiiB+FMJI16Y3CuYvspD42lS1axVeLhU1TgPaBVrBa95x2EgzSeF4mFK6fmKtIFIj84oTHZfQjBaLYITwz5Eqw9hXknGXBswctevTA+P5SqlT71rArTw6IRA6LJDNwA8urlHf20uV6j80e3D7BiKnldWALGQ5BpbUytDN9xz+u/rPvW7dMotNQMFsoJDefJcd2oXkO4Bz/+A9r+CrlQNAAbEPWNWo0bKaUrcsjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX+nRqHNti5IOXHyQBtw1lZm7A02+B+sUQgfhqvQ1vU=;
 b=nRkFGNdBSL23VFlO/WeR5oSWBKIjKUznfHzBnxdThQStduFzucfFa6zKHuL9cfKizoIKD/HKfdrhBaD+eC53uIVirL4g8KXWkWc/+EsUTjphWD1zCKhbVCdQ/Hrl1zyMTXsNzbDwG8ZC/UzYfWBbdPOGzkYSzR1/CeYMbq8MeI8=
Received: from DM6PR14CA0063.namprd14.prod.outlook.com (2603:10b6:5:18f::40)
 by DM6PR02MB5147.namprd02.prod.outlook.com (2603:10b6:5:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 3 Dec
 2021 09:18:26 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::4b) by DM6PR14CA0063.outlook.office365.com
 (2603:10b6:5:18f::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 09:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 09:18:26 +0000
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
        id 1mt4i1-0007wj-2E; Fri, 03 Dec 2021 01:18:25 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v3 2/3] firmware: zynqmp: Add sysfs entry for runtime features
Date:   Fri, 3 Dec 2021 01:18:13 -0800
Message-ID: <20211203091814.15582-3-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211203091814.15582-1-ronak.jain@xilinx.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52c74655-750b-4bc2-ec6a-08d9b63ddcd0
X-MS-TrafficTypeDiagnostic: DM6PR02MB5147:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5147109B14CDB5812790BAF6A46A9@DM6PR02MB5147.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i2SKLBUf0qSKXHo3LrZCkZOwEXIrnuxnzbGzxzplSn6V12cBilwSm3Hm+cGIxhbnAFZ+aOgQyiZvMra4yyVKS18iIAtPX/NdIn2XfBaObZ5ElLeRC05VWROGVkXNK6qSWubQc+G2MO1BHNTnDSmxI8QC2d92j0R8gGJetkeKDq98bwv6Q5wCoBQzovbSJJ8kQkxfz6pXT9P5enVkCWbLoQepuCO3j36hclSgmzocXrH8hOLcYIf5aCoA0obyjhg4bP2dqMfHtk+6OrR/XL81g0LLpD6/TR3g68BdMixvp88Cr+KbrF7pYfBqa2/rPURXPAHJ1X/cfy7zYg2tRH5IWO4YaL/uF1d3YqkOLAGZ+dAq898jDLEk1erAc96XID8pzDC39kwcmnVNKPkjAS44HSaWwZwoOBpoJxmRdJ35dC4om+C11W5vjnw2rcYNUFjOms8b3Bb6ojKT+Mwr2NUz4ggHjGKNwm66m9BFQhozBFw4At6ExOXJnlgFEyP/y3QHO7Nnx8Ap8WqLQYxoYpJ0sP2O/TpS9ooZZHOrIHzqIJvqHA2okZU0N5VYMkwjjSE6GfwbJW3qZntlV6gSDBTL90lbEGorgdP/3Jvw2pITZEHXVRulLjPoRobqEiFHniblUrjGk3j9fFTIQOyKJ2pY5v/C8uoARnWZIGfc+8dEqtI0YDdVzqkvDlVBqJOC1wIeLkdH35F67qhXAGiF3kOwKkzcyI64D7ZqqLeseRqMMc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(316002)(5660300002)(336012)(110136005)(4326008)(36860700001)(8676002)(186003)(70586007)(70206006)(36756003)(1076003)(426003)(2616005)(26005)(54906003)(6666004)(356005)(44832011)(107886003)(7636003)(508600001)(7696005)(8936002)(9786002)(47076005)(82310400004)(83380400001)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:18:26.2638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c74655-750b-4bc2-ec6a-08d9b63ddcd0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create sysfs entry for runtime feature configuration. The support
 is added for an over temperature and external watchdog feature.

The below listed files are used for runtime features configuration:
/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value

In order to configure an over temperature or external watchdog
 features, first the user need to select the valid config id and then
 the user can configure the value for selected feature config id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v3:
- None

Changes in v2:
- Update commit message
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index f5724bb5b462..2fde354715a5 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -113,3 +113,87 @@ Description:
 		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_*
+Date:		Aug 2021
+KernelVersion:	5.14
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

