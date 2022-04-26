Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90BB50FE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350632AbiDZNJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbiDZNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:09:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C762D6;
        Tue, 26 Apr 2022 06:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrvmmGECTWOp9rHmK9U5TS9roR+IERSfW3KsrMBja6ityIdX8VwroSdX4sh8cXOuPHpjBR+UVk0vLqA+qk6MGf0di8KyWlPPhY4o3rlmrV2BuVNepQ4ZkJJYtat+XSG38yoMWyUSiJC0UJnCygxSNIYnvNI4qr7tS5K0v6KNdjIj8Sdf5+xLCm+LB2HdUKJreGK2/UKNHzy5iJagN4a3GRz8cqiD8+A8cz7HwxfNq79BBI02zDWfe9tJla6XsM4VSsz6wK/3hugosFX+XnnrwGWubYHbOMMoLIkgaVO8WzSiUUV4iOnoqiffh0M7WRNfJD9y2Gs20qgwmzM7lqr06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0U3EekqMxQOfInrtD7Yk76DmXTjrwUwztJMahOcDc0=;
 b=Fe0U/6sPgmxGGPiwxyPMA55U1wrEkXmcV87eVOJD58aTGKAmhF9LH6qiAJxLJSeg2XvlnExmHyNOI6PW/bNT3pcSuUp60VjWZnRO424c921l485Nx3M3Kkz5bDlNJXMGzE6ML0CZJhX/sv37aOoX73pPWOfDMB2vy0W9jcPTn8ZQJlKoByzbokgMCy40MgjkJJu+8i2obHE+6lCXuqxW2lymBLZ7GBFx+kHKm7oNVxsDx7iIgzzF55ZoyT3I9F7eyy1D7GQfIe85Zdl//Lvq02tK2NnnKZ1+iCn7Cp7QXS8LXQ7tBhhrbTUDNUOexo2WpfyuD2EQ2Sn3cm/3WTp8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0U3EekqMxQOfInrtD7Yk76DmXTjrwUwztJMahOcDc0=;
 b=ixXcdLToGFcaAi/3IXUCfcGlJIvSfw7RNNYJ8DQdFBXWIddeNomeWMvGfmBoJ+8XUbABp22OtTnpNiBeswrVRiS69mrnxyW33nAU/IpxvwSFYCeyB83XiuWNxofEoa8wt4LWgc9RimJE2vU3FdJ057UPXfOyVcVbFrV+F135RKI=
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 13:06:32 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::da) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 13:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:06:32 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:06:25 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <puwen@hygon.cn>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 2/7] x86/msr: Add PerfCntrGlobal* registers
Date:   Tue, 26 Apr 2022 18:35:33 +0530
Message-ID: <b6a041871798a300760d088b7b6881db1f38221d.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650977962.git.sandipan.das@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23d46a7-dff9-4948-18ca-08da278595dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3376:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3376B8597198BBAF445A1E9E8BFB9@MN2PR12MB3376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7soNTA3S0hVTg3zCC8tAAmKALICiToc697htrdlAOFhtfi3T9k/+hJiRbZjxPymr4xDgmjnglrNxHpLBxGvFOkOeBTpFapShwcG9Bgy+hUeblGDbUJbkX3Gvxrn1j2VTHvZZEj6XaDiNdt9gT31Ec3MKA5KXndXGpIxI2gnZyV1eEvMcmNam6g+Wipp1XUzc+fal+7hYD+FuHNb2wGJY/gmG98S6H+e3h9fJZzImKNZfM467JjZr2WhJZdchMhocx7v2Z5sS84CwnMiVEqNj/Xv4xZIBkaCjmvpExWsbANOufSFGrPkki0knr8WHV0cRg4cGHl697Luqm5l7alskBzs4E00DzKXsROzp5rj//wIaGub1xeg0qFIaxuVGlSvrnmGZOs5TKNG53IlMpbeyeG30Gt45e7OZYRXs7gjJJHIFSRox/EXdIYub+OAqWvpEhhbw2Vx+C6QON3pqbg+Na0An8DLLW+uIeauBdfhoHSCsDLgs17XA7aFtLTnyuJZR8PvVZxksWudr8SnPJfzQSTrz6PtHRgjlI6ReJ4H9KTReEO0JyLSiqJorJ8yYjCRQ1zrcUeYcslVpBEPPEbV9E3eoRAQ0/4/Rb/hEm7mRCmFY0gwj4ps+gJbI+FHPoKJAvl1nlxOVp4Y2vKAd9SBkA5JtQ9TcgPKUAacdVnBVroihF1uYna0pSEkiz2c9sfbOk8W75az9Cf0cj82PEUrTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(2906002)(44832011)(5660300002)(82310400005)(36860700001)(7416002)(81166007)(110136005)(54906003)(8936002)(70206006)(70586007)(40460700003)(2616005)(316002)(47076005)(426003)(336012)(36756003)(186003)(16526019)(86362001)(26005)(6666004)(508600001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:06:32.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23d46a7-dff9-4948-18ca-08da278595dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSR definitions that will be used to enable the new AMD
Performance Monitoring Version 2 (PerfMonV2) features. These
include:

  * Performance Counter Global Control (PerfCntrGlobalCtl)
  * Performance Counter Global Status (PerfCntrGlobalStatus)
  * Performance Counter Global Status Clear (PerfCntrGlobalStatusClr)

The new Performance Counter Global Control and Status MSRs
provide an interface for enabling or disabling multiple
counters at the same time and for testing overflow without
probing the individual registers for each PMC.

The availability of these registers is indicated through the
PerfMonV2 feature bit of CPUID leaf 0x80000022 EAX.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9e2e7185fc1d..a040f4af93c9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -527,6 +527,11 @@
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
 
+/* AMD Performance Counter Global Status and Control MSRs */
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.34.1

