Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6F54C018
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiFODUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiFODUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:20:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04C4ECF8;
        Tue, 14 Jun 2022 20:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT1OI8COVBPuyBRT9rgUq1lZKHJLY4SaR6O4PbwuzqDVP9Y11xDBdqUfu7+rWkmt957d6HXy2XTcLihoF7ALeMbpSgDpF+C9iD0nL2LrnvJb/rgegknYq+yDoR4PePRcdpn3YE8cbOzbwHU/r8bExstiqR2xXpzHV0xD70EdKaqnKlvieyBkamwScfyrTswrKldoBU8NsPxt2WACGxwR7LYQH+41qptUNFIF6WE25N9RdZzjZ0h/qWcTigw95jWyGY9oHGxAgnwju6Fo9+o9HoboCVqP3NXhieWXX9jYesN8lXsROAj2luRUuDGZ5zm2noxI/G3ry9cyF4+QPzdGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izeN58nkKvbN/2XuBE3XQO8CoWEKdNWMsVYbjhuBz9s=;
 b=YlSgFYwrvZokZjgnNeD3nPilbOVQ6hQPZ68NYYZ5F1DDL/E785T7UIhEksD/NrNYuz5a+r+GSVqqAyA477kJSCmzEilcDaM71YoPEWa/DKiTscmEnQ0WcmngVj8Xy3RNH0KBIsZcyl7h/uqBRz/QzqWSJDcdTql8v8fs0K6Z+MTpskzYdV9E0PtnFCIirTI4xywuy+GNWBycdCc2LeSB5qqXVy/cbsIOAMx44C/Ue7U2rRd8KM9KTbRc8fMUJMU8BDhxlEpEEuFL/q15Qy4+A9jIeQ6c9CHna4XfBKWJu7nz/95Y7INXIf1cVh/TFjaGrxQbQOYdEOqZTtWSv+m5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izeN58nkKvbN/2XuBE3XQO8CoWEKdNWMsVYbjhuBz9s=;
 b=bzWpPF+M94ytVmlQnBoaNFTIIJKRYFV5xU8f1ItG5obTjiKcKm9Ijs/bxFII0U6NQfht8qqcKt/9ZfIlBKUWf+RWeUOeJ7mRJh/UXp+q93TFSQePLnl5KPwoiMrEbPz/cLCUJetsXTFtH8zrmnmD+qgGlyMm0igraOYIrLVcbtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 03:20:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5332.021; Wed, 15 Jun 2022
 03:20:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: v4l2-mem2mem: prevent pollerr when last_buffer_dequeued is set
Date:   Wed, 15 Jun 2022 11:19:20 +0800
Message-Id: <20220615031920.16118-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b6b5b3b-c7a0-4977-de32-08da4e7dee51
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB89587E0A70694C68E6462B7AE7AD9@PAXPR04MB8958.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMRl37RVnc4rJih4t9vHhwdBhm/32R3gLjXS3i01wM6ZovxU1+gswm9Slk5KPBFnt8xsYBdmI0aAnlRHLs/aRx8f8gZq6cDM2dORhOIDRRcKQySADrV10isTI7D0uIX0dy/l3vdf1Z4RpGwTVvwnTkhc3pb1Ihfgagsp6mmeojMkDbxg5aZzHhNLPEOejOZbCQ1wC36O1BrfYqzD/xB4k+6boNz+w5a+KZNzPW3PgkIoF2LnODUcnwAP5fkdHLPa4PLqo/80MG1BtHtJkmB6lX8KuSSrUitl4fJUpaGKc1Ad8MAScNiMP9opiRpRHgT9Sjx0QH+35r+2lFzLTUjTLtOkolLpNL6BqgaptFl//T+my4T9aqi0QehJqKPHLIFNmzXtKix9Re7VMLErfUKZGj6g3D2ooqT+bMee65qUICALt+FPBBA2h94l4Cl9jEJc+tAOv5xmGdIbn1PRCejUmwqMiilh1r2hl+ao8Xn5j0mQXbG5ElIrAgZy/2R85BbHyTUWnRTqfbC0LRvFb8unXCB2ewWWjdv0M1vJ0ltbkyW44RLyjyUNsIHB72QMdF1z+bhCtPoZqAWZbSJAcPjdMHBdclWv5qE3sbv0HsvE8o46p26M3iY8pcnWEUgoDmeuBpfGN20/i6C+XLHSmOV0Zek+t0rsEcwc4BWinlauRxkIU3z9VfPGMX4KFxmulgFF4FC7noFVkWW504S+M6gv0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(2906002)(44832011)(26005)(508600001)(66556008)(66946007)(66476007)(36756003)(1076003)(186003)(83380400001)(2616005)(86362001)(38100700002)(8936002)(5660300002)(316002)(6506007)(7416002)(6512007)(6486002)(38350700002)(8676002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NrMQ4iG0FrwA3Y0dG9PzhSwm7bL978k5mUXERHSSyIgH9Ee6Zkil9R21Og0?=
 =?us-ascii?Q?oE2T5AWVVAEe8mMs8ZfiSY3VAdPjxTqpjhjz0OEbMRP1uZHyKxMrJhJ6cDr+?=
 =?us-ascii?Q?6dF31pQ6UUHjcS/8EVA4u4sBet7dtJGIZmnxrnX+Z6zadzr7tLpcG8+aIbF9?=
 =?us-ascii?Q?dubjIJrJC3j3YjkHupymg4DZIRvEqUxN92HvCdxotaTIQl1qS3qOLWyPOdPG?=
 =?us-ascii?Q?EBSAHBTK9d5HS8DqOXo/3py5IZoptQav1mUEGd3YvET7qVQ6T+5fcp2xDrgd?=
 =?us-ascii?Q?mJ7XIln5o/V6F4rWlr2GlZ84KSz+NJA2xBWtEBZvWOdlyeugHXsd24sIy7Wp?=
 =?us-ascii?Q?DRLe2Ss+wI0YED6236uGmGo+UIGMj8wTnk7nLmCzam8+DafQpvMRU7Wo9Rpf?=
 =?us-ascii?Q?hlyXMWlxkCSJdiuc71Mv9Jtg9iMXA1BSe+ib3Trl1T35TWkuDT9iQz+oSXRt?=
 =?us-ascii?Q?wiKGJM3ptsM4b1UqQZCdr5TYm5yDimmalNRGxcRud/w5gs73as+QlvBR/0qy?=
 =?us-ascii?Q?zPOkeeFp+g8NbonRWON5C16e4C2DMelEa7qElZyMnfo2ORVHLVS5kxieHH8X?=
 =?us-ascii?Q?pdWYVXhZeWHvIYNgZ5UWZ6C0ABkxNKC9K0LItt2+xag8cH65Ob4TFRnLLMhs?=
 =?us-ascii?Q?/nOWFTANB7Cd9F7BnZvI17lXruGxpF/z7nr/14HTzcfe3WljWyOpEJoerEqg?=
 =?us-ascii?Q?jEyPPdv3y/6cJsJ5jnGAbGk93jxz9uHuBGyFe2W23kk9cldXzBoC3ROhekhD?=
 =?us-ascii?Q?KFe1H6QLipujqrohC2DH9yGuRVl9xtz84OG25tRhjC+xv/fXFWu+c2+N5tXt?=
 =?us-ascii?Q?2gXFb870OfJnovVZ44PxGjNPVsaqME/C+VeS6iVK5BJLT1Js1bFGxuu4TqrV?=
 =?us-ascii?Q?NFOpha1earvxCewiL580fchcQR6txxpHw1EiNvmjvfP0U6L4NXqG6AKFBw8D?=
 =?us-ascii?Q?YdF8Eit9L4KOpSL5ySjAHEdUvOJ40fKZ9ktHZFLz5bL7lqF9GU5ZoQ48APW9?=
 =?us-ascii?Q?f/MTTnDvEPEJ/nvag0no67vOhTMrZyXMVI2Nf12eTs/5dYFFMLYkDU7uv4Qo?=
 =?us-ascii?Q?A2oK6QMjxqQrNOMEX+F0+5RP9Yw7PeHkhN7X4d/5tZ+q3Qt6SL2ECIQW5oXz?=
 =?us-ascii?Q?7Cvawb0cD/z8iq1T2So/teefyeGMFlRPOKfBa0ZIjLVEXPLctrP09s5m0um/?=
 =?us-ascii?Q?a9hDc9TZANcRwpq6JpY3/YyAuNtBmHrd2L+KbciltWdyPzKAjXaFWuC501ip?=
 =?us-ascii?Q?bcGocZWijT5MlLwePyxf5485OBie7ng9OFGn6L5lRdvu/Aq0LQz5PF7uQfjB?=
 =?us-ascii?Q?yEbDRB8HQffDgzgi3Qj5BkrNPBfLkNce+L9OxTZ3cqnDVcY6CFKdzE/Wqhz5?=
 =?us-ascii?Q?sSjTtZ0N5J09jKoMMhvmXK7Fysd+wNT6Z3tNMlzm4Dt+nqoc+/MOngo/IlkZ?=
 =?us-ascii?Q?pUMeKIIkdG5WQmYo4Bq52RZjW+WndEsqr/Qn3P/5H+n225IJjFdMrUTN40dx?=
 =?us-ascii?Q?vrcYpf1gVhX6JfJ1haKwar0PJxKCwHQiGnSm9b1b4JQ1gBg9RvCE7/m+/9BA?=
 =?us-ascii?Q?9X+zARPkFTbI8sA52LEMgUSRkbzwRBQIHvAUD/uT9tIUGm4aa1EF2IyvIiTW?=
 =?us-ascii?Q?n+smKz8BMxIXKyMumQh2IxAuAj5Omp5pA/nZToxHw2IgiiZYSjjZuuXfditn?=
 =?us-ascii?Q?pPJX986B/Eehc5ULdhpFnUcPCKgF3Ai1WLAvwIIDNcSkVZqYqmQu2tZdpc3c?=
 =?us-ascii?Q?FaVc8W6abw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6b5b3b-c7a0-4977-de32-08da4e7dee51
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:20:00.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJo50EfOJ43zOwnz8fDUX8ynvH/pubsR21STMUZ4QyloWyuDOa6Vctay14m9itz/8BlMwPmLGMeRzzDCBBxXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the last buffer was dequeued from the capture queue,
signal userspace. DQBUF(CAPTURE) will return -EPIPE.

But if output queue is empty and capture queue is empty,
v4l2_m2m_poll_for_data will return EPOLLERR,
This is very easy to happen in drain.

When last_buffer_dequeued is set, we shouldn't return EPOLLERR,
but return EPOLLIN | EPOLLRDNORM.

Fixes: 1698a7f151126 ("media: v4l2-mem2mem: simplify poll logic")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 6469f9a25a4e..837e1855f94b 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -925,7 +925,7 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
 	if ((!src_q->streaming || src_q->error ||
 	     list_empty(&src_q->queued_list)) &&
 	    (!dst_q->streaming || dst_q->error ||
-	     list_empty(&dst_q->queued_list)))
+	     (list_empty(&dst_q->queued_list) && !dst_q->last_buffer_dequeued)))
 		return EPOLLERR;
 
 	spin_lock_irqsave(&src_q->done_lock, flags);
-- 
2.36.1

