Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA07575F09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiGOKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiGOKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00133A08;
        Fri, 15 Jul 2022 03:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf/ARAi9z6UGV3hCEReLPOUoNlItPtqiInUrtLUR2jEXWyC3M5svYF79OrevApE8AK9AH9CDATv6NRUx7lu5YksvijzlVmlLbXK44HN+Ze56ImQfe07IB24WIxAzDyBp8dAIBzUOHclf+Afcg94D/srQANJtnN9od15AMgB/8RtAsFYcjeEbNrbzSp6M4T+77RG6VzvPzkMre/y2hX+KB2R1y6L+9rubqH4gpu4XXpjGLZ4y1EJYPsh6SJWlMhUF0d8RwhQ+EegMwpF6OYb/pkOMB/bo+2qohYHQwfesevK/DUXYHuSyYttpCCwgjP6Hcz1uxcxGAtGfApzBGYL0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbhNxgmTeWy6Jq2jT29MMre/xJvh6Q5oR8ySWlwZNzk=;
 b=MPdtxWyXwk2xNPyMx8UAmhTqYsp3fvIQ+5yzWQTGlQzV2U0GEQMpA2Grz5hBhfdT4zkNGUjOR8O0dKfh3f00aOoR5onDQUGAEMU5kV3yc3zpIqK9eUsvn4FlX6eyPmIIv3p3hYBKbraL9uKkPJ/hwvZaUYyPKvpJnkrWuKZOLBL6cC5aewjUXdL/q8k3ewdPuRmgrdBLh4EC15ZoPsg7Sj5aT5mvWNjRNJ3fT428O1zYDvb53tO7uVpF5aU1uUh66KMlXnmcNh5/pXhSU4R2P1tUXS5bmsjr/dOFrC7DzbsALegy6XWOIZDz1aYazUJolaHdFTOS+zb8PCwiv+Iprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbhNxgmTeWy6Jq2jT29MMre/xJvh6Q5oR8ySWlwZNzk=;
 b=f0JLntudF4SyW86JAGHpR7hyW+RiHMR5KYUpHBmFiLACeujtgFSl4zsdyZ+XSEE5SKbVkMcnmN1JqTLXojmgo+Dek2Jm49Dc9u9J7fw0siY7AbS2fbzhj1PJL1bgoBgiwzk1Z5gV8wfCbX4QWicIHv5eQAF0rbc6DlBWm/ytCNE=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:05:02 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::16) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:02 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:04:58 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached value in amd_pstate_cpu_init()
Date:   Fri, 15 Jul 2022 06:04:23 -0400
Message-ID: <686bc72b4dc3a663c00126c852e3b4774a280700.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b3f28f-345f-412a-dc8e-08da66497bf5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPl3plYHuirgVcRi7b8zhiD00tk2RJlumezyWMcua//REzgklYnRdcArk2tha5NUHNg4Y0HDnFj7apkuZVZqRYEBioWp0moyUVTIzzHHX6QV+eD9UnlGesN0+IYkllf2qTXrIS15xId+0jssJRNZM7PgYP96sWm7HkdggAJCjNzmQ8ensrTNV0xvH/zMZnJ6zmjZbR3ptQOWzPd27p8MEu/0eNAQn52R9+fRR/Mw5zH6yC2ja8ioWBzsc/wL8ETUv/gtboCQdgpvMDfoVe7Rf7jesewWHg0TfF/ZchsiV4WhZJJECeN83kgwXUoVPVq0UWUuzAdTiMLAFx6T8fjBUBLuSP3eoLbV+91nioImaFISG3qx74a4ABcxUGRVuz5qm5faqXFu0rlWWA8QUBTRZLXiMvioXRca5xo1nOyRvXpxNbOJbG/wW/Uz1uOMa5GIEsc/jo2DE/guwjCUKcftvABoKE9jSzn/GoFfUl74w3OqdNn6o0J9M5faNL7fiaDYeGVv8lOewmi8WGK9HwPXbvAwEzlhYBK+fMIwcM+cIWDIkxCwWGB7vY1UccW4Jey9sx8a/kD0r9uaPOAoNpj/VZX47+euRBX7qUawJuiO/AUc870rVpCHSkjdHCjxTIejv32Cg4uLAoLxCx3/naooVczbxXZrhmzlzOZTW6muj7EDsvUnKJzyRc3tURjlb5iwMHNneC4WsY4QJyjo0sX+GAEXF0biyTqMQfSckBHe+XyWwNpmqjGqO8pKTWIk2/Z+mMjosFfMxEumIr6U7cQGtPgtSK8cjbSeEFroN8ZaTBDpjrBjmWpwtvJdDQMtiR0XSEsrugk4biHzIMpsYECeNVWyZJOWX/Xgq3Bla9wHL3E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(110136005)(54906003)(6636002)(86362001)(336012)(316002)(16526019)(83380400001)(40480700001)(2616005)(47076005)(186003)(41300700001)(478600001)(6666004)(82310400005)(426003)(36860700001)(26005)(356005)(7696005)(8936002)(82740400003)(2906002)(40460700003)(36756003)(70586007)(81166007)(8676002)(70206006)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:02.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b3f28f-345f-412a-dc8e-08da66497bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cppc_req_cached valued should be prefetched during
amd_pstate_cpu_init call period, then the amd_pstate_update() will get
correct cached value before updating the perf to change the cpu perf
level.The cached values are read through MSR interface, so here use
shared_mem flag to check the registers are accessible

Also the core performance boost state will be initialized through
hardware configuration register

* shared_mem flag is used for the shared memory type CPPC implementation
  which dose not support MSR interface operation

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 43e6df9f67f6..d8c4153dbe4f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -92,6 +92,8 @@ struct amd_aperf_mperf {
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
+ * @precision_boost_off: the core performance boost disabled state
+ * @cppc_hw_conf_cached: the cached hardware configuration register
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -117,6 +119,7 @@ struct amd_cpudata {
 
 	u64 freq;
 	bool	boost_supported;
+	bool	precision_boost_off;
 	u64 	cppc_hw_conf_cached;
 };
 
@@ -547,12 +550,17 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
+	if (!shared_mem) {
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
+		if (ret)
+			return ret;
+		cpudata->precision_boost_off = value & AMD_CPPC_PRECISION_BOOST_ENABLED;
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
-	if (ret)
-		return ret;
-	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
-
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+	}
 	amd_pstate_boost_init(cpudata);
 
 	return 0;
-- 
2.32.0

