Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5459D545C31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiFJG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiFJG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:26:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80492624A;
        Thu,  9 Jun 2022 23:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/VuWHjGKINJqFx0hPDlTphPvE0Mutg8aRU9GFKzLEErQUD+oEYCJMVaE06Ibao8mW6nzvc8cVY8pnDIXbHjK7f5No3hlqAWB6a0B2SlyVRHhhdNpieaBZbyhold/gxwilCC+rOxj6QJICWToJwJ+E292CBwoE8JR4EcCETsbXkpW8Zaud+vxQRrx43HlCMQEtJcLt2X5/ThxdERkGvkATaHe3uh6VXPdlx9+VObDQ7TeaCEo35DETBHAgZDPIofp6WdBanHU5kCZDsm1FVc7R97Y+95d2p40tkWeMl0Z7e3HGOTxMzyMdmnjTGLpCBnubbekq0vN/RDEEcM8b79iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8zZKPcmwRxXvMsS0Gc5DSPSOLmif2cM4370/8JdRKo=;
 b=iyEz2ApexJU2jftnfKB1oNASB0IQV5QbiGEfVWV5eTTeY2OUyM/micYvK0TRrgvCLl11RN0ngU53DK5RFZjs7MtUE0QqcSjIjziLKKlsa9RwRQlATkMZKGDMgBT0kDPxXiXjAhmiuyCoYbs7ODSN+IfV8f/XnxeVWT3kPO88eCvvwS6CkOml/zhv2XovfQn6Bz9i8HKWxGrSxol6g0eGJsZtROipcADBsMdUsyyOaHI4wIK2PLWBJsLqQREYN47HTk+cS6W8V1AY34zxQ+kTNXOxM4BvhiTIMlFtWaJpAGh8e+tTnYVnvgnRva7vKoysERqnCUnQfkCTvfSaYVUARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8zZKPcmwRxXvMsS0Gc5DSPSOLmif2cM4370/8JdRKo=;
 b=e82zDv+dpUr95xnHeo0/QyF4lpJPWp06RRYGgbrcpmAKL/cJErpAneB9wkdnWZcsZ7eMeOzWYclgpbNjfbbCLq1HK4Fl0P6o2hMLSvJrNBIH4ipFCscXgHS0oyw+Ki7QD46c6zPGxBrFynLZ0H5aSvYCGT5yyr48SLZcIm1z6vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR0402MB3858.eurprd04.prod.outlook.com (2603:10a6:208:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 06:26:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 06:26:40 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: output firmware error message
Date:   Fri, 10 Jun 2022 14:26:11 +0800
Message-Id: <20220610062611.20201-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0bf4b3-e00d-4620-95e9-08da4aaa2e02
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3858:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB38589185B9E4FBEBFAC162C2E7A69@AM0PR0402MB3858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuGXvgMaqqCHxuXM0vqHcOhmv2kfdaCnYDnhjiLgq/yTB14mJ0AQYheAP1Y4MTQLYHXxfuhHACvDiRTdPO1CXm85KcmzDNT0vfTSHw6FIg1ePKUZECzwFGcnA05s+Yg8cHTjC9Wq+D9IDMWqBm1Zn4d82o/ce1ZLirTfQLydM2TgDq3peejtBtoZHFzdZj7ClshLOxe3QGPqNHBbgXu7JPUWyO9Jeysm3/hZJ5Q/OcWNvmCgrwKpIoYIFUb8LyxIhczicA5uhs+9NDPigtj0OA6tanXfJW1LB+i10dATEgzFlsdoOZNmbFeV7w4aLgK+QvJREyn4OLabo2DVJtlo/KYjquXCmYJ8kTD0BPw0p7pwbtq1SGhvp9Lo1sprErRWVNi3UUOvaYFJVGFlMzb1Y+qQaEcCql8/5kw3BMHb/4lBZNbTE8KRBZ9HNtK3sPdw5ath4w7fg/nKySgWbjvZ6MMp4SqLROeMLj5Aq1YXP1n1o1vz18XCAV+Rqsbblf51rfAPN93eDnlBvEsAKHJQPAC28tLO2G2fz4JFBwAmYOG3VCO9OvYygu+l/02yhL4WUnMVTLKDmxLX8FgohnCqc6VFUWCrtd4FyUqckCA+WJJRkBgOGbI69XFRCiSJAIaAYQqbZCfyWfdgd5Zb/JmaBaHrPwZzT+H1j7IJrnfcWya2N5X0cbJGOiJaMQuVOdLP8zCnJ/aFGL5NCRh7izZgGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7416002)(66476007)(4326008)(8676002)(66946007)(5660300002)(6486002)(83380400001)(66556008)(316002)(508600001)(6506007)(2906002)(38100700002)(86362001)(52116002)(6666004)(186003)(2616005)(36756003)(6512007)(26005)(44832011)(38350700002)(1076003)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VySriApSw/yrK5y3jsHSxKiLa6kNa/ahVf6mtubrHCQaVOtDyjO9ACYVBgI0?=
 =?us-ascii?Q?+1IJohOjNc6XKBojglGONAtWyhikXOvPQedu1BGCVD4TFbEAilAimT1sUpRM?=
 =?us-ascii?Q?0WiBPa+Ne8HemE6eSChadi1MI7odXOgURfeO2TZk5h9SmWnbUYaNRC8xI/Ai?=
 =?us-ascii?Q?ZEi9++N6+wVj67Gi2l94LOIUuuiZhiRO7PwTQ1Grqh0u16Invx/Z22TSWyu2?=
 =?us-ascii?Q?/aVt9bcg6WBzP8itycHpK4ulQOuMc0Cxna1b3U9crBn2M0XuFGwkKULZXtKF?=
 =?us-ascii?Q?yBKDqGV3FoQ0AdVKgS5UNTtlIvotBY/xSDECgipd5YAmZozIwnHy3yIY57+1?=
 =?us-ascii?Q?WlsNPQUjjzemykkitQLZl4bWG3TFig6rbcsGcyyWIwm79cB7xACOwT8MTC0d?=
 =?us-ascii?Q?L0hipcz+E8PtHN2RrvHCgHsX6Mil9Ov9N0WdL6ZNoexVFjYkiGUrul72fCi1?=
 =?us-ascii?Q?jaJmwUFdU7vm/vQEuf3XyiDak3FDr1d0WbojKQbqKtbTxEt5Nf+2Zqyjxrdu?=
 =?us-ascii?Q?eNqG49aGp8etwmvgvDiuOl33dkeaaMtVxUSwuxya2mPlQUt0FhRlGD9LOmUM?=
 =?us-ascii?Q?ytL8FVJws0XR2b//LBkxFY9H/YZcJvcWkMYlsXFFGKS1HcblCvNw0rDpdR3R?=
 =?us-ascii?Q?K44efv+6Opvno0Ug//wunjQCd86xlv0fiLD0YqvB3jCg8ryEP981UIPaft27?=
 =?us-ascii?Q?rg4ctnYC5F8V8EPH6owaAhQnjC7tLVzP7f/ohsEL7C8ikShUx4j3sw6WxTFD?=
 =?us-ascii?Q?y7YkI2dPFYTP9K2Ukb6K9ERHMmG4DEN+4wuiZIyqdcbAnut7TpC9gyamQRNk?=
 =?us-ascii?Q?OWK6CF8/vPMgx+dWJpNp/2qu389QMzB/eY0K+26vIejRH3RSHgOTxoxDkRbx?=
 =?us-ascii?Q?+NWPJDWLt84JpPDizkUcipS+ugYaGoyDwzrvEB5Cd33OMjL5WdRUpjKHNeFd?=
 =?us-ascii?Q?/o0oBWHuV8vYv9UBcw5ML0JWsbZ7sxgOWeGIwGjMweHwPTE+6/UE0P5N0QzG?=
 =?us-ascii?Q?btr8UoxZ12dgiNpjAqKkMAEsDcP7oHn0V47juu1vuabHoWvfYIheRHO+PNbB?=
 =?us-ascii?Q?JNGtbyW3St16yOpz5XgEJ5g76132oeh8CFjBPaC4FtLzkX5kW0mI4uZE9DGs?=
 =?us-ascii?Q?k1GOi15vI+IOFaiipAYVI4OHTIGJ0Xa5benJRWip784J+w4XFWo4IfJpkjGb?=
 =?us-ascii?Q?RmB1CU+O0GwAv+Nnq4TW5o6wRKJswTDAVrxAY5h6qlVCkCJ+ThsRcs0XC55r?=
 =?us-ascii?Q?keIzyoj9XJd7d7dPhYdtWkC0jk+pdnYUUTwq/8rLxmbIuDNMXH3m6SEc+tG8?=
 =?us-ascii?Q?EaauEZAYsE75/Eu4l2/b6A8ZJr2rrpQU0jKa8V5+ffsP8WUxI6pZPssN7DMU?=
 =?us-ascii?Q?5KaJAIYD7cfioqN/GWRBDAgssDLAG3lovze5O1tbYoXgxBKh/HKy1XDTCLAj?=
 =?us-ascii?Q?F87svddjlQlzRFRD4DFKGBagpFKDsKeTjGZE4GP0HlU1/ZXOrBeA61VnPsMT?=
 =?us-ascii?Q?69sA9jK4q57lHU6zdtKNQzWMRpooGVCcXy6xFu/XeKwddyM1UIGMc2JsVyvB?=
 =?us-ascii?Q?xbWWSbX9Xb5JRF2x9DDzFT061gAhbG2tNHnKj/6OhNMEvP+TxNNqAjN/IdwJ?=
 =?us-ascii?Q?giRhIrCstcQB9b7gOSK3qVjBPikrisyFXmoawZKfwcAj5tIt9OIbYVY8sGsA?=
 =?us-ascii?Q?1HoCduVfuseQMyZ9v7T/lX4ggKrZPvTQ2wWpK4Oe7KM3yk2llEmWeMtz6lVO?=
 =?us-ascii?Q?jIh5FOAJwA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0bf4b3-e00d-4620-95e9-08da4aaa2e02
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 06:26:40.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6gstk11ZdNrh1+OYw/O6FcZum3f+i4j2eQoeLXTUCYG3j3E7IZRbmCTrsGMlGLSYNlC0JmYEEH9FBMw653Gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware may send the error event with some error messge,
and it help locate the firmware error,
so output the error message if it exists

Fixes: 61cbf1c1fa6d7 ("media: amphion: implement vpu core communication based on mailbox")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_msgs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index d5850df8f1d5..d8247f36d84b 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -150,7 +150,12 @@ static void vpu_session_handle_eos(struct vpu_inst *inst, struct vpu_rpc_event *
 
 static void vpu_session_handle_error(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	dev_err(inst->dev, "unsupported stream\n");
+	char *str = (char *)pkt->data;
+
+	if (strlen(str))
+		dev_err(inst->dev, "instance %d firmware error : %s\n", inst->id, str);
+	else
+		dev_err(inst->dev, "instance %d is unsupported stream\n", inst->id);
 	call_void_vop(inst, event_notify, VPU_MSG_ID_UNSUPPORTED, NULL);
 	vpu_v4l2_set_error(inst);
 }
-- 
2.36.1

