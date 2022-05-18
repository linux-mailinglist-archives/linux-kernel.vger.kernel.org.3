Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C552C3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiERTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiERTq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:46:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63101A4920;
        Wed, 18 May 2022 12:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLiqE/rUawwJTZiQXIYN8AZZYwl8AyacIk66/4XZ1bDkM0jzZniVFUmowk34F4bmSh6Sg8NxFgqHp+ttxUjKP8yjqDzVJjCXT1TYRVpLpdoiB7OuGxM6fQgg4su4j833Hr5Nlx1ztPOsOOKaffLDjldhZUqiEgzD21hTQmdwf3i/0nhzWgpw5CHRS/jpJ5TgYXCdN7H7Na+VzNsarSTex+dgjjHSO/W/eECogHVnJj1iQyep3vHtSI/jZXjCSr5xua3MZGNnxBtjnSH4gIifu208+yRnNrU2vHGxk/fD3bjo1rbIU4fCYPSWBBBK0Usn060eCRih3rC5UVPXXVejyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyDObr9g57eqjRib21RhnfA6P+RU0j7RZYizyJyiPZg=;
 b=Emo9eTYv04DfO7CMgcjnx+LDPJoi9rJO7aw/oYJBtVawPX2yb9MezRZyUA2N4l9QX+Tmzg8HYCscn2mbSZP3E4m/gdeaPLJl4c2zZgtUxm1RDYUCsBA4dRRUlPONLNcO0lFuwf8FapbGfLYAmkePCnqhtBV4fUVSP5OiZZOH5DBNHKNmto1wtuh8flBYP3Sp3CkZvwD4ZvWOwCn97byPxERqzp8vZwV4ylsN79s1b43IJBDAqd7zUEQyEJYD9d0mj7KpxKcz58pDaCG0nWs1Tvmy8JrLHaPilbxGim1GPqY2jF3s+0ITzQgtbC2ur40AQ0hOD2TE9owUHvLOZ3PA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyDObr9g57eqjRib21RhnfA6P+RU0j7RZYizyJyiPZg=;
 b=AoD9DS6IT5KuKmfT8GJFH9qR9FlLh8obLhpa33yRRsAuO2qfLvP/TpQdryXEZNU8KsmoJJyNbME4xp61ldGT9F6JIsmCgHNTuEQLYBd+FqIX3R8RpyUFhjFMfyCLIo88mOeBtbrGGnOw5XgBxqUt57sA3QqNvrcjQe0mHG3WE90=
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by SN1PR02MB3806.namprd02.prod.outlook.com (2603:10b6:802:27::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 19:46:52 +0000
Received: from DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::99) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Wed, 18 May 2022 19:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT042.mail.protection.outlook.com (10.13.4.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:46:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 May 2022 12:46:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 May 2022 12:46:46 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=40706 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nrPd8-0004Ew-QJ; Wed, 18 May 2022 12:46:46 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH v5 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Wed, 18 May 2022 12:44:25 -0700
Message-ID: <20220518194426.3784095-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0e9293-6016-44d2-93ab-08da3907282b
X-MS-TrafficTypeDiagnostic: SN1PR02MB3806:EE_
X-Microsoft-Antispam-PRVS: <SN1PR02MB380639A000EE2F082CDC6B3BCAD19@SN1PR02MB3806.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Se+xrPEW5VvjhY7bF3kv1eUvtBxs+72L9yGKtrrvDxSufL7/va4gTnU6aMvFC9pVbsNqvKmvCxiE3+tHVOHLjeJAYps9Z0+3Aua/xdefY+2ml2Fy4i4vAefQt56JFQWn70KkS2C6d8Wpj3/jLV3Tgbdt0LLYl6C0dgUWkJmeUjV/WYdQ2Nw3sNtegigYrlpf8amovY//31SxRL1l3jpkIBUAPhjklKVD5pOD3wOs5pYoFP0j8mZ9zEDTGy6v1ze2V8o76hDnfYDtsB4/yndKfhfo9KqnTE6KoGuMPgtXXNlCzjnLH4jU48hKeoV1AOLA6ujH/bPShT0AXO3DeO+OlYFGoSx5sz7QLYGRuAdPDXu0fLilb7KEbFkGNHBcm4FZ5ptt/+DzGFdq68v5K4hSG9nXBGzt4qPRI89J+5+E7pAGV2zs08fVDhsT3ssUb0fEZhtQd/ficuCJ/c4UP3/LAxsM3yEmJvT5Xz98sChiQbsPVX+WOYOVwGL9o05O9WWzPvDJ8gf5ZU4tJ+6U9EYW/WqNtoVOg02q91N+u/ENmGTjgCinhC+xPlHwmgefJ0+rbFkQ3S/nQyhB/wVwNfxIMWZVLtc1axiKSPKIAl+oXCl1N88YiNy8XdYmxRYNpMb+yG+qBRUWU/me4JH90acvNsoAeM8JrFWwY4NIgtrd6ShOPQD6DqYvFv2B0N4mH8vSJ+qTieBG5Cf2U9PutepKYg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(316002)(83380400001)(336012)(54906003)(107886003)(426003)(6636002)(82310400005)(1076003)(356005)(2616005)(7696005)(2906002)(36756003)(26005)(40460700003)(110136005)(8936002)(4326008)(70206006)(70586007)(5660300002)(8676002)(186003)(6666004)(44832011)(508600001)(9786002)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:46:52.6907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e9293-6016-44d2-93ab-08da3907282b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3806
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPU subsystem can be configured in cluster-mode or split mode.
Also each r5 core has separate power domains.

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v5:
  - Remove optional reg property from r5fss node
  - Move r5fss node out of axi node

Changes in v4:
  - Add reserved memory region node and use it in RPU subsystem node

Changes in v3:
  - Fix checkpatch.pl style warning
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index c715a18368c2..e8315a4f7f61 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -100,6 +100,22 @@ opp03 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rproc_0_fw_image: memory@3ed00000 {
+			no-map;
+			reg = <0x0 0x3ed00000 0x0 0x40000>;
+		};
+
+		rproc_1_fw_image: memory@3ef00000 {
+			no-map;
+			reg = <0x0 0x3ef00000 0x0 0x40000>;
+		};
+	};
+
 	zynqmp_ipi: zynqmp_ipi {
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
@@ -203,6 +219,23 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
+	r5fss: r5fss {
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <1>;
+
+		r5f_core0: r5f-0 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f_core1: r5f-1 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.25.1

