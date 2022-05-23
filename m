Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AC531034
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiEWL3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiEWL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:29:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7294EDC2;
        Mon, 23 May 2022 04:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD3xIa+JADo4YLWM2myUDBg/MTLGYNMM133Z8B/5Ys0aOWFlHxjS9pXN28rVvxav46L51TjjdExYB08bG4qGneVAH24zwh6Rh8ayu7+Ia9AIiC0a+Q0WA2lKtHheZKPw7lPATqjUPW6EJLuHNbkv6BqY2CoOQSnb6mn12OhIWF6D4VE5N4AxLR4veh9NN5me9kPmcyZ8Oly8UriWFKXZF8jHD/YFWjOYm9F2bxB7l9mN+UQnBjZ3q3y/3LLHYjw987BWGObPeJtnMRk8KKlbIA2TslvqW0vBpYw8cxsVL0svX3/GZ/bWIhJcKszYtfVVIkwD0oQmc25vSwKiSkMeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=ct1fGdyCORAqFcjOoZJggifsi9I9TiKI+EUCzMu8l5YifRVtyTcrh9MGDCm59E8+s5+SXMUj2ob8zoDh5wXz5z9uU4Te/Y5qrU+PCgLvveU1y7DgZSG1EOoihRe/2pkT81Oncb66WE/alPWvV10gLhICL5tLAbfoIj9/r8LRZPM5JT2C3oE3co11clnGUg6c2G4BvbKGEKz4wKku7rXEkMG7T1QspaWK0aFZPj887vJnXSQNs5cRIU08MWOsHmj5S5VsGBJrC8qAXmaftp9/b3jFZIUA21jhogbpaev8yXRwRu9PldF4xm6Wu8effodcmCjPGxtWW40nHu5e+7EwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=lpaN0lQ1Fyo6JM3WSraJgPG1GZxDThkJYyw3g+/Y6pIWte4wkZL7lUBW7ATuwCF4pa2XHzC6oKJdcJsKvRwdJPvAx26qoS+CyKBka6f7Hh2bylL2EnevLb7UA4luwgTyxmvBBAVaIMU8sXYnUbia2zcpoqKYrDbz5HRlqaNghmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6586.eurprd04.prod.outlook.com (2603:10a6:10:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:28:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:28:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/7] clk: export of_clk_bulk_get_all
Date:   Mon, 23 May 2022 19:30:25 +0800
Message-Id: <20220523113029.842753-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4835409b-9512-4e82-3da0-08da3caf6c6f
X-MS-TrafficTypeDiagnostic: DB8PR04MB6586:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB65861FCC0630405B897CDBC3C9D49@DB8PR04MB6586.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/nWY0/Fp5eAyGtDwMwAAHtTcceoiqofXmxOq3VXB9KY/ZiOIbUH0GQQ8jZapADDZIycDJfsiipOQ9/xhC3ivnKY0Lp/VVfMdi8108ry033CyadAKxwVzCvz99KLmh6pZ6CfRrFnKHD60VabgK/5posM7OfNBO+IZSYPyDVRhPJnSgKsA3gJsqmwYp6/4OWiJkAJfWL+R7jK1wgg/0MrOr0Lz1vy+UTr8hc4Mo8komsbGi6onAiiF4XtXfZLYol/6AxjPFhy5qmRwojuaXyKJbvxplsPAO0rgEY5BOgOkF7FVthk6DeW/1VUD90dJPf0uu2MMftTkDn3orgM8J2ugK/OpSTCWusGu4Mnw4z891uaEJBkORWLN8pPXVLSE1WtiSDWVzgefCQUwVKTZnoL1FwUeyNIu9R1wYrIRdp2ZdtiAv6zvph0L9Wu+eOd1x8Be+3NbAQWiqYL+107ksi6AFMMGJY7s9Efjec2rgLecwX5BpldHmbhebpePoAY1XnSO5Eptm8bOH8u52tA8X13jqK4PrmTnpU8veJ9sYhYd3HpPfhAbLbHAuWMeNr9QXQhm+l2/y2o/ch0bD1uPoJ2L1W+dQVY13DuLHG098LqiWWk9CB/FCFvu6JuDO5L/KYWFAtG++U71/jL27xDXtBhiTuppaIamYZoWoFFjIBt65dd3yZtyE5wUKJDWUp/P/e1dlDONYMfiZNzi/pOZ9E6XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52116002)(6666004)(2616005)(186003)(26005)(66556008)(66476007)(8676002)(4326008)(66946007)(5660300002)(1076003)(508600001)(6486002)(6506007)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t73zoPP9fKP9hPGT/FSmdSNMYSCf99P/or4oaAV9Q5UzJuzODpaYUSLtVrRP?=
 =?us-ascii?Q?6MD/f//crsHpg7D4sr2FX0kb2TbIMNAs+eUFPxiixcmafGpGyTvEpxlsN7GA?=
 =?us-ascii?Q?58p9zy6zM/BQk0GPApdDL0VvmJc63XiSz0oGgNaZlVlhO0V8yorWnBL6JNol?=
 =?us-ascii?Q?5Be6rOwV+aUEVbQXHCCtvCV+cDJuAvsrtu1UIdt+HB5amNfCYWx6y6Kch7lx?=
 =?us-ascii?Q?nmcrEuMhWDbsM3te72aaFB+1DXc3WDumMrGeyiNHawrrLRlhNK67YuvNzB67?=
 =?us-ascii?Q?7wncJy51ReIdVHXxWQrvnpXMbybgf4mNUsJTM2Lb/TQ0GSU0AMgUfuZypcui?=
 =?us-ascii?Q?GfqJa4+3qWL3nr8ru5lA0w53hncHn9FqelPPfU1x7R70txspDhThCG/nbOvj?=
 =?us-ascii?Q?eUvNbH7YdJ4Kjiw+r1i5SFN1REQh0QpUnPitcqrmK6hxUSk9AtWRpUrpEpWS?=
 =?us-ascii?Q?kj+/PAxcEBiLKJG1hfgOpHFn6KuPhQb9/u0utbGWg4rpBeaMkYRqBNFbiZtg?=
 =?us-ascii?Q?1koVEl7ACi3i6SucaZ2sz6Lzry17rK/+DmXuNrMXzyp9UxlgGP0aUDSwhOK4?=
 =?us-ascii?Q?6uS26ziTOxg5yfwiAc5Lddf61JjoRRHmQDuzUSjp2uPhMcgHCKeqwqBw/Hq1?=
 =?us-ascii?Q?5ORyOPDpmSftVmSXY00Ecngc67WWdzqvv2qpMlWHj5uTnR8ZNOI6mpNxoJQA?=
 =?us-ascii?Q?4Npj+ARCMOeL6A9zn+sy/xH2PY2+kcxJ1Y3OfwUmIdcR6JAtWIk2OnFa2HaP?=
 =?us-ascii?Q?SuZltCzV7IXKXGZvbKk9LtZs1NhQxhu4rGx7ZvcKo1dJexsMat6wqOjbm91L?=
 =?us-ascii?Q?1rNmygqxYroOWWlzAvj+mEEwInL9l9OK4MsPn1RUJJeYDCD3Lv7wTbp49woa?=
 =?us-ascii?Q?ubldcKljXahZjbGF9INddXrhyapB2vpRQ4qaLyu439hY/ityT/m8/eTxYAU4?=
 =?us-ascii?Q?66fXTZ0ueazLEeGDDrVJiYiIeyChKUT+FeuNhT3A9aKFbbTxIqkEgmFAQHVb?=
 =?us-ascii?Q?7kVerobz0fEuh872xLFUdiYDguvMZLCS32Cf7acba/+rtIooJaD7JbDZ6tLX?=
 =?us-ascii?Q?DBcUsviQLvkjA0FjoixPUoW9n3qnLK5g6yZh3ylrPwzMI7pqFo9Z4qp5z8uW?=
 =?us-ascii?Q?nHhkkszaOkRcOuvrun8xVac1kHKh7vIi5vuAq9sLpB1tAGdaSIyKokCp/DFV?=
 =?us-ascii?Q?TemObjbgSw/X3sSCCb12yi4umpIvlsfKlldZRxZBZiiJcDwWeYowkduga0GW?=
 =?us-ascii?Q?gEJbj3Q7byGLBXslTCSW2hj6PyxXFEPuLGRIN4ZIhI3XTAf9ooJF7eBUfbOP?=
 =?us-ascii?Q?hY1l3i/Qzwk1DAWntp+UOyhb5UZE3JnIV0YTMhr+Ziq2kCfJD7DS8BdzH+sN?=
 =?us-ascii?Q?6pXdpl+lbUh4GTwoOzZ4ztASk/MBFF+FQ0Ntm7OGe4gaGZyegKKd/FgWxKxq?=
 =?us-ascii?Q?aCvo966xn3tWhJzjNLe6hU2KbLrL/hbKqkgVGWnJnmW5dD/S42DIE1PcYSya?=
 =?us-ascii?Q?JgHDb1uo6rLKNFtkYHncHnZFOwTvqW5R7bbUk/UgxzMClHHEuZ1f49iNnlVT?=
 =?us-ascii?Q?Nn5rF1/qC9J3VpUQi7U7dx5Yrw3gi68A0nCB814HEO6aS0ury/MAMI5shDDt?=
 =?us-ascii?Q?mNbGaPYBDw+YocDy/wlnn3NU+iWnZt1h3xsegrSj6T+h/ZYJiCx3FUXYTd1l?=
 =?us-ascii?Q?ns6dg8g2WhuZdHeBqHwJiWunXQA5eL3qOupIACbIDHEbSdZh9e92AMxeZ2Lh?=
 =?us-ascii?Q?oyGuWmKp4w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4835409b-9512-4e82-3da0-08da3caf6c6f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:28:56.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POY8Fyk0AcEsuAWQlCbHXD1T9efFHWwv2mUlBrWo+hcYDg99P0Nsi4hfg7h7mtMvE0r014Vk7PbxYr5BEOSgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6586
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Export of_clk_bulk_get_all, so drivers could use this API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-bulk.c | 3 ++-
 include/linux/clk.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index e9e16425c739..470155856b02 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
-static int __must_check of_clk_bulk_get_all(struct device_node *np,
+int __must_check of_clk_bulk_get_all(struct device_node *np,
 					    struct clk_bulk_data **clks)
 {
 	struct clk_bulk_data *clk_bulk;
@@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct device_node *np,
 
 	return num_clks;
 }
+EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 39faa54efe88..ca74f4e83d25 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 int __must_check clk_bulk_get_all(struct device *dev,
 				  struct clk_bulk_data **clks);
 
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks);
 /**
  * clk_bulk_get_optional - lookup and obtain a number of references to clock producer
  * @dev: device for clock "consumer"
-- 
2.25.1

