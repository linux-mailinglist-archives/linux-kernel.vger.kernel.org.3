Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C645AD7A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiIEQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiIEQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:35:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708D2C661;
        Mon,  5 Sep 2022 09:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPgSA6z9J0O+7PSGNqJoBDHqkZNw9V+7P/tL+d9vpoqSDmSRdDxo18n62jeZCBxRzh7A9ver4p6UcxU6Zw4+e6xrKtfBDmoH2c+27iTQo+in2f9S4R37Ped46sPAGk+FR48BJvdF6xngwWOrWUAlivWmkq56Bcw4BVWddgtlKAny/i6VeDN6Rr7tFBklSbgDdjAQOIh4sinHP5GrdmMvWJjjRXrppoViKQXlWH7FoqXqC2/djEzkUqW1wul4rc89ioNh7K4g+2wRpUA32+uWdFWb8xwYC6GeEiSPWzynE1hkj4YyCj090LOm8kAa1IwFkCJWzGAw6oR1djSH+UPkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnVNPUuHP170ocIwgDxILHO+8+oRYs7NJQgQ0eUAG1A=;
 b=mbe1iot4xuU35WHAaiMzHqMfguChD6b3eT0WClWZg+8CeByeVd4jzm0oz6VxnlftnHHgAYLBinTIYmD3Pu92znoqNDdc28vlB5M5J07TM1WwlKnpoAa1YTPQ3nje/XQsmvWq+21CI+a+ISfXa+OuV+h3IgvsTUVaZMezZROlA84l5xoFVP2FmQ0G3VvGADu634EeL+RVCwjByLFS9jrcbJTO5h/3IbIKEcqFs7eaAP4J8XiSBcU1qaB3Q+heL0zDT3nwK48nj8tmDCTMXC3cZAa5DBWfCWNIOQrCXkWlyWPUm8o3WWsLfz/7GM6KPCEQihYbUVMieBohJJzrHD4zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnVNPUuHP170ocIwgDxILHO+8+oRYs7NJQgQ0eUAG1A=;
 b=wdrYixAtk7zC5R1M7v/DtnPB5VA3YmkgxZvYorSDqJz06Qd+6fPynsLKmyGrDpHXsbeiD/8Gr8h6V1xaX42mDXfN2Bw4sHQinFIw+EXe1XsKyYXhL3cY3ovdnrp345EcUy327zIimu1/tHI7B/DOh5MUhoG3MokmNUMqGj9Ni80=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 16:35:44 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::83) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 5 Sep 2022 16:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Mon, 5 Sep 2022 16:35:44 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 5 Sep
 2022 11:35:40 -0500
From:   Arvind Yadav <Arvind.Yadav@amd.com>
To:     <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
        <shashank.sharma@amd.com>, <amaranath.somalapuram@amd.com>,
        <Arunpravin.PaneerSelvam@amd.com>, <sumit.semwal@linaro.org>,
        <gustavo@padovan.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <Arvind.Yadav@amd.com>
Subject: [PATCH v2 1/4] drm/sched: Enable signaling for finished fence
Date:   Mon, 5 Sep 2022 22:04:59 +0530
Message-ID: <20220905163502.4032-2-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905163502.4032-1-Arvind.Yadav@amd.com>
References: <20220905163502.4032-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f5b680-64a4-4fd6-6472-08da8f5cadde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0xAtG+OW5DpT7nvzEluo24UGAPfU3Mzt873UF/fmHYt2nG0oNxTAgrjrIyujEDCMtRgT0f/3puYQI0i9FTbTVVqvZMywfn8NsvBj8941q68z4EmrWr5fFkqTG1yipPBUsPA5kGvTDoXwd6dhCyP6RAWOxhmcvCQihhFPLGUAoBveszocmFD6hbC4FrJr8bh3f/4bJ0ii2sWted2F8U0tBpwK27o3tH3/1hYUoyua3Rydf0fgcm6i7vdDd9bN5XUU1JOhP6YvAcpMnaOoVnFl0XPIyc7R2kMKjGcZ4CwKyGrXRPps0mBjYulLx+r9OSEVS9ymwKKcjd3KijUGXH4NhPvj9SMNIdsz598WjPej2+I17l1hXP0Vb7YqD6b6KSNiHWX2lVYaA7eTZDho7FDELI9yVGZsoZ78qbCaibz1j3BVv7/9C7UtXHLqKckX68Av8cJvHX+PUBmu70bPj+5zdk2ZKfIT4++6xL9hs7Ws0UkrXt+NlERMKq0JPgnpBE+4RxFnmis8RE1bbYdzsrOpGZC7ADDmcNWki1AOt3ZmcaZLC0+g9iQipJL6a0Oj9Moc6cQM+b0e29MwH5G6G4bpNw8wnbRbAVBAh76ZtlpHf46LRfGCHZdlucU29KxcP4n0PW85OQ9WMkJvGSRrG2arRQ777m+cs/nX4dgsDagvxVmY6PI4s3b0eqfvaMlSXaJsofXycCra3Ltx7t1c/F7IiewYnCxcaxhcWQQYXGOA+Lcp7YK259xpaokzNsCjuE/iOYD9b+lSBp7DKuLraKJVo79yvl5mvFGWB6WQzxDEx1fm9KGfUTR2y55lbN4TIRmDM8Z+qDG0gQxPmQgUwEf0bYmpuFvPkX2UcMqzR0fq91yPs8pboLBxDETIVvHGfmw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(40470700004)(46966006)(426003)(36860700001)(26005)(70206006)(70586007)(86362001)(47076005)(4326008)(8676002)(7696005)(40480700001)(81166007)(82740400003)(336012)(316002)(110136005)(6666004)(356005)(921005)(40460700003)(16526019)(82310400005)(5660300002)(41300700001)(478600001)(1076003)(186003)(36756003)(2616005)(4744005)(2906002)(8936002)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 16:35:44.2361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f5b680-64a4-4fd6-6472-08da8f5cadde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's enabling software signaling for finished fence.

Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---

Changes in v1 :
1- Addressing Christian's comment to remove CONFIG_DEBUG_FS check from 
this patch. 
2- The version of this patch is also changed and previously
it was [PATCH 2/4]

---
 drivers/gpu/drm/scheduler/sched_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index e0ab14e0fb6b..fe72de0e2911 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -962,6 +962,8 @@ static int drm_sched_main(void *param)
 			/* Drop for original kref_init of the fence */
 			dma_fence_put(fence);
 
+			dma_fence_enable_sw_signaling(&s_fence->finished);
+
 			r = dma_fence_add_callback(fence, &sched_job->cb,
 						   drm_sched_job_done_cb);
 			if (r == -ENOENT)
-- 
2.25.1

