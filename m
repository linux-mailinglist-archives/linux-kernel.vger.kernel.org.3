Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9458FCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiHKMsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiHKMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:48:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30F2558F;
        Thu, 11 Aug 2022 05:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlDYp/dATO69UqD9ixQwpio6xNMA6yGFP5YoRycHXpgLoIj0bnteQIehr3Y94JXwy2FHTk4GC59xf/iFE7qOodNdcR9d2P/4aOf+4k4lubfnXk/axoDVy7Y0FzgcNcWf08+IUU0wJzk3qxFniXP+jAukat7/KK1C9B45+8VMRiHhgtsmLIgWEMQziGOpZlHYTCnw7szqRyurWAxCC/mPEVEl+1IbB9za/2MZ4StKwYhP8NmC2v+yhDl9EUt2DbClSj32GXs+LqJSOR15bQPNfSvrXpP8FOl4dk9kZJHTAjv6jZ1CYYIKmnc+KsvPva3SpI3qKudWmdXUb2im7aU6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GV0rOy3hFnvC3sfPV4NPUw+DJ9HJuuyqL82CTEin0E=;
 b=FWry9i7fxKqkRjOzgNukF09uMhMNaDjSP0n0estf7VdQwZlasCovgAPTF6OdNdUPcyGzJKZzjPsL/VDr2DXGUKgYgzj/pUnKtk+cgvjBKpsPbYjlwgmrREm4CzeuFhE0bTgE4i+T/EF1NgSvIaqWeLZ8Woq1c82WYgJOuQczgU+f06tLQEzI4va8huc7aqVzTQdNuefh4iw59kA1kOw7IFlhXOqK02GcoqdNsqk3b4aWhVZ3Cbmumx4ioPEtfPGldQUbiUKbNafvK+iXu2yzffJS26C2wRxfHrRvp7/3GRBK1TY1iCaGgxTVgVqgG3V7pBe7Bh2IdYSBTJ8fLdAJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GV0rOy3hFnvC3sfPV4NPUw+DJ9HJuuyqL82CTEin0E=;
 b=HhJbq3GUqH4nmQDgXv6yF7oatq+QijLzf6o2ujOlL+m1YjsfusiLydMXANpXwkYABudt66moDc+oTYYk05mPIVPEk8RadyNOuuIHqcVcSrCCyO6iXdT+vpgvGYqOvxGT9MdfaH11Aly9MCmunpF6VBvV/YRl40pZ5mhH0QtUpM4=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 12:48:41 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::2) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 12:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:48:41 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:48:12 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 3/4] perf script: Show branch speculation info
Date:   Thu, 11 Aug 2022 18:16:48 +0530
Message-ID: <d56c9d54839b9f114525cc31cc4d9455f1ff6008.1660217326.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660217326.git.sandipan.das@amd.com>
References: <cover.1660217326.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8428e82-bfc2-4496-1319-08da7b97d1a2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpQltuyChi+d0nXj7fA8TSNuKbyssb4ePOUMkYG+D4IgzYmXKRNrfy7UN6cD3SoatMs3yFZYgUvCAkyZ6AtFO+u4FEQxpxYVF2CugPJeoGa5nKVpLp3Ev7GPAyPXNuhLPURQHaNq+KaotAmZTgQbo4iRywwWpVtgl5TizUDcOHHIISmVnpUZie6HizCkHEtwUGy2DF3/8bQbwLTPU0W8FRznX5TpwDpke8rmlXTzasoKe97KDtakjinYc/wurcj/8YMt8nqrkmzxf7dgQLNbWck3PiVgdwAyx+8dqLs5yzt9WLr9f1uaNzB6LielZI5bFxzupFfOJZZpCg0XMA5bc4QzL8OYjFDMhEVv9lR4k8JcSyzmDV+z4k9Jf6Bk0SxFv4hc3DT86KzVLlnq8rtHnosXDXQ2hvEFddK4BOhFbAS1Uq/gCrQSGnl6VMS/BSBO+lpC7vA/yDctoUVBia8eLaIeGZ7zdwSFbyP35ptCs45U7GsJD8Kw3FxVCkoboQv5TsPDL9D9NWYeXIzxdx8MMfDvLLmj4IjxWYMh30kCgTqiLh73iAwtW9L1pbihzGS90VabsM/No6PhZtzyaq1513OpadBmnIrS3aq2/Ka35ICg3oic+oAo6Tytot9+KCV1MjrAPdRXQ1RHP/Pfd7z/edi3423rd06b6nOpS5nVck79Y3xDXnizpD1ao1oAit5Z1/vic4ARMyTXtLm2SqJfbxzXt/xsS6de/4PKfdjiakG6qZSjQEc9WbLrF24Ts3MglR+LkGPmn0e3zlsto4ZH1lPwOmG6l3fMNCVb9a3986lE7XfBPuDf0h3KKpJdWWUv4gOIeHbrSV7+RnJqA+Wkxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(186003)(316002)(336012)(16526019)(70586007)(426003)(54906003)(47076005)(110136005)(6666004)(86362001)(7696005)(82310400005)(26005)(83380400001)(2616005)(478600001)(40480700001)(4326008)(44832011)(7416002)(8936002)(41300700001)(40460700003)(8676002)(81166007)(5660300002)(356005)(82740400003)(36756003)(36860700001)(2906002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:48:41.1184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8428e82-bfc2-4496-1319-08da7b97d1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the branch speculation info if provided by the branch recording
hardware feature. This can be useful for optimizing code further.

The speculation info is appended to the end of the list of fields so any
existing tools that use "/" as a delimiter for access fields via an index
remain unaffected. Also show "-" instead of "N/A" when speculation info
is unavailable because "/" is used as the field separator.

E.g.

  $ perf record -j any,u,save_type ./test_branch
  $ perf script --fields brstacksym

Before:

  [...]
  check_match+0x60/strcmp+0x0/P/-/-/0/CALL
  do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
  [...]

After:

  [...]
  check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  [...]

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/builtin-script.c |  5 +++--
 tools/perf/util/branch.c    | 15 +++++++++++++++
 tools/perf/util/branch.h    |  5 ++++-
 tools/perf/util/evsel.c     |  9 ++++++---
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac19fee62d8e..d294ac804244 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -872,12 +872,13 @@ mispred_str(struct branch_entry *br)
 
 static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 {
-	return fprintf(fp, "/%c/%c/%c/%d/%s ",
+	return fprintf(fp, "/%c/%c/%c/%d/%s/%s ",
 		       mispred_str(br),
 		       br->flags.in_tx ? 'X' : '-',
 		       br->flags.abort ? 'A' : '-',
 		       br->flags.cycles,
-		       br->flags.type ? branch_type_name(br->flags.type) : "-");
+		       br->flags.type ? branch_type_name(br->flags.type) : "-",
+		       br->flags.spec ? branch_spec_desc(br->flags.spec) : "-");
 }
 
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index a9a909db8cc7..29d89425a011 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -146,3 +146,18 @@ int branch_type_str(struct branch_type_stat *st, char *bf, int size)
 
 	return printed;
 }
+
+const char *branch_spec_desc(int spec)
+{
+	const char *branch_spec_outcomes[PERF_BR_SPEC_MAX] = {
+		"N/A",
+		"SPEC_WRONG_PATH",
+		"NON_SPEC_CORRECT_PATH",
+		"SPEC_CORRECT_PATH",
+	};
+
+	if (spec >= 0 && spec < PERF_BR_SPEC_MAX)
+		return branch_spec_outcomes[spec];
+
+	return NULL;
+}
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 17b2ccc61094..8563b88b8281 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -24,7 +24,8 @@ struct branch_flags {
 			u64 abort:1;
 			u64 cycles:16;
 			u64 type:4;
-			u64 reserved:40;
+			u64 spec:2;
+			u64 reserved:38;
 		};
 	};
 };
@@ -85,4 +86,6 @@ const char *branch_type_name(int type);
 void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
 int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
 
+const char *branch_spec_desc(int spec);
+
 #endif /* _PERF_BRANCH_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4852089e1d79..e47cf16bef0a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2313,7 +2313,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	 * 		abort:1		//transaction abort
 	 * 		cycles:16	//cycle count to last branch
 	 * 		type:4		//branch type
-	 * 		reserved:40
+	 * 		spec:2		//branch speculation info
+	 * 		reserved:38
 	 * 	}
 	 * }
 	 *
@@ -2332,7 +2333,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 3, 1);
 		new_val |= bitfield_swap(value, 4, 16);
 		new_val |= bitfield_swap(value, 20, 4);
-		new_val |= bitfield_swap(value, 24, 40);
+		new_val |= bitfield_swap(value, 24, 2);
+		new_val |= bitfield_swap(value, 26, 38);
 	} else {
 		new_val = bitfield_swap(value, 63, 1);
 		new_val |= bitfield_swap(value, 62, 1);
@@ -2340,7 +2342,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 60, 1);
 		new_val |= bitfield_swap(value, 44, 16);
 		new_val |= bitfield_swap(value, 40, 4);
-		new_val |= bitfield_swap(value, 0, 40);
+		new_val |= bitfield_swap(value, 38, 2);
+		new_val |= bitfield_swap(value, 0, 38);
 	}
 
 	return new_val;
-- 
2.34.1

