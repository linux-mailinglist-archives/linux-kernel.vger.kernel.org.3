Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D518851F6CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiEIIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiEIIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:01:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA819C32;
        Mon,  9 May 2022 00:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTfJI9aYr4kuujjjwoG6kejvioF8uuAxAyLsD5mfo0uohnDlvuqcCc8pofiTXpvx21T2Wj7XduB3+29ZG8pgVj+DydRrLuwLrfNEEJjy/HBIrdmA+pO0oMB3CSp6D1pyfB++Irh1Bk0sCYOR9jsilJ2Wk22W+rh/n0paJzKI7E1cTBwCfzpbtl8fuUhaLOLCOshgleR5cew/6hO5owPLpgkYiD8Q14sX8rksaGL2rlOCTfiN6UEst28JL7/mkZQFvw1sXzAPcNZSXa4lQAHCkJTNXcGY83T9QYXYvWF+sV27d9JzECA2Od/AA+3FF5twzxCZt1/GUgt9ipKE4UhZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFer5QZPSXXzyHY77JHH2MsdpW5Hs8IX/taIJg8Y0s8=;
 b=cFF2p2ziGceGS5j5wtgGKedc+i9jKkplJhaIMRwbwR15hVyUsTx5xaHdhMqN4ghk644/zqwP7jNmY+CzXcbRDH40oSl67q4+Agbh6YAJkxLFohelvoJD4VYc0q1yUH1+a4mOYB/MdtQCaLLOUi7e9s2rJOHnjw6Cx7e0IA96lGoxe2tqeLfACYaUImNfMU51aKyq3jyZu3ERJZvUYG+DzxN6S0Y+DOoXBbCV3JwdjmqEff1VeVkr1igHmBLu7pDvsaBKP+m7ItxFpkPQknTFll+YFc+canLy26OG7/5fywKAOkRwoujoJUXI0jBqwXX2PgfMPAfkDO1f8L71U6/tOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFer5QZPSXXzyHY77JHH2MsdpW5Hs8IX/taIJg8Y0s8=;
 b=Hw7oAgj8Img27ZiBF6i/vJJWZH6QEz2sDwvj/cikYN4k4awH/gw7smxYhs7I1GcCGy5HZjE05trQaYEdve5lDWBozmzRi4wfQ6E9bLBwILgQSdsYWo8aJvlptpFOOtnpDLZFK1cHtCIvKiHe4BnDTUxUBwXcwzqmDtmJcdvdhEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 9 May
 2022 07:53:42 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 07:53:42 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: G/S_PARM only for encoder's output queue
Date:   Mon,  9 May 2022 15:52:25 +0800
Message-Id: <20220509075225.8031-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d467045-69f7-4cb9-7cc0-08da3191090c
X-MS-TrafficTypeDiagnostic: AS1PR04MB9504:EE_
X-Microsoft-Antispam-PRVS: <AS1PR04MB950417D16F1D962CD0FF23A8E7C69@AS1PR04MB9504.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jF+nq548pvSMZw2zV6lw41LNSikur059d8cDNyjJAoQjgAFCxmN54oIvdOUTPr8NBc3E7B8uloBMRhmkX8MNSt+OAnmy5tpCoedspL2jMXSbMsjwcxKsF+ent9H1u8oOIJ+ABdlis94GflkGUdo4oV5FFFVWgtAmaDNw1y6OiVk7YPoMVlSK9OtFKam09FRtfEWZXYtk10elFWHH90kYZ9dSbtrFJvzo46wYL/3ebI6wwWZp7ENEIsztODPlPJRKFWaZdA1S71j+ftpCccUqZKtNI21741AktOoctY4IcO6NJ800qBLxNNTKut46GbkSDScG1+TI3HQc4yIThrS+rc66VNF8usDMfMluWx5mk5pUPjiXTyPeakRB7K+P38Nj7kb4qsS2mMVTVgue6FX9PNMht27kX6UOueAgy3kS7G1TmF8nft1OmcJUuyIPGrCuwksw80RrJzWwEvnDBxczSe26A/o9qyaJJDp3obBJLT1L2dwxGJ6Z1eldkqmib58IjnthNiOK5ysZ8JHsPySvB9/VeprO1vbl+J/Pna9k1Z0gsPzY1maz/+ekwWOU4FDiH7ocqKYkI8rCIf2e0biZWq1BUlZQE5JEl8B4SxBAH4zRlzeF9DGnV99bTYJ7drtB2pqQvPocvm4LCITe/luPO8RdmZCOV1zLluH15K6frQFYbxuV9pG0eJLwU5GGn6zg34/LlYpL/NoWGosgdWlH2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(38100700002)(36756003)(38350700002)(186003)(6486002)(1076003)(316002)(66556008)(2616005)(66946007)(8936002)(2906002)(4326008)(66476007)(8676002)(86362001)(508600001)(6666004)(6506007)(7416002)(52116002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRUXLUjTNO8NwCCGAqB1JwDm8hy9cKujSWIfw2plZdBZbnFabbOx/q3DQthw?=
 =?us-ascii?Q?HAVDVEEfzWSXgvBBPbrJ/tsYQTv+zLwfdVvkzRZDJIh03bAO3KWAq4c920ja?=
 =?us-ascii?Q?OdsuG8C1FaPLs7SfkmkiLL1VWNBsYArb1MHgF85Y2yLupMqpxA0zZZ1REA8O?=
 =?us-ascii?Q?XeDRvAEUEYUoyAL7EKVRLfwpFLoCrM85Z1TAe3huEyVMOzO3PM5vg+cISoYF?=
 =?us-ascii?Q?9mFKkaL+a7jbACiGv/hmkqcRnhHEw9volvC6v5T+THVy73NPlpWMApF3w3hF?=
 =?us-ascii?Q?LUwO2/vGa+AV762he20ZCuCpBN+a8S1pVxCWuJoTrFh3D62glNGhtEIlc/v7?=
 =?us-ascii?Q?KRGNdjSYf4ZMEMQSRaUZijU8aE6+MIcnLnGyajatpj08WiW9HE3I1Ib2d+lF?=
 =?us-ascii?Q?a7g6iBmpMY3YMsYsZxDp2O8Nr8vnDfjAxm0CXv9ZVLrUOsvYZl/W5vxCLUqV?=
 =?us-ascii?Q?pR2rMpdC9YGUH8K3fS6rGHzXKa9XG502Y+w37kdGTsodBaiAAoh6D9hH0qtC?=
 =?us-ascii?Q?w4T3qTFeMopRCI7E7OG+wj1Qir9AOcTy5nQG73Qq1pAm2YvxfuUN8pbV3yEZ?=
 =?us-ascii?Q?zCNE0/N4oTwUt9ERRmjKh8T35fqEallHR7ahNu0lz+IqlLj3ctJvE6e8C7tA?=
 =?us-ascii?Q?1xmYR19fmKcbZLnjrGYuyT2ybCWq/yuFmqoEZToGBrF6FZm6b8o5CKR/pvEs?=
 =?us-ascii?Q?MxpJ/sxdbD2ydOBecXNedmNw7MANSLXbvzQtZoh57fcwbVHG6kQMWpoH+VTc?=
 =?us-ascii?Q?jVbi0kdtO4ofNnlVZNmsiA8NvWuTGuqEacA1ibfLsUzmn6yiMeGOWjR5mYaD?=
 =?us-ascii?Q?APgZB7NpW+8Gz+GbafDAa0yVlsC5ix7MQSP6lKKUSpIDxIqhDhq03SzeD0pR?=
 =?us-ascii?Q?850ZMbhZuRodE5fOePp/3MpgxFZwYfYvpzHUmezCoEdIF12RPpeck/NVdqDK?=
 =?us-ascii?Q?+uiDraNpqFaqeiGQUaptyRpqhq9mgi0ITCQ51rFdnvbDaBHobEjggk9DFu1N?=
 =?us-ascii?Q?rkJwgJIZRRUgbzvanVyaR1XWs3KAGOcGJury66NM7gyHiaIpHZVF7aNm7ACv?=
 =?us-ascii?Q?FOgNMW4Hv1Xke3NZp4eTPi5zwwTILScTtP0auuZhj3osjTw1IhClFsSoxLoh?=
 =?us-ascii?Q?dcCXxD7MrJYaoPt/h1yPS4dNR1Afq0/0Et4RPlEokkX0nTOFmlAwE+EwfAqb?=
 =?us-ascii?Q?HbdmwkCo4us36rNhACQAtbY69/sY7At7aCtlTbO2FIxPoXLCUBS+iZ6q5N01?=
 =?us-ascii?Q?qglFWxoodaEsHhg7FDHXAlqo8D92NMdNe+WpC1LhHfsG8FiSmB2rAMRe0a60?=
 =?us-ascii?Q?Bfwx3p37pr9JGaUwNaVCvbJrEvMwkyGidiUM0RU8H7IPOQK+BwjgzekGTivj?=
 =?us-ascii?Q?lI8kpccjeC76QUcm0Ns51WQywRylpiCsnp7waza83w/CpY8JCp1GEiFOgKbP?=
 =?us-ascii?Q?qY7sFP6+89aRo3cuYcazmIiGqDBroLfNZw4RJv4xGuA/t+WR7ykZmSFK3Sjk?=
 =?us-ascii?Q?lmvg/u36WMb/mUx7QrWDEBO0rRXgd8dNn/bD8qhM+0i0h7FtvDrtJpjil18E?=
 =?us-ascii?Q?ynXKLhVRxWFvT4IdSWHR17njzoCKIbXoYihcWFKWyrXw92KrS6jmE4S6aaCS?=
 =?us-ascii?Q?id92NyfXR/VjmvXmxvoFS34jfPTFi4VhgXYjRMisGTGTfsH5u7zXePQrPuUp?=
 =?us-ascii?Q?T/JJBecR9BWmvIGMZPj2Hm4NtKvVgNxXZgmTCK65x8MX2epm/oedHS05431w?=
 =?us-ascii?Q?ubUPl0305A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d467045-69f7-4cb9-7cc0-08da3191090c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:53:42.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3FSZVOMspERu1opO0hik0h1PW4NYWO7T/U5tuK5Cqp/zed6J4go2tGnAQkZ3NvOCEb7rgNK34sN9d7Xp/gdRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G/S_PARM doesn't make sense for the capture queue of a stateful encoder,
unless V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL is set to reserve hardware
resources.

Otherwise it will fail the v4l2-compliance

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index ba9f49cca155..43d61d82f58c 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -283,6 +283,9 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!parm)
 		return -EINVAL;
 
+	if (!V4L2_TYPE_IS_OUTPUT(parm->type))
+		return -EINVAL;
+
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
@@ -304,6 +307,9 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!parm)
 		return -EINVAL;
 
+	if (!V4L2_TYPE_IS_OUTPUT(parm->type))
+		return -EINVAL;
+
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
-- 
2.36.0

