Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034A54E041
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359805AbiFPLwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiFPLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:52:43 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A5BC3B;
        Thu, 16 Jun 2022 04:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7gVf3PhzuU0EjV+5H6bPfZ3KaGHnHETJ8100FmvTQPmOKUpc3rLNTBqkamU5TpaK8U+M1sOnAq3alGgEHjg4oFc+qTQAA6jx9ZYPkn82czvt8ApDmsLjYaHh3Gl+YMbTl21Cpaps7pKH3T1HHVctBUfFjmU62+tcwtxptFsq8+Nq2OjhZ2BfsdVgndGRbb56+JtRwcHjcHgk+Wc1z/MtDLiEpf5mSVRzI9HgjXDlyCazFcbzlFyHyxHPSE5p54zXwNq01av57BpLtKo3e8wFIviNgV6nmbFn+iYanCic7a2Zpf9kdE4pwJEYexAddqVRcLaFZZ0S0YWYhb7zvxGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMpf3cBd5JWv3uuHuPCCF61aUtVxerEimuTbqwTc/yc=;
 b=PUfkmlVUJLRgpKnF7qG2S+aO+afkbmTRqgmNAVDuWwpx2PnvlSenptEMR/wM9tuX9zbfCvMEXrn6yGMn5/lE5TUfvpW3jumEEO8PQpthQ3ZnDDObjmEvZGXeOgMmnPp/8eE2dnAkMWUC7VZYcynKD6Dzeuq1BwTJtE4jf4K2KDcQemMQaIoqrrQ4ZRUaTKoKXMJ5MNru3jIRdCxZ+UPxY8mUvzPBFA7w/6ruusgdvPC6Lh4gJBGQtudoHXCzbI36VCjBVicWdzeXizc6Kp0+4eKzIuukI219AKbyAJVzslYjLU6TydpsZNBTgKQxF8lozlmm8B8kcLgKsLajjid+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMpf3cBd5JWv3uuHuPCCF61aUtVxerEimuTbqwTc/yc=;
 b=dSIS50zOo5pkRvZ1c00+VdxdQWKdyutNu+QDbC2xBoDmI6T7yBLxUOjXqh1rwGk2F6Q5GEta3X9FfH9kyGU8RIh0GI/vB+JzfOu5kiMdb3r+krEYEHg9qyes0FuNEVB1vFq8Z5pz5ROa49cIbtDRL0STcBhm/Wc/xqnLbM1BE/Y=
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 11:52:37 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ad) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 16 Jun 2022 11:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:52:35 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:52:23 -0500
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
Subject: [PATCH v2 10/14] perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
Date:   Thu, 16 Jun 2022 17:22:03 +0530
Message-ID: <20220616115207.1143-1-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87b7966f-2ccc-4699-0659-08da4f8eb495
X-MS-TrafficTypeDiagnostic: BL1PR12MB5876:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB58769F796B9AB38124088926E0AC9@BL1PR12MB5876.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9RRzRLFEkiHOhKP2mMKdU2xTNMZZ1zvjs+8xHhKNakLaQlrDu0a6/LIQ9RPWGxUUfMFMKMYHE/Y5+dIjtLzg5AlmMg5xR2bHQ1K1dXpvwmaeY+zbOmye34Mkq2VJK43FgD0JSgAX4/i3SZ1OVVC726TgxgpWWyG0lRBBm3mYOMaDGH9/4NjjzGIzudm2QBMnkebExjZGAy2aCn9iZ7Nc6EzuQtSSe790D4AAGSP+47cBtXqbFRMPCfM0anVR6J0rDJuarIkpNnuLNHjBj6wzlivN9D8QQr3OlfTTO723eKL2TJjr7a2sxLofGJ9iRjnfL5BTajDDJZsvmo4mYDyQgIpwLItWDMYjwAjeElrhRqB81Tn2SQYrHtEbH/JM4ZRntgaW2VgQvkGPRFLZ4+2x4Y40LBIWs+eFofCCJuhLfIT4C2E7ydxYE78QkoNWps/SZ5VmZFSCCw+r2tdFyz5RwXDJHA6CZkLxnNTBS8py7z10JFt76JrDkz3WQ0mKDj6oaGzpPJKnQhfFTqsOkfgekvyPvl8SN0JhccUfFOdgbt94AkL/p+6F3hf4Eqp/IagetMBKG5WoloVsZ5X3BJG7M5RBwGVRP0RPLO8FZoaUozl4M6MI5nvTjRnV8UMWccV2RezIEUAIz2sIMfbA+eABEISpNKB1VJUcyx9NF9rLQqxA0okikv83HRkyYPPK7xi/djAHbocsdDjBeKAIrsnY1yV11om3sJC1CE8t8YvKKAAftyZq65GPD/gawK5IOMx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(110136005)(81166007)(2616005)(1076003)(86362001)(54906003)(2906002)(7696005)(44832011)(186003)(82310400005)(8676002)(4326008)(26005)(70206006)(7416002)(426003)(16526019)(336012)(316002)(36756003)(47076005)(70586007)(40460700003)(6666004)(36860700001)(508600001)(5660300002)(8936002)(356005)(16393002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:52:35.8087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b7966f-2ccc-4699-0659-08da4f8eb495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf sets PERF_SAMPLE_WEIGHT flag only for mem load events.
Set it for combined load-store event as well which will enable recording
of load latency by default on arch that does not support independent
mem load event.

Also document missing -W in perf-record man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/builtin-c2c.c                 | 1 +
 tools/perf/builtin-mem.c                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cf8ad50f3de1..cf68eeb08316 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -397,6 +397,7 @@ is enabled for all the sampling events. The sampled branch type is the same for
 The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
 Note that this feature may not be available on all processors.
 
+-W::
 --weight::
 Enable weightened sampling. An additional weight is recorded per sample and can be
 displayed with the weight and local_weight sort keys.  This currently works for TSX
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4898ee57d156..3bf3db6f889c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3034,6 +3034,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		 */
 		if (e->tag) {
 			e->record = true;
+			rec_argv[i++] = "-W";
 		} else {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 			e->record = true;
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9e435fd23503..f7dd8216de72 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -122,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	    (mem->operation & MEM_OPERATION_LOAD) &&
 	    (mem->operation & MEM_OPERATION_STORE)) {
 		e->record = true;
+		rec_argv[i++] = "-W";
 	} else {
 		if (mem->operation & MEM_OPERATION_LOAD) {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-- 
2.31.1

