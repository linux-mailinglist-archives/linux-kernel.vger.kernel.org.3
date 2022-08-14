Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B2592599
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiHNQvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiHNQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:51:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3661137;
        Sun, 14 Aug 2022 09:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHFAoDFckEDsAsGPIaYxTIdC3+U+g1FfV9mx3Dugz4js8mNKsqCoYZL5LVqKnSBBQioNCvEUrQGBuITmhDUQY1zf8Br6RtO10fvKbeLFs9Y+EpRJ+2waT2DqCQ8ybTFgXOOWO8EXogNiaaAqKFxRCF15e8JfC0t6NS78tovVUjgD0LErRyZg0EjibWNQEhQoTLmVFtrVNGsZlhNn0VYSeKihsXAkB2DwqQARrhuKQEmmOsUnIn83Mfh076jY3/mTNI8ByZ60MqK1ER7YgpTDI+s0YCvfmbA1QZDyms3lzU7CNQWjTwyiH5Ne55+LQGFB8EOOBnjGssrUgzh7ph23zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM+R2mC8GBtxj5rLDlxGAcV4rBT4sWbzfKQkPyc5TtI=;
 b=LTNjAquK3Vf0qGedm5081bXFYMtygZ/D75rDcG/8mNoBTZaUuT6Fc1pbUvd9GX06jQFb+kbKiFI2LyUTBXTymajknKm3//YxxZao/JfDwRVTH/0cqqevY2HNMQwY8Ig3TVnteilXO2koFAPzrf5EDnjqCrZm0lgoBZV8/tQY8vdaOWJrKtWAVfN5KhBPQzjSuLSFZN/LZXyyXbSIIXVkuhmOUF97XvPZcQm2qQ6ttBkX5G0ZvDc3DpyNVmtzA2tiAZuHnr+io+2jzH1WgOYqsEWZxLygckEGcrtUfHRerwlwsS649/Mx4gt/N0lJpeXNwb6cRLcE1fhufK9AkS7RYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM+R2mC8GBtxj5rLDlxGAcV4rBT4sWbzfKQkPyc5TtI=;
 b=nLCP+yZaJXpKjMRqfhbUjXMwOZDuP8LS/jzGmYPRngWLVHBMAAtsuNh9vJriCveS59uXuF3869dsIDlJgx+lRWRHKINsA4zNrl73Xx/Oe1CZTBQoJzPNOS02H4IXVN3VXPdl3wdm1NRU/W8VO6y64jNCa+vGokmbd3+WzQBF414=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 14 Aug
 2022 16:38:48 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::b0) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sun, 14 Aug 2022 16:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 16:38:47 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:38:03 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 5/7] cpufreq: amd_pstate: map desired perf into pstate scope for powersave governor
Date:   Mon, 15 Aug 2022 00:35:46 +0800
Message-ID: <20220814163548.326686-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fd6be10-1d06-4e54-c03e-08da7e13761a
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5486:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tdLo9QsUumFDfNlGsGJmdToUMfSASAXzLeHwqHkivkZm+Tqv+sTiQHBemSOdU5VM4b3aZUOONSLgbX7qKyLsEXR4IlKnwkKYRRE5SPj9WUd7oAvDmm7sZvEWq7iFMx0dWRHg7JcgXvvvdee5I4gOI07ZmOqKmfo1cNYuGXR5HNTg/yTN8NEYsBtV8XmxB8QeEpfrbMyCnEynD+BVpmG0PiAeMwYvTdz3r0NdnoVF45spIDwoRdt65Qm1sRxnEyVK24tPhAgagiFuIQh1pRljumCiDMAai8TJN4TIEb8FTr3a+2wl4WTgn0VNb/qJ9BmCqYxRJ/MvdMh/tNX1tj9TanjiJvcgCzeFWBkc6nt7LbZP2D8p/IwDQhqJeiYmoLGheqqqEs35IlNiAtXNbyrdta1StlG/F5T6aHV9KLEs6M+VrHT2CdU43q0Yef1QRnv29xKa2geIDepEGGXQk+i9a24CmK89ePf85tqYPP5U1Ej+lkdvu/iNHTXITFdgrC1Z2zfiXuzR/+N9BEuxzNvQoYUYPpBWycAoB/s4iWcK7dGS4gkMqROitMijguFgdj712HOsQYpLNzhA8G32i4cACOq7VXHvhiOKm61tyHqUMBH5ByGF0LnRg2NT68v4cHL/JoIzJJJEezMFtR54ovRVR08+tzWASuv+R52WwL+JZMZppqIunHkDFKecodSrCJci9riSXlVzIz0Q8L8oq+3cRV8cI65BbjTHh3XYdXVKwq4AsGdQ+5a6bi4Xjl6TmQHS3Nw7hTy9xfWiOovjbGOTGDiR+CFLHPh5KKTDNAqksXN9bkznMwVaysG1Hkw9PTes2TzLlLKuI5wECVMmdQ62iwbKzYMpdsM1my36sv1ALw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(36860700001)(1076003)(6666004)(16526019)(5660300002)(82740400003)(41300700001)(82310400005)(426003)(83380400001)(40480700001)(2906002)(336012)(47076005)(26005)(2616005)(7696005)(54906003)(110136005)(316002)(86362001)(40460700003)(356005)(478600001)(186003)(81166007)(70206006)(70586007)(8936002)(8676002)(36756003)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:38:47.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd6be10-1d06-4e54-c03e-08da7e13761a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will fix the invalid desired perf value for powersave
governor. This issue is found when testing on one AMD EPYC system, the
actual des_perf is smaller than the min_perf value, that is invalid
value. because the min_perf is the lowest_perf system can support in
idle state.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 183cdd4ba00e..e40177d14310 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -264,6 +264,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -352,8 +353,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
-
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 }
 
-- 
2.34.1

