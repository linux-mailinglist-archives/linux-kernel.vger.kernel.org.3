Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDF4D4088
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiCJFD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:03:56 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300115.outbound.protection.outlook.com [40.107.130.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A801142
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzDh6ysM8ZSlpSchVBAgTHLcldxx7L4PXWMsD5PWPYNloA1LcgnT7tsvjs42R4t6MFPEU5W+D2bp3xq2cnAS4IlDJjoH/uZY3TdbYTHtU9tVhoPUDYH3NWDMxT5fQvkUPdbheKHCeF9iHMlj7NfePfyRlCuTZKFOwLo5H1eg+h7Fd2155oKP5A4dw3U239Xn5KMn9Sma9NsdnPIwdPlOjt7XRWyPJpqq32EH2mKp9qck3LisF3FVcUqo2N/xacQK9bF3/4AxO+M+TLpTueAR90fTEOe5EwO2S4tsHATv/b/pfLdYosYjm8CGNXpTOUmG5yrVZBKUAhWN4AiFEuQ1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qePHbvf7Etl15108MplvLpFM/eFIOy3qxdLTVidSBT0=;
 b=JVhQ5/r9o8fpFNrSbIDX7zZW1EMatRgb6buelpOZmak5yXAfbVjRuGVWpk2reut3ZIMNqp0j3DgLQak7sanXKJ4g9D8MOC8Nd7UxiGsnHD6pFecebtknxgoxmVq9atoZgvxD/4nGpSYwa+qubbYIbJh3+ly3kGsWNws3TMOrD4Lgj5HEHF3+ZpaI01MWju7cVJt9NvmsAK6dAbuRRTmP+8JvygCU1BSYW6lwzRc9YRv8VJ1zRbiglEbXNOrXBAKN5XSXmbKTugOL/50snXgQ0wFeQp3YSFB3s0bRgoVqSce7hi6dP5xqaUxRKh9vZaCqxI1DZoSqocIGeU0i25jXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qePHbvf7Etl15108MplvLpFM/eFIOy3qxdLTVidSBT0=;
 b=n3Toe7bLxJqDiDTF3xVZ7Vh3vtykZVB3UBTQObCs18RXzJkejl8PO43dgy4cV3u/hspjVWIDD4DJOq/JdcKuaeojOiSXk1/kFDXvHoZEO3bWdUVUIb/oSzRoBfLax2G3uR1NUIuMx7g1X/FNkIf3i0rr0kYCI7t6LJXQ5uQjym0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEYPR06MB5326.apcprd06.prod.outlook.com (2603:1096:101:6b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 05:02:52 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 05:02:51 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/APPLE MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] irqchip/apple-aic: application of sizeof() to a pointer
Date:   Thu, 10 Mar 2022 13:02:38 +0800
Message-Id: <20220310050238.4478-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c55d8a-51a6-4054-1976-08da02533a60
X-MS-TrafficTypeDiagnostic: SEYPR06MB5326:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB532622D86319C48DDC10180CC70B9@SEYPR06MB5326.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecju8RYYpbMHVTu3O9hRYHWBjkxcz0MTK6ibvTPf08JKOWZ7bJvVk4iTHN0uoIUmsoAQI0Hmo7G9/DnqduPEmJulmfPQnh0kU6LKaEVIO1vTBCj43/b2UR6apy2X8ktO+7udB3BtBqRu6VeaP42Nx6O1gD2eRsJ44UGIgOFWFSo2OTWKwPpi9IR6n15b75BgvFSr73VfYbHLXjWY9IX6WHTUnuhDJVY9BuLD4+m3iq3B248JfIdl3Ob9q4PGnIA3EL+ooU0V8XK295tSTXQ8+X6zszZjgK/rpVLEhBUsiXxsgVfnuvyXGp80b/N2zDHUzPk40gYes+FHuk0zshThBnBsyBugfEshhqrbl0Cr7WGHYFswOLbuSlNu5WIATRWtl0UHlkObvgf45ZgNOgFCtz0gY2pVrNJjI0JkkTg0+sZQjTh8VeV6SVFo3N88pSNqEYoJM75JQ6WO1aVCvUosW1GfD8ECdGE5UVTJ6Q891RcdmQvzJWiXynYvRDMhdEBglXyhwKxYTccDccj7LJrwJqsWOPIW7RmQ/8p5F0YxDCY2NpIpd1yH2/7yUqoUFh9xuOSe2SwMp/zKGO/ZfNaEZDOvlFmtaL7KujV1eKeaeRK4CykPDiHHk9ivMgItgiXFCGQ/0JsoNRKLWdf9U2TSyErrDhgqUhkL9G+Ms5a4FaePPyf4qtZVLY1LeQsw7S1Wz6auDvqNuAD6fTq7ynyqYFkqFjHSXw4HX739hsyF3JLK6bJbqv1Dpwu2eeh/UuCTYnlqj8E/Dywt6N1+PKEVBWPWRGl0Ob2MrGjH8+f+Vxfc7Z9NZmcWIi/4mDvIh2l/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47660400002)(52116002)(4326008)(8676002)(110136005)(36756003)(6666004)(6512007)(6506007)(966005)(508600001)(6486002)(5660300002)(66946007)(66476007)(66556008)(8936002)(86362001)(316002)(38350700002)(38100700002)(2906002)(83380400001)(26005)(1076003)(107886003)(186003)(2616005)(46800400005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppB6ACaUV3sidD+2q9lgSwbnnqqoEJQ/58mgUJ8ZYNq3R2XszO7Ki6PwrfoG?=
 =?us-ascii?Q?pHfzAUIj9+qQAqyDBUqzcy0YcC7Ew0Xouh52J55l3brZLUP0zcgdHh67CxZE?=
 =?us-ascii?Q?m417vBGj6l2rOySU+/RIhyUr/7tlUKe6H7Xw9wb/8S401jzmD1zM/29DjZFA?=
 =?us-ascii?Q?QlfiBHOWq0/HrHvOsalWWL9ot1WBBXa0YFrEQ8DKr4fjAkeAjaJdn35APq4I?=
 =?us-ascii?Q?8xTI0tDs/oNb1JVCJ5CyEeEv1s5ilv8UZ5tSAE4Nu46G9iPGbeRkPDwMHWEv?=
 =?us-ascii?Q?UTOyUyxQKv4QzafrZzpALMu8xjB5y4PmrH2XjExIcf0VTJJFOVdptUyB5gG5?=
 =?us-ascii?Q?IL75+FaZXZ0CcZqyzf3gyV6YlkbbKjbaOEYOSvFkxCcauT7HFBoJaXJMKGGH?=
 =?us-ascii?Q?W7zpyq++WC5QBj6T6a94IvrcsNpNFpQ1kluXPCFkTEVzqmWcgdomrc1WsEem?=
 =?us-ascii?Q?7hs4AUphQ7olO42tYtcJ0fxqr3fGz0fGF2UkON6YvZ6a+L8GPJNWc9pOpymk?=
 =?us-ascii?Q?9ZLIer6irnte0s4xgG5oiZKA7HEcZKNwGFqr6PTyfAiW7697pQn2fTDmCwYN?=
 =?us-ascii?Q?37rkCXtY22/7Qqya2GxJBSk6KsgrEGiwZXaka61BOds5G7V/KLaWP2Q/sHZT?=
 =?us-ascii?Q?c9KS7gEF/ayiODmYlTTMxmesss6N2MrW5VbFYRgGWZ9S6MTBKvzUqGssBRrP?=
 =?us-ascii?Q?Bvo+aSQVZEJ5i5/m4XZUTk44+BaETXneQ8zGlfHYdooz10LLguNBAo06mY6n?=
 =?us-ascii?Q?+v2/hUtmajI+hClGKMDyjEY8xbkTF3+uetCjA2AKdOvsiDCeH5d5+Pz0FtQ9?=
 =?us-ascii?Q?t6X0G0rGuzVNPGu+K8wvEu4UlD2mErAKERmRsV3QPDo/6nvsMTFZrLexfCBs?=
 =?us-ascii?Q?wjpB9HnoJzrP3W81Ptfu2ZduYRZTlSWdoIOiPw0b9e8ETW75p1vuJL+7yzEE?=
 =?us-ascii?Q?LEzDpfSxc4WWahAd9kyNyvgy5DHL13LfkSAwhwRkKg/S4uvMEzusCXMefoGd?=
 =?us-ascii?Q?oYA1Tru5qHTfdIpEl0wZX5NN4jhk/d8TCyQ5txDcCGaY7hQG/UqPRZLrfqtP?=
 =?us-ascii?Q?qdnCybQfNxQVeJ4n7XeXjXIPP/yDuga8nqhQr2+40Li/NKplWN97UpBO8zJr?=
 =?us-ascii?Q?y3Zb+Iuoh1Gc9b3DAZnGtu/mwoM7EX70DOQ5IgJ4t0UE46ExXed08A+VmQpG?=
 =?us-ascii?Q?eex7YZfWqKGbHdiA6HT5NWGb6GRH8rpP+ElbsI4crN+WYaxBIrdH5QtpKjK1?=
 =?us-ascii?Q?JAS+GCxk7BPPanZ9Kx4+qorQTmTZu5prH4drcrBjHSjfGbu0Lf9RNu8M1G3J?=
 =?us-ascii?Q?864DDJodfiLdxftsbzz0mKr/LReuxgHb45vgDhB85iCb96hdglAvYmetv+I8?=
 =?us-ascii?Q?s5tij1u0YfLojBwTjEXEwCw/bm04T1HY9N+OlxqMQptFg6/CJAvxmDR4n74v?=
 =?us-ascii?Q?szrP4nzCFcQqKbhxKm/yJMyuHxKQ6KyT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c55d8a-51a6-4054-1976-08da02533a60
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 05:02:51.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr4LvWjGV47Kd4+3/GN/she1LrKfqbr1lY1Db4lauOnrVz3ByEnrbP79FsoyXCsnMtqD4ctuahxDSjaCY6ENtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5326
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`ic->fiq_aff[fiq]` is a pointer to the unnamed struct.
`sizeof(ic->fiq_aff[fiq])` intends to get the size of this pointer. But
readers may get confused. `sizeof(unsigned long)` makes more sense because
`unsigned long` has the same size of pointer.

reference:
https://lore.kernel.org/all/Ya%2FeUbdN1+ABFVWf@rowland.harvard.edu/
https://lore.kernel.org/all/YbBGGI9wQenI4kP7@kroah.com/
https://lore.kernel.org/all/20211209062441.9856-1-guozhengkui@vivo.com/

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b40199c6625e..23098b469b1a 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -810,7 +810,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
 	if (WARN_ON(n < 0))
 		return;
 
-	ic->fiq_aff[fiq] = kzalloc(sizeof(ic->fiq_aff[fiq]), GFP_KERNEL);
+	ic->fiq_aff[fiq] = kzalloc(sizeof(unsigned long), GFP_KERNEL);
 	if (!ic->fiq_aff[fiq])
 		return;
 
-- 
2.20.1

