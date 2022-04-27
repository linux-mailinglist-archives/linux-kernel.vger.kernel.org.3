Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDF511653
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiD0LgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0LgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:36:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF53A71B;
        Wed, 27 Apr 2022 04:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp+b61Ssgpp1ebOaugu+qXdOIXBdyDMPkaELHMoYRkZxthOn692jDNShXbOvPzs7etvW8Q7Asddm5aTIAZLZ3mQ+UivJQ2lG3CyWaI0cn9nTn4mNlUWHiXnO9E+9AsWlj/HxEaq7vmySiAZp2m2TxNz2roYJfujAPSqs1hIRQJWCrSr64FrBNTwf0xeOG+eauFYjpC9LockFyNV8+VxtHRp77FY0hpn7KXZa7b9A/FC6vZE0ePtmplZqrEaEO2Ztgom3QDDL2b5rxwwejcB5mb9k3NIxaGtey8mQQJ7vtG3r0s/6iQMrt2YCTFkQkX1OGKo/jgVM19oO8Xd54Imuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0U3EekqMxQOfInrtD7Yk76DmXTjrwUwztJMahOcDc0=;
 b=cjmR6X8xCZ78PLJCHHX7DrmXNFxMvhWfp89OiWnP93NDoLk/oyWtQtwVuvdVAxwT+nXgpD30zVR8iYwPZi+L2Q6QsYW7U+jSenqn+22OWpBHESFxa5VKJkeiofTWW8j+J3LqsyPOVKLim+AR+Xixql9mfARgTKu1nYp9buP0cszqTvP8C+UaJIXDaAhS3xHcdp1OKAYSyGo3lVYOmoEPDQhcxzabtVyHhyajidM9tFrZIKdYozOxyUHX+BgQID4XV9GGYdZOq/r7rFC4vEUpmf0Jvxd9WHnKI2dOdReRoY+O2ikI/dZB3gyHL83SANnpJjScERAQxN7epwgjQF6ZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0U3EekqMxQOfInrtD7Yk76DmXTjrwUwztJMahOcDc0=;
 b=f7R9LMgzzpRFRADi4/hbyRF0OjwmHyfCE1nBVdPg46u1UOj+w+2bscthMB+SnAr3iyBvoQ1NUIjb2xAK++DIB45XybLaCShp3Hyk7JEOXzj3nhWaJgqmTHJJH7sxYI5+uY4EZ1kgMtz4tIxb6mHq0XN1vJIBYECxSW1omLJsDXg=
Received: from DM5PR21CA0046.namprd21.prod.outlook.com (2603:10b6:3:ed::32) by
 CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 11:32:44 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::fe) by DM5PR21CA0046.outlook.office365.com
 (2603:10b6:3:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.5 via Frontend
 Transport; Wed, 27 Apr 2022 11:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:32:43 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:32:36 -0500
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
Subject: [PATCH v4 2/7] x86/msr: Add PerfCntrGlobal* registers
Date:   Wed, 27 Apr 2022 17:01:44 +0530
Message-ID: <b6a041871798a300760d088b7b6881db1f38221d.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d5fb90-dc24-4882-0017-08da2841a56c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5153791ACF9BD94051A8FC4A8BFA9@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuJfmVmaFqUlXSFspnUqBfxCTTOpn5XcosvpurCDzg/NfOfc4d0oRAdFjCdVR79ytJtkmCxIVxMBixinKYyAKVyhVp2YH7bttUlvCgwePJ6pSpRqVR0ptL9/57iBk/fo6+UOCGW+mdCnz1rAqMMN2vp6Kxrx7pNAbtCzvcsTpTwMwB2V/VvKOCdPIC0xtdzWIX/ZOjZxMQgQX7S/cc7FXSXuMtNpCnrkY62KaDCR/nExXto3q+0jDhsqXd8Wt1eT9PejlO8oeoHzzDIkrV+pttz6di3h4KrYPeUNy7EvWf67MYjY9eSAyKqqLxP/7B0PtWEMCamCEDJZbfrFzbBm5eHfekycCFpG77LVlvNHvM7WNm8Z4KOXxhtPhmxCPRnS5RJ6sTY1fHAUUjw+dHiqFJUZlyx/0U92wQRbnyWsCj8u4tyVRYBWWcMkKFPdwb2WrLMnif/BveUhjmv95nuALG4o2Vc+cy+6NV1OJpm+ddWx+s/OGniu1eIwrpJqz0y6Bb/ftI+emLy4MuIEtpIlW28T6Bij7lKDqVPfmHicDMjTpvuGY/i7Q+GthFTT94jOiFmbTgwreAqUGYzJ5D2ZEay+RWbEWuZ9bepWcgQ8I2296LtEDWvfJURzQfDKueq/+BMVwonyA0pov9sUJV9qegNlFgdaX+VgPnVmuEyHO4ZDogf/BD/Af80Drqj+SU1ZRYDgTRFiiCpdDeeaCuRHMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(8936002)(36756003)(4326008)(6666004)(110136005)(82310400005)(36860700001)(336012)(426003)(26005)(5660300002)(508600001)(54906003)(70586007)(8676002)(356005)(44832011)(70206006)(40460700003)(7416002)(86362001)(316002)(16526019)(2616005)(186003)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:32:43.8556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d5fb90-dc24-4882-0017-08da2841a56c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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

