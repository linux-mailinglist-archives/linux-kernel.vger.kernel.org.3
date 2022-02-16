Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2174B81B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiBPHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiBPHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A317199D6E;
        Tue, 15 Feb 2022 23:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYXMif9JrzuwzADqkkCqFjnosqV4p/y5CTYOGLeVUlvwQKg3/pzP1pLbA+pHnhgnFc94lrK/ZdgXvsu5s364hwAi4nWlhLOaEInVyDw8oSbBXdQyWxUNbACwXUlZLGjzEkBuQxEAnrnN6uyv1o3VRjyWvKZQ42DU7lj70IepuBstNUhOrx9koGjK06vMxlHU51j/ouU7cHE0Uw5/z3p76dw6wPh0cpuHXsIN+tUnyarBY/jVmxL99LABVXnjYg+i8+zLM4pdM8iCazsvaNRIQ2FFFLRcDSFoOAZT7tXUIMOCyawalgWCMvI/nm+sDQbii+wRniLun+UKGjGZrBxCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy8TeewnnR2/h2tASJ5GXLvwUizrySg8Zlw3tMxk50g=;
 b=G+GvWo6ZvhyXhLYSIjbQ4a5FVAcj0K40hrFwzBXad6az5/I0NlZ2XpTOnOfDTmw6refSz1j9ZVzQV9wgDXKILm7+HN1e/j9ZCpCJGTj6puoozsgq+VhsbLdIhF3wEczs31xFumXNjDCtUfOgpbZUVbt8we1kYdfleoFb5XAPVdmptOmoFaTWuCKvOKMlCAptza11b2zHM/lXUVNt7aA31eSJw35xT3Q+g8+JdvRutqYIB0z25mB6IY4SD08uG8RCYOTtV+MGl2SgdmFr+Tc4jrhHDyBSuxJN/0Pd6TmrS6bkfHu40qANxffn+bwWBpNvTO/SQgGRAjGe0Q1ma8BFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8TeewnnR2/h2tASJ5GXLvwUizrySg8Zlw3tMxk50g=;
 b=zqkj6CbIa3di6amxIBKaLGtDsvRuN3kBuSzPeHRC2pMBsJ9IYpyiUdsVQYEKCW142Znq4Z0ZrCErNzunX53EmGxGNNRqWpZJzCy4xXxn3t9omo4oodJUT3WeZwQV+hnSo8IXb5Bxf9EeYBMUZ4qomvv73/Q8z/Dm33+ct1SKEIQ=
Received: from BN6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:404:65::30)
 by DM5PR12MB1210.namprd12.prod.outlook.com (2603:10b6:3:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Wed, 16 Feb 2022 07:36:35 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::c) by BN6PR17CA0020.outlook.office365.com
 (2603:10b6:404:65::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:29 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH RESEND v6 1/9] cpupower: Add AMD P-State capability flag
Date:   Wed, 16 Feb 2022 15:35:50 +0800
Message-ID: <20220216073558.751071-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216073558.751071-1-ray.huang@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d940546-c617-4b6b-b6d3-08d9f11f0f42
X-MS-TrafficTypeDiagnostic: DM5PR12MB1210:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB121044341DF08C1514DA0FC0EC359@DM5PR12MB1210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suWRhGI9mAIieQs3V8Kv1smEluICwlr66eRMeAXN5GQUzD5ixhrQgs0dySjP/qEErD1uSZY/FAzgR+ZmazAg1/yAJ4TlNxVKeJXzpj3YUeDqMGbr2ID1aw+hqb1f9MDjLgGVDSJrxRE71CRBBUkNQCrCFTs1fAQfBInZ5gdGkRhoSRqmLF2IniHXmN/UNq68xbZJk5tyP4P5SgPuBLwTNKC7FxGaF4lK2rXYoRPB0wNaSgeDRHl/KlWabCUSxGmDMMF/iEaTsufxhpQ/TnDDGlnA3R9UIQalAY/+EFtlw55RYdc9UJEIUHVLVEhoZxkj0nRBwsxYGJXXHeFhuQdVvWfSR5hcxaGXgIO1u1CbPQ/j/Cc97LNdW8I0gs/nTEBAH+urZnjQbb38XJfcohohXX+7LhnEIxtx68J6WyEQNLY3J68MOcG4VF2NFWPM0z421smGoCPyNNL6fBiLcSWuJuBfaNOqwtiZV+0PnM4l8DJI6Vy4BeL1uhNF8BOlm+nxPhhKD225dOUaE1w+SZziIZ/9hmJzlsDJqk9t3RUZ1shRyTungAfiXgCeQNKxSLx0hS2Ip6rBfvcbVlt3ozKhKwSO4XE7sbW/M1+tTji4eGI/OPHwCn+EbBGN58reTcw5fuRvvUKKWVWATw0Fmhl2pQ1twKm3ZKQbW22ux5XsYDCkSaXNDymSSGrpvQNT42ubTV4yPKSe37r2cGoKkguRZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(36756003)(316002)(508600001)(7696005)(82310400004)(36860700001)(336012)(47076005)(426003)(110136005)(6666004)(186003)(86362001)(16526019)(2906002)(40460700003)(5660300002)(1076003)(26005)(4326008)(8676002)(70206006)(81166007)(356005)(70586007)(8936002)(4744005)(7416002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:35.1321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d940546-c617-4b6b-b6d3-08d9f11f0f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD P-State capability flag in cpupower to indicate AMD new P-State
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

