Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861BF51F3A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiEIE5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiEIEyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:54:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F7A1446;
        Sun,  8 May 2022 21:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTRPXpuyOPWzSBph+rZqK2pIJPL7E8F8ygQhWiNwmSZzTVZbYKIfE61EHAnqZkR2fmzuUULlD4uD6PzNQ39uIaX/CRmWW/7TsAjFQb/uGIyhQuSZzFG3RDQJsMYF8saQAXMBpc2cQlITxfgumOWvzK4m3F7bJhy8svHhuQ9+F2hkbEMIQx/a/MRIncrh/nBh6ht1LbAg/nTW1pwVBDpFIqx7ifvSo1uAlzABdn8ECdlckMGKRBGpNN9oXLOsQMJ0NYsRiVFM1pxWYRC1bL2qPBktzbMnHnjIUus8qUSSLFBiC4EQeFdgJITN2wRRMrv5PcAEypXshF/h/O5Uk3LKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcElq48EYRSapD7GKojon7GCvxvDUTeof7FynrUPmNw=;
 b=gOXH9eAAdhNz0MqLBklpPTXwF22UdLlM69cNlog0dc6rJREqdCj7F/UmqB5yNFbflBCFoCd4A8eP9FdvISfT/tsGRs3wV7Qg/Pit7ZRrc4bSGQULiVtcxrAexD4H9kWZnOtENVZ1N0DkGgNxhspTGf/UAhBEDU58XTkHfUJE4AOtnAYVSXvVXO/hVCrKdab67CCaAUfl+RRL4EmKkdk0Na2p9fsEsqdkPawfGMGwTQdfDzPjqos2e7V8zyRMm3qNfZcRpvgkCjvykFSaRlMIjd4/zxgPkCjvKAJcNmQEzjLUxKVcbxBXPMlwPa7iJqbBplgHLE/bbJcF8bGMgBVxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcElq48EYRSapD7GKojon7GCvxvDUTeof7FynrUPmNw=;
 b=wbF7sD30y6qtr3f3LLvBk2oxLykRybEBTNJ32w7vFJGhnCbEaVhXq5od8zh9hBuinT/dVnoMHpq4d+HpoBbmQ/GWd/i/AmPS4H8YYkYrAP3Yl4J+1i2IEZCK3ZNr2hAN+kR++GqqwZehAHMkMYDpj4Z0c4N7oRDuvKKC0PO781Y=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 04:50:05 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::6d) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 04:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:50:05 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:49:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 1/8] perf/amd/ibs: Cascade pmu init functions' return value
Date:   Mon, 9 May 2022 10:19:07 +0530
Message-ID: <20220509044914.1473-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509044914.1473-1-ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791300b8-9c26-4f78-26b8-08da317762b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB383337917B74C1E86EBA4CD0E0C69@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gp3V41TT0MeIxCwf4IjTSK3e6kFkbeYKf7ZLHp+g1Tx56LEN2kJoK2zBlpNuuUYOt4P5vRAvm1ozLlGLvnYXQaVXPdWx3DqmM/vQlWijrrJFnMM/adq/A+9uBsX5maiGw9LkNoyK4YPClDC1FBc0SqOq2o95igYsqx0C6TKbC5nn8fKYFauA1oNCxoHOd/jLFskoJh8UFeXy4rvN0xyFQ7FXG0Hd4W176w/v8Zd+44L5Q5eCntXWMLuiG/YLF45eXmNTrymW577eoalifMBnVf3SHcoDQ8O/DANhv+l2KSzAeRGZV61mK+lrSqR1y9OsG+FgOLWzbQXmCTStcKMWorXTlFFZFDLSZ9SnfnGmwMYN5LdaTN1SlpQF/q1dUEKEp/4lzJsxbGi3BuomrH5UQPzWLbGP/3rRWtb4EENwZgW3DGgj9b/QGh8q3IV4Il5aTwCDd3H25VFmYGWedfBNgh2DoX38mNRvgqoP2T9eHq3Il0sxY1eFj7DSPdEAfdzYfERSKovAqAiQG1DR/MF1zl7yU3YXszknQxTol0HRCqu0whLlYpQL//Y/DriBr+qwHEVvfQDOJsh2TfDOvsoMHcMDETMnoK0XHqp148TZ+WH2R37JoGstIcuo797nfpO0H61nM1r3GM5Aq9y+HNczHD+awAuHLi1aN/TfTdsWAO9s+Z9zwZbXSAjFUPxBUIShN7ptWUKWALlyQvFF7gHFtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(336012)(1076003)(2616005)(86362001)(40460700003)(47076005)(82310400005)(186003)(26005)(16526019)(316002)(44832011)(5660300002)(7416002)(4326008)(8936002)(36756003)(81166007)(36860700001)(2906002)(70206006)(70586007)(54906003)(6666004)(356005)(83380400001)(7696005)(110136005)(8676002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:05.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791300b8-9c26-4f78-26b8-08da317762b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS pmu initialization code ignores return value provided by
callee functions. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9739019d4b67..367ca899e6e8 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -759,9 +759,10 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	return ret;
 }
 
-static __init void perf_event_ibs_init(void)
+static __init int perf_event_ibs_init(void)
 {
 	struct attribute **attr = ibs_op_format_attrs;
+	int ret;
 
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
@@ -773,7 +774,9 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
-	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+	if (ret)
+		return ret;
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
@@ -786,15 +789,35 @@ static __init void perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
-	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	if (ret)
+		goto err_op;
+
+	ret = register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
+	if (ret)
+		goto err_nmi;
 
-	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
 	pr_info("perf: AMD IBS detected (0x%08x)\n", ibs_caps);
+	return 0;
+
+err_nmi:
+	perf_pmu_unregister(&perf_ibs_op.pmu);
+	free_percpu(perf_ibs_op.pcpu);
+	perf_ibs_op.pcpu = NULL;
+err_op:
+	perf_pmu_unregister(&perf_ibs_fetch.pmu);
+	free_percpu(perf_ibs_fetch.pcpu);
+	perf_ibs_fetch.pcpu = NULL;
+
+	return ret;
 }
 
 #else /* defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD) */
 
-static __init void perf_event_ibs_init(void) { }
+static __init int perf_event_ibs_init(void)
+{
+	return 0;
+}
 
 #endif
 
@@ -1064,9 +1087,7 @@ static __init int amd_ibs_init(void)
 			  x86_pmu_amd_ibs_starting_cpu,
 			  x86_pmu_amd_ibs_dying_cpu);
 
-	perf_event_ibs_init();
-
-	return 0;
+	return perf_event_ibs_init();
 }
 
 /* Since we need the pci subsystem to init ibs we can't do this earlier: */
-- 
2.27.0

