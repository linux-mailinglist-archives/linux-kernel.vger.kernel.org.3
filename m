Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA95AD2BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiIEMfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiIEMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:34:33 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20115.outbound.protection.outlook.com [40.107.2.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0E61B12
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRpumYC2x+BQroizR9uLAGDQGXmSHcOJsXz8y14lyR4uaNktVCxOCqR21oNiYgigCWGO2fIOrwZEfOd1MwKWcKliSE8Zp6569BL2InIZIHwLebz1vOnTKuc4MuirW7IbTL/QDBvtsNcPIvd/8TeIIQbuQpg/zRJDHgMAtmdNgnscgYrcAuESRK0xp1Tn2YbPDk2tTiDDEDiKTVYvU796Iwg82a+zfmseLYwoTZ/kwIVlY3AHiYxsKuTLfsa/jNr9KEW2yM/C4f/s+Vm4152qca+KZWhp9xW3MmpnMlGLg6ri2ZLaAtwt0+vsdqXmxMP5GwDBBaztSQoDOr0vwuxtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMdyDeV7btMAUHDJfsyyjiGN4a44HHGw7/KNGpxBIWg=;
 b=g6VxykbY9PXN0FQ/1iYTZ8EqSVaYYc+ayKM0AhT0RgDMD1kA4VyI2IUvzyWPoGIg8cehEb+Ssjbw/hqNqjvSQh2SL+WepuJIU2K1oq2Ay/iFpc7kEjyoJNAaBTMSOa5FHcm57Dsb3zRMya+UeUvVW2QK56KC/jzOqgnECMVBecsMRY68LVKuz62BrGtdJKYaLEXA2Vi5qQSVkpJHPE/7BdJOfwKFBPRGH7TNIoDrJgZLFxer0W2qurwDiNwhvCwqgUpMCYxsU7Y2VaJ5tcNqgxkC7dyqkQvyMYKDhtj0Re51uEVxwNQjXnHXcW93hjv2W87UVfTzB9MQj26lxsatWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=linaro.org smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMdyDeV7btMAUHDJfsyyjiGN4a44HHGw7/KNGpxBIWg=;
 b=fJhY8s6jJ7XW9AuwwlMzTh+Svm8eWZwyXQpREPdaSDir2sWwmfFk+DruuZNdodQ4eMd7rtfj/boih2nbdup3AR4k9oXfOG2/ja6VI6WMUyqVQYSg7VWq3+iXzLmdRvCixKdEoWwA34N5CYoXODrCcPkyIwNoGw4E5erlZc9cUIY=
Received: from DB6P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::32) by
 AM9PR07MB7890.eurprd07.prod.outlook.com (2603:10a6:20b:303::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Mon, 5 Sep 2022 12:28:05 +0000
Received: from DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::72) by DB6P193CA0022.outlook.office365.com
 (2603:10a6:6:29::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 5 Sep 2022 12:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT025.mail.protection.outlook.com (100.127.142.226) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 12:28:04 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 285CS0Mi008828;
        Mon, 5 Sep 2022 12:28:00 GMT
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
Date:   Mon,  5 Sep 2022 14:27:54 +0200
Message-Id: <20220905122754.32590-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e57da00e-418c-445f-b00e-08da8f3a1508
X-MS-TrafficTypeDiagnostic: AM9PR07MB7890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PT40EXaVjYj5qqCPbaMvrHmrrCjFmEDyFy5S6putdHWsNdmfIhvQD94ouI3i7Cs+EzqRUGP/snaEimr5hk5Zx0jH9+hpO/fh+7jF7QZKJiHnLi/+Jj7h8FHMlMxZtH40buUnOWza3ntMRZMK72v9xlO3kndRIW5TMqhRELxaFDN1bfbduBVtxKs5pvKI9vVJKajaylqC4q3AB1mHWRbmQAKW5rCTsnL5JXMnSoChf4yWn+1IDrjWMrbYNgXOwyREM68UiUV2h+Ld/dcVnJZqRvErU8OYV8q/LTlT9jkgl6bsKslOJb/3yBGpHJ6bp3pPb0YslIIgPUtFkNCkqjmlV/3XQHIxVdjxEvjA9GCRsWvkKLfWjG7iCmRdUV1NXl5kPQBvbmL436ToeNi/4SALWUz53IRJNrzDnJa+vVqkHmNWVDsI+5AVu0H5YppuJVJ7cBtn1mSyDPZ2FNwRA3iNFsPKfRMWEBJDnuTi8cBLBp5RTRLhCAiOkJ70kI1LQtPc3vDMqlQRR//NAxw0ecN83c3UXRwkH0uYESRMGsmn2rau6j7wP6BBZBEQo7Tnwly7aBSL0wGe4qWQIAi7I6VaMpdPW01Ylf8ZT5QIvHCIth3jh5MBF8rfxY8Mo4pmSL63oz9Gc0fY4bBEwxvQyOV35neNvqgIcjdGAmjlYSQdWqp1d0ftMt63kAOG3rAYrgwr1aeU5SIdvSHHSxKVdL4aZ/b/ECXfvj39+EZCPWdRquE8d3itwlC9l9Zj2KvVkwxXyCIxZVU2K9TE/n8hiuJGGJ+Lxdcp0Bn7s644Dp0fKQGrOQjKlJSTNiopC61vt0om4KqPGGtHldD6JeZwhYVCFXY9Aya48JhqnLqr0iKMpqs=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(8676002)(4326008)(70206006)(82310400005)(316002)(41300700001)(6666004)(45080400002)(6916009)(54906003)(83380400001)(36756003)(86362001)(70586007)(26005)(1076003)(2616005)(336012)(186003)(47076005)(7416002)(2906002)(81166007)(5660300002)(82960400001)(356005)(40480700001)(36860700001)(82740400003)(8936002)(478600001)(40460700003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7890
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---

Changelog:
v2:
* more verbose comment

 arch/arm/mm/kasan_init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 29caee9..46d9f4a 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -268,12 +268,17 @@ void __init kasan_init(void)
 
 	/*
 	 * 1. The module global variables are in MODULES_VADDR ~ MODULES_END,
-	 *    so we need to map this area.
+	 *    so we need to map this area if CONFIG_KASAN_VMALLOC=n. With
+	 *    VMALLOC support KASAN will manage this region dynamically,
+	 *    refer to kasan_populate_vmalloc() and ARM's implementation of
+	 *    module_alloc().
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
2.10.2

