Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03E8533A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiEYJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbiEYJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:42:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A1AE4B;
        Wed, 25 May 2022 02:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPDeNznrLpBNonxTS8vVs4jcqAPT9qoZNz/yG/W8mnHe/jCNX9uLugBL3F04DmgL0k1GXewcyecHyeBwdse2Y1kchpq9CQr4im4pOwze+Y5kXdFeBDyCfsLPzzc5oOe25uLRJgRALJqdYu7mSfhqx/GEFKziyqlQwEpxLEyfJFAQvCLmffwRpPAtuhBGEQ89aXTzQO/lh0iBiDPV7sIDKhNaMO817XPZhHoATB2gbgme2ywgSvOIB4xsqJ7PCAW5jbR89bMNDn0cRwaT4gS7NueUbQB4k4cgiurOBLXjda2W/aigYR/vyjTd+6M5B2or73rKx/ZXsGQLrnnZ+T9RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp/YrH9YeCNZXqRvGfEIuMKEvMEiLb+CFYf6+/nIJTI=;
 b=WJb+d6OT7YGqZ6MLaH4NsyaSf3qHvIQRomNboXmTHgs7UOZybKxUt2fadFFSSlVvx8W9pVGivety+Vk5RhT0+sKciyzreagN+Dhupyvb6IafyQ+M1+sFEVAlYctAyh7mqbYhWnzUNByCdzU0Ui+26Fup2ekyaZNrL9ScjGpfaX1+gCbiiGjd4vokCKYX4fjhheRrpq7jgfEWmjSmEAIu81lO16ccgNNUov6DdbJdGKhpYjsC5Dvxt2fCqasA4SU6URyXFmnmJ85BJ7rBP+CjErGen3bjznotYBL6Zo+L8EU/MYKHdjJ9Uptm34c8+1inWC8FGdlyOQljTmY+TD/Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp/YrH9YeCNZXqRvGfEIuMKEvMEiLb+CFYf6+/nIJTI=;
 b=wXNP+0aG1eMPeM1IaOx8UQZ88W2p9/PUvjMtXAe3LQLKWlx+Td2dT+N1MpB0xodUQagVjjW4UrYYypUS4ReCTCcgY+dxfM3UEpUxbgKZWm6xe8doG1I6ahgRv9ja9G1RN491QyU7muTyd8+MiMU1omRczE8/yl+D8caifmEgZww=
Received: from CO1PR15CA0085.namprd15.prod.outlook.com (2603:10b6:101:20::29)
 by MWHPR12MB1741.namprd12.prod.outlook.com (2603:10b6:300:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 09:42:46 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::18) by CO1PR15CA0085.outlook.office365.com
 (2603:10b6:101:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:42:46 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:42:31 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH 04/13] perf/x86/amd: Support PERF_SAMPLE_WEIGHT using IBS OP_DATA3[IbsDcMissLat]
Date:   Wed, 25 May 2022 15:09:29 +0530
Message-ID: <20220525093938.4101-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb78fe73-9a50-45a0-555d-08da3e32eca1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1741E911F79F151FF40D1406E0D69@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecLTbGeyYome6SWc8HLdmWPMnY3M5WU1Fqx2VNXiaSCwHli3Dh7g5z7Y2BKE4l3aKmbsxedfA6BPFwkXa8w+nQW2Ie3uk+NPHiu53mb3UNnE1UCD2FuQ7ptJL1fjyO04tYHDwfWjyqrKMZ1pHI7Hr8jyjiXQIOIQS4tpety5aehmpAZ5Jw+TLLMAH2uKI7oIVmqmA6c2TQU5h9V9dIXX5YRc5JpMhShtuAdZ5Jo4RzbqDmChkpZ+d+/SNa4cmRzA/IPxPMCx7k1h1iqJ3k98h1BHNqdJeCUtBx9zJ6ooIOnt+MKQYL5ZdjOvabbiIrMmTm22YumourUWc60NAkUm3i0hC27YWshq1kJN00B+wNI7oczZ/RnfdlQ1cagJ7+1zFwQk+wSLffTRyhoPwm/GZ0wbBv2AJDSQu6yP3ckBR6mb5zB2f14hUNH9JEANsIGUmIRJGkPVvxrMI80UkKQh8qtjy5Kq4lIQtpfAcaswKIp10dcixjQEHV11a+yGddJnQ6VdjdoMTVo+VLpDEpCBbYfa29KY/MeMv8Wk8V/ifttaBXtgPynHhV8YsXRShZXwyYXaj1K5dz9sktUB4R3iQZN3eG4efg0/VTfwRY0APh60L6IPoXzuKMJusp3+mEPSuWmA8EEh8HwI6PaNIVqw7eTCpFg3lW5XmIptVZSokNhR0WYn9jnhCKU8mYsVm5NHiS1Lv5XmXT9mBPwbgn19B8qLs5dJnnR/4jqgw+DkphfU1gdn/sm6P1lHDWIHRAAy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(40470700004)(36840700001)(46966006)(4744005)(186003)(426003)(336012)(47076005)(1076003)(7416002)(44832011)(16526019)(5660300002)(2906002)(8936002)(81166007)(36756003)(36860700001)(82310400005)(86362001)(7696005)(356005)(70206006)(2616005)(70586007)(316002)(40460700003)(110136005)(54906003)(26005)(508600001)(8676002)(4326008)(16393002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:42:46.3754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb78fe73-9a50-45a0-555d-08da3e32eca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS Op data3 provides data cache miss latency which can be passed as
sample->weight along with perf_mem_data_src. Note that sample->weight
will be populated only when PERF_SAMPLE_DATA_SRC is also set, although
both sample types are independent.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 6626caeed6a1..5a6e278713f4 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -738,6 +738,12 @@ static void perf_ibs_get_mem_lvl(struct perf_event *event, u64 op_data2,
 		return;
 	}
 
+	/* Load latency (Data cache miss latency) */
+	if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    event->attr.sample_type & PERF_SAMPLE_WEIGHT) {
+		data->weight.full = (op_data3 & IBS_DC_MISS_LAT_MASK) >> IBS_DC_MISS_LAT_SHIFT;
+	}
+
 	/* L2 Hit */
 	if ((op_data3 & IBS_L2_MISS_MASK) == 0) {
 		/* Erratum #1293 */
-- 
2.31.1

