Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1652D010
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiESKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiESKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:04:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261395DD9;
        Thu, 19 May 2022 03:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKT0yDa3/3z71z6CHy8elNsHdPuxD8UGFDdhGMl/pdGXsU5/Ibku2kaq/sG8NaC6jo662a5WPvORCfUcQlBm305amvYQiNyanVU7axBRrSuWe58/cBbPulOxa5kxn5Hundm0Qko1KpXhge2tbh5PrM8EGVRp0iIfIasS/hepRREvEPV2jAmzvlth3V4fRxKelt2V/keNDMIPesxNlGf4d6Dtf9DDNHtqPTDUFRF9JbtjWBQzqew4ay+U7SlidAB7dJxHU1pa5Iy/wlu8OH15l/u7VaMC9wiG/rJ2zbUK0mY6vTDT1JfvbcipWAp7acJHcu6obIG/niLG27KOehSlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLbFxQDW36DZNUzI7RgBV10Zs9DfVPkAulLWWcmGO9g=;
 b=dMkuGRhkQEM/tFaA63nCU9YwuQukJhdmwdzyYaJbuDllrAlpfKOpGyLSMJcuRJ+Fg8wKUSgi939TMGQAHKcl/RJ4vSZbblAsolyzkW3YxBD9f356vQrSx+Zkrj/mfZ0xjL4TrqKFgN/tW8lLRJ/AerEx8YFIwtIaE3EextvPUgLkSFtcEs30qLdCQEWcIFB97FpkmuC4nj6tybvfWs4liuq4ZCBR4Sm6YtDASiNMLxO3apdR9vl7IzeOSDJPzmcfHwcRWlojgR7qMtISTQtK767jcSJf/Fb5noxCQnbduWTjJ0Er/6Yl1RvlF9yOeU/wmnrE9HR9wPzsTOiXqPIWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLbFxQDW36DZNUzI7RgBV10Zs9DfVPkAulLWWcmGO9g=;
 b=kp4WN6nJy2Da0sZhbQmUy3X6IIY5IA3LgiEICX0Ry0TvUAxfq0/LvxFGptnWYISLZTqDh3k0/bSHci41Jlt9tM8BJdXiJZkK3KEtPRCOtBFHPP8V32UKC83GCJjptf4IOY3HC8VeZVQF+/YXRvBa/PUaaPQWAz/tyg3H13HaGEI=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 10:04:25 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::e) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 10:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:04:25 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:04:19 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/5] perf/x86/amd/uncore: Use attr_update for format attributes
Date:   Thu, 19 May 2022 15:33:31 +0530
Message-ID: <a5e4f4dd5c459199fc497e82b858ba09dc91c064.1652954372.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652954372.git.sandipan.das@amd.com>
References: <cover.1652954372.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5716fcc2-be81-48c7-c580-08da397ef434
X-MS-TrafficTypeDiagnostic: DM4PR12MB5916:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59165588733F17CD2FAE7CDE8BD09@DM4PR12MB5916.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGIRdUU4ZI1jxblHbcztqW7M44WLCiaS2Ef+s2wcgHNszasTP2GjoN3bBdC3ky/cQM5HUPtDB7MCDA6kf7CapubSqFIbdNwfIHPtsyuUJRDY0OaxfFUfO4OQJY24S+ug+idT7XSOf2w7aCeLkgcY0OCpVMHk5qGx8W++wxWwyWh3xUaBisSQzNbbs3n8HRy4myy/jYAiY6TDtRlFIi9U3L8csSxI2//ttUrjkJlYB8+5My5q7k6M1e80BEMjSE7+c/sO0Z5i8Vtl+KBnzPyWs5LtpZdpZmemt3Pkst5GvIlNWl+srCnO4TXodkCh/D1C+YjBrftlB482HmEcWexeAS/4P7zfgVWL2gljKfCX3RcQYsl/DKpMJAsOTtUKP7hFHoIW/y3DoESUv2a/q7OahFeyfLztvgP+12lV/wAKYPr6qidW+RipOt46qAZbu2X6NsM5LOgfG5De0UKHcJf7+SKKqm2A6J6YwDi1Dfk+SKVec5p2KvLXiQERvKOoVF/j96+M8fG0rO+JfLCep/pVkj4ll/00W265o0fjHdjVyQTgk81dhImrYRpl+8HNQCokQ2ceqGY+CuDjH4AJfvx5XxvNC6FMgw0BgHO6gd4rvrN7M3+BRwT2i0hhZCU+V6bpIdez0z/ZkvuosHTMNHTC0Ar9myXAMSIjXBcej5aA0WDX+VT9OObE69pRR5aCHarGCtQT8AggWv7TQoGWuWI1Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(7416002)(7696005)(5660300002)(8936002)(336012)(44832011)(110136005)(508600001)(2906002)(6666004)(186003)(16526019)(426003)(47076005)(83380400001)(4326008)(70206006)(70586007)(8676002)(81166007)(26005)(36756003)(86362001)(356005)(82310400005)(36860700001)(316002)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:04:25.1014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5716fcc2-be81-48c7-c580-08da397ef434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the update_attrs attribute group introduced by commit
f3a3a8257e5a ("perf/core: Add attr_groups_update into struct
pmu") and the is_visible() callback to populate the family
specifc attributes for uncore events.

The changes apply to attributes that are unique to families
such as slicemask for Family 17h and coreid for Family 19h.
The addition of common attributes such as event and umask,
whose formats change across families, remain unchanged.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 68 ++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8dfcf93711ab..c3e218dccf6e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -246,6 +246,19 @@ static int amd_uncore_event_init(struct perf_event *event)
 	return 0;
 }
 
+static umode_t
+amd_f17h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return boot_cpu_data.x86 >= 0x17 && boot_cpu_data.x86 < 0x19 ?
+	       attr->mode : 0;
+}
+
+static umode_t
+amd_f19h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return boot_cpu_data.x86 >= 0x19 ? attr->mode : 0;
+}
+
 static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -296,20 +309,33 @@ DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 
+/* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
-	&format_attr_event12.attr, /* event14 if F17h+ */
-	&format_attr_umask.attr,
+	&format_attr_event12.attr,	/* event */
+	&format_attr_umask.attr,	/* umask */
 	NULL,
 };
 
+/* Common L2 and L3 attributes */
 static struct attribute *amd_uncore_l3_format_attr[] = {
-	&format_attr_event12.attr, /* event8 if F17h+ */
-	&format_attr_umask.attr,
-	NULL, /* slicemask if F17h,	coreid if F19h */
-	NULL, /* threadmask8 if F17h,	enallslices if F19h */
-	NULL, /*			enallcores if F19h */
-	NULL, /*			sliceid if F19h */
-	NULL, /*			threadmask2 if F19h */
+	&format_attr_event12.attr,	/* event */
+	&format_attr_umask.attr,	/* umask */
+	NULL,				/* threadmask */
+	NULL,
+};
+
+/* F17h unique L3 attributes */
+static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
+	&format_attr_slicemask.attr,	/* slicemask */
+	NULL,
+};
+
+/* F19h unique L3 attributes */
+static struct attribute *amd_f19h_uncore_l3_format_attr[] = {
+	&format_attr_coreid.attr,	/* coreid */
+	&format_attr_enallslices.attr,	/* enallslices */
+	&format_attr_enallcores.attr,	/* enallcores */
+	&format_attr_sliceid.attr,	/* sliceid */
 	NULL,
 };
 
@@ -323,6 +349,18 @@ static struct attribute_group amd_uncore_l3_format_group = {
 	.attrs = amd_uncore_l3_format_attr,
 };
 
+static struct attribute_group amd_f17h_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_f17h_uncore_l3_format_attr,
+	.is_visible = amd_f17h_uncore_is_visible,
+};
+
+static struct attribute_group amd_f19h_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_f19h_uncore_l3_format_attr,
+	.is_visible = amd_f19h_uncore_is_visible,
+};
+
 static const struct attribute_group *amd_uncore_df_attr_groups[] = {
 	&amd_uncore_attr_group,
 	&amd_uncore_df_format_group,
@@ -335,6 +373,12 @@ static const struct attribute_group *amd_uncore_l3_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *amd_uncore_l3_attr_update[] = {
+	&amd_f17h_uncore_l3_format_group,
+	&amd_f19h_uncore_l3_format_group,
+	NULL,
+};
+
 static struct pmu amd_nb_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_uncore_df_attr_groups,
@@ -352,6 +396,7 @@ static struct pmu amd_nb_pmu = {
 static struct pmu amd_llc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_uncore_l3_attr_groups,
+	.attr_update	= amd_uncore_l3_attr_update,
 	.name		= "amd_l2",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
@@ -632,15 +677,10 @@ static int __init amd_uncore_init(void)
 		if (boot_cpu_data.x86 >= 0x19) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
-			*l3_attr++ = &format_attr_coreid.attr;
-			*l3_attr++ = &format_attr_enallslices.attr;
-			*l3_attr++ = &format_attr_enallcores.attr;
-			*l3_attr++ = &format_attr_sliceid.attr;
 			*l3_attr++ = &format_attr_threadmask2.attr;
 		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
-			*l3_attr++ = &format_attr_slicemask.attr;
 			*l3_attr++ = &format_attr_threadmask8.attr;
 		}
 
-- 
2.34.1

