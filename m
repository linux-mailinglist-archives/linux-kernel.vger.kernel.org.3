Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7694C6130
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiB1CjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiB1CjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:05 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C1512757;
        Sun, 27 Feb 2022 18:38:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKSFJ7k9jBRw9Cn5YLa4kmrXuft8SnPLi97OX5PXIOfVXY+3H33dCt1AnvcUVWT4D6CUj1KWR4skXHZNydoGiu9UqWRwbPDra1a0BkqLnhBV+drtu4qkbsCsSzJfoSYr0XUQT2OnDADowhKVdfAXy8WsIMQdgnBtXHSXEphRoqP3Qnq2tMvqk++ncPu0HGKSQyStyRmD9y6x16gv5S7/2+64CjCiWYicb5YSWTrI9Pv9TiHTpqW+bifuxNZUOj3aNvUCGJobGdDTR5WNwY/v7Baeq5u0Zuc0pJVI1BsaNetSYQc+nxE0Xz+lzd82TCfx0psZQn4uVIyrZO/Soifzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKIFsIYacI2v7HqgY/cfWmZ2LsB5hFERdNIV5XWfBLg=;
 b=myxknbP3pFozmcJHcNVWKiClLZZYGcoinWWz0Hpof/Wn0x330fu1+B9Yg8v3AarEdxqcY0eZ6kKpetWthvQ61F5EYVm/4BcU7n2o/zOZ9qYFTCreE2AV+KPGiGb8H985BJNfjDRIRcSUL9TeFxS3iX1ZZuXoutpLQ07rbZftlU6yqF2zEaDOlq5HAclWSirV4IZGSsfPKMrUEdNXWMDCyRarxXVINpIQPcrmBgL8IRAB670WVw22WB+yEfV40ldBVlaz/59U2sX/6SZbtg/gNT2yrhFs3T6gdH8kl+ZVsnWADIWToAmyry9nAteHDzZgbtJJ9nUVtec31HaibmFKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKIFsIYacI2v7HqgY/cfWmZ2LsB5hFERdNIV5XWfBLg=;
 b=LWR6bJ4KfcC/QSRf+TUpQpXssoOAKiCcm5IZpZPphu+yHnVV1C8LGo/x8zvxZLspi+LAAVi6xinv3ETXL2RtdChmor7nUROxQhtfpoGqSSytYBAjGEsCTHUccxsGfJ1B4gaKckof/nGan7NasRLdEO+oRxThy/x8bOzHaIe6bcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/5] mailbox: imx: support i.MX93
Date:   Mon, 28 Feb 2022 10:40:08 +0800
Message-Id: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c36f8b-9694-4389-599a-08d9fa6363f9
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB87208976668D4B24543A6332C9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3MfyEAhEyZ45ddcY7X0gpRvTxudXubRGLpDmVEuem/eP5SwyaCKTK5bHJ9XGv5YitIxFbGfWNoQk4079V+4ih2c+YIv8Bt7nntLCg+dhMHbJppFgukx3f5ok9yDmpkA4eWPCtDLK726tMMjSnBqdJcjmcxe5v580wy2RIKbOzRDOg+334bWGKMiEvz52cP51uhcWHS7IOrMdU2KqjdySEx4HkXFpq0c/5AVOmFFyO7a+8/zXknGwNyS9WvfNMlqQFV8wMYv7vM28ceuvM1u0vVpuvGAP1kQW+pcI7yAZadbMSD9/stcWqKUVWtts6Iam12FZQrfstMSj49Rxz0l+2EOJ12Gbpo1HQz3pyzMBe8bqCCcjSDIzdPQa5yOKVDUYFuH+F37Dczyrh+q9Dpg8QQv+lspPUmlpg95F7hRbXJsW4wN2Ip4KLCUuxs/1duwPFgE7YlfFTi/Y1SnWfsvUxbK4MCFqvrzg9HUV73ZlETJg5UW3skHdJIr7wUFFDbg6PKyplELEnw2mw3Ej5lqCxE4t/IiseIkjXKYC3RuulE8hrhhtXzGrq5rYmTGRV+NQt6vCCBakJ6T9ZSKmuBWil+Ma1yP8jv1xml1asvB0RvM7x073YBOzyN6k0uq96ziAKoRJWc8JnnDeSucIvuaa5PyPiCVjLyTixKHR+++NyZW6+q+QWgiY+/V9axzwTY/puwMeyhMc+XsGEROPLb7/Ywwm20UmdzCwvr3d7BQaRufV/6Tud2Xs3NuhyNwnGrb19TujkHNsTkZ9ORC8z7VHmXrd6q7lgfFCf8n4rk3HG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(966005)(15650500001)(38350700002)(38100700002)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6oDXFjbYlF7ClgopK4rYqZifeO0D49cnMHnVsvgF2BEoH60wLUEZetzbdO1?=
 =?us-ascii?Q?ca5xY3MVULCzGq1jzTZwro6XnueFFKkLB1arYxhDe/wtxLPwoSTV5XqGe4yb?=
 =?us-ascii?Q?wfJm3iOHfyQ2+C8KYf9GQFDXtvXvJREC37FcjWQmV6Z7V7t7wKrnwo5aJJvU?=
 =?us-ascii?Q?A6lt1jtephJ4/GAD1NIzqOGjOfolbewh3j169zPSAypo5szPPepRK5VMkPO8?=
 =?us-ascii?Q?TCsE0zIZGIXizxqU92qFTdLZ8H27j90VjsfHWCRN8QRzi0ViVJFRdtUAnuFE?=
 =?us-ascii?Q?/cI/7aZhaABmXPSzEOgXA/Zrt1CwEDL6V3OsRV35l2w7oVi6883HfhvThahC?=
 =?us-ascii?Q?0qhIXG51mCy12tk0Vff+Qa3cfwz1mE9iE9Ab+cQPfVnS6z3yLYcg+gdiLHMm?=
 =?us-ascii?Q?DSrmCXQu1gr9i0D/+MzeDn+SOC5FRILUyiUF5i52w+PzqYN+VDrIrjkustWR?=
 =?us-ascii?Q?0y5G018AkFw6CrrecZBN0kNWDJEXrfm+RkFxIe/tkwHjCbdlLBGaRaCsXxJL?=
 =?us-ascii?Q?33krkOe7AcbykRQlOU04//VgG8Z0Ph7YRmS6sA+Dat2Ef/1Cafswa1Tr6iuY?=
 =?us-ascii?Q?Puws+80rU4SLlKnQ6NubqUQ40zKJWmoZjVRaYi+C8cFWvqdxKCaKQl/WD7qA?=
 =?us-ascii?Q?2hGez2uPEhd9gEFTCvTHqjS5pEfjAqnQ8p8+VIiYARTaVJn/Ru4SaCd+mRQq?=
 =?us-ascii?Q?jDx6YQDw6WeyWci+5iIOOJShLfGQwZKmbHeSQ3DbwbLAaIype+YyabO2uvpO?=
 =?us-ascii?Q?K1naUOg9rFm5hfqiLCXIGzftNB266E5PO8clscq7zFN9VkmDDXuc1xRj18Dj?=
 =?us-ascii?Q?9Zg95Lu5NtdMzypu5MQfJ+QJzqnqBKuhfI4zpajzO8ixTpsj3LmVLUjjC/Yl?=
 =?us-ascii?Q?A4Yfv+rrTrRK3r/SvZ/cC3uYaREyi09sj7sdD67WNWUfz/jD0AUsA4SPD9a8?=
 =?us-ascii?Q?cl0AjMHd6PQWGalt8SgApTG2KlQcPxyMIOwx7O0xbuJBtE991k2yv2rT46ZR?=
 =?us-ascii?Q?RENbe/2ZqD48PRflTS1P3ko+Ad153KIz/vp2jUasfKKhqFt91124puR81l/h?=
 =?us-ascii?Q?gVzs35FTLbxv/qHd179KEJPfE4RCQGU2mzGQj+vxlJWMWGBvRODUUeID38E9?=
 =?us-ascii?Q?/72gyV6tlR1a1jBghWRi7+F9cn7LC5oyYTmeq9DCcO7XVBCVqoyBMzQxVDv3?=
 =?us-ascii?Q?alpl+xFqoIMm74WWcXlguvWOH7ICH7UAdt2iFSh2l50OjzOOu//3FhYu4S08?=
 =?us-ascii?Q?Q9xcNe9W48+5HU3aMKiM3tEqSChlCJzUATmZ5OZRFSDuwHnzEHVcfFwJDAj5?=
 =?us-ascii?Q?OiAdODFA/rhfgmsQClD/+K/VylXi+IaEh2g5Oe/QKEzpOBChWfCBYGVd9V/y?=
 =?us-ascii?Q?EHOGzu1C2vPDVnMHAtcQYT5giA1zmJkc8UGSBA09tl7uaCgRsSLmE/DvYLCS?=
 =?us-ascii?Q?Fzoja60873UM0S+f7GFZoy6tcA49X5r9n0WYId6bvGUIFja7X56iP0bKx1Jv?=
 =?us-ascii?Q?7fR8v1iCwNYXVcz7iOHBLFfo4OW/h/0PbtfLfyN4CTctHOfMRJI4alX8uLyu?=
 =?us-ascii?Q?cCn+tnva7jKGwG1zarTjThiP76IeP8yFnw0QgszRdbZohjPi5yPWunhGVwNr?=
 =?us-ascii?Q?5i+TMGiEb5gBfiPttLYUZig=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c36f8b-9694-4389-599a-08d9fa6363f9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:23.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WmJMAutFM/dynCAOGGt5Ri+Pf8kMwIs0l4sSWhvRHj5rNm2A30YGRXARFu6k/cKcGPMzYanI9NxJbyVFtpsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Per Rob's comments to patch 2/5, add minItems/maxItems for interrupts,
 Use minItems for imx93-mu-s4 interrupts

V4:
 Add A-b for 1/5
 Address Rob's comments in 2/5, passed dt_binding_check and dtbs_check
 Use tx/rx instead txirq/rxirq in 4/5

V3:
 Add R-b for 1/5 2/5
 Split V2 patch 4/4 into two patch 4/5, patch 5/5

V2:
 Fix dt bindings in patch 1/4 2/4
 Squash author/copyright patch into patch 4/4

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

Peng Fan (5):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support dual interrupts
  mailbox: imx: support i.MX93 S401 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 31 ++++++++++-
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.25.1

