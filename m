Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EC47C00F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhLUMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:54 -0500
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:33620
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237854AbhLUMvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkWb9XzWmtuz33VbjdGfR9QO/kTzyhg2QjR8nJzpXBvJXbbW8pepSJ9HIFxFeJUju8grUVnkuLM57GN8miDdtWuDJajam6Tk2xyPfzi/4i15Uusylq7LC/uiklhPOJNYDStsE36m2Ea3Gr0B1lz1gR/9ua5t+1Lk8XACe9/4VPc3KXcfNoSL8oETmbwQc5rWgBis+AuB++KSOCwSgSHxNZvB7b9tITO/tuL+jRok+x9dgr7fZvY1hGXQZ0YFUvF+FpcE1wLh3f2l3gOOgMeQTn42fZQx/JQpvY5bQqpJt9fZhJ4nbMO3re1lHvl//BnETWf9rVx3kWdTSTU9X5kbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=ZL3JxD3mSgSaze72LQV1QjOxOy3bNMmorkNOjAUNWWv4aBP3SYXD2XHrq0RGWByhWrDWmMhpRJEplwx0F0dpDaRy+y0VmjueS11xJ9CCDyErazSO0S5QRNOL0lnfMq4RGskk0zOz+FYJF+5k+DNyZT6l/Uj21hS058nBhWSmrUi6AxxNHmUUcmjir3mWZJDJHXQttyK+gE1iHKqN/oNihtTMZhaiISI2lOjQDQWlwjw1itLYAPSXppB/kHK8pq/hpa5xFbVPKPz6Pjpcgau7sXeup3itH5JJdrA5lFwXZVgEtnO+bxwWfCmO+zndiO48YlmAAoIdTnc58te662Tt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=KA1TZKaZeOuGlXHxRO1NvlErt+3+7IvK0NhXPE5LCm5HUDIZWYVeSg91t5eBQEirl2yreiEkfZMhbQJb035RAwzrpkUghaUO+BlAgn7jGjZfybQGmxsdQuCgrUoPlWRjR9Bl+mF20FszDYyjLQu9ZBDB6tjy5iDxNnewyJ7VZ+OyA9A3jmVxHVK/Skz5LjBTUO2P5erZ4ZYp2+hTzC5lGYvuvN8JTpxypyRUXJYPcoenwm1QC6THT0/MFQzAJ1DmMnIZ8OjC6kCMCFUO+rizNUJokMtKUt8RII02vNr1F7kygiXTxiMjPvBN0kUP3/XVXlLf+Fmj7YXlsa35rlLuRw==
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 21 Dec
 2021 12:51:48 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e6) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:48 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:46 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:46 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:43 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Tue, 21 Dec 2021 18:21:14 +0530
Message-ID: <20211221125117.6545-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9cb1bf-d5c9-4c5b-c31d-08d9c480a6de
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5485:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54855069B95E96F5937E276EB97C9@SJ0PR12MB5485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdIhS087ExJ1yZSNr8Z0C2XEXvfDu/IoLvQJVBhJiaekeX0hmvKxgg9cUsz3?=
 =?us-ascii?Q?UVv1UxahzrsTPba2tik3hHXSeCCaSoKaaRL34aOFpsTWAv/zjO4nMl+hmm/O?=
 =?us-ascii?Q?OJPFpEuP3exbnnLIJNUUr01jVfeDRAoisJRmqQgv48XwrIvj9vLoIZklXf9H?=
 =?us-ascii?Q?THo2rlL0ab+B6fr1dZlxalGiumNQGrOOI1JiRcz7slYeqaKCpY0CEcug6VaM?=
 =?us-ascii?Q?brSmQ6yToXqT9PPkT2KmA3/piWuiGYHcL5rYhRod4wfmj6e0rseE6O2YwaEE?=
 =?us-ascii?Q?WfGldyfnhDRV4gkRHtnw+ZrBmlzJq80JtK3gZnLkPMrLI2ePaIiP8dixkfKO?=
 =?us-ascii?Q?GXTdPYLFDRZJuU2u3E4xEkDlZTUr2mhFG3K6Ptv8xfMYAhWAwhz+lUG8Y1RB?=
 =?us-ascii?Q?vtQkAkhwGvxzlYZwiSTiqD3gzOqG8SklDr6+9cvqPg23TElCGvjpZaL8gKny?=
 =?us-ascii?Q?uUeJ0CSZGauVefJwMV1SU668hs6shM6j5YG6DJOEXqhTQek6152jkcq7Ruwh?=
 =?us-ascii?Q?jvrHUHBoIGet13vV4VSFpaBUIs5aPjdzfgFyxhCNcF+0yfgfXoe22WSqL30u?=
 =?us-ascii?Q?2b2bkfc1Fiixu3tJkl893NizEK428liISYBHfIjg4DBXoEZqLuCIdD7YQM62?=
 =?us-ascii?Q?8eFMmfPj2GaK1BPjRoZcYI+f8cSeOFpwm7Zd/t1dADUNi7cbZeTP4DHyq0D3?=
 =?us-ascii?Q?ZN3k5w5SPGZkheqPKNXNuNHAvEWuWB/YYexEPMIuWzqGDbHFwKTVYws7Lxqu?=
 =?us-ascii?Q?EqqENiJRlWAaMNZ4Q02PdlEIE6RUbpghjwbYP4Fkg/IBBFkZJlRr9TB2LDj5?=
 =?us-ascii?Q?TW6Tdq/lbrob2biKyFaoNWO0JR/8LMhFAd5YQZyPd6UcPXBCAeQbv9koApJD?=
 =?us-ascii?Q?PaZyyoZBHz4BLhcwAdMdvt3a1NoN6T0ZGZqPOgn1RxMKWxFmEWmrG/KTcCzU?=
 =?us-ascii?Q?J3qIBYCBvSae0GQkXK67cA=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(316002)(83380400001)(47076005)(336012)(7696005)(40460700001)(4326008)(356005)(8936002)(8676002)(82310400004)(34020700004)(1076003)(5660300002)(508600001)(426003)(86362001)(81166007)(2616005)(70586007)(70206006)(186003)(110136005)(36860700001)(107886003)(6666004)(2906002)(36756003)(26005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:48.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9cb1bf-d5c9-4c5b-c31d-08d9c480a6de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent CBB2.0 (Control
Backbone) error handling driver. The driver prints debug information
about failed transaction on receiving interrupt from CBB2.0.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..fa4383be19d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
+  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
+  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
+
+  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
+  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
+  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
+  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
+  interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses and prints debug information
+  about failed transaction on receiving the interrupt from EN. Debug information includes Error
+  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
+  etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
+  exception error response is masked and an interrupt is used for reporting errors due to illegal
+  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
+  compatibility with PCIE.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra234-aon-fabric
+      - nvidia,tegra234-bpmp-fabric
+      - nvidia,tegra234-cbb-fabric
+      - nvidia,tegra234-dce-fabric
+      - nvidia,tegra234-rce-fabric
+      - nvidia,tegra234-sce-fabric
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: secure interrupt from error notifier
+
+additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-fabric@1300000 {
+      compatible = "nvidia,tegra234-cbb-fabric";
+      reg = <0x13a00000 0x400000>;
+      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+      status = "okay";
+    };
-- 
2.17.1

