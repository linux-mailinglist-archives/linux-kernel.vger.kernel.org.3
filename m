Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674CD4F149D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiDDMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbiDDMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392013E1A;
        Mon,  4 Apr 2022 05:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgUqvJH4w4+P8oeQwcdjeWCZGIh5X2mpQpGguyitM8S7STbrB+O3hzrZ14/c0AejANJij85Z15WeCVeFrXAChndS9cb16JBNMZJ65/pIUdmMn2Z6Ke3d8doAmTZFsU8I4nYQuEEXRWn7MMO7r9VsjUdXjEMHgIFubXRhRR0j6IjI9orp91DCsfu8KxSgt1tWvB7O/cah3wXpovnKt+wIqYjQ+Q6t/ED3SL+iJxkmrKpPm+6WYARaoDO/PdUBqypIYPN1XCW4JAb9QTv3V4FY/titn0uLD5DPgKql+4qNnojwhZQifyQ7V2t0Cimn6ECHSwpj4FTcSBe23/R1rRhszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eArfy8qE8/R2h6+1Ap1uo/GO/O9rOYDIbwlsfjE9vg4=;
 b=W9lhySVn7hhc43MDsonU9yNgcBOssIeAQExpANsOZxb683/g0mW8xK5D3li5fY79CoSbIlDLgvj0kAsqpFsFgh01Ra1M5EQQqNO1qfBju6dLNn085A79n1H+mC3v3JEwBmEAX/No4xV+n6woIFiXoBoZGuMZ8bUYS/H21QV3ZQWRGUQJk8FSHUc1mO8ASgcU5yVHeWvqwPtScUJlQ6sTzH70elx1jX/czptMnWG6PdBfjfcNexHCnqtlwi64yUZoG6leARnJErm1vZCdQhKwsbpP2yDgIdT/me+J4DGnGD71sOCcQ3BE4RoVMVHQYeArRNGLs8BLjuPFXIVcMI/K5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eArfy8qE8/R2h6+1Ap1uo/GO/O9rOYDIbwlsfjE9vg4=;
 b=QcOyown/8mMqkZMwsyQfJ5OlZtHQz28Ud7/h25T9MlpCXYrv7dKqtqTlhHGEh89liKEYpssyB+bYi18wLGIrXObFC9bCSlGYy80B6eTsONPfoO82hEn5rlpoPCTyMol/DCc5bKkzkivD5pnLszwcLo4SpfYC9mv97sPFOTgvnAM3iI+Xl6dJdwBM2i6nCrk/zaDU0w7bGAcbhQ23YxvNPcKmYWDuUDOIGY6FN7yN6+ln3VLSMX372bEoSz+7QUK+8Qb2M1AKOJvZf3dGjLCJIRgbKe7LCUNiKDEb4u3ihTP+Lfpk1IMG9dWzTB2594v4HezRThbka8XXaxe9aSWuXQ==
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:17:23 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::d6) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 12:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 12:17:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Apr
 2022 12:17:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:17:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 05:17:18 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v3 0/4] Tegra234 cpufreq driver support
Date:   Mon, 4 Apr 2022 17:47:09 +0530
Message-ID: <20220404121713.22461-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39785a8a-6cfd-41c1-5566-08da163512ff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB435794BADCBA55EB44C89DB1B9E59@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsQBrXcR8V+PMFQweONEyw2wcdPkxIgp8stnQMswL240m2eK0kuIQBxGO1XlAbMr7JYo3q6TjUppmmxU5pEgnERWYYou7ubwVJ/o11u8399ZJPbHH0qpJVYgC1KvvN3wnOFjEtsoEmCSuFrrKCxYYXKIbmw7ga18VCCcg8rICJQpmRjm2VfMGOtsynVjkj/NZbqwswNDtaTzmSz0K0DcEyxLNQrcIwPBRtr7JDBxHPMXjoBxMBF7jJbLzpfr2BNr57W8c/mdyEeRBWKtyqjie0fBG/rpmKwX+DDRMVV5FYpLwBa6w07nqRE/X6sh7ioi7NiWptU7HqODSKwDLIoqwjT90tSv6I2KoniO9ukmSFHF5YwXvrcoiWzGcTp3udSZ3a+Yvr81+k3yYhR/yZL9IB6MCedO95J4HbDh/9dqWP9fm3x5EF62rugJqgbeScZ3nQe+e9MqBNrtcQFhbysTFOhW8O2NhOJAnSuQ95VfAHupZ5lOA4181HYRD7UyKPJ/pb4jOH5a0Jb5vH6diY8p+PlJzoz9wE/rkrGhB25U3S3a1rjdtXnXFbc/S5xTEWWlbUf8fhsBhlnLvqGU70TVzzt3D6X2zjjSj1zV+Qnu/qzWAFNl3UwjZDxd9E4Noz5ZcoDKDbABru6TmnVJLSQiPyJXhXXUMfi5+IRWtLI4oySYZ/1IFky07o9uKC+6HkIUmb+l9xwkPeGuhC/xGduHvZXWIXM1pxcFJAAICsugcyw=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(83380400001)(2616005)(82310400004)(4326008)(1076003)(508600001)(47076005)(36860700001)(70586007)(110136005)(86362001)(6666004)(426003)(40460700003)(336012)(8936002)(70206006)(8676002)(54906003)(26005)(7696005)(921005)(316002)(36756003)(2906002)(356005)(81166007)(5660300002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:17:23.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39785a8a-6cfd-41c1-5566-08da163512ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds driver support for Tegra234 cpufreq.
Also, added soc data and ops to support multiple SoC's and variants
which have similar logic to {get|set} cpu frequency as Tegra194 in
the same driver.
From cpufreq point, main difference between Tegra194 and Tegra234 are:
 1) Tegra234 uses MMIO for frequency requests and not sysreg like T194.
 2) MPIDR affinity info in Tegra234 is different from Tegra194.
 3) Register bits of pllp_clk_count and core_clk_count are swapped.
So, added ops hooks for Tegra234.

---
v2 -> v3:
- used CPU COMPLEX CLUSTER name in binding document.
- reordered the patches.

v1 -> v2:
- added nvidia,tegra-ccplex-cluster.yaml binding doc
- changed compatible check to 'soc->actmon_cntr_base' field of soc data

Sumit Gupta (4):
  dt-bindings: Document Tegra CCPLEX Cluster
  cpufreq: tegra194: add soc data to support multiple soc
  cpufreq: tegra194: Add support for Tegra234
  arm64: tegra: add node for tegra234 cpufreq

 .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  52 ++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   7 +
 drivers/cpufreq/tegra194-cpufreq.c            | 246 +++++++++++++++---
 3 files changed, 268 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

-- 
2.17.1

