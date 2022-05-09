Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28FF51F3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiEIE4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiEIEyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:54:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37374A1446;
        Sun,  8 May 2022 21:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUZ/4JxRHwGSv7JKRHsE9dUC2RCBwhDAF5kdcI0zXNqrGwg/mJgzugdpU6A8trb/u9lq9kq1kV+/xp3+OExCM12FIWMz45Upu4OQKTS/5wb+UtsVA7mTXlpQanRs1WQ76+LlrAzsIcDgvCv2RIiqsiN6fbYy6HQrFGXTrkCNfHgJYrwWgUeYe+dRHpAtQiAts2sielQKTxgplEy4Wn/QomiDghqvmf4s12Vc7eKNpgOLM/iFBUtCRlFZd6Va0Zx9BmL59Bn01+YMLZQwxYvlJ1MVrQ/lR8JwjHYt5JgnMUPeWUUBTcd0kI5ILvi2ywBqMsqAblYCnpONA/oGQ7p/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jfWMFg1bsD8010TgxLteIn1mWdzlbOQ8FtGemtHDn0=;
 b=a/iA1rd+RWDSp3DG42qQj0qGxlJ+fJVabzDAALO9XukYMOOqYuQPcQ6Tb8QpmV3UY6kAyPf+i478WugPqFo1n4ZoIr1Hym8/ToePBDu0xyrgCP7YDbR8jAXwX5AMrKdD6R09MM60GO3Nx88gZgFNW5BXsSMrcHJ+1acshONbBZOgkkmWwQvWIsH2dB85+/HWCeZMAYu/ynuRfCTl0GGN49pZtPFodG4IM2XA+WUbVbyehCpiIq+gxwvdUnr35a2Q3JPtLvlS0YjfT91B3BxR7ONNPNquCrteV4y05TCCDwSX0Yw7M0Ut2N0nSQuZVr117CwUkI6v1FX5NO0YrnPs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jfWMFg1bsD8010TgxLteIn1mWdzlbOQ8FtGemtHDn0=;
 b=ct/zlR2KgQCyuzs7LyadMxUJ27Jwk437WTgfNdCZ08KjqXqI1z9ONfMlvijw0W1p60OL/HbE2i6f5XUrb/DXCOP1IBTtdrc8Zscp0OJCY79KSOUEQG2KRGRfgpJ6td1cJkkmimRkhG2yeiXodXKXE8Y6dEJ7O3BMVax7FbkokiQ=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by BN6PR12MB1394.namprd12.prod.outlook.com (2603:10b6:404:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 04:50:20 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::cb) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 04:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:50:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:50:12 -0500
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
Subject: [PATCH v2 3/8] perf/amd/ibs: Add support for L3 miss filtering
Date:   Mon, 9 May 2022 10:19:09 +0530
Message-ID: <20220509044914.1473-4-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: be680c47-5f63-43eb-fce6-08da31776bd5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1394:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1394C8035F9CE0DD532FFEE8E0C69@BN6PR12MB1394.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KR32KRux1Ho1hNo9uTiVJxftUhBdzaq/qY45JtZG0x6Qjdw9etRtkhKqnLtIjcRRGmgtNQGEoJ+IqxCISCeHmj+gvdY/OC2v1sAohFU0gxeqi38B+4xSlvYhmDRTY/RzrnZwHj0nmKIwuWrrXb/mXrbXaL3xka85cjffG83dSEk6GLGehXpkCwQ9RRnOAaWjExDh/SAkvKCynIeVVBWBX+JnDR6mKYFR0rUlth5rSJJ3abbtv0PqQTT1buewOWtyGfjWmAVKIgpv681oczB2CAT4EuJTOCIN9IM2StrXfFmxO9+vYObbfP83rGqoG/14YQJBNrMfiWI7ISsFAXX4uNpQS+RH5dhkJ6UPDLGv3haiqUfSTUD40zi797UcUR9W3/W3FEE3OydxfEhzZUawBEYuJ8Qa1IhgeSqnh9cOkTu8I4D7ol0W1sZHghZYckyP2HaKpwtl+VcdLC+utHGFCj35ofp4pAqxtqvNHBKI8qICBrnfq1oTDYtkVBh9qEvV8BOi3Xy31gVa/4iNYUtH6egYYesESguEBtKkPXZR6JkLoyDvHO+IUYCALk/dtVa1wE+LG2twxhPa07gzTmmN1mnIWdYA69/hEL/iOJ+BMBb/t1JnnlnG+OCR5LpQsqgYsgpPV9He5qrqtCV4nDBNbQxzymf4PHNA2O3vdukXjsCKMZM1tLO+ru6XSg5NtRkZ/SJxc+P2cv3yVDj6c+5ziA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(8676002)(2616005)(70586007)(4326008)(83380400001)(70206006)(47076005)(426003)(336012)(186003)(508600001)(86362001)(6666004)(16526019)(26005)(316002)(82310400005)(54906003)(110136005)(7696005)(7416002)(81166007)(8936002)(36860700001)(40460700003)(356005)(36756003)(44832011)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:20.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be680c47-5f63-43eb-fce6-08da31776bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS L3 miss filtering works by tagging an instruction on IBS counter
overflow and generating an NMI if the tagged instruction causes an L3
miss. Samples without an L3 miss are discarded and counter is reset
with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
This helps in reducing sampling overhead when user is interested only
in such samples. One of the use case of such filtered samples is to
feed data to page-migration daemon in tiered memory systems.

Add support for L3 miss filtering in IBS driver via new pmu attribute
"l3missonly". Example usage:

  # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 67 +++++++++++++++++++++++++++----
 arch/x86/include/asm/perf_event.h |  3 ++
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 785212b5dfd6..52d2eb9ff19a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -534,22 +534,46 @@ static const struct attribute_group *empty_attr_groups[] = {
 
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
+PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
+PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+
+static umode_t
+zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS ? attr->mode : 0;
+}
 
 static struct attribute *rand_en_attrs[] = {
 	&format_attr_rand_en.attr,
 	NULL,
 };
 
+static struct attribute *fetch_l3missonly_attrs[] = {
+	&fetch_l3missonly.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_rand_en = {
 	.name = "format",
 	.attrs = rand_en_attrs,
 };
 
+static struct attribute_group group_fetch_l3missonly = {
+	.name = "format",
+	.attrs = fetch_l3missonly_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
 	NULL,
 };
 
+static const struct attribute_group *fetch_attr_update[] = {
+	&group_fetch_l3missonly,
+	NULL,
+};
+
 static umode_t
 cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -561,14 +585,26 @@ static struct attribute *cnt_ctl_attrs[] = {
 	NULL,
 };
 
+static struct attribute *op_l3missonly_attrs[] = {
+	&op_l3missonly.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
 	.is_visible = cnt_ctl_is_visible,
 };
 
+static struct attribute_group group_op_l3missonly = {
+	.name = "format",
+	.attrs = op_l3missonly_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
+	&group_op_l3missonly,
 	NULL,
 };
 
@@ -787,10 +823,8 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	return ret;
 }
 
-static __init int perf_event_ibs_init(void)
+static __init int perf_ibs_fetch_init(void)
 {
-	int ret;
-
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
 	 * they need a 0-1 transition of IbsFetchEn.
@@ -801,12 +835,17 @@ static __init int perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
+	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS)
+		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
+
 	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
+	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
 
-	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
-	if (ret)
-		return ret;
+	return perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+}
 
+static __init int perf_ibs_op_init(void)
+{
 	if (ibs_caps & IBS_CAPS_OPCNT)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
 
@@ -816,10 +855,24 @@ static __init int perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
+	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS)
+		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
+
 	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
-	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	return perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+}
+
+static __init int perf_event_ibs_init(void)
+{
+	int ret;
+
+	ret = perf_ibs_fetch_init();
+	if (ret)
+		return ret;
+
+	ret = perf_ibs_op_init();
 	if (ret)
 		goto err_op;
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index b06e4c573add..a24b637a6e1d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -391,6 +391,7 @@ struct pebs_xmm {
 #define IBS_CAPS_OPBRNFUSE		(1U<<8)
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
+#define IBS_CAPS_ZEN4IBSEXTENSIONS	(1U<<11)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -404,6 +405,7 @@ struct pebs_xmm {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
 /* IBS fetch bits/masks */
+#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
 #define IBS_FETCH_RAND_EN	(1ULL<<57)
 #define IBS_FETCH_VAL		(1ULL<<49)
 #define IBS_FETCH_ENABLE	(1ULL<<48)
@@ -420,6 +422,7 @@ struct pebs_xmm {
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
+#define IBS_OP_L3MISSONLY	(1ULL<<16)
 #define IBS_OP_MAX_CNT		0x0000FFFFULL
 #define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
 #define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
-- 
2.27.0

