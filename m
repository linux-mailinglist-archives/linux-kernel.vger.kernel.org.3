Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CE4B2F13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353714AbiBKVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:06:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353682AbiBKVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:06:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F3E2D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtvCR3JM/ltNAW1dW1WiS7iop23iExxXZSMIdugU6oo+yOJ9WYWenXVV+JG/nE55Ji3JszAA1j81EDsCUndmEaQsNgtdx2HxDdwtfsmhVqKxtEw370nIgkkyNE9YGownj1rC6j1UEIHPZN99ut3NEJgP5gCbiGAVk/BWVtzeozZTVmIY0jel2Tdf5lUIXew8RGy9JntUg9vhJdsZGOmp0rFFsKXWon2pWIj7wNZRfnrzokcTrhbq4VvqLnZuYT+ODeulZUrCHz19cMwdh5zMydNPjtHLevaTWdwTnqHZTWbsvo6u8ocyHC/9VNijuKqo3SMaBU40H+n14OkgkIjURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A64yGphSPUuITJhT/JcqmxOnimSVcR/eBE+ddOYFoII=;
 b=Gg9evq2WI3w7hmZRqinGG3JnOvmviAGmA9tFlFL8Q6gr7TCYS6mdqZYMO2Ifq8hasGs/LsY0vGqlE/3CXRdTj6ZBa9Aq3WfXQYJ1jfYPsHi3umen+s9R6wYxOCEnMResvcaw1l59Y6Y4bNfaTY0Wv0rOT2k9Rlkqn0t+xwuuSp0I0Xe4zV/A2GLcZqc08IoqZLxrj1L10uw1GA5bntrV4UolCL1Df3bx52TR0nDWTWZrgpMsROvvkHj+C5Sot16+ZY0p5pN2f/u2g2snM/5tf6aY8FRpfxFepxaUl8ITtqqc39fg6aBRFLqMySN6KvE2QyTdMnv8mXlATrvnYAZI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A64yGphSPUuITJhT/JcqmxOnimSVcR/eBE+ddOYFoII=;
 b=azXvTPpV7TJmhtYXp1lS6wvOF1KaEG3NzbzcFPG0TBRi4mErqNtz7D0u/CUuBjHeFXWBcfc40g/0JR8b7QLpbTj6TBwHXhCRx20w9cnmuW/4DdCoXQPrFu0PedSONq/AzNjpNix79KDsTkzeJkyxMba9vOfiyfCj7qYPG96oCQk=
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:06:10 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::61) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 11 Feb 2022 21:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:06:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 15:06:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/4] x86/cpu: clear SEV/SEV_ES features when not in use
Date:   Fri, 11 Feb 2022 15:02:55 -0600
Message-ID: <20220211210255.9820-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211210255.9820-1-mario.limonciello@amd.com>
References: <20220211210255.9820-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d74a9c-a6ae-421d-2ab1-08d9eda25430
X-MS-TrafficTypeDiagnostic: MN0PR12MB6001:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6001EF39A386AA5BC5CA4109E2309@MN0PR12MB6001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhxN4LFX/jYTTIxuE0Bk9XqhYW1Qta4D4dLRtO2op4PqaizLzpnVlxaIfWah3dtb9mi+kPEH4RACI4Up96ksK1bhU6VqaDcWoC7sJ3/qv6mWS8LaDnc/9QBuLrD8COmr2Phy/Kd2VsT+fSB3mRFM61+vtJyM6pQbZmKIakQOPvKIBuNWnGWqami9UP1mX7W7yUKpgmn4qg18bChmvkuzQogFs2QyN79L2jJvKdvSgPIJtAmhDXgGl7AUUAFIsrCz8FoVjwVb31MQzJfolDNkNtWSbQc/Gk+OXO+foafBwfAtFvjOCLJdmicGVAW9xIBQ17DWmq7nJlGjraBhaJC8D+RP7vyedhOcezZGdSIqc5hV94y+gj7KzC0ojSYaXKhWxfHP4n5OgGc0jGHY/cyfZwn61rfx9OsKjBAsfD7t7ehSm3nga1Itn6luOmyo6GA0UwrWUzUes/jLbLXdxnOreqH8PgzmoiLou03veKqOvrmIFMLh9AjTH4f4Yje9TXW44l0i3zN9BE4U+wSoSOemQ77JfiHNaSzL9nBIReogiFT97OO884zmp90POCnQv8fdyW3UWH5ioDjkGu5hSBhnbkPIUvyAnD8IQx1Gdr2MqduPLQRuGIAfwkXyWe3Jt9RzyU/94yNAkXdiy/CTnQrii3qfGzsiW+1/O4FgQUUy69h2PH2ouAeNZx5kbBqKYvuW6NlvszNwm/z074bqTL9mgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(426003)(44832011)(26005)(186003)(36860700001)(336012)(86362001)(40460700003)(2906002)(4744005)(47076005)(316002)(2616005)(356005)(54906003)(82310400004)(110136005)(81166007)(6666004)(8936002)(5660300002)(70206006)(4326008)(8676002)(83380400001)(70586007)(1076003)(36756003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:06:10.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d74a9c-a6ae-421d-2ab1-08d9eda25430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there are no consumers for these feature flags in the kernel,
don't export these flags to userspace unless the feature has been
enabled by the guest.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9cea774344cb..6623a4995df1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -614,12 +614,19 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
 
+		if (!(sev_status & MSR_AMD64_SEV_ENABLED))
+			goto clear_sev;
+
+		if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED))
+			goto clear_sev_es;
+
 		return;
 
 clear_all:
 		setup_clear_cpu_cap(X86_FEATURE_SME);
 clear_sev:
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
+clear_sev_es:
 		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
 	}
 }
-- 
2.34.1

