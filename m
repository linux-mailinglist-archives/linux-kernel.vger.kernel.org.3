Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA14DB207
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356291AbiCPOAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356209AbiCPOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:00:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877F6543A;
        Wed, 16 Mar 2022 06:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqcvaeFwcvuCRpNc1cRiRk61DK1/eSKS0fzuG0lLLSg+KXVmO/de3IgUR67M71LI9zkEhyFYHp82+RH4z9EvG+iLffewIEvzPkZQlnQOE8FPyRlTrh0Rw678VHSOTL4TllVej95F1c7ThKdcsfvP9jvqHOLYjalVEQuw58EQ5VrSlzX6+IvGeRP0/kKOkOLY37VpOgfowRxPBfrHgri+jEgRLxTNgtfAYgCOzNVxogyAH8AG1vRYC30uE8Mw3dOCCVHLXUS6pCBGccxYUWtmmRDCc+H8doZoj8+SohKkbw167wnlK5aQ2Nbcow0PaQQQxf4WvwgFz7VrUy78qmj7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKtY4QpIi5R1l4CR9iSY25rzi84WqYjzvyStnU/1GMI=;
 b=TCnZfQq4vznto2qzbWg2gbhevnNlcqtxxHT7tknVDOByK38CMIBX9IGdSXC1D8V1oqQY1pC1e7fc7fKjJoH9Ax4myNL0TBB2CKtHFpwZmiLqCWAlCeFCD6Ha1fqyiOZEqykMfhyLB5T2vsbHvVJMZIrrXksoDdsP1dSEXHafCAcefcd4RkFqXGU4i838kxPDAZLdrhSbGgEG38+uGREV88sxet/4SOPEi4Emt6dWcfM9VhDlD5Iw8b9ux+qrJY1WXkNud6FpaHqKHGb6quHa1JcnwXeWQJbgFc+lkchd+VBLo9lZiIov3ar1Zy4E+m8HQ+2YCbpz/JgDPWXyuY2Fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKtY4QpIi5R1l4CR9iSY25rzi84WqYjzvyStnU/1GMI=;
 b=Vg2AZ4cz+bSrOoX36EKOSHEdbkLtlIXHCT15TpG06A938OkWIsHU5fJaV/14on6nGFCUJwhIiXsDqP1Me7EeXe7lvYZScwnjp3S4zfjJY/TixVrAJn+ljNui6ehRMCwrWj3I3ZPbUInkpWOK9Byxwx9ks4H7pti00do7eiWGlEOE/aYQAUcTVe0y47lBQS9nYsEQsbhxhGkJDJtOy0V2bjJzX8nMSwdQ9q/Rl5YMEsqGlF7LbIpx9gMy7LTZkQUaxtVvLil6jfVaNgGOnOTZgwzEvshqDtN31j1Kh6gbTbaUz99llpFB45t4XxKpPFzLvE2SUmMI2K8iaY6FVD70uw==
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:58:43 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::5a) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Wed, 16 Mar 2022 13:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 13:58:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 13:58:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 06:58:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 06:58:37 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v1 0/3] Tegra234 cpufreq driver support
Date:   Wed, 16 Mar 2022 19:28:28 +0530
Message-ID: <20220316135831.900-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec75e8d5-3911-4abf-289d-08da07551550
X-MS-TrafficTypeDiagnostic: MWHPR12MB1135:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB113596E607B12FC584FCA646B9119@MWHPR12MB1135.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHMue9I8QUYZh0eeHYNdhA+UKGr4Bxkuw+r0daIlg4TBQ0KAEvGQfMROMdbGCITNQ0WGamgjG6osucscPxDjDs8ipdrnVwnHb9zaWv7a2yRSOuWnzuYPbDnnaEjxb6O5tKU3j83aFIklEC6lWHo2gX4brLf7nCNG3qR0T3WmX/cT9V3uLlrXuFaYKIIo6qOUuAtV0+n9ztKOkixJsZSqYw11/ATYjil1vFO7ijdKMUOLrNrVQo3x+qLCfGrgK+haDB7zR/WyCOn1a20wvs345x5jUcsdsCuCyH0DBC+5wf58LyeFKWZ98OlisFKPpS9hIMfqoHQNoXTIMVLak0dwEUwgkVFqmqIHWoVmaJhpWZGMU6XfgbOg9ul/DNFCLto/wHLOHTgbzGM97Z8V1FHhR3RzU+GDqil4RUuISpLKonnUwXVnqtLqmg5ZSjNBHSLfL78P7QtRqICXuDWNmIpKAYrUCXgsChP7mey/4fPzIzgtkLpvDj0eOe2ZsO8FsxOeEcmZF7Tj6OWVlfrfJGKmlJEA7Dc3g5o12xhURGpnFVxyjVfb+gGeKCnjcuhO5LQ+Q4Ky3XB7OjJojfW83u8T6JauhwvaYkYpCYBzVWYZTAi9yPhB/MZTNVPYu39g4h+i3tMhCAgPPhM4scOGA9xrbcY3eeLghUxEfh7cZrGKeot0kMrtUXiuKbY2SJN7/PRSrLcUYHvhS+/hCX66IvIhZ7z4QTV9hnHqazEQUDTtT1g=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(110136005)(36756003)(36860700001)(2906002)(47076005)(40460700003)(8676002)(7696005)(316002)(356005)(70206006)(70586007)(107886003)(8936002)(336012)(81166007)(2616005)(6666004)(921005)(426003)(1076003)(186003)(26005)(4326008)(82310400004)(4744005)(5660300002)(83380400001)(508600001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:58:43.6598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec75e8d5-3911-4abf-289d-08da07551550
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Sumit Gupta (3):
  cpufreq: tegra194: add soc data to support multiple soc
  arm64: tegra: add node for tegra234 cpufreq
  cpufreq: tegra194: Add support for Tegra234

 arch/arm64/boot/dts/nvidia/tegra234.dtsi |   7 +
 drivers/cpufreq/tegra194-cpufreq.c       | 246 +++++++++++++++++++----
 2 files changed, 216 insertions(+), 37 deletions(-)

-- 
2.17.1

