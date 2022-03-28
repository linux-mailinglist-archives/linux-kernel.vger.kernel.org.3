Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DF4E8EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiC1H1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiC1H1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:27:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA6255A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSW4p1sCMKIY9NP38vUP4WdoAMRG3IkVuw5s5nmb4yEOEMkaKsxbJtzTzoZ7Yp0TFW1hS2uFQ77pFOWNh9oIVeRJayrrqwyh0m52VfMzhU9G4o/PGqAPLNxlZF0+A+3L2Qa0lgaBZiz9AfGCA3/oVEGbcHohhIus4/VHeSnA8/j/vChXVFTuH4KTuYuMsGbNLkIBrE+aR0eptfDzOI1h52huhXVRwlvblHKseeW8Yjp8//atH8V6DAKaQ6EuYVagZpP/N48s6AavjDJ3HGAc//P13uFTUTlg9g3xbl9bT3aO0yLWZFT+QdK8+k6MGEbAIR2oNgMeNrIbPOQqSueqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5psfVh8WyLeIpHXpvPTNCnXU0hPdANgAhA6YsqHn3U=;
 b=Cx7T7I2w7y3hJzSCGxmcXOrFC342uZ8Ly7Xp2gQhZbTabI8zjqrA4D00i6yWlFOrjlVJdrnFT0lufVw7fpUf7gikN28Z7wzQkDW5sNPkCDdHCBh1GhAxR4w2JHwM1E3ytIAFhreTONv7vevmr+GkD7q5JzwjCCP56lqQc5rFifisHyOS4olgO0tJVXccifqw9ooMiSh3zAEzKhx26iZ6avcKZc7rgWb4gAOaR5a+PQYXIKz199ew624CWCe6iRfts6u/sWrJxvgBPbWvmCPWZVF5AsDUFimdZbeTUlPPoJ1kiVjq6kH1JtBBEqeh/0WG4ef4M/T+t/tLrq+UBDR+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5psfVh8WyLeIpHXpvPTNCnXU0hPdANgAhA6YsqHn3U=;
 b=hv8bSTZWhEtUUjldH8cYpPpd67vDucVejOER408u/9h46H/POkY9YTTB4Skl6Og+cNjtmFe5IG1QL3qCV62Z6awWsIWf8FImg7j8K4k3cU9kIp+673nWLD/3BOMvPjcUAUtn3Z865e4sr2AYLqMTzT5YH9G/Pmxf+gY91vwNqOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3080.apcprd06.prod.outlook.com (2603:1096:4:6d::16) by
 SG2PR06MB5333.apcprd06.prod.outlook.com (2603:1096:4:1d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Mon, 28 Mar 2022 07:25:29 +0000
Received: from SG2PR06MB3080.apcprd06.prod.outlook.com
 ([fe80::34de:38d6:2701:5f94]) by SG2PR06MB3080.apcprd06.prod.outlook.com
 ([fe80::34de:38d6:2701:5f94%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:25:29 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arch_topology: Do not set llc_sibling if llc_id is invalid
Date:   Mon, 28 Mar 2022 00:24:58 -0700
Message-Id: <1648452300-3233-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To SG2PR06MB3080.apcprd06.prod.outlook.com
 (2603:1096:4:6d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ab6606f-6b26-4c15-433a-08da108c2275
X-MS-TrafficTypeDiagnostic: SG2PR06MB5333:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB533371CA76E9E967BA1D9569BD1D9@SG2PR06MB5333.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5W31eyf6WqeMFn2YlWG78/8VuLdSqJZPP4UDwPVj6K1fLrKW2fEifc1IvepBK7XfayRJUv8Ttzxw0BgY5b3iCZqYqgg72ZwAjK5vTLL7RbAWeEvKS+WJd2ykNUPB5/3l9AKSbNXn9mOsPZ5wM1KmTgsJ7CfZ05jdH6Ya1BPPCmXcRNKfsYit9HtDD8o/BHmIjVrcU52Qw7Iz5/U8SopNu8AnexRbZJoMjilnvHNoJ4S6VBkHusEhx/5/yd2KGM/TIerTdXXALe4F0xaqhLvBjk8ltfi3H7ais5M6+a/Xlb5/b58jKk3Q82tfvf7Z39mTD5HApSCBDRCqbtbvPUwZ6fBHI+gh+ZFjv2nU/UAvZV6mrTjp1Yl87VPiPtJJyFKBEKEp8K4+r7NEXtnqmGyNzhAN43Y4aOR05cGbxIlfKNEAmD+F6IL2JJxrWf1viexAwdWAORcdltQ2t+N1Z319eOPS4lN2cq4A2cEbHMJf/d/WXokC59BJy+piOnkvyCS99oFkdBNV48yFpryYO6ruyZqCG1KuRXSqKHj+jkTsEeOP/QlAsgKFfO/rNfdcISxVfZf4V1wIoZ7B12gU0H6l64rip+IlmoqsGMcDdgkhlcybUJWBpahkcp66IsKsvhaCe/gJKuycc2m+3Z+9L4j40WZYyFAfo/BsnaG9sXnwjom3RV0sLlxujU3rhmgaQlB8ocOF7rKBzw66QcWZN9YRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3080.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(52116002)(38100700002)(38350700002)(4744005)(5660300002)(6486002)(4326008)(83380400001)(107886003)(2616005)(36756003)(186003)(26005)(6512007)(8936002)(508600001)(66556008)(110136005)(316002)(66476007)(6666004)(66946007)(2906002)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rf7wXEByGNTLtD9apIhkjbPfcs/rH92aGOJSQddldsyv9kN5KhETb9dICGWm?=
 =?us-ascii?Q?NUBgl5v+rmMHZNzdDYAHJvmc8zO4a8Z0fJAdD5Zrp/PMOlE2UXRsU2HKaolZ?=
 =?us-ascii?Q?loqdZxnJmD3ovPgtR1OoOV2RiEgmsjgTP4nIJxAjxQMai2+cYyKizWyqt5MY?=
 =?us-ascii?Q?9sqMKYBYat9MtzApzi2EQqvbKHwk6tWueJsxZhHrwIPurxf5Kmt7oAEs9zzG?=
 =?us-ascii?Q?bhxgJ2Sw0SrD3M5/T5uA+T2pzcGL3ln4/fETUWA7qcFdxtdzYnD6oxstgr8S?=
 =?us-ascii?Q?otubTnZtHGjsN4K7ffjMn673WeVLsDZiHiKeIhJPpU4rZMIH3pvEjJz3ZdiI?=
 =?us-ascii?Q?DGPj5V+kVT6QdEbl/tQwknl3+0lVIGRRGgLBgRJlM1ZgK6jJPJdojgT2XdPG?=
 =?us-ascii?Q?sO6VuPlQdHC9AoHXJbTTJgVzw4hJr5aqVP9Bvg2cbM8fFzcKwhYnyT/pyoxm?=
 =?us-ascii?Q?3DCiyr8futKtkuxfLTcC8rsDxwi1db03GpfJWZXh/aQrwr4S02XjroGA/ZHH?=
 =?us-ascii?Q?I2XpEZkMg19KdzTQGj86qFIF4ZLLxjCinMx/0+E00RxsfOJiNSvn2kPo4ItP?=
 =?us-ascii?Q?tQs1lxWlczdWxdZdle7VW667wV9M0JmYctL1BAe0wyRhKf5WoaKXURH6+LKr?=
 =?us-ascii?Q?qmCgEz/5R/fPoKBdF17oEfdrfMYkzMwJqUu/1Lf0jhOeM+jFeUhe7Yd+TOec?=
 =?us-ascii?Q?0LksMM5CX1Wqd2gVxoznXmSOD/aGmpua3xm/Ir9VGzG+zopTQMB7qeAiQ/Ek?=
 =?us-ascii?Q?9hWl6mm+cQXhpx8fZSMRhi1MvQ3h/fSBvU6jPNC5RJucDCjy+FBSiVlt/Dun?=
 =?us-ascii?Q?e1xy722CI+qYK4DvKxoeyz/XwFcpZZJTfuIdu90GNxviHfc4bAYGlq8NDOBm?=
 =?us-ascii?Q?XDBoX040s54NGU7PFLggNHJAPDZTbAPklQiSiZydzv/KpyKrWS2PXsOTSJPq?=
 =?us-ascii?Q?nt/XuWGDIl3e5DKPv3Dr6yaLfIP9DGSbupErYTU3DWpr1PAKOVuPM8/t2Ux3?=
 =?us-ascii?Q?/9GIycqBpjQF6EdqiDIwZ8VUkSKmnQQB48AEczTWr4R9GG1tDjT+JL9Hk/DD?=
 =?us-ascii?Q?ewIGbUvEe20mzD+YsPOpNjtoUa/wfpaR+20szLOTePVXz6rm/Mlx/veto0Mx?=
 =?us-ascii?Q?GeuVxyeqs5MW1OgI/VG+pcxldyNy7Vzu3io2ggCyVh21hjOUgcb5z7E3T3Yw?=
 =?us-ascii?Q?QeGkzk6896oCKlqY/RHXZhZHtKrbbNFz+9HVoenJVdo2VkJe1t7K2YAk7Ymx?=
 =?us-ascii?Q?f97GqtDgAvvEcHVKGNw5nNVMjhWxyWgOvJlFPS4MQH+BSx9YGF1bOU9T/jDo?=
 =?us-ascii?Q?DzTKKd0qsQWNNPSSfzU42dHwjVeDwsV2JHFWRQEue8QK1p7uzvpadTIWy9HQ?=
 =?us-ascii?Q?hnrDkLQAaLETaeqqYXI8PvQD5wM0iCoNxbSJ1BkiNTBTEUf5zgVC/kh6o+al?=
 =?us-ascii?Q?zLXD+7iAPAyqsCRDqNWxiPyAnLUupM21nzTYw8EuBp0h6IfjuyEHcJ9oi1AR?=
 =?us-ascii?Q?A7CEEHsfrZyXF3YRtmthwQKVmL4D2k3Lpa7bJA7vfFPiNvR88liEKmTDERAr?=
 =?us-ascii?Q?WhqKYAXTgKcbY8t46iELOoAKKqbBU7Al2iDWbdxed8D4aWPt/CNMMlyT26hT?=
 =?us-ascii?Q?QyLfCj7EWbcaraxWnsHC5JRwoRL9Tm0Cz4iFOL2MnETfbUCjB198ycHOYiz8?=
 =?us-ascii?Q?unJP68amVkKEBca0krVPDyoTRXNsQDNyzF+l0TQ2JcveV9F/vyDAuOUN3HAu?=
 =?us-ascii?Q?yv3rIVNwaQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab6606f-6b26-4c15-433a-08da108c2275
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3080.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 07:25:28.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDbu5B/Yti+/1HV3TnqW8ttl3YqS/fjPjbooGuHUD4r6BSysEgK7dHv/CnqVIq2pLj62IWj3OHEo2VeEhOXkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5333
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
will set llc_sibling 0xff(...), this is misleading.

Don't set llc_sibling(default 0) if we don't know the cache topology.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636e..5c3a642
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -684,7 +684,7 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
+		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
-- 
2.7.4

