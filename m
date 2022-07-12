Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DC571F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiGLPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiGLPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:36:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B22B1B0;
        Tue, 12 Jul 2022 08:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqaT3VsTkQJC58PvM5f97JqhUxnnzlx2Pr/1q+/uJHv0KM69DbFCBl1RlNdJB4g8yTOhg6k/Xnihh5Rc0Dd2T4B4m9ncQs4E9PXBZDERyFtQQwGbvfTksJlQaCb970UxPlaAhAWLnlf61cE+P3QzKssXn7Jh4O2+X6K0o1MKQPfI8smbBvbrF+UkeHN3U9fOB3EV6rJyBtBwp/bPjsLioELlvqPEZ6nmA2q618LUPMUKBgqSJ8hEtw4SeeXthb+KBEGedKH+oTCnZrv8LhObdTMAaV0JYNtiQNizVnFcvl2nxz/oZZDWm+b4k8Q0ZRSsGFsuwXvyOUL5eTTvxDnZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=ZV0s9LmNtlAvEPGensRcgw2gaHncskjnoomOwU6j37l6AvqWuJphQk3K9EIA1J+Mnj6RePda1fXB2DP0TX7xHsLlYAJzMcuMsT62SCpW1lRMtGwYWCYHkQMn3tMIYht9DKukcp11d1f0a4Z/7AviRY1kiOmh6e37MawogXVKbx3ItMuAmbFoKCmo3bpfUT4SHCed5W2IMDeTVuEbUVo951Xjj1c45lFvqISlIfTfydJxj7Tut7sRliDtnAnw5OJzKsG7chcScXo8NxncE9AI1Kip52RIAhf2etXFkMM6VNz5GG/SQg00ttzMM5uyd2yOBvX3eMsGjtE8NN6nwEFSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=TTpFkWnm0sB218RgGLkywGOf901U568LXOvA1CItUzp9qjPZsb2QcoXngo0mvq7tAIgk8x7b8VAKE+iO/PE/7JB/HO7Zw0zFSDHDZ9z6pxzp28cclP/dW4Nw99HGLyELZjdGTnBTJt23QJKsxfBjs6cw39c3H3V4/mfv5BUiytk=
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 15:36:00 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::ef) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:36:00 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:35:53 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Huang Rui <ray.huang@amd.com>, Tony Luck <tony.luck@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 01/13] x86/msr: Add the MSR definition for AMD CPPC hardware control.
Date:   Tue, 12 Jul 2022 11:35:36 -0400
Message-ID: <ca830355f1470ce53cd56917b0adee66c0b50f00.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c19a7a8-4ee3-4ea7-7100-08da641c393c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJDfLZScNCP9PEsVD3pSS/QPqSGcNRcvtN8TkXpcPW+5xDAnEyEUrsO4Sf+J026Xvliy7JuDX02n5HHQkCTEnCLZXHQ/zcIbVzQnmwXp3LzWLkBw56/EZrU55n5ZpIT2Xh9AetcXYTH+Xee1funXN5cjbgQ+fm6HkqIwYWChXPt/JOkeD+2aAS7M1LyJXhtPclHuxXYZID3on1RU7JoMQJNdYldpjlHX2D77NmNQ/mM8bmGcaFXsckAKcdrDLbztCw+lCHhr66jyxy4OPsSxO/3fLWX9mvi07N+NjmPr8wOLlqafdFx3W8VQfN/3VAtS1xO1x1c7e7KKGqPYXKh1ULnZD6u6cdR1faG4yscnvhghH9Vz5JeRb36G4VXqQRPOKNmOyXnn218JkTfIxYcdDsAOdeApWyT+9So1dg7Lpx3pe1Y8UFsTwwfbsaQ+2heXLrQ95SZWdB2KTtNuIM2oRI1niq3/KIdmCFATVtPKpgLMDDtTN9vinrQU/NvGEIv8MV08EM2kmCote2OsSnLGaZ3ykYhcu0U+D7J7z25dsnpNJSJRNOT/jbs5eG9y7gpp5IljRk3NogIlut1sqwxNz/34leZLlodH7+9G9c+hAyeH2KLzrXe8dfUpYTTg6GBJhbEC3d2UjrKD+yGSytIc53XeiPyO5gIWFkIYNSnIr2JRr9+imk/MOkwHblUyrc5AKFzDll8IUE+j6qEONiY/tUPhAwFMU/jvxzncCT1ZzivZIBe2GRi/H9I1UH+GTvkmybkUSn3pXwn9F0zpKYszQrwdyBfUoXrFbqp3iZLu32cMLfGvasZjKxuh7em+QjTI8Am3Bj452HktKd/UrBgtrx004uG34preEYRWw2/t6D2Kh3E6wwclTLXGbCoqyJw7b8QYLEXqAhVSdN826/aUQwsHYoHZ+BqzDXT3b+8jZ6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(356005)(81166007)(40460700003)(40480700001)(6636002)(2616005)(186003)(47076005)(316002)(54906003)(336012)(82310400005)(2906002)(36756003)(110136005)(82740400003)(5660300002)(426003)(4744005)(4326008)(41300700001)(6666004)(26005)(16526019)(8936002)(86362001)(966005)(8676002)(478600001)(70586007)(70206006)(7696005)(36860700001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:36:00.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c19a7a8-4ee3-4ea7-7100-08da641c393c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MSR can be used for controlling whether the CPU boost state
is enabled in the hardware.

AMD Processor Programming Reference (PPR)
Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d27e0581b777..869508de8269 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -548,6 +548,7 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_HW_CTL		0xc0010015
 
 #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
 #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
-- 
2.25.1

