Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288DD539A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348731AbiEaXou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348703AbiEaXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:44:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE76EC66;
        Tue, 31 May 2022 16:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRJj17tcUKr9Ntpqk/ZBHMCn4KFyBSWKYCiV8hoQ/YEZwjmjXve3iL1geGwwvkBUd7fzTm5EuUfkW7RRpQ/rDu4UIqmXBi67Ep698EFNxgB6ADUyefrLOqlTo/q4AbqufXEzkcpkUvUJdQlxsO8QO7xHwdWPOJ9g2PTEmrrbeoF1ZCl+hAqrEuRN+ngnXAN6c2z7wv0sXER6xDR96EeaJd+nO+/quW3yXkC50Jymm0U9trIAyKpXgJp6B0bJC7CbKs1YwBJawtfJxj+OO1xm7Ce63uVUOIdeD08gvr+DbtFKaV29CFETsLe+f0k+zwo7FP0nLqSptarrWtw06qS6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLxg5gkRCQCxK+RG7BUqfjz8sUNlOO28xmeE6yzaxxA=;
 b=EDJhGEoMNGNWQkMl8FVTJ6E+JbQMJ9A6nsJbynJWTd+jGHpCMVXdsjLGMnvZp8uK1AZXLz4unqTh/TnctZ7vxAp4NbdABfK5ukyd80U+N03g1pB/4hZE/rPQn6GjkxPkZ26CwoU8gh47muFB/gv/vNTjob+9zUxiAkH4gf2GXebKsjTI3pBz2GgJDtKzN3+Y2Nhhfp9Tf8K2rmsaBH8T5msseiSwlTU+R+VZ2QNui4D6MjmQgwqxZmoWxX78yvpI3MvspGdFV4i2zeZeVAQIHYtlrbTswKacmQ+pmSAmnzbwzDtUubHeztcFKUUjqx3gZMIKoC/Wzwg3IT2E8m3QWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLxg5gkRCQCxK+RG7BUqfjz8sUNlOO28xmeE6yzaxxA=;
 b=L9ReUsCVTD7QyyabJgTk0BQlla2i2LYKsQg6rnS89dxVs9BZ16NTJL9JlwF9UGrqkPOw5esOp7oo+N0skatVkNINCjNoykF16bWZzj2plOA/oKpLYJ3bBJcqKBseUrDhiaJa2SfF5FeGrgOCZm/0DGeTa24py3AQlv9mILEuUfk=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 BL0PR02MB5699.namprd02.prod.outlook.com (2603:10b6:208:80::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 23:44:42 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::f2) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 23:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:44:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 May 2022 16:44:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 May 2022 16:44:41 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48904 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwBXU-0006jm-UL; Tue, 31 May 2022 16:44:40 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Tue, 31 May 2022 16:43:06 -0700
Message-ID: <20220531234308.3317795-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2de73c-4f88-4137-c6c3-08da435f886e
X-MS-TrafficTypeDiagnostic: BL0PR02MB5699:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB5699C6CDFC55931FA1D4D950CADC9@BL0PR02MB5699.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPZmaZlJeOpSMODTMFNOX5WN8rVhbaBx42YoBWxyLrR8cPjgKWHfr1SujpRnDECVh3BoAvaj7eGC8PNJCI7m5DvForqm2MRDfnT26gn/RaIy8DiNP4QJCcjVVDmvFss+tMiiBfi8fwQwt1Pi0iH0XAA9e2cMGvYIXuAv7JhKHpjz3+9yu8W2eIwoSNKRF9VLm1gAK3q+WCL/Ax97rA40n/PfuQb9AuLwd57Y9dQBWZXr53UT0O9/ZcA2FeOFMGU2DoAj2bK/MpolTX/KyLcFTw4T0Q3zz295pQU9Cn3wh0ZYvejzQuc11d5gmFYMyHKP9GEcLKF3zKE3ZzH02obIoDQHHIl2E5C1uWWMfe08kwHlpAfbBGtIaDz1RF7l40Hj/28PoJzli8d73yheXOHSME0bhk3CpEXyvBz4bTdK86j4d90pLp9TxK4IYJj01aaGUbze61xpuI5AlB+mgO1jOvqE6EKfzThV/QIzD5QGhZ81GDCZAKTPLy+wZ4xbfHli1u1Znbe3Wssjo+owFu6r9IZOF7VynaQkvyNJ7z/RiXjAwXFranSBpwAF1NlqIuJnYRw24tecolITfpoiPEajEPvwPvJa3r+CqjdAgWYqNc98bUVKXIQHyHBSYvddCE1NZWwfJ4+n6GYTIBI5xH1USbROzVgkoqaGmdDzu6znfb2ZU0pxA7MOis47W/LhH+ZZvp8X1zFWXCGDHn61IdsPzA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(2616005)(356005)(8936002)(26005)(508600001)(9786002)(316002)(8676002)(70586007)(70206006)(4326008)(5660300002)(83380400001)(40460700003)(1076003)(186003)(44832011)(7049001)(336012)(426003)(47076005)(110136005)(6666004)(7636003)(54906003)(36756003)(2906002)(7696005)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:44:41.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2de73c-4f88-4137-c6c3-08da435f886e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5699
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

