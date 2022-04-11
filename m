Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B90F4FB8F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbiDKKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbiDKKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A4DFAC;
        Mon, 11 Apr 2022 03:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0gTXIxvbrfoFqKkmokdyC6ObD3uTmAZGbLWR7TEcSJVbz73TXAiXK6Z2R84D9BQst3TCy40PULR3+Sh5kpPrMTquVhvwNHXrdMSRwt3mjucB6B1X76/G7FwCrNcNAVTVdzDfEOecfWVC16q/6PXw9usiKwKq65y3K/gZcHmxdyHcQISrcHg7HQMOJajzAf6LJfrDpzofFw/XiXn3Xy46Rk3TbILkXsQyEGajfoFVLhU9ykbndZptN3y4awXdYKp73DQYdpauuluIjOqyYVA+lNrBPabWT1OUwiAoSgwwPUKW0f5zsLQm2ns+AigZkLcGLMj/AfXXy+i0zO/xUeklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLTs/yH/omQ/+m5FhT4GbTHTIl8DetDvfEBtfBbxQw4=;
 b=aEm5XnxGiKm/pmOdZWEBozuTgM9cli2bLpypT98gmgf1Qr9R4ZEUSE3umihtjLXmGPG1+NqOltouHhuIN1OGyaVK+IhmMgRVciLjcmk9cLzbHj1TgJe+M9BbklyK824Kdk8VLL55R8GpbnY3ehKv3gF00RvYvQo9m+YwW/TXtbKfyZqejLaMPjYvW5UiWMgKJRkE6LCxhZGmR6PHMrmbfK0wXOJ1ikSma6aiUmuWG5FUKQOFBsMtTvqmT7RFgVajP18PRrHeQ3FmdRYwjm2Sn9+YDvMs2C+n6xyr6Z2ZexBICy65ZZHxxEFfwf2dq7Q4HVNFQFnL9Rl1Kqna1x9vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLTs/yH/omQ/+m5FhT4GbTHTIl8DetDvfEBtfBbxQw4=;
 b=WEuO8TGzGDi2zMTcSMlvI3XMzGxvf9iyApdxqYlQlDv6ODqTBqMueYpSue8dWh0OpPrB/lhIdAvMSMeXFCR0H5zcHciju1++KelM97/HvYPg0BDeYzlPZ6d1RyUgi9PE1kgrZdGjB6tKRW8C5DTTgQgVOLEdkRZcjj/P78566tI=
Received: from BN6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:404:10a::32)
 by BY5PR02MB6212.namprd02.prod.outlook.com (2603:10b6:a03:1f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:04:51 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::20) by BN6PR13CA0022.outlook.office365.com
 (2603:10b6:404:10a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.17 via Frontend
 Transport; Mon, 11 Apr 2022 10:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:04:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:04:50 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:04:50 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndquf-0003Jf-LI; Mon, 11 Apr 2022 03:04:50 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 1/5] dt-bindings: add documentation of xilinx clocking wizard
Date:   Mon, 11 Apr 2022 15:34:39 +0530
Message-ID: <20220411100443.15132-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 750e4e5d-53d9-4a58-96f3-08da1ba2b7e1
X-MS-TrafficTypeDiagnostic: BY5PR02MB6212:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB621223970E418F666794C678AAEA9@BY5PR02MB6212.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7MwLo2yjY1Ljv4Sn/Fzz6ufgJd/a2sQgfpSC3HHwDluj/PSUmV0wTQ0UCaPiMlCmIHPCqK3sKZ2Zvr3IKbM/URMSfO3zipHet3bX/QVtO9MwRstJHBfwa2bYFZbUJvFfNDAaoCN3jUrk4Ex6NhL849Reu5aEF1zsAzASon1UAQHMywZoeHCvqtoR1VeAZiBiyNiLgyV6Bh+uSUWq5aot+wxyxoHoLTvbuYGFSUKOVJF0+ScEv6Rq1MyG/FggxmbttU78kKJ5kYWx/opBvVwY9g8MzHN1fDR6eD3OPk19pdhUaDLWUuEugGTAw2RQG7Q8PkBq8YhpDaxieN/7ecXrE61HORczXc+ZcOgi6V7swAeH5FYV88KHwHsNKs7plV1rV7S2XpFsA/FZr1EqsS1mGjTIxIzJ9fpRZ0BjjTzGDKb+WO98OYc7Is7lmrtQe/yYMsobTwuPkSqCgk13Js7O69hzVi/xq6vdaiV03v5DD/b1307CMkyniIXP5YtRvPWksJff6KZDc8IqOhI/CA1ZpmjFY52jPJL70NhVE0S0C75O/fyLcLTN7mRa5xxsZD87WMQ9KE+75CIn6RKIX3ZWAt8BF5I+u7ipTAOZmjTesMdxeYi9gIr/GMp2vHkcPVa5/OI+BkDd+74E61lROB2Vmr2VfDALoC4pGrUeNYnCBMkxl7IExHEbPPsy54oyUjNcVEFvJztEdaqt9pAOlHYzh55NbN+HkdBF9h0kXBI0IOeYXUeI45PP1Kh5AVFGYsJnGBTRcj4iF+KGb8Z1Qvyqm4mt5HW37Rpz1pO1sx9LTC2MAbc+LbuBToPugoWBTALx9R4wphZ8sncvFnDxpquTA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(426003)(336012)(40460700003)(47076005)(26005)(1076003)(508600001)(54906003)(6916009)(36756003)(82310400005)(316002)(2616005)(107886003)(7696005)(70206006)(83380400001)(70586007)(6666004)(2906002)(186003)(44832011)(5660300002)(9786002)(8936002)(356005)(4326008)(8676002)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:04:50.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750e4e5d-53d9-4a58-96f3-08da1ba2b7e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree binding for the xilinx clocking wizard.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
new file mode 100644
index 000000000000..634b7b964606
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xilinx clocking wizard
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+description:
+  The clocking wizard is a soft ip clocking block of Xilinx versal. It
+  reads required input clock frequencies from the devicetree and acts as clock
+  clock output.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,clocking-wizard
+      - xlnx,clocking-wizard-v5.2
+      - xlnx,clocking-wizard-v6.0
+
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    items:
+      - description: clock input
+      - description: axi clock
+
+  clock-names:
+    items:
+      - const: clk_in1
+      - const: s_axi_aclk
+
+
+  xlnx,speed-grade:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description:
+      Speed grade of the device. Higher the speed grade faster is the FPGA device.
+
+  xlnx,nr-outputs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 8
+    description:
+      Number of outputs.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - xlnx,speed-grade
+  - xlnx,nr-outputs
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@b0000000  {
+        compatible = "xlnx,clocking-wizard";
+        reg = <0xb0000000 0x10000>;
+        #clock-cells = <1>;
+        xlnx,speed-grade = <1>;
+        xlnx,nr-outputs = <6>;
+        clock-names = "clk_in1", "s_axi_aclk";
+        clocks = <&clkc 15>, <&clkc 15>;
+    };
+...
-- 
2.17.1

