Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9807D53AAF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356114AbiFAQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356076AbiFAQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:21:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246DEDD0;
        Wed,  1 Jun 2022 09:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKxrYLD/CKRiUVtI1yMi4vJ2sY0oLG6aU5RJKeI6zeC1x2OtnZ4dEE1QnIV6+CR6A/b6EZuLjD9BdymGRvOu22+1G1eJvLWidxrI3fYHKVzd6UzUPFVpKyqKwspVZDJ+No7J/Od+PxT/1h3gyPKMuL3jov44EY9LDT2h3fJJ5kz+ikbuJkwdlDMGO7t73iu820vMPxZmNDEwyzSFB64K3w8R4IPFj3wwF1IswmnSTq+VmDwd5idFRFsw4u+HlblzPPEa1JFjW7ZSgI4ldxq2n/iCNEQkJFnef/OwFuUoumQtD27YJ5ccE0Uaq38l0C2tPmA2AdZaObOTLA+yTbbMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bevVLhHG05UzMCZyjLaMleOpgfBexhgpdP6/NnzIraQ=;
 b=g6gw5wsTaSwsDiZXWqVgxcdzrCtLXDwQVZWlrBVfgdc93ANnhyvmu1D7Bxy0xo8ij5DzVjsf1IHwiIBbq9BgsJ7U7wC6g7VoS6gwZimica7C1q3RseA7GcnmKSnEnuqE7OG/PpFDcZFOxb3OQiafcplvRlbRbC5bYjs1iSEeWOY+MlqzGdrZsbXV5atol+hDisM5t56TC7hBACUfojzMgnG87Vn22wH5pPEVkzgAa8+lw5f0tCpUv/8IAjdRoRAVw0srCAxFjomDYoahfDYYz/QOAYiVMLNrcd5h8s7S5WjNRYyz4woG41yxmqgN0TGNG1Jve0sOWlRWqZsTfo71VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bevVLhHG05UzMCZyjLaMleOpgfBexhgpdP6/NnzIraQ=;
 b=QCmujPomeFVoa8g7gBnLWxCIqoe+HuBt2PwPKhQx183fBFZv9T09+ehEVpIhdwQEI3E+nk9FQ22kaWr2FR5rZCvJT45/WOkAT/dvyALN/GuAHyerK1j9vOfLNnp0wCcXt7L0XVLH2LIWHWtwOGiknmzNV/yzE7mddw14HGLJX6s=
Received: from SN6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:805:66::34)
 by SA0PR02MB7482.namprd02.prod.outlook.com (2603:10b6:806:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 16:21:40 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::7a) by SN6PR08CA0021.outlook.office365.com
 (2603:10b6:805:66::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 16:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 16:21:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Jun 2022 09:21:38 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Jun 2022 09:21:38 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=50642 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwR6I-0003Rb-Dr; Wed, 01 Jun 2022 09:21:38 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Wed, 1 Jun 2022 09:21:08 -0700
Message-ID: <20220601162111.3505458-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
References: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f3988b7-fe4a-44b6-4fbd-08da43eacf2c
X-MS-TrafficTypeDiagnostic: SA0PR02MB7482:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB74823D88EFAE6C6304E3C60ACADF9@SA0PR02MB7482.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ4TYSxlgQ3gvJ0BHBRLTx4pJRFKxl6U0Ya8ygHPraYN+LkEvlp55XbQ8zhTWQ0yzuKc3wP1KA28+5HVR5E9EqK5ZrtGHRjqgPUEMpFsH1pT4jFRV2dVnCB6k2mUS9t8vapQ6UsfKHEWlSXDCKLhWTiE+oxA4sbmYG5wiG9dUoD/BxlM601QQNRaqaaQ41OMOz1N8FpVhuFy7fbLvsD/FGV9NbQc4w7oM7dx9yjmGAQtwIxebxWmPWtqdStrZdPCd5QBE1KUxh2enTPYxNAFhPL83Hqre49ZN4+tzSVuuJ9O8ETKDfSlE9I52Tsh+MKlcp+IxIciZMVOb6fwLZqPR9C9hcXBG2TytxhLl4Zxh5d7Fw8JWXdGbXtgB+vqXrJvLTUkb4jnZ0QnVi+nUrGN9ZCFXPPX2N1IzcO08apyZdwmK1kOtWCxAi+I3f9TnF+io5oW/zOhOs+TdHnD2mhuoDYjg10SVrKVV+xFGZpttKkoLMAdg0fW3enJiawxwlMWUSlMR60UfhnlIj3YWkOPv8RvlzamXOYXTY5sHfqJp5S5jEPTRVX+8j94aedfqMQCz50eSf998oLPzc053ZHKflsC2llxP/sKCVdOxPLU3g5yrY6wf39B2iMXgxAAr6Ys1i69S2SG3DDEsNSlQY/Xvgnrb/uoWSm1NIwS7SIo4NDPgnlfIItaApdwy4n9hHQ8BpZhoTjs2LghXN1l081/nA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(508600001)(1076003)(316002)(2616005)(36860700001)(8936002)(7696005)(186003)(9786002)(426003)(82310400005)(336012)(47076005)(110136005)(54906003)(356005)(5660300002)(2906002)(6666004)(70206006)(70586007)(40460700003)(4326008)(8676002)(7636003)(26005)(83380400001)(7049001)(44832011)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:21:40.2761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3988b7-fe4a-44b6-4fbd-08da43eacf2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7482
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

Changes in v7:
  - None

Changes in v6:
  - None

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

