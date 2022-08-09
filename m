Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9358D40F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiHIGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiHIGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:51:40 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00082.outbound.protection.outlook.com [40.107.0.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695D205EB;
        Mon,  8 Aug 2022 23:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPfzgGG2dUbbX4pG8QniLQLUJPOZE8Vdnv3ZJPZB1jaTK4RtZWY3AANbLQG+BR/ESchpKPgMiarO5YLZGludRSXymO6E54xvY0AVNkhiDaR/J30NJNn8BL4vd719VAQ1DEJgBsTyKNJLeJXWxeCmc9kI8FwlVJyQYCn4IQ1XoWw5IuAyfgLdtb8UekyG2OMmLNMImeB0fuSaQSwLJ3iD1L9qGFBXbaeIPdoZ5kz48GskuU79DNSXfYU1c+1ljQi4xjIKiBH2ucno5Bk1OrC8Kkc1LRqcVgT8aCHE8xXP4JoYaADq6fAcomhyqVI7nJnkNOXhqQhbRjITzNpO1leDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=LrD3DJQnFftDXf8pVBgyWm3QTYU9EWkUjlcgyCm+XgOMId5JiE15xuKFPTz4V+bT1nm2hSjqvxL6w6g7vRtcKhzCfDOheNncpjtghbZBpIllMNwEleMe3rHn7kFMGBAakm0No992hNSUmA077J8Abva9pVbSudFeWsEVGVh80vPf9mamhQdZ4bIyrkB/FS4x/oaIidAXeJ4s+jbUhUDQP0pk68gREAocpnCATW7aj8z3a3b6TWVssnHkNRi0iy+n+RafevwY368jmI255zhjFRiYFrB0c1MhHz2VinVl0h5xH/OCrBjed47oRSTxsSXcNJr3rz5VmRdR1o3lUNPEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=Nl9GDmC9boj5p8QpO8SVRniVbtZp++BkQ94bpdwwhB/8BTqsLzi1PQObL0D+k/M4vLTLsCL4FZ4FfN9PaXa32Q/Einj+NTq1Fwqbah4NIlfMrVSP5hPyW0JcIs0mflV5o65jj2sf5mbiT9CZXpbEPUEgco5Dzy6bm3FQQR+HzDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 06:51:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 06:51:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] media: amphion: encoder add support for contiguous planes
Date:   Tue,  9 Aug 2022 14:50:41 +0800
Message-Id: <c375506c02e6664580a2eb1cac559ab8dfd02552.1660027440.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660027440.git.ming.qian@nxp.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bb977a-1be2-49a7-7b24-08da79d39aad
X-MS-TrafficTypeDiagnostic: PAXPR04MB8991:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7Eyr6jSz3kPGQTkTYzoW6uVnViAsHJt5ZjQ8OKW6x0f9CRJ5nnDgTqfSjE3fIzAAzLuHettHsU9Ylsogwffb0tfaVcjMv/o9JppiqroKTviVNj2ACkCDj1BR6z7CUJOkcRIYw/71NTkPep2BEB7Yp2HD+I9GKZrHaxLPl5hcHeq3n8pFXScLe3OQezD8RzWOZMX6aPH7PFxY/Hou1PC8t/Jve3BHrPBJs5bc3T1UeYthsenXb/LRDc1l/8I8VVaKv35VuHtQxcv8rtTmWKAPGvX5/TcPnZ/3R8bw2F07JZUCuGCPVRtM82QFMr+ylTafrswHgV1OKzFNVwXxCWOMXfP103IvK3tzJz6IIYwA7MFFTMCDESUTwxKJ8/n9usjNiWahFhPe+uVk2WbYSvAqf9bHhBlopca4qZR/mwn18DmV8DDySqKHCvNWia9enDwEGGRABSEq+E0ovOqk37yqL8/pMkFJzAakX3OkwIsP4ZiSrIQk6PnlHp9OdKUN7ZVjFCgShHGTWpEFlyKrhe/Gi7xDFsHuRBQ90OyyARe59hpn60PMeYUHenXaGrYVs5DMq6dIt5FnM6r/YPi00vLiCXP9+s6VWC0sYp59DepT1YyvJPkQS3XRGcvnDIRj0TNs5c1Exn8uGSp+Fs/nk5FGzBl97gad/EHaMCeIWsZGn7yVZaLDW07igKEp241Zsp+tl9JJIc6ATxFxsDkIE2kYXBA1RpguKDRLPNE5azwXCHpZzcxLcejpd8XudxZdNYxw5tuwVk6qilVa197cCAqqztTFmK7t7rCCZN70+ejU7E6AJXXzk31ClAGqpEDhOPG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(7416002)(36756003)(38350700002)(38100700002)(2906002)(86362001)(66946007)(66556008)(66476007)(6666004)(8676002)(52116002)(6506007)(6512007)(26005)(4326008)(316002)(6486002)(478600001)(41300700001)(186003)(2616005)(5660300002)(8936002)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsgfvROzR8j/VpYypPEBc8zW0m/BaU/zF5o4l7bMf5cBTilc+JVflE5u9JIz?=
 =?us-ascii?Q?5dpZvmy+lX+9q/N0H+sbn7iE5rIANSrL9RGXv7lNESnJklYAsQFxyfxbO+TC?=
 =?us-ascii?Q?fbJ2E6oTI59Iy/2TXe60jwYH26+X2ynW9eH1lsQzs+naoatvy/IuC4qg+YlE?=
 =?us-ascii?Q?QyBrRTWG3uIfOPGAAnwERfo6qLSMCwCAXn9lnSkj0366663cKnihqk8lC5nr?=
 =?us-ascii?Q?iPbRqJRP6rvPJwFS3m0iGdwj6dwOYkv4nVnu4Ox6qyrVaXHS1XOrvfECzY17?=
 =?us-ascii?Q?LxJTzeVT3q3eJP6mYVsbOlJJXeEYomqBYem7V2o0QR4v9a8E63U9umTsuS+P?=
 =?us-ascii?Q?RmM3MAyxXIeBJTXA9saYQL/VvSrJ7oeLvS3ZkfPOAqE+JCL2XqFPPtWhsWX4?=
 =?us-ascii?Q?vUiFnahYY3qATgfPj9M6MZTTHoJa3bVdBlCOUoEZOPcdrbIydLnYvebVh6qo?=
 =?us-ascii?Q?Eob+E9A5hHsdlV7k4CHAkgXk9XsKAUFkbiCUuc8vkcCwF6g/pUhn7PLeAObT?=
 =?us-ascii?Q?EZjbdlYevv1fE4kYvm9G/avEUeMTQT4xtWQJLcBieR5vE6Jrd9t1a5rf2N6K?=
 =?us-ascii?Q?4HH2p/G5S1DLkFIWJzfI2LZ8x8p8EjK2Wff8mUqCXM93LmRR204rrAXQu5E+?=
 =?us-ascii?Q?6aOOssuskFTOQo3gfeJ8KxpfN9Rte+vzAu3TbjTrdQBw+gJiT5HS4wd459Ps?=
 =?us-ascii?Q?XFEy0I+FpH9tO3qSAKqUOVflTzysXegoYHNoUvXChiWn5D4MG5E9xEMpEc0+?=
 =?us-ascii?Q?S0T7gtSuLi3DuhqS/W182hfVUY84PQcmcaPe2GlNO2752wJRH01AWLfMyyGg?=
 =?us-ascii?Q?UgBx9nLdmwZxqpXqseRASMaspTNm8kNYd6hEKYGiYoEyc3pjHGlrnFvTBVo/?=
 =?us-ascii?Q?k10yzey3xW4rSUDI/fBeKA8NGL6FvaDQDaJCXzTkiT6DUBOK64Qj4wuEQJR8?=
 =?us-ascii?Q?74MfcMJq/2rNq7h7jeTqYjY0EI4Isl0ZDwaYgXwwDZDD5R5XmKSUplRhyg1w?=
 =?us-ascii?Q?9OljxFDP2c0xWhEZNU2kKmmgYX64wua7RQrFTyCLbG4841pQORyrHt9Qp3/I?=
 =?us-ascii?Q?P4mKt3LyM9RCI2GeCNjnHkWFswkOIF3DMZam0WxoALheMV68WxIg6x2rBQxI?=
 =?us-ascii?Q?JeYvTo62Ql1bQPsYoFm31XzyrU71VXAJ8by4E+hYcKoJuCRZCKMy6yBtHElF?=
 =?us-ascii?Q?DWB08nB1xQf0XMEuaDIxeEpJZqGp89N6wwTdOkHqaTudxcOoadEDSAXrGLbf?=
 =?us-ascii?Q?f0cfvtFF9mIbUqsnASOhofs4nMheqsN0CAQlxa3wzDiVSa84aQxKoIS/Adlr?=
 =?us-ascii?Q?aRXqvkLeh8Q0f0CTQLiTZ6TcDkaiXALhkMMOMTEUMI+XJ2io1+VBYk0jlbkP?=
 =?us-ascii?Q?urbVuLMJvKFqYqS4C0bsw5na5WkzuVA9WG7xvvmWHi/dyP6/P5NzumTbhbgz?=
 =?us-ascii?Q?JU0rf5AJv0nNriMjtF9KkPWJTZIYtmGIXLKeRc8P/PNMwGn6A0iFjFjPxyqc?=
 =?us-ascii?Q?yGTyAqkQLQB2I4pPVTsH/ZdKOBgNy8NcpnQUe++1eK9o/nJc9EPNhQ0gDucb?=
 =?us-ascii?Q?zRjjTZL2Abz8S6Wj04V6zzx+fM+kpclANAO6qVOS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb977a-1be2-49a7-7b24-08da79d39aad
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:51:36.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oXwmDzdXa6Ic+cPa/+1ig//laDteLIkrauuXv0CvENjBifnBR1i8Wreh/hsirASy0PQpxj1nV+LC9TLe98uYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encoder add support for contiguous formats NV12

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 060a1ee78b17..3cbe8ce637e5 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -72,6 +72,14 @@ static const struct vpu_format venc_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

