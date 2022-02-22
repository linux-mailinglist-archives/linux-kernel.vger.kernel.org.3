Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703E4BFCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiBVPf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiBVPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0016305C;
        Tue, 22 Feb 2022 07:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZzoue4qnopXwJCilAk3QeQ5AOUm6Tv0wHzaKucrc4sgNZlwxRybDLQg0fF+Ui5LR2mRq/OOsvZ+WSqZDhUOwPVeSSoPYUggceYHi8PjzIzqkqAxWUnuK+vyUVn72iXC/WNu7ATkbOPgv14yDl7HhbAlOQ8R8+jw2mxfbeDmb1JVRue1F3uONjFvYW0ERMYNEqzYzQ5CF/Lw5vghaXflZVp9Piz/F8QOtAXrKliQIK2bu33tqJyPztdf845xiUFaIxfNYStkWxhREJEozmTkRcYOohxk3C+Eu2SYUGJGitPR0WxFCFbFjjTipW87NhpOPkYz1O4h9YwLeHYIxmBtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy8TeewnnR2/h2tASJ5GXLvwUizrySg8Zlw3tMxk50g=;
 b=oK9okzPyW7i8orRLXLmdarIV7KYUvABI2o7hW1xPlBWdi5xFFlgV6ROyKoItuTwaAp3YFbaj0PUU7rr0oSvwkyLoL52nUUu+Ub62H/iRoOCvZlACuHpFKjGckyHWrF6IwqNhbkoH3uCawWuavoQ+anN2ML6SJggaqQf67/NkErjOrs8zg0d/u36S3ActrNYERTwA2R3//53hZMkXn7YkoDfpwqFGnzXZic0Jx8vJAdGNdYdk99JwP0VLl81I/OZudF2VLIxwaw7sU9ZzeVdXiDhmqhsZ3lmc7bSSNsd8cvd+rCeTHL5EIBsbadvtTkvCLpNY3orWJz/YXhV1c0jhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8TeewnnR2/h2tASJ5GXLvwUizrySg8Zlw3tMxk50g=;
 b=c50TDP0T6qdrSC2n+mP75cY4xBH6aJ5kIi/x3Up0oRt3KHfc6T2mw0SbI6/vy6p1Ld/vtqIvmvJeRVltl07SryAUw4XUs60XXK5WnHQ+E/Muz/c7jXZ99M4/J6J2TDgwuAD5bp8WYxYGmQtTHHzvNzqiH8KoUTzoZXuYu/KhULI=
Received: from DM3PR11CA0021.namprd11.prod.outlook.com (2603:10b6:0:54::31) by
 MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 15:34:56 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::be) by DM3PR11CA0021.outlook.office365.com
 (2603:10b6:0:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:34:55 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:34:50 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 01/10] cpupower: Add AMD P-State capability flag
Date:   Tue, 22 Feb 2022 23:34:17 +0800
Message-ID: <20220222153426.2216974-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b892d513-f342-472d-938c-08d9f618e075
X-MS-TrafficTypeDiagnostic: MWHPR12MB1376:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13769834079EB024BA4E0C71EC3B9@MWHPR12MB1376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCDEqYvIeod14w2wdMzSM8F6S2VKi49AYa016XaT4YzaY2Tea7AEJMTi6fwNg9tqEVN3jX1b9mWkHW6AYeSJ8GLhYyVwzFYgbuzCF0cBeEMwmAzADAT4HF4UlZrjQaVeNyAuren/KEpJRUZ1bU6b/jfSe2v7Xhm/hkQlFgFw8hDuFSNPKlpL3FlR6ffQk65H/4YIpui+h8BMR3t67p/zHOa6OEXnv3Fo0sY+fYS3lQEcO4rxEPcumamXGENAz/Eggtux7Y3Qwp6gUA5qy0GiEfaY+PIBDpKqnzkNvSba7umuZr+B6rODcfcE8d5CpV4Q51Uo6i8ryr0muleWWHmaBQ1iG1blh1Uchn1D/A79YaWCHBhlfpviKb2IUzTynLbmC6uaA3NQmTgf2XUJ9dLX/i2K3xIgLFrVkF3VAZvWTK2A7xl+C+Il9015E+jooysKytea51K/ouLJgJrCtimMGnhlCY4eRp7SiHyEw0CqIIZl+otdXasEZ14z35oxT2F5xT1abLNO1XKsfW7KOB2vu8jfa5GdLoWGzQ6Mc5zYBMgduApdEMuSzMnFyDb2IEBuOz1CjCrzPo3SHLfAaVPjSYShYnFfouRkpmjAYfMQfCzZ/bAbF9jrH3z2q3KajBMuLcVkDjc2qrDljKlgGW/Roc928fmJfBqe+QzpGmSwF2KxEv7IGVluArrO7ILIHbYJfT2TPUbSJXBZWSg6N7F8OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(7696005)(26005)(186003)(81166007)(2906002)(36756003)(6666004)(356005)(36860700001)(47076005)(16526019)(8676002)(70206006)(70586007)(316002)(54906003)(508600001)(426003)(336012)(82310400004)(4326008)(110136005)(8936002)(7416002)(4744005)(1076003)(2616005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:34:55.3992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b892d513-f342-472d-938c-08d9f618e075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD P-State capability flag in cpupower to indicate AMD new P-State
kernel module support on Ryzen processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 33ffacee7fcb..b4813efdfb00 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -73,6 +73,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 #define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
+#define CPUPOWER_CAP_AMD_PSTATE		0x00000800
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
-- 
2.25.1

