Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA4575F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGOKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiGOKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8377BE21;
        Fri, 15 Jul 2022 03:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzTxaLyzIc3Cw6xf6S90ENtM/QN3kBfWeEx1FXp+FdhilEj5i/QmCzeMr+cz0Dam5SYfol2cNQxWKXFuu7Nh4RRMHnlDSgT25WopxyHJFx2qdYD0rLhgr4bYckRKfQ1GQamkOs3p6eUTGxRxBG4w3RL3M2CSIRdfdnJO5wQ+HBW4WUsF45hFEGlSTbu0qi9aIwSqevnrFcizfT7pSNfK255qMReq86tNc2v6djJeejJ5bXfmYmTD//KLdJaYb+X7UIRxDh1bWti+Iq5s7TWd5QF6A2PyOX2WZ+zg2Bn7Z4sN2cI/UbxFAV/mqUeKUUIZxPflM47+Ve621BIFEXAyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNefItLSEw5zcz1l9vPXNypnOlVbiRq1Ye3gOwzkO/U=;
 b=Hbhb6A0RMJBHLjOA5k2UO6JtgOuvFl7hm6GR5pdhosygEoPonwPDg0oQiMsz/S92xQMKv7C9rQRbpDpA5EsAk9Tqpv+GkVS5GOzOisGOca/PEDjZy3Q+Wt+b9v+/wetrQ0i7mZrZKC3QNnrPKpHrHpzErBpgyIjW0eIM6GczqHmx7PIfWyg+NddxR+BQF6sI6vukzYzDzpSLU389iyTWBJUOfo2W95BYWJ6bdZIoTJ2tatahGpMHdRFmwmNnCmulMCS+8/8luoDHoD4foYValusG3k6RwC9N3ehRCRW7K/hSWEveKcy1Us/WbTgsyYZBgFkjvJp3LWWWuJta0oG2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNefItLSEw5zcz1l9vPXNypnOlVbiRq1Ye3gOwzkO/U=;
 b=zKoC5ZtI5Lu+boMrWyNJIYfLI/yusA7R3eVfS4XmzRURzOYtXJeXRr0i9KdUax/SOVCz38ieIgZPSCd7pgdSlHp85Qy+zeLyRVYScra175Rc65mnq0ERgI17OhMlzTCQY0Iz5LTu4gwMO5nqI8adUoELu0FyzMS+vt51u6jczSk=
Received: from BN9PR03CA0209.namprd03.prod.outlook.com (2603:10b6:408:f9::34)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 10:05:06 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::3a) by BN9PR03CA0209.outlook.office365.com
 (2603:10b6:408:f9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:05 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:01 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 05/13] cpufreq: amd-pstate: simplify cpudata pointer assignment
Date:   Fri, 15 Jul 2022 06:04:24 -0400
Message-ID: <e75b941f2c994d5b52cb42cd31eaf90d24efb73e.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945d9ac4-ffd0-4a5a-853b-08da66497df5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFz8PQipw9omZ90Pc1T4/MZTDsSfZfAH42iuUKp42gZpGfPiRN3vHHhj61K75ZesQxkCgfSnkdRRygU3UOWtfAqqrOVNXrnttc7SYOOmHWuLGf0m0sSfLcGkL8SMURYoFFX19FyuYxwbAfm0v5zYPKemAGSndY8j1tt9sJYEcbJdjSHiZ/5c1BMvY89voJtkdUcmoPmv3bX4rnd4ahZOprYmrbbc27a58veOTaLKsR/gjFLm9m7pBg/SaukpOn8QJNm+NXEZqTfBOhEDu2u1qVz8XBebHGTsbTCD5NP3A5AX1W6QUz4YIzXuPXtB6W6pPmen4L/u2X4Tcahjckt0DyvxwkcZjAL7JGm17ykXKPzIbor32MwmdcyHuMmb7aEhflmebVmAbBEL0ugw6D1q4SywbL03YYJ4PEqPh+4z4XZZmw/7PdcNRxKl7TSY1M6sDsgknToFbEL8IT7M58IkDli+lrbkgn/bc8mAxNugR5mcMW45EcXoXFZYN/zVAARsRRFlnjCECHjMPDSkGUxkRtQBSepCkJL6BaQjvCB1dAAGRyGr0UJL1W0LE/tIc0eLY6ngUFIY6AJHJ+6c7gyz+EHxSJ2mNblABfwaj5bIVeHom0qbY/4Z9whqw47NpgU7LBCEt38W5nOuazR4TDVwezVW6dxmFIGt78h0+ak43nUoDsmDP/IqNCwMmusmyoEfq82K8Qpxen/uWeUffqE3h7rzRFL3iZQvH5k51gu1oVwUGYdX52gEbS8rhkIe3Ck38jo8/eDJq0aYAP9QSW5K3Nm7xYTnlr7o42Qx+PfqcIHg+qxIbgpINa2+tzjRkQSjibs3T/Q2FX/qHwqluRb8/pAgqptUtn0KsrHz8qhBMFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(40470700004)(36840700001)(36860700001)(81166007)(478600001)(356005)(36756003)(82740400003)(186003)(316002)(4326008)(41300700001)(7696005)(54906003)(2616005)(426003)(110136005)(6666004)(70206006)(16526019)(70586007)(8676002)(47076005)(26005)(6636002)(83380400001)(82310400005)(40480700001)(8936002)(5660300002)(336012)(2906002)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:05.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945d9ac4-ffd0-4a5a-853b-08da66497df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the cpudata assignment to cpudata declaration which
will simplify the functions.

No functional change intended.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d8c4153dbe4f..0c8256638ed7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -574,9 +574,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -618,9 +616,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
 	int max_freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_freq = amd_get_max_freq(cpudata);
 	if (max_freq < 0)
@@ -633,9 +629,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
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
2.32.0

