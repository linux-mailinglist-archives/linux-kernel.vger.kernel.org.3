Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB053BFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiFBUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiFBUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:38:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714DBF68;
        Thu,  2 Jun 2022 13:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0GWh/j1N2XBe91xCqWGQorrlN2d/K6MdRp8hYocSBIF9AAGRi6xz+ywYB+7WhfvyPc/nMyjt7l+TFa9AHhry3b5ZpJ3cEnhJO1tlbH5kDmzkTQ7ZP7sPJ5rzc0/DA1m4h97My9wxpkB6A9vRVpyv69xVkISV9uoy/Tgreb9S/PNHgyIz4GnBNsA7+Xze7II40lqHAgxDyULAlhN6J81h02+fM4PR/fO0Ou4AqEmOHzV9Q+JR9a8DH2/H5tYkPpkbSDLBJj+6WMi7JxQdTU0D1KricoHQN43iQJ01n/HtBscYZTQd4XtX2Kj+K/34ceuZEj9XKDIKalSIzytvNZa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6wDV+udcR/TPyOSoBDiuwURCXJveHtP9CkVFQ6aGt8=;
 b=XKO7SeZ2gA7AtzuTNK5NFXL2MtoeJm/X4N5ZXSDqEAbyZUC3eFj52EZ40AmkbBw/OsJhzgqoDb606Xxk1wiTqXwAGgCSnqXkzJY+8YmuBfP/Q+8pu/UCleBH0z/UQyoMAVU9gQ14wkbAqy90vSJ7DGEaE+GXmSGTzaNMtAuLZ4lVYWG3O8c1st/cvYOZjS32s/CCfcKN21NQAiQLQy/SlJpBwOGHDRedZ1yKZ74NyAQwdkxuJLA33P9F3S1lZmIfu+PevNzfsuYR6jY0JQcxATaLFrF7pIrlqEDBP+Lz89RpWIPlSpLVMnrld0AROeoZVb+iR9DujwbFKuP8FkdVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6wDV+udcR/TPyOSoBDiuwURCXJveHtP9CkVFQ6aGt8=;
 b=pRp1xDgrc8pAyzY4SiC/yzQBxjRDwdPhDXiBS3xzBvuht599K6A8PeBiP6peWWv1lhIG3PpCwO4zeeaZWXUFN/EGUN5wml0unyeAu179bhYmP4gW7pDfF0FTzZACCRMbZ6pGLMpawpuZXyQ8sxmq5AZnPw9wI6cPz6bkcpEbytQ=
Received: from BN8PR15CA0047.namprd15.prod.outlook.com (2603:10b6:408:80::24)
 by BN7PR02MB4195.namprd02.prod.outlook.com (2603:10b6:406:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 20:38:53 +0000
Received: from BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::25) by BN8PR15CA0047.outlook.office365.com
 (2603:10b6:408:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Thu, 2 Jun 2022 20:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT016.mail.protection.outlook.com (10.13.2.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:38:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Jun 2022 13:38:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Jun 2022 13:38:49 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [172.19.3.14] (port=53866 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwraj-0007MG-76; Thu, 02 Jun 2022 13:38:49 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: [PATCH v8 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Thu, 2 Jun 2022 13:38:30 -0700
Message-ID: <20220602203834.3675160-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea74775-2bca-4580-091c-08da44d7e836
X-MS-TrafficTypeDiagnostic: BN7PR02MB4195:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB419597E1D8D20DC83F3B73CACADE9@BN7PR02MB4195.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPVaGk0oD3192DvK3GzI/q4vQ44ZcUHIUMIbh2eeUSJUQPac+tAmF0iPQdNkth2ONYIMUz0H+Uxpzf8DITYwDNY465jwzFUo4KIV6I5WIDpwUPC1F7UGSTr/cbu/SDb9VptKxlA+17ytn97KfJc6OC8lvcArw55qQorR/nqPMJ2XjeJ6KxcIn9EXtZKT9XPXl9xKtUuxC8+M3qBEOZk5W4kDV1W+Q3V8MlMipdlAHtGbnEKH/ayWaBKunpnh488316dlzWAlsnusZzWtjGXhOjV+KzWvHsqiADDNyiWpj5tO1RQGK1uzI2iqZn3itZ1ETLbJmah+tzL6Wdz+BZj9odYh9/BiR9LXOOfeQKkKWQdlGGODossxIc0DWPDsZtJOmt1KgRHQso9vYsWZHPH0ULdyZGrspjAZ9JKXjwkcr/YGtZvrgp+pSKvkKA+j8HpwEP0IoKNPOXV61UpSdJ/yxsO36rPOijgqGI35eBAJuXUiciIEJ/gnSOzYpo9DkhOxogKSMzIuiMyD3Qn3xKFWQThfrjiEHZBBFyXrPPyRTngh5xEPm6cU4vxXrF2vjTEA6JXF+OErh9M4q0OYeeeyQpyFnegXuEAvlDB3r/zEMdACTu5X/UYV9MbBNOZlcqyK1/g8sNpYNLYNDbhX26r6pyPHla0AOLzfctzGaqU3O0C1V09HniLz/jikQP3yj9tS/sAxRhWo7ya06nLl3tRyJA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(44832011)(47076005)(4326008)(7636003)(2906002)(83380400001)(8676002)(7696005)(40460700003)(6666004)(26005)(36756003)(7049001)(426003)(336012)(8936002)(36860700001)(1076003)(186003)(82310400005)(508600001)(54906003)(316002)(2616005)(110136005)(5660300002)(9786002)(70206006)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:38:52.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea74775-2bca-4580-091c-08da44d7e836
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4195
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

Changes in v8:
  - None

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

