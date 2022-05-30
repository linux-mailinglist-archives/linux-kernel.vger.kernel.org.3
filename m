Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F55375CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiE3HsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiE3HsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:48:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176371D8B;
        Mon, 30 May 2022 00:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0gmVX5UNyFk1UkuZiNyAwnsVxjnETDm7cTad0uJ/k9Ej6aZAyj0MyfSeybEgKOE4vGokcsC3m9eKoDboq25GUIQ2UJR0NxKWli+aidnhZsIwKXflfohH/R3t8Y+o4BEpqTos3zIuOY6HFJbbnlBs4bU4z25ciXXfxMXy2+wtXa0tLStrEH+p3M0mYB+da1Jvc7O3XSnF/WeebVt6nLR2tShfMZAJD8O9OZhkjxhSx+VcQvWAf5furPdNhj33FxpisKTLUypZcX3hTaMdADeD6upVGMOceW7v9P0KTiarX0qquch4srDqD1xFJrDbQYuGFmaz7gb/1NaZicXME0/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J5FeEi9RojFrcKDnPZHW0Ccpa/LtoF3FGam6JHrsSc=;
 b=QJQlIJ8L3meDKugpBT1992jQaWnIJukhOiik/33+CEkDXZDdphRTGL1kBf+wqKy4gq783KEQMJYkqA+nOumPE31M5gbsbcBZKBNTFG6CD+BndoFWUtpjCKD113tFd3nGG1MEHuM2CjKRB8xSR9nB1OW0LF6yQKVLl11azb47wapnJEq9lqs3ycnONvWqS77jDHveMcCMzzWdY+B4Kxr40VWCoGC08hUglosG0QBVpK9k1THKRzqcgPV2wdA2uU7/PvbQEF7aW8n6N1N8CmBu02rlpqfWIQtUTXx0guxq1SwuzZStlPhMcNwSxGYe/w0r05FzBPwTBPPFl61Ajn0CoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J5FeEi9RojFrcKDnPZHW0Ccpa/LtoF3FGam6JHrsSc=;
 b=i8o7cEdCCicoGNPINDaOBTJCWWvn/gCsujSniwjC7sv4L2SJzjCOLbhJH5A0PUXWp7DHomqREi20nK9CCJ/BwUDl7a05vw3N71BHHGE5yp49gB09BzEdFwuaDe+erZgNYln6XwKL6lwDZnDtABcmYnT7dG6kKTTWzihYGUosFc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB5452.eurprd04.prod.outlook.com (2603:10a6:10:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:48:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 07:48:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Date:   Mon, 30 May 2022 15:47:56 +0800
Message-Id: <20220530074756.14585-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 091b43e1-d142-422b-6446-08da4210bea7
X-MS-TrafficTypeDiagnostic: DB7PR04MB5452:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB5452D35EF0E3B947C2333528E7DD9@DB7PR04MB5452.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yv/aFM4NBX6b20HNK0hh/KunDUZxOCIcLUuok3SElbL1WZZJZPcG6gy+sWh2TqJnG4qj1Vz7a1yFzmD5vVCaIk+9KLccX+IjVml5pwnevIxunbNenkZAd3D9/jdpdx+3Ag1FQSOioji4vU6vAK/fjTBPtLdD9KWVnFOzZhu3tDWR2R+s80tSUO0kzL2HEeGJ9ff90e/tC+4bRGa1hRSUVcI5rbNFQmQebMdHx8aXxJtNkCnCtp37aI2MtAa0iFG78Ts11h6VLl8gKlhsl0+v8xb8sjJJ+leAzlt6TgPjEbKyh5GPmwGv4LTMGh7jXrLhrQpw5gRJ6PeKTGf7GHhuBSRh+5crj/8FCchTR6B2BkLkcEuuy6tGrPYgUNukfu3tD8M24jpEc2hv/Zoa32vUU3gS2EnnQrFmZCderb5kmTwW5z6SnwGXVoa0OH5+nXR+OKCfkN4WO/myEopBXaiHNF35gkC/Nay7rH0BuZQOvsrVdamu8xN8HNB+oYy7agrKK/dYCgl3m3q3mojItbxkxDCrnf4CeUHm+ykN1OZLvf9UoFd/SHriHd/TBCNeCpfUqKCBXl/rv0i/jxUS/aR1sWkGDazHYhq8CpFq+wkWML9J8LzYCsE7wVATmCS+mrZXpkIHRrAI6AGR1O4DIUSs95qBgb2byVKxKKvVGHnczbBusBRCEhgegJ+Cebv2FmuRUrD33h7UB9ifM1Bi4rt1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(66556008)(66946007)(66476007)(36756003)(38100700002)(7416002)(6666004)(316002)(8936002)(1076003)(86362001)(186003)(5660300002)(52116002)(2616005)(2906002)(4326008)(8676002)(508600001)(83380400001)(26005)(6506007)(6512007)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6qYULY7aIB0bhyVe3k4N5GRnmf8/XfffT7G9cbH+HCSt1mb79ngy9q7f6R2?=
 =?us-ascii?Q?/fEIGIVYnfHk+ash1/cuE+us+xZbWSxauLrqfOHP8/oSSax/o2+6z4Pxbkl6?=
 =?us-ascii?Q?PNPVsTYHecgFFQUlVbdqBpjbGxSVYAYcY9Q58RgjWmj1pLKkCd40KKquSU1V?=
 =?us-ascii?Q?z3vVTLbSO5c2R+6U9rkBJlvrQWdmyaQ5ndblqFMwkLEktSCJ/xaN4XXHgHLB?=
 =?us-ascii?Q?8wwqvvOi0yyhgvH4X3TFyRAFtMSXNRru3/0Nv33RlMoy03Lk7Zo4Tg2uAlqW?=
 =?us-ascii?Q?FNR6IzyJF28r+u/OLC+KQ3kbm6mmUm43HaJR6hHF+hXZSNtWsh7G8n7mixbz?=
 =?us-ascii?Q?U2MELNWvc/8xURvXnm5O+RVH5zikvDzilWiNTS/VkA39EM4fIW+hni0QE6Xm?=
 =?us-ascii?Q?I0ua3bWnDFYTXDJO82UG+1Yz44SmR0NHHGUNLfHUcedy7/BdHeUQYrU0yyXk?=
 =?us-ascii?Q?7gbCG3C+8RBKJizO5Wi1iqqMMOHMGJ006cdDNsoUtTqEa2HssxnHFXo1jwCv?=
 =?us-ascii?Q?VIOE7QjRfp2TA2/1fG7m6L7n7b/lTORxEzcNJmkn3eDxsMAWJTDgo7pplgN8?=
 =?us-ascii?Q?RZCVKKQjsQGD6QCBMrJKfy2OUIpigVmMqdnHdgMnjNFDAr4IPo0vc+DMi838?=
 =?us-ascii?Q?x9SpVxkMLZaJUc7smVMHBeGf5s98lm5ePg/Bymwuj3upqzqkmCGvgG4c1SHZ?=
 =?us-ascii?Q?7JjyUQJ7xa6dJ/S/5snpzb2FcGaIANl+TIkbu6OfTv/zIeOLlDWyE4wb9OTd?=
 =?us-ascii?Q?3R4yDWTFj2G1xgnFw7Jx/Tny/K43aJTpf7XpmiSq+R8HzT0JWDotWbep7p45?=
 =?us-ascii?Q?AypHnUPBFDxR418pah1xk4g9vhOvQgeRq2688LnpwMLmgWGjEFaNURDY8DYC?=
 =?us-ascii?Q?7q6MEYbEtoIi74WNqdHCn+xKCDXLjac7wJP4FEDQMk4aKglcyCcx7S5cFyW9?=
 =?us-ascii?Q?BpUdi6FnLyEcHvxldaO6yap08UOJUO20R4wOI2sSzmKtniZjfOTyw+ihFlqK?=
 =?us-ascii?Q?p8QcBMrv9U5HiVTKDVhwUX78rF86G8Jh7VGNPOObZC3FkfayVdrykyPkyTbL?=
 =?us-ascii?Q?h5fbG+ibNqs1hKKFC+H1osty+PYErWboZHDQ892Z60yu83olmacWF9Vkit8Z?=
 =?us-ascii?Q?wV+65OOIaZTPypsTOgstfEWaSIcvyZVFOdi8jOeQg1Ylmpvs8gR6N/229p0V?=
 =?us-ascii?Q?nlz0rw2ckcnTg/948h9Zn69RGzggLig/ZCCga+jIAnvmFRxjReB2XkcAjAsz?=
 =?us-ascii?Q?gxtsW8PlDvx+wzeyHvTfGHgauaFDNDfTkmqIO05qGlr5Nlh/M5NxYszCdzpj?=
 =?us-ascii?Q?YA9crtW6VDRNgp69KjlImIsEeoJw+LKEUWlH7ngGsc9qrEB8UmdYzeLuO5Ul?=
 =?us-ascii?Q?RZYAzJaxET7Lwt7u4gBxSr3DxdN6cj/ZG3/7M4eS338IWtl0OELV+KXGuAbg?=
 =?us-ascii?Q?PRsoSDZXXDm89DQs58+q0zqBbR6AScQyE3qtVj9yMXg0nR/+9wEROd9rdpMo?=
 =?us-ascii?Q?fBOk0ZI2a8QzHZKhExqoOjdHvRGQNdoDqV9PD20PAgYnunzciP0jrz+FiYhn?=
 =?us-ascii?Q?vLel6ZCs1DttNcc35UVYDr82iSevnBQOSjvLW69Fm0VhoLGORCrqCXHqtVww?=
 =?us-ascii?Q?3xp6IByywIQwVY8x+k8fixxww9SI1thlqLcgZjnjYeJ4Y7kaFIyjsJX7y4/V?=
 =?us-ascii?Q?oR7rENozq+KaE31mR6b/9DmPMltwOhvo3vCaAfwGDp1I0FpS9U25YogJbm2l?=
 =?us-ascii?Q?NSYeaYdHDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b43e1-d142-422b-6446-08da4210bea7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:48:11.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV7oXLafYolwSLIXxm7CHwxsFtW7qtCvJ3yOkPT+1eoJlM0LGVXUYoDhICm+nnuBaYzCFU0vMjiiBvhE6bwKag==
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

The interrupt STMBUF_HALF may be triggered after frame done.
It may led to system hang if driver try to access the register after
power off.
And interrupt STMBUF_HALF and STMBUF_RTND have no other effect.
So disable them and the unused interrupts.

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- add Fixes tag
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index c482228262a3..258fbee7ab66 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -76,7 +76,7 @@ void print_wrapper_info(struct device *dev, void __iomem *reg)
 
 void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
 {
-	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
+	writel(0xF0C, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
 }
 
 void mxc_jpeg_sw_reset(void __iomem *reg)
-- 
2.36.1

