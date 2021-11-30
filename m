Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFB462F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhK3I6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:30 -0500
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:57120
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239904AbhK3I6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo4Ux+b1EGLPMvM85DzB9SNHX09bgzg4fWYM+tvd21YNaTphCAspD86qRrBGAhNCyegTG4H4zsmuoJ9ilxOqcf+NqgV2fnYY6+APFalm70GpoVB4UovYqaTvbgZm8jBsGuETLbuWAJCo0q42mt/gT/UylbX4r3LG26T1JCIeelVwuMzAXZ72Py7ItGUR3nO2lcWF3AXLRiVa1OkaPQXn8O6sHYvhmm8vVpkmoqtv58EnNrSf19OzFP/6YxJ1p3kCheZ0kq0tB+XvLFvqiIO0luKP8FlZWnhF2k0be6zkQtpJLao9SWx7yhQQmtULSA7o/iIuWUfDzuAfC8JR1pSCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze6WcJmkN9wp8KSPFGSjWr94sSuCPpVcCkDngb5vXuQ=;
 b=Ic6Rt0OxE5ZXCOtgOr0Uuh3QrBKr6BQxWwK4d6+W6tWQY9e8p8AIubGeiewECkiZB3b4G5U8s5Woq6gKSb3AD2mFC3va6zju9Zq3ojU0rL+MtxzO0ly0XA/csKrQYTmH4/7Js6RuFrf8l1SKzfJkrVagiHHHDSNXZ3ks4z6Y6iUdyR6MvlzxKV74XvUoQPzkhQbWPnVBwMvcbEMoM1bt7ip7ycOg2hVSvePs9cXp8+k9IgUQYjiVi8vqkolnvGjaVtO85EJ+DMnMzxHgSvWRQmiqi7ecoo6txtCmA+NAh5rme0wB6I3HGRAvQMtXwWNM/tGIJvV8eRpcKw61jNlLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze6WcJmkN9wp8KSPFGSjWr94sSuCPpVcCkDngb5vXuQ=;
 b=NcFRUOLFi/fgrOU3NeiGHPOj47n/vWCOuLubv/WNAGVEX2qCgfhWxOfuq+YHeVXtnd9XfFxmNG+FXTAoBWXhk56ZRad9sP3XpisatyuWWg120DZo1zM4URMsi4JmJ/uDp6Ib2ux6SZuPri52JrR1oj9SJJGBufrTo1IDMgQTjhQ=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by PH0PR02MB7463.namprd02.prod.outlook.com (2603:10b6:510:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:54:42 +0000
Received: from DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::e5) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT017.mail.protection.outlook.com (10.13.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:41 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:41 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuO-000GNC-U5; Tue, 30 Nov 2021 00:54:41 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
Date:   Tue, 30 Nov 2021 14:24:22 +0530
Message-ID: <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b047c5e-58c3-49fe-4012-08d9b3df0d26
X-MS-TrafficTypeDiagnostic: PH0PR02MB7463:
X-Microsoft-Antispam-PRVS: <PH0PR02MB74632E2B8C5C250B899AEAD5DE679@PH0PR02MB7463.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKjm9LBpX/hkw64H/OijNE3uNR0Bnk9HQRyTEvuWTXQv6zO+tKP3XtzklN3KWKjZtJ2/BjTOFZENZP0B27Ag6q8s7guSPMFn8NUR0U2FJtXahMGfoHHGL5Vfnmov8WPsvirSEvNcNASINg82f1a4nXt+A95xrCJtauHDTIcMsTjOenD9SvWOB5Nc/sqdu/fPlA9j6SgFLJVcw7TynXpQNsWNjhvg1iwZ4oWpfOggGA1SeSi9Oe9SHQeqgBWal1kV+Py6UlK5XCOOvKQGF9LKx9WqbRJjsHofIT4M3UGeH0KrsJLAwz8+N7KaEtfgmYL0Xa/DSvdJpfYFT02H9kUEw+nUBDycpQQUnqxR+JWAJweg9KLkktLSivF6AdpO6MSYRz1X8+GnSeZJlS6+WuUDw2oxQlyTeXJhs0vgZoDYH6VjZJwpIfW9u4BHmErMvRKzi7Hw6LdB5BLoZ+DZ5Efqsw8yPDqKp91CZYUHACBjp0sOqhBRvb8IFZaMLIG0oLyiWJKK9j3Ywz/7QBa54xRkC+DHt3F0/qo6AaEQzyfxG9P7ei8FUu9P35qdFZAS/6Gr2byzk9VXXLxJeCOQlb49bopNnlSaPIoo1CLf75B7F+kSb951ccdZsWmQVL5vzuAXfczsPvIE/GpcAO62+8vrNHqyXq4XC9lKwmoF7UwQT2YL4LiyCov2+69Lnfiof8LZ2wD3WT0RRXJR3fMQU2QTh5YRsdWAD0/HloujKbzkYTrmJ64OycjvwGxEiJeyQW4ov1G34GmGDIY4rAz63si8WS5y+Xx0BqgeiF49E3sZPTVMLdQeGYyL5VMJGoW95XotfPfg5T2NX+WJ20PR06Uspfmoum/FH8yTm/uNu89oMNA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(7696005)(508600001)(426003)(186003)(26005)(336012)(47076005)(8936002)(9786002)(6666004)(36756003)(2616005)(7636003)(2906002)(5660300002)(107886003)(8676002)(316002)(966005)(36860700001)(356005)(110136005)(54906003)(4326008)(82310400004)(70206006)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:42.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b047c5e-58c3-49fe-4012-08d9b3df0d26
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation to describe Xilinx ZynqMP SHA3 driver
bindings.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 .../bindings/crypto/xlnx,zynqmp-sha3.yaml          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml

diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
new file mode 100644
index 0000000..45a8022
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/xlnx,zynqmp-sha3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP SHA3 Hardware Accelerator Device Tree Bindings
+
+maintainers:
+  - Harsha Harsha<harsha.harsha@xilinx.com>
+
+description: |
+  The ZynqMP SHA3 hardened cryptographic accelerator is used to
+  calculate the SHA3 hash for the given user data.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-sha3-384
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    xlnx_sha3_384: sha3-384 {
+      compatible = "xlnx,zynqmp-sha3-384";
+    };
+...
-- 
1.8.2.1

