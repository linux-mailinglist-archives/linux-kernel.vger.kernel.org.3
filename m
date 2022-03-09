Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400684D271C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiCIBZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiCIBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:25:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F86E57D;
        Tue,  8 Mar 2022 17:24:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyka0mBRLkiLThZ63/VAkANh1MAMQCfBZilwN+/Wv3g4Q5LCXquiqqlBN4JU1p91UhdEYSx+ztxdZPtUvVASEXicDWfs3k23AXp9ksUjiw7dLdIg/0ZtSv+40RlSWNW6CgtLfNeMNRNqqgNXNWdYCKxVkva2VcY3v7xBG7/G2KJNxwW3a6lc2mlMNVH2NE/iXl6/nRAQpb2RcX41iI7Bf/8txjslzsrxR9829DopZ5xNZbpVl2v1FOvUwSqN/weo753J1iE+f7s9xKGsR3uug9luO2tBKpyuzarHxbM0arSpkfV3TAS0F4wjyv38uRMHwHYyOoWrNDVdh05066mXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNHQmm3Nr/3YLW9hs4iFd4oBGpPa5YKARO/BCzGSSmg=;
 b=HIqgfa/tMO6KIKX0YBI4XSv6zkywyp02qg+w8o43yWokBq02AlQWtfSX/MHl+nZN311QPxKOwtRUCYNg+WUQ14akqdZ9wrNDGAKm+WzuDJcxeJ907O67wG9p9lLRRTvMsZxDaCphIlSrMoqj4EOzESvaaJJ2e8aqDIPdUXKuXIxGh6+bILGFCusO+7cBUQEalC7GUXxAk8SPH1jsu4zQhnlg8ibogWqv3+WDzgWwhxZwmUD9H8xlfyii6V2PWwiynX5BJ0U3LLhsdv+8fOilsQNhxZwdH1Vpf8V+bOda+q+GbL2I+ZRammFFNkIopYk+yPh/qmnXdtfdqYcToACbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNHQmm3Nr/3YLW9hs4iFd4oBGpPa5YKARO/BCzGSSmg=;
 b=SWLqZZn+f95hVjSTSQUJ5+B6qI5K5tv9cz0ZGyD6G/2fyt7ycgqkqDFH2z8ns/UBKE2QwUbxIJq/HgwxQKQIdILLVeCH9yW/a84b8+Lye4yq0VLchJIqmiBrg5hUyCeevMJtbnzeFgZu5+WsDXkFGIv4tdZ995xfqT957NNPsNA=
Received: from MWHPR12CA0057.namprd12.prod.outlook.com (2603:10b6:300:103::19)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 01:24:43 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::de) by MWHPR12CA0057.outlook.office365.com
 (2603:10b6:300:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 01:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 01:24:42 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 19:24:38 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH v3 4/4] Documentation: amd-pstate: add tracer tool introduction
Date:   Wed, 9 Mar 2022 09:23:51 +0800
Message-ID: <20220309012351.616826-5-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220309012351.616826-1-Jinzhou.Su@amd.com>
References: <20220309012351.616826-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630dde07-744a-47a2-62e4-08da016b96ab
X-MS-TrafficTypeDiagnostic: CH0PR12MB5265:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB526519CCC646E454E6E88575900A9@CH0PR12MB5265.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8QDx1nGXFfRzk9fXAulBYRGcG7Y8e+TDvlwnF9eIxJgaR86JRJk94+xZ8NgdJhuJip9ZHZNiZccs/bSYI9fRwS9PHNGkyohQaUc+7Df8XLigYTxkSi5GqrV9mTNXesZIgH+j9mnECmx/gApnztrVGyh+wzk4L6gEgPKaEnl2wYad9UMgWhqk3wEwBwbYvP6+N+D66RaGVxJTufS3eZbb5o5yTVT1x3AHRazApr0LbGCi4E1N7/JT7KhtL1zlcWcD3CUAeW8BJNZ56406irj/aaDYMNUyT5Q27c65r153PFixNE0mq1YVkyjw/bZkIVBmwt3c28QItm17OPgIyXh39ucqMek2HM0i9EK18GpK8IGISpDiAPtEdGaU5KHTEXMj+5mCiNtaE4nzV7lyOmBd41TX/n7GKXyN95iOPPVrlcn9j3U/BjMAHpFoHIlgfYWPAjEOA+gS9COzphJfSG6M6pbFVRWUpH8v4LTDcWWvUqIS0RU1amV/FiyyFqNrzUvFW/dycJd203pOD0zv6hUC2iuae13U1x5W7UMySZDzoMYsccKvq/62WpJj4Yvn8qAkah2sz4qDP1yyiS/KdO0VfB8T9W625RZ5ByEKWgSabSmeP98w1Q2ebQdt7Yg2XViLGew3Q1jD1X4Tnot2LZXbzUQElZOc742jB342n+uUY2WZKsCZaAv1mk0lKtAh33T9AQlDyuI/pdVI/rU4c75aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(86362001)(8936002)(508600001)(70586007)(5660300002)(6666004)(4326008)(2616005)(70206006)(1076003)(2906002)(16526019)(186003)(26005)(40460700003)(8676002)(82310400004)(47076005)(110136005)(356005)(81166007)(36860700001)(316002)(54906003)(336012)(36756003)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 01:24:42.5570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630dde07-744a-47a2-62e4-08da016b96ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd pstate tracer tool introduction

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 2f066df4ee9c..1923cb25073b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -369,6 +369,32 @@ governor (for the policies it is attached to), or by the ``CPUFreq`` core (for t
 policies with other scaling governors).
 
 
+Tracer Tool
+-------------
+
+``amd_pstate_tracer.py`` can record and parse ``amd-pstate`` trace log, then
+generate performance plots. This utility can be used to debug and tune the
+performance of ``amd-pstate`` driver. The tracer tool needs to import intel
+pstate tracer.
+
+Tracer tool located in ``linux/tools/power/x86/amd_pstate_tracer``. It can be
+used in two ways. If trace file is available, then directly parse the file
+with command ::
+
+ ./amd_pstate_trace.py [-c cpus] -t <trace_file> -n <test_name>
+
+Or generate trace file with root privilege, then parse and plot with command ::
+
+ sudo ./amd_pstate_trace.py [-c cpus] -n <test_name> -i <interval> [-m kbytes]
+
+The test result can be found in ``results/test_name``. Following is the example
+about part of the output. ::
+
+ common_cpu  common_secs  common_usecs  min_perf  des_perf  max_perf  freq    mperf   apef    tsc       load   duration_ms  sample_num  elapsed_time  common_comm
+ CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
+ CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
+
+
 Reference
 ===========
 
-- 
2.27.0

