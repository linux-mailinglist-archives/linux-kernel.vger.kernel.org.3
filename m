Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21724463481
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbhK3Mkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:40:49 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:49766
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241672AbhK3Mkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDE1L2pMQ+emXm8BI7C7sRtL9gKcltuMQxDVRkQ2BsZz04ELEz6NLP6NU1ZPnq94cQQxJNraKqruDcw9C+rxWkFW3XP9/If9B1DFwklSTgEKhCfOp/Pms1zfOG8EUQn9/DjOWOcui7UB7W4qVd6ti9+Kl0uWCRad4y9YFdr60Db5P85qGa9SBBZKpdzitYlbbqM8oKn1Ziac0AtBA1DCDZSbi/SXGBcyvSpWGJ9NfOX3juFndSb2pgrbMJlG2yYJqiQRlFYT4PnGxL8O5gKdRjZmmEXvroHWxo0rP3yTXwdeMPIBdjcMGSihPHWYB5jCCBWZBpMPd7eTSfqi+iPz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyhG7Iwmktic/nhBTF3DsMsL1bvubDHmme8VkELaobE=;
 b=jYYuFG3SJFXRkImul8BrZCBQVirMri5x3OoTxCX9JbZZEblgipPb5i/4J1rL2VIlWrK3JNbWBojQ6UU3w0CR6zKQK7MhlG9PPlkdDGRIPBcNaIOgSQpewo0FXAWgU762LO4C5M3ZzAjhSel+GYYYoPvUZ5lC8O1dasNeFX9jZsUQ9fKwJLTZLp8oGuRc3kcdoc2pWkLHk9x+AQbWT4TqLcdLICmdxBYm+/sg26xyBBD8wMRFYtdifL8Wcwu9wIJFRdl/+G5ZrdpSOTDv4FYKdAP92JMa1xEAlmLLI7I90G0FjKBeYf2SyvzVZvHSFtRpsrFfUz1FG+QdWzu/pZ92EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyhG7Iwmktic/nhBTF3DsMsL1bvubDHmme8VkELaobE=;
 b=q1EgnTNVAAF/BCG2mv5tBTPzLxUoQ1MvAM31Nt3Xc/9Oh7dK5unmZiBuLUFoyu3bxJenCb4IWQkP5OjDd4TUbYmjaGQLcZ+K11A6qYJrsBle2eicvkq8Ud71ovKBPcWoIiMIqCPlamy4rzCpqusUlpHr1pK4CdBwU88GWlcZg98=
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:19 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::93) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:11 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
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
Subject: [PATCH v5 03/22] ACPI: CPPC: implement support for SystemIO registers
Date:   Tue, 30 Nov 2021 20:36:22 +0800
Message-ID: <20211130123641.1449041-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2323b4a7-2665-4850-30a2-08d9b3fe2512
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5473A311E4753095DC59997AEC679@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnKIjCGqT2hiztbG71ERF94E3efD4yAd4HAENlrSjyURMgPXlkz+uZQSQkeIG2WzZDWBFvmiUuolwz7beaqs8cY2FP9orU5wDbqAGoMXTU1VxKY7FA/LHvkAecnRcHiHoWdWBuJtT/8q91dxp7XAFfVTtXI3E4QJH+8tbM/MrugtV4lJV2vihCJUbl0/RbF2WPpYHli9kqPLp8OXmmUZoZeg4tAxGlBghXIaMgtPOdkcLoSbShtBAkx4pKKn3ORLbfbXbErfbWFqjHMORjDMF1IriYxpP+il2x/mq6ysfgFciWxPXePasNuKGmcROaj9psh2D6ogfrOazEvy+eQmp1J0K2xnjyLbE+chfNqtyMHNpNfwNaH7CMksr4AyUXnBwR4RDtGD7/WVoBFKj5hMsFnH70g213h3PWrAZWHV8YvlFZhgXEZ37oG1dWfLgegHGPo6ioauEH5FOJoIMJUIaqqgU6tQg9MSko/YIQJmUYkmNi6Pg9i37VIt8ZjfG1rZ6/ETqOda+/uJk7CYR2Ma4utgIk2F9JLBDMcZlk8ygFQT9CsVSvOZ2m5swekHJv1mVI1sBs7lLJItn81wfkRoKBIWs7MWiKqrPu8F3+GG2b3lW3n5QgYGy6ooHgwbk7PwhKE+hVYzE4wytdgvBnZYj53xstwBRqnCzfNOGqPNzrrORwRDA1vQrYpNDey7/0KKw6PhEL0y54zRnnTHhzEqgJrIOf1qNpKrRfMMZcvMDnuLbtexXLx/VxQPpi+uL3Vikl6gZOvI1ii8FpNfzWqKcyJbwyXrayrIvO2+bWk6XSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(7696005)(7416002)(8676002)(83380400001)(2616005)(426003)(356005)(70586007)(86362001)(81166007)(8936002)(70206006)(36756003)(16526019)(2906002)(316002)(36860700001)(336012)(82310400004)(54906003)(5660300002)(1076003)(40460700001)(508600001)(6666004)(26005)(4326008)(110136005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:17.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323b4a7-2665-4850-30a2-08d9b3fe2512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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
 drivers/acpi/cppc_acpi.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a85c351589be..ca62c3dc9899 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -746,9 +746,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
 				}
+			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
+					/* 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit. SystemIO doesn't
+					 * implement 64-bit registers.
+					 */
+					pr_debug("Invalid access width %d for SystemIO register\n",
+						gas_t->access_width);
+					goto out_free;
+				}
+				if (gas_t->address & ~0xFFFFULL) {
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
@@ -923,7 +938,20 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_read_port((acpi_io_address)reg->address, (u32 *)val, width);
+
+		if (status != AE_OK) {
+			pr_debug("Error: Failed to read SystemIO port %llx\n", reg->address);
+			return -EFAULT;
+		}
+
+		return 0;
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
@@ -962,7 +990,19 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_write_port((acpi_io_address)reg->address, (u32)val, width);
+
+		if (status != AE_OK) {
+			pr_debug("Error: Failed to write SystemIO port %llx\n", reg->address);
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

