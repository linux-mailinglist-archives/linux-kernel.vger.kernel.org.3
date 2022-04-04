Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A04F14A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbiDDMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiDDMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614813D38;
        Mon,  4 Apr 2022 05:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHLLE3SBVUaqMvzg8UWOwlax61Gymf28mPZxlqB0D+oPHZZxzjzjd3SQeoJqWwLq9pQS9xLlST+rWAzoF6iQRPIMyZlH6z2NRexHt40Aox1aZ8mgHPcll11Na30lg9o4m7BMsqv7PO56Uygh13VPykNiOhydRkMIMhtT0ySKqQ+CyCtFVnwd/wRkQIADScxQUOX2/orjuWlPX3R1wsFtXwVXSVT+16T6azcbI/4ah4GCRz+XWuKPOGfyCltLrDauBF6QtBnfo9cjMdJw88ntPnjdleRzzxC0Hv1W86NvX+oZqGWZEF3LxUlCwzzeR+h9ndDMI1RDlQT7GirzSHvf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp4U4Yhy9GvwQwN+tXguWiy5VKS7LxNgvEy+aPeM/fE=;
 b=fW51bFCWSA0qjceJUVlZWxfJhkPoEkZBhg8WAehakzOKgJdKsBfW0KUXfFsPwsvflHkISEiWbV4kSIf/UTjxfgtS0UH6ejh0D47PeEWWDTOtxdVeq/cTp67iBEzRdYMZaOaqow0/spRjiu2Ch+IFiI8BcLRo336meOznOg7YZYEQkKjDe39ZwOkbq3uNg9Nz94wbrjuXUWDoUEc2Jc/k388Yl9POKSnjYoYeyL4CfR0jMUlizYtB7QOu5kPfDWXLdcZq6fJGbrDbiHKXr57q47AKC0yKkV/AOnAqlO/a0XJKlPRVh8OuFKem0+F3zq35/SSNdXN5i1Z0C8FKckejuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp4U4Yhy9GvwQwN+tXguWiy5VKS7LxNgvEy+aPeM/fE=;
 b=MDjAa0n+vLo7nmtSwF274ODWCOW8thBZHXo4yRMK6nRyycqFaqyzybbqrJXRLK2xqivQaP5KCexEMuuAeKZwlhgPe+u8Bc9MYwYk4+f4IdmO6cDacdaGQYLdLdEIDlJ7ob2f9irox8oQehurtkD4+Z72tNBgkQvAWIStqr9puAF9F1+WSA2L9C95bzK6/NyOGGpb/5Njle8gRT88weE+offbSOR93/Cxljmq7rocrZ576WKy5K6rwl+iR8PkiBMDHJXLMgjEqw47OCSuJuMInlgVIBpeZYEP/1wiDHg+ioFmFJQE6DmXZW8rZ9P9Zmm1A5eSK/cIjph4ECned4esow==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:17:30 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c4) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 12:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 12:17:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Apr
 2022 12:17:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:17:28 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 05:17:24 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v3 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Date:   Mon, 4 Apr 2022 17:47:10 +0530
Message-ID: <20220404121713.22461-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404121713.22461-1-sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcae15a-a4c8-438e-33d3-08da163516db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4298985DFFE5F8FF1F9EACDAB9E59@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBsEjE0Vnk5CjIZOyZhbmlt2dI04v3gqKmcHd4R3Wk6iZx9U3eSOWsFTfBn2lHWUa2z1fK7sXz20UcqZCxkIHdEbMgpCLTQ9NvX6huW7naLJ+PhFP226sogY+4SaLG+GTnTTz1TOiLIR2OajT0WE6ut/8XRh/1VqBe1l9xJxSvnYGxf9J/Au233uzLuGRIE0vfG3Ut1XZDJ/v63R+r4LmZtgRU1pxdV4cd8iJci2M7Lhf6j47Z+ccFXwIaO2MjT81qLkcIbgNIwljEiw3evOXABAZV9li4yrKTkGorOYj9NyC6NZXjqmxnlEX9iOKLq7u/3W9cIX2loAEIak38Yea3ohta0Z9wu3Afefk9zPaA8o0tuMkwxEXePDN1u9lIpwWPsygER3ZraqBnjhiA/C6nkEYN/xKF7afrq2wCM2krzEL1KdN5dE6/Yt6ojQCX7FnS30oFQDMj49MpSavjFbc8JcVRK3n7JPF8zikFHftVGbZ77cj1Zls3sh59kjRxskBRWtPpNkhBRdmHuziWeefwextkojTRLdXQ+D8fzYkXZZm39jJe581Cg/A38YdtdakHINPSFvY5SXimLEhKpvUYU4OREHxro57VTcdKrMd5udxXN/NU9E0N5pMBHZy8nwU+hZ2mBRMoSHTI0l9drA1TtPpKlHMrW4WXh4Q7/n6Wq9ZSnMVd4xbpk2exTRCMWFGVdqKsmARaE2sBBD/xsudqkrXAJpNUVJwp7SCCHbz3EBRlSecLKBo3Oc1dBIekz8CDX3jhxjQ2UrYu/CwRGnFQwdX2wh+jw8KCgGSJ5WiQ6DhtdQ2E2+hxlehtEGeP40XxQnQYrPV0YpuAayjhyWIgbk2Z/dlHvXneb2dFMWksI=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(36756003)(7696005)(107886003)(2616005)(426003)(110136005)(54906003)(86362001)(6666004)(336012)(2906002)(1076003)(40460700003)(186003)(316002)(26005)(47076005)(70586007)(70206006)(5660300002)(36860700001)(8936002)(82310400004)(8676002)(4326008)(356005)(921005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:17:29.7794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcae15a-a4c8-438e-33d3-08da163516db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
index 000000000000..d89457e0bd7d
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
+additionalProperties: true
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
+      reg = <0x0 0x0e000000 0x0 0x5ffff>;
+      nvidia,bpmp = <&bpmp>;
+      status = "okay";
+    };
-- 
2.17.1

