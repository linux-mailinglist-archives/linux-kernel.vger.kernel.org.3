Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AB47425E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhLNMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:19:59 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:41616
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232035AbhLNMT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:19:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLt3hDdaWu1mJEYBCbwhhr37uRHeXTvQ9cDUZ3gepeif7EcaFEp6UFm5t1PkRV8lJKwL6kfTto7/81BOnGLusXhz513k8zeIRXXhg3YE29cmD1R7rQq9C1RwVATId1JqD2W+v0/FRoVEqfK6C/u1S1U6ZfY5tWjK/L89cOy8hgOVdqjJIsmaqMPKqARzfSCA2jOiCb0fpz2/BkkmtYM3KnwQ1+Ot3ieSQXWbHVd51Hjx3SLEY3bj6oLFQx2v7Tcpn6xxXVe6V7At9nSz68zhRTeh0Cwi0AtBpl66xmPNhHLqOLMsJwyqhqQnunMqSiUaAzFy4jrPmXgV0z2E7ZkZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X/n/Mz1DCKovD3uqTcqXURC7EQ6OmJLTdaFEh6MlHI=;
 b=Kia8UYHOhs13aDn/WpfoYQSEP0QZT+9T3MoCDmpjPzJcMsKWT5Rk0Fq/0JMvJUpStfEQaDZBW5buMOpXis+xX5QHhLWEnWHbVQ4yBd3lgRlrjvndraacjt6lOhcJdTa9UVgT5wJ9w/dSnTCszAagmgdD9gy1YKxwyEfWjyBNRyhm5T4dXWLRZot5R1bXhPA7IPoHIfwSb03wm6gsmIl+GSuGCOnIcpz9ylivf8KROecXHcWboW5UTJlnCJske0qN2Q5UvwXa8gLIZRQ5v7NJSufVslIbbAuC1c4be8iCNO/Gg68AWKv8DPXwX9FXFciwub8FrDdvr1a9itXgMcu3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X/n/Mz1DCKovD3uqTcqXURC7EQ6OmJLTdaFEh6MlHI=;
 b=iRLKt9BUAG+gKQEIdbN23Fa+59XbGFG3fzVa07p+LAYqGtfm2/RY2HHv4mzNxMjlrIx1bq8tR6ORu+aUXJu1N+8dkXVJZyT8CxeuP1BWvWNXq4DPvfIXM7V6Jk7UHda6nWorVW14MObMICO7a0Mkiec+WpN8+wAMJrwB4yKgke0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3084.apcprd06.prod.outlook.com (2603:1096:100:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:19:55 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:19:55 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] coccinelle: adjust the confidence of uninitialized_var.cocci
Date:   Tue, 14 Dec 2021 04:19:47 -0800
Message-Id: <1639484387-76107-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0366b7-745b-47d2-161e-08d9befc099a
X-MS-TrafficTypeDiagnostic: SL2PR06MB3084:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3084ABC3C2C819083399A6B7BD759@SL2PR06MB3084.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqrwsxNO0KvKWNMnqXqYDWMlsE7k9QizfXkPCxDGdfboTdwsRi16VML6jWMMn3mCuwNSmDHUG2MVM5it9Hkx1DxD79KPXaA39AHKsjntXwgOQLPSGzTE+C6xO7O3CJ2ulEXSyyLdme/dGfj5TYZYGFBOvWLHqoOeas5lDE/YTmAB7hHpurPWatL/QcfqkQDodAbfqKYalAasKf01P0QQue0rBCtEumLkqALWjA8wjvNpr7HdYdeWdFuSo0O9UC8I2jjlwgrmp6lE+eqVkQtlJMLSk99mrHWUKijPyB/FXktRrHaMeppfGHfIii1IZgpVrI7T6w7mzdFJyS5FiT1sh/RyO4fxy113ZzZsyU9V0SPtLZIYX7wMB0+dJtF0oLe/NEK9g3OWwaAzb0rM3U0n5WoDfJP7HOnAt/6t5PSt/a0uPmrtWJiVOiWd4DRBizMdSd04qDqiHc+Qkmwejssf9hCHdwrZGkQPxQsPhOmC9Xif89zAhjEMYtLgfmje48b8kPhy72ggrwaijVHKRQ0HyP8Xc1N6lIxuE0YIjwqBwsl3nrJnDJEooI4kuLTkDvvcNecfOVN2v7+C8IhiqIYA/+RKCXyq0FZFSpOBKNsehrynIPb/950YG6O8ctOth4e4pIDsoYOZsIR/nG+wajNJsV+pwjJjnROr53BwjiFznvo2xglV6VDDUEtLJIClPzNnyc+hfZ3dd464BjCNuNPT7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(107886003)(4326008)(316002)(186003)(6666004)(8936002)(2616005)(66946007)(66556008)(66476007)(6486002)(83380400001)(26005)(508600001)(5660300002)(6512007)(86362001)(4744005)(52116002)(36756003)(6506007)(38350700002)(38100700002)(110136005)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MX58LH+lm0Vc7EyvLK3t0ltyKnhewlwkr2sE2w/VpqsAEmVY0QXja+2Tta/?=
 =?us-ascii?Q?AReEDHeBIfDnR/GHYZ3gsMDXK1/fHTJgMUfviNgsi6vpUWcMFyITjNwg1T3K?=
 =?us-ascii?Q?nrVmnpq6GOSWfXlncG8wF9+XmQ88e7KG2Q5ppRUrRWeo92DrDUf/ZAp0M+U5?=
 =?us-ascii?Q?g+k+/UEqlJ6DsG/WtTdE/bAKe2AKDAbfaFxuUSk4QhxhGqYQkIQ6kjWsQWNq?=
 =?us-ascii?Q?heaxyElHHZW31CsGnliZT0w6QssUZgzsgpi+EmMQKkGj/zQ9M3g8C0qfuAMk?=
 =?us-ascii?Q?bZxYrxifWMVqBG6Oyx8Oi8i1tOq8GomyXdHxuoweL4mw6So/YOpewXXN5XbT?=
 =?us-ascii?Q?m3fhBAq95RuFsG6zC4Y/E+Z/uKtmQ/DRyphujmiV3kBuNEMIMY3gkV3cqSXw?=
 =?us-ascii?Q?K9/iUvzQc5DNwKGerh8zAF3a7nLfUSUPt6sOSzUVIdiShJNY+IOTH6i8M8cA?=
 =?us-ascii?Q?ffnobxPSYFGp5ReQ6Bs5E9CmIi2feytraJe58gGk9AKz7E5EDyxF7+TBH0xA?=
 =?us-ascii?Q?p0MihbxLbOomIv2l8W/7YkMjlyVj0oGCyfp8tPbPNFQfxSS9ezy9p3RTVyH+?=
 =?us-ascii?Q?AMSUjQo/vmegYiQUxZ4lq+QuXW2Ur798NbOzUwO2NUSu43l6OGiQKQyQaHGe?=
 =?us-ascii?Q?Ki5Mk8gMp5uczkeXKLZ2pDdQCprxVbnqrTJA8ocFine0IaIsyiSQci2yIbPW?=
 =?us-ascii?Q?ElZ6iEcLE5Bdz4INurqyw4RvQxi6WPZeHkaHcSFo7fjFGLij9WqMC67i2J3F?=
 =?us-ascii?Q?IGqcY2wNNoc6be6G/9NQuLtJPwii3N15qHyxojikk73L8QgUOP0u9Lho5bL0?=
 =?us-ascii?Q?sVdl0wTb3aa5vtXRYGj1OZqndXX0R4vxc0KBUpdLlZ8JZBvoZ6OriUAFO/YA?=
 =?us-ascii?Q?D3fy6x498fcSBpmeng7gSF/mzG0UnxIHc6Ka3DZebWiDjnaYbJUSD5gXEWO5?=
 =?us-ascii?Q?VvLKpUQx6QZrizRDsQpfz4VBz6Eq4+DjeuqFY9P93UQi6BOmG5v5qgjc+iax?=
 =?us-ascii?Q?4BSURUybLWY/32VBgZqMZBmBxe4Tfi9fq2D/3LC0wsoKxw3Wg9AoECgOA55V?=
 =?us-ascii?Q?QwBrcNXOukaW2Vhep/FXNjih63KeToIZlyi0am3hMt1i5otVqtu3qn4VmNnO?=
 =?us-ascii?Q?b1Nh/I/W3jKbAXg95TMpIoG01Dk1u/ZU0iHIKn08yV1UXGe0xEjPdYvCEjlI?=
 =?us-ascii?Q?bUZo6lajTjonw/5RY+PTY6VhhFELrFOFID/3lyKq6N2/Zua09WBKZGE+LRv+?=
 =?us-ascii?Q?T64uKiCXYc/pe2SisRLOsWWGr3IWhRJKPS8b+xcdfUtq8kf83VXL/N4daAPx?=
 =?us-ascii?Q?jOaRo5k9huRfZUUYt38jsdhcJepnMDeL6JJNl4LtVj7pfu/g3QFx/nWrYE2H?=
 =?us-ascii?Q?HNiYeTKVZNuTCbRoZhwGiajaXJC+zOTrO5ZJ/8NaRSEpaCEoGQkbDkziTRmw?=
 =?us-ascii?Q?JkDDp8a4W/+o1izZNIip+u8IA3ekHIeF1iWZzh1KV34XnZlJjmbMHQuiVRjT?=
 =?us-ascii?Q?0OxSJpp47jppVp2KMUN4qNPh9m7HdxA76H85Vu8D9jl52teEo9gB2b0Lkmw6?=
 =?us-ascii?Q?/A4JmgSnRjmkFzyvyvHAiJ44ZK4XDIRZ5tMcub/Us5Ji2Bbg9Up5+dOUBLrL?=
 =?us-ascii?Q?+UUYNn6nxa1qkV3PM0vnovU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0366b7-745b-47d2-161e-08d9befc099a
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:19:55.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/1bsWcaV2R3C3aqR8gC84AhyEj3M6v3TbVUtaoKwcxZ/z9p3IRuAXWt04K99F/mZ6sJ1ApF4VdbbhC3CnRWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Since uninitialized_var() was removed, this cocci should reset its 
confidence to low.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 scripts/coccinelle/misc/uninitialized_var.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
index 69bbaae..79e02e3
--- a/scripts/coccinelle/misc/uninitialized_var.cocci
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -18,7 +18,7 @@
 /// this kind were cleaned-up from the kernel. This cocci rule checks that
 /// the macro is not explicitly or implicitly reintroduced.
 ///
-// Confidence: High
+// Confidence: Low
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
 //
-- 
2.7.4

