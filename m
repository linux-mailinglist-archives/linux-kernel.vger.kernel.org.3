Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A4D003A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiCGNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiCGNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:39:23 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508702F020;
        Mon,  7 Mar 2022 05:38:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQn/Wo0FWTrJ8Ky11rCcQ6GS1yYQ18AxAwb6nnb5AGJpVqWrxP1svZN4vdeqj1N41Lt9zxQUz5TXPIBBPOqO3Jl9D1unEZx3LUocaNKHqIPoIAormxzdNEh+BQVsfqJbqhbswS6ZtByFXmFNHNCWF6SKkm7FD5z2vcau0qHGE5L/Ld6xXtqEuvE+qiHK9ovNi5kU4vlnFDhKy1tKuXpK34m3G6ntmcfYAicpddqGjO//NghP42VxO9D71qh+Cq1n+vhwtT5tLv5/pf0ezcv23/3lX0UIRtcbzLc0l2+UkCGYiwTDR16mHy1Ys5BvYqr1PY0JG8bWq9C97PuKyQt4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS5+HYf9sklJH/I6BBHREnos1ynYhWuUKYDqXhj8TYI=;
 b=Z7yOnrhw4RYlqzLouwR3PytAJofo5IzH0S++0+zk5g8/3ntXX3yLhPjzgg56W4msR/jjCBp/BreIteEx2ucwflbeTNWz0ELM12gg/HdB2q9z8Xreya4r7Ms8YzwXc9ryp3ds6yw8iHeNPyAAfkeewO18cBAcVxzPN6YGR7+C+bhwVUYvvJQElkVOILRocvDKU+ytCNpZJulupqIPplhC5KPzx6L2FxKH9wfz3+gqdR8TiUtb2q7YIxGOHTVGK0dA2jvZzo5pPpoXbCzvBFqWXdSkffNteqvKO6bziDlOPZpw6ynwWo9Q9tMPJDR+7llujJAK6XqCQF4ImaNR+T7cYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS5+HYf9sklJH/I6BBHREnos1ynYhWuUKYDqXhj8TYI=;
 b=CppAmLEorp9GOl1U3gAPVP8fpGJk5E1p8ZnBb0FB/QJOoYD8evb1cgUj24KjoTDtA/FMhXnt6xseJv21fLQBoZ3MVEwWuE1/7LeFxcYM3zYZlo+GrOvTmjzAb8UqvOdYd2zmLHuytqqfMAtvOjabj+jkeOub6pL6PYapCaDoMOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by AM9PR04MB8828.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 13:38:25 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 13:38:25 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: max9286: fix kernel oops when removing module
Date:   Mon,  7 Mar 2022 15:37:50 +0200
Message-Id: <20220307133750.29708-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:208:be::38) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf93bb45-da84-4bfd-13cd-08da003fc0ed
X-MS-TrafficTypeDiagnostic: AM9PR04MB8828:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8828CB0B204C9D09F430CFA4BE089@AM9PR04MB8828.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMlQskFH/HUc9vzTcdc5pk6lWXsnMDyhSBiEuxSpMUeY59CD+YLNwOSeZPXrm3bWoF3vNdOqxWt2ITpZ8lz1pJcrhx+bXyKtUR9WVjcZxdnCjIAVcH4DerZsjY7sMPpLSbZTZv/PUQiSaAo8WrHuyy8JWnQemYl05a4NuJkhE1StuHOOtqf2nSMP1OKxyDqVJyG1ZC2lj5gZvR3hyflQk3QbMBu6IS+vIAApipJ7UcAeCllekTY5jiWGt0bmiqmrCgVZGTLelStEcykKIsPtCoHb2Hm6KiA347trMBUT2oxlwrOgquiV/kPwv0atpcF+6JzIbp1+0PvK9K3CWWnu9tI7rqBcWPo5RR5VCNcb6bds2LuQXIlgvHb0EZy5HiO6A4UIgZCu8VICK4A9SthKQpKcipoGdim1t3H5obluQ5emhvo5NLzkuE3SFqKzFRM0D6pFAHet8DpSj0VToctciqrsSnJQsz/xoW3LdEyF555P4f9NYeWHNjPQy+7wOQ+s5V3eZUXBnxeKuOuNuteL5wk7p4zl96KL++GjpUKPUQLRkEMA71xQHzQq9P96AxbvjDKIIcqLCGoXdn3KkxhuZ7XeaNhOxZhL9e/8Qz+VwGmZyaTL+VNwAagUy6+cu2erLXJLL4hgvZKMUbQtXb2pNRaG6x1k5hsQ5ixeOc5LJ/u8oc/3CipVnJ5XlctnTBXKrtihdOemxU2JVonnz8vpVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(26005)(498600001)(66556008)(2616005)(1076003)(44832011)(4326008)(8936002)(66946007)(83380400001)(86362001)(66476007)(8676002)(45080400002)(52116002)(6666004)(6512007)(6506007)(6486002)(110136005)(38350700002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OpK4vcghtGIyXU4JO1VBLAdh+2OUYOIl2NGnV9aduZlQYOEEvcc6t+lzVesZ?=
 =?us-ascii?Q?np376IzfwR7qe+52UtwVp2hr6g1X4wVKGfm/lfteA8oJylCkjUlvvzBvkyRD?=
 =?us-ascii?Q?edDGqkYIbum8lw5HCbdKRZydhtsXg8/v61Ja0CNM04BGilEx8oByWbV28UB+?=
 =?us-ascii?Q?JqKEUs6LEHgSwGhPdWZbxXH14n+sQLJcLds1On/vEf7uHPGcAIaeOWa6AFwO?=
 =?us-ascii?Q?iNoBNfungslaPSY5BAnsR9sUQsUErdv1FN7uSVyiNjFgzGvYM6dO/vTqSBnN?=
 =?us-ascii?Q?q79TU4z2oAnwP7bWfY+q0mrZT5rW/zyEEmKiq6TThhlB48PSbM4RcI9qsRJ1?=
 =?us-ascii?Q?eHwHCXueTdA3Ub9ntKVypAjgln18Ps/GCKMoQML8Zo5neRVt66dQGv2PVas9?=
 =?us-ascii?Q?uCle5K5Hj62TV0JT3fGAQOn2zEa/QxbBvdDP6DkYBTCNT4yxXFeWWEp0lqn2?=
 =?us-ascii?Q?IbLSUSusEHbloPbDYfMFxKMtYBe8yKXv0HB4CwCc1WEQTwJfswlKAlrmBF8z?=
 =?us-ascii?Q?2EXJeHU5g+g0z26xu718uM8tUyusa2rKXfxM63NBoJSD86YpaFw2NhMtdoc0?=
 =?us-ascii?Q?MjkI4UD3RnSW0VQ7Ne8ICpjvr4V9VCrXVrbBQWOkJ3ewim9hr8jMnnvV2CRh?=
 =?us-ascii?Q?7aTKn+aS6seRYcXkzxhckdmdw1AK3OFhUYEFK908sT97rA9lPhWrve0tVTVF?=
 =?us-ascii?Q?KTxYJxjjAq8Ld8UAlg0Me6LJuHwf4UPfV+jfh4fJ6df+oX33b9vMFSloLdzf?=
 =?us-ascii?Q?wtARXo/mSrSYPtnXv9LruQo8u47pvAqY4EzY33iH/1uxQNwCMph8iABAof4f?=
 =?us-ascii?Q?R3nu3Zgnu/I6Y2+a8WdQdzlON5ofJZ/hAQvM8o7Oiw5MGE86o3UUfWBrTzU3?=
 =?us-ascii?Q?j/orDa3fBkzvYfUaAVIbFDUHnR4YBP+5io5+kILwdWSIwLw76QoSDmFPZ3BX?=
 =?us-ascii?Q?yD7lbzIiCKwKFM+X+i5RMCFP0L3aU9RJsgPbfHRchu2ojNKEIWFnEYo61nD2?=
 =?us-ascii?Q?psiYTlRb1jGo7zWSt4gcfgemgG+404+jhHKi8fSXDPY2H6cPeZ5Kqdri2Vkt?=
 =?us-ascii?Q?DotQoONzkkPnRk2f6/p7x2exg5Y/M25nWA58MxyPVA0eby7LXcVNAWa+81o6?=
 =?us-ascii?Q?EAxAtVdybx18pUSRbu8u1NqFy/oovCkt97aW5MrMnzv8Cu2VkF6Q5g+rWrHC?=
 =?us-ascii?Q?G4I3/7O1/vijwj0Ohb/m69ULPkjt46tybgoSurwvKxULDSL3agN7W1XrzwQG?=
 =?us-ascii?Q?KDrQQjhdbZMAw3yiu2EId7cIEk0mHn1UVHxI+sIRUsJepiJcVcpRvbWLgJwm?=
 =?us-ascii?Q?bMxoz2WNvUd1ZdgP9HHx/lhxj43CAqsyRpfzUobT1hj1hDjWE1cnYOUsWt9m?=
 =?us-ascii?Q?Z2UQWXczk0ZqgYeto9MdY/hZa/OLUoQMMDNN3KvLUK6Izj34vlMP2pl560WF?=
 =?us-ascii?Q?w90mRPk0VzK+7Ek0DDvo6HcYCeyWDO5foNAF85swCT1wPSK06XBBxDM5FJZ8?=
 =?us-ascii?Q?eokmZm45lXWpGOWJ7dmARWPy5qdUEKKXUKIV8uOPkw0hrPcsq65tRhYKmbGu?=
 =?us-ascii?Q?28KHbJsjnK7eYq3gMkp54VYbopX+SroVsmQNTaFGkiJET58w77dy6nYMyjJ3?=
 =?us-ascii?Q?7vxQNWiOmcHuYiLl6eXza28=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf93bb45-da84-4bfd-13cd-08da003fc0ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:38:24.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbHiKQBbSQ5YD6FpaAVwN5E0jR0DtBR7JU4JBcYWS9Qwsh3d6PDfYILpNYI7McbSqDGIzXvkROjNGgR4KZT/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/media/i2c/max9286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index d2a4915ed9f7..04f5b7e3a9e5 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1385,7 +1385,7 @@ static int max9286_probe(struct i2c_client *client)
 
 static int max9286_remove(struct i2c_client *client)
 {
-	struct max9286_priv *priv = i2c_get_clientdata(client);
+	struct max9286_priv *priv = sd_to_max9286(i2c_get_clientdata(client));
 
 	i2c_mux_del_adapters(priv->mux);
 
-- 
2.17.1

