Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78A571FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiGLPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGLPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:44:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA35BF561;
        Tue, 12 Jul 2022 08:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2ejDy7FIo7gX6f3IRvPEL5NPz6gQUMYCA2rsxSnqLBE1JZwfpXc1OkQh/OE1yk1qA13n+0XZb4yqHBgf3DoMTyHoqG+9qy2++3DqDiXn/BSJf504NkGVKI5C5LQ8YJ5wRp0f25Kga9K64+bK6zzZAQj6QsoVFCc0X/UAA1dchXqusHFDCHVRmOh0rg8+nLa34JM1lwzcVk3GcunERiZu8eipGg6vhv4M+VQS1SgTnWgFy2nc6ndHVlbqWmwX7In72Ue6I1A6XHrZc/4WIrNfowl8/3+xX4/1dwE7xRRJgSCGSRYQ5jhzDpYKp5PcTZfBnI0OvW2cBeMHzN4607iFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg1W6FnKHehDtSxZjy9OOG/riwVCF9EOOqtUhcHbOHs=;
 b=YMI3W6iljJ+OQnwv1/26SJ4dFR3D2/O0TrvaKljNl1vjFgZ6ojEIwjJ+HIku1NnrQTVcF/SX31nP1E0kJ5twgtLY3VZVoVwEYmULEXJu4ro1SQIMxK4SJbidt9yUzPwRIn9yfYGrdexO6Tel/c6ARDDvmyVOIiBkXkNSEQjSRx+TFt7O9q47BiRr6RW6Ekim1noyatuH6gzmAUIyThN5PJu1sXvgmv7JGz6n6Vwc4/2o12ou4DkT+wWyRtU+QxYnam468oKzlvXgXbPlxt04DFMcJj6hF6heqgPXrRJYGoryKyBbRlnmBNa2RJHVuulxZv5KQskyAJdwUdior02VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg1W6FnKHehDtSxZjy9OOG/riwVCF9EOOqtUhcHbOHs=;
 b=yvONRESraAs0cjhWhyZLRRjvPn6ohfYcAAajeRB03Xm+NNEm7+oY0VP84hvckhgAxoWtKTCBvrGhDnf6NDFpE2HdfMNPX3UJWlgOT/wZ8WSQexNNOJrd4MIjPME9xFzJ9gjv/LWZ2UOlTh1S+icVKzZQ7B9F9di7nIyMlrR2KWY=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:44:00 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c8) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Tue, 12 Jul 2022 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:44:00 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:43:55 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 13/13] cpufreq: CPPC: remove the acpi_disabled check
Date:   Tue, 12 Jul 2022 11:43:44 -0400
Message-ID: <d36d38953cf819d89eb9be4d1a2baa5b5feeb52a.1657638462.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e50728f8-d7d0-4c87-6e21-08da641d5714
X-MS-TrafficTypeDiagnostic: MN2PR12MB2896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5uRrdzM0x2dEFIvf24kfRqdvYi79HMrQsKsqmCl3vKFzWKl4rSDc+TfxgFEHhcsHRv3UOCvc+IihKgEotF/4SC03cz016gQcBGdCItBRZxhQhjq8EXXAUkBXpJs9d9ec3f3vbw1TV/rSFfx+w9X5bDOap0M7TVXRY3hNlFoRyHySvRQOz/GZs37sf4k2DVXp95swNue8qL99O9mWRK9plGzaV8KSVaAn/sABZzTPMrgGEknvANHsD+UtBoHzfafECf0Hp/VdNy7Eyt9R+pkKsO+LYmCmVRpto76K4agL6e2am5f+sKUEjCucs/iKfMul6yYYep2XixBZdR2cMzwRRsIDHR8aJ7laTtHeFRSok9kiwy/rSCqHKa3NkrFg+jWnXhmLfdsbAaVz2Q14cKd0at8ofu26oGhXKl4qqCl63vwT9Xw5eTsWIjZcfyd5mLDApJUgXfg80hl9LRpvJBVTHXR9pIREjFrRueDuGW/GK3eb+PwH0aVgMWbczZ3VovWxhybR9GxkAaVTfpTcZgZpIs0sk55Ts1k+VrbX3hgfzEGlL3Hj3Td/3zCqbVdM2Q5VCvyIBlpUUL+EajTWtjjEsRMHG9dbdvPPcG9b6C7T2YG/BKvYGdxKpKmZZefXMgVD5QW3mGWV6xmmqw4F0WLKNk1gRFBlJAjYspAJk7ECmW5Cip4466XOc0vSds7np5bYNVIH6/oLgdS4cc6184OM6MzsJ3tJ+U1N8GgDJOu/T31aLFa52Qoqxp2Uz02FS1Jt2esZdSKabw2zbiPm6FYtOoIReRNP9Z+TpViaPzvnzKlsdPr8JjrcQmJKxeZgdw4LKNDtJHAjnnCa+qxM2hrItFxAnmMqtUi5L9V7+l7Wcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(40470700004)(82310400005)(26005)(4744005)(41300700001)(316002)(110136005)(54906003)(478600001)(8676002)(36756003)(4326008)(81166007)(356005)(82740400003)(70206006)(6636002)(7696005)(2906002)(83380400001)(40460700003)(6666004)(186003)(40480700001)(2616005)(8936002)(86362001)(36860700001)(5660300002)(336012)(426003)(16526019)(47076005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:44:00.2413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50728f8-d7d0-4c87-6e21-08da641d5714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..9adb7612993e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
 {
 	int ret;
 
-	if ((acpi_disabled) || !acpi_cpc_valid())
+	if (!acpi_cpc_valid())
 		return -ENODEV;
 
 	cppc_check_hisi_workaround();
-- 
2.25.1

