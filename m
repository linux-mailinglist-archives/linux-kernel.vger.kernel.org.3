Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60EE47A14D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhLSQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:10 -0500
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:12512
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233228AbhLSQgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F11lspCW8UNC2d8befTPTsU1hZIaWaaF94P7GvzStDwXw0ECyUtuJrvuOpQutJk6Vc5IdJ3TX/D0ghPfdlpHTl5M5puofyPeuAQk76e7MJdjWGb2K1e6SGBwlfEtlpfk1KoIY51mCuun8wUaRBVMdFfmjgOZocIM2BCYguO9MwoPE/GoAfAynZwKucNv7kqqzOvNO8lj1bpp7kne6w0kmn8zY9lAMNn60x0mgmM8EumwdWxJijAIXJsbKATRXcsG/fMa1Au+i+KX2fty98BsJ2v4TMz2lgkafcBD2ntUJoVKlypusyv8pBdZYlDWK2YKmD5PrWs+BvKOtHCGH2dmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFpsTHzsc4S/yAm2lai1tvTk8AIOTj4EwQTjCfegOTM=;
 b=AQC44MITP+tHMZBMTFnTW8Blkqs+6Ngmaz5tM9xzAyttsAaqgQQ+qOa0ncoC89/m6NfR1xemwl+W3nujcLGr5Pbq2EASFyoIDAMymztqEqqwXyvyh9HMx1YnHJMsDFlOrRy6LCTiwxElSaZ2j12RBj/wkOnH0+otN1579/HJ9gC2icXmcERzoh9thIzkiYSAzNCFzT/UAWfKyNl8U2j6aQwtgSZbNv5XdsLJMQCy/flnC7Y96bxLtZGUDpS/N83/bEppib0jwin+v/NfsLtC64ZqIdaP2VPSjQqb5JVuLwW0q/hNtr+n+uMdpvubGSuGMQb52VUHd2nzUpVS2wasew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFpsTHzsc4S/yAm2lai1tvTk8AIOTj4EwQTjCfegOTM=;
 b=CUW59tB83Wyo049EVQeVqt8vfkH+ooJ1CY7etfRTF9e/3VzTX6cFxLU+1rYyBQIo+GVDPQcjQZbBhfyDutfKfB7dvI1mA5n5h2PaagPpsLNSkX/Uuuv9wKZhiuReO8tl8n4QQm0j5XT2bLkoFdgNHJ6nFmc6gyibUU7yakjOCqA=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by MWHPR12MB1232.namprd12.prod.outlook.com (2603:10b6:300:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 16:36:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::a1) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:35:58 -0600
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
Subject: [PATCH v6 01/14] x86/cpufeatures: add AMD Collaborative Processor Performance Control feature flag
Date:   Mon, 20 Dec 2021 00:35:15 +0800
Message-ID: <20211219163528.1023186-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f121c60e-6192-4181-f0a9-08d9c30da57f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1232:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1232115155DABE5F01873C16EC7A9@MWHPR12MB1232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s0XeBT6rIZWyT6lACNp7L6g/kk3a1yZV45xXPcah/8Uyb+8zgNrJhkOevGkvH6uVJzDlr6d4aIatZdI10I8rk+k5542DXs5A8PuiPJm7+347S0d8cq6gqv2pCQUzG+Mqr/F1mhznf/6QSTfiUg3gr0niio0mlyOMp+Lt0IGi7hZLIgDpeSjtliSykmkpsIxsL6eK5WqYlVNpYpAuDP4o8xN0feq1vEICkfP/4SxKJCVJJ8x3XZh+SedlAETvXtxbzxyoUvzMrHARsDVO82CH71RKiHZUO7vpjyKiiECabYTl7IBn/dPrL3J0awP+fe2ns4jQgYViVNU13dkOtQK0JtR6S4YCJ6dsoJjpiCI/v9eDpUoPYAXmyTHkrD1YsnFr83wv7o0soS4Z0+15eVJ2lSpGnRoftmPDlM/Xi8Tr9qHDLRXdMAEvBA442zwgerhOaSXWR57PFUyykLVfsOcK/lRCxZy9h0U9wrIb/ImxjhqlCM6mGK4fPoRDcJ7xYNhgx/DwSSQh2ksqLtc3bviY5N1Jdnt9gVWO8lGmrTCq6kDiH1sMuMBhIKzRgBoV2sguHnBt9mHnKCWxr9ZVHmgucNrO0HBOs0xlc9/AxNkvlToSU9NNpCDQ/UUk9ArzSQfPZ6sDzEwp50Od/8Oqjs2quYnF7uU08+hmnmesFkHepw4FrKi+plS50wfsri8qhdamgxLwpdha5PAGszUjiNZGiDLIKQMblwaDkuNQVJcy4waFu2vH0BJ0L4UmvJnID50NeCwHHSCmonGnGuEe697MhyrkD6xHsPGLjbhTX7CZGI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(7696005)(7416002)(110136005)(2906002)(8936002)(8676002)(86362001)(36860700001)(316002)(356005)(508600001)(81166007)(47076005)(82310400004)(6666004)(336012)(1076003)(4326008)(40460700001)(2616005)(5660300002)(186003)(36756003)(426003)(16526019)(70586007)(70206006)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:02.7823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f121c60e-6192-4181-f0a9-08d9c30da57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1232
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Collaborative Processor Performance Control feature flag for AMD
processors.

This feature flag will be used on the following AMD P-State driver. The
AMD P-State driver has two approaches to implement the frequency control
behavior. That depends on the CPU hardware implementation. One is "Full
MSR Support" and another is "Shared Memory Support". The feature flag
indicates the current processors with "Full MSR Support".

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..18de5f76f198 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

