Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D585A137F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiHYOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiHYOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EEB6D69
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQKK8WZP1x2RT4IDu0LZusI43ipfaqVo2tB0KLoNiu30HyqH/SAcN+BrWN7l3MtMeKZK2unl3NRtPCLAEuIEadMf53LAqsMym8ulsi1cvT8mFMori+6GWUDRKOSaaUtq6Sy2Ed1Fy6hu0dfVFqqrwpxGisDC5kQs8FPNGPm1EX2KNTvVqMdd300cGd8a7cNmCNa/CQmxYRRsOF9oNbgNPcUC7u+gb6IckMBGG3Q2deuPicRg+HPjRuxJX1yhguxW4H8UROwZnlTsfWAQIRj9kzl1SbD2VSKhFVnEpiWAsWOKG8sb2e/5gs8afEtxcZ+JPbgeTTtVyWdQrO5PpWX4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAbbVS44d1PXjCPzbKQZ+RMiV6nTKz/ZR8vnsIsvuI=;
 b=f3tkM5Nwde8ohvWh09hag5U2Gof3LWPSphSxaTy0TYMBFq+soa3MUH4U5RvuyVp6u9QerW0pBYIz3QEuBma3vM5fLyclju2ATDx+Dcwi3W27NCqlKgml/3oLT5viNb2JXPGImlSUgc6/QLzvIQCDvlw60bwq+cUuZ4X4vgfgyk+nJ6NexNh8VF1wFYS8572SQHK+G8+/ZEPTCOhxbcJqoTnjRz8FHZu9lY46v+Ho/+06TgMyWBo7i4S4bvMQlF0lNGEn/9eQvjAh1Kt3tX5lUhNwBWNQ2vu8rZNV3EOGcxZKg42Tnqnz1wYVwe+QpKmkfjoSCzYhZhnpYQiGmUlA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAbbVS44d1PXjCPzbKQZ+RMiV6nTKz/ZR8vnsIsvuI=;
 b=bDmzArCagb9uN/6Np/25sMiTSoWtryPbJXe1jZI6pqWQQGRZopFHe9qnvq8CX5v5oeC5ISWKbKdhm1FdfRmUQZ8w58IiRVpYCPjAp1bRfQdmuPOYT+7OKnaJWM5mq2nmKnU5X19X9AWM+X0dS2r6g9q/Rp4ZGp2cKAGixxVcPfk=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by MWHPR12MB1902.namprd12.prod.outlook.com (2603:10b6:300:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 14:23:31 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::ee) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 14:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Thu, 25 Aug 2022 14:23:31 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 09:23:27 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 0/4] Provide SEV-SNP support for unaccepted memory
Date:   Thu, 25 Aug 2022 09:23:13 -0500
Message-ID: <cover.1661437397.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f4d0a6-f1f3-4cd0-9966-08da86a562ef
X-MS-TrafficTypeDiagnostic: MWHPR12MB1902:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZr+u6Vnn0Ld6rxYF0n/9hiKhBtvmZyY24ccxePxn4hJs/VV+hTPoenEPiFu07y5qdg+VR2hg8PiHR6RgjN5zlVXBt8cH2iDIihmX4+SoRlk1+lNJhAItvU9csxdJjQiCuVSjL8OP/+YnaSWch99dwy2iEeXr5qyXY1SMy9etwzT4vNEF4A7VW1m34R9kkR5uLkxCzK/fxGwKHy0kD7bQwsoNueE67NsBUdfmyjbQKn5WHIisYaEK3G6r3tfte4pQTMXtaLtcitxieoNCQSRWoojKldWTrD3IdzQUgz2AMh30xvgQnL/t5Tk9qVBKr1tZ6DyY4ePseMrDCXw4Ja/oiG2JX4+acWK9tqMo8RfIh6Xxubo6ku1BUW4FJK45TTIKz0nwMLiAm9ss3fjE7RhWFkmYBHhq9KD7mEPOBm1anaEvc7KCJja1ngZfMjct5n5gC1kM+PASMwA6jVbZVYayN5ctBLXiNARfTlQ/ot9S+H06ah1toCB9L6j5qU6V0a0Vtxc9C/cxQRZo11hlovvgDSdmpDsBAUCBpHZ+6N3Bzm/F3UtSxWzP8hpiENYYi+UtSnWWzLTq7JhKFO/uTeMs5coGRQ8Wb6pRJHY5P+XX4tfFT+3xqXQ43BZ/fi8JU1N9RDWYCAtjn2/SpPeWsRO6LYwJoYyrMA+Bl3Hv1FBsWEvlda4LmrAA6adwlbdhPYFanQ8hUL6V1cY2vBrnFmuEWYhzPYnxRhZjyYP1LrHJGJUa1Hiu/Zmyke62rQaxJ8GT2WjtVl/rhc/9klH8cNULK6Jza2T/NvF+AGoiimoAouNIHXc9EkbV+KRWjbHxdoAYFY8nKe0K3/FIg/gFOoyaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(426003)(47076005)(36860700001)(83380400001)(2616005)(16526019)(336012)(26005)(2906002)(7696005)(186003)(40460700003)(81166007)(356005)(86362001)(82740400003)(40480700001)(41300700001)(54906003)(82310400005)(316002)(110136005)(4326008)(70206006)(966005)(7416002)(36756003)(5660300002)(478600001)(8936002)(6666004)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:23:31.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f4d0a6-f1f3-4cd0-9966-08da86a562ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SEV-SNP support for unaccepted memory to the patch series
titled:

  [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory

Currently, when changing the state of a page under SNP, the page state
change structure is kmalloc()'d. This lead to hangs during boot when
accepting memory because the allocation can trigger the need to accept
more memory. Additionally, the page state change operations are not
optimized under Linux since it was expected that all memory has been
validated already, resulting in poor performance when adding basic
support for unaccepted memory.

 So this series consists of four patches:

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a (smaller) stack-based page state change structure.

  - A pre-patch to allow the use of the early boot GHCB in the core kernel
    path.

  - A pre-patch to allow for use of 2M page state change requests and 2M
    page validation.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

Changes since v3:
- Reworks the PSC process to greatly improve performance:
  - Optimize the PSC process to use 2M pages when applicable.
  - Optimize the page validation process to use 2M pages when applicable.
  - Use the early GHCB in both the decompression phase and core kernel
    boot phase in order to minimize the use of the MSR protocol. The MSR
    protocol only allows for a single 4K page to be updated at a time.
- Move the ghcb_percpu_ready flag into the sev_config structure and
  rename it to ghcbs_initialized.

Changes since v2:
- Improve code comments in regards to when to use the per-CPU GHCB vs
  the MSR protocol and why a single global value is valid for both
  the BSP and APs.
- Add a comment related to the number of PSC entries and how it can
  impact the size of the struct and, therefore, stack usage.
- Add a WARN_ON_ONCE() for invoking vmgexit_psc() when per-CPU GHCBs
  haven't been created or registered, yet.
- Use the compiler support for clearing the PSC struct instead of
  issuing memset().

Changes since v1:
- Change from using a per-CPU PSC structure to a (smaller) stack PSC
  structure.


Tom Lendacky (4):
  x86/sev: Put PSC struct on the stack in prep for unaccepted memory
    support
  x86/sev: Allow for use of the early boot GHCB for PSC requests
  x86/sev: Use large PSC requests if applicable
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                  |   1 +
 arch/x86/boot/compressed/mem.c    |   3 +
 arch/x86/boot/compressed/sev.c    |  54 ++++++-
 arch/x86/boot/compressed/sev.h    |  23 +++
 arch/x86/include/asm/sev-common.h |   9 +-
 arch/x86/include/asm/sev.h        |   7 +
 arch/x86/kernel/sev-shared.c      | 104 +++++++++++++
 arch/x86/kernel/sev.c             | 246 +++++++++++++-----------------
 arch/x86/mm/unaccepted_memory.c   |   4 +
 9 files changed, 305 insertions(+), 146 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.37.2

