Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670F658662D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiHAITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiHAITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:19:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684453AE48;
        Mon,  1 Aug 2022 01:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bieI5xIrnB9J/fuQ7v4R4sMxBKC9gGrGbptTajNAb6JMLg8BpcfgZPQNXNBcYSNV46XxgPQvzds/UQQbAjDztojLXBetfCKHQCZK6S84qU8ta4Fua5h1DnFIQvK49qktBVL1L6nIi/fR9BvQzvLHh7ykNfkXQ0R8C/U2FzHcBMzTKVRwmNZUBSLtCvJt2ceCvPVF0TBKtUsoH6ymUP80b/RFzfN9NAWzFxVEVJvl9VkBhNjqVJVe7jyjsy60lrDm6S6034YeBjWnbIYKylr22f0ppLXoslVf4VKKjGzYnXd54qtXaKWKVY4LKEZpQUDGWYZ+cN+dBvJe6khi+gka3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=ZEnmvGR/VItkMl+1YQ+up4JtYbuEyL06pbTA+XMA1pRdAWZGeY4xY2ekfJ6hiZsPY/l2hh0vP1zUrlIXXlYD9oE6URs+05o4gvp2NKzdOijdl8CppTuvUYSvwBogP4dxKWRkRVNZMUSA5Ni/2ooIqncrJ7gHnxgJ8/mo2QLS9ugEr4bmijLVe6csUqemUNPN7Q5Jz6VJxnKnVNvUSL6Nsv01rLrUCIBol90H8hCasWZGFnBb65tkKUG8lK7KLMgW3Lbq5bjWhtPYz8jtNbqp5aiWU19yaOJzwkgzBgTyDTPv1kotnyZD6C8zn5FRDj9UxEx7/GkP0MS+PbxbrvTnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=PR54dsfscRBijxL0los8Xb9GFWbpIsMSVciBJiRcnKLKscArFFObmkS32TVbAyxtXANNcjZRT1gcpRHuBp4M50xjAWuaKCKUhoys/t4txxfqU4DlGpcJRiNuWJvAa8XfQUO8yejIAhXbuEb7+S5UNDiHJgRL5JC+tfEceSYgaF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 08:19:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 08:19:02 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] media: amphion: decoder add support for contiguous planes
Date:   Mon,  1 Aug 2022 16:18:04 +0800
Message-Id: <5d3a7534e265a644d103e07821f3e5f905906bda.1659340974.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659340974.git.ming.qian@nxp.com>
References: <cover.1659340974.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb0e2d0-4223-4361-ace7-08da73967e13
X-MS-TrafficTypeDiagnostic: AS1PR04MB9334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIq8BMRJ66duunXTskmOGoa5jqT768tOjDA5GR5atZafF+CzUaORWMKYy4kc4aZV/hBrQxL+9dLLKn2639EfPEbGwR4//JFLRITqq/BFeMz2nmBQWyzdlDsWVTEkNPq3sYCOwO+OtU6GG7WlYhKf5qS2mrdGbQWj4NXX5ylzpUviVfI6CHxuWXIwcdL+cCGEnzIK1nb2flaBGbxVmuGgQoai02AY0xTmtdrh7ifUd8MfF1Fl4IxPnDPEA9d4oWBF1Zp8pwvRvBqmqErVGNB4Vfh9qQc0snQOXCV+c1/CRmQGUITlqVKXHaLVouAEKuVnrQWOrkM2OSGU90REAzgHMe9C3AE7yQIM6KxwueQzJo+CJZRlTowQUAoEZ219qOKLIR5wtrCy3ucl+Zuhtae3oQAhs5/vhGcHBzdEFsmcASeCvzocAXYj9/UjpwdDBbL7OVFhZjxNjR116F8tNRpQIZS5Lu2wQcE7lP/EgYHIpg7oTydtOsRZfegnKjE5/4NxF9Bk43kp38/DAiTqYSoC2k7VqnTyJT7rQvpehO1bOkpNXkvdOHxRKPvac+lNmRcydB2kt0LZc92H2cJ5is8JJ3wt9v2Fe0FNfvAf9Ru3jcw9nqM9Aw56mqph2/+wWV1EbmglW6VOnTMyLuV0v7gIQ9w3v+t7OojnyRomisd8aEtCpvI0I8Xeeo0Xu1zOZe+rqEUqMiaxtHKazITFTAqYVnrjgXZivCELORYbt9/aC2bG9z2c0roPF0wGqxa6kKpBjKNF0LMAwxiHSnI/1okiCXzSua9RbUMIeHNd0jnnAstxdnF+RhkUvXFm9wPvXo5g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(316002)(6506007)(6512007)(52116002)(26005)(6486002)(86362001)(2616005)(41300700001)(38350700002)(478600001)(5660300002)(7416002)(44832011)(36756003)(38100700002)(66476007)(66556008)(4326008)(8676002)(8936002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYCLoBstIcja5182ZTR+fUwhUmlT3gQROYlt6e3B6MkMrP57+SpdzWW8ZRUH?=
 =?us-ascii?Q?N4Uetf680EX8OE5Wh3x1RcCS9VchPZ/Bs2THHON/pdw4TNsYCnwaP7riYElT?=
 =?us-ascii?Q?MBSiHSAk47hgydZp7SsLf+grza8FXs/Xhp3Obzy4HwiHUa0ewAXqoX9eZ75z?=
 =?us-ascii?Q?VG1SjsgMgOUWvwfRGNFkx8zX+lF+EwlCA+rgtlPOUpmfEef31zcdSOiPW/rs?=
 =?us-ascii?Q?HybVju2sow8ClcHu3rBV1c2nfSf78sUiz40R648RvrQnBRG6TTEZSL3gUdgH?=
 =?us-ascii?Q?mpsMXJpbficYqieHxMOFGxAFI7Ujwy/vRRBNh21SGt5fl436F+48MSCQrMJ8?=
 =?us-ascii?Q?x2AyOaPsn7KFlEl06n5y+U0rCzWq2/R1Jy/wcwsQs0nhT2dtEsIC4b8XTP8Z?=
 =?us-ascii?Q?w20TnphnC+aw7S4TTsnkFNV7oQRNg8k4E9oDxWk1VryVWx+pLxlHVIXzrcuA?=
 =?us-ascii?Q?l6w8NQFRXd0sCiCX2xxlIhDIh9HAXRmXnWToZMeLXAmEv7qsMUNOtWbQLKd3?=
 =?us-ascii?Q?LCkCftoOEbXp9H0sIuyKXK3LXaQMM6scpn52NFDoa/GD+h9zNNk9tbq/Wy7T?=
 =?us-ascii?Q?s2803V63MDvO+hULgLbwTujTsGfL15bKFDACe++lZ8z9oWVuxOHRnel7avJB?=
 =?us-ascii?Q?KBbrt3xZ0oYfmlrtK3yfWRWTML8t69eWDxcUxOI1/TyatnOSAjEoD5wRjzQY?=
 =?us-ascii?Q?o8Mp6GaR88GhcRBOTumlaGbGbXMNa1N2ujrZuGF8zWM7Gg5CmJ2hDHrijpYD?=
 =?us-ascii?Q?+rjlqXQAKQKhaZet2eRO/g/BHaxLn9a1tH2F7a8LM7w2r91soS4+0YKyDYeC?=
 =?us-ascii?Q?UptDGD9a65GPsNx8z84nY2b6yZCOPoumCwAflgdmrwRldgWra3fzxTiwj/c6?=
 =?us-ascii?Q?Z3z/bAEGYsNDZdB4hElcJFqrYFZkrxp38EcWWB1f4J0J+MFMGKWelJ6/rTJ1?=
 =?us-ascii?Q?jFx0rK1ps5Z+wthx3J3w20TRHY1unnYPsTWmIH34Nddgd6F/BSz6/849TM8o?=
 =?us-ascii?Q?okOoqvfDmsailF0zrrU7OpUotuxetv+4Pgwyo86YC3uLw2yzeYuHjYO+VyP5?=
 =?us-ascii?Q?7RcXbMutKhN7MAJ5FkRqyczTZGsGI3pXF8RHUPCjYXMz/iD4eH7GglsudJIA?=
 =?us-ascii?Q?2QNMhYfg4sBlX4hlWtLLmJ2oZJ8qYGot17BQoDAezr8mmEXMKEjkpgJDbqR+?=
 =?us-ascii?Q?utY5wS8D394tq/qqhtvsDJ+csRM/rShfY58LDz/8Z8ahe6CuBXrUw3eXWe08?=
 =?us-ascii?Q?GwevKhGz5VV7utCnq2SPBrJs2/RtkMwSbTynf3aUkbyNZ0gbz5UtB3Curpxw?=
 =?us-ascii?Q?NALW4WqnNAfJ78o4AfozGhpqO0csiz0Dup149P9SkxjfL8ex5YVmZnh/G+Tu?=
 =?us-ascii?Q?33pWe+PxHM/1sbFyhdlJcJg7u7urb5AHUFlIUz0xuYxPBf8YPUMoujt5HGCn?=
 =?us-ascii?Q?necBc/UjgDZqzFNHDZTOdDlHZFqAarEcWU4jaofnEXAha3koh4gWvTOc3xL1?=
 =?us-ascii?Q?XqVAtnk9wQ3S640mbmbhUg+jWR/04HIB0qu+rwEsa4dMqPmjlc4882xl5EU5?=
 =?us-ascii?Q?Hsy3LiXCXIr5xwEm0WBJJnFifXJkvWGJpcXg3nh2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0e2d0-4223-4361-ace7-08da73967e13
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 08:19:02.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uED1ra6TIWlzc27xn5FjPL6w/YJm7SEMp84O7ZSafTGQRa89q9B5RFuFAjYMXOHoCoov1nMIez83/5rB/Ah8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decoder add support for contiguous formats
V4L2_PIX_FMT_NV12_8L128 and V4L2_PIX_FMT_NV12_10BE_8L128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 48ab664fa7ef..9c3324717cbc 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -72,12 +72,28 @@ static const struct vpu_format vdec_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_8L128,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_10BE_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_10BE_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_10BE_8L128
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

