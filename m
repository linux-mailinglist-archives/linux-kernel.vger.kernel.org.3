Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B24D1873
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbiCHM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiCHM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:57:15 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31247541;
        Tue,  8 Mar 2022 04:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzpCg4K563SctIwj3GB/yCjmDauAvhH9gsAkd3wP+Ws17pEEVFfrUTEFW/Gp+dWsUvqVIS2ehekCv64UUbhbUcKx/nA6ERLEoACZO8BvKNa8poRSEscUhRQfLDsC2K34efXTJF7AeQhvg/lB2faiDIAIFuzDIM14OpKbY4s73bDRe3BrzCjdo5bC9TYyjQFsJtiKabl6kwOeBnmjG/B5bI4rqjs0iwkaWlpMjM+Aod5DMcL94sZJWXsmcTOL5pSORe91hne79EdRQcjjdL7WvWE+mT6kZfYT72lmXHBMP9IG/9lL5qcVB/QtVJ01uO0JwYqTnf1ak1pr62AAmAMdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbCpnfzk/F872enxkGEhcaZfijUUnqIig0Nu87oDU4M=;
 b=kT5NPco9nt6xJjzz0BGUdAcskkpFT4Fa6M1abRAq3ETfl1C8VkskBJcJ/jiJHl6vjypiEbl/a8mXyBHM6dSDiMtjxaKIibfgYNohQci6iWWqnV+HJXaFduaOdEwcpj0iM2MwIQ47bAVQN/TRh9gncl7QXZ4RDCnvzs0MLWTbJydQMY5JcOmoqLXgEl9rV9ZSKpiaduKdZ3b/zBoNr3gxL51MqKPNpugRDIOCmSemKLZS8TEmfmJJ/iGIriWNLytR/xDgjPxFYH+wPHKVyqg8KYbiZe8tb1GPaiY2/RPVsvfKk0Q1HJe8X0Yseurzt1jzMF7GWGkyI1LSjS7leu6pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbCpnfzk/F872enxkGEhcaZfijUUnqIig0Nu87oDU4M=;
 b=JJzarkYX00u+VzXkfVmlBqlRg3xOOVZ4MVWt53IAFieAvA2enwCJ8lBnXe6Mo4518zHbTJSghG0HeXFPE+F06KLYcjgurFW0gNm8XEsG11iTyT2xwsZ2zDMf1rsVbnRBkR6N3KWWgQYk/lcInShz7frKHG2Z4S9sVlSzOxeqi6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by AM6PR0402MB3813.eurprd04.prod.outlook.com
 (2603:10a6:209:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 12:56:14 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 12:56:14 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: rdacm2x: properly set subdev entity function
Date:   Tue,  8 Mar 2022 14:55:49 +0200
Message-Id: <20220308125549.9676-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM9P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::20) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 245efa32-7c6d-4047-2c2e-08da01030722
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3813:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB38132FDDCA0D72AEDC91233FBE099@AM6PR0402MB3813.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ytvx41Hio3y0zaDSYKVEYYBPUMu1YfbKWcmASjLmJtlda9PD3VDJi/8+7bHSonO3LsUsA6j2krAeUIE4wzWV2e9qL5QB0khcicAWY+C1cEoM42ij0AQzkI6ciYELzFulXMD9HFkg2/jt0tv9VTN55St8Cq9aIM9aUKLim4ABc1yaEa5AUfCTku1APRGeQ65b9VMpLWmMJSxPZ7gw+nc+e54IVMkntUg0kywuIcMSBS9xAGKsOCuRxx10K5VKOoujtHoCRSBap1gRRND9OsllyAjAUC/5Ef+BxlG2NWCZB3PWpvqmuhhb8ZYr+8vmnlktN+fcgpjbr6EQuv2mlW0vpdq0xqTQW93uETY8hZ6Ayk9eNzamO0PyEb1dimUQYI9pjoSkOkbZ1u+rA46Ed6bTPRuPSzt5KeCpza7l+hfqe3iAC8obMDN3R+6dEbKbNhjBcSr1q2N704ee4O7X/OotsDX+Nr5pUU+KJZ/GzUZxlHCttg54a4Xerc18ITM8Elhm5D9Do6mm0G7Hen2wUIxYrxycnCBpfLLHPZlutLn91GgHP5SVzedWL6+sh0p+xLyZVwMMyiFhciXyi4agBScinBJKgBXi4bEw7PvnZ6yZDTsB5sGYpHaaBQQoM8cXBpohVVgAs/+Kk9g81XQm5p7RkmW8L6o0rcA9WegAm0khHVApNZkNNkMEBLbjZ0pZjXa7xoP6APwOFruTxjLXuMp5bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(44832011)(316002)(110136005)(86362001)(2906002)(66556008)(66476007)(4326008)(1076003)(66946007)(5660300002)(8676002)(38350700002)(8936002)(38100700002)(6512007)(26005)(83380400001)(186003)(508600001)(6486002)(52116002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6oHxBQjmjFOh3+sAKlDPg2UoXNAy12+9M7mOW4gHp/2pxsgp9Yb7Yf3fWTd?=
 =?us-ascii?Q?E6/cI+LbFGoVMcIqjCcB8QcsunohI5gwIfHi7DqHF4zL5RJ1ahK0/ZU7rn3l?=
 =?us-ascii?Q?qnRqtwnqmZwdwYhGQFIBoUw5cN811i4Tj5L8RL0uHwB+L2vVA5KA3s0ogNcR?=
 =?us-ascii?Q?mgWnPEe6gM2/Q0dXQo/xZf/v5yabF6iaKhXqlAOrsl4i+cc1vdO2YHbH3fZ/?=
 =?us-ascii?Q?PXisonfMHxfMC7tLERBdXV9/SYI6gNXyS5rIe85DqHwzH9uUzwikrVTIIO48?=
 =?us-ascii?Q?N9+0MJAn3G5TmI6EERzFBZBAs4nPoI8Di9iExZd5fdcE8De4ULsGfptnHvbd?=
 =?us-ascii?Q?+QMLaSkEUreki8U9dylfyOcjy3TlN9bsr7gCyBr7eZZXcqOEFX2vMItC2dz0?=
 =?us-ascii?Q?e8Ast9kpMv96X73/LMVQdIdrxiCEH3TP8uIOyyFx4PRQxmfXjD5K4HoHOHgS?=
 =?us-ascii?Q?M4tQ/NtiYQ7B/cFY/b+SYwOxzaO9G8aO8YeKKFZUanGca7iXsHXbUL4rXVPW?=
 =?us-ascii?Q?AT/nfnntxDu6Tia/0OPGVOgqr2WXHV9hZlgoQckSyfl8Mh8df79hzFu2IPwW?=
 =?us-ascii?Q?DnGEhxIwnGxOwkpyQBanD4n8+3ZkxD8CoX5tvT7DLta/C9oc3EioEVSExhH5?=
 =?us-ascii?Q?bgxTYWmJj/LRjcJcEzo5tshm/7IuPFChRnYhrZowlvv+rXr41NWyQ5yuv8MA?=
 =?us-ascii?Q?zZmpj7jaMxUxV6YC5wb2xOMukgowbcg+m8+WmdSpMNh5Vg41pNlPF/qC3vex?=
 =?us-ascii?Q?vMBIofQnslkWtK2gJ3cBY1GSrgnjE9k1xQO7fj4hIdnPgBS9Pqihh8fB/Dws?=
 =?us-ascii?Q?g1LJTyvCO+O7x3XExhqFAQYfrJzz1/48Cs08bPSkuy5OBrOR0HwSvrcILTtI?=
 =?us-ascii?Q?oD7x363fOWHLzI7bgapDstPd/Jj6N9pnmD3fVyU5xTYKK8buz94KxsJ6GVqF?=
 =?us-ascii?Q?rQ4a6/YPHSTkEnJngaPCEr2wlK++Qenw25501MXYlCJiftA1H0wE28m8Zbu2?=
 =?us-ascii?Q?x0Vva/qYQAB/nHW/ykdFTUyqmpUc7qNwIhNUYbtkoLgQlbaRr9IhY8L5Jh3E?=
 =?us-ascii?Q?qsQw+H/kw7P7mO/KOlHSVELG0THkbswn+Uv+OMp6TXYbf+SwlSuu7c3L+K2c?=
 =?us-ascii?Q?fWNQfo5Cu+Czy6Hk9o4Ya7fmaALEAfxFNNTB32jH02Hf5ooOTAXyPYZivPuG?=
 =?us-ascii?Q?e/2HATbpWnlDQkRj6o/29cFZHiWS05QHVIObNQjIkYIHGYmaYpvelFqez9SB?=
 =?us-ascii?Q?RbSjStYYiICn7WxjLjRGB2Kw7yMO+8y6zyZJjLP6U/qBbjFQYVIl2+odOARU?=
 =?us-ascii?Q?IFd0QPjl6494dJepVbWkqHK5XQhsk7ONwXvWGFNizezCixPgFH8heMZBTSkR?=
 =?us-ascii?Q?BPpij2QIOlrMv0uwRXT8m0YrYjxNuo0/Rt4AvonIAGVuNcjr5jw41kL0AJBH?=
 =?us-ascii?Q?FuEWM0BJJN4Fu+bwymPnjB/WYX9iLWOpjArjBuAEkFgehZFWpzFUtFfnK09+?=
 =?us-ascii?Q?N/FIqXTsKfrnrYfWyBnzxvOIvb/GMl/juQhZKGrJsTyRJ08/Mn5+9f/xZqmg?=
 =?us-ascii?Q?/vXt39v0e7pEydJXAxXhOi2vKrCSSIw3E751TyY/VXrwa9XnUK/QrDxuhDTy?=
 =?us-ascii?Q?V92SOHYZ0cN807D3gQxJQZk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245efa32-7c6d-4047-2c2e-08da01030722
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 12:56:14.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHMN4bbbiCEU9soogf1xkpw1vCMgYumUti8wfufv/DPygWysXi/qomweRm9i26Cv3UzwQoU0gVONUg1KM3S5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3813
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

Also, set the entity flags to MEDIA_ENT_FL_DEFAULT instead of
MEDIA_ENT_F_CAM_SENSOR which will be used for entity's function instead.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
Hi,

Only tested the rdacm20 part but I believe rdacm21 should work as well.

Cheers,
laurentiu

 drivers/media/i2c/rdacm20.c | 3 ++-
 drivers/media/i2c/rdacm21.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index 025a610de893..ea5b7d5151ee 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -611,7 +611,8 @@ static int rdacm20_probe(struct i2c_client *client)
 		goto error_free_ctrls;
 
 	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
-	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
+	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;
+	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
 	if (ret < 0)
 		goto error_free_ctrls;
diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index 12ec5467ed1e..be89bd43e88b 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -583,7 +583,8 @@ static int rdacm21_probe(struct i2c_client *client)
 		goto error_free_ctrls;
 
 	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
-	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
+	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;
+	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
 	if (ret < 0)
 		goto error_free_ctrls;
-- 
2.33.0

