Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B954917D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiFMPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiFMPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:22:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B64133917;
        Mon, 13 Jun 2022 05:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMfmkFnzEOS1rQPrFiwSbvKQgxHWswgMN00HB2smGEBAbcYw25edbjXr+zqm5RYvD0UJ1yv0cGvHR/c3wAKGGf49f9pqVvwlXDalzwgvWVaUqnpk44P6plSNc/onHuC2b36vmWp9ZiY9hgy4FxYTRq7AFSh8G5zbYgLoCjthyxUujg9Cp1JsoZQXMizNO9TuTgCmUijRAKNGlnyMlXChNf88Lgw2/u0pHDjmr/Mz/beKso8Nj4BT2nWLxUNNL1Wn4YS3SKWmtNIdBJVis3zyQ0ly74sdj4N0OiJDr6Xjoo/NAfIs7HPzlTzNC3qyED7fEPA1vuNch9DgRjFhEk1EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAwtrkRFqb/GKinsHUzY3y4eLFpbZs6Eo5Tn/14+gFE=;
 b=gKV0bQG1y3sVzFUjTYBy9GQslbY0tFITtUTItrL0sZdZofgJBGJoDg7XpQLeeamI4dcLqODb8OhJuEoqy46faOClPltHfxluxX+p1cvUOp1OMDf5lSEugIrNEcjfu8KDOgsTLLfHMlQO1NBLSBSQSFGoyp2t5Odp3DT0j031pKylOX/l/JtHWo/LndhVh5972UlTfigNyOkj3gaWqwsTDiLqqUIlyevaNBDoay5Sqg56+6jVPYjb2pXf4PVMBW06xiueKDeRvJJF+fqB1FPuYbBqxGVX0iOoGovZO8WnbjE3pODGtDy+uM+XAG6I7stoIcjOVeS2O3pu1caC2dZjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAwtrkRFqb/GKinsHUzY3y4eLFpbZs6Eo5Tn/14+gFE=;
 b=HyrB8DOGsQq8ZshhEr5Fs/eGNhx+5f28eeAnpi2RE7UkvwomsRe7CTr3CUMHsATS29Ant1qjdr5v5GcxOVYyOA86Nvt2d9M3bjK2d0ZaUK/eoxHBkRahrYYpGY1yewj4e9ivgz58/Cm5NA4JeAwuj1EQhYzC8k69bquCm/K2Eto=
Received: from BN6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:404:f7::19)
 by DM6PR02MB5931.namprd02.prod.outlook.com (2603:10b6:5:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Mon, 13 Jun
 2022 12:48:04 +0000
Received: from BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::f7) by BN6PR11CA0057.outlook.office365.com
 (2603:10b6:404:f7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 12:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT010.mail.protection.outlook.com (10.13.2.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 12:48:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 05:48:02 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 05:48:02 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 balbi@kernel.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=39406 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o0jU9-000A8B-DV; Mon, 13 Jun 2022 05:48:01 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Add 'snps,enable_guctl1_resume_quirk' quirk
Date:   Mon, 13 Jun 2022 18:17:02 +0530
Message-ID: <20220613124703.4493-2-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613124703.4493-1-piyush.mehta@xilinx.com>
References: <20220613124703.4493-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d2fc54-9e87-4dea-2169-08da4d3af4db
X-MS-TrafficTypeDiagnostic: DM6PR02MB5931:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB5931420DF6E31644770F9DA2D4AB9@DM6PR02MB5931.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2McO8ovP6/SyaMXe5lkkLtALFTjCMEEMVQK+eHbylCqc6WfZ+6SRDjspdjc4hPfYsql+1iwI+ZT5CnHJ7AVYvaqU5X+D0cu1zWBQbqkauZmODhSANrSaV2hmFz8/k5z/jSm7YB/utUvgJdkltiEhCgYDfKPL4FoF80ZM0vQyNOMXKiZM/xESxGyFfKE5H1oeDWD7OIEzXQXN7GdfKF1zPUxJ9l7RBecfXGTqAVUFNzAENCzAXy7EPJrfuNRkqiu37yAiwoKmlNCqRv8VYW7cYGson8FQjg8/u4Go6G/NqbA2Lpoe2ffRA1P8fqZvpftIt81PJCYgMsGC0WVvf8XfKqf+Rvsv9EzmxlVQ5dzPDVGrgtH8tdbQeKwPVLgifSgbDLC3GYLkPBsAw4q7ETHH+sMoFoqAOlyniLSUYE0Roxes54xT3xDERfhfM3xGFHH+cJWh4V+0hVWXBL1kSwYkMds2Vxg6/oJM/iMsBjDMUT7R7r/7OXrkOS0k/EAstnMI7/IR/vBKQaiB9Ry3kRY2zWIIEVfkgA2L/r82VC677Eu/CPoDGVSQtZY6qH8Kks0biV5C+h7wr0ZcS5EesDQ4xZtvw82IiWkKxylf4lQnKbaku/+g9uDZy9AxougvKg2iA3+EELuiN0Jpg2P5xVR1xmfOwsPI59Y/0C2z47FF768eBGslP/7jWCbHyXs7uYLCldWZOf5NfJxP+wp1XU/+gQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(8936002)(70206006)(44832011)(4326008)(9786002)(7696005)(70586007)(5660300002)(316002)(2906002)(83380400001)(426003)(356005)(6636002)(54906003)(110136005)(36756003)(82310400005)(40460700003)(7636003)(8676002)(508600001)(2616005)(26005)(36860700001)(336012)(107886003)(47076005)(1076003)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:48:03.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d2fc54-9e87-4dea-2169-08da4d3af4db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5931
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new DT quirk to dwc3 core to resolved issue of CRC failed error.
On the resume path, U3/U2 exit controller fails to send proper CRC
checksum in CRC5 field. As result Transaction Error is generated.
Enabling bit 10 of GUCTL1 will correct this problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations after EOR.
This option is to support certain legacy UTMI/ULPI PHYs.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d41265ba8ce2..36fa87df57a9 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -234,6 +234,12 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,enable_guctl1_resume_quirk:
+    description:
+      Set if we enable quirk for fixing improper crc generation after resume
+      from suspend.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.17.1

