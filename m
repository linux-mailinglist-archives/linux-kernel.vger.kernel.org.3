Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545C51F3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiEIE6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiEIEzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:55:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370981238BC;
        Sun,  8 May 2022 21:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZSGM1DAhUOcC7JGgmrJsQ01karVcW2aCDRtoQs9Bkf720KX5RyV4OZmLHJAtIB1m/7AxDQEcRJrYhBhQBTg8ZOODiybvP7+uTzH4JZKMPpEbjdQ3BGe4yowSqrX7grclqSIhgTKhlQz5lYvWKKNMSvAVFC13cGH7zWNCzoI+aUhhMk9sl9O77UIslVFeAEV7jbFhl0RVsSYZEyGMSMojmRPg/hrIyOqntHKvy14bg2FC7aPvqNH64j1RrjJ7maK8h3LNmRCpntQy7CzQZm9GtDzUBDtt5TAifUvxd96coYV4N2zf5zsGaqbdo55xZTnKrBd2BWoWsyRYrS+nnUAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvGO2hnqcqHJP2EtSdwF+bhOn1fiHAiP1GSeVlAY9M4=;
 b=mV2vqeyVsiynWT9lLbn76FEWB8yUO+9KWyKtT5MCbFJBY5wXolKkmzs6WxjisRx0GPrQCJ9qa6so8UvV36W7+UabdqT4YJu9o6aBaEOvu/c1NUNNyT4/NEoc8ww60y7buG6427uUczlhm2of3ePVG7zQMeAMcnDTnAcbwC5j6K+njvZcEn5NKkO9lP94NPMjfR7+qtFcKXO5exIgqtZ9EdNM2xJrCZIMijN4N6XN2kYL8Z3emiqpKEl0AhNo69sP5m5oHqY7ZuQaoie6dbigOVg3DY8EAidZDbcmW3XAu7FEKVQqok4WC7HZD75ppb2Xzp1Uy6v53CQet570Qgl3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvGO2hnqcqHJP2EtSdwF+bhOn1fiHAiP1GSeVlAY9M4=;
 b=aIfMDqbdn07BbWSs2woV6CRXecue21TTXyAsY+7du234u5NfvlDZgVQYV4tFwSvnnoQfZ2cGOdSShuqEiyU+HVRdhaxXR60YpBo7anNaHq2Ho7lzdn3YlJmdGrWMN2G+edfdpDPGfFQKha+1qBGCkWDmajSCUxTkgZ+bisyxYUk=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 04:51:05 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::93) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 04:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:51:05 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:50:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 8/8] perf ibs: Fix comment
Date:   Mon, 9 May 2022 10:19:14 +0530
Message-ID: <20220509044914.1473-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509044914.1473-1-ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f892ed-2b81-406c-b296-08da31778689
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB486248987D6757C30A95868BE0C69@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D5q6lC7SYLhpXSEOdfMvU4QsAwf0MQlx/GOf5yhu19DHXq8ezzInFSBfCr3bTIwBmlux/SkFrJvEGEQuy781F3rMKuihY/zOQBXsLMwgtKRgb0JcOvTzVBLj/sKNes9ivTZIblGUXUWIeXgWxd8iE9Gfgfx2RBO4Z/0qUg/E94EeHIDPevQiF6L3U8GKNORQHgPoiamPNQ0YVI/vL9ypGEvqyTgO1cO0XluxS5bUl7bqzoBS9byLXbmbmEUrfhLb/5d9wH/5t2E1yt+pnrw9zoxlVaTOyoWOR+2PDrdQ4tQeyAABIoatc+AwuTUZeiywbPFIkjmiqbEXVxb4XMi3VGj2qvkmqcqP2FJKJK5DaOmpaptLktU8gb09EUT6AW0YxnqGvk9gkPxru7ypvzWusxWpfEcTV43CVfrpIaHbuRAu7ApzeXMVIIdq0vI0LeZ5X1nyVFQqTyRHaZE47TT8wit/ZXxaM0nPBPzyuEODpAAOjFxd0Fqg5oKSfLHRw4Y09rXounYf0Ez/O4drCD8YHJj49xD0PxdqdrUeT1PsQBNFecH9ykkXAEWfbEnpBha27IXqI+G9mt4fn9+qbQJw08FKpff10rY6a2gxMNUF5+XupUGxc3o19yJcH+ErLsBqKxq6tI9N5rvkGLXi34vCVxySVQB6iSEzfZq1zEs/pZZjZzrIzqVhiMEy2Zfzt3iCyM8OuURdPnQQJvy9MyIIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(36860700001)(81166007)(8676002)(4326008)(26005)(4744005)(86362001)(44832011)(7696005)(6666004)(2906002)(356005)(83380400001)(7416002)(5660300002)(508600001)(8936002)(40460700003)(316002)(1076003)(16526019)(36756003)(186003)(70206006)(70586007)(82310400005)(110136005)(47076005)(54906003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:51:05.3605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f892ed-2b81-406c-b296-08da31778689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/IBS Op Data 2/IBS Op Data 1/ for MSR 0xc0011035.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h       | 2 +-
 tools/arch/x86/include/asm/amd-ibs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index b40b2d4ea2ac..f3eb098d63d4 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -52,7 +52,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 21e01cf6162e..9a3312e12e2e 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -52,7 +52,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
-- 
2.27.0

