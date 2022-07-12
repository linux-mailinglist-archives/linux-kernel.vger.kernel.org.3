Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1F571FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiGLPlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiGLPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:41:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C5C1FFE;
        Tue, 12 Jul 2022 08:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StsOpU4VV7EoSFREp2yl98WKgwY3KUuncQWh+ce5vdesZDvYnONz2kaeaeMWoUSbXz9exL4FwluJfB6qcjw2Qa5FLEzPAuBNE/8K5elzUPaWAj7+5WopoXjN2iu9fWFq1+tb/s899/p2l0I1uR9qrUUrMXtHPWgPNtlXlBcdtLF7TSANTjC1znlCxoxjqJmtUa3jHXLzPW+scsWr7I777tBGQtpkoLDpKkjbjtwqwPqA5j9+Q0k601TBIcOqkDpj7eDLst3RMjJgjVleLzSnfV1OMbnNY5wmyf60LNRPJCScsq9qpVzDBsrv+B4ZhweJdNZ5Dclu3bOCc/a/Pp6YtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=cA3XpaLowLNCZtn8sxMcz59E92K1Xfolw2upG7vKVhgVnmwvfoPHDTxXottI2NCRDpknbNFaP53/sJy3JuZrobOsCZ+oxnt9CV+/tWeWvJ1ystKN/dKMIWLwoHpYZP8E4jtiamXFqvt61y3aGGB/yHhZr1SZNoFFYWynRuGoUDiRPYUMZSu50MT5wbB3oXqJvMKMLHurXBRDAhmixD+Cw0Clh9UvoN0DWJApcsjktdRlREPX2teHjkTTdRm1AvWdl4u12Rva4byMIu3dLgjC6zqrxfwSKgSGYDX6jhqrAEMUNU7P1zZ2/u3CZbe6tDTYyLV6CFksPOsnfstYqExNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=FDuodwrM9qgt+QSWAHs6bAoUl3xIJtEY51uQY/Ru0qDBXRMJkQ6B9I4PgRMUeg6sZ7PxLR9vWks4CRfWfWOD9QaNLW6266vqs+pjlBxDAVCDkTY84UZf/Qh4EIBZQST4OFHvJ4+83UfxZGWj61SPsHfy/b3FR8JsW3vqwfTxdt4=
Received: from BN9PR03CA0373.namprd03.prod.outlook.com (2603:10b6:408:f7::18)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 15:40:58 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::67) by BN9PR03CA0373.outlook.office365.com
 (2603:10b6:408:f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:40:55 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:40:51 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 05/13] cpufreq: amd-pstate: simplify cpudata pointer assignment
Date:   Tue, 12 Jul 2022 11:40:42 -0400
Message-ID: <34465aace57a9ace28f9fb2c4599bcc8cdae8286.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27114530-e500-492c-9a9c-08da641ce931
X-MS-TrafficTypeDiagnostic: DM6PR12MB4941:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUfr4o6ycfmu3mpO0VnUSXi/lAo45aPB1pS5cFqigAQsElYOsaAiwVL/jTZ2MxekGK/BtKUwC2XcugzM4sLtFgpxEpThpkMAVEch3Wqr8hN42yK/o+l7DzoDibim5MntefjDztuf4B3wvhbrd2Bd/exQN+APyU7s5H/hGTGIKeZ5SIfIPzwFXfawMPzC0+FODt/VMEtyqbi30bJPFUj+vcGwTw04yL40k9kepTC9Bz8xKmd5En2K2Is0EeDbGmUNRkLLVPeK4f2vAtjJ1vPlY+U+qi9Xe19bcHAS021tKROj6j92aIE5Xy5eLqFrBl7ZMBtyt87J5BxdW66eqkz9hn+eB205nuch8Sdr//U6ODEZQ79YpHWACTwzsg9EfVUt2VrY867IG6RGTcKBhz17ZTNvnIgRpEl9vVLVq4Qq+JEvhOMlqvcYN3iNTQgL/uOZhdNVEmwdF+9hAli2B1Q5eb4JuKSkM2vwvkyAj8qP06QaTlYIGKyiguUyisDu4p/KiJEzWI3izBIq4TmQIR3r6N9xE2PO1AFnnYZpwdK26bryWmREAZt5/lryDcDf4BWtG7GzR4Zw+oJBozo3HNB/UPQntMUJdxto1mFcPfQR+JijXDgx0+c5znrF4d3ZUTCDKKdZ16Ui0PqH00UngNYNayxkIKyoAfeQFAOYIUNuB8By3HJYR/sr0+zaIgOQ+tVQOh+jjPVLRJfGn/ysW5q+W2WwC0D6rk8XMy5bTSh4468A6/ypkYPlpef+VjuYF78w9gkkQyFcwZZlpo5vE3UblONMz+1h60FMGYKprO/hWcCQmRiaUwai9MfcEsELtJ522iDQaH+r7d//nT/szl2ir835u9UZC03PFw2GVcz9t6s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(70586007)(4326008)(8676002)(26005)(478600001)(70206006)(5660300002)(16526019)(41300700001)(2616005)(6666004)(7696005)(110136005)(316002)(81166007)(8936002)(6636002)(54906003)(86362001)(82740400003)(336012)(356005)(426003)(40460700003)(83380400001)(2906002)(40480700001)(186003)(36860700001)(47076005)(63370400001)(63350400001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:40:55.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27114530-e500-492c-9a9c-08da641ce931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the cpudata assignment to cpudata declaration which
will simplify the functions.

No functional change intended.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e4904da54541..fc0de9fd643b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -571,9 +571,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -615,9 +613,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
 	int max_freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_freq = amd_get_max_freq(cpudata);
 	if (max_freq < 0)
@@ -630,9 +626,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 						     char *buf)
 {
 	int freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq = amd_get_lowest_nonlinear_freq(cpudata);
 	if (freq < 0)
-- 
2.25.1

