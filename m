Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B705A503C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiH2PcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH2Pbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:31:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE779EE1;
        Mon, 29 Aug 2022 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES4ir4QQ0DXZkwIG5InNnmARWqesEs7XT8UN/D3RoBjVIBtkWZOfcSX2Mr4/FuGHMTVyta5K8Its4SYC/azd7ZILisWme4Jh26ilw5nKJxzFTQHVvjAfTRMl6v4R3hqNgih9xbmeBRapomE2opqRVvT+dO4B3iOZjx4wTL1gakvZRf6Dp7sG1ZXIXCS2/URWuqR2Ygn0bsJXnH+Xivms6lzMhCMu6JM72MRNKlT06dwfBcSjwtamdwP7D59xyfoACOrArASptZp3aKpqHlAKDKrDdrQF0e6vS/8dPw78os0x0UyHBh5FotnRbnqDJnHGsyiEZC+k0YPDBAsOuVPL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu0YMp8Dhd+fbgp5pxFjVBz0BwHtXCXxTETjz2JXGCI=;
 b=jxlxB6TXj7NDdtIOTQc+N1deEoVPpjE6nf1+7tffvd7fgwsD5Pn8nxKF5Y3nSfVzaaFX5Lx4G1da2n5SPBwVVvZapLISxxmH3kmBbpqWTxnYPv+LDy4Pr9CEXnxR1/AKf5kOqRBUOtw9EGiDVfbu1OLPEfVxwCl0I09658wpdoLU0RqnfpQmi3pk+Ej6ZIGAOJ0AGeJZOLOM2SIU+45uTTXA7CRLQERMon52hUtPCpkAcNQae6yw4tTeu0nOcWU7a4HoMn8Eo3adDo4dMyQm3Wkkk/oGEtaoEgM8gN/SMGvnUu1DekvV7h2Ix4/rS01f4brwlHPmPpFNXMDaSYZEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu0YMp8Dhd+fbgp5pxFjVBz0BwHtXCXxTETjz2JXGCI=;
 b=DeN/+rOA08pWD0sSqs5k09bQUi61HZ5qWlWY29T0Erkb9T31pEDSw2i8XMOXAtnkjznEhkYL4zwMIR923b10R5doA4tp/RzJ+mBnvT0iooT8YzST1zp6hJuxxxyVioJ+H5csQrR98pIENKtksRZwWbbC2PWw4FoKXWzSlkXmbWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4313.eurprd04.prod.outlook.com (2603:10a6:5:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 15:31:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:31:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v1 2/2] usb: phy: mxs: fix MXS_PHY_TX_CAL45_MIN and MXS_PHY_TX_CAL45_MAX
Date:   Mon, 29 Aug 2022 10:31:24 -0500
Message-Id: <20220829153124.2791210-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829153124.2791210-1-Frank.Li@nxp.com>
References: <20220829153124.2791210-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d838c0bc-10ae-4f56-04a3-08da89d39668
X-MS-TrafficTypeDiagnostic: DB7PR04MB4313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6zifAET8pqBaVNPE0rgKmBwFCZuXaeMmNFYhpAadlyymYvm4n1mXQ+DGPq6HicXlWSJQ+hXiwHMDu6Ci/P9QpkLQJfefWGy8zPgqcnHA6ZzaqeCcrokChU53YKTDZF+3zLrp5J+v/AzzVAkdCRBqrxaZSvfPB9xsylg3G2U9rclB+y0kLO+SCLBgfekXTEJ5D4onCxi3tHWRfSU9PYx9LHGFQ/XJcB9ibamexcfc+AuQbUIM04xFFnvYKD7Sp2js28VVkLaMTv8bj5ZKTYRurseAhrNLAuhNXjlkTLckIGKNMa+EZ8ezsOqRuCLi/0ciSVs4j9H2QIPDWpenV9euXZAxvj7GAeFTLQBZvDL7okJ9wWX128Y67EKdpfktTnpROf5aUgTmqs83C/lRoFw6CuDU+v++VeIVGeqPu98VjNpHUilvgPABI+XFFSxg9EMg8QWdC2zQfsX/YjVRkLFjuNWrJd5EPd1R8OJjYSAf1nPlziUaK3JOKMHLtesDAxNY0P5PojIPmLn3k99Mt9IZka8pZrdZK3Uh92yUwcSagvAV1BYC2Y0uz0IX4/s5Z/psZrYL7LH0vO4xUE7M5Q4gfl2B08dCUlGgy+gn80Hqa6MPOIH+Qe6RTiUHzBZTA9n5RnUDHHih8zCQ/ObdnDOfx9mvF3rZE1Vic+3zxDaUgGCJLhLRLV0MXhIuFSfSsIJSjCoeOzU7RpL5l/ZwxAdCT2StTNfQMDivLuiOBoT6MDasn9G194lzc4PyHwd3q7RIZYzPAcuENxo9kUpL0h/eeMT+RFNH49M6GNxB9fpbS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(26005)(86362001)(52116002)(6512007)(6666004)(478600001)(6506007)(41300700001)(6486002)(186003)(38350700002)(38100700002)(921005)(83380400001)(1076003)(2906002)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002)(316002)(36756003)(4744005)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QuOkUJxnXIluCyb+l1qY0hU6G5wyxDgWajQ3HG7Ug+CkckEaItUuQ2ZvBZhQ?=
 =?us-ascii?Q?x3XPXbJ5N7tsF05BRy1QWWBwjrJZAR1w4cuwk5Yg7kTVYhG8W3oMBgZExPSk?=
 =?us-ascii?Q?2gIlzHjsX/M9aD+RNUP56WBTG0jAlEA79u9MEkD9OJkSKvIOnxJZGkbt5u3q?=
 =?us-ascii?Q?wUj6srv+LtvtvMY9LYIb4u+Eh+BSzoAzWt9fE46uByM/Zbc4pbrDU6hcWDul?=
 =?us-ascii?Q?EPBv1/2D+womI71v58nLmizCeUD9fkcmdUi6lJDTTJxE7Ei+Rvif+4odOP3Z?=
 =?us-ascii?Q?YmIrXi1R7OC+waJOdS9KRLrejb/nBannRi1arbrfRzsZlUAltJ1Dvh4cEYC6?=
 =?us-ascii?Q?+D8bnd8mquP5k6YEf1TUsylb9vJazU8Tw1G5a7Ae9CMkt3hiMqP45gLcuzuz?=
 =?us-ascii?Q?3ovbh5X6yIi1U+NAH5A9eDVtlfEILj/oVV/f05wmQiWeYbxQaKJY9XjeGhjJ?=
 =?us-ascii?Q?PA5heTQ6kqgvg/BH2eYCCCSHxPBvBlLbS2rBDUpAQ57aI1JN0M6IgH9GztUQ?=
 =?us-ascii?Q?z217MVHeTwFXMkbcbaIlJ6Zr1ogiV1+n01JQD94FhGn1OdL08wm6PTA1jSVv?=
 =?us-ascii?Q?A9FmA41t5C8Ywv5puSLFijOkCa3UkQzppbRZmDnAM68EwBqDJk+sM0dAuIeX?=
 =?us-ascii?Q?d03lU+0adYwlDjumA0dJwBuHUb7TVkMV9Pkn9KtW0fhValHSJj1g6Eq0K8XU?=
 =?us-ascii?Q?brsDjPSlTyg/iVYOQq5+KSi4M+AkhbxTScBKA9wbMocLgpzZNNDyr/U1Vrgo?=
 =?us-ascii?Q?JV81eCMZFSJqZsCWsfVsgVTcg8ShNtCAnhgd6EigM00fjNnG5FyzVPjH3ZeN?=
 =?us-ascii?Q?ew03BWUQIRAPHyAjD/btVhMP0Q4SsXKaqhnJgJSXCN/YzBfLuCk0YuyzTItW?=
 =?us-ascii?Q?3hkYFxfb6J9/0vtSTrdjpax44l5gP6YnZSmN6+41QgEymGzqASY4GcHEpMM0?=
 =?us-ascii?Q?HaPbP1WycNb9DS0rgfbk1qwcToHPncJ6ganr0I8pJEUZ9L0Jrkq2/9ON6v/8?=
 =?us-ascii?Q?x4EFt4fZ+SCroos4z2aOTHPozAYsIAcGQmlzFSOI769lrZzNG1WPa8Z6fjC4?=
 =?us-ascii?Q?W/x4Eh4TKAWF+NFWoSMvoPM5mFIK8cauTe4wXHOWbd2kSL9M4XMwW+Uj3AHY?=
 =?us-ascii?Q?rigrC4VEdIZvt9RzBJRm1AmaextCagKZTGrwGn+hEsDa6tywYVno7+vEhy83?=
 =?us-ascii?Q?N8ew8WD5tzDtG/M1Z5yEs5/RZqbdMtO6Q1KtgGtg7aFnXlBGT5hoRvN+a5IM?=
 =?us-ascii?Q?kth1Ck+s3m1XVbGRtDlMrBS2XgflINeQYH/jCOSyzv4n5BEO7oe7lRTt2A5/?=
 =?us-ascii?Q?GgNylg147abgwUcyer7fGmaD1B2AsJUv2NpWd5ghfKZs4HkPVE1Zzy5ageRR?=
 =?us-ascii?Q?zecUNZlzqF4q84GLyplxD7p2H4CzJ85VH3EhcFYrMGwUyW1XxrIJT4Uzaj+n?=
 =?us-ascii?Q?wla7oRWnITJLXxTw4XxXmlVWLdGmquggKrMkc/9oc2GIIyIEv7cBJUpuWdju?=
 =?us-ascii?Q?vyQhgIHxdutT330dGYqhlENs6n5D8JvkpIedUXCot/OnAt4YF/9hXqwcaNY0?=
 =?us-ascii?Q?bmf5du0ila3fmisRWxB3aW4pTbZec0CHb3nROSMk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d838c0bc-10ae-4f56-04a3-08da89d39668
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:31:48.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WH2GaKAKedNZKt1JNrAUGg4gwsRE6pyjFd75lpvZrruxzh0Q+jz8rF9BMxrRmUcELXcHuFMF7pFV+TTDEDyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to spec:
            0000 +19.95%
            ....
            1111 -21.68%

    45 * (1 + 19.95%) = 53.9775
    45 * (1 - 21.68%) = 35.244

Fix MXS_PHY_TX_CAL45_MIN from 30 to 35
Fix MXS_PHY_TX_CAL45_MAX from 55 to 54

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/phy/phy-mxs-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 9292d8e4e92a5..f909741641ec3 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -193,8 +193,8 @@
 #define MXS_PHY_NEED_IP_FIX			BIT(3)
 
 /* Minimum and maximum values for device tree entries */
-#define MXS_PHY_TX_CAL45_MIN			30
-#define MXS_PHY_TX_CAL45_MAX			55
+#define MXS_PHY_TX_CAL45_MIN			35
+#define MXS_PHY_TX_CAL45_MAX			54
 #define MXS_PHY_TX_D_CAL_MIN			79
 #define MXS_PHY_TX_D_CAL_MAX			119
 
-- 
2.35.1

