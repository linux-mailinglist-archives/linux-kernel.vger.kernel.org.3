Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF034F4825
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377133AbiDEV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382116AbiDEORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A5160C17;
        Tue,  5 Apr 2022 06:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i28ISAFOCCx0/+cUsremgSY/kxc8nCtOXYFm6X8bCJefiOpXVEuSPlVqvtFZQEamViFkyah67sfYhhLFiVeyx186T7fKrxn8yZ4c5y22vBNhkNpDmIJYWjFEaowUuDAQSJKbRYj856C3zl6OT89i2j7Sv6Q8udkIMXBAFf2oG79QoKQLuxkTQyfmvl6bH9jW1vAYOS0kfYQNQKJqpdNBzUvt6SxvYOkClL28Dypp+9kt6vS9esLPSVJrPFDielOnIlIESbtkSNU3y9vF8TVgqyAc+K8DRN2lNe8iB2UsE7QnPqqbrYwfBydcd7Wcwy21vB9sTKOdUHvqjs7PYri8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8i85DJwZtncqEQZ7TEeTjmCCy1RYwOdgyHXoXJi82s=;
 b=VG9oXDRQCBqK3LE9IC1xiFkuW9rXSQbj8iFd9jJmEzK8qVtaLe695PwLfA8z73VIJfQhKrALEZZRhmwSIVPCBew/Uvhu9XdT2V3XTfbRMSvuzTm6/gk9kOAapCT4YYP4j2TxG4t1PrBWgese4At9WUcYBKbrOVYJ31Ay9kvXdp2+CGM2pULd5yWz+xLjv/c/QVAIu7/sToRsofTQtno+ccmGqWFsOjHgLCMYxfPOkFOHSpA1886DtPhV2iMaOwQR84QiimWNBJq5DladsjmQzuIDB8DwjENqoQfZwNqmIF4yGus4duHMHe0YQZCnY2cU0utbkcpliIvy5aS0Bj2JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8i85DJwZtncqEQZ7TEeTjmCCy1RYwOdgyHXoXJi82s=;
 b=RE+g2f83Tb2ESmhK+Rs7D4bbXOpX2h2XtBh5rUtKYkmLaD8HCvtZoZ2NE9XJkJq9n8AC1CH3lK+sDsDMOiqDpU7BuILz4uZVyM6BaIth+++ZMxC/BEqATLJLT+rKrNjTR5QBd/iGK/r4SuEV94oFGxyy02Btp6b+Di5UC8aFP6elWnWMtcqqbIf1P5gZxXAd4BSMAPWodIwdOIKFNhSTLIVjv/9vq1Mqj73tGc/On/Ab3HA+c/smZ/X4+b8Cf24/nst07Lhe/YlcDdXvQHpK+E4HTsRGpwpduqlJ8PFD6PJoeNdSQA3PBK7weErhsMeHAqjLjsNguruasbPHo+NtWA==
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:01:34 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::46) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 13:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:01:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 13:01:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 06:01:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 06:01:28 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v4 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Date:   Tue, 5 Apr 2022 18:31:16 +0530
Message-ID: <20220405130119.4697-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220405130119.4697-1-sumitg@nvidia.com>
References: <20220405130119.4697-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b993c35-5d0e-4316-149b-08da17046932
X-MS-TrafficTypeDiagnostic: DM6PR12MB4975:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4975BEE00401C0AD6347F8A6B9E49@DM6PR12MB4975.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zarHcOz+f+dF4Jx70JmICFPCYnnvo2AmENjgPszZoBD0f5ne09e4WXfRfOU+C1cfFJWbERrGFTA6djkkxOXr1n6VEmkaaBhALNwdO71w7hqz/ZnR0NHSWVFaljvG8Xz2nc4ZrJQYLApTwRTVIyoDWqBa8pWGBRhdQ4YCSG7dRfyn/n67VY6gBMu+W/rRJ2uGM1HPDidvR1FuBH+EoJ9J+DEYbi716kKu+eK71hOXSdbljNY7fxY/pyoKzRz2dQayfbmvOfZy9mzazNbhTCCeYmFUkR0tfoVgzJ7OMPI+QhErN2nrZCRF0rUNymxftKWppD1dDNhhsQaaR1o9ntBrL2ebyFPYd3FMIeiCBzc4DQ1v9yMVvGyh0NqAxXGGyySMGweluK1gXzJ+oW3+3W7RCsPBv6Q1HgPyKRMlB+VMwgkC7e+y2/STZnPXS41oJqb9aGmxdkToMBVDQjUTRlcy9v6i1E8dJ3jrXKn0RlNgoVbzYtO/0P3yUKRlHGFiTvj5zRrt3mdZt3AgqutUurX52x8NjPx396dQ7MLntaQF2dphVRz5hemdWmtL4c/dujsyGnjfQrx+N6+TwaMKRIuAjvn1u7zQ3Nk4/nRXEr0wBZDmzwisoyJOLX3OUx3txMBMILR7+rMmw8tcBB2waK7tdn570GsKy/pH/i3G84JGzP79rebVigDyootXpYwYHddQiaH654v6UX7GaxH7xZFUu2tlq4V0i9YFiYds5Rb/lc5awCkU4v0x2HKwnA5MG3droXv8VdOK/th7LFVf8VPjjOTUHgRgXHULB4jye5BzChudPcceR/V2jguzm6e61Uv+e4nRctpGO13uSl8KZ2bV9mi9jBAFm2m8vkKUKNnMLqc=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(110136005)(70206006)(70586007)(40460700003)(81166007)(426003)(336012)(82310400005)(8676002)(107886003)(2616005)(356005)(8936002)(86362001)(921005)(2906002)(54906003)(508600001)(36860700001)(316002)(7696005)(5660300002)(1076003)(36756003)(6666004)(47076005)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:01:33.6981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b993c35-5d0e-4316-149b-08da17046932
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
registers that initiate CPU frequency/voltage transitions.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
new file mode 100644
index 000000000000..8c6543b5c0dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CPU COMPLEX CLUSTER area device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+  - Mikko Perttunen <mperttunen@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
+  registers that initiate CPU frequency/voltage transitions.
+
+properties:
+  $nodename:
+    pattern: "ccplex@([0-9a-f]+)$"
+
+  compatible:
+    enum:
+      - nvidia,tegra186-ccplex-cluster
+      - nvidia,tegra234-ccplex-cluster
+
+  reg:
+    maxItems: 1
+
+  nvidia,bpmp:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the BPMP node that needs to be queried to get
+      operating point data for all CPUs.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - nvidia,bpmp
+  - status
+
+examples:
+  - |
+    ccplex@e000000 {
+      compatible = "nvidia,tegra234-ccplex-cluster";
+      reg = <0x0e000000 0x5ffff>;
+      nvidia,bpmp = <&bpmp>;
+      status = "okay";
+    };
-- 
2.17.1

