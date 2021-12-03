Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F653467F45
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383280AbhLCV1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:27:53 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:47584
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383214AbhLCV1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ4CyfXy/VlWwaCkLPblls1w82X3THhm4r5GfyKA/y7I2MQLEi0DQL1NajVOsj4PD2Bgs8ZCcDVDzkZ8NrcTzxND9oKvYbXpv72uHPsZchgYzY9yOPTjwpCo4MRkRlBrLrrjLInlnnPbzgCWj7evlkHJEfLKMzEetn1JWfOsXJoWddqvq3HsW42QO2/hH4r6pfixS7fE461XAlFE00nFFp7qfkP5yoL/MuN0B1ZczWEHSBSSslC4yPmx2Gz71uGapx7qDdc/Sn1VVOaXHaUdOvE5oAD0paAdrxh2m4YMr+QF40QP2HVO0RvZj8yw3h+shlpMYOkFOlDc0TQmDX2zhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=MOaSOBhPcIgEAhighXm/z6KM8eIldNLuDpkV/oVplR3HwDhFKDcDTq97ofFWTdhUSp3T41xTTkwtpiRGKzJCvY50G6JLkdWCiMcWTlNH6jO3l54ZJBlP9zqBQ0DO/TCiE0cq+3FHHfrhHeXo+gI1Mw/y0jSk7uPSHBWfk1eCjJCcLvnKGOLNzsU5U2pcWYMDJDqR4CtubSNV4rVbhqsCcNAPFA4meUVJgXv4MhFsWVymch7BIAmVG7QAhfSVL75XsivLtuEyEwU9AW60/c4j4+3laD+hwFhZtcJlym+ZETOa5P49mcJsLuy0dQMjPN1LPsSmU/OECnW2J9UzqXp/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=k3IdVYJfkakTckj3jNZPt8U4fKuSHqEyxdnWnompdf49JKMcR3KbpPHpq+HJ3FPT6dyNe5Q7AiPvEvDg0rH+hsKGbZvnTKYw1gAWgA5obn4/nb5IX5lqIGNVbNi6tknDzRgvU9UgmKJ3dwRwmzoIwX3IPyfeUfXGHbAzi0N2Zbo=
Received: from SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18)
 by DM6PR02MB6512.namprd02.prod.outlook.com (2603:10b6:5:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 21:24:17 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::85) by SN7PR04CA0043.outlook.office365.com
 (2603:10b6:806:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 21:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 21:24:16 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 21:24:09 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 21:24:09 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michals@xilinx.com,
 manish.narani@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=14741 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mtG2C-0005F8-8d; Fri, 03 Dec 2021 21:24:00 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v12 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Fri, 3 Dec 2021 21:23:55 +0000
Message-ID: <20211203212358.31444-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3840f69b-fb61-4976-b667-08d9b6a34311
X-MS-TrafficTypeDiagnostic: DM6PR02MB6512:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6512492CC8618E45C8546F68A96A9@DM6PR02MB6512.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOjHPBLt9fB4MIYyQL1KQW1LrjSTOK6na64W5mjCcIF2uIh9zwI09JpIhZJeTh0MMgLcCMVC9fEmN69Rzjz7uh8n8qAPBoEu11NfVFMv1L8548mhvqaD1ZJU/QzlZ6Vd/kJ/kmrWmXm6I/EmOFrwp4ytuQ//fopy3ycJxlSLaUPLg8pkt4gcW73cam58tgpzMh94GX2JNgSDXllbtYegxFvcgSbMC9JGMkWaolh3ethnroD2Z4aHHnx6Dts1VLg8QAo0jeIw9anR3XQ8kuZZQ73SPJZ8bZkQX3LFecjCT1fvmz79Bw6S66WMFzf300aw9Ein9b0ACgg6U3hpqhL0WZZtZt+JHkesOP6wogMM+Fb52lxYA06LXOWxXIubWv0BOSL3evJbJWL9qcMGu1htKxPrr0B4AvcqdqXUqyNjMIQFXcxQu+LwhsOFseAoePsL8edhHGLjmOtXqzHo6xzneGaK4wZTb/m9wDPDCOljx1CRgu2rXvXynK4pdHv0sW9FchLgdGlbB/XRJr/VUuu0inOVBHZA+ZFKnsNBUuU6cYxJGx7H0agqFBKycpqugv39PnoJ2fF58nvaRJzjalNx38cmGw283QgHI7enkkUhsPFPvQsY9EnT1ERMWqSusdm27mQfX4wLavJyr9kJ19S+DGBSUJPDwiYyM/crWflchrBpS8Salqe9asyhmV119BI4aX5or+hsOSRdehRPpzY8phwLwLN+/t8v3vkFjgkkXc55+DT4bxF6gNs9nn/TWg5OZZH/NxWdqV+0Dco0uAwR/zJZE8yaTPys2mO06Lyj3Z0=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(9786002)(5660300002)(186003)(1076003)(336012)(26005)(2616005)(426003)(8936002)(8676002)(4326008)(70206006)(103116003)(107886003)(7696005)(70586007)(6666004)(83380400001)(7636003)(2906002)(508600001)(36756003)(82310400004)(921005)(316002)(54906003)(36860700001)(110136005)(356005)(47076005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:24:16.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3840f69b-fb61-4976-b667-08d9b6a34311
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Co-developed-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..ab96708fe65e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -878,6 +878,30 @@
 			timeout-sec = <10>;
 		};
 
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x800>;
+
+			ams_ps: ams-ps@0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams-pl@400 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x400 0x400>;
+			};
+		};
+
 		zynqmp_dpdma: dma-controller@fd4c0000 {
 			compatible = "xlnx,zynqmp-dpdma";
 			status = "disabled";
-- 
2.17.1

