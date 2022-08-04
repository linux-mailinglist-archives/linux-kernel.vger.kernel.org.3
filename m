Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF45899FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiHDJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiHDJjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:39:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538C4199C;
        Thu,  4 Aug 2022 02:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVMpJRHRsLoOsKrynHWTjQhxtsbUuJnQ9knWzUvjo097dmqXiEd0oiL7gt1I5DZzyIEjHVUe8X0DbrWgBZ81p7KetJ+7cqWoO7ZqoIyHxmuGb1Zi5TBlSAeO4hp08K5Pw0XnI9EP6+DtbNl4GzkYQzH3UodvXaE2714/3QwP7ARb90yg22C+ZOxAD40UkaEWXYL+R3TqNHwRPeTAU6MegtIByggNek+D77V3Gi5r5MpTxLmtUweidyKwQc/57/els5mTdX5lxQ5iGWwT4BWi3HR7EILKkK6uCtMZ7O3YFBQbh6aCh7Bj42FviryPEc/CedVhZW5vWVjAyWhInpzdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Uo+8sQk/Ln7Nj6Q+3ErF8xc7unji6Ck+KSRh39MrRM=;
 b=MhCSfrepoMmklLOenQGg9M238hdXjpkWATTwO2N23GM9u92IKNUTivF0jgLxxOv2721O7oSXervTKuSaCO9G9Izr3loyvrPo/K0fb1j1P1rhqadIGErPuZTrw3leZicp62EVQs2Yti+QXzNrmo1b8RRhWIYBxT9jwAgJ3bfqHZi/QehklTuHDxO3TOKeYpmtj2+O7hZQbh30jqs0PAZaEHWTBcWWUASurHSTMv50p0J32Fvz+RB16ChvEUZIJdeFalXiEI/sKPwMeQdxxNOID5/JI93OPECGnZALXI5+ydbnxwG65PQl1Tk8EpG+uQm4vQJ5YxYH3jnGEcuBV8drzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uo+8sQk/Ln7Nj6Q+3ErF8xc7unji6Ck+KSRh39MrRM=;
 b=pZYAm1z8xOx98qhmkX8SIaLLmmJdmfAlK1qPVQLixBwfaVvcmb8K0chcFnXc0TY+b4lJ8bIa/lJTCPyeXO9sx61mfwG6iM+mzDo1inVUZkMDMAyhusJ04LGaXNenMkcgb69laghm6TpBwwyHJaHZRRkYR0+RYHr7Qx+Bi5C7lVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 09:39:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 09:39:01 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Disable useless interrupt to avoid kernel panic
Date:   Thu,  4 Aug 2022 17:38:41 +0800
Message-Id: <20220804093841.31337-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c160740-6f04-4be4-45a7-08da75fd29d0
X-MS-TrafficTypeDiagnostic: AM8PR04MB7267:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNgIE7cZe7WTnF23HFq7kwsMVEeOx78o/BdfAZZlo55EVNK6QiOjPjkc/9IufyuvY6HA/rStG9eGcbt+TRiPQhlWUqn3DT98Xuc8vyI4U2p2Tby+ffKkKZLeHlaBf5036PcnP/jNVklctNKcTTqAdDqdYKR7bZPAhNGYcdLN2UzVhtJ0i+mBf3QsTavlP81uZhvpElL1RfvFx1AQceHfXe7+zPJWeIeFSBNyZs/GLYFPlebv2Dj0m+FACaTHf3ddBCShQ1t2+C9SGI3LQ4DrrgK2KcfXWxYsNCuu7picvwHfO7fAktRuGJxIRm+cJLpyq2DvZUlRKtE+vinxlp06oq0nlIjnnBqdukbT/7KaUvncpirEFhdLHg4lCS5x6I11jOXbMa8qgPzvhgi1l0icar7SSoEUYuSgRIGlISYLdiK/KVOVxU54matk086VY9MvcWxW6ZAXrffyosbbH4yo7ZIiKT1PQdU9y7gUfmNymVoDIHKl4rvqsQG6IIH0OE76p3v5Zl4RpqKzlXu73NBl+4dZgE1RBriDYUL0AICNodVxv/lHiqS1GnOyATawQcxBL9OIkow+RZFeeu4ngOSGNl0jz1OTZFXEj386KpwWZpgH+6eKiqnXB//0kxO5slCZRc7JhQuPFUXiGBo4CrdRV8nURXxY7xV7yrTnWHTumJ2trV0KtP3+JLXbfnt9N3j/3O89EG127yV1SmmZexQaEWxQr0cQVM3Aj6lcbHAAK3elfWuPjwCVvCMbWsrVesyn1Nrr6Qca54U6fspOpgjA5Z3gPlPuDAuf1J/EmkhtAC3uQL32u1qBZ3WKFKw9jvox
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(26005)(6512007)(38100700002)(38350700002)(41300700001)(44832011)(7416002)(8936002)(86362001)(5660300002)(6486002)(478600001)(6506007)(52116002)(8676002)(66556008)(4326008)(66946007)(6666004)(2906002)(1076003)(66476007)(36756003)(316002)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9jgUoiJPMZNH6GM98zpYr0XMzTf1TQgf2/KbvMR1Igs59achkKCd7dIL4HE?=
 =?us-ascii?Q?o/HowXaW9ekONURRILtrccqMLMoX7mGrS4vQeY9gZeT4Sp9H7DBA0dK/7UAj?=
 =?us-ascii?Q?YjEeMUwCSd2XPeVLFeolL3Jy8Im005tTLkHKry8PHD/XaMVwYOJKxXP97+3T?=
 =?us-ascii?Q?TZrAuzOH0VhKaeKuPyt6j8SnEXEKcOrI3QzenIQux1LrPmXcl1Zv8TBCOGgT?=
 =?us-ascii?Q?3fPZGN8+cedVA1R23bEx61g6KkRKdhI2jzYCwnnXUs308aJPk+kYwflnVd4A?=
 =?us-ascii?Q?3JV61yGVbXAhYRx7eTdlAiPWikV7MFvihTKOgC7n2BCoejPKxohAqY0qKD7P?=
 =?us-ascii?Q?Y8UIM5qKgraoNEQDtstpQ6cdieaDQxblkhHPVhdB8maM5rbyJ267/tssjF0O?=
 =?us-ascii?Q?3ueECzkkyrAjSpNUoEsl9znsqZkT6SLo/gj/jlEx1O0hrn2igSyIKptBCd5t?=
 =?us-ascii?Q?5yBa8HB0T5oPzZ/25/CxFx77zWAWUjDTFnuMX2wyAPq/+8CAc0YUGRZWiTJ2?=
 =?us-ascii?Q?ekvqmxGDEpAMK7kx7SBYrLmB6F/1EppOF9KTfYCn5Nqvd44EIQhvqBZDHBSt?=
 =?us-ascii?Q?L22of7h8KVllpSQK5PlQUiASfeg/74RxzP1usq26xN5t8kcejejkPwjMbAn2?=
 =?us-ascii?Q?eZa8si8vAu/27kIJONgkaf+gp9PUcPtwqcIrQSeBtPHxpUy8NAlng6FyMa28?=
 =?us-ascii?Q?Ro/kTcyiP+uiPFBTlekUZLMwu/7x/Lk3d4Y1EwGXaG9/hU1v1Jh7nkiplibM?=
 =?us-ascii?Q?Ui0AAyl/Judx/E46IbcPeZi5NwkHZPh+us0kIX8dEbT6Ko17+cc+78tzH/wV?=
 =?us-ascii?Q?xhMoYmfAHoZSG2zPtFTJ7IfW9weyd1EO2XcI+AqrBBNQwgGQTsqv/9qF18q5?=
 =?us-ascii?Q?RdILdlYTjcVn9yBDvGMjDFvX+3VgeU+4LicMLp7EHTp9FgVSmXKBv7Xau7WV?=
 =?us-ascii?Q?xJ5hgobjJDNNBpmb8MgtJHsureol/T2HAnv8VnzQlLpKRLgXRHca+BXQTuPJ?=
 =?us-ascii?Q?aq20fmHaKReYkcvOCBB0pc0fu8TeMkJfigBwu++uyDMclxIYK7PT/AcDZq13?=
 =?us-ascii?Q?oI0GPQFsfyToXlh7NaNzZ8txDAnpppRwzBJXJcfk3DqANOODh6FKlby0IaP+?=
 =?us-ascii?Q?wftGyq87cBDtFUViArPB5NnqTg1dEaS2XlzkFBVJtlIBYAuAPvKKvub1O6Uc?=
 =?us-ascii?Q?H3zDouXSqL7NqX0h2aCtFGJQiI031XHVvB01oAFlP/yS14beH001HX7hDjOT?=
 =?us-ascii?Q?LkzvRCzZ3ek5EpH3FQW4eHZWQflFpKwex9i3ZCdMitOFR2+jPvyCvhYW9Bhs?=
 =?us-ascii?Q?P86q3CwFkGyHBaR+k+zufkzfWoL3w9dX4nudPktIc2O2BZXHBq9iI3Z/cXmU?=
 =?us-ascii?Q?7mHRaUsjLvwMZ9dSo0HRs7wBXSSBgRs6Kt5gwtIahOrrWjqgbC6MPX2aFSA/?=
 =?us-ascii?Q?q/moPMJtgWjwaoC5vRGvSrQr/6aB9838P2P6lUIQqz/YkegPv1+dd2B23k+Z?=
 =?us-ascii?Q?Y0lI8vOqQm6q/wpgUH4/+ndFCMvh8XbzcLOiCcVxYUO+4wuk+HKZ5QOu/Nlf?=
 =?us-ascii?Q?/KI265mjent8Kxg4HBu7/OtBfGG9YOveeWvNnAKj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c160740-6f04-4be4-45a7-08da75fd29d0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 09:39:01.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Nqh3ZINk4PziJ8nphxd1pZqWiQOajaUY0xzTWqo4Thfz3FU5YmR8ucJlc7H1QNPudLSllpT2A5PE1HqeWJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a hardware bug that the interrupt STMBUF_HALF may be triggered
after or when disable interrupt.
It may led to unexpected kernel panic.
And interrupt STMBUF_HALF and STMBUF_RTND have no other effect.
So disable them and the unused interrupts.

meanwhile clear the interrupt status when disable interrupt.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index 9418fcf740a8..ef28122a5ed4 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -76,12 +76,14 @@ void print_wrapper_info(struct device *dev, void __iomem *reg)
 
 void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
 {
-	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
+	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
+	writel(0xF0C, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
 }
 
 void mxc_jpeg_disable_irq(void __iomem *reg, int slot)
 {
 	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
+	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
 }
 
 void mxc_jpeg_sw_reset(void __iomem *reg)
-- 
2.37.1

