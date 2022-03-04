Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36A4CD200
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiCDKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiCDKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:32 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F52F1A7D89;
        Fri,  4 Mar 2022 02:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f53tsZiNh7NfsoeYG+GZLZFtWgxGXYN6TRc8K6otSlSa4vP65RNz/DLFikqOZc7UyAEhQdrUhrTVU01g3quaDs53t0oAneYXZkjUWQ0kvDZIZP1Fd4Np8q707Vlj/nC6rdhHPXD/FirzuUhZBvfbyPfUwxE7oeSPtaB5vvrzgbkjdq0r9MnPohtG58Y7GEM2Rj8zD5Y76c22dg7qi9owrsgvVJSk96IjsBboPZahigGgGgxYPvSR7NoNSdsX+utGwL867QTPF7smfbvLoTP33AsLygVOlUsaGNvA7yRzYAvaCH1v9FCv4vRSe8ltdvc4QOPOu3SG5nmhwCZLHx/ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVO2/nH7ttQoj34Ss3xh4MBHpK3ZK8PlQGv/Tzhdc+k=;
 b=iE/pb1KksQTu3zbWTby39ZLIbTosPzIxrqxhM5DTKhtSKGkzBVcQN+M/IuDbePtR/NLsjLLk/oThr1iaDmHsP1bJrqLHBNC74O7xeeyLfBfLspUP8preoISjfetfjQZf+RO4PYlg1cM+xCiqNnxL5mEXWBP6POHuKRvJ7UPHYMoUSF2KG9uNVrH9V+1G686DjLwTtgnc28M2kUelSgNChSKeMSJHQiImU/0qwI9ovPZJqWMwf5/XnB43UkP7g3OeCTkp5pxsZyuVOas52YG0wDIB8fzWLLoIATQSCgz3P7kAKrQl4I7Uxy1BuUGwt8aNjYoWMU9KX/FmaEsEjLPTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVO2/nH7ttQoj34Ss3xh4MBHpK3ZK8PlQGv/Tzhdc+k=;
 b=hR8ZZQmg8LS+/Q0nWWMb++VIQSJX2X8Sh6FyPKVhWHPk9AD1ZjnEeOaC7oQAyvUXW0zPR7ZWfFbfXcRl98r9ROXDTxJHZ9gSkYo/6UIvZcw4PsFRbvMebB8z53fIanfh3c+9WEoLMHKVmF7zYMgS2mQ8uH4+3zx1PkbFeV3A6NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PSAPR06MB3910.apcprd06.prod.outlook.com (2603:1096:301:31::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 10:03:35 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 10:03:35 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] docs: serial: fix a reference file name in driver.rst
Date:   Fri,  4 Mar 2022 18:03:15 +0800
Message-Id: <20220304100315.6732-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a77d1c-7e8b-46fa-e0f0-08d9fdc63ee4
X-MS-TrafficTypeDiagnostic: PSAPR06MB3910:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB3910D987A5572DA4F5B795ADAB059@PSAPR06MB3910.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njEY2iJDwIwNVqv2oF2pJ6zSfmfVB1hGNsqsa9TjLb8drJ8JOggGE/k5/NkC0Y2jDszJ+ma1rNBc14kvSD4sY3bjHO+D5bmRex9CZ712deqYkgkHjWpebZrxRyuTE8kF6MLrIiwtWm3MU4hfEjchfN/SfYgZP+KWKU5AyRfmRN0GTBcQEvt017PAZh2NLaLHmtRJ/zfXYiPQYtTx9FCskhowID85pVSA2Ne9rsxTKFf6U+xeo6nwS2GqBEJyABahEWhwjWUnMvTrU93DkvLaXP9MlV35jwrG0v475yDvGdNt7DEQVOXvwd0GGFXlzoGuli/csYGw5HoC2ZZRTc/cL/YJnme2J/DSx4z4U/n9o/S23ZbHd4ckOgb3riJnfbtoEd7KXddwMozkyGNBXCiGWJc1sQjB7DnwvmTnxhVx4NJOaBFpUBavp0gXdpStHjhlHOqdSvZ186MQDybXqODmcmdtscqHmJeCYmAOm2hv1X5uTXo1ZndcgvJYFVcI3tq15IxZ2yRzi0mslmmgdSCQ5Dfk6KWnUVhBxNELWPaQ7zvN8cYfGHNt1KqybzqzBUHCsGmJO1Tpex0TnkSQ2vW3B/GHpbiImJ5W/SY7KSPPSo7yGUGQeHQYjq0MZNFu6eZ8pQbRfBXvH8cyhqTOpjSi+g+y01xKUbIE+rrAqEPhMAQbJLCThAzm/2+y40hCR2/hQn3OXr4VZMBE9UIL1n0lNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(186003)(26005)(107886003)(83380400001)(6666004)(6506007)(36756003)(52116002)(508600001)(6486002)(110136005)(4744005)(8676002)(4326008)(316002)(5660300002)(86362001)(8936002)(38100700002)(38350700002)(6512007)(2616005)(66946007)(2906002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQwBacp/wcKuOdb8snCglmxD1bQeE/deOsYfJVrJY0W/sg4iPfSDM6H73Xuv?=
 =?us-ascii?Q?2YJh7wIa/T2d80u00BaZf4A8L+365QsNQjGsIg6fvyPq56E8NMaByP1Lu5Tu?=
 =?us-ascii?Q?lO82RPbtzRIByAPCp+hUmZ2jX3DR2IeQ3vqfrsOYM+7zsCwdu9zQIi2no1q+?=
 =?us-ascii?Q?mwKEJXdb38ewWR3vhDHLUPAbkumnQrFQXwuccxcLiUeoIdjyFP5SZjD5F1uD?=
 =?us-ascii?Q?kDIngDZ9r/VpqHAwZ+wrgniG9IZYpOylmTLIBFthp3Kow1EHP/CLsine4dH0?=
 =?us-ascii?Q?khh9X2kyyWo0fVhK0+W2vhU8+uhWT1PO6S8/MwaIRyfNLYHTSDeZvkqEalh+?=
 =?us-ascii?Q?MNDwdKxGH3uUz/lYGZtE0mw5WvHtPMz6fOLS5Zn7wQ90VqWWlUSp2qpW7Em/?=
 =?us-ascii?Q?wApU46Wh1t+BiPzKcCJ/1lm50nPVyXJYmywsDjrFIiMPqO8oRP5RwR+fhJq1?=
 =?us-ascii?Q?ZRlHoXty7xjS50P9lm1igf5OnBrBCesMY80bbqswnUbUOQlR3z+KjmRizotg?=
 =?us-ascii?Q?jfv8J0ygCcawrhIjBArTSDAWJV6WQRQB4XAsofHF4bZ/7P/E7W24wjSnAb4t?=
 =?us-ascii?Q?z7MYZC80sddeRc9IQaefHvIunfxzd9UA3/bo7snyeQygC/RdlMJPws2pAWvy?=
 =?us-ascii?Q?hV5X4+twplyVluZv2DXDVwDfcYQoJJPXyXxmW4x29DacC6fD0d9IHKR0ZwjA?=
 =?us-ascii?Q?oG/l1dzFXoP8JMwZZse/cBu5q2Vjb4UwmEdEYcXlfAI/bM58jUj/N0FKEJtz?=
 =?us-ascii?Q?L+A8vGDEaZcm8RrVCoEegVa8iyyD542O38zwk6YWprhLIvbaM6spVJmPeCFt?=
 =?us-ascii?Q?Xm4cpqjpHLTfGIquTHwUCq9f8IhsvHc5s7W8jaeMaRAqtmjS0aWDirwmn8xh?=
 =?us-ascii?Q?KG7ff086aygfyCpgCs48GDvfvJr9coxUURULYFtTxo27QbfuPlGjTjhOjlAy?=
 =?us-ascii?Q?HzvRTMKisvn4keyC+bN27uIkCXOzstcS72oVkso0PhP+NnETG0WbopZ1Yg9p?=
 =?us-ascii?Q?WzZ+XK3j2j9F0Qd8NC/4kbOzg6v4kvXBr8AJ0M6OtMZ4XdIxI1AQ6Q2EhUWF?=
 =?us-ascii?Q?jA7vEgBov0QbOftEXfuvWigmMyTfy0RPXiZAry84uH6AzSIh1han9n4Miuk4?=
 =?us-ascii?Q?KUlbLUx05pqL14bp/TchDYq7mEwO1aQ2CIMVQvccytkoHjQpEb4E+EvjPYW0?=
 =?us-ascii?Q?o8QGlv+MqxUNKOoGn0/E3EIzTsq6V1QqOvpvUTFZJbybMce0r1mOFS2m5/bC?=
 =?us-ascii?Q?XjyCTOqJqn7g7QlkkqqvL73ZugjyKEnQxWwpj0f7t33+TTgZ92VU9yalTgri?=
 =?us-ascii?Q?swTma0fxPdIvEERF938RCqxsY4vpnNfzew2zTcInPw8QT3JptZ+ePGl6IYUa?=
 =?us-ascii?Q?kJfHKZuv0tSDAYlrOz8KlvYPQ6RHwVkbitlAlrsSfr193kZ1ukiKZqfIaO6Q?=
 =?us-ascii?Q?Z/ss5mp02HJku+TbwL4pBAe4bDEdTap47+j6IDMnwd8F0FthL3JSWAVwYLeQ?=
 =?us-ascii?Q?mJBG5LNEOSBB9WweXyeZfExlAor5kmDYa55bIZJtc8S3jC82LS8vM8TCC5fH?=
 =?us-ascii?Q?XWdDnu6p1YehbRucJMsxx3V5zei5V62X+T6eOeslf78M6VrCiUoGYiHfCeak?=
 =?us-ascii?Q?PYwoEch+0r19T/2lQtZM6bU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a77d1c-7e8b-46fa-e0f0-08d9fdc63ee4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:03:35.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3JOJFNCkkH5GJlKBzw3n+2U61fl/i2XL7Kg2ircENd7NOWUVykcZ1cGNioDZzGwZE5Uudg9d2EaqGkyrLDE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3910
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following 'make refcheckdocs' warning:
Warning: Documentation/driver-api/serial/driver.rst references a file
that doesn't exist: Documentation/driver-api/serial/tty.rst

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/driver-api/serial/driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 31bd4e16fb1f..06ec04ba086f 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -311,7 +311,7 @@ hardware.
 	This call must not sleep
 
   set_ldisc(port,termios)
-	Notifier for discipline change. See Documentation/driver-api/serial/tty.rst.
+	Notifier for discipline change. See Documentation/tty/tty_ldisc.rst.
 
 	Locking: caller holds tty_port->mutex
 
-- 
2.35.1

