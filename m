Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40D65A0B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiHYIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiHYIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C442A61F4;
        Thu, 25 Aug 2022 01:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTjRWhhtX0gJN5whj72h6fkd/LfYce0MKuJMRqumyqPToBftm4peHnVrvLVEoIvZFID2C9k02pF42OJfm4AEAsU6t4QqcqvOZAlgA5CcnimmuZkP/SDC2TEzjOyomMeSWoKEIXwLP+nrUfinoYHDddMcJLdjqemPSWPapIe+9mN3ww47B1uAGXppXUafO/BN8AWM0mN2kEFqNxG97ppdeCKGPsVPOdFZAfY2PM4WZx3lpczN1sFEu8luYTO8ydf1KU+MfhaC1RHcUtcxK8W+0UnXqPTkRE8gNjLNN+NDeNf/VTvmv/Gp6MyZ7tZnhLb5N0qUfXip6sx3Lqn47kicDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOvx8PFif0c8G1i/uD7gAfYKTonb/FFBmXB88pWKY5U=;
 b=iZQO4VXuwKpY1j8mL7gdF9xg3Kde7F2n5jDqylpps4kVkMPz1+X3kqPzYUooTbKQGMIeWZZcVanCD3ADTY3MsSU6xqwrp40I4yQ7Y8WSaDPdqeq4Z9eMQ/fio2mfjEhgFMAI4qF0CHCk8C4pwRvT+G1LxpRgAyG7Oh07EVFVsPlMTGN/mq/Zyb3E5ms5wwkz9H/dNpBYmdQPP3z2PkiSoP7TZQbk/ATAHxaoqzie7vMn2jy8dlgIlW7xgIsTcSmx/CNp79QvG3NKOkRTC4682Ry3qya1Qs22UknskUKkpbXot3kLWqdcZdanRThEulJ4W0/w6FZAt6/OcEvZDFTRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOvx8PFif0c8G1i/uD7gAfYKTonb/FFBmXB88pWKY5U=;
 b=iPomr3L5anT1M7+rsEV8vnlmMFtWcnLaDaT45aNq8y9Sclp8zMb1aDuScpsSodrRpmmTxC9iUddk9hhp3x4f7SwMT07Hz8j32HtF3ugGv57Alc8bDSVKv9P/8/TjxfdlGJ33nnLvcl1FqwYWlKl5qUcOHKbLfVX2PGHuI2+rBvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:32:58 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:32:58 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Date:   Thu, 25 Aug 2022 16:32:52 +0800
Message-Id: <20220825083256.14565-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825083256.14565-1-alice.guo@oss.nxp.com>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582f7f76-4fae-43b7-67cc-08da86746a0b
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YikAmK7gqiz4gl2LCzERPh3sXkNnhZVAQDvMfIlmYEWFtjmnbGZjY46BNuflfl21VimGrj87Cor0c4LBd6S65kT4dx+Mixq3uYPY8dRXJwQK2KKjkFNu69cuXyqnjdjosrYK1gEe12aJvUR+03Ymuv07FGiPlu6bbfRxE56dWteaVR1DJn6mG/CuAkUeDyX7bei0KmMF0T7x+T1vyDMupM9sf3nEDp92cVmXMqSwdFLtPEWwcvn8uBqsDm2biWNvL5Oc328MXvdeOVkYF7Jz27Gf2sREYJbtXknXz66A2+ScDhQ4as9zBtnj2i07uhBxm+OOaxeayL3Sk2aW5A4oHpe65S3QENCDNPHYtQGv3722bGIdhSwS21L6SFkYmP718q+zhs0sfUohAvZq6hsr4Z+wyF1ObLl6dg86EuGvc63/G/pNJDFT3AJCa5G2Owi29BskMbZ3T5QJn1S4UaslKFkPS+oUO1u2rjYiKaILd8ZrGOdHHHjmCvyIGSoPrgGsmfT8R+51pinSyqLMBjSDFWGtS2FzHv1RhHq3dmmUmihqbgsueiGQsiXCNqnv1kZmQs0ttYL1jBzildtcIh2DxpCFY0/1vZpZg0FJrNSX2rniTL0NQCayBIqC9OLceyV2YxcJid8UQwYfVVw2MTXC7Ks8b+xSY4EEE4OO1EgKViNLry6/g9dEAy9vFLmLZD0eQc0A4GXIQpcShoGvN5o9Ck76H4fAq3PAvILp6OCxddT/sbJYh7oFL0scZw0J/+S6WBxvFS1BUsXo4peDpdiDIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwgOc2pjEFScFFCnebuEY9rNGrHLepouYJ/bqf4MgqVrFvXxJiN3tHtPDwnJ?=
 =?us-ascii?Q?A2QCpI3N9PvRPyHQV30MkMFOCNjHQeDhJddeHkjqtMenjLWovJylgAJ0TBKC?=
 =?us-ascii?Q?UkvxqIp7Qt2BUTeNw8a1z9XDQOdW+6l2nFR3zwQsdl4D81OJe98iYPksFaat?=
 =?us-ascii?Q?2IvZXSOUezqN+RbIzFRHn/WL4p0rSmzmq26gKOgGzolkR9JGE8JJWoEawWAt?=
 =?us-ascii?Q?iwfJWDz7R0aZRkh4+IX5loa+ASE+Ifs++lYTzRVElQh38wQeReepP5vYnd3k?=
 =?us-ascii?Q?fXywhjwXkJlyDcehqpL+ItuIDEQJzUFF4VLg9hX/yhoHsZZAHp3ZOk6cNGGr?=
 =?us-ascii?Q?fO3WWKO6heTtur/IU1FOuI7uHKKxod8SkeWyVi61FrC9Row8oGTT5FMNltGF?=
 =?us-ascii?Q?Web4URYPb12xBpGvmIb0sTNKBriWfqJileXUIKocsL2s8MG1fOURxmhn7h2o?=
 =?us-ascii?Q?/ldKY6zK2xaHebgllHChAkFtpnHNW7U1qOrfmc9gvl2+xKVxul8JNQigEG2b?=
 =?us-ascii?Q?blqILfCLsXsMw/HiGtX4E0loXFG6vECPty1wGBoK371hUUqL8rKjmEV140YO?=
 =?us-ascii?Q?JUqg06dyCTHDgfnnqgkALv0893F1UlzhKfe022+LA0a40sGbx8Wd0RYAotQ0?=
 =?us-ascii?Q?cT18EfZsQzbiyNRlA99NAvztqSiO23+nYuoFb5u0e3UGLblroLoDt064KOzp?=
 =?us-ascii?Q?djkB/xmolWHJzCPqHCRtKYMVy6LfuK5PYeUFq8NJrGiwS9A3B2B192D9sek8?=
 =?us-ascii?Q?w+B6/L0MTem1PL/8/Mwq/eE3r//w1XrNOuCvbeh0yK+lEqWpbx/uK8N+i8h2?=
 =?us-ascii?Q?ie4xVkfD7+osDtJwXZA7SCvF5OSNegYAyDYhYHGLJMHyibvL4e/KgL/vAnSb?=
 =?us-ascii?Q?1eggfx6d3J/uabCKOfA0Jv/u2c3NCGMkuMUB2kWIXBLy6O68fYqA8SQ9Bo0e?=
 =?us-ascii?Q?2uwpZWysjphxYBPyHmM9BWnhLEwcl1dUFaHPr3elzLExvdmySci0kcMOyagB?=
 =?us-ascii?Q?JAupHPOalfT6EEcbkmfwh3rmn0pYBokaT9W3eg7UM1kl5DCzStJ4d5SgH81b?=
 =?us-ascii?Q?DV7epnNv8aSiQzdD84dPP6pLExCX1UfInnFt2tR/dqiAEScH9aIrX2NEXyUG?=
 =?us-ascii?Q?qQ6/UU0w7xJZsXPZIGO1MI8msMxZN1+V2ON+36YYOwEYLmYeBDoSz3ozShI1?=
 =?us-ascii?Q?LXkMnjR+IL34/zIMO8zvtKy9w+ZqNan4bzrjJZQDUGWIbFjo60AGyRbitL4L?=
 =?us-ascii?Q?ov9Tvg5qIQ2W8DBxczygEbgGXsXgQZehZhzej3pqVRs2i0oBZrZEX3nTAGfP?=
 =?us-ascii?Q?1TEN0HtwQQioVCOqXg9W9qRfIDHMmrijwxf8Ho5s6wbf/H5rqznz9E2JchuY?=
 =?us-ascii?Q?JEk+iwSZ4NpQSTkcty5ZoPy60wDaxPWqoVnyuRsa9IrIM10LFjBAQHVASjJ/?=
 =?us-ascii?Q?ARXD9khhGtBkmHThizTzqbrw61ujPIvIlrOxRXkfrx9FBvaGGCXC3zfoQmXz?=
 =?us-ascii?Q?B4ZP9jT0/83xaPEs4oZ0aXEqV1dNLtd6SCUxLIsvmFlo3yJbqoUO7r9JbBvm?=
 =?us-ascii?Q?TGKwO+Ab3QlA+cVJ0qSG7GP62xX0z+xJf3mUwqdu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f7f76-4fae-43b7-67cc-08da86746a0b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:32:58.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PIyAkPPnYwmbWkQ76EHG/Ww+kvHFvDxL7JrUE6Z+VfuYZnJ8j9Lhlwz5EYfD/R0jkooauEB/c1rKtV3wwJSwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Li <ye.li@nxp.com>

When bootloader has enabled the CMD32EN bit, switch to use 32bits
unlock command to unlock the CS register. Using 32bits command will
help on avoiding 16 bus cycle window violation for two 16 bits
commands.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---

Changes for v2:
 - none

 drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index b8ac0cb04d2f..a0f6b8cea78f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
 
 	local_irq_disable();
 
-	mb();
-	/* unlock the wdog for reconfiguration */
-	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
-	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
-	mb();
+	val = readl(base + WDOG_CS);
+	if (val & WDOG_CS_CMD32EN) {
+		writel(UNLOCK, base + WDOG_CNT);
+	} else {
+		mb();
+		/* unlock the wdog for reconfiguration */
+		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
+		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
+		mb();
+	}
 
 	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
 	if (ret)
-- 
2.17.1

