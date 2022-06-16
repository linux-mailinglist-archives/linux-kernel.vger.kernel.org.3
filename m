Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6669354E04A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377008AbiFPLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376979AbiFPLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:53:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054F2C666;
        Thu, 16 Jun 2022 04:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYkgqtMmGFjnVYkzcqAdkHM87O5TXQCq79NDi5VyXN2U6zGzXHCrnRvGlbh4TEGhqSAb+F63m6rjgq8t4FLyMbPcFvoLCEPsLw7R/FsYS8R2GJvm9SYx/BT9WfbeXf4i8SJOW6DGOXc0KBK9yWf6fxrnkdYalznxPfyNjmvuaLPJdCOzLxubKRsaovCWYoAdAjVoN+AkOkJX0nGy2/F6U1uRyU4bfsixXfUqeIehGzyZ4107ItByaTfmAia+NeTA4M+h/tenYRPyXC4uW1rC5uAqEtd4WbfMCwBse6D3fCDbr+MuZJwGVKfwev/e9UwyvBZHinn5W//AJJKUgM1wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDVkud1DlS0PgBIhMdyeP1kMVmXlRl6qFbw7Is1rWr0=;
 b=LQh0s98PpSWxPdz0+dWLFzSHThnuFflktXfhva5RAFUxjbzzqxreQJiRovO1/3vGvEyCLFqcC3iULnepefnULROKjzvc95EAFZ2hvMe6Ufk2YHdqp8zEkXr2j9X0Bo479x7g3Wd57ghO8MzaaZ3FdpW2VB7ru30lkCsPPBA2+r/LDvJGV/y5sCq1L0xkOjcTHyWm49m/7C2Q3m5AiTCAu/1nSzndxkqS+r8GEJe5kVioLN1wAC4l1NbyzzYtpEui0XsVLkDfm7nmM1GMtCpp0THMBIIGeZt/pA2lHzczbUw27ihfN1oiXXBISiPYa9hDRx/D3DvDn5YaB61L16KbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDVkud1DlS0PgBIhMdyeP1kMVmXlRl6qFbw7Is1rWr0=;
 b=pZbGCmFBryAApuAeA32stQ1r+PoZ4/aWfImNRMB/1HeEFC2GGEZmLNoEhTLxFTavFuY2bTyyT1ZrCc+91UBUfET7SxjTUh5oEIHhIOwZJ72JFMbrutsPECjdpQkcCKG8xqelCEZ2cpion8lbbGH6S+EywWc7BG6TRKmXTn/kbq4=
Received: from MW4PR04CA0242.namprd04.prod.outlook.com (2603:10b6:303:88::7)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 11:53:47 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::73) by MW4PR04CA0242.outlook.office365.com
 (2603:10b6:303:88::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 11:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:53:46 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:53:35 -0500
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
Subject: [PATCH v2 14/14] perf script: Add missing fields in usage hint
Date:   Thu, 16 Jun 2022 17:22:07 +0530
Message-ID: <20220616115207.1143-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616115207.1143-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <20220616115207.1143-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c199f05-58a2-454a-cca6-08da4f8eded6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34032BF50854E7181D13C1ABE0AC9@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRjec4EYQM8ENQ8takvr9IxVXmfSQwJ8gPeOBP7MBdmGuFkB4B9ZWmM/rLlbvllKLhhJb0QNGCJoonlf5rH2nOvnsVROgrTxzsjoefFLHEoa6KAjeAHb9xM6/14qIZjMC1ii7hOgBKA9/Xhk4TKOmgCuPrR9zkwxY8TdGpcgjbUa8HJVamA11QG7Y8xKdoAUuEL87BZmI58paIXHD5UxfyKRijksgVQ30HrAl4xu63d0fssdHleOtn1VFEhcUJjnfuEl1uAVfHSv4VOSVoQRwaTpUXvjyHlPsEy5nAsTNcc752vJaGVJGFmmhCWSyDnJ4BNABwTsQ3+26c8MW9Gi5bGNdAt147NKS3sB5+fY6pKk/HOHViRluP8qPbze4lYdLzshzgq0GmVGGpVMOiU/jR4pbUB7OpCnpVrYKSQSB0TtdUh7DeVsv+aV/1FADpMoj5BQ26m5PN/GuJeZVz/NyfRX0PSKekd/tTVr3y/GF6XSOadoQVOYWaA7yfsW3mDAkyq4nMXyaTX6k3OVTcqqB/NNJvOwYSbrslDPrhQVOUNmmJpCnFn+Y89xP169A3t2PL7tyHLGj05bkXYQlPRQh/vT25a7pGJobDeORYl6AyCwviElSrrldsqY8/tExA9bgtchFaYEZwRdwHRoApSXggfyyKhvslpaeOCwUI93F2Z95rEUrhmxEyEa3A41q9UXaFvXHgYYuK5l6WVspGb6zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(110136005)(86362001)(508600001)(8676002)(186003)(2906002)(81166007)(54906003)(47076005)(36860700001)(5660300002)(356005)(4326008)(26005)(6666004)(44832011)(316002)(8936002)(70586007)(16526019)(426003)(7416002)(336012)(83380400001)(2616005)(7696005)(40460700003)(36756003)(1076003)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:53:46.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c199f05-58a2-454a-cca6-08da4f8eded6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few fields are missing in the usage message printed when wrong
field option is passed. Add them in the list.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-script.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c689054002cc..35e10c71692f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3824,9 +3824,10 @@ int cmd_script(int argc, const char **argv)
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
-		     "brstacksym,flags,bpf-output,brstackinsn,brstackinsnlen,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
-		     "data_page_size,code_page_size,ins_lat",
+		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
+		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
+		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
+		     "code_page_size,ins_lat",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.31.1

