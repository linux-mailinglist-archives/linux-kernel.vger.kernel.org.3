Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868053C40B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiFCFOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiFCFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:13:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C41DA7A;
        Thu,  2 Jun 2022 22:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU0IbFAt2Sc1wdrCHXX2lI+VeaLmFi6U0OCgqhgay21oKlS/B+OgsQbCYyR5IJ6a3sQemPo2dlSwcV5xmvjWmEP47ducKFaZ6+oWT2geZpyTtBx27/OCtxQW/L90lb8Y0YCS1K5Oepx2Jo6I7PG6FakhxKI40XurxWDmdZhtlklcE+3/4kL9ILQw4GW60r2Vi/gUjJ577PilvmkMVhsa1hj6vbbbjnYFSPlVFht5bCPlfj3PkJZKeqwBhynPwdbvaabI5U07d6nwh9MRIbWuvOzl7FqIz/WSQtSIZcPH01BDT0Q1Ly2xiPaDNDETkWP/mu5IPi9w9J68JPXwvsvZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCyd8ZIJLcKWk0TbtLoDscbb+h8cqeOxP+E/I07hkAw=;
 b=YExddUgKyxg8qtazxnf1mP4OVqNrAcq+4T8XPhUbxgih0VOg79FKPlQm0PRlVZ+xhyfhhXMzxZKX5vyRT7Yd7HjjycYOCBtqbr/e1RqAZDTQwzYZOgBXwsMBUkgWLrXi714PyvwnM5qjEpJ61RZEAcEnazXHK0DwDfS4BIJT/rrcfGhGUQlXR3qclkPppigDjyDPVsEr2py/heRujxjCNbFHSSosXcncuInZ4q+9QuBDHanG5BN7+S+iLsOxCoUfgN+OnbJwyFna4uvydza0RDdX9GM0WWvz3yReRjh69vm78X/Kscw51yZrr+UUUBGPcSFdE/ApHggoY11FD6rjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCyd8ZIJLcKWk0TbtLoDscbb+h8cqeOxP+E/I07hkAw=;
 b=yN+UlLyJCymYFunc8hWHJqmrZX2rtrr7PLgiygURjHG7XRJhFZUQ0OKm2IQ2MP6V/NwLrxD7tqy4ul9UYSaTBXXrbA9L57ObSevtcx9jJlHbf5iCvzfG+CPmXw37MfMz7pvXussMsd1ACVY2S6paCGmti9JJlbvyzH2v5Kt1o74=
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by CY4PR12MB1528.namprd12.prod.outlook.com (2603:10b6:910:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Fri, 3 Jun
 2022 05:13:45 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::1b) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 05:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 05:13:44 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 00:13:29 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <peterz@infradead.org>,
        <rrichter@amd.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH v5 1/8] perf record ibs: Warn about sampling period skew
Date:   Fri, 3 Jun 2022 10:42:23 +0530
Message-ID: <20220603051223.4272-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAM9d7ch2dtTjhSt9i96yr4JLEWy7EgNArRvSURE4h5gLL6=7EQ@mail.gmail.com>
References: <CAM9d7ch2dtTjhSt9i96yr4JLEWy7EgNArRvSURE4h5gLL6=7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6fb3bb1-fa67-4974-3a1d-08da451fd528
X-MS-TrafficTypeDiagnostic: CY4PR12MB1528:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1528C4675695520780A762ACE0A19@CY4PR12MB1528.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a+CzKqZnPNL4rxGGPMJFfMP9KkqDiQQDEjFs47sSfYbTMrOsoXEW0/90zhS5mOqchfBHUi4VGH/5nXGjIrq/r10u+QtS0oNK7QF8bIJ+KPxhC2nqmDliaQ2uVaCpLGB4TC4RmRALOrGvOKaNAV6pIrknXO4luzXjwHH8FJAC90QfH4/cjAHtkDIprnWOL1oKdqTEZNsZdnpCYO31fQhDUKAeKKdva4LEbkGTr+54/ZNM2MY5jGq1xunlo7c1h0cE0F9tfsSgfhTZe1NvAKW4zYWCmZTixJIO+v0LuEH4SAPmiznszkCiduQpncCGORVtl8wC/lgJUe550ROBn+KkeXZPZ7pbGPwx6kBzvlgP5KHSHGKHZ5wjku+gSFngvl3ZsEnvZZHjDBi8jnlEWdaZzE+Rah6PJPLP6sXDKVt5CFyYhqTxP5L0hq/OjWUKA7DmLDygDmCnK8scT4Sk1qsKjRwSG1M75F8VYrgSZFqeHKr00VIZlQoI7zn4dinh1IgokArK6sg4S6NH6daFifg3RboMdFwRF43S7hqCMCoCLpzu37NNLzAio8Chu4JUtdQjGhFXCv+0LI54FCG+hop7cgf6MrUfQ9NZjL+OfbQHL+M3sFd0CuSzFOCjHXitsaZYqljNIuoZh2lnSghflwL5uqjlzj+f9fbupDKeeZPnWaQd4BMFViY8ihX+pmbYncz/3WTUrQTwJtPwCpKlKDNGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(2906002)(44832011)(7416002)(36860700001)(1076003)(26005)(186003)(2616005)(508600001)(36756003)(7696005)(47076005)(336012)(426003)(6666004)(53546011)(83380400001)(316002)(54906003)(8676002)(82310400005)(4326008)(8936002)(86362001)(110136005)(5660300002)(70586007)(40460700003)(81166007)(356005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 05:13:44.7739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fb3bb1-fa67-4974-3a1d-08da451fd528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +       if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
>> +               if (attr->config & (1ULL << 59)) {
> 
> It'd be nice if we used a macro or something instead of the
> magic number.
> 
>> +                       ibs_l3miss_warn();
>> +                       warned_once = 1;
>> +               }
>> +       } else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
>> +               if (attr->config & (1ULL << 16)) {
> 
> Ditto.

Thanks for the review, Namhyung.

Arnaldo, Would you be able to squash below trivial patch into original
patch? Please let me know if you want me to respin the series instead.

---><---

From 352228ee010b0782410e233233377d9484ea51bd Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Fri, 3 Jun 2022 10:19:01 +0530
Subject: [PATCH] perf record ibs: Define macros for IBS L3MissOnly bits

Instead of magic numbers use macros for IBS L3MissOnly bits.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/evsel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index fceb904902ab..53763e583804 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -7,6 +7,9 @@
 #include "linux/string.h"
 #include "util/debug.h"
 
+#define IBS_FETCH_L3MISSONLY	(1ULL << 59)
+#define IBS_OP_L3MISSONLY	(1ULL << 16)
+
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
@@ -98,12 +101,12 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 	ibs_op_pmu = perf_pmu__find("ibs_op");
 
 	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
-		if (attr->config & (1ULL << 59)) {
+		if (attr->config & IBS_FETCH_L3MISSONLY) {
 			ibs_l3miss_warn();
 			warned_once = 1;
 		}
 	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
-		if (attr->config & (1ULL << 16)) {
+		if (attr->config & IBS_OP_L3MISSONLY) {
 			ibs_l3miss_warn();
 			warned_once = 1;
 		}
-- 
2.31.1

