Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691AC592594
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbiHNQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiHNQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:49:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802339E2D8;
        Sun, 14 Aug 2022 09:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY6Hakp/ZmfbaqzXSrpMYzJ7inLXLJH7PNEfEvG0TrpdOpAehqD/notZ5zFJlTdKA+FRiR9Ve9UlbGU3TbnZOXb61IA9YSHOb8JxGsfdbX50A1S6zVh29yac7vz5S59Hw87wyJurttDeC8j8cLRXu0xInLWWuTSMKUzSTuhs+hjgwsnwYZ0QfTDGsN+1AkWARq93qFVzkIRnTamfSb2EmhLOGEmzhPn3pilWX75hmpsM/ryImKLhJrRqbtyxD6e6++tNlZM6NFnqpp5PHZXS2rJRNTHl8WwJ9InEJTie3PFCSmOGPo5J1B4wqGFL2a/MD3+iA+Qbs4jwpbovaxyt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvMXDPcSyspKZwfDSte4a5scNDX8L6+9iCN3PVZLF98=;
 b=k2nzUyu88rvsqSpjk7Q0yPIBeW5Lr0fMRphcfW+yR0m+fN5KKhzinwwbXDI6aDAjZZt2SVs7DzA9xtbWhLeyv2hUQhTmK2WJNfvanS8s4nrV2nwiqbnGpEQb48dlFmDSNSrvTn8aOrQLhMxywzJfdV9bTvN1dHZLeo1919wWCg4qjJzqJ9ff49dfNkmb6BuRAzEJcIxJuXXCQjGjf0uT6Qg17KxZ6de81nQWhhOKV42xEp4sWXtCeEzOei11bRr2K/t02AXA7lJC6ky6lIqfBKYpwga6PuT0tTH1wYjHAQHZ7kI2sy3X2sAsTIlQoI3NjpB+jHkQQZ7SMctOa8geuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvMXDPcSyspKZwfDSte4a5scNDX8L6+9iCN3PVZLF98=;
 b=Y9Hs/huD4aBfrd+6IIXHw2sXiulCl+uIcN4JtjB2N0OTsQFcZxx53Q6TgxR07iXYTBVhjgfcQDqWVwU7GaKvqZ24qqE72uRAt7HxgafCxd8fVZ98JxDKIjHsHbw1wnvFrQFqF88vBLrV0WmUmGjXditzbgC7ov0Q0OwlZQssU0E=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 14 Aug
 2022 16:38:01 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::f1) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.15 via Frontend
 Transport; Sun, 14 Aug 2022 16:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 16:38:01 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:36:34 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 2/7] cpufreq: amd-pstate: simplify cpudata pointer assignment
Date:   Mon, 15 Aug 2022 00:35:43 +0800
Message-ID: <20220814163548.326686-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46df4687-1afc-4b5a-422e-08da7e135a51
X-MS-TrafficTypeDiagnostic: BN9PR12MB5035:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phNYlTdWbrXUuC0keUTJnU2X/9PJq9pQarV1RtbPHu3wZG+7RYJrx0TA8SZIk3QBMaZAAIh/TgZE2HyG4/R3CUJIX77AU3Q4m3PrXZhUaamI3Y52XmkUkJ0cw85jsC23AOe546QWHY7p416SmgHriNOOSPRy1dLcncuV8hu3veMV7c1ev4kKdScX0ZvH36NQy/+n3UjhjTRSFvchSCQiBySETCGZJd1YWKGqvVXhLLwBdNMR9yADB45CzOFxYDHxhP+6tiKbFK1b3gdccVhmXe+BgO3EgJRIUDqFI+owPbYmtour0FGDF5d23yLoB5bx6M/FbZyD1aXMn88mdw2sJTlPfLCatuCGOL2V6tXdx/QD3Rl0rAImxmH44eXAKixOJjlrMpZpL1TgkMvSgNjOCVskTvx2e/0jKCZva3UcVZGmDMG+xYEu4X6s2ftxZt8Kel+q+ywApL/zXqfPlgy6BiALtkM0Xd2m8FD75pB1auJhFcdMfeFgMqVgqFj9Z2hTbjp2RgmxNeBrKcyu+FeGfoLhK7fgezKNWgsPO1dhvNroq//B4ecHzPflOPeVoTFYSib+OUprOH+ax9Exf8VGu9jMYns3PaGZm9vj0lsRwNJUMHvrTw9BGLa1yaHnWF6Fpb5xID2Oo40f6AYiZjzeg00wrQSEkSSQ279ylWUZPfv0TN53phSsCym4qRDvssafoDOorxvZoTx1vxlZG1jBZYT8MiFMDMk4O5Me7aqqrhSWGt/wg3cMtJ9LG/vRzv5F9pbdjc0c3PRo5FGKpt1MSHyEsU+LVDz+UqWTpqaQXt4OwGzfCTT71nrVpGlm4MkqPxcwb10E9cjXZikp6MYdjjsVwEMb8nl6F6N2vxUUo14=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(4326008)(8676002)(47076005)(426003)(110136005)(54906003)(86362001)(1076003)(40460700003)(82740400003)(83380400001)(16526019)(186003)(336012)(81166007)(70586007)(70206006)(316002)(36756003)(356005)(478600001)(41300700001)(2906002)(7696005)(2616005)(26005)(40480700001)(8936002)(82310400005)(6666004)(36860700001)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:38:01.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df4687-1afc-4b5a-422e-08da7e135a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the cpudata assignment to cpudata declaration which
will simplify the functions.

No functional change intended.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 19a078e232dd..b31bb5e6cefc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -550,9 +550,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -594,9 +592,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
 	int max_freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_freq = amd_get_max_freq(cpudata);
 	if (max_freq < 0)
@@ -609,9 +605,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 						     char *buf)
 {
 	int freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq = amd_get_lowest_nonlinear_freq(cpudata);
 	if (freq < 0)
-- 
2.34.1

