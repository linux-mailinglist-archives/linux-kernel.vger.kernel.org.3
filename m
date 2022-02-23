Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1944C0ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiBWDwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiBWDwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:52:41 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300129.outbound.protection.outlook.com [40.107.130.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466224A3EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBjUL1HrCg93LEJzATG9+WlQEqn/5B3PM6jscHDwynSpWdxfaaas5vS0h0Wzf4a2mq+0e3TSQWfM5/kCTxqgXdH6EcA3H/cLWJ/ivpDIAR4cTACJv8pzPiaGpN0TZO8tYVXwha3bb/5KtLzP674xijlevlUfHkKJzhlEO5mw3WEk4cPOj3xKW0L/QOhqEud+NvqrhuLYacNyw/J/M/V8MzgZ0eCGdlylt5XyzgamjLUIirZyJZ1xvFKlx6zrIivdM5Zl/1boHQe7FLa9RUQoSwf5lfNaYWLsdrHZUbaSxijnP8TzBFoCFBPsSXL198KwN4Z/l+L+nWFUHI4HpUqTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENnXnIhZO0Re6+UZvuzCybiCI9xVspYvEK5sHiIptC8=;
 b=cfa72jRsJ6VEDqSdPta6WmQXo0n+GLreo/MtfAOTHYr+BJjJWrLTiLAnY1mYMXg6TcBdLrQuO805+5l12OSiSu76A66qZZlKsmMrg1SqvOd9AYJmaxpncjza6zH20Ir0z3ma2IWokVzCzQp4wUXYSYznUoILog88Nx0hpkfRBqNZjfEdSK6472dZAxubTmCLHwp/lWoyjw0N8o57sPV0U6RAAIuVMCj9RWnUnSxZo1oTdG3yWZ6fOtw4mwAizpz4ULJwx54tGqg/itJpxOuI3ft/BX0eGsNUk1oihoC66SJJopb1+yIqGF/6Q3paCBMEn8KRkyPMZX1RgtdqJmbnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENnXnIhZO0Re6+UZvuzCybiCI9xVspYvEK5sHiIptC8=;
 b=pNNmVoxWiHxiGJlo/BG/sksIBtVIF1YZ/PmFArqaof01u7kxA6puOXBhYjXtafOh0LFh79YGfu3W8sOC6rYetC75PqPtxPrghb9gFLW/JM9PimHXYnc4IT4WFrpBB/USCvJAMUKcFFgPfH950jcqXlBaFxM8E1CVuOVl+Mp6+wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SI2PR06MB5292.apcprd06.prod.outlook.com (2603:1096:4:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 03:52:11 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:52:10 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: [PATCH] bus: imx-weim: fix NULL but dereferenced coccicheck error
Date:   Wed, 23 Feb 2022 11:51:45 +0800
Message-Id: <20220223035146.412499-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd820b8-aad7-4b4d-1dc0-08d9f67fde40
X-MS-TrafficTypeDiagnostic: SI2PR06MB5292:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB52922C8FE4BCB5ADAE614FD9AB3C9@SI2PR06MB5292.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py9DDKJCQ/DtTXfdWcF/oRZnZ/y5LCCxtZVzUuvcY/5Mj1b0JKtY8sbUzjXuM/ZqwY5V61HdzJl1lRM2oSccStoX6BBXjQHG8kC08xTd68tYBT5X2dvaGTGhxIA56WJV8Nhb91MiVMBPBlD+z6uJ9nTFZh14DtFpErO5ee3xDWCZoz4PcTWngyK/D4Mpl0EKJXI9gVN2++SV0XuC4xj2yOOoY+IPTWcvsiJnrpmRiPuk+aZ5yBx4SxZmABeTOPmTHqekbKwez1fc7Fa17S9VyszQ/eyv8VY3brDNNZ+0ZmwZ40RRziNod9ZVHInSecdyPY2mnoyW/S+vpHcdV7vaE/ySkbZSYhRZU3sBN4mdyUO7GutX3/s34gnTVhYUgWt4o/zOVwDrbjTsluz5oBt+13JCmSmLjNT3Ih3TxFTmYgmGIpTT/SXyj3cmekCBmV/bOyacNPyBI4OfHQ45hc3uAN10ouVT8EOmLT1/w3mChlzIkfwVoOun2tFIRSMX+V/QZpUhHiqZqr9oRLGO+CARO3o58ujYgfNaeJpo7Bm+k//7Dr7yNSJvUN6LJYStT5xtdA1ugBPeGgHQfqLuWC0NCj47752gAq+X1lG53azL74Ro8FfcIWSrcb5T8GZ/w3rsa1uCI0Z0/P1SW5pkr+/8ED9SOnC0ogg3xsc5OZZp2AnWK7IySq4hrEn6e/HSdU5xUsXlvd6GT0MdPXHMneU9ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(4326008)(6512007)(6666004)(6506007)(86362001)(508600001)(36756003)(4744005)(2616005)(2906002)(186003)(8936002)(26005)(1076003)(83380400001)(110136005)(316002)(8676002)(66476007)(66556008)(66946007)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFT0+UtG+g9QLJ5jzC5gI4ir5MLBuCavIihrgnJsXX/H6geo59riHQuzXevC?=
 =?us-ascii?Q?Se8LAnWNZoaSTuT/aPX7pjfjF562VXizTR9VxtQJICjPJddIX7Fc0JUjdRIJ?=
 =?us-ascii?Q?5wUnrEJ4lm+Ux1HSS2rhUWwJwZGQcdeifMuo+IyA+61Qwl/3JyylLa2JroBl?=
 =?us-ascii?Q?O39XglfPYlRVbGz8M1ABmogolfSUwTFsHKG0a6r0KoM2FvWH9SZLoWhGTIGJ?=
 =?us-ascii?Q?qWcHUffD7qhQdbmDL9Q2YeXhjSZOlAQxF6QuNu7wnT5QlD0vfZCizFqoqiSu?=
 =?us-ascii?Q?smDn2G3MVwlDNYyXyE7ffqjOBu+1IH4uuwDOozwpOK9fuux8USR46fCxqgSM?=
 =?us-ascii?Q?CNRWnjc/irB1Jznma0ct+xGZGZ1TCJg11yTMzSSW0/ITYxdOOk2nOETWyuIC?=
 =?us-ascii?Q?OHvLw627eQXK+ZCGd58KTlLlM7+rHfxlik0JzyrwCN2iqiFVOQfmmQByCVbt?=
 =?us-ascii?Q?VGun493dZXzkcWROzC/ioJJSqt0w1K2oNZIk07qlmPzqv6st761Jd7IZMw7/?=
 =?us-ascii?Q?upTjJtTllIaBT56JHwNNpzOr2p0dESeA8xAQp+QpQVPiTmWeiu7FFBGJhN0O?=
 =?us-ascii?Q?CVjrOfBZsp4XiRmPRuCriR0XylvHMb52AgqlYYeP5Bn/5BRSu2jHWR5OnPKS?=
 =?us-ascii?Q?tP9C/AE9IxcHIZhYDRV1bKUnByYrTxnw5hmfkdGBwoGRnBgssvO6VDfEaM9S?=
 =?us-ascii?Q?r74wNGCzKip08ZV24Idt5WO+57UOkyMvP5+m+O7QBXkB6GPsKYlJ7Qm9lEDG?=
 =?us-ascii?Q?cIMhAL3nLwVbNBN9sHhvLVNiOrp+PSzPi1vvyGv+jOOTH5oiUaiknvbzg4XZ?=
 =?us-ascii?Q?MLeqmxhQ87FoUVkbNfAUvvw/2bOBPGgRVcL5uZC8nSjCHeYAtS64BIDZb7Nd?=
 =?us-ascii?Q?9i2KNh8yr10+QWhuDBVbqSqSuLIEqWfdnwKcjMqxcBmtn4YQQcjBR6VmhMbu?=
 =?us-ascii?Q?VUG6Qbyl8b2FI4zMAYBn1ws0CA8SLiTThayKRHhWHBQ7e80AgpzIoSSBbTHi?=
 =?us-ascii?Q?cthNfTr0+KRGZUqryemghWGQZTwUJYmUoH2Hrqb2QXhjC/N99xVn7DgAHGGO?=
 =?us-ascii?Q?3+73Gz0n90pEefqUhsNm7JWkgOiQ3tqBc5QWihugNBcNj0qURveCT/0cqaP/?=
 =?us-ascii?Q?HriP1A+0OZdM7adPUT7XiEZxWlHdwPDFC1YEFXW/3FiASw1PmWJa1thw3AA5?=
 =?us-ascii?Q?puHuJ08XibiKi8tyKgJEU2tpikBetJ6LzWCUPPGfbJZzRxZnUpxlhdXP9znS?=
 =?us-ascii?Q?wsAj3LpJTXcdMfuvD7o/5IUJ+cPTeBagh6xjT0NOgDD5eZ3JixCKMIWg0Dfr?=
 =?us-ascii?Q?weyxB7R1BdAJtOUlULGUsKMblr8L6b6+zON0IhioXsZkv2wg3DQkmWeH1dYo?=
 =?us-ascii?Q?BX+Me7PRRvyEFBmAtlt544V2wxuns3/FvQlwSJBjFZCNSrQsZqydmptuGPqs?=
 =?us-ascii?Q?1HmjSX9Ov5obN292stcr+ckRzADn3RDuJICB6GCTUiOBM9txGO890n5kdRAL?=
 =?us-ascii?Q?eQeR3bJoPJ0AamzLAmSp+/nEt3lMW+KrSQcAYxzLM57tr4DZqUh+Q5e/DP1Z?=
 =?us-ascii?Q?LYet/4q+9jc0oKGN+suZVf1N0+J2jzmDGIfdhkcZFR6Hsh9ey4ni6c7Ti8LJ?=
 =?us-ascii?Q?0Z21UQU3gUzah4joQpRiNTQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd820b8-aad7-4b4d-1dc0-08d9f67fde40
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:52:10.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUPWy78xX0df9TTq4cs2pJQsHn6VFWmtoIGWw93fDwjsPGLArgTs78sh+ABeC4KW70ri/TkPg1rPGBZdlq4aAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5292
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/bus/imx-weim.c:355:18-21: ERROR: pdev is NULL but dereferenced.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/bus/imx-weim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 60fbd42041dd..2ea0a51f79f6 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -352,8 +352,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 
 		pdev = of_find_device_by_node(rd->dn);
 		if (!pdev) {
-			dev_err(&pdev->dev,
-				"Could not find platform device for '%pOF'\n",
+			pr_err("Could not find platform device for '%pOF'\n",
 				rd->dn);
 
 			ret = notifier_from_errno(-EINVAL);
-- 
2.35.1

