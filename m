Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0351D0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389307AbiEFGFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389296AbiEFGFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:05:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150127.outbound.protection.outlook.com [40.107.15.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C9443C7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9TH530hMOko4y+a3OZixMLL4FSUZTCGFVxsekcbEMpMBv24cmxpAs9+46/Ufve5cme+FAGrvm+6TgGmLHimymN1NelysnQYG/QMEGQYIOUJtmh3/HV/K5qbNaDVo5tTJ7JCKsuEPgvrZt5/pAn1rOHDtzx+3+ZRIy7KPCD1G5nxvYHia/QYfYqC3/ts+3adckH/ytdgQckyzUAHcgtSqZyk2dEAm5uHy9Tzo3LCPmPGoBYhY5YwaYU9bvOdxyRPYX55POv3xkTSrHhGKMcaQm5mMteX1/xAHzSaB9fWumUYsE/BlJEID6NwJTFJ2MM9GFiuS+nk1KFltO9pW2KbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El7Nc3mtKX+LWr3Br1RKEhRC/VMyrNOKCfkT1H7wHB4=;
 b=i3/IQ2t8UADmh/R/TUGJ0uWl8JvzTvFFGOcKj2/FGr3gGFiqFa07y66k+OXg89qzOPb/JZeuEp9XrxPzTKNCS+b/PXdwTX/4nSj8Gs2p6bJ5BssmhVOy/pkAockWmAjd17HOtcEmDrI1PyClHLQypkWrpGvHI7kJZXYcvBs9mRPKORfZWwPVoJrFOiL9b+vgqHdbWv13jD4sHWaHvJ6Jpawzx5SSVyM4gX3pRSOs9FFkow4keEH6prZUztS5sRNbXQK/jVxBL20BhyBmNlatIJem8kE4YdlVJ3izr9DvVAm+CqrljM6uIKg80zolrqvqHIs8FVkN3/ukJOzR5/beTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El7Nc3mtKX+LWr3Br1RKEhRC/VMyrNOKCfkT1H7wHB4=;
 b=yqvyLYXpuZ31Ftm/2IBSSZJX6Fo3TYvjUBToUm8huS7OmAmhIQfHPn7dcmxePA3kveKkgmDz14zydeoCESeC5o01fGXV/xClQP8uKlXpThORMfsCIyk5tPsqJZzMiJP6ObbVDjVWGfL9MHsWrhknWLTF2/c/1VOKT9hzTooYnoc=
Received: from DU2PR04CA0267.eurprd04.prod.outlook.com (2603:10a6:10:28e::32)
 by HE1PR0701MB2345.eurprd07.prod.outlook.com (2603:10a6:3:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 06:01:25 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::74) by DU2PR04CA0267.outlook.office365.com
 (2603:10a6:10:28e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Fri, 6 May 2022 06:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 06:01:24 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 24661GKm018644;
        Fri, 6 May 2022 06:01:16 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     kasan-dev@googlegroups.com
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: kasan: Support CONFIG_KASAN_VMALLOC
Date:   Fri,  6 May 2022 08:01:12 +0200
Message-Id: <20220506060113.14881-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 713b2b9f-6663-482e-3fe7-08da2f25da59
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2345:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0701MB23452F77D62B50C75F5E170F88C59@HE1PR0701MB2345.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCndEZ7kDQgrKM6WQIG7+/l6CITyedr4GCGis7nNQ8mUqgXk/w3rsgHZIDK8y9W/k5x8lxAUD6hxqBTBoCCGXH54oMSwNaMqL34N7j5O1Rl61yNtNjc75TDeX/H4by/O8ozeuPwmBJ/6QD6rIDDdsXCcfnx1r4UHCxzk3PVpGHw4H0PVu9JcMp4xdeFGUxl4HOlX8SjBGsND2sQUZOAihsELFWps1Ssqx2nTW8CIuSF2LOEwuautBHVbkpi5aFgI3hGygrtQYomL6cBPnJO9LzG1gXb85xWGMKUyfW/PjjzIq2dJmDCNbbx6Mwj4s3LkUC3lhtogAULkjz+yRytCBgjfMmQFt9SVc1ELeg8dmGtmoY1DHZzLTRdRx25bsUOfVUK6QjbudDtQn44QNweiru2MpF6BTyebu0NSL48vOmW6Lp1CDEI41l5VzdrtWvSM2IQId38BhVzleNXMnpVGANg7ZH3OkMfvaB7yVrPTkhPFErJ2/5j3m5QaWv+YBpP7qLY6lyqOGwbjWCkEZg5Mko8c/5YRqiBkDyRsYAgqzdRpb8bHTaOnsTEbvIhvbCw3RzhTvKqRFTdnsNg3YxGZadBMIESPPXPo6LKid4KPVnAvmGTHhiKmvFZr9wLoUlh3q2zlWv0h0PyDeDLkSekNuZvxSHZOBv4IAkvRo+nXYWH7CBXpIi2oqqKivL7O6vEoPt07OzfC79LERn5/Lc5u9PvESeol36M8NS1i+A8j/3B9eQlLnyHWPNPTyIQYcR15
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(26005)(82960400001)(81166007)(36860700001)(47076005)(336012)(83380400001)(2906002)(508600001)(40460700003)(5660300002)(86362001)(8936002)(186003)(316002)(2616005)(6666004)(356005)(82310400005)(70206006)(70586007)(8676002)(4326008)(6916009)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 06:01:24.8986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713b2b9f-6663-482e-3fe7-08da2f25da59
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2345
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Create KASAN mapping between VMALLOC_START and VMALLOC_END instead of
early shadow if KASAN_VMALLOC is configured.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/Kconfig         | 1 +
 arch/arm/mm/kasan_init.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e..f440cf5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -75,6 +75,7 @@ config ARM
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 5ad0d6c5..c2f49f7 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -236,7 +236,12 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		create_mapping((void *)VMALLOC_START, (void *)VMALLOC_END);
+	else
+		kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
+					    kasan_mem_to_shadow((void *)VMALLOC_END));
+	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_END),
 				    kasan_mem_to_shadow((void *)-1UL) + 1);
 
 	for_each_mem_range(i, &pa_start, &pa_end) {
-- 
2.10.2

