Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB351004F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiDZOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiDZOZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:25:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7D15714
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdqxSqVwmuNce2/GYuJGJVShvHQIlk2bHWNRsJIooRqu63UkcY/D4xoyxaQAaNymjSB+T5FnK16tqS1xe3cWPd3UGJyeFSRpbohwWaO98vYxNWt1+9YlNdss5uyxnIcOBYRDPyD4tHMK4l4l8qJbrSUIAZj7ORJbcfZrEhlh5u4qqTHYp357Vanp6F9n49tMmBHM5A5RAFfUCLRI7HqnSSy4tmc2hKUQFEilU5JC7rzPiWZZVKESKRxkf97ZYkP4J96cubwlKvNBomO3zKJpGO8xnz/nn6Kpg7Wn1irDpFbvajGwGTJHFZSf9BEEUGseWW2NsH4GyrBSt9WOk68nMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifu82dvdV3mo0DUouvOO9/1HzkR1/3P1PtralWwI7IY=;
 b=RqPIseUZB1wtWxnWPDoN/T2EEouY2/NYSjo9Tusw0nrgcyYbXXeHWApfvQhpjyvYZGAwBsfmZMoJh/SYeWldzjzY+PapEVvuJMjXAk/eczjouYsz5EFMARELG0jqSXJXWc4wN+B8VZRSefNDiAEV/MzZWKvobwnD5yoELTBQfCdXyQBo0v/zJY6DjE1+KWu3SKNFfFe0V/tZRvf4r+j93h+FD9T8gNDYCTiixXSlHhGI5Kp1T769OSSPohs8rcsuf0WUVLgMPCxTNsyE3fXUPWRXlzr6LUfaVtmHQL3Ac1iSRY2kc0+vxbCN3yWyTZOtGtPnN9cr7wXPD1RkBb6JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifu82dvdV3mo0DUouvOO9/1HzkR1/3P1PtralWwI7IY=;
 b=bb1/OsEJLooQnFrxEpLonnEXyHm5bUfN/QDxBJp5RcH975Y7r2F98rsEzGU/6kQB1dXUeKHZzEGvj2pDEBVjmSkyu6GVGvJiJiVAD1RiySNOcRuQUhR56tntPuhWtBnQv6H/ZC+9VwRI167Ja8/gSyY2PAvkpSC4/8KJgm8OU44=
Received: from MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) by MWHPR12MB1136.namprd12.prod.outlook.com
 (2603:10b6:300:f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 14:22:22 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D1B.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.4 via Frontend
 Transport; Tue, 26 Apr 2022 14:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 14:22:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 09:22:21 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        "Joerg Roedel" <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH v4 0/2] x86/sev: Fix AP Jump Table handling for SNP guests
Date:   Tue, 26 Apr 2022 09:21:45 -0500
Message-ID: <20220426142147.338412-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f28980-fd8d-4c54-1719-08da27902df7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1136:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11360471BD253F0F1E93E51095FB9@MWHPR12MB1136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MYeRGRasd82BTanA4nKbVCHwg8gujKlKCi5DQr+rq0WYoL7jLTkVhywla4+EdHcQ73JhX0MrMREe3V/Lagk7qan8l3mOtkMVfRVQ9D6GreSqTpmw4fEsdk07RJ4lfAvMuta+X7AiGz3pCo64wf5xE5evNQdj7jwQ47lAlCKA+4NVJKRmCGFCTaPhBP008HTZg6Rm145b3REfh+cCPbDwC532bZUkARAMZQhT5p8b114hKNpDlAUtmC1P5CB2nFfet/EY5wGUfpzF4WksPhPDxUznANgM3tO1YX6pNcvCWDV4zxNCvo6HyZKe0CD0nckqunX/aWJeD8JgUf8P0ZRytYHuaIaW45U/b2JHaBjpt3hmNb1UImp/E7kdAtPsRrzd2vaBM0iL7iqLtEWuzYi/YC1YqY1Lp9shbCx9VQYkVdZoevoAErpQ0BVog+qGNlyfe8eFCjYCSVVwXvfe7sLc/SfL1UrbLDI64BIIgm1Xd1kZQS+exYg9eUxqPCwp44m6xN/xA88ZalRK0+wpFqRYeuMCsTRyvr+eIcdRZ4CgFiXMg7dmrhMjA/4dAFq6X8EJinlJtGZneoNZ9uZ5GJ+8VGlD1aISo+t3H1UvfWaXLh8nq4q/VmFVRNB+KEDmpO+d+WlDpICTavkOISpEEPm8RrX0oDBEsHDoSfrEohOR09IIR3Gys79nT7ITea8LPvwKarc0JdOuJOYvdDV2yxLMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(83380400001)(36756003)(16526019)(70206006)(44832011)(82310400005)(2616005)(1076003)(26005)(508600001)(54906003)(6916009)(2906002)(70586007)(81166007)(6666004)(4744005)(36860700001)(336012)(47076005)(40460700003)(426003)(356005)(86362001)(5660300002)(8676002)(8936002)(316002)(4326008)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:22:22.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f28980-fd8d-4c54-1719-08da27902df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on tip/master (commit 1912a07f8a)

SNP guests should only retrieve the AP Jump Table address from the
secrets page, not via a GHCB request as with SEV-ES guests. This series
reworks the handling accordingly, and fixes up some __init annotations
for some of the SEV routines touched by that rework.

v4:
 - Improve commit msg for patch 2 (Tom)

v3:
 - Address missing __init annotations (Boris)

v2:
 - add handling for memremap()/ioremap() failures (Boris)
 - don't mix function calls with declarations (Boris)

 arch/x86/include/asm/sev.h              | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c                   | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 arch/x86/realmode/init.c                |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.h | 35 -----------------------------------
 4 files changed, 90 insertions(+), 62 deletions(-)


