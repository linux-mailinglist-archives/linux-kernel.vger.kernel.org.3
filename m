Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2883A4FDFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351696AbiDLMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352940AbiDLMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085C32D;
        Tue, 12 Apr 2022 04:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCpKkwkp2pVUdKqpQSzXxjqJNn+NfrxId8tOKA6YuUuXPsPof+BkBBFupUaOd8NL1k88lT+/Nz7y9NJGoYPTNDageBCDd4VEplEKreCEeQJC1EzmH41pb4GPrOwzvadGQIHF3ciibDu3wT4G5Lp9JpQjg9WgNBq6voMgZRiLEgqPhHuyyuC201oFm2NAQslvpui/2yJcbID8XwL0H8thCt3izZmLJUWglFUnO+hcrrDYHIuTFbFTz4vKv/PNS1utPAN8lMicJNJyklK08UVj48YxfwrA6W5+Fz4d0N/lhQP6IwDMe/fKljh65D4PsasL7vubQUQj28Ll7UzNGAO9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrlnXPV9r5wnUUocuJYewCGwtfbttI+GWm1kYRlJ77U=;
 b=HSoeCWa9SBAk9mOen3Ay43d95LxN3LWunsWK3c99ojezaTVN03peGqU6wErNJazUmH+iMQ8/Lss/yQUyLhiRaiUuOuDFafxQG5pXl4K/Ftt0ciPgdbXBleqVP760mZ3quo+D1DNx568nC2jI98UbpmvkuCSAyAi0WloWyMZNI4HXcGXEkzgUxcdSTbQt/Rn2+KF5umZIcDfGGro8g1NqbL4NCcZyiO00L8FztKGngQc/KXYCU8nQidgsAsK8YPJQDiGRdQmdWCD71v8Lw4PoXOGXiLn+/3Xye0SYtFon+DFK4abDLnX22wZD73QmBSANRp/lZUXltIdnuOMZINHKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrlnXPV9r5wnUUocuJYewCGwtfbttI+GWm1kYRlJ77U=;
 b=Ch4mwDRXUjl/e7/AnpRCkEC+CCA3gn+7xVW4DviQ85YNzMS7phMJ679+RvkgSyocL6Or8RgbBlAE173JBF0wAyFWJPUMyqqrW2cFFv+WiaUZjYBR6p3LgyjT4HOClydNHlFh1GO7+imoaR95K72lhtngNZlwXslkt6Ue0twOIAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6126.eurprd04.prod.outlook.com (2603:10a6:803:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 11:02:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 11:02:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: fix decoder's interlaced field
Date:   Tue, 12 Apr 2022 19:01:55 +0800
Message-Id: <20220412110155.21427-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a171713b-8209-4595-349e-08da1c73e5b6
X-MS-TrafficTypeDiagnostic: VI1PR04MB6126:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6126316086BEEF0F86A30712E7ED9@VI1PR04MB6126.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YlQsggkIrwWuXiXFA6eHG1/y9vIn0tgRUK7aCIeYMlxUpjhpWifjDiBXhxfLND0jzi299Gl/WdZKYK7NrAWkDEQwnPP9eUf3eaBFPtIou3+TgyS0uCT/epr+itki4yEyN+hgtCw+nkVdGkkHKzDu063CMqY0jpOnYCjWjLFF5TI6JDmaeZCIHzGMvNJT4GPwqeMU8IXl1NhZBGRKWvXquoIvzOgtsxg9j4NQz0cY/jfiIT4HZE4Do/q+NQ5TSPZhfWTjJIfut6xylq7E4lXOm5ODbcKdEdrTgNkEubgZDwP7rqGmIEgSi04AYelBLtFhUyoyquho/7r5fcXWMqEzVDiT6KZ6XfZ4o0Zf2skWfbdx/xp7rqa3VfqgR8lqat66X+8/19kqOkqIsH3Lm0wjRDqfbxqnMMt1KKyJxbzjxWTitGtaPGwau5y0H4zIocRSYHCeWQrTIXHDx2ywWxqdFfl4l4wk0uT6dUJ/SB5uakzyKLdOG6Lk7pRXBLQGORQHcLOrP7MrW1WzOTIy+3bclvWXgjR/1YOWxdlO8FOo1WdXKfl4hdoDSXlS8wzlJEKJJyU0suEine59/DIXx0JmlTEu597MWqE9dWcfrIr6ITFWBegVwRg0z543Y6Leqss9UKd4aCuqJ0/ABYifM0VDXGdT8urfLJWpYyCV3DrMwkGg2XJgHMSAgqxDtvnYOdATpAO2BxuQG6pSG+evnRj/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(44832011)(316002)(2906002)(36756003)(6486002)(186003)(7416002)(508600001)(26005)(38100700002)(6506007)(6666004)(38350700002)(8676002)(5660300002)(6512007)(86362001)(66556008)(66946007)(4326008)(66476007)(1076003)(2616005)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7h9UtvT9kENf3NmmeR2R9GwIPF8kzBWYrq3LgAsrDPzcIvrZNb3NhirjEmZf?=
 =?us-ascii?Q?yFQwrKzID80/fzfl9kYfPQYEG7vsEB3JFAZqMcgg/7h8gnQsu8b4TBJX4wpE?=
 =?us-ascii?Q?hhNEtJwYGDnfy/WFIIJV2QiM55V92op4s/ARELH+rEqsVjqNFl73FIch/QkB?=
 =?us-ascii?Q?r9DFduqferHV6Ei00bn0EGRG5XZK9x3JFwdXkWyB0wwEQx33G5ereSQWXaIL?=
 =?us-ascii?Q?MlLaFa9gOhMfa/CM+OiZUOq241XYvs41lAzPeboAmNIT5FEveBxK1MwSe7mC?=
 =?us-ascii?Q?blvpEBX9Cq+UWMFcltsYJTJJjq035Hl4LDKmX/JVI96XcWEX6gsH07cNibTQ?=
 =?us-ascii?Q?SHuIOztelXtqsslhnTQMPRMhQv8L/fX5U0A9ULvnhbuD+SORGVOlVCWcyCVU?=
 =?us-ascii?Q?ArQk1E58fdjMokgfNvZpa5I654dSkotvs+xFj6+Xg7gjdjVi0ptuUivm8lKg?=
 =?us-ascii?Q?OBY7i0zqdVvnwRF9E9bwNHGrGcvwnMFfEA9Rrk3SB5Zhrmw2E7U/lhHIEO/s?=
 =?us-ascii?Q?wTxgJDjvWimn+ChZrxg13esYIUiB7QWIJNMblUZmWxi3e85xSIR+KVJ0k8G4?=
 =?us-ascii?Q?WYPWLXU2Sv1wXunZOtmbFPZQZh/xa3egN92XJl6Gsh+SdtRfsNEzdvUQr0G2?=
 =?us-ascii?Q?InD6V6bEnarVUtRtOc5lh4OjXbPTlnmUnt3uro02nF9Q23HnfZKg/dihB1So?=
 =?us-ascii?Q?LYlWDOQTNhOMoTQEnanryHVL14FpyhMxGbC7g2eAv0GnCXXTeAO8jxE0ECxb?=
 =?us-ascii?Q?vVy4uaHTxxQ9C1V6vVuyk9dfxIWy6Zo8JWp/n8h4yuM2iisDaZn01lb+gQZW?=
 =?us-ascii?Q?+YrdF/CM4wKejqcpvlwBSSbAzXWuJmp1X5ra2jRLvf2dSLuvlkYfOJc8Je9x?=
 =?us-ascii?Q?g+5ho1QUJTJSoz19RqmRcJsvkmJcYmisSPoIY9Q5FPVwvEyOlbGEmiN5NwGK?=
 =?us-ascii?Q?HRg/OMb5giDRD+oOHaqOFmZOieEZnpQ9mK1FhthZk5JR9dLk9JCYQsZAhGxl?=
 =?us-ascii?Q?WdXhFSPNq7Y072LYhIfDauAhApsb16mOLGaM5WJP3YDbet5l+d7eMEfLdILT?=
 =?us-ascii?Q?/kN3I/HUq0pdCz76wnUABpVI/CN4bUBM7VT1YgQUcGeBzDZVvtsAm5v9fcPa?=
 =?us-ascii?Q?uu0x18BsWVJiBopLhsH5I1rQoHWjGqI6y9j86mQVv3MHmz4ASjJhMQUbFgKf?=
 =?us-ascii?Q?Es+PXZqnFAhcRvoo9BHFlV0m6SUU6YWr+7WQPOgqMs90lz5FZFUuyHNL+AAV?=
 =?us-ascii?Q?bFEgpWMnWZJhPWb1v9DN0AHr0gDiazlOAa7t+0AOEUrTYP+qspWu1MuNhtf2?=
 =?us-ascii?Q?rxfPSTQcl5A4KYslpVpGy7YiFichmSALD/4JOXPM8HJgtTMZ8ieH5R6cLfUT?=
 =?us-ascii?Q?Hd2kqDY3qQvz8zFvUQZFRwAdTNn6WTTGgZbiUcITSRL47Jk+bqmbbVzfVTrN?=
 =?us-ascii?Q?5gnz5W5+vV8ZoWNIohJHSO6fEfMJ+AkQgaZWrf69fP3nrvAwgBxksXb02xy7?=
 =?us-ascii?Q?3v0sgcF95AogIRZIgJXgd+RL6TOA4Ie+0kbdT+JH/p6epbeIFz7pHvc/7C2A?=
 =?us-ascii?Q?4XZCq+v4T3qIxGJXdu0l50oQl+a/zFqpGrvVPErdTUOk25BXmJYHYvzTZTbp?=
 =?us-ascii?Q?r/cdeVrrsspVrwFykOfM8R+pRCv/Jrxm+uJuxE9LyPZ+bRbnbngR4xJejxHS?=
 =?us-ascii?Q?ORPvWY8+dhAQhQDXSGjhkZiYbq4ACG8jfDXuARFzVQ0X8PSQ7gByXFdxnEGi?=
 =?us-ascii?Q?wLWYlgvIMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a171713b-8209-4595-349e-08da1c73e5b6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:02:12.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iaf9ddG7p0sXaMgz4chf6Q+SPGTVm5CaF9TcbyejRw5NSneWD8R8FjoTpWli6oKSetsGdOFfoMOZNm0kzNkkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For interlaced frame, the amphion vpu will store the
two fields sequential into one buffer, top-bottom order
so the field should be set to V4L2_FIELD_SEQ_TB.
fix the previous bug that set it to V4L2_FIELD_SEQ_BT wrongly.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09628dd0c855..0a1976852b0d 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -804,7 +804,7 @@ static void vdec_init_fmt(struct vpu_inst *inst)
 	if (vdec->codec_info.progressive)
 		inst->cap_format.field = V4L2_FIELD_NONE;
 	else
-		inst->cap_format.field = V4L2_FIELD_SEQ_BT;
+		inst->cap_format.field = V4L2_FIELD_SEQ_TB;
 	if (vdec->codec_info.color_primaries == V4L2_COLORSPACE_DEFAULT)
 		vdec->codec_info.color_primaries = V4L2_COLORSPACE_REC709;
 	if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
-- 
2.35.1

