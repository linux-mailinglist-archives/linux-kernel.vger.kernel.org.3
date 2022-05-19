Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C047452CB97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiESFpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiESFpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:45:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F5BA56E;
        Wed, 18 May 2022 22:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW8PuAWF0dqh4cRfPcLKI7cLqWqt9Wn5kc43pL6Sd/gibQhEa4yMrJdoiP9bO/XHzyNiFsqWbKdwbGTd+VeEUL4prZwmh+/R1jg0AkirnTnNTrBrR+gWX8IL7XKDvfnfiGODMCU86Itb9Zf091YoCVnfeyaN4oHQgzN3L7qI6NUhw/HdFb6RrqrM8qqp6nBEDoRzuZ36pv+Lt+5Di+SGSu0MBre044Tsxs9Xne+6bZ4CyWIH5GgtArakDJ8cSzIiArwQQwFg2r62WlhuGI87aDntmv4z6OBRdqF1Z5II+UbRlv+ZAXah1hTxwcbMF/B5s69zT4ct3XMLNBDvF1gdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE0f8ImGrokTIfeFf6tpPAfo9D6Vh+TdCS2d981/FiQ=;
 b=AM1neLWsgvxx24PkEakaHPa+dOacYhpLdPXXJSrVvHBjK9pIg3WyjRcAS12+xKhopRHV+rLD5PbSY3NLeQ6VbljeUbjbmffFzQH1neptAXdkVKVPiJ5lI4QlM1S9N67CnPzy3aeLIcLH1pGwZrePtmELk+yYhh7XtqUhniKb5FRKPgBcjqSFY0uRtpLDTvYzmr3qBBOocrF7OhuJ5POkZOO00pc6xLbKUlG177I8jvCDoO21sURMJbA2gN5b/8p7ihcQk2f7Pm92tPF2f23004zzr+3PU/nhgo8BZyN4YZ4qyqwuwMr2fLqBE5E21WIFxV9FHNxs70MYwVBQYwLxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE0f8ImGrokTIfeFf6tpPAfo9D6Vh+TdCS2d981/FiQ=;
 b=xg23Y4IeD6Usd/7rZEMY618gJdo8PxaNeRWv2cNqVPy/iISAK+g+/bRuSb6EmQa49kT7purDlMNxioKFn52bU+Bj9zwyIF+PVoPLrY0jvhZ9pJAu/2hV5FWs2Fdu9m2XuUegvODtYtqSF9KepQhGHlpL2YOwwXbZOXwn0cXO2Tc=
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 05:45:07 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::75) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 05:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:45:06 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:44:56 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <rrichter@amd.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <irogers@google.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 3/5] perf/x86/ibs: Add new IBS register bits into header
Date:   Thu, 19 May 2022 11:13:53 +0530
Message-ID: <20220519054355.477-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519054355.477-1-ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc23f28-350c-46be-c595-08da395abaf2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46897F5410CFCC8DC12825FCE0D09@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEJ9CiLeIN75jQwEVinw1AoJmjmDZFvSWhyptMJz2vh+vPpwxtko0fGyVrXfTHAoi4OL/lXjW5kWCizq7GG4a0i1hJFjn4IjX7Vf3ihK7xPmoz2ZF7IMBluFgVy90STeJYXlHsJ9z/eDPyRe6p8wtFaBDQVbKC6tCTZ7iH6MIIHP7ZDf4+KmfHOacsMc5JzGh09Ix4bVbVHYa5A8q36V9nLG811y79LbhEguoeQv0QtjbgPpB/b3rosZANKlRyu9mwYAvLIN8mIBHIqH4KrD+KpDxi3nLW/IxkuedNRlSnT36rfQqVRUZqeyKB0uKlr9lVxMNv1HmUmO6pPcejxHdDwcN1JFuXq5+v6c+MNtNw9nlc45E/B1jyGoOFrBp9+18ahboHmdcSRK8FoIcNVdwBsDiZ4tzsjrhiXTi+9oo/sENOuRjVe5FMJkWWjnBnHFctx/Mh+zREeaGKG7NmNPjh09HN634WM2manJl0ab226HacHxIrQ6STDi454UdAdET4axbPlecaTNzf7lDeRaWh/QyivgvpYBoh65uiDbaTDW3WOAdmkOhAZSj3etMWy46WTF4THB3E57PbWPTSD1CSmTTunG7YY8FwXeMQDV8wZgLohrjDOy3jS/XGZC7A1bWmAHQj0ctddeOz1UZ1PRebzwbNfzfQPi/CypP/M+0TNFK3p7G1ZUSCTgremu5L4a5rsCNJJggj5gx0SP18G2HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(2906002)(8676002)(36756003)(7696005)(2616005)(4326008)(336012)(426003)(83380400001)(316002)(47076005)(36860700001)(6666004)(8936002)(40460700003)(81166007)(7416002)(82310400005)(5660300002)(186003)(356005)(1076003)(16526019)(6916009)(26005)(508600001)(86362001)(54906003)(44832011)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:45:06.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc23f28-350c-46be-c595-08da395abaf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS support has been enhanced with two new features in upcoming uarch:
1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
has been introduced in IBS registers to exploit these features. Define
these new bits into arch/x86/ header.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index aabdbb5ab920..f3eb098d63d4 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
-- 
2.27.0

