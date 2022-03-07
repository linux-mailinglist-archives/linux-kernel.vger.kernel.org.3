Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E934D0477
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiCGQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCGQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:47:37 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60079.outbound.protection.outlook.com [40.107.6.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F68939BF;
        Mon,  7 Mar 2022 08:46:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX8NdfYtWlTAkxeo5ZtUCeGw7zEpT6VOavDCXKXqHigyvalnH8rM5WyFW8ykfIfCsmcbRLmtfs4RGclrvmkNDwfj/wFfJrfSCfOwePj4yZeGKozXc3rJUDbhR0QgM4aczEUb4pQP5Ti3dAPHc8pLfkFdQOEI1cUuPY+G0L2C0iWB/C0Q116pFCyh0/PtGvX4qZWj8kuos00iFfDUZv3dNNGOt6N58NI/wvJqelBgHrQvKEGk8izaJpG0bc5hj8QNnetoJUla3DbXj1V1QoGOS4iubVloDdTKZGVzYqvqBz7Kl/JSn5MsXc2be2PrzyEU1f8sisLr3f87gJBWE9y3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAJ7aAW2whZ8dBfvOQXuFr5RJhVOcEDbH7lR6In7huU=;
 b=Zrh8vCIEwB/YI8q7Z+UdjG7p6WAc+p4d+Dh5WhKWGrxM0QoJtPEqsn8dbOUi3w2x3Jh/AyUNWNrIHe7jg9hii6Ogxpu7NghKRr7a0UOj2qvHzH7kgKZhKlkpX3fdyNIcwf5GcZ4pRRIrMQvKR+aMBrqEZhGL+/TN7ADAW24GR3exqkXsJa07sULqvPNhsZmPdD8hBwUC2g726iL/ZS8yillC4lx0AmIgJzH26HYp0PYMrdWVtBQ2dkmxKnBPJ5nLlOv9tmgb8dLP/5UhC2mqUtUwECLFYb0jca6f4/fTTDU8FZPbX5kcCsqmhttr+aPumbjQX2LLsgTQQUyBjRaBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAJ7aAW2whZ8dBfvOQXuFr5RJhVOcEDbH7lR6In7huU=;
 b=YlWoTbTdratHylf5yn54EZ9Zw+4mZUEJ4XmTzdhXxJ5wsKTqdsY/GpIlhpRmpvF7lZbu3xBgpnnFIVQUv/WphmKiRXpbUnhQvNuQawRdF6D3FtcZUxCrlCF9IA6nmVOyNivO0irCAK2uR8SByBslenFgaIQagsAcDhvDbDYW6tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by DBBPR04MB6201.eurprd04.prod.outlook.com
 (2603:10a6:10:d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Mon, 7 Mar
 2022 16:46:39 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:46:39 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: max9286: fix kernel oops when removing module
Date:   Mon,  7 Mar 2022 18:46:07 +0200
Message-Id: <20220307164607.18258-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c07088-668e-4a25-bbb7-08da005a0cf1
X-MS-TrafficTypeDiagnostic: DBBPR04MB6201:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB62015D42639C20A8881A0D34BE089@DBBPR04MB6201.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPjcxLB4F1zDV6FoWgxDIpE+g88oNiRb0mKw4fmw0vk3/LdYNelprAnXuIRkn0ogPVdeOwhkZejUHvUEnG9XTlZgpCBU6PU4A9eB3mHcQFxBY0Fdd1iwJEnRHuHJ5WXQq35XQRBLz7WXuu0wO8RHkfTzcoxupJX5BiQSBUJh0cGrUg2Sd1tnMwOO0LhROLyCN5Zx+b/8oAFKRXuVTMdIf9lE6aiFdHs1hGs5vXZoZEXqIBIqnFhM2mqyuvaTbVTeUGPojhWL8ZLStGUuO4rahivYp1vQf6sFYRKFohnnmq5/Ar1Ig9Jrj+tDm1AetF9bR2zPxjf0l0cWdI9nDinDV0zEVIm6zqL7969Y95tWQ44KnjE3h5hOopl93brilzT/F9GZRRCeR742BKJ2BdmTfrHLYCJcnX92/N5TFLuoRLZxXDeggEHwUVnLuiZTSnZnS35iyifo9PAuB9T+7fBAngRzhEE0kTP04sBnMFUtC2ZvZstsISWp3+IYxEvYV+wkzPUgJ4bdN0TVniJEmNx4GZdH/c1Ri7drcNLtbAvE7R4V23tRK27icQEZhnUrMGXmX3PXJWpL24FjXr9dTMYL+D8qStH0rMOaZpUWzWK9ryOlXcSpEKNPt+IhlSN3PHHY+1ACP53BQELUXY+bB7/AkkyqeLKdtO50JcXhjFpLNkBwa/27ilX9y9C5mY+a9Fb7OaSyRIVxnTt6CLjGuijXXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8676002)(508600001)(45080400002)(38100700002)(38350700002)(6512007)(6666004)(52116002)(6506007)(8936002)(44832011)(110136005)(86362001)(54906003)(316002)(1076003)(2616005)(186003)(83380400001)(26005)(4326008)(66476007)(66556008)(66946007)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKR7TtJICg1j6JsadAH8aJpktiGAMR1S1qF4PLBb5Fj4ZL30z7+yjS7yrmeL?=
 =?us-ascii?Q?fJ0Anzgt/bwFeL1dQOCLF9vicngGjdoHMxXYCAXN22GVykD3ntlE0epasgqM?=
 =?us-ascii?Q?A8JTS+v4oiXBmA+Hr2jwxBntpJNI+kYXcXiITh+EZ8vkL0HNj6yaawRTp7IK?=
 =?us-ascii?Q?lZY56ChYs4bmkiTIGQk/C5IoFo+gSQwCpKDQLUD1IedJbYULxGlgubJjdMFN?=
 =?us-ascii?Q?NMQGS+vF83a9JFNgjb/us5ccfqZ1cadIcwFyNPDeQJoEgF6uBdmQUo44z+ob?=
 =?us-ascii?Q?DBb1HMOBuhdvVszQ0MnRGB1SRriggA2tl9kel4FWWMTNAyIOw1K+gaWskrGY?=
 =?us-ascii?Q?793lJy1y9AC2ffuuiB+AzbkzqbLVyq5caD0Mz0w+JEYadVyv7CMUiLuKOAe8?=
 =?us-ascii?Q?pnwgd1UtoBNZli4e1GuTOohmNQjepezE4xO8ol2K3h1G4qLcWwqc2TCypjJi?=
 =?us-ascii?Q?UdJG5yofT8f2j0ny7RVX48gIiW2hgeRQTzGr91j4uViq+sog+cZN83glM6f8?=
 =?us-ascii?Q?jDasXL3ZO8ubWQZJBt/5pjJGJvBhMGc5AkcL/VNZMT4TrQZWXIB2AHjYkP7Y?=
 =?us-ascii?Q?bXCHjHA8jFjs4ttNRdPRAJoz5OeDfV76iN0tgXc2WPoOppfTWW3eTKESW/pC?=
 =?us-ascii?Q?O3OASx6NWVaaYibpVfs4RZXnrAvY+dHY6/Jx0G8pq0Lq84v8pDRsZfwDc4k/?=
 =?us-ascii?Q?ujQ7ExnC/0fWwr/nTbAwaqxKWFRj/Pku3Hxu5m8d3Ba4YEtmznkBupIuWTMu?=
 =?us-ascii?Q?2E7s4yfkwbZT5fTQBW7Zjt6XEe9MN8DMaJ5sfSy1pU6Uih8Fdzih50Mecq87?=
 =?us-ascii?Q?5aqaReJldMTLwgofViiP0x0/db1PK3eLefiBUciD4avx+TU29k85YsaRbxo6?=
 =?us-ascii?Q?VU4N/KdPTlS8uDO4BzT62rBSq7LIav3o/IKdzJ7LkVCoKZbhV4yWyU47KWqJ?=
 =?us-ascii?Q?r9BU9EVAtZJUXO2wDFJ3NVwl48s6V2D/PuUXYU+49zaWQXqKg4sKmaNxofZg?=
 =?us-ascii?Q?3YgrAoWzhfx92x+7o73nGSZm7UhrUvFB8TQhZcYElVueiRcn1d9yBhZz34jU?=
 =?us-ascii?Q?MhvbmACO/hxc1DjXwLvRzdwpV4qSj2gx5guDpPpKwbGgha7A7WqOS94DFxDG?=
 =?us-ascii?Q?kficoUS9X7al39v19p5tCrerMRU9L/RtVT+IxtrcF05YUGNK1SK6vMmNgKqp?=
 =?us-ascii?Q?Ko8LK8NXrNmPDu3+oQ1ZKn7vYV5JSZwMGaEdzOreyxVL3vSoJGmE9zXaD1jK?=
 =?us-ascii?Q?6L343YKhoOthoGKTPqeWmV/s+gwgw3AsNSNfvWW+/SS5JqRBNJevHbzdV+rk?=
 =?us-ascii?Q?Xk5LKDsePBET6E4v71FHWQzhZjZAAqayfMt0I1XOnd0julB6VzdOKPLjjlbz?=
 =?us-ascii?Q?7rH/YdMrjqiCA5D2VxFoOraGc4Us4COv0RNxcV0sHE5lGkBsoXe5PtIhAwmZ?=
 =?us-ascii?Q?1kprIsM+02BBGuQkjP25ABuCoV2kj7jAtWIzdl+h62iDvaxDopzjJrTgGV5F?=
 =?us-ascii?Q?m+9WVHdWKO8BC0HlIJGyMPaKldKgITv7yWPb2r3OaEDoxbwFHd36StDrtAru?=
 =?us-ascii?Q?1E7ggqmlsZeFkP5UV5NHJLnN4WqTSRwrOxFWRPm+HsnxfzZEQo9Fg9oEdqaG?=
 =?us-ascii?Q?/0iVku8Gei7EVidZWRBpjgo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c07088-668e-4a25-bbb7-08da005a0cf1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:46:39.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGo0T+xcQ5u1TR68PmXvJHa9q0CvmLiGHdXVIZxfV6BGOWLF/59E2KjvZdCbjBXjFjOCizz8nZAriSKl0YRb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the max9286 module we get a kernel oops:

Unable to handle kernel paging request at virtual address 000000aa00000094
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000880d85000
[000000aa00000094] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in: fsl_jr_uio caam_jr rng_core libdes caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine max9271 authenc crct10dif_ce mxc_jpeg_encdec
CPU: 2 PID: 713 Comm: rmmod Tainted: G         C        5.15.5-00057-gaebcd29c8ed7-dirty #5
Hardware name: Freescale i.MX8QXP MEK (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : i2c_mux_del_adapters+0x24/0xf0
lr : max9286_remove+0x28/0xd0 [max9286]
sp : ffff800013a9bbf0
x29: ffff800013a9bbf0 x28: ffff00080b6da940 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffff000801a5b970 x22: ffff0008048b0890 x21: ffff800009297000
x20: ffff0008048b0f70 x19: 000000aa00000064 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000014 x13: 0000000000000000 x12: ffff000802da49e8
x11: ffff000802051918 x10: ffff000802da4920 x9 : ffff000800030098
x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
x5 : 8080808000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : ffffffffffffffff x1 : ffff00080b6da940 x0 : 0000000000000000
Call trace:
 i2c_mux_del_adapters+0x24/0xf0
 max9286_remove+0x28/0xd0 [max9286]
 i2c_device_remove+0x40/0x110
 __device_release_driver+0x188/0x234
 driver_detach+0xc4/0x150
 bus_remove_driver+0x60/0xe0
 driver_unregister+0x34/0x64
 i2c_del_driver+0x58/0xa0
 max9286_i2c_driver_exit+0x1c/0x490 [max9286]
 __arm64_sys_delete_module+0x194/0x260
 invoke_syscall+0x48/0x114
 el0_svc_common.constprop.0+0xd4/0xfc
 do_el0_svc+0x2c/0x94
 el0_svc+0x28/0x80
 el0t_64_sync_handler+0xa8/0x130
 el0t_64_sync+0x1a0/0x1a4

The Oops happens because the I2C client data does not point to
max9286_priv anymore but to v4l2_subdev. The change happened in
max9286_init() which calls v4l2_i2c_subdev_init() later on...

Besides fixing the max9286_remove() function, remove the call to
i2c_set_clientdata() in max9286_probe(), to avoid confusion, and make
the necessary changes to max9286_init() so that it doesn't have to use
i2c_get_clientdata() in order to fetch the pointer to priv.

Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
Changes in v2:
 * removed i2c_set_clientdata() in max9286_probe();
 * refactored max9286_init() so that we pass priv as argument, not dev;

Cheers,
Laurentiu

 drivers/media/i2c/max9286.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index d2a4915ed9f7..3684faa72253 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1147,22 +1147,18 @@ static int max9286_poc_enable(struct max9286_priv *priv, bool enable)
 	return ret;
 }
 
-static int max9286_init(struct device *dev)
+static int max9286_init(struct max9286_priv *priv)
 {
-	struct max9286_priv *priv;
-	struct i2c_client *client;
+	struct i2c_client *client = priv->client;
 	int ret;
 
-	client = to_i2c_client(dev);
-	priv = i2c_get_clientdata(client);
-
 	ret = max9286_poc_enable(priv, true);
 	if (ret)
 		return ret;
 
 	ret = max9286_setup(priv);
 	if (ret) {
-		dev_err(dev, "Unable to setup max9286\n");
+		dev_err(&client->dev, "Unable to setup max9286\n");
 		goto err_poc_disable;
 	}
 
@@ -1172,13 +1168,13 @@ static int max9286_init(struct device *dev)
 	 */
 	ret = max9286_v4l2_register(priv);
 	if (ret) {
-		dev_err(dev, "Failed to register with V4L2\n");
+		dev_err(&client->dev, "Failed to register with V4L2\n");
 		goto err_poc_disable;
 	}
 
 	ret = max9286_i2c_mux_init(priv);
 	if (ret) {
-		dev_err(dev, "Unable to initialize I2C multiplexer\n");
+		dev_err(&client->dev, "Unable to initialize I2C multiplexer\n");
 		goto err_v4l2_register;
 	}
 
@@ -1333,7 +1329,6 @@ static int max9286_probe(struct i2c_client *client)
 	mutex_init(&priv->mutex);
 
 	priv->client = client;
-	i2c_set_clientdata(client, priv);
 
 	priv->gpiod_pwdn = devm_gpiod_get_optional(&client->dev, "enable",
 						   GPIOD_OUT_HIGH);
@@ -1369,7 +1364,7 @@ static int max9286_probe(struct i2c_client *client)
 	if (ret)
 		goto err_powerdown;
 
-	ret = max9286_init(&client->dev);
+	ret = max9286_init(priv);
 	if (ret < 0)
 		goto err_cleanup_dt;
 
@@ -1385,7 +1380,7 @@ static int max9286_probe(struct i2c_client *client)
 
 static int max9286_remove(struct i2c_client *client)
 {
-	struct max9286_priv *priv = i2c_get_clientdata(client);
+	struct max9286_priv *priv = sd_to_max9286(i2c_get_clientdata(client));
 
 	i2c_mux_del_adapters(priv->mux);
 
-- 
2.17.1

