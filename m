Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE394694EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbhLFLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:24:59 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:22625
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242397AbhLFLY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:24:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHvWglITIjaC9UjCGxcF1sINzks7IJr2kkshcqAPfCTNMLwyxTysG0K10TTGa3mGVT8FOmRxKANbA2Z9REC0Uvdlojv9wdFegQFgcu9fWN1i9GECB/iXrR1tVEcQTHNWGwxZCs264XX2vI7QAVPT8gOeIoy9rVwmKb2S1/vRXq6iowWsI/DxoAWTjZSOkOhCvjyXfOqtCBa92mjlT8jYFuEBaeybTkw2r0JOvUDo+Lif4LrFVn/jcUh7bs/be5n9xHSzfo2V/1Oxa3hnfl8LwsHYbqfvc31NnyU5HdXIC13kbJk1fxhPcg48QUn+kbbMeeMwrcc8Xioa9+QIhvJuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7AhqUsFVsQemv93ghpgQ2P3Mo6bZj6/X9TRtaYI700=;
 b=lYBiz8eoDnvxfse9IoGS8IvSMT1iom6JTKPWss+cQoFTXjFVLPinic4wt3HscrwI6zYKS7uYmGqpZ2qQgIVOhS4LEncs8QbKpDQquLR5Cpfp7IasMe2cWjyKRIcAY3IPz/6rM4GkyLz6Eq0VaaSFbAOp8fhgwWJasd9BULxG6yisLKyA6evTU1l3ufEWWMTPEdnccCpT56SOIsEMB9kqkh+1Pk0vFRzcyIXZS+MUJ7Bj22kc81SeK1tHQwnewocaoREU6Xb6G8ntGuxPTRXmGI8GnA09u6IoozzSF7IW6YI/Pm2HiOD2GFWb+mjMcMiKQjr9Q3CwTemzOZ9D3qratA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7AhqUsFVsQemv93ghpgQ2P3Mo6bZj6/X9TRtaYI700=;
 b=F1AKCfVXM5AikTdz30v2ctG8o1UBBOVjehSzIs2sJEndBd0SGwjcxdsep9meI/lGh3q8rEDj8dbm7R3sloXzZo+3OFbCU26zzrLUtaXcEaRjl2nlCS1rSMvSC55y/BXXsysX50u5cAGW7JHLDkxz2Y7DbM0EYIKp5/vH7i2B36Y=
Received: from SN7PR04CA0229.namprd04.prod.outlook.com (2603:10b6:806:127::24)
 by CY4PR02MB2197.namprd02.prod.outlook.com (2603:10b6:903:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 11:21:22 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::f8) by SN7PR04CA0229.outlook.office365.com
 (2603:10b6:806:127::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Mon, 6 Dec 2021 11:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:21:21 +0000
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
        id 1muC3V-00050V-JP; Mon, 06 Dec 2021 03:21:13 -0800
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v4 2/3] firmware: zynqmp: Add documentation for runtime feature config
Date:   Mon, 6 Dec 2021 03:21:00 -0800
Message-ID: <20211206112101.24955-3-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211206112101.24955-1-ronak.jain@xilinx.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf6a550-7acb-4859-f53c-08d9b8aa884c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2197:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB219700638EE81D4D188F67E5A46D9@CY4PR02MB2197.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev2PJHUDHmdntybpub5VGU5Ud+r+5pUjU4U0nYcjGWOIta8BPcakymWsUVX/5QWWqwxr3A1W7f9zrWtTvEOS0jCQ6xAOp3GPNpGeg26HQvN1n+6jyTz10VOblTjGJTa5qftHIbs+fQ5vVIUVKt6PIHfjYzOYo2B1Mxm3ePxv4L7vbawUP8KPlI5lJ+rMB/x0o6HwcPik1xh9HEveQqDLt5Pnm/66V7Pko0B7/c5SrrBA7j8NCUR/v8RrgPjvWkpzTfjt+U5kgFX14oDJK88yaU2hFpBpyRr3iDoxWDxg7mif0FKBANRi/DuxdgVWetdEBMdR40SO3poa3bu8uaRE9HSxcx7Ujj097Dp7VbprUra+dMpY+KMfyT6OhbB3nfEl5vQKCfWChVDdeo9YcCTHEUrSLxn4/YCSsHYhzDdHvrzRsPLfFxGRmHGc2SyeMI7aIjaYWsOmyKPx+X5Fc5p883pMC+Xpfp2qeEV/XyNOraPJf3JVu3MB5v76VcPtDqvtbOa7yJ3sGuV3PMhV8EC75rYjL4pLr9CJN9Yrtr1D9txj1COBTVzvc7dDS3jvYd7YoIJ19A7vn/Hugzllcri4L1hC3lgM7G+BzRcLHmZZ94e4toG/oHV584SJyMWlVl4kF5gzxIt17Gpe3jamt4fKrZqqE7oef8gjaZksiihEDtr+z6I65eMT4ddbG1cYxeOCbr4KsKcJzLM22aLMl8tGFfW8ifWyWnij0LAnci/pBrM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36756003)(2906002)(107886003)(8676002)(336012)(26005)(186003)(8936002)(426003)(4326008)(44832011)(1076003)(7696005)(2616005)(70586007)(5660300002)(70206006)(6666004)(9786002)(36860700001)(54906003)(7636003)(82310400004)(47076005)(356005)(83380400001)(508600001)(110136005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:21:21.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6a550-7acb-4859-f53c-08d9b8aa884c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for sysfs entries like feature_config_id and
 feature_config_value for runtime feature configuration. The support is
 added for an over temperature and external watchdog features.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
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
index f5724bb5b462..0978a766bd65 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -113,3 +113,144 @@ Description:
 		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+Date:		Dec 2021
+KernelVersion:	5.16
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
+Date:		Dec 2021
+KernelVersion:	5.16
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

