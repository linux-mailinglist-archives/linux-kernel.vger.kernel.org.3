Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD9589211
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiHCSLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiHCSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:11:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3F51405
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOyLUul9g0Fx6m3ZCkBuTmVbcqkDUIPX1UJPJkR7qMIWsZenJAzSbEWdZdOU2zIy/86ZVIddptO/WMp3OtTND4UoiKcJZllFOHafb0NmmfzMRRWnC3a/zOsqhfoQYk0zzoW6OOo3URZaJbjUl2aH59Y7ppzsaiYNF9DNnMHUk+d1+iLKw6QH4p5yJLk5FsReFXkqPRZ4JkyRNCkPEFtaDwc29pTr3bNwBwmVJMnk9nA41QO6eDTMn4LlNjEH5H3fi0tjojg0csZDEiw4nn55/6O40DlTQLCeItr2vzxlKXErdAAe6Q8JkF4ndfm1bLjxLKWQ1Ou9UtG6kOt/ewsYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eFrMjKBG3BmeJSqfvusj/0iFI6nlIOuY+OoBrpgzLg=;
 b=Ma+j4k0eEQvR2zvQYBb6dCFpt7cjnbzZk9WQ4eH3ziMkjXtqv2b27c30B6ykLe372JGn7SLKjb+rQ7NJsYmWb2ABVXYaWhYUfsRXUjg1gyWs1E1AY6Q9+tWNeMjltT5AGcehYOSCAEzzLqqvDomK44sYnC+cipwHvJZTOBSPc52ket+bAdL21f/SKye1QMWfb4jAHY6KMSjnTTRIth1FnxcS12xNWYEPWmlhXNV/vGNtgfHa87pte/+eM4sW+pKKuV29I6Bvse+GT5fFnHPTsIzuI06m23QcVSJ2r33/A31xfgYlqVj9wG1vSO1C99mi1RV+qbxE0Qn9Sh3XfYtgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eFrMjKBG3BmeJSqfvusj/0iFI6nlIOuY+OoBrpgzLg=;
 b=roam+IInpWKAwiEvA2aMRN4iVwc2/aofIY6I/DpTPsMJNMxk+WayrVw4R29Rtz/F1SgdsAY3zD0nuByu/ipvlOK3/2yqOKJ8l4XRKujbXN4roM+lqVZygauGS2XDKFZB6HBIXgxuLvjG7KzNE2NvVOPGlL8ajCM+40kz/+d8eTA=
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 3 Aug 2022 18:11:16 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::69) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.10 via Frontend
 Transport; Wed, 3 Aug 2022 18:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 18:11:16 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 13:11:14 -0500
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
Subject: [PATCH v1.1 0/2] Provide SEV-SNP support for unaccepted memory
Date:   Wed, 3 Aug 2022 13:11:03 -0500
Message-ID: <cover.1659550264.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93815f68-9923-43d3-f021-08da757b8ee3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf8s0AM0v9Eb4vnGRgST1v1Gjjawt3YjHDJnB60AUCJZFaBQWIjAmiHmXqTiIk4U7/C/Z8aM56jtay5PEPi60XiKSXlO595so33hMsBNeY2pINxpvLdnwjk3rRYEXkq8N8t5YJLA2GUuiKtOqo3fODh74KIuHB/tL2RxlAk8Si2rvRGnq3gJHci8rhFtZ/TNM90UnQddalbPstGRuLpkSHVOYhBWWBhTnfqd1xHNp6b1mEJoEAOfQNf1kBYLMnm2pDgtJsuZeFU00ktSy5xgBWQ6hWARitW7PB22eKX8WxsgrDRYa0W4UFAczlB1Aapp/VImKFAyCFENnZHBSJddtFNzpIeX8LtFdIjGBPAebUi9esgV6nrXg6oWsssLnfYaRxxbR8bpAT5ZfmivEIM32oC/v4mST6H4W838IQmU9T6w8I8+LZEOywdo4o4rJ+FsRCwA82K1U9E1Z1phR7tUe7MH6uZ+t2JxtwTl6PVLo+34TQFnFspuEiFBvFN9NfmcPbcztCpbXqS6YIRXZg0rmv2VN9M0VxatTatzbqnaeH39iasFL8BYKb4aCoQMGBoQG6wqdwK8jJqqJ0N/yrWLkvCA05zVslscvdSSJ8CDAbTItC/BYFWK5LOGZXxTOUNADsLbV0xM+JOGnoDIcN73m8iLUcXZVcutWOw4cfNnkzeasBPdKrVrxQyDjqC4oJS4BpLgJjaQZC+D8iH4wRjD6XhY85Ymb8ndqsa+Zg35vdJlxpUQG13nIQiwEmI89JhxlnRDnoe7sRUGe4DpKHhQB3XyCfCVN1THnel8X0Swgj7rfAVrqzEBofjeGHndDw4K1sjEce8fp/ZQmXv0BzAA8LF/KuX6w3LksRlG7HV3+iBKvzrSSRHTy//H/11edpnd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(41300700001)(6666004)(7696005)(82310400005)(16526019)(186003)(81166007)(5660300002)(86362001)(2906002)(8936002)(40480700001)(7416002)(36756003)(83380400001)(4326008)(8676002)(966005)(54906003)(478600001)(70586007)(110136005)(82740400003)(356005)(70206006)(2616005)(47076005)(426003)(336012)(26005)(36860700001)(40460700003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:11:16.3982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93815f68-9923-43d3-f021-08da757b8ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
more memory. So this series consists of two patches:

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a static page state change structure proteced with access protected
    by a spinlock.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

This is what the static structure / spinlock method looks like. Let me
know if this approach is preferred over the per-CPU structure. If so,
I'll submit this as a v2.

Thanks,
Tom

Tom Lendacky (2):
  x86/sev: Use per-CPU PSC structure in prep for unaccepted memory
    support
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                |  1 +
 arch/x86/boot/compressed/mem.c  |  3 ++
 arch/x86/boot/compressed/sev.c  | 10 ++++-
 arch/x86/boot/compressed/sev.h  | 23 +++++++++++
 arch/x86/include/asm/sev.h      |  3 ++
 arch/x86/kernel/sev.c           | 71 ++++++++++++++++++++++-----------
 arch/x86/mm/unaccepted_memory.c |  4 ++
 7 files changed, 91 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.36.1

