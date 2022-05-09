Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F051F3A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiEIE6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiEIEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:54:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2032329C;
        Sun,  8 May 2022 21:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTD0KPGAUQ0IWvhDWS+e4IFEhT+PBoPJx8TGpZfcVK99AKPzNucI9oiD2zWTSL6sfKoX6iUzkbwNO32UTKkTpn+5A+x2+0o+IVTlLfkNMV+AZ4fZ+JbvH7pci5z1q9m+rnb3asGzzpPF8NCr1hTBFez60p66BwDDorro0ID7+7Ixz6bVV6C2g8lk74GqYiY6NyCZKchYicb+YBU4NkDmGdX1IjHBUq7L3rzFzl+rAQV6cP8DZGgihCzs3dD4f3AagHOpq6Aj0cr2TE248mov7k/L35YII3LQ+xEbNadcdMZrvHTlck1qwcM0ojyBJZUiUH8t0n1FV+jstEinyXb1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6CrwUMjg7j5oPD52iUObPLZlNGVwDXbbjjHWSg/GTQ=;
 b=MNM0PxgswpcwJxux1gWG1CDtYNePiBpIXx6An0uKEjkoaHYYGxDDuCe4ChzUDumVYLPf2YOF83Qe/oA+bGNos6MnsuyBzwwaxVPWPLmx0er2M3ZZSUiYIR04qQJ87V9/rQvIg3Nbf2qtFGzw7EKSBYKRqwF7tagb7Pg/cFySHXPeinzBnE1tdW083ufvXXnOdDwpyPPuSDZPOJdhGnPA5jUQwunvUO5BYL9rECc/Dm8GftmeHk3d3XqpC9h5bqD6bpNtbbfj75tScn/OqnpuFB4JsqicYN37PryD6kzehdcShIm7XL+9g8x94qGmoi1jFNQqAzgO0aBmUBntLkLLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6CrwUMjg7j5oPD52iUObPLZlNGVwDXbbjjHWSg/GTQ=;
 b=SZTkNbkcX1GrKaPjRyHI/6Gd9dSx2W/4+UH4cS0Jl35cx0elcajFW1GC7FUDW5QRhrCJ1gHqrlqEJY/FsFLRx1pjDryEOMOoY+1+q54ZnXQ/HY0yEm8y9no2Ga+oaka1I05cFc1fBUgw65rqzMaz0cKwzek6ZPhzAqixNEwudlw=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 04:50:30 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::1d) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 04:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:50:30 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:50:20 -0500
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
Subject: [PATCH v2 4/8] perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability attribute
Date:   Mon, 9 May 2022 10:19:10 +0530
Message-ID: <20220509044914.1473-5-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: afd0efa6-9fd9-478c-f662-08da3177718f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43871B9E6919A5F1AC3D3058E0C69@DM6PR12MB4387.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAYayKB9qYdAAGjGZAU/htGnOFdOBLYoY34XhMFZfDHE6HwdKnIdbrm37Z9WvK2vnPOq0lVN5BXtcU6XiCuXEzns0C8QIXYLuqXQQzX+6st956wrntjRFdao6ozy2p7Aj/VU+v5HOSsY4iNIEofORimbcn1JEHYUIf0/lR+PRpXMAktzFrJRCAse3e71b6+ARLPx7l7+cQRARZ8vpW2B1qB7vL5tguPwQoJYQTgt2lIW/0+tHrN9rTtbVWPEQYnCm/WiQIZZaQud6ZwFQsZ9uk+sWpDG9ijdOt3DZqsiUwWVer3o4UZElZaskyPw3ZFjb+ia53t2QOvFigomc2KLH5azkgXydQfm9K3CpvIOnMGw1p02gQuE5Lc3Mon7VTxvfU0mAfBIyxaH+U2sYsTUpLWJz3BlPUvefPGnD1/hF8R5PJ6YRIX3Tg4E9UuEmPvE4NXvcaV4/4z3PEEFDbKULn/f4g5MBKs8JLKJFwri1FMw91t0C184pxvJZFgxpNw56Of84ZjjkUoXuZNZPYj/xbfndrHxeAZ+miVna70Tju19fDxKvcjMMB7tzlWFFHTxNf1bTgw8JygdQe0A8herVsDrshmQZooTTQ1I2fUvK1xnJ3mGHtuMBun3AMAcAr0S0ioLRJKMSRJdgNmfDMF4ydRhC0yqvkoU0zP233E3pKbK23NR05g6erlCRA88jJA1e+A5dhf+Fw3IJ6QkLusp6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(16526019)(508600001)(8936002)(54906003)(36860700001)(110136005)(81166007)(356005)(8676002)(70206006)(86362001)(4326008)(70586007)(83380400001)(26005)(44832011)(6666004)(7416002)(40460700003)(7696005)(1076003)(2616005)(186003)(82310400005)(336012)(2906002)(47076005)(426003)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:30.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd0efa6-9fd9-478c-f662-08da3177718f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMU driver can advertise certain feature via capability attribute('caps'
sysfs directory) which can be consumed by userspace tools like perf. Add
zen4_ibs_extensions capability attribute for IBS pmus. This attribute
will be enabled when CPUID_Fn8000001B_EAX[11] is set.

With patch on Zen4:

  $ ls /sys/bus/event_source/devices/ibs_op/caps
  zen4_ibs_extensions

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 52d2eb9ff19a..12b0fd4a0328 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -527,8 +527,14 @@ static struct attribute_group empty_format_group = {
 	.attrs = attrs_empty,
 };
 
+static struct attribute_group empty_caps_group = {
+	.name = "caps",
+	.attrs = attrs_empty,
+};
+
 static const struct attribute_group *empty_attr_groups[] = {
 	&empty_format_group,
+	&empty_caps_group,
 	NULL,
 };
 
@@ -536,6 +542,7 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -553,6 +560,11 @@ static struct attribute *fetch_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute *zen4_ibs_extensions_attrs[] = {
+	&zen4_ibs_extensions.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_rand_en = {
 	.name = "format",
 	.attrs = rand_en_attrs,
@@ -564,13 +576,21 @@ static struct attribute_group group_fetch_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_zen4_ibs_extensions = {
+	.name = "caps",
+	.attrs = zen4_ibs_extensions_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
+	&empty_caps_group,
 	NULL,
 };
 
 static const struct attribute_group *fetch_attr_update[] = {
 	&group_fetch_l3missonly,
+	&group_zen4_ibs_extensions,
 	NULL,
 };
 
@@ -605,6 +625,7 @@ static struct attribute_group group_op_l3missonly = {
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
+	&group_zen4_ibs_extensions,
 	NULL,
 };
 
-- 
2.27.0

