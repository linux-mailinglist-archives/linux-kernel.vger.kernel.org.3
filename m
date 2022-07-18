Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231B4577E21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiGRI6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiGRI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:58:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1653EE15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBPlsVJUR5y4iIe1zmqawbKYVxoqDKVRPudtJev2IVv+QqpIZ3yY04wKlOXHqBZnsFUZEd2B/y0cHF/WXJ5YfwtNYCAIjxzQEG2tNW81mzfncwAtrEkzi+4asWCnG3OC1T6Q+DE9yfR+I1cplSGGM6+ttNqhJ7FEEiBKKEV/ZREDPmiZ8L1gznIGXrT0ZSd3admTUb7f6gqf+eZUtBMJ660rvj06VisAlvFcXBKRxRifLpUUKRt9QlYo9w8+EDgHcsrrqNWMq2Aul2y5BQoIKS9Nokcl7TsLPzRiy4eV4wUfHu3pPNOQGmwDdeEidhAHZKfGUe2tMf+3Kle9xKtFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++fC2X7REOPXbO0hv5m5QDCO5nssMa6QjuYykwTNmWk=;
 b=HhYvV/qmw4hnHdjt9tm54lqGeeN6byF9aeh15sgSox/DENH9/u+fZj047VVsc/9tRvhH8M8f5p5EDtFK2NAXfFNyR8lOEtc7630WN8FazTP8Psy7aYpSh04Tzw5NZshUcwxEmp/TtxDVbwZe3Xqqv6F+ZiFdHlBVlXoZdK+8ni94BnP0ApqUmdEH+bd69UnsxWXvPdvvpJY2D7cBeKIGNypnJuMzZ4sqXPszuwJgJ9JUD8mNF36i3aRh/pmlQtMJTv3UFd0+i5uTeFS87r/3dept8U9NX9fhKJoRuayVG07LqaJ8mjhYKkxXuYSsaeTFC97b7jImSP3kVpBoR5qneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++fC2X7REOPXbO0hv5m5QDCO5nssMa6QjuYykwTNmWk=;
 b=nG1iYIujV+NVrKE7Ugn+fOYfFoFoF6IqkTMdWfWWDuVRGD+KW1ylN2I3orP3H64hBP9kOf3mJLRH7ClIkaiYFAJStwpFUstyP8cgHYzQfyi4ZBQVaw+vYKBZ94i3puMZZGFyTyQqQ5R1amfzVtKcioSJfDyl/TFs2UDzsi10zDI=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by BYAPR12MB2824.namprd12.prod.outlook.com (2603:10b6:a03:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 08:58:30 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::2) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 18 Jul 2022 08:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 08:58:29 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 03:58:24 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <nikunj@amd.com>, <Abraham.Shaju@amd.com>
Subject: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource reservation fails
Date:   Mon, 18 Jul 2022 14:28:15 +0530
Message-ID: <20220718085815.1943-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c30ad9fe-3724-4660-8b1e-08da689baf5b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2824:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjnvkToAfaksl1DKCiY1nR3wX8u9PNGtPtXFSoN041Z2eOCfYrjHr2YNpVNmuLpIHUg2uN1p1V9/lGRXG8vw9zHlgBphb7sNL4rvAJFnre63zklx/0w+VwNWXH4wGjc2KBvrbIZ0OgXaRy6NBqcspcdl4tEQDpZjbMhmOsGU11YZn/Ql98+VNOSBdx1V/nNPGLAsdX9kbamwCw3MVcq+XwyBaSYLNLZcoM5ukc+TQmSN27WWea/TdtchPgY6GA0dnsW2yfxZBc2Ci4xVqKdXwG8ezYniwLBO3hBdo08JgmH4DrFSHlp/cdaO9jKnSQiQvDVnEodZ0darQeekATwZDYs2UMszEO9lWoCYmbiCapHS2gLJ9gbejL45sp3Wk/qf1/DF2sU7OjRaWxxZsZCLF9ADGrYNGLdx5wtVkDBloGFUG/FUoLcLn1TsDXfHRMxagaP21F9x+mBOY3p2c+dfX8zpBHJk3VVZYLMTIg63Dncz2r4ZFKuJmQ6v3Y0mUUODtrmxpinnkZ82Kx5FTyaOfcDKp8h7lmWh57e/rgHuPM63jX9Z+ST+GV4HS7CJIc1hFjkX3UBOPlYFMcx//nL6eJEXLVRYK8G6zzs2aAGRXtiqxR8FIsBrlUnSJivGA4JiI4V/rzw/keCUBylowXRdWBgrvCY/bu6EtnYhjOh0HJW+xkAK8/KdLwfMvzTEHErK6fnNg3yUgMYh/Xdepg1WfvMjIot37iMncb0APyA5YzAmAxgK/+n8XlsSDw2ygrfLMcjqpUl1smBN9jMVbtMMHaXxudlGDlmaZ+0xlWPk3ceWCWEcDiqj5xTCtjrSIjYOBXVTwp+gPabA3ldOAp4ifxGR3bLIsF7tciY5SfHvtT6Jfr04wg3/TP8d430vrIJB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(40470700004)(36840700001)(46966006)(8936002)(86362001)(4326008)(70206006)(70586007)(8676002)(36756003)(81166007)(6916009)(54906003)(356005)(40460700003)(7696005)(82740400003)(316002)(26005)(83380400001)(41300700001)(6666004)(2616005)(1076003)(186003)(36860700001)(478600001)(16526019)(426003)(82310400005)(336012)(40480700001)(47076005)(5660300002)(966005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 08:58:29.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30ad9fe-3724-4660-8b1e-08da689baf5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is possible to start a guest with memory that
is beyond the addressable range of CPU. This can typically
be done by using QEMU without explicilty specifying the max
physical addressable bits (via phys-bits or host-phys-bits
options). In such cases QEMU will start the guest with more
than 1TB memory but would implicitly limit the phys-bits to 40.

In this scenario, iomem_resource.end gets set to 1TB and
hence subsequent resource reservations of RAM regions beyond
1TB would fail. Since this failure is ignored, there can be
a situation where kernel is using the entire RAM (beyond 1T),
but the RAM range is not part of iomem resource tree.

This can lead to both performance as well as correctness
issues. For example, gettimeofday() calls will take more
time as the vvar_page gets mapped as uncacheable memory
type (_PAGE_CACHE_MODE_UC_MINUS). The vvar fault handler
will default to uncacheable type when it fails to find the
vvar_page pfn as part of any RAM range in iomem_resource.
Here is a comparision of the time taken (in us) by an
application doing lots (10240) of gettimeofday() calls, to
complete in case of 999G and 1T guest RAM:

Iteration	999G	1T
----------------------------
1		291	1178
2		316	3286
3		582	2982
4		284	1808
5		252	4503

This is how /proc/iomem looks like for the above two cases:

999G guest RAM
---------------
00001000-0009fbff : System RAM
00100000-bffdbfff : System RAM
100000000-f9ffffffff : System RAM
  1549c00000-154fe09107 : Kernel code
  1550000000-1552f3cfff : Kernel rodata
  1553000000-15544aea3f : Kernel data
  1554d67000-15553fffff : Kernel bss

1T guest RAM
------------
00001000-0009fbff : System RAM
00100000-bffdbfff : System RAM
6752200000-6758409107 : Kernel code
6758600000-675b53cfff : Kernel rodata
675b600000-675caaea3f : Kernel data
675d367000-675d9fffff : Kernel bss
(Last System RAM entry is missing)

It is also seen that any memory region reservation requests
(say by using request_free_mem_region()), whose sizes fall
below 1TB, will be satisfied, leading to ranges overlapping
with actual RAM range (though the RAM range is missing in the
resource tree).

Fix this problem by stopping the kernel boot when resource
reservation fails for system RAM.

Reported-by: Shaju Abraham <Abraham.Shaju@amd.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
1. It appears that we should fail for other types of
resources too and not just for RAM, but wasn't sure
and hence checking for RAM explicitly in this version.
2. There is an attempt to fix this on the QEMU side too
https://lore.kernel.org/qemu-devel/20220718081734.135598-1-nikunj@amd.com/

 arch/x86/kernel/e820.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..1cfe640afe71 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1185,7 +1185,10 @@ void __init e820__reserve_resources(void)
 		 */
 		if (do_mark_busy(entry->type, res)) {
 			res->flags |= IORESOURCE_BUSY;
-			insert_resource(&iomem_resource, res);
+			if (insert_resource(&iomem_resource, res) &&
+			    entry->type == E820_TYPE_RAM)
+				panic("%s: Failed to reserve resource %s with range (%llx-%llx)\n",
+				      __func__, res->name, res->start, res->end);
 		}
 		res++;
 	}
-- 
2.25.1

