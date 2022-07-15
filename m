Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E349575F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiGOKGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiGOKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB782F8C;
        Fri, 15 Jul 2022 03:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKjjHy2O0lU7z6vzn5b6f3V/4ubizZRT+YznzALlUy/tF4VS0tVj1MypIH435V18gVNskJsxAtK4ExGCPLJspWnix9/Pm+WW8Zut2u60yuwpYMOzqa9F5yBX0Hyl3qbS5TYgbe/WX7Yd+x4Xy3gaFocg/Bdgc/5NIOmwdObFKF0ZuVSmKoEx8TcflVYE7Qkb4Lgf/JFtS8Fir2fvJczsEDRXmEQ3MG8jTBT+muShIpSS5d1TW228oGEqaUcY4Vm15VdllvibqEJG8uRM62tF6UBf0VS76L421bugzgoLiOW/+JyGziDLASJUUEGn7xaIpC4AZYlth4slBGXK7IZhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Dge5roJ1lX7QI35KBgccomo6IM3GEDgTMHIK68aPk=;
 b=WSoFGtk6wjcQNvg6JuNVlKBnWk3iudaxwtTcaBqPQXIsc5fn8W9yXzaD5UrqL9Y2WbdpBO8zbqV8XeTP5nhkyRSIzaxMOVjWGRMPmAhgr2uMb8qnkiXhzFkKUBUpzXAuxrQl2mYw8aOMgOIdWMeUSgIn6Ev/HR/0CXWxbCLX3/C2E/57Z42+eGo0bSWZQaMwg+DkiYH3fkXtphvxVUgvpVQoh6pXVoqjGCIE5MD9v0NiSd77vBDfVXssRy+lAWVfo9BvlorTY5Br7pRDmB00eBsodepEzczn080vbKfB77G1U2utO8fXa85A6v0n05nH1PvFX4h3IZmVR9RfvvE1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Dge5roJ1lX7QI35KBgccomo6IM3GEDgTMHIK68aPk=;
 b=GQV1CDkIr9L9ADGozoGhz2VkUmj429NmzF8B8zBO15kdkYYGd0B80YcAVf9yjfVZ35hpsfrT3Wq8gjXLpu/z2HSenDbGH2oif9AHQI4k5mRW+M7ZtIr5txvT34zlq7P87TKLc2eTdMN6N2tDWO4dBJXgx5T2DntgGmhVAi4lBIQ=
Received: from BN7PR06CA0055.namprd06.prod.outlook.com (2603:10b6:408:34::32)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:05:16 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::b1) by BN7PR06CA0055.outlook.office365.com
 (2603:10b6:408:34::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:16 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:12 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 08/13] cpufreq: amd-pstate: fix white-space
Date:   Fri, 15 Jul 2022 06:04:27 -0400
Message-ID: <3ef38105e85e6527d14d9d0e2f969fe2ff86ce45.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8eb14195-4bbb-4113-f62b-08da66498473
X-MS-TrafficTypeDiagnostic: MN0PR12MB5836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d21uW7vT++9NfRecwURQMPxm9yzgjaQfWV/+7lBW9fUKntNO6C93t7Z+VBSLj0lJkMKww3e/wJG5LouF3/7mN83yYYSSvY/9i6whyHPUmGTzhtn3KKrSVbwS9MZKkRKJrwmTnWFKIGjSOsmd0y3E5JtJwqjUsnxuuQwoS2DAoMyieYsfe8EoVzJJgLcSE5cUK2ecX632RhjXG2quGYscxsM7epJe4Gnl7GyUX34l1/mcHmJN4FuX4O82DUbJACTfZjyAfclR4jc9GIRmXhjnhWnW5WlrdiPtnqe3ALrP+l0snqkMZ2rfRKLNLtz3BnzR9J80m+1+iZByqQ7qwYWONNCwCXeHQ4lM24nnQJwDGDZyHWILPjzKUZMrxEB08HYYZvamsvcTR94PXCDzHysJo+BjR9qqWKmHqv0MOKXokUYtzzYMRQT7iI3nw0UgAEsBJfH2M+a/A4AIdax7xdHoBm7JKbIB93ojenUaUxd5+raB4eZJ6lCyQjEQbg4DTBVJxtW6z8qu+tmnkb4X3JltZ2DZOMLRB8yIzO3ZzKpCwCELwZaccYynVQDOLmt9kS4qKOrdRuxQtAUPnkffBSlauHhYcMVZc4kplx1TATdoMOwxxsS7HSncTztrf8WmB0aH4sUkELe9D/QCV93IvFjDJJEW9d1kUpHfML/VcLb8QaOhJAISY5dibO5WAPOHb9eD16wFnp6sAAyTpcPshy5DuTZu5P7q7Hegf/JtmpXyKRnUdiKhpxT0MYGzyeFESn/5DYilGBV8ZaTsE19ZwI6yclf+YJYUsBQbhoMSSwuh436PP2gJ8bSOH/IKFEug8C4X5fOItZKOSt6g5UPXs1HZUFPQZOzHJgqCYukBHjqLZOQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(2616005)(54906003)(70206006)(81166007)(7696005)(110136005)(86362001)(83380400001)(4326008)(356005)(70586007)(6636002)(16526019)(8676002)(26005)(186003)(47076005)(336012)(82310400005)(2906002)(426003)(36756003)(478600001)(36860700001)(6666004)(82740400003)(5660300002)(40460700003)(40480700001)(8936002)(4744005)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:16.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb14195-4bbb-4113-f62b-08da66498473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the white space and correct mixed-up indentation

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ebc7c6d389be..acb62ec5ebab 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -117,7 +117,7 @@ struct amd_cpudata {
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
 
-	u64 freq;
+	u64 	freq;
 	bool	boost_supported;
 	bool	precision_boost_off;
 	u64 	cppc_hw_conf_cached;
@@ -674,7 +674,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
-	.attr           = amd_pstate_attr,
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.32.0

