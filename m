Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA38C4D4575
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiCJLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiCJLRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88CBE1EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRJKDKOf1oDpbkRm+PAefJiwUAV28dLzpgMP9zNIQHwmGCIHKzpeVqllql25G3AWv8OIt9sEvsUwhzY50Fx+uajThPz9GuQQxRRW5W2P+R6ovh1AN8xBomW0h1PSUr6MA2pCtQuIThT4WTQ8G34GmxTfJLrgHYvAgMO1gcUrD+hQPuHvXTMXFsk6jzBe15lPcPkF+0B07m6zTp57GafhtAA++sWeOD0MPxaxTQH0e8BeN63aN1XZ4QOZ9bmGBKgAbtBhlrEnEULUhucrfy6ul8obomCDS9UYgaDfArRT5H+YIJvMOLq4jbGpYkaIY75MYbiTZL+xmNEzB7yN6Fgqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP8VIHMHET5trlL7sV3ghL9tgHiFgaGrGGDQzFeJ0Ag=;
 b=g3jTGBR1GJS1fOJFEhncM3UopXHSy3qnG1Np5LIyQfz8+6vY9ktYIC51UKA2ipkdCKOZwCFhDp7gS8I6WY2AuS4o9ZHph57ZgNZuh7tqDYLWdXZRuZjb0vdhfEjwLR9I2RHJmMnMZKOtPDaA2ebCD/Oa2I9OQeTc7A5DHvLY6g9oLQtL6kORpxbPJtxQH7+Bg4u3085APmzKmp6TWTOinC3W5g3BFXiP1TAVtlNsUbJoa8G2OnmxHFPgD7DpD033y0zg6vpoJsHSOG1m36jqDHZAw/qAMDG6Uge8lWKWsWuRZQnxEuTPbBY4f89qwnhsxlXDtJyEQgVbVkjJwHui1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP8VIHMHET5trlL7sV3ghL9tgHiFgaGrGGDQzFeJ0Ag=;
 b=MHE0ncczUfInDzfUsGA5neMZCVzRQKik6HT652cvEiln6mJH77kUC0WH5c8y6MZqZyAwGdkZvUah43YYoD+F8BXaykzClISxlZ/k6AihoakixlMLn5njgm2ixnZsHHLiENBb0xjhgIic5/LDBio7j1Va+kKMIrGJxR9MhBVbrPo=
Received: from MW4PR03CA0192.namprd03.prod.outlook.com (2603:10b6:303:b8::17)
 by MN2PR12MB4015.namprd12.prod.outlook.com (2603:10b6:208:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 11:16:10 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7d) by MW4PR03CA0192.outlook.office365.com
 (2603:10b6:303:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 11:16:09 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:04 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Date:   Thu, 10 Mar 2022 16:45:39 +0530
Message-ID: <20220310111545.10852-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f37e030-b3ac-44e1-52d9-08da0287612f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4015:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4015E2408F906ECBB2FAC9FFB00B9@MN2PR12MB4015.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMtWsUYqDXRiSTottIk26CVZVgP/M2Xyz0h/+CRdtYlXJV5pY1IpxtaI1t4/KbXbMhWjs+htlaYrOOLjFU6ORgwUuuM+MMWlSe8VqGp+CCl/1YAXtHRNtdrhRSe43K8aFgF3RtcKMPWfJ9ldsBQ8X7wkPXIdJf5mSsso8TAT4OMLDruuBYvRDJ4NSHURGrjVLG+T+u/D0Glq0HBkgQWhN9nJMBEk4Z78Xnuh+OyhX6yFb+TRTXFmwjHtpVV6Af7AJ0yzkQ2b3koBtBGp716a7+93wTXLJ0QDL+GPkW7TcCxIxVlUbU3oUq3z1eWodppwjZdYmJLY7wlMW8cmKKZNQIZKYOFOIDOqV/eIho46QZYTolN3OScaOJAE2cWh5uyEGFZQuZdgKuPwhcYxgzNsheiOiCNNCCgrdzPyQgv2epDIC0aT3so858QOCLBcveU3GoYl3SQpb/mX/dab7IRx/jSpLCoQU55OxWYbjeoTe6LHAnIZUyb5CUNTdQ9d7dnZI6eYcF9JBbi9xL87X/bJKb8ib/X5FPrvAo9rvKNCM2E48qGz0afZlI+TK6m/IH4L8U5UGXPcFd7F2ZOgWneAggILeBaisJzQlSD6EhCT1urs9JZp9UgkmBowctt3Ppggxc7fApEoJLMdx8Eh7LvNFJZHfMNttR2JNnQITypkRDuNYXm4eDRr1eG/hUD/IliuI2DnT93EWXdzXwqosOraguFIgGcxpcIJk8s1DjUoACepN31F3o991FhX0SkTMR8GCveQ9o0rEkJfgKb879dy4SlvsIh+4Z4pLJtqINN/0SbAKUghyOGBIk5q+dchsI3db4cMvEny9VEVqIC7b3Nfsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(70206006)(8676002)(70586007)(186003)(26005)(336012)(81166007)(4326008)(316002)(36756003)(82310400004)(8936002)(6916009)(54906003)(7416002)(36860700001)(356005)(40460700003)(86362001)(966005)(83380400001)(508600001)(47076005)(6666004)(7696005)(2616005)(16526019)(1076003)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:09.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f37e030-b3ac-44e1-52d9-08da0287612f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset makes use of Upper Address Ignore (UAI) feature available
on upcoming AMD processors to provide user address tagging support for x86/AMD.

UAI allows software to store a tag in the upper 7 bits of a logical
address [63:57]. When enabled, the processor will suppress the
traditional canonical address checks on the addresses. More information
about UAI can be found in section 5.10 of 'AMD64 Architecture
Programmer's Manual, Vol 2: System Programming' which is available from

https://bugzilla.kernel.org/attachment.cgi?id=300549

Currently ARM64 provides a way for processes to opt-in for
relaxed tagged ABI via prctl() options PR_SET/GET_TAGGED_ADDR_CTRL.
The prctl() API was found to be a bit restrictive for x86 use and
Kirill had posted an extension to it as part of Intel LAM patchset.
(https://lore.kernel.org/linux-mm/20210205151631.43511-1-kirill.shutemov@linux.intel.com/)

This patchset builds on that prctl() extension and adds support
for AMD UAI. AMD implementation is kept separate as equivalent
Intel LAM implementation is likely to be different due to different
bit positions and tag width.

This is an early implementation which has been only lightly tested.
I have used the tags_test.c from selftests/vm/tags/ to test this.
For ARM64 changes, I have only ensured that the changes compile.

Regards,
Bharata.

Bharata B Rao (5):
  x86/cpufeatures: Add Upper Address Ignore(UAI) as CPU feature
  x86: Enable Upper Address Ignore(UAI) feature
  x86: Provide an implementation of untagged_addr()
  x86: Untag user pointers in access_ok()
  x86: Add prctl() options to control tagged user addresses ABI

Kirill A. Shutemov (1):
  mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface

 arch/arm64/include/asm/processor.h            |  12 +-
 arch/arm64/kernel/process.c                   |  45 +++++-
 arch/arm64/kernel/ptrace.c                    |   4 +-
 arch/x86/Kconfig                              |   9 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/page_32.h                |   3 +
 arch/x86/include/asm/page_64.h                |  26 ++++
 arch/x86/include/asm/processor.h              |  12 ++
 arch/x86/include/asm/thread_info.h            |   2 +
 arch/x86/include/asm/uaccess.h                |  29 +++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 arch/x86/kernel/process.c                     | 134 ++++++++++++++++++
 arch/x86/kernel/setup.c                       |   8 ++
 kernel/sys.c                                  |  14 +-
 .../testing/selftests/arm64/tags/tags_test.c  |  31 ----
 .../selftests/{arm64 => vm}/tags/.gitignore   |   0
 .../selftests/{arm64 => vm}/tags/Makefile     |   0
 .../{arm64 => vm}/tags/run_tags_test.sh       |   0
 tools/testing/selftests/vm/tags/tags_test.c   |  59 ++++++++
 20 files changed, 335 insertions(+), 58 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
 rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
 create mode 100644 tools/testing/selftests/vm/tags/tags_test.c

-- 
2.25.1

