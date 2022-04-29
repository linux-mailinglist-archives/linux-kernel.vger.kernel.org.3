Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68C5141B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiD2FSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiD2FSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:18:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E1496B7;
        Thu, 28 Apr 2022 22:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgj2h747t2kBW3AtzgP4MGa6J65B6NTgsqJlSBKQ5yd4cFG4Vf01ZEgHZNBQcPs06oJPNzvWGuLZ7vM9IYmu84QGnW/HCot3IhlIaigyboLGVm+fKd03hR1zZiYEaCiZ6rBCJtjLnnEsMR5kbWk6UEMwguZl2qxgV1qjpCwA9GGOJcm3gnhlbqMQlvBGbfRVEhxobvyuK7AiAosbn2rXcerZL7C8oGBGAO6qnH/JQQtHy1kDdeM2BT3V552LoAGTxmDhDITz4VrNfTWWu//tGBmHKb1RUJqJxA0tSa7ubIfAZV+/0huWuhwOQhpWbnQ9sVyagD4TkK/8Dln4cc62HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlHqn8qyM9qtDv/VY3HRDGesglhBywtKft4AK6bF9Gs=;
 b=MeeV5B7heO3dMFS3nYlyh6AkqkWSz7sskLykeyyAUxEttFARi1aHB1kkhrwTAdWDarIzWA9C4wvCJAsu8gzWrlymiVhoFZBcHXIh38imRpN5TmqxWnfgU4DS0HHfnRkN3T+Ff/aIslLqytahjOp1O4NlAZlk8bfvOfCGqEyzmxTmW5BRj+/s9kz0j6AOwmZZfEqcPQHvSJWzJAbkLB19BtaM0uxdXKlHw4SBieR4/WzOUS8ek4HtpsY9a1TBtEGn/B9b11pCpgt9BqRJ2Ej6ulB3YSLdGVH3rhyD0iU/HHR9JbGC7eN8fHSHq67lLfnlAi0nuOQt6CjtcXTPEgEBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlHqn8qyM9qtDv/VY3HRDGesglhBywtKft4AK6bF9Gs=;
 b=kjD8oOOzB+DN3iMUH9FjGWUg3FrzrNDeJ+H0OJEl5S/b0/bQAsZSDR6NU06f9OY61nxghLTbVklvPFKjPiRMmwsmA6QPxxZy1wtoWGEuo4tmCxDVtY15POBfnPuLPk/qSOtX5giUGqmEOtd/gvQXYck0PvRw4FktG34QqJ6X2cY=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by BN8PR12MB3169.namprd12.prod.outlook.com (2603:10b6:408:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 05:15:10 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f5) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 05:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 05:15:09 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 00:15:00 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <dmtrmonakhov@yandex-team.ru>,
        <jpoimboe@redhat.com>
CC:     <ravi.bangoria@amd.com>, <acme@kernel.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf/amd/ibs: Use interrupt regs ip for stack unwinding
Date:   Fri, 29 Apr 2022 10:44:41 +0530
Message-ID: <20220429051441.14251-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net>
References: <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6671e40-8837-4f92-d360-08da299f3b12
X-MS-TrafficTypeDiagnostic: BN8PR12MB3169:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3169B5D7DF26EFC605AB99D5E0FC9@BN8PR12MB3169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zWZatlURgtNtkUKuip+kiAnODK9OP3/g5ihJ0ZVSXsb+onFvf4SSj9NaJxeFPvJ/a3XgmbsH4K5xN/e3mdK59JV+OucICp7qGZPz91ZEumPmYfyJFwzjl28DOmM3Afa+6Tp2ooKy4r2QxBBsLrTPCM1nNyUf/BF5ZKIhvyvqJ55PDqaBrgkk2KUWx9Q0f3+LXfd29JtutYspqTJgqriXnl4SuFHnoO4hIHrkluCD9o+4Oex+0jyJxrCdr+2TtejNubEM2MsPZA0GIrvnzXfx1lFKaIZZ+Gb0O+u5UDrNMNplH44acKf686wodk0OPitXt1Hk3ALLWKkbR/Q0tsML2Vap7xZjx/ldwdDd9Z5LW064GM32oSPdGVIacJt2+BUJ7aGKjptWRmna1CdEh9rSIis7P2WIhGaLzO9iFNGyuRR5aO3avYGVBQCwaN7xse/yPm+hdGzCQ/Z79MKpXDdPOHZqSVEbo2wZSi8jMp9qi9gQIG2Cw/iRmSTYOKhcl9G2JL4SgLLpBlr0GfUaY6xnMMqZE2Beb67pg/N+cLkO4VYSWGgyoWTrVTg/vvqzxCJdUbMXg37b+UghMcD/NQwwzKrNZlALoSiDPhS4v3R6/+CRxDiZD0DcJyiWkZsmPqVWYiuY6Obslc0/585bZEe9TUE5FZCDACRpwgOq8cKvqXWsOUTm76CLGkwbDR6ymOey2MFfa4n8xNsv9Gw94/IgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(81166007)(36860700001)(82310400005)(356005)(426003)(40460700003)(8936002)(44832011)(7416002)(5660300002)(86362001)(110136005)(316002)(54906003)(4326008)(8676002)(70586007)(26005)(70206006)(186003)(1076003)(16526019)(2616005)(508600001)(6666004)(7696005)(36756003)(2906002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 05:15:09.2099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6671e40-8837-4f92-d360-08da299f3b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IbsOpRip is recorded when IBS interrupt is triggered. But there is
a skid from the time IBS interrupt gets triggered to the time the
interrupt is presented to the core. Meanwhile processor would have
moved ahead and thus IbsOpRip will be inconsistent with rsp and rbp
recorded as part of the interrupt regs. This causes issues while
unwinding stack using the ORC unwinder as it needs consistent rip,
rsp and rbp. Fix this by using rip from interrupt regs instead of
IbsOpRip for stack unwinding.

Fixes: ee9f8fce99640 ("x86/unwind: Add the ORC unwinder")
Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9739019d4b67..171941043f53 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -304,6 +304,16 @@ static int perf_ibs_init(struct perf_event *event)
 	hwc->config_base = perf_ibs->msr;
 	hwc->config = config;
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack. Setting _EARLY flag
+	 * makes sure we unwind call-stack before perf sample rip is set to
+	 * IbsOpRip.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
+
 	return 0;
 }
 
@@ -687,6 +697,14 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		data.raw = &raw;
 	}
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		data.callchain = perf_callchain(event, iregs);
+
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
 	if (throttle) {
-- 
2.27.0

