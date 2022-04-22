Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5393D50B0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444424AbiDVGfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444431AbiDVGfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:35:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0D50E0A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdnYhgR+XmHAC/ZcDvD3+xH6LXLX4Q+I5qqbl0PF4wz8saXwfFo0pVRdQzuZ1PdRv71oJa1C47Ttw7sKkMjFqhrR1K+Yl+9mHaID2BK5KgU65qaTdz7rK2tuf02CX81izBOYvKbN/SxtNuMvdr3TVA8/VQkaOgeiHJesuF6Vc7oNzFC2TGPT1j9nxOF/H9z2LOeZgUuh/dIvAObKtlga+KpALfbfa5jO65KFefEGI/0BbAvobhz+fVJ+Ekfw1h6iDVDpDXxe3xY+vl/hTcxztW7dF7r/K2arTqA27ez0KW9ZUfylX8AFBYSBQ6VCEhGc3VfdKbR14iFrnu6AaElobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNMe5pJikl9pd96UwC4jPJk8hPZIsoY8KnpHs2wS4Cw=;
 b=bi4fn5gjADy6OIJik7OGa7ZenQ87atYAXH0nESCk1NIMrAAhu7EQ+yM7qU8ith3E4MMV1CA/cyYzB5O1MV0plczH58q8b2K47EBtIIS0D/VSLnvg0HD6yhBAHspZwcfjI0l9CsZsvMpqRIf7uyoM+CO7ofO1ZqfOG3KnSD0HbnYd5tJTwrPmGxLuhIROvDlADbrVSZKSoQp/wSCYaUbkVuDMpJ6u9tTB5yrG0UFJrF0oCUo4NcFayHsquhavFMdaXYauLNSmzD4NPYDEnusLJK2Pf3hXmc+4+gOMEZyesmQ0ikg3wR7wCSnL/sHJwi/z46D1bcGPDsTa5NUTZXunuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNMe5pJikl9pd96UwC4jPJk8hPZIsoY8KnpHs2wS4Cw=;
 b=OeQ7sGZXJ3JEQ9qyn12qUV2A2cRO4VD7IJNVtJJw9f25fUJmFKwTgrlcgaCI4i2ELWcGgfAH4a2sB7X8Hsn5mPy5Yc9qukQUSwpXiulrXPKzWXKiWGgpMtZMUD7FJl9mxwGZIKxVCTDfN1IyDAGHlief3sYCrFgsI49BTkm53dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TY2PR06MB2511.apcprd06.prod.outlook.com (2603:1096:404:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 06:32:51 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 06:32:51 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM
        SUB-ARCHITECTURES), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] ARM: pxa: remove repeated includes
Date:   Fri, 22 Apr 2022 14:32:13 +0800
Message-Id: <20220422063213.9891-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0183.jpnprd01.prod.outlook.com (2603:1096:403::13)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fabb95-1649-4ccd-46aa-08da2429eca3
X-MS-TrafficTypeDiagnostic: TY2PR06MB2511:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB2511D3BDE11B5E02FE730651C7F79@TY2PR06MB2511.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VC2eK5fB5KA01C8Ea9Tq918a+gvvORqJyx/ScEuJ808Ryr5hvBD+umb4VsdsDZ3jUrk4aqrq4eHE8iOOfUn2HQC666UYKKcOxTUO3M2mrwnUzRdAkN9iggHC9ZGQz50QmSP7BgCJRN5ovV/MZLW/9jtYRn6TFASgebN1BWBNaHCwKNFNmHgjjlXtFUwIH6SRqoSuBNM5EildgGMpc5VWJondqDIwJcXMIwrAKyM/nkNeYDUF+y/ceHBW582l/A7LFwVx2Ge2Wyzhyz5fzS8wuneJkowlLgTmhr7AGa2kEylQ3IjJpjLDKXrjHRQALXD2y27We0+6Say8MVAeNlAQ/1LSt73lHcwdjExk02PCte0rf6wm2eaHeP5PYog0xy2gtPPW49dsdv77Rbo6Q3sfv3fOFNgVYR8FTpqHPYgd9/6iyqhTv70GzlaT73TOq/iUlryhuwR2kZaThKTQGotulsXHYXNwM8MUn7XrCE794f/FIjHwbKz0X4dEMunr1qp87DDXuH7Z82Fi10Q4VIioN6sqzuEvpCPUdrG7lqagGLcGrDvW/rGpjS8Mx26NZmjcRcB330og5tHtAtFD6X2Q1qbVZA0TfM5ur9TcF6d4UWdWrpyXgXGUrsUBSB1cvtCeyWlxQbF1oHiHV5lYAbtHW4wc+Q6gWCXSOxT+FSy0p9jif0C4n5u3fi4WhsQ7/JwTjTbjGcjI7M648826W8j2kbYMYJ68V88ewf5IF0YrNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(86362001)(6512007)(6666004)(52116002)(2616005)(6486002)(6506007)(508600001)(38100700002)(38350700002)(66556008)(66946007)(26005)(107886003)(1076003)(186003)(83380400001)(66476007)(2906002)(4744005)(36756003)(8936002)(5660300002)(8676002)(4326008)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaPipiHFGzLeUlQ6Eu8gjqvDMf64nPxX0b7N+IoWbF/Js6sekJBLV9W+XG1u?=
 =?us-ascii?Q?iaMLxrt2f8y6wqNzRHlmG3ms/YnlrRb4YAyy34Ap6NygLSB2dCns4qWYYhd9?=
 =?us-ascii?Q?RqGA2BLdHdi0m1E0clq7XSuZ1ax/7kl+Lmn7+6u9u7ndbTVUek3E36fDnoPz?=
 =?us-ascii?Q?5WIWFMbcMKiLEHbAyBLc2ReEMSz1NpkQl9uvLxc12m7e8cJAgDhwwkT+joqH?=
 =?us-ascii?Q?cptDMYFYO7N5RZKX0SS86zSEqHSpzsfdirS8BLKuypfcUQoYr5wcwica0cZo?=
 =?us-ascii?Q?MF53sLSv6a7rUZ9cSc9fgjS8hW4stsXmHGhMdw4XDouHM1xUulMUGgV1qgJX?=
 =?us-ascii?Q?JMKHjZslchxyT0FHm7x6Q3XQkotcvby+MhXaDB6c/F0M5w9eGK6Z22/hOl9a?=
 =?us-ascii?Q?oxXPwuttkwDeSeLH6jFIQ4lXimmvQl45KzVNy8/yV/nrQ1SMpG58IwuUy0GE?=
 =?us-ascii?Q?QetBiOE6+gZB/JOkn3rTKs1DJ6ZSk2+g3aolp1G13ln4ppu+Zzj+gdPB+vh2?=
 =?us-ascii?Q?UX234G6PETSXf07dSe26OLh0TeNqqKa9VT0lQf/mkIfBeMIILOIDxBmTsHoD?=
 =?us-ascii?Q?OOsuL6JisftM5fRESzrKtUMAdmlEeJrujK878ZzIJXaPAwI2pAdexy/GlvBF?=
 =?us-ascii?Q?ueCqoGLz/PjxiGbeZPq4IuV7k/3lRhWMl7izKRlBhNXbqTBVyRI/GM2Jj7nV?=
 =?us-ascii?Q?bpcS4MyOXnSAtiScd6NimhGX8OV/gMw1UqYlj0nVWocbmdEPxQkOc7dDf2DE?=
 =?us-ascii?Q?ZJgTowpVMR4X8RCsT95edHt9p0s3N0NyJPlbo1NeQ33VnhdIf2T66KQ2XHei?=
 =?us-ascii?Q?sdekG8j0yae+EQiEw7p/MaXItzlpNBzCTGH/oXmXZmzbeM14VywPdc2YW3rQ?=
 =?us-ascii?Q?GjEGTzJ/8w9rqqBpayvPndlKbxTW29WqCc397SZFAiSwvuqURnzJ8EkrAriR?=
 =?us-ascii?Q?pWhLqhruEzp9WH7cmiXn7i7oZGlMoMi/V9sYg0FUvnyUxKuxqdPWI2MOYcW3?=
 =?us-ascii?Q?/gkSARTPYilgF96zXLeYJkbvB9tVcQh+c8b3gU5laGM23hYhte9U3z1ZoaGv?=
 =?us-ascii?Q?4rbGc6t4kAPUEf565n2xqrX87IMXCpp3FUXrB2cga8voYl9inr70bwcyFDIW?=
 =?us-ascii?Q?DoRe5UUNYjEfvm9s6NMlABt+usuADVWiJw7gWERjNKlUFdZoKnws/h8wpMXh?=
 =?us-ascii?Q?geGUxFxxtZsbWgGGG+ariM/UtqPgUbRBvAtbQ+Inj0CBsX63S8YZf7DaVEcw?=
 =?us-ascii?Q?jSnGcE3fgiu8AU7WlcXRorkxzycdIt6DODcAADuHTYEK5tJdT2URcmjZo+Nv?=
 =?us-ascii?Q?7URsn72ziY+L8JcPBvjIU4k6y1x92DvjrwMmqSKOt+uWK8N3mDgAJOA+PAEs?=
 =?us-ascii?Q?Iy6/se+PgTfQ4DuAnfT1CYdC2ryflsEPUBPueVcW1kPsFajGzrOkYSi1As9U?=
 =?us-ascii?Q?RzBk+UixRX1p4qYTiYDn/HaM/2ch+UQJseNytv8c+w8XgbAx1DBtzrAAGjTN?=
 =?us-ascii?Q?blBGbm2gAPoRtks/KsFytWxmmqFPe0jlQ7hhx328oZZiB1LPsw7tOItGgcK9?=
 =?us-ascii?Q?7kJEuSnKG9oB0wdW0lS8zaC+qTe8805sExF4xaCpF+s5VzFt5MK56Qe+qJwV?=
 =?us-ascii?Q?GfoMTAWGa2Bdy4JGu0dT/WmIRMMQCveXd9c5D+haOOjPvkYNl6fEjePdWAkS?=
 =?us-ascii?Q?LAeAH8BDCoEqWszz5q91vqSaelS/7sgRpzvfHvLobV3+NVPRzZpCuA3aBkDG?=
 =?us-ascii?Q?giYiEyhHCw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fabb95-1649-4ccd-46aa-08da2429eca3
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 06:32:51.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bwvpz9N5flDkLUhpEfKg4eeOMOCRe/55V07TBj3OGwALWRcIGXhyTDOKtnGvvlkTF+uhYoyPDNDSG+WjG3BP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2511
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a repeated "#include <linux/gpio/machine.h>".

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 arch/arm/mach-pxa/eseries.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index c441a299b1ac..63351477ec6b 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -17,21 +17,20 @@
 #include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/tc6387xb.h>
 #include <linux/mfd/tc6393xb.h>
 #include <linux/mfd/t7l66xb.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/memblock.h>
-#include <linux/gpio/machine.h>
 
 #include <video/w100fb.h>
 
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
 #include "pxa25x.h"
 #include "eseries-gpio.h"
 #include "eseries-irq.h"
-- 
2.20.1

