Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434A4FDEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiDLMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiDLL6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:58:41 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A772E96;
        Tue, 12 Apr 2022 03:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9Kgv90U5bKOeRVhhq57tPG27mxTZss5FVespC84E1kjrrnvjlrSXgzjdpAFtWavvkBtlWmF+8uFfKGSKh58822a8f6rTOpt/Xkt9bYbKQMS8MQ8kmXavH/LUA8HYa7b75V5wuO1n16Mf13ZO5iX1xvq2VdvYUlvz/G21Cb+N9Dm6BAc6kh/HNFZrzD15h7A+0Bc5lCiPNLWW2q180saGFaXjQMhm969lgVs5n6KlaPBRGQgAMmv1YbL2AQZCR0hyb1yoDJ1vEjIWYfgHETtHGsoUnrcPUu/ujbfRWkhNJNqg9hGa3MtDYFoWnbI0AyB74z+BgbyABkOSqzKbQe1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9i9vK3j5n7CRaydbIQFvde0+sm/bQ1s4MbCbF6P36c=;
 b=F33Na0KOmQ9CyvrB5e8Z1e2cE5mr2+D4nW+zhlMVHrNTyDR/bizbBfbXzwHSxdbhza9EXMwZohmaExqosXJ4YnziMKHFuGgb1zDMQ4ubMIZBlk2E5QDn+P6/5wjEnPqKd3wyFuk1U4XTmvQd5yv+XmyYVEtmVsuJbnRT6rN9bRu/tCuEBWCGTkg4WQFerpdibsQOmUUr0Mt7dT6LeJ6CfmVf39m3oIX5IzFfW0cOiyaorr/fLORT2jdgQZ4vlFjxHs6OemSAKjvoQYmP7tNPYgxS35vd09GYN3z2sP95ir9rSxr1slKWJdRtZq4pcjnDvXGE/WHTWd1kGgkKdfJ/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9i9vK3j5n7CRaydbIQFvde0+sm/bQ1s4MbCbF6P36c=;
 b=HrEoF2lDyj0PDNkGfv/foCGimcgiJadTvrj5Dvw9AyO3C35c6GtN8KCnbYo/ermPwogaKTzt8mfJp6r9+SlfgsRrPeM5amo4G4j6BcyQ4l1cIt7zH1c9mG6ar5zDXgszH6WF4wfn1BhbhOQ7pEe/G/LeOFo0JCoaKlsR7EwaEl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by HE1PR0401MB2394.eurprd04.prod.outlook.com (2603:10a6:3:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 10:52:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 10:52:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix decoder's interlaced filed
Date:   Tue, 12 Apr 2022 18:51:56 +0800
Message-Id: <20220412105156.17091-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1b6e2e-6096-4a9e-c9ff-08da1c72817d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2394:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0401MB23940FB62C1352B14B16FC0BE7ED9@HE1PR0401MB2394.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxOACPzHWIwH/ExE/3vb56RC4uRRnIdZ81XONikaPEuzuTs5zsQUqt18E4U3wihk2Y6yJJPc7o5crI2pLznhelsN8aYI+kwijytJa/X7NGxl9nhkJGDue0VWOMBpha0UEayjAqi+2pkgOcjkemcylnx5tMnyxsA1cI6t0FXWAH2UYbSf0D6j44+LQo1GEGpVyFATes+kVmQO3QgbBinUrAVrBcsMt5O/TAt17T/8b56APNIKtobyUS7jxN9vzqNS/Y7PYWhv63+fw0NRwPSIIYgIiGFKszK6BUWNRFl469RoAqZNNLSoYwWV24hEREtdVFccvFKBtu6mtQL+CLurm/PhB+KVaGOcLKhzg5M3W5T2E2mxYxO3TJ1dQjUQ0Q+lVJk4pC9Lyhk09F6JVFTy/UvGqBvnKNVvFzkrwPYzclcSqjaiHp2+vKFYXlwRtC59LV3b9eFZgTiTxV8iVwzcWqw+TZYmfqDwvRdYWtY3PPQX7NrJiHrGv45EsCocuPCmh4ZuVeKqaSuJTIB98UyNuIHCKguaHCNOujFdHxOhJFhKQ8WI8wfVpqz3lZg614mC8O01e0KYLXgDQiIFszewyHL4+dEcDdpnnaYbpncKJ2q9ENCqgx6uwRl9dQXCYc9OuglinlBTtJeBf/QtFkRdAgp47PmfDV9IPuvqJjNiinHkOHVZ9WOntuK7qA5C23MATzEZWmDL/Y8aR8KcTSLOWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(2616005)(6666004)(6512007)(6506007)(52116002)(186003)(26005)(2906002)(83380400001)(44832011)(7416002)(8936002)(5660300002)(508600001)(6486002)(4326008)(316002)(66946007)(8676002)(66476007)(66556008)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UvgDqPQPLa94ZU/HvkamXBX5/a6y2vEtJGeb1urXCk+gxQsUjjJ9ULGD+Dhd?=
 =?us-ascii?Q?6vTdCu0kxy78fplapytncdHtZgYB+DkpzfAtAqe/8T4bsMUuhuGjL9v0ihX0?=
 =?us-ascii?Q?9aAJhhRxOiBVzTd0e3Q3EQQrk6us232//OAcd7V57XfTKmi1wuL1/9PZuNgN?=
 =?us-ascii?Q?n6llavZE+184wBHEt9YhDs0nWQMh5p8j0wt1YVIm87pcd9QgiYDwt8KiDNae?=
 =?us-ascii?Q?0IfmwIG8EB3IjuRnEAerWN7wQ0Et/6E4mFCse2LVuyFW5OtC2llEdbrwBU9m?=
 =?us-ascii?Q?W2Ptm++IQ4CH+aXVV1iw56ss3ePRRawm5dPDHMNXllAsLTqDn7cSt6P0ye+i?=
 =?us-ascii?Q?8oYLjPtWcQhv0KWbrAcDsSaculBUIxJjTEaG2UWE3cG6T1MHPtElptW5TwF+?=
 =?us-ascii?Q?cUmpoAXUxrKmFE05tLeeL45Mg0efRab9Jhq0RBqYuy3TE6xTbaJAm58s8vC4?=
 =?us-ascii?Q?kwfBURcte0JZo6BqSLF+xWfn/5OAVkX/a434JyUQwlSSGPUU0hu5aHBzwa9M?=
 =?us-ascii?Q?3JvV+ML6qAsPj9cpER3IUEfh/mTb4V6Sm4GcPK3nqWYkIdFUDRKv709k41Rn?=
 =?us-ascii?Q?X+x5FiXfLAJ/fdn5w4iBV03692FcsMrkWHH4sJvxjCavTSMGljlYBxiV+Co5?=
 =?us-ascii?Q?HCR6sfp6jDgvM9V2htVuvIW4DnKC9WURhWRULfjxnAsvqAJ5ZntCiSirw1c5?=
 =?us-ascii?Q?743dA/d5uERBnCHQhjgs3io2Qtas1kA7Vzbqc9gCdx7BAAVWxgAIdUjMJdZB?=
 =?us-ascii?Q?E2XFvQRdX64lZRJXcojowdC9961nTHw40AZ9YW/rm6mjaOrroe/2InNyUXMv?=
 =?us-ascii?Q?BcLghdWg4ITJHa+D39KS6uJvk7UgPrPeJjCU7oJRt3XUkK5lIZXm51z9ReNj?=
 =?us-ascii?Q?P0n04qTSbPp/t3W3Puc9lEbyxnJTxMD1yVu/zobQ4lEja3rgYpHsGlbLa9ig?=
 =?us-ascii?Q?ZYLX7qHhGap2D9OM2t9yXeF1QBmrP/xrCGDxjEYlXu+O44F88al1b23+7evR?=
 =?us-ascii?Q?518yu9BDgE0f0qsQyOspsA6qStff5RMXikatGAQdy+L2wp7mvylatSIMdv1p?=
 =?us-ascii?Q?R84/Rx+sDN+w4RnhM3cD2uHnL2Nld1grn///WUpt5fq9sPbQAOqIprDKTNM1?=
 =?us-ascii?Q?cRSoVgbBRfClFlvKsoYqmN86B4tW7uj2Z3Tl5ZTikjz8CRLPRfkDjUwltniK?=
 =?us-ascii?Q?jtkSvsDgjyZYQRS8K6D+hEEGq2Z/DgosvhoqZeIYqfd/zbpEM321dPM/x0U0?=
 =?us-ascii?Q?gmXTl6h35SVJxiDsboy332ovN8oszK5aQiKrZHpJX0xvWJx3tc+e5lMbE5G7?=
 =?us-ascii?Q?J9AQxzJLmtWVJA7U1h0PDFg0saHp9Ct/d7zOmwTf1Lc9hVov0/Hh8dipztqy?=
 =?us-ascii?Q?/iNH3nVvpJwRSHp6Ft55OmQRNHmvcLGfVxHTaIfCgG1Wo5V0XFwD/QNYR9/V?=
 =?us-ascii?Q?5zA8av8Th2RG6eEgA352inY2uV2/haj/+AWFLZMbdM6NvWgmu81tzWpK/Plk?=
 =?us-ascii?Q?CdbOUCDUMkDtbO/zxkIlXrLT2Mi5aHPnQ99Cl6q1XYg0pu53/websBHWgZ2W?=
 =?us-ascii?Q?hGraw9uQtfy/gpRluHpd4daWUl7eUSi3xoYk8eXlu8ZihIkaA0A+gm6pooBb?=
 =?us-ascii?Q?9ic8/KcHDrzcE2UDzbq/zXnYWiPXeD1wbugnHBnx2rwSI2hrlLI9wyxayQ/3?=
 =?us-ascii?Q?RsOmcuDwvLl74WN5Qg8V3X/+h4J9N0etRFZj+SHetLHQvBQTc2quOFiSfiqo?=
 =?us-ascii?Q?BtDtJFqLLQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1b6e2e-6096-4a9e-c9ff-08da1c72817d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 10:52:15.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgafVrFUfAsj53J8udtM8A+Vry8Wqn6G8FGtM/NnuPga00GtayDTHlQkOBS6mDfkVs9guTm6YxTH2e1aA6A5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2394
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
two fileds sequential into one buffer, top-bottom order
so the filed should be set to V4L2_FIELD_SEQ_TB.
fix the previous bug that setting it to V4L2_FIELD_SEQ_BT wrongly.

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

