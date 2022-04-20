Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA35082C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376535AbiDTHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376465AbiDTHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE003BFAA;
        Wed, 20 Apr 2022 00:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rssb6P3lDkzMXH7J5OVaD+nPeVB6iPdo0JbPTCXE4KjuTiI2WcWXBF0N0jowgzTZ66F0BDKAzRrtlRrLQukOlAN1nlZ2JjDgSdEaih8BnJ2GMwwR5ULF2Uac5X6dF5fhCSN3fYGGbrIQ2UGS8oOPkKhVsFld3wUvVdyz4pcFLpgD2Gv6cqIKkoPk+6vR343e4ZJAECBdJGeJrm+dlgHcvOg/I0/FZZE47GCc1Z/Leib0y0QgRNc2d2fTVvmvF9y8Iwf52TzBb8shvZhVdZiPloqVZt10+Vbx+qbvSZb3h9r0af1vwKoSLiT407gWL/NDCGOAdm7CZQX2Y49q8OoYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4i8RM8CGIjUKAzdjJNfb+jKlng/2sT8y4Wi8uhrqVo=;
 b=nV7rcNDZy1+EJCf9L1HjODEzPhnmcqfPgtRuoxYvis+8zwuA8T2AJ+o+esWnmnG+X2zhfGn8PvBM+fNu4PQx51RI8eGR2gKgPyHiBr865XfOQ3geszV+56BZWmd+9JoA5/aCvKK3CmKYqbns5CzkgCfoxPZNrYLeFFrIBRCFzVIBnLKoYAGHHZn9e8PVHrfXc7Z5CAiBmTt7sNpEdN7MTLgignfN0RZsgymfMzCH5k1k4cMVNwRy1DRN6nTQj7J3yvadTr8pTw41Fcx4z+uX2evE71WyvGD7kVQwic7EHKstNkQ2oCJ5LUMWWVmzVmCumDz5cv/el8jy8gu+XcjWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4i8RM8CGIjUKAzdjJNfb+jKlng/2sT8y4Wi8uhrqVo=;
 b=m80tbwFQ19SYlm4guXie3MbeJSVbvMNcZGjzemQv49G5ZC11zz9+P5IklPU7GzcuTt96HxOj0kp/e/Fhfkw7QZldkck+jfrrDaXNrupjXRZTBpJ+V09sGp9A8vvOVAGXvwrhjuUq/wolMLb4L7BWsmCzdYAPOGdStaSXU1YKMOU=
Received: from SN2PR01CA0043.prod.exchangelabs.com (2603:10b6:800::11) by
 BN7PR02MB3969.namprd02.prod.outlook.com (2603:10b6:406:ff::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 20 Apr 2022 07:50:38 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::2b) by SN2PR01CA0043.outlook.office365.com
 (2603:10b6:800::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25 via Frontend
 Transport; Wed, 20 Apr 2022 07:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 07:50:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 00:50:13 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 00:50:13 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=51254 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nh560-0001h6-Cx; Wed, 20 Apr 2022 00:49:52 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Wed, 20 Apr 2022 00:44:50 -0700
Message-ID: <20220420074450.2034092-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
References: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a67f3f9-b296-446b-3530-08da22a275b2
X-MS-TrafficTypeDiagnostic: BN7PR02MB3969:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB3969847BD016740982419E37CAF59@BN7PR02MB3969.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3thQCa2d38xHImQRN9gfl35+tn3ghvmbRFLXTmUSVki4F5NjZibBS/lHvW8NkyYHN7BHz8PGj9w7UNjITnWN9xBeYX1FJW/Xzgs8GeAzhdR7jj+yYnH9Yb25EXzLh8FhJ8UxB9kXO1FEsejpV8DuVFL+H7+AmEo/V1/lPKMX8IYuqhyah8vxICU28u9yK+ILjxAc4af8IY2pOugflAJPEhcYIU98xVc0gTr4h3FEbPmRGmOuXh7ouuBMhOBEqWzYv8tdbBt0BeacEgjRtV/mSiUOZfA2QCFT4GwOUIpZkfroNmiuXf7wPIFTfH78zydVc1M/O3ws5fRCGHBHsGCLZj3NPuyjzvrduVA9GDpVvsBn7olj9l/JyuSLeeh1HtWuH6xHM55GrGCptYdlvwyb4yZMfm+l9mxaFW95cBG1/hrbT2ABn1b6WNgnbN+aGm/5WKfQHVEBU1m8J4anmLjfnu5l1J5kOoPF+USl4AfV7KEvN1+Zn4seOkUg6nPHfHRVsA7eHWT/HJYpZHZnp8WToN5ZThkm8P+F69e13J1aXMuUmA99SDWC1Q5cTvYqFjEeRgp/YKRRwfGon4rILetXHHyzpmrn1+yUGtR3YGZfBh39OYuStt7hcE1c2KbehOlEDJaqUlolHBAgaLw6XpvYfG7dcVVKvhfMfgTj4gC5Ys9TkD1DPjXiXdefmEdaSSE5XyqFgAI+VN88ira0F4Kew==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(1076003)(44832011)(336012)(426003)(47076005)(40460700003)(82310400005)(2906002)(2616005)(36860700001)(36756003)(83380400001)(8936002)(70206006)(70586007)(508600001)(5660300002)(9786002)(110136005)(54906003)(7696005)(356005)(316002)(8676002)(26005)(4326008)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:50:38.0068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a67f3f9-b296-446b-3530-08da22a275b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3969
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

Changes in v4:
  - Add reserved memory region node and use it in RPU subsystem node

Changes in v3:
  - Fix checkpatch.pl style warning

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index c715a18368c2..87d4ce5155c0 100644
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
@@ -648,6 +664,25 @@ qspi: spi@ff0f0000 {
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
 
+		r5fss: r5fss@ff9a0000 {
+			compatible = "xlnx,zynqmp-r5fss";
+			xlnx,cluster-mode = <1>;
+
+			reg = <0x0 0Xff9a0000 0x0 0x228>;
+
+			r5f_core0: r5f-0 {
+				compatible = "xlnx,zynqmp-r5f";
+				power-domains = <&zynqmp_firmware PD_RPU_0>;
+				memory-region = <&rproc_0_fw_image>;
+			};
+
+			r5f_core1: r5f-1 {
+				compatible = "xlnx,zynqmp-r5f";
+				power-domains = <&zynqmp_firmware PD_RPU_1>;
+				memory-region = <&rproc_1_fw_image>;
+			};
+		};
+
 		psgtr: phy@fd400000 {
 			compatible = "xlnx,zynqmp-psgtr-v1.1";
 			status = "disabled";
-- 
2.25.1

