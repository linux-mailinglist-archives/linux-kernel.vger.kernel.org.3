Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D034B0C63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiBJL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:29:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbiBJL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:28:48 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3DFFB;
        Thu, 10 Feb 2022 03:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp1p51T5ai5VHPXdEGh5NjJv9tyzqB7foiSv67URkE67alL1CTXhzd/Jv4xrhZ8hxg9z56tylC1o5O0dZKP6kUU9wqhXcTJbgPnQQh9J2QQUAqqH94STQDLH/an2FoayfOdB+ljETvVn+rcLS4UbsLoBDirUAdqlGxBvRMAjOSsE5N1liPnc1kAC0gKomKso3UnmBSXJdUGCuotL5b8tXmmiyZQm3lLSRYWD3ZeiXdwQ8AsKCf4hV5tlVrN4/+MRL6EEKvYGRA/A9gm1Rv1XnMz+qjg/AM+cmUHAb7q/lr/3kCFjEvdDdRM6R2hNcW+xrkdcDiNofwSx6xfHe4NzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwlAL8uXhX4mUiwQbHsvxxOC7qBpI1rymC0O1sdBxIY=;
 b=ipDpkfVHNPMbXvXbo47Bg5wI+mvgs4EQ8uJi12DKwt6Vs5lMugcEtBr7xA6hHHDUfQ7UqyBw3Pm4TqgeCXvo6sPp+hqro1T/wdsihcc7NSOsdiX/YUa9HVwRNR3lNOLQZjYHyrjK0oEfLMMGL53XcY11apyjkj2XS9yGmGpeGCDzfTIvgFQYcVaYXCh3YUIrxufY/QeVihniXEvkqm11eJi/a0oVb0ELC2CJQOmFMgrG9ieBJKcHvPDa0G7WzHR0S2mff2y1UG6Hn80LPNwX8iT0h+/+onE2LXiHnsTUPlKIuKJZM5ug0rN7xO2ACVCk/dV5nP1hrR72tC4T0QOVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwlAL8uXhX4mUiwQbHsvxxOC7qBpI1rymC0O1sdBxIY=;
 b=V1NN2MhJObgxyerd+632GcSfa1JSJALy96g44Xps0B7xTIqlp6CsCw6hS6VxQY6QL5pg1EsHtvwxNI0KE3so7+9QT28Amz6aRlnABdN6K9L+elvdQNfv81jxR8nsSy+Zcn6cShL0keWI2o6mCk33kboG2Y1ElQvOhVCu1gIWw0I=
Received: from DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28) by
 SN6PR02MB5469.namprd02.prod.outlook.com (2603:10b6:805:e7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Thu, 10 Feb 2022 11:28:45 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::5e) by DM5PR10CA0018.outlook.office365.com
 (2603:10b6:4:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Thu, 10 Feb 2022 11:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 11:28:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Feb 2022 03:28:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Feb 2022 03:28:44 -0800
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48874 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nI7cx-0000UP-VH; Thu, 10 Feb 2022 03:28:43 -0800
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <laurent.pinchart@ideasonboard.com>, <ben.levinsky@xilinx.com>,
        <bill.mills@linaro.org>, <sergei.korneichuk@xilinx.com>,
        <tanmay.shah@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Thu, 10 Feb 2022 03:28:20 -0800
Message-ID: <20220210112824.2084724-3-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5feec14c-5753-4489-580e-08d9ec887f54
X-MS-TrafficTypeDiagnostic: SN6PR02MB5469:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB5469C6D89CB3091613BC4C8ECA2F9@SN6PR02MB5469.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW0a2ioIZBBYmE9A5UTm5iOwI0f1RUiwZdE9c8YoXANlCthJ9GE1FyQLWadFjptyz4TfSRRtMij8QfH/QPBj5y0wfOEo56epmuAGqTskv5jGX1WzFM+LNLDNOIYaiTNm3a3HkxkEzGU0x+XQnWtFm68eQ1EN2xUVp9GEy5BKGb5Y49xp1nPMqNFnWUGKo+bnwgW7vjU+hzZWqgyJ2d2eW60uEf3CQG6WX88kh/yWv3Xjfa5hTBwegxlVn6daRhdC8c4iztp0YPrADAIHJr+IbxZjtwDspyu8++xLO2vyoAC2PRLmBRLjiJJHYCZNNl50Q/F2AaRJH4tiJ1BiI4IrVNN7ygr7fJPo8i0ayXIDXNhn740g58h96GzK+GjiZcRnf30z5Ui9OekFWW50+BKk2fR/7UHfmp4xlV/YOhrSN4Ao0T0fRurWKpOVNIoFTcJR0lqtobR2Xg0i3FVd3hkiOxNCKzpPzdudBT51PLubWigGECnwiXY3YASsFN9ZUsxRzyZbs3fjXTBZnqLnrn1fY6ZW/5cDGct0tj3ngKUMhQhVRXrpeAiSfLeENdj9NlRQAIOxeVas8oocsHWmv/AZf/G9KuZf2q3NAlUriA0RKtrotwx4OYxNuNUDv9WKbmRouXsrnOjUE/+p9GLT06kywtNrnVqqfqqxJRtWfhIhGF9VXeD9+jQRDO63R8X/H/SPTqhd3rLo8Ac75CRviQOScQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(47076005)(36756003)(83380400001)(356005)(2616005)(1076003)(426003)(336012)(7636003)(26005)(2906002)(186003)(70586007)(70206006)(44832011)(7696005)(508600001)(6666004)(110136005)(316002)(54906003)(6636002)(9786002)(82310400004)(5660300002)(8936002)(8676002)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:28:44.4639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feec14c-5753-4489-580e-08d9ec887f54
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5469
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

Changes in v3:
  - Fix checkpatch.pl style warning

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..9ac649a7b52c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -647,6 +647,23 @@ qspi: spi@ff0f0000 {
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
+			};
+
+			r5f_core1: r5f-1 {
+				compatible = "xlnx,zynqmp-r5f";
+				power-domains = <&zynqmp_firmware PD_RPU_1>;
+			};
+		};
+
 		psgtr: phy@fd400000 {
 			compatible = "xlnx,zynqmp-psgtr-v1.1";
 			status = "disabled";
-- 
2.25.1

