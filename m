Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7805375DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiE3Htk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiE3Hs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:48:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31B71D8B;
        Mon, 30 May 2022 00:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+KCWI+7iUp8grU/4Q07wgC4uDh6RpOQelIbg4gEOh/7s0T3Bw5J0O4bwXbCYiayyvAMqW/N53efXiYegez0z5C/agEYvTZ+6Cww7Sc+721UkcqRoKRNL+b3vN0HaagTInxBObecD2W0dVruDj9tFwFRiLSmsxeQmKoklHwTLkTWTdl8WSxenuNZZLd4Q758NssWyTK4OYed7RRykqjMNO7VeLV2Ul8Me28T+AGG0dI8ENjEUJPkLSKA/iyOM4x54PL78ysMqMt1Z1E+06OGG575DSUmxrleYRgMQR7/uutTQSMBd+a47SOJGjwkrOzXlN17hk0QZYkX8v4aXsHJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wldO5Mwxe7XSyHRxNqBjPrwzyUBp+vSZB1mEGZn6yvI=;
 b=J7OSGAe5AbK1K2yt99b4vd05ZaQERlHOXLGxhbDJPB3Vg1P/nLKC68y/BbsrxfJV/aze0uQ5tOvzzJUEATH1YfvpPDThXQBLujP/ILvh9XLbID5eKlDNfdr2290Ww08CebL/zLlxHYSQ7B8VixhfTE869pYJvdanta74VySDIP6LJ1Dwe/ljDZwUKd5JqV6fm7b/3Gi7gSvQiptedJ0JDrnub0TrTTB+TJ1P3NFL+KcPyoSJKpZNKJIUrEu5AMrrnwGeGD+W1W4u8d8a38hRqYYONyYMAsKm2dgJc8usGbbdBL7Ai3Xe3B4i1ukkImGYtsg2XJsHkfhROWAYLhAiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wldO5Mwxe7XSyHRxNqBjPrwzyUBp+vSZB1mEGZn6yvI=;
 b=bfSZitAGSCd0yLB4B1zMA5WxkoUl1jGI6PCIyB01WdKX8/ajjJilDAXi3wCWfGxN9DjhtBEu4N66Op8Lm/sKO6VEUfULV/PaoLHKyl0hbBYcnHg94SIQYs0XY2geil/szeiCnpx8XsbeLmbvXMDmMWuZ3fgFNeI2w/6YvkSrj/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB5452.eurprd04.prod.outlook.com (2603:10a6:10:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:48:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 07:48:52 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: imx-jpeg: Leave a blank space before the configuration data
Date:   Mon, 30 May 2022 15:48:37 +0800
Message-Id: <20220530074837.14643-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13a97624-765f-4d06-eb36-08da4210d759
X-MS-TrafficTypeDiagnostic: DB7PR04MB5452:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB54526FFB87BFC584044C7584E7DD9@DB7PR04MB5452.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXY0JuE7cr3+kCGRhNZHsbcqdD2FPxwBhopxbZAS7bF+Szo+09bVifrOLyWmCwF2hqO4JD8YzuFJ1L6sbXMH+8u5PjbIf3D7X5LeTWLvDEaygLMSNldX187SNK+rvvrHpa5uXYIdUgYTqV6KRGTHSnLCmMlJDSDegyorOyuksUhq5FzDw7P2Rzya2nSdnplehmh4eQPiiQplsQL2SmA9Pn561u1hRvsX6BEmWELR6UEPfKEnjDP5jDjU4eKTcRkWVsJ8SIgTBy2M3E6jBuOdqjV/ePdrK1pcXImco09NF7F54H1iQP3LhUnKgcOkZXcGPH+c1BoZuGJr3NZSfBbYQuRcPAxFDdrSzrTBcJ8KNhr+IjoIyVXTyA2teDAIw4c3DAwqVNx/gxAABteafKdJp55za+5H3l8s5GRuyZRoFud+00ZPE5CgQW6ef8eSeoRgJ4zcPT1ft9H7X9U6Bak/tnLi+vFuZBrJTsvmujBfRd7gPRcIqg1KxmzhYDwafW2rWPOsgEO2YKkOEzv9wKiFZxD4M+75/SzKnQ/7uyzHVlebRFBnHN6ZNGAy06t2yQTRfF87hbE8uNXg1G8ZRWEmtNIX5ysGvQSzHtQZeb6Kc53RLoGAFZihaGG8uYrGTn3pxPouH47MntJ0GTDapsJnAPJ/A64Xf1h+7d96+Tr7HAfh81MQdMscSt58rFbLiTu8ThpgPhdqOYSPmrnYDK8JCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(66556008)(66946007)(66476007)(36756003)(38100700002)(7416002)(6666004)(316002)(8936002)(1076003)(86362001)(186003)(5660300002)(52116002)(2616005)(2906002)(4326008)(8676002)(508600001)(83380400001)(26005)(6506007)(6512007)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WSLJZjytOFxPno2ahuUExXpiZKtscJN3bXdd+/6zEk1PHfqDsCUZhJ/DjQdX?=
 =?us-ascii?Q?xJ8p9r3hZVKsziwupZL14lSftY/JwFlcxN5xhHgHfU1eKOUMMq2DmQ+H/xPm?=
 =?us-ascii?Q?+qbc6iTL3+sVy9OI3c/XUpIpc2pPrUlCjHvM6RqaqSvrfEZvN9/w5IqKcrVU?=
 =?us-ascii?Q?FAKFx436JtdQhTpiT3kClPEnid4RgayF5DPtThOCEskme9dR5dCSuEl47g/e?=
 =?us-ascii?Q?w4K+hmoghUgVY0S+pdWJtuJ70R6xu3HLzcTiwJk1EhwVuD3OVKBzllL9WdzB?=
 =?us-ascii?Q?AXtlD1jdzTtqaAJ9fjZCnXYnTQ+z0r5QyarcQzsKGLL0xhmS4BgajNHiBBcc?=
 =?us-ascii?Q?IOl2JLDZoUZU/yTNN8BVkAX81xoClC+3D0fZX1/bqDR//wKpRiu6iadKNCVV?=
 =?us-ascii?Q?imLiDG6SDlP6yUsGzGkcbN/USAMQfIPI8ixdIsrZJ7zSpxta2RLLc9bREM//?=
 =?us-ascii?Q?50I49pVeQZHMPbzGioLIVcv8EAb+qdg9u4wUXPY6EnkA0aOXkBphWhUpwxGz?=
 =?us-ascii?Q?Bnd+4u9lW+5Ph6i4xP8lC53os7vPi90FERUrnYLZFYLjYtfKsH9Mk4wBxqhC?=
 =?us-ascii?Q?1lKixlGakojwGFl2poIpZ6Kp79RxGiFFogX6kCDAq6kEenFIElbZyQoGYcHv?=
 =?us-ascii?Q?neey2hOCSt0YlReV+cjn3+WwA0xsPqY6zWZzdwzQPxZ+kFti7Wa02QdI8eJ5?=
 =?us-ascii?Q?wfaP82VoMlLHQHLDS3Ttk/2QOVmxlM2Jc8LGtlQunDiokk2Hd/Y65l9wGc3p?=
 =?us-ascii?Q?/+sxIgET/a/+feS4wjjSO4xPnuwiOXpqnZQ/8yWDpuRiDdV5yb7MlKA2nkFg?=
 =?us-ascii?Q?D2aCv/NmZPAIGWhus/Httz9b+6zPLHjTcgoRMhztHi5rdhWxOK616AXLVWly?=
 =?us-ascii?Q?FaOHNa+tObJGXQzdL0K18ZiDnqtxdLU4/Et0hGdL2YrrcAFh6KQsjF5BueRK?=
 =?us-ascii?Q?OOeOLYmmP5rwQ2+toPb05G6mjjFjHb0GQRC317oa0dgEpLZZ69V0Brwgfb6N?=
 =?us-ascii?Q?b3EN0lwIexTyMiKv7A3h8zUub1x/D0HQ3hyuWZAnJOfIY0caHwm85ky2XO/O?=
 =?us-ascii?Q?i8tiTG44SzwnL7PYdvNqqUZTg6DTR8VUfIf7bg+o8J3eRx3VZ4JrmE1TG12K?=
 =?us-ascii?Q?R+XS+Ht1d1VDxf6VHfv3fgvdH6WFpMUrCdMwxzAe2zukjY0BlJ0hgv8Oegvi?=
 =?us-ascii?Q?IEOzOkrdk8YMGwboEyLjhjagvCdRxtvQiRtGrf2HOTq9Q7IUOJVMkp/5kN1t?=
 =?us-ascii?Q?Eago+8Rz1rN3bXlyJXA/9UdazvEWQFAt3SyLudObIIaAwk+wsQZBGG4ib2wf?=
 =?us-ascii?Q?HBvjXGMO3O5ZKayo0VaQnTx+9hMU6+0LXLhJbjoqkS4U7FviDxb+yKeG0O+Q?=
 =?us-ascii?Q?T7DU91Hoj6IBNrbTP9RVQ+CxdUnRMgLt04U+pm6+ZsynmNy4KJRd7QaxhCak?=
 =?us-ascii?Q?yWB3neMAq0bSMQaXbyp74fGXJZ+wYnoQhJVgDf/ggw7s8uMOR8d5MBbe573D?=
 =?us-ascii?Q?Pw1o6UCaRItAIHOSezA2B7CUjANUJhqMXEd4O9UIB9ZojJ7GpZUJOADrTI6R?=
 =?us-ascii?Q?CwEhMfuD52i6Ee6aIp8c4ll/t8WLaonn6aCf5T9ZrOCIWkgnnAu5lUo/WlFC?=
 =?us-ascii?Q?jndUghINnT+pBok5kz75a9UsPU2ZZIZeXvb/mEDqLm9Yz+pWxctZ/za1B4WI?=
 =?us-ascii?Q?ySHxwoL2smcN42NRzeTesBnMfhYzWMUXWQ50Y4eesNujGvtNIKrxJUHeXyYd?=
 =?us-ascii?Q?3EnpVC81mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a97624-765f-4d06-eb36-08da4210d759
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:48:52.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQRHCv46q0qFjiKea85XZ/THOeaGZ5nOovNKoyhO0lMPToI+4e+xY/ZKf8q6z1MCnMTYl8wPdNhIxMoNjVP7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a hardware bug that it will load
the first 128 bytes of configuration data twice,
it will led to some configure error.
so shift the configuration data 128 bytes,
and make the first 128 bytes all zero,
then hardware will load the 128 zero twice,
and ignore them as garbage.
then the configuration data can be loaded correctly

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
v3
- add Fixes tag
v2
- add some comments about why the 0x80 offset is needed
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 734e1b65fbc7..c0fd030d0f19 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -519,6 +519,7 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
+	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
 	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
@@ -755,7 +756,13 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 					      u32 fourcc,
 					      u16 w, u16 h)
 {
-	unsigned int offset = 0;
+	/*
+	 * There is a hardware issue that first 128 bytes of configuration data
+	 * can't be loaded correctly.
+	 * To avoid this issue, we need to write the configuration from
+	 * an offset which should be no less than 0x80 (128 bytes).
+	 */
+	unsigned int offset = 0x80;
 	u8 *cfg = (u8 *)cfg_stream_vaddr;
 	struct mxc_jpeg_sof *sof;
 	struct mxc_jpeg_sos *sos;
-- 
2.36.1

