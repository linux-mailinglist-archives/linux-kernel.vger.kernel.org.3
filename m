Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7A56B039
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiGHBkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbiGHBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794473588;
        Thu,  7 Jul 2022 18:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSvOHL3gyh5LsLcW79kZlwq6lB4cdJeuvDWb7ViwNKFCr5bBJfZQbOaq4mHIRB6ZxpWYXcSq8sVJbGey+lSGZgsXUUX1qUo0KHHtKu7+dvDKzXDgpGwOtUy+WPE18lgPG8GtRjw5XLj4hHHfdcBZmYOL/mx3vg6xAL6fLM79QySYNYT+QOT/tv2jZdj1I78+EjpsqGURucAMrSUWD/YI+noSAWddpC3sjvXJE90/EZF2G/aWXjlPT+gw7Wq9XLi0D7QTiRoXt6y970sDT4A8iIBYj0KOpHsaH30mpFnMMOLqiq6K1uUV0F1BX6Yiwfp4oXKS2YuvGVy+56e7jE+bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XANvWm6J9WbH7ErpoxfhJRro7/C1LKP97pbzDwq6wA0=;
 b=SbTZTbr7tsJBD4n6R8y3qwpA67bWiaCRCSe3mGZWHVrErDisoe8+kacNLwvkhj7gLOkae9CwHjKxuiWWBOv+XEcE3Rs3+KRNXQjugrnxh3U8R7rulE5sSWOvegxsa0MnGSXW27pabDA+yETJsPl7+D0fpvJFwR0S7fjCcLMedqpEWVOS0hxP6FnUEK633WRaBWs3fxMLtZL6kdN/4+45/i38vx/FuKIMkbzgDkkUMprrKiPu2xGnffkrx/dB6K7zbKO+IovkTNtkQxeaqs4QMZpvoYqkrjk9XeXd+x/fzvKHrBOD7xnkxk4Yc/e3MfnaFXvlkN2vYrccc3o/wGiafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XANvWm6J9WbH7ErpoxfhJRro7/C1LKP97pbzDwq6wA0=;
 b=HnqHABA53JQrehMlCiLeDiN6ItgyW5SUi2IHl0AupN9aISGV/1aXchR6borIFJoYZSSDtfXzwJpU9MRpGLv60VggSjXsCDAPhqJwKco4yUDp9o0YrBE+BAFPjK4WXowxPNDqemLN92CCZWAebh12IDMEQ3FLHPt7hWgZ2YdUWDk=
Received: from MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) by
 CH2PR12MB3784.namprd12.prod.outlook.com (2603:10b6:610:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 01:40:32 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::c) by MWHPR10CA0005.outlook.office365.com
 (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:31 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:30 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Thu, 7 Jul 2022 18:39:51 -0700
Message-ID: <20220708013955.2340449-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708013955.2340449-1-tanmay.shah@amd.com>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec68d024-1e22-4b9f-553b-08da6082d8a5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxoKoOOmalluleAeuT1X/Re62TYjYZiDwWUtuEAmJEg6Np3uqNlCPpc7Z6tS/eR9g2tNkJ5ISvAeU2SPaVLp7hqennfvUMo5T7r9X/Qe4ozfM2hJDp51ZuYerUmMDJHNXm/gKbt8yR2bGP/8Re7HhuMTc8qiTEdK43Ykn8wYSFNyi27AkrXIGVPDDvfjVhMMU0C+dj4GQ+yNkxf5lt3WJzbxVB2onz46p//z71c8LNTJTf2Z0xnadc2xk73S7egqeyB+SPIAxX+RTPTGqPS1mUjA5JfdLVJl4amMpo8nKOe9FwVT26l00orEnkA8xE/T9uU9iOuMiLNOqS9DBW7p3bk1hS6rnYL2QLIMTW9QYthVdHmdmk2qVSgsjk5I+/gR99DFy7o36tPt6Q8v/KaY2diUW6Nn3FaP97qhQiqEgKVa5v7YTx0dy3IV+aCUkjPsaZqQh9fyPthfS7SUwG3aBaBlTxWkl2uHutvv1dcFe+6yNjyGm/K8Yvo3+mkdVMikutCo0zb4jYoMvXqjSf9O+HSi9d7H14eQIIBnkmNDzXB9prna78Wx7zir/sAYB+IMIwL3KoVDzZ3KfcjN9txhRTXOpauOSeYgsDvpOHNdZt5r3iX0WyV/1tHIPtXFyrgku5bgysxRmCvnJntnsaxi3mrFlajD2T1j/AkQpSdBcXFRX+eU0wttoiEFpGVmiajzgDcWtvHSofLqvpGwwadqEQLQ66eq13iYs9KRl1Jeua8w8pY1au5O0wWIghHChyVP6oDMjAuVj1ryJxtZFI/qigulJAYPIN7v9/h4gUUGg5xh/ID6ZsnA0+xpyXp5Ux06oms9Ji/oBmIyyjvbaJdf/SWEOViYW8gzo9Xpp6te3veU07ilb8jsIeDBcFLIWnN2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(2906002)(6666004)(41300700001)(82310400005)(478600001)(86362001)(82740400003)(356005)(81166007)(70206006)(70586007)(83380400001)(2616005)(54906003)(1076003)(4326008)(8676002)(47076005)(426003)(336012)(40460700003)(26005)(36860700001)(44832011)(40480700001)(8936002)(34020700004)(110136005)(36756003)(316002)(6636002)(186003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:32.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68d024-1e22-4b9f-553b-08da6082d8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanmay Shah <tanmay.shah@xilinx.com>

RPU subsystem can be configured in cluster-mode or split mode.
Also each r5 core has separate power domains.

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v9:
  - remove unused labels

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
index c715a18368c2..1c19d9a03c49 100644
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
 
+	r5fss {
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <1>;
+
+		r5f-0 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f-1 {
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

