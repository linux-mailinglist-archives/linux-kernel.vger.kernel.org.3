Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559A58513A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiG2OBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiG2OBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:01:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39C33365
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErOwdoD7d0bb9ZCE+eaKTpnQ4fTemNCAeZYCuleSoOd3dikEAdsYSKVcKTFJkn3BMFePhTZNSzBXJW7+o1X0qOeynSIMIAHKxWsQRpBqxNCawmx77D0zWIDqrNd31hzIEEJK+NKxntkmfbGHBIgj2kgkDsTh79vLteg2nambzZAMVoFmodZhuLoYoNZThbwZsaNwpU7cACvDnJIn9gVlC3wU7YdTZI7AhryoE0g73WO/Xn59YuIg9frS+8YtW800l3rGB9DLXdgJx75StPS01mBWcl15vcWgxBzvFkddzexn5x8blKGfR8jPnX1pCXPUigQhnmxxnkACBQbcm0jnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbCPhEFD7XwhqsIf9wO3OdXQdPCrfsbs5ZWK52yVXqc=;
 b=CD1fDRJWmUSRKHTV4j7b1IpqPrCd1ybwHmM27slLIDvwSbXjUGXbMXZe8DALARIH2PAFUdSB+Yjlmob9Hl4rop6XHJEu3BhNT/PcE6HZ5EH5kVgDHIZuj+BJSxf3GQGg94wCsX0sxEfKrtWOYDiUGRxNntfACHqOM8rhOS1AliB35fQjgrHW6aVCU0asZqsOSbYe8QVR9o14gp/BMfoKvZHrBPCh5bmeO4DmK48tg0S9tILVHUdJkNyTK+z0SOplpQfeBPKavgBh6S1K2pQdIgOksqJf5EkmkoIsPa7XrY4dU3qX/IB8+yAuiAUXwINSMmu2209RM4Xz2oWJIKk/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbCPhEFD7XwhqsIf9wO3OdXQdPCrfsbs5ZWK52yVXqc=;
 b=30zG/9OOVeUw6kABkjPgZ8kVO6gaLsU1XDjRqCvWdDntEr5c8+5qVB3dx0Hrk6M69HGdHkrG+5HRvVlL27Hk/14dOhZ5J1UxEntAUPaSjwH/hTNsC5uq+OdW+dkITQhdmY1hqwqsy43nl6FmwsYwUYVatUQlXDg8SAiy7loaYoY=
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 14:01:40 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::82) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 29 Jul 2022 14:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 14:01:39 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 09:01:25 -0500
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
Subject: [PATCH v1 0/2] Provide SEV-SNP support for unaccepted memory
Date:   Fri, 29 Jul 2022 09:01:13 -0500
Message-ID: <cover.1659103274.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
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
X-MS-Office365-Filtering-Correlation-Id: 5d788131-8bbb-444a-dea7-08da716adbd5
X-MS-TrafficTypeDiagnostic: BL3PR12MB6379:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/X0+ixZuWDrXUXjQRULx51NGgDF6SvIVFJGoLIQduzivNeex4/uxQHyI1Ov2iqtDx9DX47lSkvxdKIk8D2eiBwces/asRDBl7QMGiHgUix4nWv3w4f8KnOrCoroHgNiMGWpW2nOjnNjQvlnXofq7AFfhY3VTm9aH/sYXoI9OrO9y1hYTdh70Omfx/wlPrwunqco0afFnF1yBOlOwH4H3r87s6mpEllzsGLoqJvfv+06CEaIi9a0FxS+Ce6a2UStWKcgPCj5wm2Xvt1anBv8//dO5Jut1ojGyMIZXfezYFSkOmOxD49vN+xEkmo6AsZkLXRww6p+/I8/ISjcTEL1XTxHvXE6SPoyTNQ0ArkS0spIs6xBni8xP0/L/Dv2aXbqiy43mw+4p1aX1E0moner+8GcQMMOS7upB6mj2H+9yHm9zJZxk4ehHf/r/Se7UtjekS+OB1aeiLkHwxkLtJr4sq6DIdHwvGphoPM/A+qdbSrJ2apwJGcPFEVg1/Gm7cUw3XQZeWbYW3vWUNcty4OrcWeFVoAMAMEdizMnArD1lr2c/NL/yT41wasXXbP+f+ilfUURi3BVL+zHdNvn4wYMTU++y01tbmMYUgonLswSqjpg2sqMgXTLItnPI3WqA4ZOt2mwR+VX7GYWh0GVjFOBtg9ELHHxFptdc9S89KU9kuAJRQabsCWFFbIeGNpiPOOAfKz+xfyH/AJOAmS+IrHoRSSnc+YvUvsEmbLHnStazTP8ujCbhLoL/DLZOxjHrP/Flyvq7wyEMdahlB+ya04qsivK3TdQSvRGNrtD394Sz3udSdZUGBFeq5z0K4G227L1Jb7aidTeX3SX6u7O5DVaKSkXvrpGOIeAvJfmrYiDPYtgAaSybEC6tJ2qaYhk+5c8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(40480700001)(2616005)(26005)(36860700001)(8676002)(41300700001)(966005)(4326008)(83380400001)(7416002)(40460700003)(70586007)(82310400005)(70206006)(5660300002)(110136005)(2906002)(8936002)(54906003)(82740400003)(6666004)(36756003)(426003)(336012)(47076005)(7696005)(356005)(478600001)(86362001)(316002)(16526019)(186003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:01:39.3170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d788131-8bbb-444a-dea7-08da716adbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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
    to a per-CPU page state change structure.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

Tom Lendacky (2):
  x86/sev: Use per-CPU PSC structure in prep for unaccepted memory
    support
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                |  1 +
 arch/x86/boot/compressed/mem.c  |  3 ++
 arch/x86/boot/compressed/sev.c  | 10 ++++-
 arch/x86/boot/compressed/sev.h  | 23 ++++++++++
 arch/x86/include/asm/sev.h      |  3 ++
 arch/x86/kernel/sev.c           | 76 ++++++++++++++++++++++++---------
 arch/x86/mm/unaccepted_memory.c |  4 ++
 7 files changed, 98 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.36.1

