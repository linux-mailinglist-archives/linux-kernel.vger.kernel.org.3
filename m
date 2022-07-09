Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93456C9FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIOUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGIOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:20:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894212AD9;
        Sat,  9 Jul 2022 07:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXyw98vATkQFV7oM5AcQTauKgFwAfJCxsQwhHzNvknsaEFUQjRvHIioCHUgQWZkout+JokZdk/YMCuIrJb2SExWwjhiCREqNTOuN4AaeiO0Prhc24x8g3GosLAtmD+o4f+qdQlFD61Djnv/lGcUXr68DfdFzWhuxypZlX+/XHphiJ/LdWo+D0PALKbUJrjMQC+p4YlMifQa7NI4w01eNzVKbOvYTxLzlODSClY8mdsRlVVypCsnm3xaqoi3UjIH+zSYbXTCG7C9fIEzEw19nu61DXmO1NwGAxG09FtxdLcXHnU3mdFo+0SHg5JvqkXICStTbzMLRJr8eoRpNmvWvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GyzmVDCJcEPYjeURfC5aBvySzwWEqQNpnsQPQDsfQs=;
 b=E/MsdMIOgQNe40PYp0vMaQyimDJD6M8HKenhdn5/KJgf/tpD+IoVmQRcO5yXe4JwTY+U4ih8CmZAkf8dpxFbzCo35SP/k6x+9A1WUlP20NIG2+VhI/WqvqsGUYHo/+erqSYYDTlQKvxtgLxEPQz4nonfu9hOAohqh5qn4uV6ZMM2dchPF7EhNC56H6CS2vNNQ9ZF1ebjdxo43qL11kcJenTZqGrkG5AYLARshr30UJ6ldxx5jPDcqWs83MlNuAX2CR5GWSdgG1OvfwAJrZFqjuomncLynLIr4BGJqqPHX2QHfBGeWRmsx/pOIO/yssHLHLdiuiXsqXkJ3wHtwzXO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GyzmVDCJcEPYjeURfC5aBvySzwWEqQNpnsQPQDsfQs=;
 b=PPp64PpzBdl2Da9WuGSQru+pe2W0E+eMGUnNB5LJy1FKCCHY/ZVndlirMVTmiYfT7CueKFaWocSnNzGGXij9gzHWfFaK7uq8cXK4QZyoMu+0b/UVHeP0REHzrEMbnhjf+7A6npL6U1LgU8cCg7zNzeE/lna5+YpWKlRH3fDsOBw=
Received: from BN9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::21)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Sat, 9 Jul
 2022 14:20:33 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::10) by BN9P223CA0016.outlook.office365.com
 (2603:10b6:408:10b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Sat, 9 Jul 2022 14:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:20:33 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:20:28 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 13/14] arch_topology: remove the acpi_disabled check
Date:   Sat, 9 Jul 2022 10:20:19 -0400
Message-ID: <20220709142019.836919-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e772275-84cb-4f1a-7965-08da61b62f60
X-MS-TrafficTypeDiagnostic: SA1PR12MB5638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7cVnUCoPmYvzFa2sCoGnH6p+uFpHwiDZ8vjGO578Ws3lpPi6fKvWX/kTL2d2S2Yjjk19RtblAfzBecYxzqGlKw71dspDhgYl7OfqqRhAvXW4HoEUct+8ktFTHfuV6M2YTFk5bpIOdjGvr7IPMopVmK+I1gT3UE6dPuX8Z+iayxQ1GnvT655oR9LxBe6ldloF+dWg/jWT2UKtjRrCNBaL2n4ahBLdnwfF53iLpqSRFpCzMe8Uszh1wd8ihBH5xOEnF5SWiZlY1pCUcLeLnScyPw+NjbcatXp543xBOhrAAB9VJBs7AKvcaDTimBJMjEhxOcNLbTbTx3ewGAt4wdpspcTiwj0XlnBvDWGLWtSbc1cqSVo5WEJ1HQkZySCpfkC9zfCZ38KX79moamcaWkwLrmgH3cZw/nLkOPJ84fD9LkPvedjgPmkMywN1QWpJp07430pMpfBPZxYOkhmDgOJq9VBePiDssU0IQE3OvdwhTP071zOqTA4zWvZVjQPYOSKPOlNDP+LMiqiQUmcoDt9C0/kiJhMDEQOxF7ddibsLRWDhK+v3MBkpot5hS9NoUmDblh+Dxw/PgEOqygMF9Lby3bzHwmm5KDi8hCaQJZa4TZ+si76stBikBb92uNs0/qyx3kfuZzxi4TCJl+ewsdLU4C8SRAFpTNKCw58l+F2xAgGBQrg1a6b6moXklBNiDRNTBgWVzUkNeOfe6uUOBo1OOEIgcDhzW+1NAqphTk6m4+zpcefkiNNZRbuO7z8vtv8ngoiFwgH6Ow2gC9ua0AySyWladAU64rbMdpMSft9SfJIeInVFgiE0+Dwsj8pg63m+RxD5/7cCnQKv5n9AAFoaupMqD6u99tbky6FSxyGOgr3aFBEJDVyG87+Hlb6F+h6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(40470700004)(46966006)(1076003)(2616005)(8936002)(40480700001)(26005)(4744005)(5660300002)(2906002)(41300700001)(6666004)(478600001)(36756003)(16526019)(186003)(426003)(336012)(47076005)(83380400001)(7696005)(316002)(54906003)(110136005)(6636002)(82740400003)(36860700001)(34020700004)(86362001)(81166007)(356005)(40460700003)(70586007)(70206006)(82310400005)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:20:33.1734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e772275-84cb-4f1a-7965-08da61b62f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 579c851a2bd7..73a8cb31529d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
-	if (likely(acpi_disabled || !acpi_cpc_valid()))
+	if (likely(!acpi_cpc_valid()))
 		return;
 
 	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
-- 
2.25.1

