Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33C508C39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380276AbiDTPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380251AbiDTPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:36:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F443EF2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbIgZ+nhUZzU7Lds9Wqb5XOy6R40Lc8hiI9k6uAPA9kCD9mCWh3NVHwJyKwHdxNNyLFQT0ytAtr8oh6v9H4Y6e6Oqilgqyddv8Q3HAdnBmjWIl49m5kQEYWHA9ivWMjOPiuQw+qZJAfKUwcshZz+/rMvMz7VoNbTqnT6DKHfBmvJrH4CrNHFFppgFA/sBuoiJSGgPlssDsOrLEP3e1kGkzqB7Cj+5mZrg+1/VurD1W0ZHBy2CAUhhj8EIHrCuRt2VoFqZPsncBRYJpeA6ElpIPXUg/EZt01mQZrBhz5ytlIkbNsDJO7FRyKLZ2Y7xDOMciDTO7De2PR9n2myTH5yew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKEz5qzVomexXsM4QHmg7oAuFlurvZ5RjNCtRaVLD8k=;
 b=MvPtRHGqSAoxZFRnmCiie6DHznucIjuQANTd66vGuy+lMY6rM1n3MMvPf9jT9osY9XtY3dRK6fErBZqK4YKxYK88NcCRZ4zDNKrddN+4PqSzdasVO+Y6eBKiVAFK7jk2T3J62e4f/rgTUoiq1WQt3ta6/fRcuO3PTtsUqsMbUHh8FjHFN/pPYvzDgEOWgIUfcG4PrlxtGAeaL6GmB4qCxLw/+L5hTA2GFdgFFwZR6BEUvNfBBZFAMJysZzZD/cVU1M7FBpceSWoDuPwvt+jrKE2yf85+evN/H+CJ7ix6E8rw9ggOlQL8xv//CjoufYkWJH9yybAQLncsG4DnG1yzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKEz5qzVomexXsM4QHmg7oAuFlurvZ5RjNCtRaVLD8k=;
 b=fj1SuB/kfY1QJ0Nx2oh3Rw8lVWrzZapEuc2OMXUbaPcda1LZ4AVdXFvLHQPpDykMjY+9SUwV6aFVEoYUnneonb8J2SJhymjh6oV8yyhvutxDPnpa0R67N1AGq3hU3UEiof2lKdtIfPayqKyggWhiDjkmP7TBEJfpxpgmiXBVC8A=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by MN2PR12MB3629.namprd12.prod.outlook.com (2603:10b6:208:cb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 15:33:27 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::dd) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 15:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 15:33:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 10:33:26 -0500
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
        Borislav Petkov <bp@suse.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/boot/compressed: use .data for globals that are accessed early
Date:   Wed, 20 Apr 2022 10:26:13 -0500
Message-ID: <20220420152613.145077-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dabba5-aebd-4de5-a780-08da22e31dba
X-MS-TrafficTypeDiagnostic: MN2PR12MB3629:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3629F11497E698CC54C9954195F59@MN2PR12MB3629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +njhVxtDa+d377E9JXv4pgWH+5dnh+8uG18A7WOr/76IjQrFfdXagP/otUiWcSAOceelUlJYy1tU9dg9PhNTNS0idqZohZEDO+t4WYjGsS2YKI9QA50vE7PGeUuhw6XYuhPy3TNv8Gzc3a8tXn5j62kDIWqHBYe9qbkI0/W6n0r6yHqnu35MnoMISOGGMFE9QD4BCX8WeSIkBKEj4B1YYQtghLULUqILo9LStjBPr43hVUriWYtnbfWJpfQxN322gtWQmJdQ/zgOnfUWS23u2A4R12S7pyWuKS8bIzVluRhbYnGUwtAKGrWXwae7doueqcBZrvqF+AkaAHsPWIkoRl9jlCHrYxAHImO64vDqeI1IOmn/Fu9jI81SAZR7ecm4Tmq3v8RMGJqgPp8nKpD0/VajE5A9Uq+xnHLeBz3Z3ovQ2ESEj7hBD56JmOJGbbZPgjAWysXaZ4hZExANbnFUF04r5zmMzKxw465SywYOF2qPfibTJbXLM5DTKa/MXBLxpULGQOn8GXx8eQHAcVZL81KFi2OutpnjP4H8L081mWm7L7JOaI2pQvrr2RD6Svt7x1r+3NLH1LKcpvHGaM005daJ0dvOrJpkDFaMwQwND7ONZ9npneTvcXdbC/hqrSErrLtL1kayFEanL8bIfrckenZ6Xr+X31QV8ztq0vOsSYp/rnZ+qBnTfcLeIlu6CKql0ArcpzqGzM+Kb71Cp0E+FuV8y6QScgTEUTnibcOSBM4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(4326008)(70586007)(36756003)(8676002)(54906003)(44832011)(6916009)(70206006)(6666004)(2906002)(336012)(426003)(26005)(356005)(7416002)(47076005)(2616005)(1076003)(316002)(36860700001)(86362001)(40460700003)(5660300002)(508600001)(83380400001)(8936002)(186003)(81166007)(16526019)(142923001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 15:33:27.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dabba5-aebd-4de5-a780-08da22e31dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helpers in efi.c might be used during early boot to access the EFI
system/config tables, and in some cases these EFI helpers might attempt
to print debug/error messages, before console_init() has been called.
__putstr() checks some variables to avoid printing anything before the
console has been initialized, but this isn't enough since those
variables live in .bss, which may not have been cleared yet. This can
lead to a triple-fault occurring, primarily when booting in legacy/CSM
mode (where EFI helpers will attempt to print some debug messages).

Fix this by declaring these globals in .data section instead so there
is no dependency on BSS being cleared before accessing them.

Fixes: c01fce9cef849 ("x86/compressed: Add SEV-SNP feature detection/setup")
Reported-by: Borislav Petkov <bp@suse.de>
Suggested-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/boot/compressed/early_serial_console.c | 3 ++-
 arch/x86/boot/compressed/misc.c                 | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81fb9582..70a8d1706d0f 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,5 +1,6 @@
 #include "misc.h"
 
-int early_serial_base;
+/* This might be accessed before .bss is cleared, so use .data instead. */
+int early_serial_base __section(".data");
 
 #include "../early_serial_console.c"
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index fa8969fad011..cf690d8712f4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -55,7 +55,10 @@ memptr free_mem_end_ptr;
 
 static char *vidmem;
 static int vidport;
-static int lines, cols;
+
+/* These might be accessed before .bss is cleared, so use .data instead. */
+static int lines __section(".data");
+static int cols __section(".data");
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
-- 
2.25.1

