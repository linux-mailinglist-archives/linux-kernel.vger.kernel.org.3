Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29B4D2E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiCIL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiCIL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:56:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005763BCC;
        Wed,  9 Mar 2022 03:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAfWE9u8t6OavVZ6LDbRt8tA46+dflD8wsyMGUimUG8M5lC7u0Zgi9FYbgnN8xWpjIp7V7BuLWH1lWdjGLscNCeeX8pSaNTA3PTPu7YM2Bat4nF191UH6yM/PEgt77iND51NQp61Wa11gvxjRFBN7924iZ5/SASymFiwizRGskO/0DMy8WD+ZO6EfreBhSSlIfJhh+nh8YNU11g1Rgz3pC2uzMC8lQvFHunL66f8tGPhyXDzq68s82FytqI+IP+32KKltIaeKJ9wg09JgJnZnOc0TTa0sBHkBhzCf+NZgNvkjlArOtejnesP/QpLIMPfscejnrEgPyXa7f2fDKBblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL7lQVxPlbfbqMey7JFczo8/deyZ7JtYUShjct9bHw8=;
 b=PMnaKkN3XVz64Iqil9uSn3afZkuTBRP4VxHzan+cN2UYbnMW5L1Q/u+xmP5Ld8YyMTldufOi1tgv1XQnAakjV4iG1upLKX+LkBbFLfM8OpX9J+jref0osYSClVcXbKgTbf4pTPyPL/3riLil0cawbUh6+tQ9l5nlX6UJhbQwLFh4xbi3gEabBLNyYSYx6p4iaYUQOxm5FbhshGQL24U8vej/eckkAVYufMvN3D16jD6JPa6AoDiZFVfGeLrMGTU049sAu6O2RTNa8I1n6ARVs6zkfmHptzIMKN0BEG4uikANb4/OvngZx2iMA4QAFznnEHK1W+YcSI0YCHckJLDwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL7lQVxPlbfbqMey7JFczo8/deyZ7JtYUShjct9bHw8=;
 b=PCgFTaauB3DZNMdET9v+IlJPU0MIoBShr32JK9ugcweBku6BvJ0lzFSi3GbrMTqj4fMnGO5kpUQaZJ8XaSEEKx1F+QeC66bLRquSmyntnmn8g8iRPAsgY+VPAqYL+Q/Ow6YRf8d9z6P4soGjtEwkwuDrmtymOjU1vpnCVRGXzTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by AM6PR04MB4613.eurprd04.prod.outlook.com
 (2603:10a6:20b:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 11:55:26 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 11:55:25 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: rdacm2x: properly set subdev entity function
Date:   Wed,  9 Mar 2022 13:55:06 +0200
Message-Id: <20220309115507.30019-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::43) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd87c81-553d-4e13-e662-08da01c3b2cc
X-MS-TrafficTypeDiagnostic: AM6PR04MB4613:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB461373BFE040D7DD1A43F1CEBE0A9@AM6PR04MB4613.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4v3DGXiWpAwnbTRR+e/1ZtJ+lFRch1eV6AwU4Niigt72hg4o1RO/sOlMkpwFztwcHGyVzfFE57A+ZcEI9m9bTQ8UJ1+RPj41gCWJbW8oEIaEluOMdfOI31JDhuE+oXUCof2AK6of2kt2EDBf8/riE9GavJjLayAYN8yDWkQLFsvbLLHsq9U7aOX/nUuwixWQ0WC5I7DsIVs5f/LfFo1SoiH8TbGZbP3XYIeLS+v2VyF0rJljR7odT5pV1+7Kf1OCT4XAn4xkc5viIkr0rFchlnn8BK1RCBdKdwgUGRRqoeLj7OKgL72rSnPwhdwYrZLAue8+009WH0DE12CMV1Readxk7YuHUyD1YYd5XOcZeJEnqMzbRwrFQ6jPjJHRq1/GTOR5IVXBhTNW92MJGEqUV4eSY8NGxUgZrGDQb6/amkXZI5aS6NNTyKtnKlDXrKyn/F33X5Sg5GhBcIdKGg66dNUyRE5tDnCtjSj/rRsMLcKAB0NH6y2c9ND93FWxFANXGTDaWUmkA/UWYxxliqgUmTW/BBfNxzZFTDWtZwUNQ1mMXHt/CgAkuUtBKnoT9BYPT3IHKuIvdN7f9WlqGwe+O43CN6Q4ZSE+x1RXvjimWjfKAuIgK7LEdLL5nCln4xGW6FscQHKKkk471qxVlQkW70uu3rKOqHe0JGDX6tEr+ogWmHDEmayc73PxqZ9iQ05R911GU6peNHd4IvkwWVZ7hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(110136005)(54906003)(4326008)(86362001)(186003)(2616005)(1076003)(5660300002)(52116002)(6666004)(7416002)(83380400001)(6506007)(38350700002)(6486002)(26005)(38100700002)(6512007)(66946007)(8936002)(66476007)(66556008)(498600001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GlZDZga8aYYfbxB0i7N1Q8d/1vFUHccKBiRvy1hxTQxS/j37mqfNeFCj44q?=
 =?us-ascii?Q?OTu9wRdZUZ4nrXlFoQOiASqZa5HvIil4xZ4zghBszE4TXMbIls+3QwQRCciO?=
 =?us-ascii?Q?X44ZR5CQkfWo88isB38N9YAlIvzAKkvqBF+nsUhzCEPgYEnFs78XgdCxoIlH?=
 =?us-ascii?Q?E5WQlhdiONMpADoSJ/aamn6oaB9GeFc56x63fy0jnxKDQUKfoRlKjCSp9Qes?=
 =?us-ascii?Q?mbRtGsS8qf2qKUu5MEupFov18pHaSVt7whdfpjjoBhiae0GMGxSsmV6R61Cg?=
 =?us-ascii?Q?zpzsh62N5gCm1cmMFxs1oJsk5kHK9WvszzUQW0GYAhGVUS3GzyOycAJtzEvl?=
 =?us-ascii?Q?Gl5+OM07Jk4CeS7mHdpDz9Rw8u3pkPCFTSrSJANaqg6Iq6yFDYq77vHmmIB3?=
 =?us-ascii?Q?DKPYfRBsy78M2whaFnMHoiMczN1zv9C9cSEKltiDYkYbV3tEZcnKvhvLcn9I?=
 =?us-ascii?Q?w/hIP/urP8Y5l79C8KnOYBgr7pSU/TNU4IOopV/KWouM6TDuo132m9em4VSS?=
 =?us-ascii?Q?HL/t8gv/UEM+nfJaZA+a1WQFCZrdF9P+IlObntYaeczcKeFyge07idUIur2V?=
 =?us-ascii?Q?lwiEY7YlLvVin1YcJ2ZDrlWpEB6wfJP9C4ZRc0uY/ItJE7m5/bqLaBj90O1h?=
 =?us-ascii?Q?h28YcRt54nc6sfoNRCwbPnLKJmO+/Jiu+XPmQrrEHurchlqfPPK+hv2tmyGE?=
 =?us-ascii?Q?jc1NlK/udoXqWpLwz2xCUXPrXCFWcNH6yqPPh7Cfe6Wu4VRcGunr36bTZRyH?=
 =?us-ascii?Q?Q8XE6DVkDuGxHUT0b6Qj/+ZkkJ+UOraD8DhRSZoHI+4nKXjvpVbRuX1iSWi5?=
 =?us-ascii?Q?2e80Udqp3Rv+NAfotp9ba5DD72PpRFZuzN6OB1UfPsjlcV34IG84GyTwY/Vc?=
 =?us-ascii?Q?8VmkXdBk2IMoLkiRLJ03P7oSGKEhDwGoGjjWxEbVBOfAzcURKUgfJx+Hr7qg?=
 =?us-ascii?Q?yn4qrOMrFpbFnB7DPHhZCHl5Jnrm2Tp5OlsB2sjpUiubOPFqBUdKQsU3NAKG?=
 =?us-ascii?Q?cdTTB41gNQUrD1ScSyo6TVlE/2DVkJqLyqE7vtFDCE7yyypxZMfEyNBTwcz4?=
 =?us-ascii?Q?vFbqN6mfXPzhjmdbEz98EKpBDipKDSzr6OnirUmpCqefFuizxHZPa7Gk8Uu1?=
 =?us-ascii?Q?XwOnhBQno8UMwQLESjNumRpPVgXTQbRRigJ526ouRzqU7J/siTQltbwI7FEw?=
 =?us-ascii?Q?XC8iqXKrY8jvAzge/GueZMkVA5IHemgs4X3Ot31WCCdgb6WrCZzDU/DP3hH2?=
 =?us-ascii?Q?vT4zQXieQj8ntdYFUlwuBxCL8vOYEnSuJY1qCkSEQ2BNMYYIAdG6QBzLmBR4?=
 =?us-ascii?Q?g/7jd5X8ZAmiSq04rZYdrZ2AEocNleN2G6S3jjHll050ldiyjnHtdIJYcoNs?=
 =?us-ascii?Q?PoIX4AR/EPYXsB3JmpF6B1W3xbcfCK7ZNO9OXDSTQDw16VLqTuItfzPd2h8H?=
 =?us-ascii?Q?x6JD/M3NTAtOxoT1YS94zomhMu8lE+/7JfhVgPnYMBUuhIOsmRyT5gg3S/ai?=
 =?us-ascii?Q?blucVohhIezs3nHEmaU7a7c0lWqPqugoDVj/kFkh23LU5DpN6+QZV+mEMO3v?=
 =?us-ascii?Q?gFcCpdC6Jqv+CXHBOD/nU1ihOhg6gxWnipve2zGg3wu+xJpeI1v0KV8HQkJM?=
 =?us-ascii?Q?aAr/RmIG3KKv6vxqeXGIIGI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd87c81-553d-4e13-e662-08da01c3b2cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 11:55:25.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf2TS3sphp3u4HjruJ709hD/lY1KnkWbHePro8bppFNSfiY7JyVRlLO+9dyNWIc8uXoSVHSsyPdRKxYiG8C0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subdevice entity function was left unset, which produces a warning
when probing the device:

mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
not initialized!

This patch will set entity function to MEDIA_ENT_F_CAM_SENSOR and leave
flags unset.

Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
Fixes: a59f853b3b4b ("media: i2c: Add driver for RDACM21 camera module")
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
Changes in v2:
	* leave entity flags unset;

Cheers,
Laurentiu

 drivers/media/i2c/rdacm20.c | 2 +-
 drivers/media/i2c/rdacm21.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index 025a610de893..9c6f66cab564 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -611,7 +611,7 @@ static int rdacm20_probe(struct i2c_client *client)
 		goto error_free_ctrls;
 
 	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
-	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
+	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
 	if (ret < 0)
 		goto error_free_ctrls;
diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index 12ec5467ed1e..ef31cf5f23ca 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -583,7 +583,7 @@ static int rdacm21_probe(struct i2c_client *client)
 		goto error_free_ctrls;
 
 	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
-	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
+	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
 	if (ret < 0)
 		goto error_free_ctrls;
-- 
2.17.1

