Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB247570801
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiGKQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGKQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:08:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E8D4A;
        Mon, 11 Jul 2022 09:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkIe6dAV/Ho9PsqUaO6L1V5aTmJ0BO5uvxZ3Fcx5nagqezUnfrc482wumZBaTFyARsXIc0SurJsx0Gkh9EWgYL6DXO1OUNuDLcSsE33/bp17UtPM6BnW/DX0dXs1wdUNVb/0QZvjcSBUoo5j3kBx1VX5EaN4tByVlku0iwQI0/FinY7RAPlqlKpquhuqs7/33quR5aZnvcMBoXo5O8cPc5kQSLc/e8e9f4E8AYGoOGy2L3YzfKTm7ADv2wurBsCFeJ1dSlrGDjhfIhtcrBSNyaaFVAZaSnREHzrPb8va3sunrtCYJOmvSEzWgG5HtNvhTuSMguMacmzG/Vlj57++Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3TaDtfWiWLmZysBkooPeW2ej+ISKyJPXroA1BPFQO4=;
 b=YlIWETXJ5yQzMAqHHxdMYUV1Wla4VycYmiii5l8zUY9/Fpx/BQnUxDK5bWPSMNihlk859siVBuh5fyTvJHrCjS88unSVedGFtuUum3X3TuLjLvJcJ5a3MIj9P96W8v0tGa+CGggP3L1+fU0oBpmioI89IG6bqbJecYUlHLrdiy56VonRtLHn4rKnt6mfrsEHD2Vbnuvu0KUXO61LO6ZaoW7lc+zCRLZniIqYRTkB/dUOvwqnHviduFNFWy2nGQUWKuxJD5S36r4fG/ZTNKa1TjrUlZDb8JCkHMH97PWj46fFyI47Bd+g9VMor6X3asd24D9yI4OAmmp5rNhvKpPsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3TaDtfWiWLmZysBkooPeW2ej+ISKyJPXroA1BPFQO4=;
 b=OUyCM2/SYdAYTxdQxvMGii3kso4BNW0ft+iEkjKBVsPxdtvDy2qAflVrL1lsmAL4nDi5cymOqN6d883xyGQ2oP6S83CwmH8iqhtsTFXFFmrZxEq4SGMA0PdPTd4xB6XxxeU1j2JU3DZXx9UDK5I7ySVvGmBRbPg6Dq/sMiZbtMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 16:08:31 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5417.025; Mon, 11 Jul 2022
 16:08:31 +0000
From:   Han Xu <han.xu@nxp.com>
To:     han.xu@nxp.com, haibo.chen@nxp.com, broonie@kernel.org,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com
Subject: [PATCH] MAINTAINERS: change the NXP FSPI driver maintainer.
Date:   Mon, 11 Jul 2022 11:08:02 -0500
Message-Id: <20220711160802.4938-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee7c0ec-98f4-47ed-4c0c-08da63579975
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQAU2ap7kwhooeAg1x92hRkrkg3OuwDSZDQ+rRSbRn1pomD+XaDtFcBfKiv1JixV3Ol3patBS5t9yYrUbgZB6YQ1U1rZ8CiP3TpT+s47K1jEI0DWkwunsHb8TcJ5vSfTh+4Squ4TcQfTmf4IY8fPxHNkHmoD/beWHqOFHMxR0dd3Ws8lWPiAawi61SsvGqjrzafEWQ7MAFIJsEX72NGp1aExEwEY/2Aek/kc42cL3zOJnPqmoETgWI4KUPo87hRejffZ5DbLodq7b6k1Y+EI7nZ2Lsn6bvA8D7w09yVBLk6yAAOeJ87Ims4uW2Ax+Rgjq2ISDPiIjqSGzQNa5ZQElWOHTlbO2C1G8dnm5HtJi+RMX9ZvsjvvbUhgU4xaZLQQahQKPggKM1I+sHJN8nHTPU14gVAcnocDw45l7WYcZWcgj3texOAntiyruJFybqBFv7S/BhciYf9p7TG/qcooHpOe4VRwJ5Wa5F3zkU5PafT64bxvGJM/NWamalC7O3h7kPIZ9NrKc4gjyZ2kXud0Q57yyMOs+exUGPh9vu8cH27x0wk1sa1iaz44R7wYUGxOOB/S3wBYD69tkWktnsgj9ZM9Kkt2TCEF87lTNqmKh+GX26/qUZUiQBU6fdCzCV8ZKfcZyQ4FmlwPtRomjaJbJoIBAgsJ0TE9+FJy0etr9cprzG1Guzy8jo8+CmW4KKmwven38AOhoZ4T+knG98vIJ3VCG5erXNLzJkABkWBPO1NAVNejGrjjDKTqgu7ExRmVdVsuCHqmoF4JANwwoCTlQyWZWyG3MEOFb9sN7eiq9nJFPNC+Nw6SRjuO15Ei5n4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(186003)(1076003)(83380400001)(38100700002)(66946007)(38350700002)(66476007)(2616005)(66556008)(478600001)(6666004)(316002)(26005)(2906002)(6486002)(6512007)(4744005)(6506007)(36756003)(44832011)(8936002)(5660300002)(86362001)(41300700001)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8arAPzDRbX4oeLKQMF5J0M0pluIehCZ6SLVCxfCK11RPxsEG4nZ+VhHJqK5M?=
 =?us-ascii?Q?tZk1oCJXlE7p+j+EEvOMLnkCjq+TU4cL+knv3tcZ12J4OE/pgXDl7S467Jy8?=
 =?us-ascii?Q?bZJ2pTg7WfQGELkFczbAWtqr/6plCeKbP6AJzp9bVyTxrgZxgGyWOHOePagK?=
 =?us-ascii?Q?R51IF/PcVNxB9OnL1hwO8mp1EroZxoGeFA/aM6ElJT7JFSr2FO06HLg7rBEQ?=
 =?us-ascii?Q?Ck7uaMpmc3SKIU//utyyBAjTg7TYlvOJSUc734g6zh1ytPdTcveFtusDB+GP?=
 =?us-ascii?Q?f7kBDphs08TACSpkaEXinRygRfG/4TCneaq7xkeq7yK1sqIz9dxCkpSgFf+5?=
 =?us-ascii?Q?NDvUzy+mI5xWDmHRhYxghB7ywbBCd7HMO9RSYo8E9Y13nakbeOA/nx7dac3d?=
 =?us-ascii?Q?cI3u06fhFEDpxQbT7tkZ4hlj8OZreq3H46up8BXf3uh+2rm4mIVndPLn5tb7?=
 =?us-ascii?Q?/F+3UzIIE+NDIH/fZbD/ABWv3Q9DUlkHkcGXagYx8NGTVyp31kc4hpB7xUss?=
 =?us-ascii?Q?jIYU2uLlIR0DF9Nb1RHmMqYMODgQE09LXiBoM5n49k331tJA+ikQjrrnNWJL?=
 =?us-ascii?Q?Rvg6yc39W0sSdeAn/qYdPtvHT4vZtq9zGD8FzDcBLV1nDukqyRhl+8D6BANg?=
 =?us-ascii?Q?8Jub/QmQCMkkSoicMfJodSQXpKBcaPSZ5tpjYOqMAy+fmYuTrkYfrfT6dp0C?=
 =?us-ascii?Q?SnIKVo6C2Xv/dWCJKx3LrIEvDG6s9aAVUDrpVRqOd0BanU8XPVXoQFOgp5mp?=
 =?us-ascii?Q?gMc5/0b44Hq+d37dxJlmj51T1WBw1jtxpR4blPjGWYatD60hGT16Gy+zGSuD?=
 =?us-ascii?Q?S4libNEcda5gfFGUOPH/o3TUINZEvgdjeJ1mLqKTkiihdKXYdfyFRolXT2kK?=
 =?us-ascii?Q?7SQC5+xet9Bl1Lyhqqd8VNkg5l6TFFg+oQMEGAsvL5jnL0isUItaymHsMSa5?=
 =?us-ascii?Q?VT3/iaastuaNkHZIBAupcaBD8uuy7b4UpmOVe1Js9bfNRi72FuqMGCEpeir2?=
 =?us-ascii?Q?etLuQsMTmMRbQEyPZ2li3y0eymp/RtYh2ObOU44PoGTfWJXIjJz4avezzwQR?=
 =?us-ascii?Q?+vaSR7SByoKg8Nl+8umLHD3Srqh5wmJLjGdm6OmGJ4J0VncU9DCWqiFOPsuH?=
 =?us-ascii?Q?ig8nXS+9MNnKwzlA28vVDugqEEAE2yzUIOML+dJtn5ISrSwPSH4Ri1YZ7Xx4?=
 =?us-ascii?Q?XJIW8o2qknUnOGspah/VwG7ZcD/r6e7Q6DUELL6PGS3wbKYyhqUARWsuMjD1?=
 =?us-ascii?Q?Aq/FBK4orPGSMMZhg8uoW4Pb/WN70YNS2dpRF6I+3NOvL9WGn+MQnSg3Twz5?=
 =?us-ascii?Q?YeB8lvGgZX/7zAgZY0RQwlaktCqNZH+Qm2qiPSK6UAqJP9kVOIxzVXu2Iyfc?=
 =?us-ascii?Q?27LjjYp4Yuhfoi8+rYemxvaB7fZRM79khSG3J2jEko4oW9MRIwRVpZku8Wqh?=
 =?us-ascii?Q?KPJStpiT/F27QoldWqoKmCXtTbkYLLkwIdy5vxxp2ThblZ6jONJjT6aahFs9?=
 =?us-ascii?Q?ObVGgZjDY1ydQteR6HkOgZIQMBZt5oYVmRMnVmZUrYDEruTrPSjCaXn1dPZy?=
 =?us-ascii?Q?HYGn8M/gWaDARuQPANA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee7c0ec-98f4-47ed-4c0c-08da63579975
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 16:08:31.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B1c4OFAPDd+IsH6NFMOR/XKFiRSjqhy5pnpNBYeTMw2f6jAUAYplpBMdCwGqFjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haibo Chen and me will take over the NXP FSPI driver maintainer role.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83fbc0bad264..070ff36c0a7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14266,7 +14266,8 @@ S:	Maintained
 F:	drivers/net/phy/nxp-c45-tja11xx.c
 
 NXP FSPI DRIVER
-M:	Ashish Kumar <ashish.kumar@nxp.com>
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-- 
2.17.1

