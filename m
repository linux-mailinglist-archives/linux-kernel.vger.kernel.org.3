Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF94F501B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840546AbiDFBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382329AbiDEORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45C160FC0;
        Tue,  5 Apr 2022 06:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfqsIMMfeC26reLatD9MokTwYecrPrj1vG/HCvzSOO2HrguiZh34GFZ0IWf5zdNDuR7+nGy5t5zpgv/qZmSnT8d/nsAYjzB9+fUTKTywZy9lX6nlAMjw0/cy5FDAjmuBO/oyawRjW8R0Q8OR9ejNZghJ/wocQ1QjQTgyuVDF8I/rfeI17JcbzaqL7hY8Q5obWj5sUz1a7dZKv+YKpcETCCJBhEZXHiWMGjojboTJLyX4ZC7kAQk0oYhgVJkekqdDh7m5nJZ08OBG/4LWYBqbmYfud8k0jPyx+wR/Y6jj7KmrSh2KHaA2XT6edoaFSAEYINcPcyohzKEHfSdgThDE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3P71ftXVbLa28033q3i+TL9rdfyovrIovSeQLq6P2A=;
 b=luBZZ6wkeYLJfT2ZdX4bNfMVm47U7nVaXT2WnshIU0AscnZGC1UrFDrB9vW1clci1GaeIQN5z6FYYymRbbFWzktkurPgLmotPJOi7Zs8YOFyoCI55VmY9ay5hhCF+ksaXJM9V2zCPzsM0Bve7r5Rqqdx2mWAJVE7GNamAsrtaSJaes2+Ik7CCT0u9V4RXRGSTBWHTB+OCQXGxRnhMwInBk5/pYZ302u9qYaZxMZCLwA7rbvMzH6yxIBGaKBV3s7NrUPegB2wDCrmPRzpwb0nP0bJEvpQMe4OtBU9fMn3MuDKzc93JSd+TokWt+GW42+03qlhcVaXECYCKpNQoVOEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3P71ftXVbLa28033q3i+TL9rdfyovrIovSeQLq6P2A=;
 b=J8REqfiQWsqQOhOwsZm+6N0lKqrM1ZeQSQJcJZ/Wi9UtAz2MJPrSAYmUtH6GEv3xBOiRjoH9YVgYOxdGwETwq9G1a9K/odhGWeGrnMQoW6LroGuCe/D6f74gqiEJ/Yx3TGDFzG4iIPrn3Gp6R48U4JekQ4u7LHPTROMNpJLUKZ1wqMTow2BtS0my8qDoj7RuXRLPsS2RKUDPeCXtakY4WdS+zHYy09w/8e5rMIaZ5PqkjcPDhdHo6b4KzPWj73+Sndb2j9ldSE0VrOlbJan9EIuiToJAtFe/7dEaksnwnkFULqOgeZz3ESNiXqjIKdfsNOaepJMHSp8ZuADijbxreg==
Received: from MW4PR04CA0371.namprd04.prod.outlook.com (2603:10b6:303:81::16)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:01:43 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::5) by MW4PR04CA0371.outlook.office365.com
 (2603:10b6:303:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 13:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:01:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 13:01:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 06:01:27 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 06:01:23 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v4 0/4] Tegra234 cpufreq driver support 
Date:   Tue, 5 Apr 2022 18:31:15 +0530
Message-ID: <20220405130119.4697-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9903c4-f605-4ea8-7a23-08da17046ec7
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB574482380735D416182509C9B9E49@DS7PR12MB5744.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npBzCHpycYkXM61lBIOplqHuVkOoYDAHDyPUZdJbwLBySHEagV4TEia0kB44lyHl3npfwJBtahYP5pLcjYZopvjlwYnyETM+I71fhXDlDK1wnDWlxsJMXRrcOUrDhUozLyTGeLuT6QG0EW7CBgHT3I2/CmlOxjKg/CVNJViHoMeNy5bvMxeAT6t7z865DGHb/28ajsqcRHWVB/RI1hyPe2pbqjd+69oyOuFmE/vQWdcXW326rMclFte7J1wwOQT4MiE9oZ2TReoNfpW8FiBmlMLjfb4gLiAx3gODnNF/eM5OrYkDK6xP8AeCYfQ0pqLFcx9hJbWy6T4Dg76L4SehiactXCIk6sEhklNmIz8dsI0ks3ptPWKf8qKXKGDebtEmBKyeReZK3VJcKy0ZL9mfOuhzbWUt9MMF8UBbH6lO6SMSnNcLI8ztJRjolJNET20JyAChKFmeAOy2wwj18N1VAW8V7wlD4fhYUeOcVheLW9m74jRFbZk3Ro+dQjamfaRx0vFwUk4x1Xb28d9C+hXP6qzZu4Tgca3LsxB8P60OaZOF3Xeb1wIDQ1I1ZJDZWv//UrE5dj6rcbrGr4Z4m2lg3IxVkLgvJuDKULb9VGiArqhOvLy4us4gu3PAufhRpqtQMx56FBl/tAApyqdgHldMyGqDPBNF+04eXCNSN0xywQfCGJlZHapynRCn5x+lSY8D0dsn2r2vKLDL8K2AIF+4AHIdNguP2Ip3JDfquREl4yo=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(40460700003)(2616005)(356005)(921005)(82310400005)(83380400001)(4743002)(54906003)(1076003)(81166007)(26005)(36756003)(2906002)(336012)(426003)(110136005)(5660300002)(86362001)(508600001)(8676002)(70586007)(107886003)(4326008)(47076005)(70206006)(7696005)(6666004)(316002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:01:43.1127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9903c4-f605-4ea8-7a23-08da17046ec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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
v3-> v4:
- fixed reg property too long error and set additionalProperties to
  false in the binding document.

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

