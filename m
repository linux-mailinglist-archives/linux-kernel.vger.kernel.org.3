Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81750D87D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiDYEth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiDYEsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:48:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A83630D;
        Sun, 24 Apr 2022 21:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiHVkB0snujOaga2BBIxeaU5A9wUuf4CVuX5t++Gf+M/LEUMDosxp0/GZjj4IMvxDn9YPgQiVSQvMWzADON5agJOnCkESo5RkImFPsVJfND+vXVffVaTX4GxVQ8TIJTk8LUoy4Dmk83u/QPHFiwDvInpFSE3HE06KCMFA2FwLkKUTjS0foZDxf17C2keReaRAiAXK3jePRwDJETZBlj0Q/ABDH+0NEhfFxcqmsVE4obZ8AP4i4KlygAqwOGUWAO2FuG3iU2+YiVgvx+3v7f4PwggyuvXTymEdm7e4MnhNfdittDR3CeL8SeuQuPzraL7wWLssu0SWXU6Ifx5ozraRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpZZgnX2sIcP5d5uiWfKL9gkpNXUsInhcxxNKShHUL8=;
 b=C4ohQtPeIHhhPd4tMlKPvokagdV7SGCsPhDlshCBUIOdRzid0yxazDPvcIkN9hG95orX+gn88UjJcyX9rz3POP/GSlvzdHosiJ3nTtqPIdeu9l/howCUO+klOl91ZplkSvML6nsLlxLg05SQnl3sq7qFiEhi/ldCYQtVNYSsrWYjBN82kep4InXxrPFjCwf2rFqNu8DYuvZD2O7Oq3NmuGv81Cd9M3XOD1WmjVoYthf4p5EViyawrUXvE6KAgkvUAPmGrxOFpW4BDE1BJ9/+FUC++VW7kfOPCj1JEn9/PfSoDtg16V07W2Q8HOC+5TdVmtzX2fvT7PU0QBxvmjys/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpZZgnX2sIcP5d5uiWfKL9gkpNXUsInhcxxNKShHUL8=;
 b=dIeZVTcB/LFQVMTEnu7QV2dFzpq5t6XnIFoDGi2vLZgnMxAQx1/IZ8mp8UAu7VLSB2oSr7e/TndCF2l8kX4vaT/GDrWMFeKA032CZOMa0RbA7BBpKCXSYiSKfcPgkuEY7ymSQPsUdaH6lGdcql0AClur9Ict0Zi9tQs2kz0Wh34=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 04:44:55 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::2a) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:55 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:47 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 6/6] perf/tool/amd/ibs: Fix comment
Date:   Mon, 25 Apr 2022 10:13:23 +0530
Message-ID: <20220425044323.2830-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425044323.2830-1-ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b9f196-b21a-480f-fefc-08da26765826
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4530FDF5597348A4D8C2C468E0F89@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMPEcjpV2sCyHM8mL9/YRrAlCtqGxzkyan8vSfYgsaBZZU2ix4ZjrBvTgF2MPIPAqj2JkgiRctcQ6OUV9jDsvjtTJvLKf20vWsqKJbO619fvTPW9tNwipnFNBYxCJwyvvQzo2adAFPcZkQU/F8DSczqBxL0WQQR1o3m7KOWQS/iYagDIrhFmiU+7L1ZwKsY5l2VWBfmtqmh5ds9YCddyfjD4VAQU7b4MXeMaiAE46+5HMEGGb7Bbg9cS9qSl7FnHjHegAeHMGoabiNB+j8metVU1HZfohOkR0YJHXfgDbxjKIfUW63z1Z2yNZSxidWVTy7NYq9otgD2HwXq3rdSUNpPFj1fimmTwhPIUIu+Mw+ZSZ+qRnogmSOWlZ8B+ekm9Fyp6gYNsaL9DRXhEtCBcKq/cW8PrH/MwAF+pB2LyLn3q67AHz7meoourb0Ga1DbGMIz2YgSDue9Q3sVqTmn4ovM9u36dsEIllfvOLAo1pq5yecVtdzgEClKNPICBCK0rXmpslnQCaH2hvz3MWOvgp+dBBja9wePaMIfIgGvr3Y45VuA9iJrRRfrdQ6mGvFdhTn8p6HTJQWoj9EPN8E+lapG25Si4ilUXNzziPaH79ujCRm9Mx6L5U7O7VAIpvN29IF6xWjAC6ovytNiW2bsSAf4+7lplOSdmkU7CH9nxPDc73/zzdszVkdgIEVMMSQR477wAOl5YQcGln+Ofmv7DJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(70586007)(70206006)(6666004)(26005)(86362001)(82310400005)(8936002)(4744005)(316002)(356005)(54906003)(36756003)(44832011)(110136005)(81166007)(40460700003)(8676002)(5660300002)(7416002)(508600001)(4326008)(2906002)(426003)(186003)(336012)(1076003)(47076005)(16526019)(83380400001)(2616005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:55.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b9f196-b21a-480f-fefc-08da26765826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/IBS Op Data 2/IBS Op Data 1/ for MSR 0xc0011035.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h       | 2 +-
 tools/arch/x86/include/asm/amd-ibs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index f55c299554a8..1a5dd23cf99d 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -52,7 +52,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 94b75721c3c8..0780c848fa6a 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -52,7 +52,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
-- 
2.27.0

