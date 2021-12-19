Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520E447A151
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhLSQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:17 -0500
Received: from mail-sn1anam02on2084.outbound.protection.outlook.com ([40.107.96.84]:34790
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236150AbhLSQgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl8OSB2JNt4p3s/+wbqAHPp/8FM46xfHU8NzXLHxeK4YQVsaMptEcPZeK0/j9/PI9JC9WurM+XwrC4O0FmU+oeZhvO5LWDraoAeZVZ/V/+8xw99CpCbFS9mxk1I2Oa/tUTqVX/dDDg5iVpakpHtMIQEYAAOb5KLj3HinqFuQAEYvhHr13UuO1LmHF1vcMoYap3R9RqxV00Nyc/B6Ev9Qnx/BAY9oX3/Lv9HUMq47lxn/UlFVj2WxgefrrhxxBgG4pgFtV8sFhxNejgdlDHS/DFGmKM0GNFVHO8mcVgvAD1RQUqBGH/sio5GKrqsI3eBLVdtFJ3ifnk/dCDFVN4RRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIfQxURDoLiRdYdh3RmTxNuSKDBcomrDa15EUoBmGq4=;
 b=knPwU2GcTZfTS7CLUnfq0gEj0ERWglKWwzQtjGf3kjFo+Ssx7WepPccghY4x69W7+ydonj38ocIFQUTJGrGAAaeeO0JGggCLFSMLfC3Cdu/zMirMBVo3HZ2LT6OIJLkxLjl2f8YA5O0cyuyQnYMjT0RSzC+7o35x664a1LuKN2KoBLcRRfY9R5TQOYZm4qR5CHeN70g60WSd09489FjHtWpwKccbVDgSWpbH6F4miVhUuyoi2n1OzXanfZz/MwIDUzZhGWFROjSKr8QQxGh8NiiislEDZdNRijveu6Sk28MetxBotQc+kM8lnmnZfRNpANFbANj55M5zEQZG6ZK3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIfQxURDoLiRdYdh3RmTxNuSKDBcomrDa15EUoBmGq4=;
 b=00vWxNg44zsWMZZcZRGrG+d1R5v7nYzFLySXF+ZxVn32m6is/CDVdccZ4clE5tRifd7DMcVIpPc8VbhDjiI9nA9QDBFk7LC6J2bI3rqY5DA7lMH3CruH8dN4qdlnq0FPB2PQ+RuKQFPLms724JB/QG0RsjIoipUP9M/G2rA0Lqc=
Received: from BN8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:ac::30)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 16:36:12 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::88) by BN8PR07CA0017.outlook.office365.com
 (2603:10b6:408:ac::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:12 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:07 -0600
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
Subject: [PATCH v6 03/14] ACPI: CPPC: implement support for SystemIO registers
Date:   Mon, 20 Dec 2021 00:35:17 +0800
Message-ID: <20211219163528.1023186-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ec3e51-f9d8-45d4-2d07-08d9c30dab19
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14346FDACE06245DDCB8C4B4EC7A9@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yqk0Ny2F4NCvzbHep+EB8K+/0xdXRX+Kc1MZeWv7s85/4vAGEVgv7eeckOZFd/ywK1/uVAWaUn6Dlu1YcdQfuOqzscuLluQDG8IFrwu1jAyD6BVkhKq/3y+A8M2HblmSZOkEY+nFWgxwWLyOCgN6No3UbQE0rjAhjSKpFsyrq9L6TmZDX0VTAY9escKj1rPUBX1zuoej1ZOPyZXmpi8WFTr62O04sKRiuOgCpcthqktSeFYJUz6WK+SxPwZU9w51ki1oi6pk9I1/0X+UC8rWlky2uflEHtAXPy3EGAE91ai2c6YFpIvlE6pbo0LobhVKvq1PMoZKYqtyaryVLa2j2j5ghaOT6sLBebfMGaSVdkssrJvRx0MR5utrK1B0JPCoPbkf7ukV4JM+vAQdnecmU+MYBKXYV7BuM0YbLbLzSBVawEmTuOiPYNfborZ/CBQXjFQa49CJS+MIZwvsUrx5S1NsdioBZRQyGzrF0NkqKSidbUOOCre0Pq81c44pgVdwREREdNPsU3bsdsxUVziyfBz9PIn/pLeeJfTilG6jla/7k8lmBsgnds/fq5dHHc5CWq8cgXZdH7J9ebYk5CIm6TzK4nN2xK8k6oNPqkSZ2kvOt96FTvtDAw/U0yN1RdIE1nfPB55bLsobWkd3WnmgxMrOQaB23QA792e/uwVqrPvRPPrrfaUuSwA4bTyGcpaP6Hl0iEOV6n5r3krBctQyoYLrcpSw0pr0lDFhIFZgmjHMG669V00JRyqe14IXq8D8RbDiNZU5mVVX+zo/aN3zCzR+QEF1tayyDDExxxYDb1M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(356005)(47076005)(26005)(40460700001)(36756003)(4326008)(508600001)(186003)(16526019)(7696005)(81166007)(82310400004)(70206006)(336012)(2906002)(2616005)(36860700001)(83380400001)(6666004)(316002)(8676002)(426003)(8936002)(7416002)(5660300002)(110136005)(54906003)(86362001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:12.1712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ec3e51-f9d8-45d4-2d07-08d9c30dab19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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

