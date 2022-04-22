Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D550B948
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448253AbiDVN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448238AbiDVN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:59:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183358E7F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg+B0XeF07Q5AuT8/UwIpD948G4Yv65BuPco/Y6jZGMTtCPVzHNYaXpWfTMWoPVNHPyJTLTCceRDqJErEmAIWSnj+hD0sBz76sszYfTEb1FyPTqNRVY5EZnboS6mYGQ5CBqKl6zqU5wU08HrH8TPlPofxj5hPasn9OqOr32UsU/WKmiuJqTzoum+i+0jjDebQSv8m/lP+TO8IFPzeZuVUxwnS0oV3KseOy9fdRyjAukHEzX6nAEIpX1WDdHZvuZWsctF/xC5qaNei8mqZWo3YzeG6fehxjeuJG3e+3SYp0foOhNM2aJDUbnrDHjDb/rVHnElIr7rnSTLOqWRE/nvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDontTKZotH8ldP82kb8V57amLDd4WdPeM6ejg6UGAU=;
 b=nr2h/5ZKY7Go5bQcSyyuS2zprEybNNthjH+cFMzmY+BZb9AoIOoGWq6YfmzQmdY/J/STrhEf5J+5vdLX7ojtVpGlc40NN0x/lNCIhRHDwRKf/XTH8eac/JtgRWTPc6Txx4Vzu3q+5kDddiWlG03HNa+lolgjpI+j3Sy9/jPd+whhT2g7SfL9a/V5TrtJXlQqfXRE5KqZBEg+NuktAKHGJkBAvcfNkyPBJhzGmj2bMFYw8s8Wp5U/VQKPOPULNbwQhxeU5f4YK9DujdEZqhSIJnHx9VirMTgAopOkXzwBwYtKsdskcsH32gK2h5BVz8Q3ujze4UkEslAHA01OJ74yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDontTKZotH8ldP82kb8V57amLDd4WdPeM6ejg6UGAU=;
 b=ig6izKzkQVcrYVxl6vIU6kXS2hWgldkVkJxAzZnqcW8VTf37a6OYBjCzRAZMQSVbMhJIE9YPqPo/Ekji0qHCDvBywtDa0pL76zi2qy8ZAaFJ/RZSmC/lUm6Q2De2z0ztI4lP6ncucVXUk0jvclh81xnTMn/zJLm1XOCopOBdNv8=
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 13:56:53 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::6f) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 13:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 13:56:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 08:56:46 -0500
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
Subject: [PATCH v3 0/2] x86/sev: Fix AP Jump Table handling for SNP guests
Date:   Fri, 22 Apr 2022 08:56:22 -0500
Message-ID: <20220422135624.114172-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d1866b-dd7b-42e8-96ff-08da2467f495
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072B34D9EDE6A76B8BD771295F79@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt3abVsx/GD+VLwlVqLjYk8IkWSOW0y054E6vgAYB2kFZ3+rEPy1CZRa7UAyx9NBXg+iTkMn5jzWKqR6+Zs+KLXSu+10JIGs4O8VmaI27mfT2MqUQQEL/v62v+8/J4eLlrC1VTFpctJ3YWdqsHmHx8R6OOH1ERm31+H29wjWFvo79Osczpcuzp5/5aMuPFXbhMBWM74+dUqjuNWZHO6NS4r+l7R3G54wce5xMtF6vy3aC2Y3T5IL+pg7GL+alUYTygNKYRhWEq6Haboj5qn8tTcmd9Fd2km8ThCHtZ7c/02rSYHh6jYd+0/89QxxQRcSKycMppnTXWOLclt3SFVrCaOMJiySncGUZYBGBuej6YuYvZ65gJipCqYLTikqhQ4y1hY3YkyLHnEKELiMZZtUE0BO/IEgszuUZvyV2f/ttdHozBx/j5cJy5WVYrWSWUlloy8VhGfHx6Onzb4znclzXsFUmjO3haoTb12WrYUTdWyFQcCrl9uPIAzU2GK+1Sbvu/fKJpavH2ygSZgXGCzFJYlYpwLOpa/Nc+nCVONc0FH+Fo+DQBsy+LlbeaAzarxf/UK8xXuDbN9syYahDSBLNA+4uMH3XsnaxHPLqYUtisLPsuS3KeYEIIHIE+Zjl0AUyv2kYD9AW8b9SIwypEWrErDk8E4B9jqJ83AvFcTQcpiFykXjuvGhg1r8Z9SfNjusPXLLQ7axYUq9F6eGDoSI/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(426003)(82310400005)(6916009)(54906003)(40460700003)(70206006)(81166007)(356005)(316002)(36756003)(336012)(2906002)(508600001)(83380400001)(70586007)(5660300002)(26005)(7416002)(16526019)(186003)(6666004)(47076005)(1076003)(44832011)(86362001)(4744005)(8676002)(8936002)(4326008)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 13:56:52.8928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d1866b-dd7b-42e8-96ff-08da2467f495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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


