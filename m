Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123C51D0F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389297AbiEFGFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347760AbiEFGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:05:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568F9443C7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G61DInEOv2eEeuxmvw7aZas/y97RtQjE10UCQLLn9DTuJEWTEpBWfjfGV2JQRvyXpfswUg6zdYfRZ3bAFwjJQkiN86JxEnynOqGjJL3QhVR6mrb3zXg185F73fyO7souUPabsmASpWQ1+1ERcF0CJIqGr9dqbJIcyMFQYg6XZGY3qcmrrB/jFYmig+TSaqdUjTZ27Vcby83HNqImg4np8cs+n8akIk42hoGUJaTaHwjFCV97qnuk4tBonEZ4dDJICcOdohr3qfnYGVIjdV4wEsgeeQTI5KxLXfC+azSTFBAMp+5RDS+3CU1YoZtKZmvOJLyrGqk2fN4oYG1p6cOPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbriUybfpReIgm3SoMDo3ayAPM+zbPmOVTAUaWJ5WJk=;
 b=n15VzyxqNzf+y3K/zv682Q/yvhNVM7SicMkT7QiGcvF4hGHcHoo89pS8x9HP473oQYbv80VgXYJBSQ0r6RG43WqdDFMaoI5zf8CSqH/V9fFDINaxSeP9T21ixdC27fbmKIpzArFQrAy5GqCNn5bcQDHJBwATxEIZXB0tUd+BFgAnfgDjjAn0w8ogszMpDJiRW0lVtS4W5731nqlJtnsSpMW/QJL7ETrQ9pXCc6ZgHGJ7UMi6zfVigRFfHviS3UD5JJcwzkhO8jMGYAEStUT8L2ZpFP/u5WxVFxkPnizFK5ILT10VBAwoKD4vKmxV3YqE60oBGlKoule6rCWMGCDQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbriUybfpReIgm3SoMDo3ayAPM+zbPmOVTAUaWJ5WJk=;
 b=MOhkFsuNNzSZsgtIcdoAXPO1tAiyHuOgi+VCL/4FnwDw4LOEPJbv10smH17rP44r4yooNUCwvnqqa5llLa8eidZGp+AQucofMEWPrTSDm6CZtGahT/U798E6QPB1C1HNHIAPKLEqjh7F6ED3dRL4nK9zEw2AJ8aCbEpIJIM19yQ=
Received: from DB7PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:10:36::21)
 by AM0PR07MB4449.eurprd07.prod.outlook.com (2603:10a6:208:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 06:01:20 +0000
Received: from DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::4) by DB7PR05CA0008.outlook.office365.com
 (2603:10a6:10:36::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Fri, 6 May 2022 06:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT036.mail.protection.outlook.com (100.127.142.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 06:01:20 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 24661GKn018644;
        Fri, 6 May 2022 06:01:17 GMT
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
Subject: [PATCH 2/2] ARM: kasan: Fix compatibility with ARM_MODULE_PLTS
Date:   Fri,  6 May 2022 08:01:13 +0200
Message-Id: <20220506060113.14881-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20220506060113.14881-1-alexander.sverdlin@nokia.com>
References: <20220506060113.14881-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7de4f0e2-98d3-4c56-72bd-08da2f25d779
X-MS-TrafficTypeDiagnostic: AM0PR07MB4449:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB444962B664766BF74F13758788C59@AM0PR07MB4449.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2DYiuXfkYQpAtZoe76SBLfw9+dFnXW61J7q6fc2o7a4KT+9LVexjiC7V+1SOH+6SPAE1uImu0mFQvqyM6Y0wuZ7KRi7pVg0u/6B0FmmNbk3WdB3bYSmaeepoRjmGhEoBNAAKpfLiggXa6Ic4DxEgaDhXH9fSNxiv4s1t8E//vk14ZHYnwBxXISjgNSMgbSTBXvLPblDHQECtgnJvqNVyj7O6wZOKmkX/GtffsubKM057n6QtuRY5Gb8bXHHZ8G5iI3vLVgYZ1uxCP1T5UEnwUNQXkB1Iq/lHFBEMpN//4KVlxnysAOPLgUT4plCNhV4OfEpRhc80lnt3plRpHJRr8K5lbVwuq47uTbizE+n7huLAP9YFNRrdb+EO5htPIOXMtbnn4OoLBa7+fXL4+aMAfWH/r5vht+mYo/alvygO5ACqJjRt3hzdqBUXEW8MfqVvrkVArBeiYIvZ2FpyKa+HCF8cHu8T1XIeZ5SKGSxEyS6TVo62YWnKQLulAhQ7Q1JoPrNLbqZHAbke4VT3mEnYQ45uw3ZPJHA8OUftIf5yx/a7eBV8WVAguhC0ajFGSKRWbCmSRpr9I9oRKZdCj1dejvp+BTf5E2uJdCtlYq4PtufK34ulBQ6YNiPWe3lpoUyaLN48aN21Crt5r0IbDKxTUyzHcAPvT5oyf2j/oAoEOvt16INL70PRgSi/ajPqeDVlUOJK9OVMYOnUsuVAzF5fQ0kI8JZ3/P1ouebn5U49lNql/zyMl3p570KkSskDwfiE5pKH3WmCWpuhPjlRjUAzw==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(47076005)(2906002)(40460700003)(6666004)(336012)(82310400005)(70586007)(8676002)(4326008)(70206006)(356005)(8936002)(508600001)(36756003)(82960400001)(81166007)(316002)(6916009)(54906003)(1076003)(2616005)(186003)(5660300002)(26005)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 06:01:20.0765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de4f0e2-98d3-4c56-72bd-08da2f25d779
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4449
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

Select KASAN_VMALLOC if KASAN && ARM_MODULE_PLT. Otherwise module load into
vmalloc area crashes the kernel:

Unable to handle kernel paging request at virtual address bce42b5c
CPU: 1 PID: 454 Comm: systemd-udevd
PC is at mmioset+0x7e/0xa0
LR is at kasan_unpoison_shadow+0x1b/0x24
Stack:
(mmioset) from (kasan_unpoison_shadow+0x1b/0x24)
(kasan_unpoison_shadow) from (__asan_register_globals+0x27/0x4c)
(__asan_register_globals) from (do_init_module+0x13d/0x5b8)
(do_init_module) from (load_module+0x6733/0x80f8)
(load_module) from (sys_finit_module+0x119/0x140)
(sys_finit_module) from (ret_fast_syscall+0x1/0x5a)

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f440cf5..d9d60a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1519,6 +1519,7 @@ config HW_PERF_EVENTS
 config ARM_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
+	select KASAN_VMALLOC if KASAN
 	default y
 	help
 	  Allocate PLTs when loading modules so that jumps and calls whose
-- 
2.10.2

