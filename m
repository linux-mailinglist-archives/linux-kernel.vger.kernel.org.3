Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093EB533A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiEYJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiEYJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:43:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B1DF2A;
        Wed, 25 May 2022 02:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcjKVD0Iyl7p6s5EzH5JLICdFd/UYJmSpKHvdK+17TnoEt5YR2FvKRax0/G1ALQ81CscxeDvEEckM1ng0VY94Io3amtjbb9SoHqe22V9xeIHfBNkBj/av2Y8bIkJnOLiPHOVCeovBEPpH6ptEe+5ATG12y7S/VFtBvl2AT8dxPEieG5b3UPA9hnFbaM9XQsX/x4WX6pkhUCeAg22RlJ3HTdjf/ssX+3u6Z5ZmdHFtgMtFnkKjeGTWC2+d0WeT6Duliz99DOUeo8FxPCKKHl3eazmjYCZYZXgg8kcXikfe8lrxEm0a/a1x8vs2OXYOPIeBbCzHEmk02mz5cKMpsb0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om1DVtBycFpLztTJcz+s6Gl8Y47WUeC6gD9Dv8ExqSU=;
 b=jbm4JNJOVE2WgL7zMEbOr/YBRd+oZha8BLifFOcHT6GQx6jwU/GuEkVpslvw7H2VsuE1OvhOWaLphLnvtjuvKGoPf1980WX0q5kTKm8O24qaq2LbSWe0KxBPpUU0M3fNlZ9JaJstUFcPkPx53FTHBMT/yV9rd2k1HP+EL3gvbn8v9oHMu/djb8NGYvB3vlN5oyrH9EbGLvq5xhLNjnISM3x4RBAG6YK2zOloeAY90w5tJm3ko+TIzs/HNDILPvE83ScUQzAT9l48dOysEV3yoT7vNDpMWCurgV18x9f1zkpgFzBC23Ooqcbem0KQN8Jc0dQ2bRPbtWd5BOcJ7oalBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om1DVtBycFpLztTJcz+s6Gl8Y47WUeC6gD9Dv8ExqSU=;
 b=qvBhm6GmkJWauNVHAOlEXFiVpB00nXbuAMfdK0D0retFb8PqSgDgBwO461t1XctioifJxxNd3iDyAswvmAv+zyfjlbpbqig4z6RwD2OPHQbOOGHg8Udy0xGU6Gdfpp+eovKon7TnOtsVgn33/kHvBVnw+ITbpOozuhHV9ov8CaY=
Received: from MWHPR17CA0094.namprd17.prod.outlook.com (2603:10b6:300:c2::32)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 09:43:12 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::5a) by MWHPR17CA0094.outlook.office365.com
 (2603:10b6:300:c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:43:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:42:57 -0500
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
Subject: [PATCH 06/13] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR using IBS_DC_PHYSADDR
Date:   Wed, 25 May 2022 15:09:31 +0530
Message-ID: <20220525093938.4101-7-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c8f294f-4624-4f2f-b053-08da3e32fb4e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047581F44B363E81EBB77DEE0D69@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEwH0JqIOlRSzqwfjVBb6TOQr1o0cC8sDEKJIdoBSJv45aFreVIZjPjegqiO5jHC51mXaNSfGBc681hMF0lZn/8XPT64OkKelCIfLDUs/6V49ACtiQ9ZmCUI1a78odigyVNvYizgn5U/yaiGPwLPtylIcZm/KZmQABn4vF2S6SO1Idk/EZ7jdYAqVyrjrMwNrunVBrN8t5f7aEl2a0fhfDqnxHx/UiGDjvKbTFOUI1BBykhzycqqrdz4FZL28M7/IMEPQIg6ZW6Zt8L2Jz/zFv0s293Cyw4c+XrRLmqGNO+VXyRRcl9uwJyS/rmF2MSGson53ymP5Cbbe1lmNI3rTcGBBffgDUv8aPU2cRt5n85WyLjGdIWq1lUzaHDzrCGWO5C+zrb5pWPDnn/cbZLBjgK+m34SiqxU0jF0kJ92fVhHQu7m+3QGzcPiniHtmETj2ajrJWxhksJ5EV2D/BdryWvKEGeTtokngW67eaoChkoM5/LEdouV9q64Rhr12/VcMSP7jCbNBdlnZy3jVEHuP9PbQFL3aQVWiKj/+iTNZYEYERuwaUAXevjnSpRPDffjt8hILv6qPlmk87P50O0RpZ3/6O29dDpAdxg8twHH1zu3yauDHxNU1h00gS1kzC/hXBaYgJeRlY/xpFEt8bcAysXb6db+7U5gNkHvI4kCUOD3PXt8I5DEc6b8zoSLHPVeCx0A8Jmzfg2UuuewF66oYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(2906002)(1076003)(7696005)(26005)(6666004)(7416002)(40460700003)(5660300002)(336012)(426003)(47076005)(508600001)(16526019)(186003)(83380400001)(86362001)(8936002)(44832011)(36756003)(82310400005)(110136005)(54906003)(81166007)(316002)(356005)(8676002)(36860700001)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:43:10.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8f294f-4624-4f2f-b053-08da3e32fb4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_DC_PHYSADDR provides the physical data address for the tagged load/
store operation. Populate perf sample physical address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index b57736357e25..c719020c0e83 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -986,13 +986,35 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
 	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
 }
 
+static void perf_ibs_get_phy_addr(struct perf_event *event,
+				  struct perf_ibs_data *ibs_data,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	u64 phy_addr_valid = op_data3 & IBS_DC_PHY_ADDR_VALID_MASK;
+
+	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
+		perf_ibs_get_mem_op(op_data3, data);
+
+	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
+	    data_src->mem_op != PERF_MEM_OP_STORE) ||
+	    !phy_addr_valid) {
+		data->phys_addr = 0x0;
+		return;
+	}
+
+	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
+}
+
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 				   int check_rip)
 {
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
 	    (sample_type & PERF_SAMPLE_DATA_SRC ||
-	     sample_type & PERF_SAMPLE_ADDR)))
+	     sample_type & PERF_SAMPLE_ADDR ||
+	     sample_type & PERF_SAMPLE_PHYS_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1106,6 +1128,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 			perf_ibs_get_data_src(event, &ibs_data, &data);
 		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
 			perf_ibs_get_data_addr(event, &ibs_data, &data);
+		if (event->attr.sample_type & PERF_SAMPLE_PHYS_ADDR)
+			perf_ibs_get_phy_addr(event, &ibs_data, &data);
 	}
 
 	/*
-- 
2.31.1

