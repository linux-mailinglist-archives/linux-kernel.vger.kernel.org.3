Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130E463499
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbhK3MmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:04 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:5536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241830AbhK3MlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a96bFwV3BCyEUdjo99Jx+QiVatVzBE/Vt48cdYkbzvP/dcI5v66PvKpfje+c3N8UTsYhUaR8USTh+WwdlB0d3unqkdpJ8iyqS0J4b5K/eD2Dgi/5A7QH4TdfXXHf4rJewoB7YrRIl8zcshFfYUmn+aw9sIg2okPlGx36ObSllrvOfscmEv69WIlIbi0CA9VMlYJCV+kZTlCoHyBdGzgorUWLdS4DtX/62AzvAZdXrYZZLwOsoIz8shLpeU0qvRE2gSPMl/TvdyrJ7/j+OpWsZk1IeYS0urHreffXJnXDDT0uGGyipSMuguJQYmFycof6LVWA1xEDIbeWIPW4kpAIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=QJIqy1L+N3Vryl6eQHyI7hGA+TXffRfucaT6sozlZh2vid/dOZNgxxc9CuuNf0Ew7QJN/9el5OhuX8u9BtZRJ+9o9jdzhtWk+MPjEl7brpyni4n89+cJNvvau2y9V41jRhN3tr1TcTOmQZ3DmtZ2wc1DxM9GmGlfBWxtSFyKDS0PXC9b7Q9YhCcoBef8j/l4kMP1D8yTyfr+KY/wuPzJylB2ZAor9vNAphf85pL6JeFBJYuGS9vCB0TP9raeBsb+KkG3R7GIGZLUn8Uo9rXzsXbWB9TMMj1Gbdkrkvy1IjoKzFQZlC2MVuZEUac/XAPhmSIwLjvzUaygLhY53zaIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=fA8o+VGt/g/bW8sPL+MPEsAiO8po2OsSfAanvJ80jdCHE9iROgpWPf9TJz0nkpT8gY6UlPcUVIGdToVMHtNS8Kt5ARG1YFhyK/M8oLgRhs7J3UdPrR9JTkbxv2ewwLhz1iin6XPuPaNgpglBODlZlJqjlGTet0iaQrbxIlpl04A=
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 12:38:02 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::e4) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:56 -0600
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
Subject: [PATCH v5 13/22] cpupower: add AMD P-state capability flag
Date:   Tue, 30 Nov 2021 20:36:32 +0800
Message-ID: <20211130123641.1449041-14-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1fadc4e-8fbe-4506-e31c-08d9b3fe3fbc
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:
X-Microsoft-Antispam-PRVS: <DM5PR12MB4662F78BB3A81642B196815BEC679@DM5PR12MB4662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mhk1VUqvhW+9qGd1RgDxZyHrr+HBroXTx+ASWWph2kW1tKCFoOLVqq73OyB+5pnKaVnt12eiqIEwFUjahnq8Zx8CLlrA0qZ0HGHNXfj/7pEf72sW6wyh+8Pv3qjI7ZX+BGLjeuwxqXjUQgRC1iuMaScBaAt+b7Md7Inm68O3VMh4DBEjlMQmtLtbyQCo0rlfN89jpFY5RvZtwq+sKQTH3qXlpvvyeyh6w/a0N7RY82N0zmrs/pFIkLihm3pAQBiLHhkTKKa6kpun/gDQqlhlRXtKBHNHXroOli3zApQkh1pHr4pnnBqrvVHCdVC3yRpAHnwGGz96mcqMHhuXO2rBUHFkbhRDeKfHX286ag41c9/StCpDqfcpx+AYwJta9Pyag20juJreqCbmxIP2ZAN5gkYvkyEmu/75kvabZqRyalLXbbFfbCwWn+ac+yetfQreY6ik3aRrUBVn/jLGjplnhoRXPd+CbPqsi1rsb+G6QOrRefYAx8grK3FlkCYQRImJigcAp8SDM/NIXlxXsCZvIx3e57ffTagvCrEbe0T2sHzQxAQ3S4ZPo4rTPSoglw8pG7nhYKxNdfht8doe2CCYcm6mLHaA6OlpLjT+/kyPsnlqFHNylx0jIa3Z485wjLkUn0z0QLo656NXrkokKddUoqnsTmdus2USCRq/5LtI83ElzdlnmcQwm2pefdmzbfnyLyE9h6eYGCoF30zr0biJ2nf2LWEIxfX/GWIL5h6yvrskL30X2n4Q0IxyI9+CFUiUr4rZvRpvkDRy4QC2xiQ1PipG81tYNMide2xTePrFHQQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(70206006)(36860700001)(426003)(70586007)(356005)(4326008)(8676002)(4744005)(5660300002)(36756003)(82310400004)(47076005)(16526019)(7416002)(1076003)(7696005)(110136005)(26005)(6666004)(2616005)(186003)(316002)(2906002)(81166007)(336012)(40460700001)(86362001)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:02.1614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fadc4e-8fbe-4506-e31c-08d9b3fe3fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD P-state capability flag in cpupower to indicate AMD new P-state
kernel module support on Ryzen processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 33ffacee7fcb..b4813efdfb00 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -73,6 +73,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 #define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
+#define CPUPOWER_CAP_AMD_PSTATE		0x00000800
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
-- 
2.25.1

