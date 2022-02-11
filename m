Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1B4B1DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiBKFjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiBKFjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:39:44 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0325CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 21:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqvS8IiJxXffjmwkeQpEOERqeA/JJaW0xiZoX+qO0+z3fXcL2Cw3xCgycRuqBR4oJ6RJHAHwg9IJoDC9Z9aus+POG0qD9bebgJ3qYcBFeMFz08TELCzkAGvr3nZgltYPjzb/58m+qi7cf3+HhIbAzBW8d1w3ps6Lk95i/sdVd0qpyUpbeP6heJiIwQcDEERNAI+q4W2WbsIAsWCNFORIPLHfXteacTkbu9RIKRLD8+q1TgpPT4jqSWvce/uYv+pB0G+/fRX3+gXuXQeWjXGhOuIttzhew7GMGOz8QurtD3oech7b2PyIy9trv3lUn8nF1NKu5knQNku5A8Vg5bneXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg0GQM6seVH3iEfFiszzRT60HVk68Y9qUlf3a+SVIlI=;
 b=Xrnc/c1+o1zHAlzz6ew35O/mGwTSq8NA90X9KZOafV2McJ7GMBtc5eraicx9gJePuOFjVZhAfGhpNOsc3fBe6l6L8PKHbkIg4SA1sNvQkjmmhar5kxGQULWgYYHu6H639WNEsHyEABmLt9TO7kjtwBRjO7DlFprZsV55ezcZJ1a2d3coxhONYeygZhKndOmIYz0Oq1kGCowyNKsJFFhFcyD4TBm9/A2xInd42NrbiqOk08jDfB6MItUSDRImSCzR+x97M5hGf/me2YV5bvcMfb4iHSFAeh12cybKJ0Jd2Ms/vIp6BZ7LjlQM1NnWhuabCuntoX5G7LnilJB1jfJARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg0GQM6seVH3iEfFiszzRT60HVk68Y9qUlf3a+SVIlI=;
 b=w6pbY9arQeTsqdr0E7/x6C70gkbFoAkewxO6Mc/6XBfA4Lr5whjav2FWJ60c09TSErLKALvhCxj2Get8Q1+05okpO7Vwi53kJ4Rxaw9YWoIgjfm0ksNKfGmBtz1TRmnOi6z2nrRAqPEeD0wRmGOroGYgobDW4VPgliLMxnlEImg=
Received: from DM6PR14CA0040.namprd14.prod.outlook.com (2603:10b6:5:18f::17)
 by DM6PR12MB3548.namprd12.prod.outlook.com (2603:10b6:5:180::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 05:39:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::de) by DM6PR14CA0040.outlook.office365.com
 (2603:10b6:5:18f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 05:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 05:39:40 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 23:39:37 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in use
Date:   Thu, 10 Feb 2022 23:36:52 -0600
Message-ID: <20220211053652.64655-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211053652.64655-1-mario.limonciello@amd.com>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e91ac39-4d18-4836-575e-08d9ed20e60d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB354871E0AE11202853D3DC13E2309@DM6PR12MB3548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvrfP7MTTM9O195J8yuiDiaFUVH2MEqFlO+F48Y5HO6BRINa4AsJcstOGvzY5F7HXGOE7KiJMZ5Se7NlQ5nf36Y4RJTTtYPzSATl1OSJJ2qC+rAjBF2aqkm4eSDZR+W/n5jqYQ7N31pveQagx4JySivQERldsvbDbeIYXuCJvWdevDD+nN13NwO8g3Usf9YJJxb0HrpkZVgBLjHgOJhdMNVQTc+IgCYrAv3jRS1oBWBzUDDHx4hbesJQbfqJsTg3xrRjS8azIK0QdZEMnV4FM5aF+G0KCO3On9zJ9TEFwX5AkF9s5loj5fg0HXG0cMe39ZQcYnItNdgykEQa+uNqv44xXHxIY4j62LvIjgKLowlAxqe99NKjXWDV/N9BEMM1JxRoed0mWxC4LaYx5xAlHhWkpNuLa8I0ZmM0fk86T0y+ur2XX5H1wMZwZEpjZuEFny4TFgCHaw2IGXV/ymn9dH77OU3mvu3OiJ8zrBxj2UPF1W1ZGLC3ml5/4nNEDIWIulQWhQHKZ6dhsd+9tdaWJrERVX+ruCMjySybiuKy+5b4M5zotVf4bmq0xobR4uGorH/byn2vVpUyoGCD8bpZ99LpEKlcYwnKU8l8actmsPILbOIBsNibWUFECZA7UpfYtgEu2XrvsI1z6xxVHU/RlPLvmv/uEEQm8mpCGtZJNqnsJJqeyTDvo+LhqXCHoFSCWbaDbk9FtSKfwT2RhG+xQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(508600001)(81166007)(356005)(86362001)(5660300002)(82310400004)(47076005)(36860700001)(6666004)(8936002)(54906003)(2906002)(40460700003)(70586007)(70206006)(83380400001)(16526019)(4326008)(8676002)(426003)(110136005)(336012)(2616005)(44832011)(186003)(26005)(1076003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 05:39:40.3068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91ac39-4d18-4836-575e-08d9ed20e60d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SME/SEV/SEV_ES features are reflective of whether the CPU
supports the features but not whether they have been activated by the
kernel.

Change this around to clear the features if the kernel is not using
them so userspace can determine if they are available and in use
from `/proc/cpuinfo`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0f628c..4a7d4801fa0b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -611,12 +611,20 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
 
+		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			goto clear_all;
+		if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+			goto clear_sev;
+		if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
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

