Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E64AF5CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiBIPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiBIPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:53:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83673C05CB8F;
        Wed,  9 Feb 2022 07:53:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9g8Kt8MjH4R6CDHqIh9cDSoZwWwt7Ex1NfloSGc8B0eLFqE0r0JPL0626eJJJH9y6SNqMVLRJx0EV6L2caJvqCrez2qlkLQhvWntTzQUwxcDX7DZhbLpfHR59lErvZ3vIGHP3/GzFZY+Qvd3qXEMXwArzjXMrk6z61zHfh4JnHKJkm9eqZlnO8zA2KeaYZXe9RIxALreM6YDdwoqPUeJNTOR6BVjsfc2nR7f4hXn+5fuaTBhNIo+ggUVX7GX+hqEfeEWDFjj5LlAyyiW9+XwUP45lqViOHE0KE/blM9mEFASKLDWdMiesKMeMJW3J7Ltz8WLUjm+cHNJ7ymCROq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMENqHZ8kO/P2IgxEY0zZ3Nu0FpBNvDs0ryssymts2o=;
 b=X+kD+7vZ6X83xDDc1Kg1DBtaZaxmQId74HjaLlrMrs+V94vPbScXTGvbRpeV49ulkV+2B1M7O25hnU9mr1I/NEhFXoU4JMjF1Lxobx5b+AOYSJVXk5Z0Qys6WDSmcnIJegb1QUfOnSa+rSH+wVDdElCr381bsFnfuSXys7vVd9kiYsFo8vdkjSOOER+prGyiy7mdu9j9gyKHHbChTRFban3sbd69HKFUbhRr3ftGmf6vIeob0q660wQVUn+QFSO6D4bHNH2iKFmgfu6YiXJbfP7x5M7wPH4/vPuw5wvJ9JVNhPzjIgxMD65aE7c7XWuAXUj+uwL/lJ7FIDbPVlx4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMENqHZ8kO/P2IgxEY0zZ3Nu0FpBNvDs0ryssymts2o=;
 b=BNHDqguinTPciQugcud9dw6nY5TQbPxaw8N3OtUOTzjuQIRi5x9QvCzW0qG4WAOXovoMIq5SmNR5jOpV6euD+kAuFXVDujJxCSgp71Hk8/iPUzABoRptc78GP40mcf2by0F37iI6CTNVhAnwu5Rkepj2Qy9SBVPAm1+Kaigmwc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by HE1PR0902MB1852.eurprd09.prod.outlook.com (2603:10a6:3:ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:53:39 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d%7]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 15:53:39 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Oliver Graute <oliver.graute@kococonnector.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8qm: added more serial alias to dts
Date:   Wed,  9 Feb 2022 16:50:55 +0100
Message-Id: <20220209155055.19856-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c3e1ed-4faa-45e2-e87b-08d9ebe456dd
X-MS-TrafficTypeDiagnostic: HE1PR0902MB1852:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0902MB18529CAF3D67056FD6276B68EB2E9@HE1PR0902MB1852.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2T4Fc8jwjfVTlyAkM+f7gpAdrqp4pOxE8o+J9gC25y/OckrlSRmoC1OMovBMc3ynncvLuRpXRP+wSz6DzSgway4df84bnMgnSus+o0/eqwK5fuJ5HOrpLunTCbJWM+2RVBJj+tV8zcjVasRrR+1QOAh15rKalsTGcH30kQpZuh/j34qDmDjqOwnycu4ppQCJmjwc61VHrk5e/RtQ+AC2Z51LcavvtW+Jf1FTvumC98+VlIiQcH84Bbi4XJDC5PZtSLb8fGfy4n4KnxvBkkfF8uEfUSt7LhbM7R+Z7IYkQzgDRxXLc/z9PloudVngMdl+QR4MiAxA7UZ3DsYmnYKkB6JI/iHxzGok5I95wwLx1sh371Kzgi240BZqcJy9kEwOSi8hSRIbBx2E+glC/y2+l48N9igbHsBfZNp669TqgRToyZP3ZmB4Y3/wCeXkelG8ff8CbU87/Y/72DbUOI6//mzFHZhlyu6xSPZ8ndK7VCE5L79zFDTiswiV8kcJ/8bmuCNMLuy/mx0IEvjturgHbEsSQ8xwhN93O3Ec2V1Zh5mKncvS+IJ2273NrgBgWGb1wKHU18DLhNfqvxbmeZoHPkDFAeb8wsihAuZY5obniTRK2xtSPF7+3KJ5Hat3RA09Cx/C97qft3toCELextuHSlqKV4nC6MwjoumYTSchiXrmPG0/J+7wcIyOQiI8d12gibBMh0pQzGhoXLILpyAgJQteEfA3A9jhj8m1weW8Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(39840400004)(376002)(346002)(38100700002)(54906003)(52116002)(6512007)(6666004)(6506007)(6486002)(38350700002)(316002)(110136005)(26005)(8676002)(1076003)(66556008)(4744005)(5660300002)(7416002)(508600001)(66476007)(44832011)(36756003)(4326008)(8936002)(66946007)(186003)(86362001)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eDPTS2bRgjs477uOrkLXyN2dn5by4ex5MRI9C3TMV69GwNN8Whm4u46rZm4?=
 =?us-ascii?Q?bb6Wexmluy3Oarg9o9xg2jGw/2lIfWfqvlGyPMjljGFVSWwhzADgPonC3emn?=
 =?us-ascii?Q?G37ZWIRKw3M0BQ2u+JFldARtKBAwmlssQtPP+3Kzs/q4PjbG2tyKqO3btQzF?=
 =?us-ascii?Q?595jxBCT5DfLrGC/MyJwW3oRdQtPvvgBNtL5CWgivIcqcfnZbN62eQWHTYK0?=
 =?us-ascii?Q?Sf6kdaxY9+wnYnwjSmfZ6gzPuZwXUN32aU3MdOSnF8fBCvvqgJnB6Kn7ckmf?=
 =?us-ascii?Q?AfXxGWxZ2p9+EcWTkT807dpD0RQZWrCygOE020SHrT59em8ycwm5z9Ho4pdS?=
 =?us-ascii?Q?r+IhPB/oNaRbMGIItX9WztT5e+4il0OXr0QUbNGgnZiztBbDdnrfn0+WqOEx?=
 =?us-ascii?Q?j62z6BGqWnN835M/5KSFZKvunZY3FIbkVmje5jRPu53uhI8WCNJoMEhKO+Bq?=
 =?us-ascii?Q?ElkJUOe2EWPNCYr8BMUgDwlolpVAAk5o3LvAGOXYuI+y80FICpsa9PABwE6J?=
 =?us-ascii?Q?7mkh0kE+GUwafozU6VhYCVvxVcr0V4gcdTsAaVnF3yt5MV/+bTan7q/dv3JH?=
 =?us-ascii?Q?z6652N9AFY79TboO0OZPgwgRdIoccnRVHX8S5OKFIGx0OjO4auoRy3o1+/OP?=
 =?us-ascii?Q?66Gw8UpR5NFW2PzioeUJaXBvz5cMOLoDycj/VsiiIUiusRANMHHQsskY4Q1I?=
 =?us-ascii?Q?69msKSc7tU/OpfK0L0yRSLU7N+oIKh8uJl4WUYt7M1fFgK5x6+fyx9rDiuKY?=
 =?us-ascii?Q?/OWGL8rhGwcOfLj+8ER62L7ccpmVe1rhbetRQCJwnbSzMYo6OVjMQJLXuWPv?=
 =?us-ascii?Q?IIz1Tm6UhGqjBbw9p/uFP2DdYY+FTNGyW1crtIp5216507R94lsiJpzVHo46?=
 =?us-ascii?Q?dcGX9+w25Enxba3NEZ/OSpir624UYHo7X04VyMROn3i0sfsYzqOUTVqrm9mq?=
 =?us-ascii?Q?7mRKAfFUEmoEHIGZwrkvAorbnX2NJS8fZ0erZJWoL63KfNldmMWAaFIHhd5A?=
 =?us-ascii?Q?ej0fpWwgmGDKpgSUGk8buiUGsl1I8OmZ3H3L1nzkeqU6PoshS4JIpoWut351?=
 =?us-ascii?Q?731i/Alt3GLf+8dzyFFLPLYOu4EfoajQOhwiVSHy7B5uj4tdpwWtgJUEzYtC?=
 =?us-ascii?Q?12AP5uUTHJeOKy7+B2BJmI9YXRE+BXLZdX2VKjp8uBaRqsmLy2Q2dzu44bVa?=
 =?us-ascii?Q?iRhho+C0H2+4yLi7awXk1s7ioEnR6x7ahW7jUvzg657Hs+5JkAtQB3Ap+s+m?=
 =?us-ascii?Q?s3RW6nG2tGjk876EY4AlkICWAl7FdXSZF5EaJKwCclXhGsMmvNJ2me/cQjZv?=
 =?us-ascii?Q?5Vf7MAFr4V2efva81mbQzkWJU+MtSaIjVFrPIdHr1lO2ccmKuigOLrE1M3hW?=
 =?us-ascii?Q?4SbVpmqBhiVzc6AKxCyOClgDk4v6DNsges4qOU31pVMC1/FmxSLDsxiVhKQU?=
 =?us-ascii?Q?HAnPhb/63kymgGXecbHsiZevxSPeybFyjQwLyCPslUVcblgpBlW7NFCtOgrL?=
 =?us-ascii?Q?qTT8ftDg8IA08ZOa5FezGwztk847ysJZLJHzN29swGQ4ZsaSaZaKLE5XNM0B?=
 =?us-ascii?Q?Pm5mXCrs0irFHWm1GmdMHiYTMBbvm8hziyV31psB1n5xCix3my0s5ETQngH+?=
 =?us-ascii?Q?7ImcoNoqD7VvWETt+gCTkCPCtIX/+9BN8NMnt/6Ho29ue7e9cz5GSc6WqyiR?=
 =?us-ascii?Q?npOJvg=3D=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c3e1ed-4faa-45e2-e87b-08d9ebe456dd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:53:39.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afWzbI0Kx1jYaMiyW7ef2wAx7tKf2aEHBxBrWflQ4csIh1fnlJkCMuX6j9/ATBXaa9FHqtwj/hTBE6wwo4uFBBTvTBfcqhduAEyYo5OD1zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more serial alias to imx8qm.dtsi file

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b822f95f9baf..097eca99c6ff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -20,6 +20,9 @@
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
 		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial2 = &lpuart2;
+		serial3 = &lpuart3;
 	};
 
 	cpus {
-- 
2.17.1

