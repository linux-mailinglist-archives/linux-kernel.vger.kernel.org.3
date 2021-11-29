Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440E461043
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbhK2Ikb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:40:31 -0500
Received: from mail-psaapc01on2099.outbound.protection.outlook.com ([40.107.255.99]:33888
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350779AbhK2Iia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbdz+ddUcFHbWMiBmknpQ7IrmvTUxIhVhPjAKy01QTb9/7ij6LG+aAbD0BZw+k6Sl2+i+2rVH99ZVRJOHaNsTnTKuP80TgEVCHlirly+MWa9mxjEM4Ku7Vx/QfyEd2CV3SbvaGZS2ddw7G9PbedNYcwdz2p9T0kMJXKR+rBIghv/KMvIyAMGQP2livmb4SImsJHiFR3BLnBpV3Z1yVOU4fe3Sa0YTKshha5VhjTA7t9WdCFUH63M1CoN1iUfOGGp7pnwme9uRdCdds2hTmzc+top0HGn3GuyfIt0Plr/AdqRq3u87O+P3+0LJMhmFCIfdSpZWqy04cODlaHYPEHWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKd0F/Q7lHOfTSM0Awi/wK0Yg1iTqE2umpow7yE8VSA=;
 b=RI/gjWKTIP7SRHhurC0lvOWaS24p7AVjrNIEnsfQHZbSXacPnEN52ubvW07RXmbYQGnVUPPeI6O9YbAzUlYXiIycJbSC5JLC50NTuN1Zdiwwh0/2u+xjSkxsUx2xg6KbTTzx2e77KsbbsmR5FeAPisbue5JZ0ca0ONw16hScsE0C7PgchhYh46eK7LVFBFQlZ+MDJ7LHTyMX5d6H8Q2NmpMbgyhB+s71DL6o+D/1WNQG5+efgLXm+6PBUIYFspfSlRHEIC9Xcx8hVjQpAB6Pl0iwCeQVst2KsvLQo13dC8lIZLPUXmBCeE/Ly+p6++N9PvUu+R6PzT7/yewn24rXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKd0F/Q7lHOfTSM0Awi/wK0Yg1iTqE2umpow7yE8VSA=;
 b=H3QHVyMdxIlWpV7n113HWQSm4C1PxjDpbaKkwhvI7HUGOB9AfJdPM/QvWOLDt726soSl/9u6T8+teUCyvKJ8V/edGdUHnQhM6UNT4Lq4fUpkTF+5GguERZCX71PSp22gbNZdbqTlww0HiWgUC6b4Tf6elq/Bk8P1wvs8ddjCmwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB3185.apcprd06.prod.outlook.com (2603:1096:203:81::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 08:35:10 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:35:10 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] crypto: DH: remove duplicate includes
Date:   Mon, 29 Nov 2021 16:34:56 +0800
Message-Id: <20211129083456.4188-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (218.213.202.190) by HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 08:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2e2e97-7dd8-4e35-4aca-08d9b31327e4
X-MS-TrafficTypeDiagnostic: HK0PR06MB3185:
X-Microsoft-Antispam-PRVS: <HK0PR06MB3185F201F3DCFC48B3D8F3CCC7669@HK0PR06MB3185.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8H5JCmgDu0Hfxe3IzE6prqqe3mFobHFM1Z/y0c2q9XM97E7ZHg01pylQYx0K/c0Dzm8hC0hTwvIZ3f1/TInQ2c+9SMdmLjr5admCBW/bITHe90r9Oq5/61TtqiMkhpXsMgjoNsHn1YtrZgQbFmYWaDWvLjbaEJVjt0XZAcDXN6W2cYsLrHL+nCLwfvLG3Lh1GFY5/9PFZVrcaQfbQwGIev4xDx5pBzdy4MyJplJ9W1jVq6wiynlFBwzpDOxXUqeEpA8VHRAlBTnAyXsy6a2S1+7usLaQ1cM/OxtZ4XovhNre0+xOdZyWMh3MT3RSoG8ex8+piBAgpYy3CRX1nz7LTmHt6p89/vcee9LpQLtZ+yUo+QcYshPtXnxRb55RgqBCH1oIPV1eaj8jrAXU+5TS6vfgKs0OYLBG2nVdHjUjpbHlQ7R2Q1xT+KCKsQ+AwBbEHoavIU4SaZNo4rrEBMxSxOApm3089NShyIJiPxDTlYIjuab9OLAG9h81sy02UaIr25JFX7MB4Pe3Me0PTWvY2B1rRwsPa58uEXUjcPgSTzVwqKzSyF/0jqrxlEoXdJ9ncKR1v5iMoTQZOwvp4TG6GOo8T7oJ3CxzGg7aOu4QMqHwLiY3paxBC2qRHPmQVbLnK1Gkgwody+XtL+o6uDtkvzvGgwJb3XdMiPEeuE8MUirFd9tDKHP8BGC3VTPR5AqFiGxBUfmXOmHZ5NrTU1/NiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2616005)(1076003)(38350700002)(38100700002)(6512007)(52116002)(83380400001)(107886003)(86362001)(6506007)(6666004)(4326008)(110136005)(2906002)(5660300002)(6486002)(36756003)(66476007)(26005)(66556008)(4744005)(66946007)(186003)(956004)(316002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAA8QVAXeReG3F7kn2hSbkrawIOWDOSBbwpGwsbmbOugMz4hlLHGP/IjIdjK?=
 =?us-ascii?Q?Yd8xFsj39emSUyib/TQfNEZIsXRzgKOF/ChVkZp9OLUcWlUrN058y/R+OJ9I?=
 =?us-ascii?Q?NZAcqblFUuUo23uND7Ob43Iji7Y5hP17xMVqIrn8t77QMYoa66FkGD48WOja?=
 =?us-ascii?Q?7e2uHHibeCO38mjsigaloV22AuxTlF6Tt6SXCkS7sslSMblzNg9CDLr+9bHZ?=
 =?us-ascii?Q?rIOldqxe/uL7mSta0Q3YPHX4iHZz6lP2dmGal40a9I6+xYjEUtrIRBdc+Btc?=
 =?us-ascii?Q?AfpnNw3V9OSQ8XGPzf8Z6L334OhJHhRnYgnIsw7pOBWDv69P+Oim1OCSu2ye?=
 =?us-ascii?Q?vP1WAGj7kGHmC//SUhduYfhN3zAnOKzBYFQLz+BzMkcXX6dYba3jodNSF/bw?=
 =?us-ascii?Q?CtZxEpcvKPnw5MX4NWDvBZaoQbH8O+Dye2ZLZATlGQDaYdteKEyi1MpJ4hsm?=
 =?us-ascii?Q?7xeG9gb46bAGS+kqEm65gK099VJQqXfKO4Q/7IY8FPyljHNufK4Sf72lDDsK?=
 =?us-ascii?Q?U5xIBfGFlUko0J9Ht92XgoNjB14E0+1FbX2xONzRLjXoBpCVLawD8N4DPdYQ?=
 =?us-ascii?Q?BD/wMF3Bi94i9Je5a0DEuQcdqYfCM2JnedZc7zIqufClRrQJgfjUe8hq/nnQ?=
 =?us-ascii?Q?YFuMftoBmjCOsruOYyJeeTsstrQ/ebn+SyRzsP0cgGr48zHckVTk/r+2EjNB?=
 =?us-ascii?Q?dNS9fIZ8Kdr8b8S1mFQ24DcdLD3R47UMffnuJ8RBwJwaGMJUrWVhyOkicUhg?=
 =?us-ascii?Q?0VvXZ6+FKfkyiQxOSLXEaoz72Wt9nrvPpOZi/xC1TZKneOBY3DmzrkhLLt0b?=
 =?us-ascii?Q?0cbnFnEnYqRoWjOF7COmb0Rs1gDok6JVuNA32MPKc/JeGAmEkK0WDyEYnlqr?=
 =?us-ascii?Q?f6GJPBGA4d+ek6JllX+BZBrlOvjfDLlGZNqASDdjBMqmzA2QdKbNBl9Bb55o?=
 =?us-ascii?Q?Lu9KaXrqTkZy7Vtv8LF2GI193TjJhm71FR4i4nLH8IRUT/5QYjzVuDxglTPW?=
 =?us-ascii?Q?qFZWZMniswei/mAD+9jNLtaitOAsR0KUCec2D8eoH1xUONhV86ivqlzpt95k?=
 =?us-ascii?Q?STZURJPvLPenmYw2EBXpCO+LNQdaRTGJIhGMMStT7IGEKq0gJvykUB7U0scP?=
 =?us-ascii?Q?GaQtzxhdKBg2NRCIQTF5AQKP2hbGtEYAdEx/wPRNlH6ElJ86JYieTxDXA8BM?=
 =?us-ascii?Q?lgknxYUTJ6PiEnp3eL8Ie+w2s7Fy6Qy34679+To1lK54iw6PTDJMb6beNcNN?=
 =?us-ascii?Q?GoRXCWJ+H9eZkkDJb7iDo23DYS9E+zB2vpd0BgCfvsGjNCeELF+Fgl1f7yI7?=
 =?us-ascii?Q?D5N9MyAMz5Io8smR5370OJxsRU05gORrxKJ0+atU8IJay3qz4HekDtmwGckt?=
 =?us-ascii?Q?+8ByI3WLWgxqruaBNfW8SYEYKcvHkAT8c77ZFBGLwC6ZbaTX/WJKFLnn5dDS?=
 =?us-ascii?Q?jcI3tZv0OZqPP9XHXporXwZIqrapUnCYzGBRGx79JDxrEJweXA0P5OYFFVMF?=
 =?us-ascii?Q?cR7NNIfCmO6gGIcT4fNtWQZlO1Qn+jbR5rz6ombC7SLPlRad10YxQRWhgCXR?=
 =?us-ascii?Q?NvlAQeLc7apb6rbsJcPuFR8XcGb9+fWOnx5f/w2Wkyd8P6IhKnOBkz4lrVSE?=
 =?us-ascii?Q?8Znkuzjs1fjEvsa+H0nmFZA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2e2e97-7dd8-4e35-4aca-08d9b31327e4
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:35:10.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFv3isTmvDY7MnmVXgHPOcW74T7ORIiXl5bEOYSjU5OVOGp8v9LACB2oPwW02eSY48/ssnvruRas3yTounDksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate #include <linux/fips.h>.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 crypto/dh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 38557e64b4b3..27e62a2a8027 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -7,13 +7,12 @@
 
 #include <linux/fips.h>
 #include <linux/module.h>
 #include <crypto/internal/kpp.h>
 #include <crypto/kpp.h>
 #include <crypto/dh.h>
-#include <linux/fips.h>
 #include <linux/mpi.h>
 
 struct dh_ctx {
 	MPI p;	/* Value is guaranteed to be set. */
 	MPI q;	/* Value is optional. */
 	MPI g;	/* Value is guaranteed to be set. */
-- 
2.20.1

