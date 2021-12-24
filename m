Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DFA47EA00
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbhLXBF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:05:56 -0500
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:60068
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350543AbhLXBFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:05:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uoyenm9WdRPBuw4kU7bo0upUsaS0lNSzf8USCa2dkGZghYtFn9flmMgZCOyHtwMpeoYZYoCCQ2Rtjnkr1MeuVcOKZCVa2IGB1A5XBTNXJv6fE3BI+3s87PNVkXSQHMf7dmmaFrad7h611kmy74tFznubqj5UIVxcYIXOVKKbWTW4yUdKyNchYa5699Lt9JQE7Hvvu1c9DnVPELPsGGUFaabI3Fb5ZjS7INP8A5tHr7COINsk6d1+Zz3H5JR0mSKGEypWhpVh4t2YfJ1k6PnTWOcK4QBJmIXRQUtjb/zxFYP1LeHWv1X5joozICmg+UQnjmV7ml/bsXhSCVkXLdcpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIfQxURDoLiRdYdh3RmTxNuSKDBcomrDa15EUoBmGq4=;
 b=F0m5iUKXbMJn3jBv9tvtpbYaQmK1z4x5QKdJ8GdOpzg27t/JH+e7Vuct17AbdKME/hX4WlpPp1pB7yheEk2qoJjJKoWn43NI4mPVFVLRDDgN8TyEga3REQWnMPTPlfMKl/MyD81TpG9ebbwSXcdym+NVxBCXDzTDKIUrProt2pPeVh2R266fdxfepZiv4+Wh+qYDcs38mXoUl/y7q+EPyBizny9Pfvlk3Zq740T41iDm6C/TB572K5uogR7ENwNOlIILIZPlrCyTSHmmX3S/4GgsGmsZGC5w81P95aYVhXolQrXuYwf0GFYgXlghjs7CI4+0lyW5w/DA6HrYExri3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIfQxURDoLiRdYdh3RmTxNuSKDBcomrDa15EUoBmGq4=;
 b=KUobwkcsgH4TDqDGINXix2G/0ggKOPdW2mY77GcS/DE2WWs7Z0J6sJebYDtzN8KJ1oeKx9tnr8GpmOIIGJD8nHRQ5w+imOQdaurJNDR19Gn5zqhxUOcPDXmPA7f7L9uP7a56Lnksnd184aDyCOM6ii28La0vmOlDk9LuDGwiH6A=
Received: from DM5PR07CA0150.namprd07.prod.outlook.com (2603:10b6:3:ee::16) by
 BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 01:05:44 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::3) by DM5PR07CA0150.outlook.office365.com
 (2603:10b6:3:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Fri, 24 Dec 2021 01:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:05:44 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:39 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 03/14] ACPI: CPPC: Implement support for SystemIO registers
Date:   Fri, 24 Dec 2021 09:04:57 +0800
Message-ID: <20211224010508.110159-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af876d5a-267e-4544-ed37-08d9c6798333
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00170BE7F4A6D7CA92359FE6EC7F9@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnfPJE4Tz/IK2HGcg1bQsWM7S5gQTwXQEiYKPAgV7oH25iMID1LN4ea3AOr/kb6IR0QEQtSUy84Be0gb3mUkJpVBp1JBnGZChYKELR+FBP7T04hyexJByZydL46itgvIG7d90b9H9UNok/BsG4THnq2milBQkNXI21IBla2aifp0N1k1xhdhX95MOKDWb3MWn/qp9LPoyOYW6kUqT6wHTr13V5IN4iOeT2+8tkMDUX0UNUxoITWVkcjRDM+xOjmFJelPjH0ln7v5y3O3NDu0rJkyfOpOtC7A9runeopYFGfAyEQxwfOkFRYZPxOrO7eJ1sxmbRopmTxACsuwFjvtfpDPiAKSokQxSF7vchYFF74Sypn8SIKphNe5mqqRwZ12qNxD9ceInkjiOGbjVr/BcpIWCgqR3uOejwPwsR2Q+eQXHvJcFmRCYaE4mrWGz5d4p+VrS2jdQuILqnMZmtUAi/XB3hUfXr2PXdHmOgI4Llp9npGsP97OPJJurMKtQ9iFYQ42cuNNaMsi7B7V+rlU6ILrh1qr0agtEdYFq9+pGF/T14Ik6f1uln6TNa+JXH2zKF5gMO/MGUT7JX0gOSWASbILbA8GgP4BOo+CNdt8YSoxmjagjsvzgv0ezlACWB4pneHXFUOWeSs3QjYtev1w1mB7RuFgqctN8A7d0RTiVKzxkqJBSCt5G/kBUx96PjjWcbg3Sb7xPpZL7e3edVUOVnGvv9HCVb8iWJzYL9+lTkMsfwBypZ3kTIxIBCgC3q9o/dO8alhX7nnK37bEE2LjIEyQsbJne4Lehni6mpS/7Vo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(1076003)(26005)(2906002)(336012)(47076005)(36860700001)(186003)(16526019)(40460700001)(54906003)(8676002)(316002)(426003)(82310400004)(8936002)(110136005)(36756003)(83380400001)(70206006)(7416002)(70586007)(86362001)(6666004)(7696005)(508600001)(81166007)(356005)(2616005)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:05:44.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af876d5a-267e-4544-ed37-08d9c6798333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Noonan <steven@valvesoftware.com>

According to the ACPI v6.2 (and later) specification, SystemIO can be
used for _CPC registers. This teaches cppc_acpi how to handle such
registers.

This patch was tested using the amd_pstate driver on my Zephyrus G15
(model GA503QS) using the current version 410 BIOS, which uses
a SystemIO register for the HighestPerformance element in _CPC.

Signed-off-by: Steven Noonan <steven@valvesoftware.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 52 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a85c351589be..df2933c28bec 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -118,6 +118,8 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  */
 #define NUM_RETRIES 500ULL
 
+#define OVER_16BTS_MASK ~0xFFFFULL
+
 #define define_one_cppc_ro(_name)		\
 static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
@@ -746,9 +748,26 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
 				}
+			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
+					/*
+					 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
+					 * SystemIO doesn't implement 64-bit
+					 * registers.
+					 */
+					pr_debug("Invalid access width %d for SystemIO register\n",
+						gas_t->access_width);
+					goto out_free;
+				}
+				if (gas_t->address & OVER_16BTS_MASK) {
+					/* SystemIO registers use 16-bit integer addresses */
+					pr_debug("Invalid IO port %llu for SystemIO register\n",
+						gas_t->address);
+					goto out_free;
+				}
 			} else {
 				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
-					/* Support only PCC ,SYS MEM and FFH type regs */
+					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
 					pr_debug("Unsupported register type: %d\n", gas_t->space_id);
 					goto out_free;
 				}
@@ -923,7 +942,21 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_read_port((acpi_io_address)reg->address,
+					   (u32 *)val, width);
+		if (ACPI_FAILURE(status)) {
+			pr_debug("Error: Failed to read SystemIO port %llx\n",
+				 reg->address);
+			return -EFAULT;
+		}
+
+		return 0;
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
@@ -962,7 +995,20 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_write_port((acpi_io_address)reg->address,
+					    (u32)val, width);
+		if (ACPI_FAILURE(status)) {
+			pr_debug("Error: Failed to write SystemIO port %llx\n",
+				 reg->address);
+			return -EFAULT;
+		}
+
+		return 0;
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-- 
2.25.1

