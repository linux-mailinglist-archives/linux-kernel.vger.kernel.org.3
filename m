Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30454E038
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376648AbiFPLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359805AbiFPLrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:47:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E69DB7;
        Thu, 16 Jun 2022 04:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIc7+hC3yVRTT4maCLSlWSkCiTX3Qy1TkHPYBRBPGLllF2Jc/gZDNaHUgU11RwegSSIHiPeKOZQN6+alBVXCC4LYjNNTJrevksPWvY9uXAwiO0bGRYGx64zTx07pfTycvwsG6WDYbsRMt+YdpVFMxnP8Cf4juv3kffpcvMyfcpPJfoFoDwVJpDywDAQnu9OeUfDqCfWEfqvUTR/qQzCMrnJcOJSa05xI4IHSDgX9JZOObm+p00ju8KJLvZDHjbNmjr7k3xNt4GClBVUtdDXCXgi3HbNTuj0xCCNR+wO3ZQNe+Me6Cm0Gcj1DH1jkcIzBwYL3R2KUOv8yhKRPjCEoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f39rqLK5PGSuWnNV9lpPQWyE78LuBKRyk9++JpQ0DoM=;
 b=bcXjiSg37EofaErwrio93mUH+ZbZV137AwV60HmMB6SFTuUHVTiF2ij4r/9m/XqYUZ+VXzUS+SznYYe1HcmfQ5jGP16qptzqM9IPlTT11bWwwsl1jNbBleOa1p6a6iuk1rV8VDVTot+5dwiQdctx4HA0AzK+3RG674cXoSnZHCuNVE650CZcdYNV9tF49zP4OynPOr4KCUcrw7nMyK0eEi2oyr9ZlCzfeLfrrnXjWk9NAM4mCN47R8zHhg1zV8inbexXezHI9I+VA7tX4IqphraDRbN65LV6ct999RckK6wtmGnfo1h0vLGnj/ZAOEHnWk3OcblGlVRuXp7VgFAFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f39rqLK5PGSuWnNV9lpPQWyE78LuBKRyk9++JpQ0DoM=;
 b=vh79lfPYTccj2d0S1YoDB5Tk7ijV7GV/K0ltVzEK/zO+v9pUsJIuc/d5ZSn2SI1wWD7DBoxs76/FYFDNwF4X01kcxNQBmRbJdT7QaW6aWN9xyCYwtBcrfU73tsexMuBdMmpBUOGh7WpUx1LCyM5DAVp2QQ/FGfVvRL9k/QxQz48=
Received: from MWHPR22CA0069.namprd22.prod.outlook.com (2603:10b6:300:12a::31)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 11:47:28 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::e4) by MWHPR22CA0069.outlook.office365.com
 (2603:10b6:300:12a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 16 Jun 2022 11:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:47:27 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:46:32 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 09/14] perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Thu, 16 Jun 2022 17:06:32 +0530
Message-ID: <20220616113638.900-10-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bacc42d7-8d36-4451-0e14-08da4f8dfceb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5705:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5705D93546BE53F6E93ACD14E0AC9@BL1PR12MB5705.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txh+JdEu9ldxwdyCTm66G1wmoPg7/fUPTxezdxkLYp6mjjDL8DtoNGvB2a5HYh5oRXHhMfaVN4z4nb3npArqf5LAA73Vayt8mB/O1wcoyCCjkGqAY8UJqty9KXi86UUh3EZ/hhgEGANDLHzgstos39N4IkX9PTeTVL7P0b5+nQnvdCK34PBWwBoutYLu5w7iAHld4BHZ07Kfam0zewLq+HTCcncaFFz1iu8ILUXcH0m54GS7+vsvvnZ/Y06kSgsl5Xej4MZgjBrGD4fL5zO+EOxr3GUSKBZlYhCCNewFj7lMwF1sx3yhxyDo1TZejYyUwE3NoZt0nW7A4XjuLbd2SQ+J/o4/dCNSV8F1FmZq1y9/f6PA9E4wFbew7eN64o1efdxhG1TABilyra5HaXdH+Kqjac63CGQsx+IhTAY/GJhzeqTexqJTQs/M8lNZtjfmUcx4qMPFRtHMbSqIzUit6/vqcnjxRTNM+v1eMLEnRWO+AuxwS1gVwhdHCAuKzRXACdItkBfj9lBVqAObo61Sal2LPjQb/zQViFOncPzCmwtOvnPy4SM3rNFAejDt6bNrnht0D6SYsqreL6iw8o3klr4qC2NGBcjgVCx0AHteK2qZzC69+lwW3TX9m2SLodDAvC0a6OnQn0jvNnGhc5eyAkJUpl51pgsR0QupVzvr2nWRy1MOpxiZCo38jLhRAHLeE9MgejgHyWs8K8L8koKXwY0Fois/aphw0Ulm0K92riE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(7416002)(8676002)(70586007)(70206006)(26005)(81166007)(356005)(316002)(4744005)(54906003)(7696005)(44832011)(110136005)(2906002)(4326008)(8936002)(508600001)(47076005)(186003)(16526019)(40460700003)(1076003)(426003)(5660300002)(336012)(36860700001)(36756003)(86362001)(2616005)(82310400005)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:47:27.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bacc42d7-8d36-4451-0e14-08da4f8dfceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for printing these new fields in perf mem report.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c3c21a9c350b..4a55cdd51bba 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -294,6 +294,8 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_EXTN_MEM] = "Ext Mem",
+	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
 	[PERF_MEM_LVLNUM_LFB] = "LFB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
-- 
2.31.1

