Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4B486113
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiAFHni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:43:38 -0500
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:35169
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234484AbiAFHni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:43:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx0n150jxeUCuyb6lfmOJ1klWv5bbyba4gCuWOFCX0cduIiT6REG0yLiB8CeESixph49/revmunR5ho07jBRu4wNspL/haenkxX+JaeAvCsfqYy1QMgfdtHuGQrQoBO0u1zSgwvLGIp7njQDyg0vS08R0XW/kW99711WdNhhTjeGtj2PUtyU6t3od52FsJGdrSkaYXyb2VPbJ381B7UNhiJxnFk+Heeqs8aVCwAumZTsKJFUV4iRAwY4WzC1CibzAeu1kwDO4sq90dBALNQbVvJbVh7PRHy6qlXe5y0Y74l7lKMT941zpSUgAvOtwkdhUiKZQ4ne+udNLmduEwZpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTLF2HVX2FudNNcisjy1iw5vDUgUh/GgtSJ+JKYP7a8=;
 b=Xt/EWNkOc2f5JGh/lRlOGkA2tuWmCUNrW/rQLH4O5x9Z3hkfmInx3bPjCKNnvkTZO4Afu8zBGLxYAMpswqt3aCAVgthWssl658QKKs4jHxxKrtqD3izs5MN2hUffZyJZA4XzsUs32GNs6cexud5EgQXu/CNE4Lj6jKx7B1ddS+wvyWEWyx/dgySWKXZdczU91kUeTxHAZtIYw/0m1kvSontHMD1NJ6bkbja4r7yBDajzG2/PtciDLiRJqmazjqlW6Z6qDA69LKMh6UVjojIcdqdPJITRdgEkfdSfjCU2vZZGixfwtKAcAdWKkDmh5iSEqsCtu7ZelemWmrUyBb0o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTLF2HVX2FudNNcisjy1iw5vDUgUh/GgtSJ+JKYP7a8=;
 b=QviXme5mUUcQ4pUC4Zj+xkanNW3ohgyim2QWz+EyAscNF4HPj3+x8b5PfrN+mscb8oOvfmExVwILLGMK0cVaPSng4hqQ+E15h2VVKaC5jRzLT41B5BC9UlxnU9Tx37/c1Y+HphgCW4aNdIeRbgTUNMhL+AOdW8sgQeMuhmH0Bpc=
Received: from BN0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:141::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Thu, 6 Jan 2022 07:43:30 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::82) by BN0PR07CA0001.outlook.office365.com
 (2603:10b6:408:141::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 07:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 07:43:29 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 01:43:26 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Perry Yuan <Perry.Yuan@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
        "Xiaojian Du" <Xiaojian.Du@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 1/2] cpufreq: amd-pstate: Fix the dependence issue of AMD P-State
Date:   Thu, 6 Jan 2022 15:43:05 +0800
Message-ID: <20220106074306.2712090-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce63f753-5e8d-4977-a6c5-08d9d0e83b97
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15157858CC7FED858E5B4278EC4C9@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyDLe2gBO6eF3lw6ikVVOlaBr0OKSkTRfMdGyfvkn5KtoHMbgOOZlc69Hh1BevXZxfD82RvfjsJNsumgGs6QAyWIkwG6aBGTM2qgG/tttnT+stSThzH9md5hgZe/gaNDZ5I4K1XoEN6/4ajb+YmRv1Z/HB6wjVQLVqRnjZJ+zA0YbWZHDLf3gYa0iukvB3ezWaICOuh073XniZOzpUmb6ZpczIOFLYicgFVk2Oh8fvMMDTZoWhWvjmx6pagB9fa64CXpKRgMYR68d//N7SdeTRY2jL7MTIVbS3rMi7quIGIOSNKTMI+JOTdf9CO1W1rsa+VH0Jnk9JOvQlj0qYSP4lnoiAxMxazWztcyx3yQ7XJE14nCENc9ThnSi5Ba2GLXbtbou5siIO/N6IBzLUn1O1IcicCgr3XX0r7PfrWsFFwkp+jjEhVI67HdlQ+0gROiEAd05tegGL8KGyof7ofG1hwWl2rzB3CoLpJExSpEy1ZQbylSEFlcoa+DBaKD1Lbi6nb9Ox5ICxXDy3cy1kKFg7w+Ol/pTZ4X33T/A2exR/iJemXoAbhklOfOU3OyySr2pK0u0vIHPyyjCVttUqX6osTytDIdDlGgeQRyrgi206A0dLUJMDdtp2BwLbfV14APuU1vW3fMMvlD+x7ZyNcZ0T1z1cuHf6plLqgYvriHTSzyCJtYwro5N9qEERTaiuDAipB8gz+i65WOFtOp0DsWbL8iCeqbuPuL6WTQ/Z4FzVT8rHfnVYzm6/UHMiFde8L6qLo3g1AakQ+ITHd3pnfcflboSa2dTD41h0TTZiMolpC2JsRsoDvYgHY9uEGl6u5HBizzhSfLYvpmPCRff29Ax3YThSi+One8sVrgckA8VcD62qul8zloa6pAiBCxunxd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(966005)(4326008)(508600001)(6666004)(81166007)(70586007)(70206006)(356005)(426003)(2616005)(336012)(36860700001)(1076003)(7696005)(316002)(8676002)(26005)(5660300002)(83380400001)(40460700001)(36756003)(54906003)(82310400004)(110136005)(86362001)(16526019)(186003)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:43:29.9951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce63f753-5e8d-4977-a6c5-08d9d0e83b97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD P-State driver is based on ACPI CPPC function, so ACPI should be
dependence of this driver in the kernel config.

In file included from ../drivers/cpufreq/amd-pstate.c:40:0:
../include/acpi/processor.h:226:2: error: unknown type name ‘phys_cpuid_t’
  phys_cpuid_t phys_id; /* CPU hardware ID such as APIC ID for x86 */
  ^~~~~~~~~~~~
../include/acpi/processor.h:355:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 ^~~~~~~~~~~~
 phys_addr_t
  CC      drivers/rtc/rtc-rv3029c2.o
../include/acpi/processor.h:356:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
 ^~~~~~~~~~~~
 phys_addr_t
../include/acpi/processor.h:357:20: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
                    ^~~~~~~~~~~~
                    phys_addr_t

See https://lore.kernel.org/lkml/20e286d4-25d7-fb6e-31a1-4349c805aae3@infradead.org/.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Kconfig.x86 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index a951768c3ebb..55516043b656 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -36,9 +36,9 @@ config X86_PCC_CPUFREQ
 
 config X86_AMD_PSTATE
 	tristate "AMD Processor P-State driver"
-	depends on X86
-	select ACPI_PROCESSOR if ACPI
-	select ACPI_CPPC_LIB if X86_64 && ACPI
+	depends on X86 && ACPI
+	select ACPI_PROCESSOR
+	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
 	help
 	  This driver adds a CPUFreq driver which utilizes a fine grain
-- 
2.25.1

