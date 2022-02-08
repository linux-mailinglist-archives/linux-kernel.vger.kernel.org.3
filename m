Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC044ADBD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379107AbiBHO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbiBHO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:42 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1BC06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKQIrKk6Ul4+E/eaPlhNHS3lvTgHuwMF9gOcBp4iatTxefqV81QpJ9fj7YJvB9jxJzYLtn87CXFcrxcA8dOLsBT0FDQNehedbNdcVkchE/lEzrqjBG8tyEqCBWHgv2l1gFHXS5TVx6k/+76eiz43/5qCK8L2ubdJkmsAWFFjkeu+CX5R4rhHXmnvl596ez+J/evJ+Y7sz660DvhUjaz52c8hOFklVwRyPaTbEo1Wuytr9RMk/3T5WTJ0bfBhiZGxb+Wc+t+vlcWm+m/frOjJ1yL9sdfh/IczpFTs86kUvaeoW9dQT+RhXhPNvcMrg8EALHDKFNp5I46wCTgMewwCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEuM3YgEWeSsvt0p3Fvd4aWbqb5k/DDi7+HQiqQHn9Y=;
 b=OdwiJ6Z5kwdnoLS8ZrYFiJZYFspDQNwLzQxHTLEzYJvdWYTNM9w2nR736qdxVOou8NNcwXh8rLRB/1x88fvBW/1Eryc82MV5IxH+D28fJ7+Q8AY7sJaOnv0jR6FMmlEKssy603I6TGzCumhWXHvfNwkC5SDjDQ3FPlrSYzszvFeVXnOa7zm56qP9LG5RJCpZYkZPk4LqAsnQDRGHEu1eSiQ93UP4grAy2ARq8OwCafNKuaOIf873cDHIhUNa5UzEron747Tbacn1bE3AfI5s4YGPA1YHESCtlOaaVR5EukziJE+GZn+eWk4+A22cmhrwYEy/TbV/a6CaF4PxYsFQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEuM3YgEWeSsvt0p3Fvd4aWbqb5k/DDi7+HQiqQHn9Y=;
 b=LWMtDZ9l9oYFofL5kEtUnGhwzma5g5blPGn/RT0KTognQ8p1JjpFYqZQFd9CsmNvxpxGVQANf9D9ufvb2iSf2KoU6raUUOaBtQ0RW6/axTK6MpWJuNM0/vN0yDAA6OHP4zwxnE8hzM2JiZVCmaIp+Bm2QN7ND328fb+xOxm8I0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:39 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:39 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/6] bus: fsl-mc: drop useless cleanup
Date:   Tue,  8 Feb 2022 16:59:23 +0200
Message-Id: <20220208145928.12468-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d62104aa-dfc4-4bcf-bc6b-08d9eb13a152
X-MS-TrafficTypeDiagnostic: AS1PR04MB9381:EE_
X-Microsoft-Antispam-PRVS: <AS1PR04MB93815C889FE06900877176D4EC2D9@AS1PR04MB9381.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiZCkghGTHu6yI4yynmWBKvj3gSD5A5t5W5TlNpM+N54scpLdNnd0DLSzvIsczf47iINUQ5vHBh4Qh1uI/EeC/7kLZrULIEe62gPZruYxcJ9QJPu+bBoxQhwLAWwTtWFvyZtPLlHUAkIQRQIwo8NbKVUQ/GFqcLP2z4jusn2rLs25gCQs+nKINRQiLr0EZNpSDq3Bqe9HtDMOwNGIxLw1U6ZpnxXmVrgY+xBQu3c7nwJGb9UHVHXKThirwlLuhm08aPK3wt0qf60h4U/4i6Pu33CGb8PtSeIPdEErxlXYlvEhlii5zowWODOftB6MsNXpfx0hWn2AqDR9g365S3f2skO2Bz/maEPj9SCB47ADJHoKwtE0ie9/6LP7bTlvZ+HP6IPq/wBvmjeXxrHFenVQFqppQW5gHZu/OIDn2EYo9DJ7DWckGBMOq8J1ziNe0oQODN+AyIxEYuQsKivrq+f5x5HCHfCu3Zqr00YKjKspdXkn62Lo8mVsi8gikoL+agBtVDrUNf5x02j//XMs76ViJkBK9CzceG0cpIh/Ld0hQWxOizyv6o7XtqVtsIj3APDGEX+GNH9oQBuWkVPPf+Kt9yEuySMOTAGic5ft0dxt56pQJxPNaU79hlpabGXvfw1rXiij8OKY+DcC+UETnVuXitSax3DIQDQ9b6fRsjpmkJVNEeRKcny+a/p2GfEbNZGSVtyq2NuGBGBFsojBkdj1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6506007)(6666004)(4326008)(38100700002)(8936002)(83380400001)(66946007)(508600001)(8676002)(66556008)(2906002)(186003)(36756003)(6486002)(86362001)(2616005)(5660300002)(6512007)(9686003)(26005)(1076003)(52116002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vJhwT888Z7k02UTpQwYqQ1O49oiXT9ZYfRUP6i0daFCoUyMN1bVhO29M9tQ?=
 =?us-ascii?Q?XxSPgscSdQ8tttbx3c7ai9duNwrADpMJbpCSgN/ve269GU6MnfVib6XA8bhf?=
 =?us-ascii?Q?xloxWkdRJnat0ltBglFFGTRW8UVlI4rDLhlBqZU0u1QVsS80sBiULCJvDBDd?=
 =?us-ascii?Q?fCaU7/crpeyHdhbV7Zice+4mLF0ya8rHUenuHsrBuqD/o4dUGtUvzwEdcDPJ?=
 =?us-ascii?Q?qwukBVSm+JG75SKbpnUTimMXqB7XuCNjxBFHtuNqBbarB0wMKj1qYHswhazU?=
 =?us-ascii?Q?PfklNz4Sb8bMSBnP92+5p21RbvK+Jc9aEWIkXfWO4YOphwgnQMmL41eGob3k?=
 =?us-ascii?Q?c489kpGREkWGp8wCxyZ68OBB8nEb2TYLNqG7Jjf9lTMPPNHC7dlxOVHFYxhQ?=
 =?us-ascii?Q?SAheOgeYDvz1M6mTRBVoERXb7mBqxnfLI3HqJkU+vZLcvo8bI25pPUFphpsh?=
 =?us-ascii?Q?3D2eX3J71P2gFPctrm1fL8KHv6vVoHtxC5ysTinVzR30Fccp/ndmU+Zr/h/7?=
 =?us-ascii?Q?5Wzu4xxcAzgaClxJmaROJi2fHyruR+3VYD3byI0zARM5JLaQE8JUJV044gIt?=
 =?us-ascii?Q?fTDYVIfJ0qQP9UQq5mt1iJsE1DmODmCIQ2oZ//sU0GU4zA6h19i10dVENfSp?=
 =?us-ascii?Q?xBddMA61qv8C9jEZZRSQ9dQYruNhVdfETY0ntUpzoEwDyZHrJRnF3fJfRL30?=
 =?us-ascii?Q?LCvX6eIeWGEuhHKYMz+GlcRQ5zaPB4r17WhnrFeXuZDQfUqIpxI/nW+JlvaL?=
 =?us-ascii?Q?TYesNMWBESH0nNjwrNMerPnuA/ocqEzlYbAaBgLsaXC2HvICNd7GiUPREm0x?=
 =?us-ascii?Q?KNh1LZS+JcZF7oJwgEi3VZnKYr6Mcf4j7zflSZBkfnJcVqsQfKcA/N/OSTkA?=
 =?us-ascii?Q?fT27SNbuYzlBd319Ynk1pi7//qy3UF6zme/IcqJ6WM0sITBUVfG6jiKQ9K8S?=
 =?us-ascii?Q?lKcxWTu2mN/pNnw4iykLYWvzcMk4gZLGJv+XJklnh/ALrQ3jm24Mhtqd3fGU?=
 =?us-ascii?Q?DACT3lN4zxeiCT7L6Tvirh6gXw1BDw/3K9iEFkFABu36Onv1Sv1Dnkaniqq9?=
 =?us-ascii?Q?TSd5fbYZnzN3CqugFOD6AVhp/fXRXWbh0JWBGh53+FSD2TJLiItbYn7TAOkP?=
 =?us-ascii?Q?XfZzQ61cIW1jbcbzINIyB8wT3vIRV2Oh/npmM3b6mU1tY2A7JMkCeVW6KXgS?=
 =?us-ascii?Q?YAjpua6GjQZ89kvrGXNxZ/QFmOV4RVFZlGQzLnnrZuhr1xKpNcoWYO/0upj4?=
 =?us-ascii?Q?vGiHpOENSQ/M9rAIUhl+zRKsdtwYD9NLdLBmdltZ8JtnfT7Xa1yedd7Q8Pl7?=
 =?us-ascii?Q?UltWRbWVfVEYUk2tE1MC0mm/IBP3pCsCXNZ9pdGDs8kVDW9k1eArB68qN/aR?=
 =?us-ascii?Q?+zUyZasQo+q7zQyNjwo2S/vP0Q1o3O2hNUEq4C7DgXkgWP7qvG2ZUZQfxZdy?=
 =?us-ascii?Q?42tGRK275dOuaHG36/ABhbCFb37/tVnRQwVcIMwLTQp54z/Tc+E30dQIZHqa?=
 =?us-ascii?Q?XfxC6M+5T9sfXvqeHe/7JFnqHvixJyt5WSB3JR6kwWMePvk3zKO6eovcBNio?=
 =?us-ascii?Q?RON80LG5EcgNncqqNj/8amDCr+9TzhATczfUwakVFcXsmIwLZnRWBh8Ls3tG?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62104aa-dfc4-4bcf-bc6b-08d9eb13a152
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:39.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA/dBFd8emr15TlxAyPBDaGh1K73gZHM5YxKTo5jvvv1TwgZ0gaq38SuQKlFKre/nEwt/WFxfTqHYTsgUy2Ohg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This cleanup is actually a no-op because the resources are freed when
the device objects are removed from the allocator at driver remove
time.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c      |  2 --
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 24 ------------------------
 drivers/bus/fsl-mc/fsl-mc-private.h   |  2 --
 3 files changed, 28 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 5e70f9775a0e..36681cf7c42e 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -801,8 +801,6 @@ int dprc_cleanup(struct fsl_mc_device *mc_dev)
 		dev_set_msi_domain(&mc_dev->dev, NULL);
 	}
 
-	fsl_mc_cleanup_all_resource_pools(mc_dev);
-
 	/* if this step fails we cannot go further with cleanup as there is no way of
 	 * communicating with the firmware
 	 */
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index dced427ca8ba..9fa2a8c28a2d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -549,30 +549,6 @@ void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
 	}
 }
 
-static void fsl_mc_cleanup_resource_pool(struct fsl_mc_device *mc_bus_dev,
-					 enum fsl_mc_pool_type pool_type)
-{
-	struct fsl_mc_resource *resource;
-	struct fsl_mc_resource *next;
-	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
-	struct fsl_mc_resource_pool *res_pool =
-					&mc_bus->resource_pools[pool_type];
-	int free_count = 0;
-
-	list_for_each_entry_safe(resource, next, &res_pool->free_list, node) {
-		free_count++;
-		devm_kfree(&mc_bus_dev->dev, resource);
-	}
-}
-
-void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
-{
-	int pool_type;
-
-	for (pool_type = 0; pool_type < FSL_MC_NUM_POOL_TYPES; pool_type++)
-		fsl_mc_cleanup_resource_pool(mc_bus_dev, pool_type);
-}
-
 /*
  * fsl_mc_allocator_probe - callback invoked when an allocatable device is
  * being added to the system
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index b3520ea1b9f4..450af2bf7de7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -635,8 +635,6 @@ void fsl_mc_allocator_driver_exit(void);
 
 void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
-void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
-
 int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 					  enum fsl_mc_pool_type pool_type,
 					  struct fsl_mc_resource
-- 
2.17.1

