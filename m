Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAC57FC31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiGYJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiGYJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:17:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADBE002;
        Mon, 25 Jul 2022 02:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD6BTdtOoq5SGANOEUHfvZSGZxBUwfxkfE9+pF3betIP5rO+HJysXJRE+MAQbVs5koy5nJWJVIlX3+xsdKkU7mJ87sLsc3uYQ17nuglG/hcco8mr5Q2gID9rA7HyI/A0L6AZ6VXv6uB0Lrf9FwCbKTwJtPYtX26U3rO/BjzmR0MR460Scb2d8aQquvyWcFVzILIFAyUjCuBiQPINs0J8YiSiUcaXYSFKVqb55fgIqGuKmZcyBx4I0kRgxale34IQM5Eo1enyUukfO+3iG8GLU3TscnZYfA410bvaF19iScTpslT2DXihYL5ugLx9BoTWBmXO/ZG+AAU0DAD5cj/KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFTt3CbnfvKcnY0eC6pl+94xZZBDJo3kacY0jDnLwCU=;
 b=I00g+oTYTO1wS07tsrPZU2lS2wU01orcY6XQJlKJvd7/CtDaiyfnFOLl3dVnmD9igWiOw/lBr9D3iQHHPodKTpPMv/T8LUR1TGi5EJPoJ7rW2A9p6UzIZpdUFtAaLe3WrVlbrisQ3z43is0HSWvCkGkfQ+Uo65lP1X7HTSrCfMUUvNM7aXMEPRf2Eyx673zxpcT+skULjJ+C44rf/tson/nNPvwVZ4gOoBeCjMnZkHf8W2F6N1vVSHJC1ljsUzCEiPfIqU1rVE59Who+bfYk/m/D522gDvWuLKWAtJVxkfY25LLgzVgFN8Do/lJCZ13ypvLaDAYxToRo2W15U+exqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFTt3CbnfvKcnY0eC6pl+94xZZBDJo3kacY0jDnLwCU=;
 b=iZIfe1b7UG+AYDm7JOZIX36swW8kgGHy5TYQ5uv/e0RO3x/U3ooAnHywUl4rJ1cswMDq6CAj+jiQUkg8bcdHFCxEylarCMtfpMs1QXwjLdg3N10JtewitPn3MCnHV47wVGJQsIVi3ZeDOBYoEE7TLPh5my92B6LQvSBOmhffsnk=
Received: from DU2PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:10:234::33)
 by DB9PR07MB7898.eurprd07.prod.outlook.com (2603:10a6:10:2ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Mon, 25 Jul
 2022 09:17:51 +0000
Received: from DBAEUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::54) by DU2PR04CA0058.outlook.office365.com
 (2603:10a6:10:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 25 Jul 2022 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT013.mail.protection.outlook.com (100.127.142.222) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 09:17:51 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 26P9Hl2N027302;
        Mon, 25 Jul 2022 09:17:49 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
Date:   Mon, 25 Jul 2022 11:17:39 +0200
Message-Id: <20220725091740.28188-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
References: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74be869f-897d-4f50-b2e4-08da6e1e8c9d
X-MS-TrafficTypeDiagnostic: DB9PR07MB7898:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5icA2p81aY1k2cvDeDZfYf7dQ6FaLrltCZEwz3WAm1L2itxd70WqSTqENhGeggBTtS09F5/aHibcZHX0SBVKWG32dWUPKpLxlXDsIyPu3k+yTjPr+DsUCtm/ROOyChZCGuiMsGHKgFIbFB1BCP/5Vi2qZbVyLkxq7vVrMGKFmcQm2UbxvIgINtpTpmAJb3pMBd5AFeZEyzq0nE6JS8NP0hulExkLklgb8/65pwmbmKRN1LMeZztvpp5AGKZQmvqWR3gzK9MnT6EPhiV1lfjKaLDDz2yDvKNYJTqsjw9+mKMxXqF/6Pt1ZovofdUv3T7Q7fUMR4Aneri7jqqHgWMwCJH0/UzKoQvsr3rdWBtSRXReRraOuY3pMsodib3QOT6Pmm/224KZTf918mJKQLJfasbl6KztQkL2Bpjorhgn5vPF+7m0hVPfB2NxBvyFEgf4OhKptjZ65HccbLbqlIDG/a35+JrDZtBPrskjyiWqBXrcNOzcGC0FKmI2hHyRRo/OjD5vNsSmRUlQ+sPPXa2LP/j8ipwVi94r+tZqCt3ukSJV16lWlbGE0zSpqN7X3P5LymruAobRqo1Z+/2Mf1IxBWiupmTLmutWDbvtfM5ZdJ18qjSbY9hGgQoDTeexy2M8MIQN6/b7gyoganiSkHggBECBWB4PlIL23dm3MlK4Hnn5AC4Wm25oduF5VCeCg65XnF9auHu/dzHc46UYCZvRtYXbS3LaXaw7bwWS9OfrnUUv4Ml59DRm+tdS6tcwKM9FM96dSAARNCzL9vu1Po5reuai/B66y3QU2U8L59vaSh6oXAngk9u6Rs4qOMHrhusykXh7VHn6yPHmFcdb5Wi1Kg==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(6916009)(8676002)(4326008)(70586007)(70206006)(41300700001)(6666004)(8936002)(26005)(36756003)(54906003)(47076005)(316002)(40480700001)(186003)(2616005)(86362001)(1076003)(336012)(36860700001)(82310400005)(356005)(2906002)(478600001)(81166007)(5660300002)(82740400003)(82960400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:17:51.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74be869f-897d-4f50-b2e4-08da6e1e8c9d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7898
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This options is used to reserve a shared memory region for user processes
to use for hardware memory buffers. The actual code to support the option
comes in the following patch.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/cavium-octeon/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 4984e46..c1899f1 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -67,6 +67,18 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
+config CAVIUM_RESERVE32
+	int "Memory to reserve for user processes shared region (MB)"
+	range 0 1536
+	default "0"
+	help
+	  Reserve a shared memory region for user processes to use for hardware
+	  memory buffers. This is required for 32bit applications to be able to
+	  send and receive packets directly. Applications access this memory by
+	  memory mapping /dev/mem for the addresses in /proc/octeon_info. For
+	  optimal performance with HugeTLBs, keep this size an even number of
+	  megabytes.
+
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
 	help
-- 
2.10.2

