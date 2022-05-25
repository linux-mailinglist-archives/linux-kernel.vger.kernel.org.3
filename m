Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51C9533A26
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiEYJo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiEYJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:43:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A9DFD4;
        Wed, 25 May 2022 02:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuoUaFjN9TQoKx5ShLsE3edD5eItukk3vGC2E6JGz1ujcNNg+Ej+CVh2UeA4UPRhuaRh7/AnaT+jiaaXv4SDS3wG6m6kR3MAEnujcHipkPyZU2ZqxUElYCd41oHralyuwg6h/NZeu7XrEVsqFSE5Nybc05qCopBT7PwZHIBxZEnGwjItONM7pxtCM8/iud398XPi0e2ZYK1C1l1Mu1Wiuni84jUdpCB5fjijU73YCWXbQ/KdamjvByxP0IFFxmVE61xUsaFzAGHXSwQ72DNGm9BwPfU6spYw6gQRINRlzbgA7PJQKzWrDCSFJu6uqQ+awMd5YwOyTisFQbVkkI/hDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOr1MBtil33b1hrIKr1/RSy5GJuzGExlotqZXbUfl74=;
 b=F4vDRekVrNnA/gz3JQkMQROK4EQ+MSS5LuZiMkAXNKfTKFREFNZq17+bQZg0DgQRYcR3FE3racwkZp9h5NC59oYBG+p95KpOB44JAa675d55kq7G7+NZLTbmOSul5TgxvIH8R8x3vxVZVFVYaVo7JGxKbX1IXV9cbeWRkcexCbfJe0AjNXo87WJKF4x1RyKkCTRF8G06ckSRgE19U83d2+6PvYh1gHPh/wg/BgqWBzp5ICQoDyN4PLbRwd8ZPCv3VSezT6ds4kkzfEpxg6mP/G732xwtwrMvZEzsfZywTLG43x2pwTutxJRxB/tzvNT8K6RQwXHSvYnbfgD6+Qxa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOr1MBtil33b1hrIKr1/RSy5GJuzGExlotqZXbUfl74=;
 b=N8a1Ec/1ctsXDmsMbsDlzntmLLKTWepzPb1w1l6BQKacU4g42ICvCIyBvL3DVYTqak3l+dnQh2n3rnNOwY5CbdVKkFGqkfxMM3PGqrOWZkBA2/DSxWZoPpuhSrWTwlqqZhu+ufASKUpibdZA1ad4onfdsOFgc08i8foJnOaO5qo=
Received: from MW4PR04CA0089.namprd04.prod.outlook.com (2603:10b6:303:6b::34)
 by CH2PR12MB3864.namprd12.prod.outlook.com (2603:10b6:610:25::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 09:43:49 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f4) by MW4PR04CA0089.outlook.office365.com
 (2603:10b6:303:6b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:43:48 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:43:32 -0500
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
Subject: [PATCH 09/13] perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Wed, 25 May 2022 15:09:34 +0530
Message-ID: <20220525093938.4101-10-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae91759-f2e1-4e18-5dec-08da3e3311bb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3864:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3864D64B0DD687014AB9B133E0D69@CH2PR12MB3864.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awIVhb6QV6jsxMuNj7UXxJbTuUNRi9sq8GTUpa4ZczyGEm/IioKqWX11FBODzmhB2sA20u5cZswJ6IukxFCGTHGJQvjAHeoi6pnQ+PlPmg8kEI/3S6HGCYtTeGxoe347RSUTLO2IRO0uzia4ekHrd4TQjGVIAEZav40EFexezoEjEycPlcJsuyvjf3vRyBAk4hKdePIUpVR1VUaiN/eJNXPM9UYaZoE8ZYjAlIK2w3+j8M+boM+pQgbiGcygj19BxIZrY/w/QMtgZqqrVtAy1IpYepXJS4Z72lejzF7rjV0/fTYKpE4piax4SzTVIBzwFfIzon+LaB27cm4sBlYy53y/StYEvW80ABcOcAfDlo/aUbG6VnlTW23ESKd0hyatZQ5l7llOqWVUj2p3ht8pYdWNg05YZm4Vd9vhyowNfLzzAfPPfbX9i12KFnR1Q4ubETSTOPSuy/ZxeWpW/UIokbz8uOgqTR0I6mPJ/jR5M1TKkD54bATCq4uGrpBXMXcZxPQPu6E9QFNuhXtVUha1XCZSbMS1dguuDiDdzy50L4gg+Qk5SnrEdktJHFCdyy0w3Z8LnCKIC0bERjypn8tgS9bautjZIgAKixDzPVAOxTf/s84dDthw3drPcLtanKkcTCbC7C0uzYRSzYZZFEFvRdiBsnKtrW4x/1eKSMdT0LO7N5dzCNY4EFOkwvZTv/RFcNPvqUxOV3a3oWQszDW0ouUiQXWvHpKjq3M5R233TtA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(7696005)(82310400005)(16526019)(336012)(1076003)(47076005)(186003)(508600001)(426003)(36756003)(110136005)(2616005)(36860700001)(316002)(5660300002)(7416002)(356005)(86362001)(26005)(70206006)(70586007)(8676002)(40460700003)(81166007)(4744005)(4326008)(44832011)(8936002)(2906002)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:43:48.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae91759-f2e1-4e18-5dec-08da3e3311bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3864
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
index ed0ab838bcc5..027cd6d62f21 100644
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

