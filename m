Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEC508A97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379529AbiDTOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380252AbiDTOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4EDB4;
        Wed, 20 Apr 2022 07:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBXhOuM47b3Ie5NeP7EeT/HNUdoNa+HHUv+ikpTf+0aJdTd7zS/kCs4N12CwTJ8b/22cFv/fjzmZLVbbEP/ilgAhP4hhA1blh3MFxopgH3Fce6rRb1XiDWls/QRIXciojuxqzF9OAYe5/qo5ZM2SuQcP1J2utm+DrIir+n2Gtn0Vo3nNKLOuAWi4pkRk/woOX658tiXzknPQnzC1WXivj28SxnzZSPiZKoVgAQuBCwhx84AJu2VyP7fc5h5CIf3RPbHLThrIV43OvBLxBNUBni6VrRipSB7Uvy3/1rj+nneS86INjz/WCopmGlG4m+8+F76D5V4yYIiFSS1/MUfEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlpTV/C2TZA+0yj/o2zRXgzvJb3qPuvmtE6rg/xHU3w=;
 b=fb+CYyQt8YLlCPc0DjEkeqy+houIVWXuyJZNxSkCCQlfOyqOZ6Bn4zV5JlP0L8Fv+jYWMqIGkhn7XJnYa4keg5ynJ6abQvjM+2UOcxfKlvxPgG9Rc3FPQTd5+Nr7Pb3IRrakIyq0hO5UUQJ4lUDo3iBfcRswc+xe84uCvW+MtCLasgJnXdjtZUJX/X6S0iShvVnjH38dlVxEH1Yud92EJ3DiZhgYUboL6rbU5dzXK53NdFLL+6BeyEb9iF638Ngqls8cXFEoAzjtcgkWiX1vyO9ooaqvTGxbdPBSPkeDLoavzOM4kkQQ1wywlsnoh57Q+nNLgBBOTSTLg5h7qTMFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlpTV/C2TZA+0yj/o2zRXgzvJb3qPuvmtE6rg/xHU3w=;
 b=g6jP405DdHp2Q3G9XveHfbI1ixrZIKznDyqzCaVJ/VqwdPF10/dSJE2W5pUEFkw3TfF0jzBCBHC3OHs/eLgvaZB1gtGKOHQy+ntmWmtgAyEP4eXWgHHmHPVbrzPtvqVduSZKARcVpugYL8lmR8KvW/SYTo4bAKt1IWbTaeMUd10=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 14:14:42 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::5a) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 14:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 14:14:42 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 09:14:40 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <jroedel@suse.de>,
        "Michael Roth" <michael.roth@amd.com>
Subject: [PATCH 2/2] virt: sevguest: Rename the sevguest dir and files to sev-guest
Date:   Wed, 20 Apr 2022 09:14:14 -0500
Message-ID: <2f5c9cb16e3a67599c8e3170f6c72c8712c47d53.1650464054.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650464054.git.thomas.lendacky@amd.com>
References: <cover.1650464054.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb62f22-10b8-49a3-dfa8-08da22d81d23
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578FD34F84C323714AC877AECF59@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q38JNYSxW8odmSZJTVMVbYYiYDe2KfwQqDS2+jWZu748/eG5NH9oLM7ugC9N47DnS5dNWnUhU0LoViQu3gLdQD6dQ3r/HC2Rc6c5eKtGfUwo+PCzu6tZOquizi/p3wAtmBqWM/OI6bcOyPNwrC+XALSkL0JznASrv8GvaWf6hn+Q5kM85j9fMA2jy969+TVl4H8Iip3FJuoBFYdAOPtvc7LeLMWgoUzKFS6rfNykB3pIN+rB7AtHWFwAB4e/sBdFlCgiUrlGd50Z+ineZ7/qYreCqlqeW9d5IXhYRUElPVdXMsH3pCRstBHNz9IgfkoLamV73KuzUpvXCB2JFMUKo/RpgQyjWeQxJoXtrWG/poRpOlUFzDLUI/4h7yEnfCXNE0eD8qv61CaUfX5k/Q4P8963jWrfDPFYVvOPAkziwNuSMHFBA725k0jFFiuR1gMaxJYUir39d5jRKewN3Adujzm39Gq9yp//GoQgGmuCY6kITtG/k0jORs+YTheyMkIerkuMBVfU000GnRlzstJk5qQRZhaGqeuM6yzkmhYOp7NXuVOtVIoyt1sDB6EDQ/9j/gNs54P0TKfkXneH4ciHdFD4uSBo9k0KyVPCjYLjVu28wwVaw+GhiDGW16lZqhofsUzDrxEU68iKxOLZG+B4rXpGI8V3s/9B/84h8M6wU3YD0WLQX0+GdHtgsKNrMVX7W2Iyev7Zg6ZfgNPO/kd1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(8676002)(36860700001)(54906003)(26005)(186003)(316002)(356005)(16526019)(110136005)(5660300002)(82310400005)(81166007)(83380400001)(70206006)(508600001)(2906002)(6666004)(336012)(47076005)(4326008)(70586007)(7696005)(8936002)(2616005)(40460700003)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 14:14:42.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb62f22-10b8-49a3-dfa8-08da22d81d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the drivers/virt/coco/sevguest directory and files to sev-guest
so as to match the driver name.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/virt/index.rst                              | 2 +-
 drivers/virt/Kconfig                                      | 2 +-
 drivers/virt/Makefile                                     | 2 +-
 drivers/virt/coco/{sevguest => sev-guest}/Kconfig         | 2 +-
 drivers/virt/coco/{sevguest => sev-guest}/Makefile        | 2 +-
 .../coco/{sevguest/sevguest.c => sev-guest/sev-guest.c}   | 8 ++++----
 .../coco/{sevguest/sevguest.h => sev-guest/sev-guest.h}   | 0
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/virt/coco/{sevguest => sev-guest}/Kconfig (87%)
 rename drivers/virt/coco/{sevguest => sev-guest}/Makefile (50%)
 rename drivers/virt/coco/{sevguest/sevguest.c => sev-guest/sev-guest.c} (98%)
 rename drivers/virt/coco/{sevguest/sevguest.h => sev-guest/sev-guest.h} (100%)

diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 40ad0d20032e..492f0920b988 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -13,7 +13,7 @@ Linux Virtualization Support
    guest-halt-polling
    ne_overview
    acrn/index
-   coco/sevguest
+   coco/sev-guest
 
 .. only:: html and subproject
 
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 7d3273cfab27..0c1bba7c5c66 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -48,6 +48,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
-source "drivers/virt/coco/sevguest/Kconfig"
+source "drivers/virt/coco/sev-guest/Kconfig"
 
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 7b87a7ba1972..b2e6e864ebbe 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -9,4 +9,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
-obj-$(CONFIG_SEV_GUEST)		+= coco/sevguest/
+obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
similarity index 87%
rename from drivers/virt/coco/sevguest/Kconfig
rename to drivers/virt/coco/sev-guest/Kconfig
index 74ca1fe09437..f9db0799ae67 100644
--- a/drivers/virt/coco/sevguest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -11,4 +11,4 @@ config SEV_GUEST
 	  userspace interface to communicate with the PSP to request the
 	  attestation report and more.
 
-	  If you choose 'M' here, this module will be called sevguest.
+	  If you choose 'M' here, this module will be called sev-guest.
diff --git a/drivers/virt/coco/sevguest/Makefile b/drivers/virt/coco/sev-guest/Makefile
similarity index 50%
rename from drivers/virt/coco/sevguest/Makefile
rename to drivers/virt/coco/sev-guest/Makefile
index b1ffb2b4177b..63d67c27723a 100644
--- a/drivers/virt/coco/sevguest/Makefile
+++ b/drivers/virt/coco/sev-guest/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SEV_GUEST) += sevguest.o
+obj-$(CONFIG_SEV_GUEST) += sev-guest.o
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sev-guest/sev-guest.c
similarity index 98%
rename from drivers/virt/coco/sevguest/sevguest.c
rename to drivers/virt/coco/sev-guest/sev-guest.c
index f3b93bd92f2f..1fd4a0583e09 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -25,7 +25,7 @@
 #include <asm/svm.h>
 #include <asm/sev.h>
 
-#include "sevguest.h"
+#include "sev-guest.h"
 
 #define DEVICE_NAME	"sev-guest"
 #define AAD_LEN		48
@@ -724,9 +724,9 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
 }
 
 /*
- * This driver is a common SEV guest interface driver and meant to support
- * any SEV guest API. As such, even though it has been introduced along with
- * the SEV-SNP support, it is named "sev-guest".
+ * This driver is meant to be a common SEV guest interface driver and to
+ * support any SEV guest API. As such, even though it has been introduced
+ * with the SEV-SNP support, it is named "sev-guest".
  */
 static struct platform_driver sev_guest_driver = {
 	.remove		= __exit_p(sev_guest_remove),
diff --git a/drivers/virt/coco/sevguest/sevguest.h b/drivers/virt/coco/sev-guest/sev-guest.h
similarity index 100%
rename from drivers/virt/coco/sevguest/sevguest.h
rename to drivers/virt/coco/sev-guest/sev-guest.h
-- 
2.34.1

