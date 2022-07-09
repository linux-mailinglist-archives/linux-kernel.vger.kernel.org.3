Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7A56C9E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:17:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E9CE32;
        Sat,  9 Jul 2022 07:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abJ0hZEjpx8Xaf0nsJ65qnk9gEtWof1ToIf63WPlRp+zfEyL/QFuC5qo+mtPDY9PB9P8DNtRUab8rpB46RbVCYIflNypYbg2Iez3EfUAl6m2KAz+7lUmTIe3cCWOuqJ8v9l5NMxpponfrKWR6/vgKrzTO7EVj/8v7Tmu4JFfJ6/L7BruMAeDFf4YBlfmXdkehTOiKToL67oV0M2Yzvepiu5ywE3lWdyBFUxgcig5nW7S5G5mZ60JaohABQqHfM5cs9AETqrHzih0NVKWDEf/XT722xg50HMRLjXEt0ga/UieoknLp6fyhSt/4AteuxUe/q03G1p8HmoRgBNbm2lXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=cwgWpJiMX+yGsa9x3NpFylPcQBW5r9W7r2LuJoHaNPEaeDR1QS40c4/acoUcOHaTQERFVxn6ZMVcAEHkwwAGG1UBl+/s/2v36h0xcIOS07gs1s6NYslUHlveVgBN6j60xx3mCbK1YRlJoG3OIf2qlYxxZkQ+qAfBGuDLIIpHaHk2h7r/i+WNvG17E3cykCuUc8uJD4AbGT5KKWeuYrZK9xGcWYYH0DAb7/gfOB28uEpn4dIPNAxGSFEhtkS5aHXH4u57nY5l43i9kK6tsSu3UY71R6a+g7ksDToGAe6Cln7ot0y6Ymh8vsG5Kq8kPeZwwF7FdmVdWB/aXSc5pDa0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=Asdlz2CcDpogbFBDCjtk82MgloQMfc6oqiyCa3rO0Grsh4b3pjrLl7QGktnWjpJcSo8v5q4A51Y4qMxzuCqJDK4r4IOCJuJQG5xh/gH5Td7ngT4c7fsmxi65RV49jyql7oOjEA1Iw3FVr/cdmGnQdGoMrCnhmajJfk1MGPfj7gU=
Received: from DM5PR06CA0096.namprd06.prod.outlook.com (2603:10b6:3:4::34) by
 MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Sat, 9 Jul 2022 14:17:39 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::c4) by DM5PR06CA0096.outlook.office365.com
 (2603:10b6:3:4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Sat, 9 Jul 2022 14:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:17:39 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:17:35 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 01/14] x86/msr: Add the MSR definition for AMD CPPC hardware control.
Date:   Sat, 9 Jul 2022 10:17:15 -0400
Message-ID: <20220709141715.834713-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3f1730-c20c-4c67-4a64-08da61b5c7c4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQi0UmND7ZvbthNm5x/kRKw5khRSuu194UX/QqzdSnx/H+Zb/M5ER2fZ3X8k?=
 =?us-ascii?Q?ry63yrbrDxJxp5ydnAjCFCmq1OUe6o2pyJMK5iatNWlkJQ4YdncAaoHxlKWq?=
 =?us-ascii?Q?pFgNib6rMQX5gV7l1IRpl6MjkOqwilAHk432N/6F3n4qZHmeYH7oyNEQ+x3O?=
 =?us-ascii?Q?EA+b8nLJv1Ja9usGXsv9dhz89eMD5IrdCWuAMbmg/BZPbBjtydOri2jx/LoF?=
 =?us-ascii?Q?9RAyHSVmTxj+uA+PRulaK5Rs3NtAzIUeZmtX8lTmyUen6QTPvRCiUDvY0j9d?=
 =?us-ascii?Q?+NwZyaGB5Lb01MdxzrtRGUIzl36rgVf5a15WTM23NZ6tDtD1zc2VA+7lN43V?=
 =?us-ascii?Q?VusJ7zEKOzD1puqHjG35WSqwVPqBWmY50Pz/HfbVcvQMLaLfbTAVMtTJwmRQ?=
 =?us-ascii?Q?UL0Wa7+eOknyOGorvbyoqNgv7YZL0ueaX9h8DPCeORmPFcRHrXiBHMGPVbCS?=
 =?us-ascii?Q?lTok9ck7WFKQMVQfjrHG74QrdrjHaC+EzBRZC0UB0gdbVnACOGx8CBNT1e9k?=
 =?us-ascii?Q?WEdPUuKWp8veqjtihdbm5vDK6Q0I30JRSuK+VmuRbah4UHYV7snrSgXAAENF?=
 =?us-ascii?Q?RHl4Z4CkRWNQV47/Spwcu6p+3N9RhWmGI/hYaX3iGxKhlJ151UALu3T+RNwp?=
 =?us-ascii?Q?VLNcFdoTKHUQL4SJviJK0fqbuGJgDRoPXJGjOXuBIthtWe6/x9ixk9OExOnX?=
 =?us-ascii?Q?njeR4sTuz8jE0J411GLE+R/UGUI19xYAajNGl/WImX4vQa0h93DyO/zpxFBf?=
 =?us-ascii?Q?EPeB6niqN4jZOYDs289cfY1uEh80XfrfS1PbE5ZtYidI1b9ZDNvDcXQ/GDzY?=
 =?us-ascii?Q?ET8s/w15W/allyPExwZZ65Rahahdp4o/tbty8Rf7s0M4RVWp7A+klD+BUM5n?=
 =?us-ascii?Q?yprZbKSD+a3zx5YNvBIc6oLebeCW6OpcO+zotXJP1rYBJ80AspbJumOaPcfI?=
 =?us-ascii?Q?rd2ICx/vicAqr4SFehBkNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(70586007)(70206006)(26005)(966005)(40460700003)(478600001)(8676002)(36756003)(40480700001)(86362001)(4326008)(1076003)(110136005)(8936002)(6666004)(16526019)(34020700004)(36860700001)(82310400005)(186003)(4744005)(2906002)(54906003)(81166007)(82740400003)(426003)(356005)(41300700001)(5660300002)(7696005)(336012)(6636002)(316002)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:17:39.3757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3f1730-c20c-4c67-4a64-08da61b5c7c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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

