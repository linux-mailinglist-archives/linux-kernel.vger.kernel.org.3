Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0983B472678
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhLMJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:52:33 -0500
Received: from mail-eopbgr1300117.outbound.protection.outlook.com ([40.107.130.117]:19251
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235148AbhLMJqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:46:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh859shriWM6+OZhh+BbNHKAQpb+h4lpTD1wjOMjZf79nbRy89hlInGc+PqvQCxokWsMYiIU+9O0YSFXOoM+6y9eEhpAlQyG70jN7Vi+TZRIbDtsJqXo+ijF7voJ3BsbIY2VdiyLiufgylzHHBQ+A/00kUzb+taWwjsgyq4eJdrXHS5F1HnIowz+7WKt29/BVdKJJJjryGqFwf/KBPzGdjNYARAiHcJuE/AJDXzps7Da8b0Qq5KYIOK4PvcYsLZP0smx9y8oMt1MmwJ1XW3Bdzi+pl/97vb2JjVEtOYmCeUBSDBERHPARQaDQ1/XHcKSwJIHYS0ZmFjaNNvp+wPNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZpBKZbvq/ThrOzQemUCsi6B33nSp+hxaExjHY2bXe4=;
 b=M6O9R6U++9F+3VU1HRUIZTW5AEa5pL1TUfc0UUX/sPr8/e9zEsSZ5yjVTE11h5E3h4Mmv6HX4OPKtkK2jvHHDipOMSSZA4l/nbeA9RYF19mLaXpZhAGhtWMSQ3zpL50eaPUoH3axIlkNNM8tAUyFXEoVJmh+qvXNBVj483RNPWM339wejRHyPT3HLASw56X2QtOtOCfqY4z+vW1mCuQpm6CleeCJo/FeIMCTtJi79jrvLNcDk1hiUKRkfPkNDGrx0qYYqmoJPNAsZAbN1Vx3zbnJEVo/qj4ryiV/I2eBgaTxsOs2TVTyjtlXJFQeks5CdFZF9U2fbdgkmy2qx3dLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZpBKZbvq/ThrOzQemUCsi6B33nSp+hxaExjHY2bXe4=;
 b=ZyoWJfea8px0rGdroltbz1+2YVWNhSvdjMu3lQk3k/y6Bril++PI+m0eyo3UIhT/YGfGw2eyFZ0Nk3fTsomWE3skfdc2bz1anjhAIc0rHW5ZyWp5J6/sFXjegNshqLhYL3YST7BVt5WvuRENqgq+Dwq2n0+NNtCt3s6b9UaceKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:45:16 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:45:16 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] bcm: pm-arm: add missing of_node_put before break and return
Date:   Mon, 13 Dec 2021 01:45:08 -0800
Message-Id: <1639388708-64085-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0222.apcprd02.prod.outlook.com
 (2603:1096:201:20::34) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef49ba2d-e1d1-4540-718b-08d9be1d4470
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3050612E33DF80DAA3030399BD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKoPdGJSUOoJCcJkcOslrpxN/i8e1nRWfMTnwf3wkI0KKnlszAJ8qyVLu+48x1uZ7NYs4e+Mfn9393P5CEpfyDt6cwjXSlO1XMB2bTch98GaY86cRJjuX+ull4aRApwO0tUBqckqM2wT9TyRKgvOnYZB5oQ1geeg/0zeIcLwwfnDLkHg4tzTPl5qkPymib6D71PS2RB+tJGv0qw//vkz5NyupXip7X1j1i38hZBKWszUtl0yRoTvEjRn6d/Se2IN/sATW+SVgeyMv4dutRW4xideGOXz/n7J2i3XotLmmNi4/+BPh83H8AYWpIZYJDrE1DGMI74NarNUMp8rtQPkoREtUlyOix+9WCYYMut/Daz7e9N8CVxn3Muu+eKR8/EMqOkCAPYnzqBi53Xn+hvsT9FaTHkJODCmY3+N3eQfugVzm1husL6FEQntO78XsV42gQPZIGSKj2NF45CiXTv8Gj6shlYlFzgOnOmqWbcq79XTV8vaquf7jM9Grapl/yV8IDmUmF+AvHcJ2j6/XsBtOgf8+EAIYKoDYHM4Q8h+qyFgiAd4TfzMPRy2N4c29eUngrFexT1BrSEeVx+0ldRsDpJwHGZdefp58tqygZP+COYIwfEsHKdSEvWA9t2GQNHBaN0t5fxefeDf8ZlfXW72QmNU3opbDfXW+XsGW0IL08/gpRytVpAxoRlySFwi9yYSs3ho5qZ3c8/q7Kc0/InPmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(2906002)(316002)(508600001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RUoeHq5DjPBo9osrB2tdlZq5phifdl4rhyeE7kyyk27EmszEghwVKrOUH4V?=
 =?us-ascii?Q?brLbrv9rvbsVnd1wzK4DgTOG4G3XRm9cYUGF5qJwyuCsnVKOoV7pWjpD365X?=
 =?us-ascii?Q?5k/YLpnu0yIDOxWyL+udjSBO5TrcAIwG7IrpTR3vyZzpAxtXVUpPmPZ0qgAo?=
 =?us-ascii?Q?sDrPvoY+VpwNB1EEjcdPx6oGlaeS4TsPVqwfDzrmdTrnfT0OSFxezOIDz0Dz?=
 =?us-ascii?Q?+W80ZjZ67iHYvmjeY+/GSLzKOzQuHuCoiAw7X8uKL4+lVK7sPPMS2XsHqKzF?=
 =?us-ascii?Q?952kDxQR7cH6GEeC6ZPPDzrmJupHctvsMue6cLApou3Sxd3fuKYahNcO+TA8?=
 =?us-ascii?Q?TP3rdtJ/VelytQp8QLYTfu69gX3xY5yF9DEcy1/GK11qNftY39AyYU7S33/a?=
 =?us-ascii?Q?CRoTXcm78AZpcHMLlW8m4QJO1LdXFCPktky8AnphkOyg/97DeE4vHdnNmU3Z?=
 =?us-ascii?Q?wUVIrHRA0Jnd1SgyeChbruVJJuKgkkxUlzW9vtELnw4OvzUMW6axo4JJmBoh?=
 =?us-ascii?Q?9x45yRKaSV7cR2Jzc8I0+fJW0ybsVrSeTJBcYzIuevkmyy1pmZG/74pyf0Zr?=
 =?us-ascii?Q?/5wuIqJ6ZLw+cWiHe3sum2CS+3R7PL0gGRJmXy6ESsJgO6MTPBK2T8QtAqvV?=
 =?us-ascii?Q?0P28mi7gFkLqdAZlwiNmVVOGAcZ/Wv03V6A/PiZsCwu6fh/9R2ctxIGam1B8?=
 =?us-ascii?Q?57wtiSOBcMKKg7BJGdqEbWliLiK9l0t7CY3tbVbFG0XsOEsI783KtcX8IWe2?=
 =?us-ascii?Q?2C2NpDt8tAzZNX8WHh+uIv6mm30WAiLR9uDP5kCZ6dvzDwuAPh1Nc6+tLwhO?=
 =?us-ascii?Q?lPipdlLTZdCo/NrWjfCoKjy9EqUYtNy3bDkaQGjumMRIDx3DlEnlvvTyxm6/?=
 =?us-ascii?Q?9ZeWUVlF/d1bcNfBKjgGqXIXvDGoMHjdX7Vobq1oSxpUI92/P/YwAmD46Mpl?=
 =?us-ascii?Q?B+ruVOKVoGtGREPmCjshTgj7gC8p9lzU9C163nKamuH9vY10WvtfdNTElJXM?=
 =?us-ascii?Q?C3i/zWqEbzscQTwXxctk/sgXHXym1D+qH4HCF5dNvqwj8CDRm7VHKI36Ulct?=
 =?us-ascii?Q?kvjwSvbwNeaURBnGYJD4hbhptSmaTmpBt5snRtN2Ngw5Vt0BtVUwE2p0ZC6h?=
 =?us-ascii?Q?GHtaPivB4BDAwaIxx9a3FAhvcb3hHw8DyLbUNWJSZsHvKyIjod+aqgCmWfqA?=
 =?us-ascii?Q?m1yNSB9vAnrRagGuhQIPMIDj4uyMASpGOOm+v7twhxyooRntnsPINkydlHTT?=
 =?us-ascii?Q?zx/JNxshGDylqquaFjlHpK4UZ7Hd1YeQs7GW1Z4+PfQBKI+2syHKX2wiEKTr?=
 =?us-ascii?Q?F88B3zXg8cCyAQXcQ2EdRvLUP8UHdv17s6NDC/qSOz3BtoOv9UUS1twGSPCZ?=
 =?us-ascii?Q?CHRbo3uioys4n3//dkqQvfgCAwTzT1uUnU2H4vWj+yMLiH+KB6J+eXQPdUSD?=
 =?us-ascii?Q?zoo8pDh7h6klivJ8YAy337u9+2nSELG1B3X0OPKfsWNVTnHFxXFDhaOjgkJw?=
 =?us-ascii?Q?8Rsk+JoyjT17MJwvUCbT9T65wX3G0kZqevgcPREExw7lW62ttwYVdzjf2fW2?=
 =?us-ascii?Q?KgNkRIUaQKbQlflZUbBWBo8l/+edvZTiE101A6/ePTFb7K5SyXaJ8AHDdAmb?=
 =?us-ascii?Q?E+VbAVJla8q4B5bEXTOJGcU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef49ba2d-e1d1-4540-718b-08d9be1d4470
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:45:16.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YIPZMaLX/XQffvd8YiSGrG9QNz3/qtfTXEWQ/XWpuY/Nfa0YomrcFUsOySF/YY/2XRLVW3DP3aM8lslcwJOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_matching_node" 
should have of_node_put() before return.

Early exits from for_each_matching_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165..caec114
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -731,15 +731,19 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 	for_each_matching_node(dn, ddr_shimphy_dt_ids) {
 		i = ctrl.num_memc;
 		if (i >= MAX_NUM_MEMC) {
+			of_node_put(dn);
 			pr_warn("too many MEMCs (max %d)\n", MAX_NUM_MEMC);
 			break;
 		}
 
 		base = of_io_request_and_map(dn, 0, dn->full_name);
 		if (IS_ERR(base)) {
-			if (!ctrl.support_warm_boot)
+			if (!ctrl.support_warm_boot) {
+				of_node_put(dn);
 				break;
+			}
 
+			of_node_put(dn);
 			pr_err("error mapping DDR SHIMPHY %d\n", i);
 			return PTR_ERR(base);
 		}
@@ -752,6 +756,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 	for_each_matching_node(dn, brcmstb_memc_of_match) {
 		base = of_iomap(dn, 0);
 		if (!base) {
+			of_node_put(dn);
 			pr_err("error mapping DDR Sequencer %d\n", i);
 			return -ENOMEM;
 		}
@@ -759,6 +764,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 		of_id = of_match_node(brcmstb_memc_of_match, dn);
 		if (!of_id) {
 			iounmap(base);
+			of_node_put(dn);
 			return -EINVAL;
 		}
 
-- 
2.7.4

