Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F95375CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiE3Hrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiE3Hrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:47:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5B71DB9;
        Mon, 30 May 2022 00:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb29acZbulvMjKui5bGFMBpx7r5XvUHVR+Mp1d2EZ6i4BjlxqElOvweL9Wq94FBqzCZvGLiSdpo6jyBEXRIYFKPT5WjecwkaWTQIzrJ5a0pk9X8U4wd/kIhuUrTIvz3gygjsLAKkVIW2uKL7wiiz8AUzfQjXLPxxZZ8r1MnKhO7viiEKhNc/AoOKb5Fj5Jae1KxuIj7oAOxx2O4kUL95wt1qPZbBQ61xGT5JjRNeyS887d7E0EbeFQ8HG4tV4Kg3wP9TY+G47YS+xseyeZbo2OU4QojQ161LPgRqyInF4unMduuMt8lz4wDWlMaGiJGh4EsPHiih5wZJZ5tSUmHpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxqRgKoyfAgcmGGEkUFvd31VaN2xxPXhmqHvjq7X/Ac=;
 b=cqf+deBUnOc/TXVnsOhsEjvuhVzUcCHle67nKoO3lQd0CCgPpmglNVYKc7fCG1lVI3d4j472Sv56ubwRshBdlODu4lq1F+my6XMZuutd+pSiP6uUfAO/AYSVxTET1d1eydBH6h5qt9ZPXXzsIB9r0z8UiE0bnMmYTPf/Khp150YpJk+jqc15HUFUwKdvHvLNauqjqIM4xYYgymdchSCkPNAFtFJSPMInV44+mwjUvP1X/30gRV2wIMPuEAPw7PIqt/mkuNjvQKwdA3K58PmYcY2Fpdc88T6EGVqRok9fCqe9hvsh1xTOAC9WQycI8UrGYq/BhbtsGTA6sttv9zPFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxqRgKoyfAgcmGGEkUFvd31VaN2xxPXhmqHvjq7X/Ac=;
 b=tENpPTciMMP4NbA6dd8rPASLKlXkauSwPz90gqdaAP1aSUxlnxVlcg3Tv6Acqv9ZgIcnOYlD/ggXQYxQIQA3kiNlZLXMTqwCJsRH8Giqw/eb5KO21BKRV2X9YY48M3WW5w70UN6nCn20TDynM8ifDdOCOQ12RSzLSEgbKQBzJdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6908.eurprd04.prod.outlook.com (2603:10a6:10:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:47:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 07:47:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Correct some definition according specification
Date:   Mon, 30 May 2022 15:47:31 +0800
Message-Id: <20220530074731.14252-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc29ab2-52cc-4380-0ded-08da4210b0f2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6908:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6908A771460395901B755FD3E7DD9@DB8PR04MB6908.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqXMHkHLUb+PsOZvwavhvufo2pQgQTZR6HBsF/7EOuEe/MpPcGf/4cFbbstuRaVCX+NF//HFGxErnviv+pkwEsB0rmbI5WXuCvvZHrWKX1wBhE3MampQMS68DrVtfgMIFqUFczIyQi2S44duyHBOE3US07evHbDkUUqgxPjGOfm4VohJbOUJMwa4Ifm24YBSvjL/klldM1CgsZuvkWFAySLgEJiaBCKlWlKX7TIuDWiSjtfVzGyeonLsTGKfzm/qoEddNzXgJZy3qTTAyvD+6EsHdf4BbE8YQdedtqzC29Ps+FcVpCVbeu1R7NLqpVt2Rtau3ctrPbirKtqHXLhLQJAxQTGbzzECcXcAr7ArLSKaS7qegY8AawSh5GWez0rpKKkPv2vpU2/vYb4DbwcoEUL5sQhcAJqcgys3pUa05KBf8yjsWwrBbuzaVaDDzp1USbEOR8mA+MJH9QtiHyrelkZ0VF1ppUXN/kEnz/7x7RcK/M2+Z/NZV+QcuCyQKSeoenzHE7g+XCBa0XMlDChVkoiV5NocjvaEvO+ly1aZaOBlYIhGcYSbBfqp35feKtDKOsOt+AE7+yE/S8GHK2WleoEex17/HY7jypmUoAXzKTfqF8fxAdRhCICvytIxJFe3ChqD8w7OfarQ8OUuYrvGg4B0JXwjQZIMUZJ3JMRLUn80/A7URDPf4BZ3vrGFmVUYPi7HRddEE7QrbnPe9etzvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(7416002)(44832011)(508600001)(8676002)(6506007)(38100700002)(66556008)(66476007)(66946007)(4326008)(36756003)(2616005)(8936002)(6666004)(2906002)(186003)(52116002)(316002)(86362001)(38350700002)(26005)(6486002)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUGRynSIDJLPsW09v/TcxCrnmf9j1lvpJVLLDvDqU000FRdofxKu2JBQ5M2y?=
 =?us-ascii?Q?3zpVgv+FOqXjYQa84+vssyE4JaQ5AaFunlIA3pops6QWT1w2XmGwxUl6hlnt?=
 =?us-ascii?Q?qGICykm5hWIIO11GI0+/NGAd2b2jRkzwCRCRoh5kpOIdijuKRuw17zaUr5fa?=
 =?us-ascii?Q?e+hXo5u9RgiMNcjwFS3UxH4B0xAGU3ANzav0fqsyVRWRLYGQnC2w/nUyLbWI?=
 =?us-ascii?Q?x69Abumu0lJiILdW3iIrzNTPvRoaE4H/p1GQ8d+Ov0IdwzKbHbznnF52y+TP?=
 =?us-ascii?Q?fuFVeaoeDlSxEyKhabeae/JK0iTzDjv4JG/qxQH6ehwZs+7uypl/jB5x1TRB?=
 =?us-ascii?Q?kQ3G8WA97XJzFGuBtQSHLuKda/ZqJXKPfsh07W90sR9W6sjo96dMrAGniayJ?=
 =?us-ascii?Q?QwZGH33oKxUr6uOR7vw1A8MCXN6XAnry4ihF0xLyUEPBWRR2VpdRnlEdZoRc?=
 =?us-ascii?Q?uZd+9uLGSE0iGMKkjR/27yuC345OKvLJh1pFIOECLN2IRyzgk6ZfO3z7HPsj?=
 =?us-ascii?Q?Bj3bcd0aRU+V8I55SXI55JhoGwavs1aTZmP0KF9vkePPvTyqeMB0/sI8MZCX?=
 =?us-ascii?Q?HpPyGsh9Y8JVnsxkLuTmYrBai/bpVH/WGX5ME05pstT8fF+x1h70idogRy96?=
 =?us-ascii?Q?3FFiaM23Nqo6t4C7+f4AbiyHmb4n81p6Mt9GMBB2IVdcoXHngRUDjpa275+L?=
 =?us-ascii?Q?aeHrEPmm/96Niz6DNoaeiOf0bgiLkfizxNu6G1B8+HfHZET7fegDGHyoj0x0?=
 =?us-ascii?Q?DAcZFw5HJj2ZPxQ3rrTLmVkyDv1+gbwNyBLl29JZ7SDEhpoNdtkao0jRbmQu?=
 =?us-ascii?Q?JaCRWOIOf+JYUx6PkcqbfTAcYN0/I6IK67HAEk7J4YINrxut0dwaArVkDgZm?=
 =?us-ascii?Q?hjETlwcBLtrGa/z3NQlUtPe5ElsJf4xuTzOu2qRW5AqPiZdX+lU/cYI2y1bV?=
 =?us-ascii?Q?pNwc7lWiYlWcplbmdCNKfZlfrjx6OY0xlKmbuBxF2EG91zPArK3JgmngZpnb?=
 =?us-ascii?Q?maLal44UQe/PbaIaz/AOLdPmPM0EZOQBzq/ACQJaeK0hTFi6wKlVeTB1mCQ3?=
 =?us-ascii?Q?rAwN0su7QjbN2vi/bnbmzu8dT9/x9gxrEykZ2WgdChOmyriB1asBuTDIqf5Y?=
 =?us-ascii?Q?91WOU9dfTbKpTRi8jAdndwFeOgvDwrClS8buqzRdUL+1UGk4PvaFmdWDnhXj?=
 =?us-ascii?Q?x/ZvxoIPbkQ5Rn/HrZWIN1+8cJYk0gcqjDMptiA+5QEmTpr3E8qm46SUPL7x?=
 =?us-ascii?Q?8SVm0yOuwKW0Z0K8awuHx4jd2Yi0bcr1mq/Md5WAwfAjM0akrW2JV7yl1Hd0?=
 =?us-ascii?Q?9P+8yomskr4NmwdLBB/L3RPNIWasRmI66l9aK4/P2tUQYDpgL13ZMWPA9Ttq?=
 =?us-ascii?Q?9ulzh3HVBBinx+5Y+GT/K+nNCyZuFNjqAzgf3xRGTgBCEDR14+kjwOndycsR?=
 =?us-ascii?Q?sIpN2HOYpGePTDYGQWpIourF08KS+9iJOUt3eeg4ZYYp+hJLmrARzqLsXfG8?=
 =?us-ascii?Q?UHKkh/KOzlewlRpdkT7p6EBywwwadXfmtg69v2ADUKDUIgorFXJWumtWV/ml?=
 =?us-ascii?Q?dOsIalfwP7KFiKSlL2hxw1/eEHPeUUdvg3RS3yxJCa6xAKlhC3cAEJjqNQ9l?=
 =?us-ascii?Q?FeLJnqTDTn0hX7M1P1scU/mubRZ5PFQMLRl0f6aCxoqFvTRkGyZawBkqpeoQ?=
 =?us-ascii?Q?xqxJ8X7V8TNE6h5sm4PP3px7RB7/Vt01VxR9KFI7fieYmnzTMjqLTXtbjw+q?=
 =?us-ascii?Q?fECtdfQiSw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc29ab2-52cc-4380-0ded-08da4210b0f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:47:48.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip/XsY3vK7B29mmkfmJc38CW7rTTHI/2XQ7i25+eC5u4FnmsS478AXThN8ertGfbqHzTsr4w8rcvb/rs6TrMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the register CAST_NOMFRSIZE_LO should be equal to CAST_STATUS16
the register CAST_NOMFRSIZE_HI should be equal to CAST_STATUS17
the register CAST_OFBSIZE_LO should be equal to CAST_STATUS18
the register CAST_OFBSIZE_HI should be equal to CAST_STATUS19

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- add Fixes tag
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index e7e8954754b1..07655502f4bd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -53,10 +53,10 @@
 #define CAST_REC_REGS_SEL		CAST_STATUS4
 #define CAST_LUMTH			CAST_STATUS5
 #define CAST_CHRTH			CAST_STATUS6
-#define CAST_NOMFRSIZE_LO		CAST_STATUS7
-#define CAST_NOMFRSIZE_HI		CAST_STATUS8
-#define CAST_OFBSIZE_LO			CAST_STATUS9
-#define CAST_OFBSIZE_HI			CAST_STATUS10
+#define CAST_NOMFRSIZE_LO		CAST_STATUS16
+#define CAST_NOMFRSIZE_HI		CAST_STATUS17
+#define CAST_OFBSIZE_LO			CAST_STATUS18
+#define CAST_OFBSIZE_HI			CAST_STATUS19
 
 #define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
 /* JPEG-Decoder Wrapper Slot Registers 0..3 */
-- 
2.36.1

