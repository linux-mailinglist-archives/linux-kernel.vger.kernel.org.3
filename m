Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727185A3A18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 23:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiH0Vaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH0Va2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 17:30:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140109.outbound.protection.outlook.com [40.107.14.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E45721F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 14:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVtXWPFGPaNKqJztl6Su8HFX4ye7Yi0MCfpBpIIUe5k8axa2uWs1yL5JVsnmmvWeVHR//E1RswO5FAV1b27D30LN0UA0fIh/ox6cFKBmasLYtPACfC/yLDCvsSso523Gv48f0O3Z/ZyZnKLgoQkCbnNOuIJ0AIovIapQ9+TNd8I30s/pVZLkDAWrH1XvXMvyVbRz7XjDsoMg1Cujj8E6xXcx4rZhUl+mrLwJftmNuchNLlQtfgJrHx+l9IHAs8f/H92PWdYvqOHS63cHAXm5FRI2PtQvyX0cMCBQ3vFLu8qYam/vP3/lMOMMQKyICXIPqvprccIpFHGZq2oSgdA9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGMuUvhSvZXy/S8vAKI2Tadnp4vXnJRLcr1jsXKOf6A=;
 b=NOC2e0LNlISMG4VnshmmoxGQpNe7M3AAegz3VFRKq0KBwPOjnwQuon3ntkczlzlE51MvQYkC2nE4NRjJ7KTbtDDVylRltmIKmqa24pjKjXauStmvBcO3nGIcYGlb5tQ4I4cV4WwX0JwxTmeWmC9Tt0+ThChcJNmbo4BujzC/hqTj9e18yrfcnFgMXwepkFHUyR0CrEKsA6zGXZxFP8viDjYTkjfej7m8ZPcD8ge7HJ6rVTOrOSC/spQNEB85lrgTPy5YaAXNNxKxVlFY3FM3l/ABLHNdadSvz0o5enNwh4gM2TZmSZFJg6nR+qBjXfZ8oKSkoUqrMEOVJA9OS79s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGMuUvhSvZXy/S8vAKI2Tadnp4vXnJRLcr1jsXKOf6A=;
 b=T40zAiOB2z8Z5h7QthA5SfVEktgStA3laJAJmfVjTkX9e/o5x/UiCUlIuPiVEuQnd6N3rKvFkj4iK1h2QOCMw97w2AKRKZ6IC7/uPY5vgnQKe7uoi2knVheJJL4/Lg4Ts+58GQwIoNVWWEhOWhCpwS2cnxUv80fDyLMfTuHPkXI=
Received: from AM5PR1001CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::21) by HE1PR0701MB2570.eurprd07.prod.outlook.com
 (2603:10a6:3:96::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.7; Sat, 27 Aug
 2022 21:30:23 +0000
Received: from AM7EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::f4) by AM5PR1001CA0044.outlook.office365.com
 (2603:10a6:206:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 21:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM7EUR03FT038.mail.protection.outlook.com (100.127.140.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 21:30:23 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 27RLUHQc017485;
        Sat, 27 Aug 2022 21:30:17 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     kasan-dev@googlegroups.com
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
Date:   Sat, 27 Aug 2022 23:30:09 +0200
Message-Id: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da3dcd54-f34a-4876-bc5d-08da887359bb
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2570:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcJepoL4qGlxn0XxEwVyt/uDEhisBp5N6qDF7IWb1yaLIjMbsYMGjuL7SEdcw/fKa/i4lOOoAFDEfLTbmZMhM59yJYrOEQZyogRCtAeuF/HinbVi/8TZogc+3s7tDHE7d69ZB4BD/fp1xUzzozwo3P35qfDYhJSiYbDfm09+LyNl0hnFb/6lloJS3ldqUgQ/vUsyDBUuEZ6dMekEScDCfAkMmcwo5yUIWoL8vPnVpgwLsiTvb/cVz3N0SQPBOmxgJk8bRyphYAX09XKc0OEZw54n+kqewOnOd2rmDgyfFPfD0YOJwg8WuV/nN+QQW7weeuF/lfIsAVYNShGW3EWbnsMB8ifbq7FVjzhpXFwioAU0SOKH8RGgcrNioL450zfbxy/EcSv1pWNZMKumn+YiVZPVHe/CS++QeaAG0Vc4udTXj0s8mN36O7Fn4mNxDNxYd0onihYQHsvz+fY3gy9UBKQzbsvGYn2npFumRg8r1iYyRxnCTFUAJV9qJeIPWEqiup+piGMRr9PNKQKNWf/IfGoPy86DF1CzaRLR94C8ZDaPMsjgdxIaFP0S8g8nejeaY40hPU4ERv2CXmM1xhfGz+qpNRRwHaRWvCEFAG+jzaG4l2UE5thklDL6zHrXUAWiimvkpJyeOhtmnL3FJHKM1W5tPDNvJWMVVpltX3xghyvQuFGugQDompS1jQ4z4lNDxlqoR/28I9cZKWMY4r5gfBmGsweUrdQTz8evicZ0SR+iXDRhos2fcMKG75GCh9GhlymhPMRw92d9BG4dzWlr8+0Zl2uPPHZVIEqwR40ZS6HNE3iXBfw1aaMXqJE+tJBOMd00gGZyGtCNKLsueaq85I6N/Yo5kqf9WocBXL5gM/A=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(40470700004)(6916009)(6666004)(41300700001)(54906003)(316002)(82310400005)(478600001)(45080400002)(86362001)(26005)(82740400003)(36860700001)(40460700003)(82960400001)(356005)(2616005)(1076003)(83380400001)(336012)(186003)(81166007)(47076005)(36756003)(7416002)(40480700001)(2906002)(8936002)(4326008)(5660300002)(8676002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 21:30:23.3813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3dcd54-f34a-4876-bc5d-08da887359bb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2570
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

In case CONFIG_KASAN_VMALLOC=y kasan_populate_vmalloc() allocates the
shadow pages dynamically. But even worse is that kasan_release_vmalloc()
releases them, which is not compatible with create_mapping() of
MODULES_VADDR..MODULES_END range:

BUG: Bad page state in process kworker/9:1  pfn:2068b
page:e5e06160 refcount:0 mapcount:0 mapping:00000000 index:0x0
flags: 0x1000(reserved)
raw: 00001000 e5e06164 e5e06164 00000000 00000000 00000000 ffffffff 00000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
bad because of flags: 0x1000(reserved)
Modules linked in: ip_tables
CPU: 9 PID: 154 Comm: kworker/9:1 Not tainted 5.4.188-... #1
Hardware name: LSI Axxia AXM55XX
Workqueue: events do_free_init
unwind_backtrace
show_stack
dump_stack
bad_page
free_pcp_prepare
free_unref_page
kasan_depopulate_vmalloc_pte
__apply_to_page_range
apply_to_existing_page_range
kasan_release_vmalloc
__purge_vmap_area_lazy
_vm_unmap_aliases.part.0
__vunmap
do_free_init
process_one_work
worker_thread
kthread

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/mm/kasan_init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 29caee9c79ce3..64790661bdc40 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -268,12 +268,14 @@ void __init kasan_init(void)
 
 	/*
 	 * 1. The module global variables are in MODULES_VADDR ~ MODULES_END,
-	 *    so we need to map this area.
+	 *    so we need to map this area if CONFIG_KASAN_VMALLOC=n.
 	 * 2. PKMAP_BASE ~ PKMAP_BASE+PMD_SIZE's shadow and MODULES_VADDR
 	 *    ~ MODULES_END's shadow is in the same PMD_SIZE, so we can't
 	 *    use kasan_populate_zero_shadow.
 	 */
-	create_mapping((void *)MODULES_VADDR, (void *)(PKMAP_BASE + PMD_SIZE));
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) && IS_ENABLED(CONFIG_MODULES))
+		create_mapping((void *)MODULES_VADDR, (void *)(MODULES_END));
+	create_mapping((void *)PKMAP_BASE, (void *)(PKMAP_BASE + PMD_SIZE));
 
 	/*
 	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so
-- 
2.35.1

