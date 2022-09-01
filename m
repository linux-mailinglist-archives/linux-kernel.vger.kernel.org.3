Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BB5A929C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiIAJBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiIAJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:00:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771964AD75;
        Thu,  1 Sep 2022 02:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daKwIXnG21f5IQnwFLtP9tfgO380G8YdT3cnUzVBJyD8r52OT+38AqkrcjdrLbOfj4HE0NPZalQWsbeGP5npJSUqLjsyppM4fxv8uHXrKAKz6rnTxv/8uoyRaE8BrcrrtoP7noiqw352WowpjSS8pj3M5TR7/j+OpUi2nPJxIQf9PlaOev6Wk/u6t8L2gY5p5jvsX++zji3NB0YGLxdver7s13dExdFevn1MTLbzZZzrE1lVy/MQYSP3hbybjxnPzkEZHXaIimCWp3zV+JzHkndPEhic15+mDr4DyKDwUh8kQZj28Xg1Zz6jUVBlrwTKhLbIkN1YVZc+Z8ti7yboRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOwv1GDUtAoqnMgcMKPJGv6/T0bXxpHqD3jQSPNQWvM=;
 b=F1++p52BPRMSRBaZgZ1JtTKSs5UiIWjTCqhfAitUf/7rLuJT9WYSzgcHw7VazHZj0pa/VZaLo0cBYeYeOriKfGfXAnQSf/6biOC4AFkDrLFvkIELjRh48s39htybIHqK4OdSOQspBOmOHYoPBtXaNYZ8G3xoYvrDs2TqIqIbxhWURaib5QhiV6H/3V2H6dYUMuY1v7mgMc7RYQLOYLbZzj1TU1uP0EPz3Z7QrVc/MiaA0Uy2JXj2dytTU1HK4ieYz9Im2TkWxBCuQqQ19kX0te1yvApWFKWzK4uiyO3sCnhOzEsU536Bh7thsEIK6zguSfPOiDThcNBdk7dB6F+UQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOwv1GDUtAoqnMgcMKPJGv6/T0bXxpHqD3jQSPNQWvM=;
 b=CYOq2TzJfEzuMKnpHuS0rkiSmwbLAnwaPxGVTEISmJItUOhwzDj0vfFz1hP+y9v2B3cVzQiM+79i4CLOhvjbwmnic14IjOPYa9OIsrAOICdXnRMpt/txLxLg3dcDvamU6pdd2FI6Fwu1QcyhD/YYdOd7g+CcU/mCF89sme5umsA=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:00:01 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::7d) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.13 via Frontend
 Transport; Thu, 1 Sep 2022 09:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 09:00:01 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 03:59:55 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3] x86/cpu/amd: fix the highest perf query for new AMD processors
Date:   Thu, 1 Sep 2022 16:59:39 +0800
Message-ID: <20220901085939.2388861-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc578a8-d0e7-4853-6899-08da8bf85a7e
X-MS-TrafficTypeDiagnostic: MW4PR12MB5668:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KESPGvNPpAuGVIycdHq3+ouZO+SdfKDruHpZga9QHd9L8a+Fe/wUmK7DtI+Qq05aKJiI5zgsU2lPgsEFc/U84jAL3LWaW7SgVGN6kF/mPue5cE5P5/znxfJpSvUu+xYvjeMUu93wb+wOkxyjQif1rTsIGRVNrWgFz1dEa3z2V5A+/vKIwHsWKMhSoAAY0XfISxu9VDWvOGlKQfa+gB/nHj4n9TlWhZ0UVMGTzWfybdlO8ackkm2tT1wtnzD2VhtsYFRMH4cdLBFFbxco/8bXD0scNLjtVCGPnJURIlyM5YBKMjcc6YRM7gS3GdDJH1LeQLcLkpUJywkNQ1IytI/LhwBMpXiZjOSzUlYEIxZABuuEA+AC5XUe1hXnkJfvgn4GOtG4ndYUMw/uHGRbz8BLJT0fmB4nUWxBHayav6BTaa15aigC0grz5/tKbfKqIODXYjXNh2jkc8k0PC9waFXXxVV46VETogxoXWt+JWVW1cRkd9DIC6pJNvXHAgvgr7ZWgPG1MY2/6D217IwSBTCyBWwYQ/xGaA4XMIvqlsi4Kcv/1duhxUAz+HGO5KgrUzFXeQ+PBJZHl7GAVRp48K0yAK4YT/WbhokmKXfLNwRWyhviG7lIreYRo9sfmhch2McBWua5Y9XzJeeBr+TjKj3e8X1a59oNqq4+h3QVnmaQ1pKyxIXRGMjlC2Tyyu0iYoHWYFZ/FZ45TmIY+iqKnSzn4ei36AQyOTW1f63MfKsXowpF0ewa0ArdCgGnduiRzFbKuUQqpORvhb1lKXK9RTAIyvCEUQxcnp0/1QFM8BhWtn+Dqbygq7xiki69v5gBwt2eDhHkSHwYnzcscuC9i2tU/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(426003)(6666004)(4744005)(26005)(7696005)(2616005)(1076003)(82740400003)(16526019)(336012)(8936002)(86362001)(82310400005)(186003)(478600001)(41300700001)(36860700001)(110136005)(356005)(5660300002)(4326008)(83380400001)(40480700001)(54906003)(316002)(36756003)(81166007)(2906002)(8676002)(70586007)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 09:00:01.0855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc578a8-d0e7-4853-6899-08da8bf85a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the corrent highest perf for some new AMD processors,
the amd_get_highest_perf() call will check the CPU model and
return correct highest perf value.

Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 48276c0e479d..bdb0bfa80525 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1184,7 +1184,8 @@ u32 amd_get_highest_perf(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
+			       (c->x86_model >= 0x70 && c->x86_model < 0x80) ||
+			       (c->x86_model >= 0xa0 && c->x86_model < 0xb0)))
 		return 166;
 
 	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-- 
2.34.1

