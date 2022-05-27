Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB55359B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiE0Gyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiE0Gyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:54:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8DBCA7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV60BnFKuANmqgkOweW7MVAhvEN6znrr+OATF+EJNKy1TynsbSFZ51nH6b4NXxB9GvHG+unftfUDTu/KAPTZz/kKdU39xCFO/c40p41Ro3jMqpCcgLOVdkBhcRY1c4VIlrSvwl2SiOMrk4JC4WASUiUEVeyaSAwCuD0odPBywef4mt3twSaX7jJSI3kItDQjLryffA5qHO2qNRZfeUsHiWuUj5pgTKfw4I2TnL479P+VACPuqoKnOwcri8EF/ZhxM/O9VPS9EgOhNzbMpUS8lWnK19o5MaZxnGUZOsBgosQbyWc9SLRNu024MjhMxlR4nKTEe6VsBs7bLDwkBZx4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEWL3YXc1rYYEPJpdiOkM5k6qpACnJFEbxJApmZCJWs=;
 b=WeSWyieknjzeeYiYxPPfc1N0BGNG8QzLNlXsM8ZhnVD6oXdY5cnyKyiT2iO8SweypV+LhJ1NWBJCwpaYehoEpwZEAhVRh4T3VHsYo9mFxzAoqf5OB22Es42sVq/QVPuhCG1BKQ2pKjri62/XeibN3m58MtNkaXdINx9p5t91Ea4+UIdHKafJ4NTm7YRm0eZfP1ZSKsDUOQgVoZ/YUpbHn/4QX90pRRbVGHxUHcYKdeaPvjKHXLIjS+yh+o12oEYXs/E2HCc71UAo9l/A2/v+oy+hLoJqmz89vmwGDHaY8yafO46snwjOfy0DwsJiFlf+mq+KMP3Na+ssKUpUXbLVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEWL3YXc1rYYEPJpdiOkM5k6qpACnJFEbxJApmZCJWs=;
 b=HuNGhQ6lCrVV+KGbVaGardm9JwMhKoFjy/0qqBZH5+SPeA4g+++eS0BMj7y/gmitgQu97YPrFP7sz1c2hHKGa9GP/SzNmkuwyXkpIkYts2/fHGXNwiFS5S+8oQo2QTvXybKjjTsi+EBI87nsPpqTtKpq1rU8X01z/mDZqaNP28w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB2371.apcprd06.prod.outlook.com (2603:1096:203:46::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 06:54:35 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::a92b:6d92:5ad9:febb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::a92b:6d92:5ad9:febb%9]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 06:54:35 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not needed
Date:   Thu, 26 May 2022 23:54:12 -0700
Message-Id: <20220527065412.3677-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40245e5b-95e8-4a08-1fae-08da3fadc284
X-MS-TrafficTypeDiagnostic: HK0PR06MB2371:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB23713D97F5F9BF1739FAD01CA2D89@HK0PR06MB2371.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JoOhOgqWtkd5qwutXuiy198XO3nfpo8u5/MC5QMBZPZ3f9Ab/tBjxLE6+gd5sJBW07Ww+RjpDvP3tgdIQpbapD/r97BwAW7fI2sBBGriILDo79mF95+dqYhUit2d2VRTkuDRmjJZp00xMXttVvWSX/io6OAf8iSKcTN1vnBc2C+AdK3xrneyt28IYJnlI3R+uL/oskaK8EaN+nLqUhOkQMuj4/lXaXJ3dJaqOutmlF2r+HczzLlQefVQCWV+++dTI4MaCKBFgDeQGHDye6TrrRVIwwghModuWRZ/ycAfj1owxydaU5LeaIf+CNT9vvcdbwmBFaBvxUxNYEGpASHoGqyDyYyDujftvyUZssangfe9zid8ZbFETwz+H/ziFL708KiB6UcZ1D3AjCB7gMCgrrh6R1s8fLQA6HEOesmASr6dPkR0qxJh0n/tCoER1oPmQBB2qMIaf2P05WBMYGKyS2OXFxrWsTBCaG/CIYzvkmWqU7G1OW4VXdhznC58hmGntT21ZCFYneix6iWeMbayi011ZUswqTm/b0Z4PfvJuYXCWoMMZdlFV36maz9XZ3zMEbXMSXHFGhtU/5bii++8sUqzjUaaWqFuzFoxtrH+qi39I9kT3gEd8VJcaejOvJ+ccQ+uxpCZH+76dDJLTtvkXqPu0HADFtWez56ziaqT8JzGYUkFztOlMeKbQ+z5kOM5c5zNhAUpsR/X6FNsIxfrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38350700002)(38100700002)(508600001)(8676002)(66556008)(66476007)(4326008)(83380400001)(66946007)(6506007)(36756003)(6666004)(1076003)(6512007)(6486002)(316002)(52116002)(26005)(8936002)(2906002)(4744005)(110136005)(107886003)(186003)(86362001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGdXtrTvcoz1LORfrgkjeLF7a/g/T+CHXhBwiEdPJVVplfq8aIuzn4L18rSC?=
 =?us-ascii?Q?ONI1/EUtmu+j/kPNBhupcoCJreUqeyadVNvuA5AyolIasI0v1/vqe17UAYNd?=
 =?us-ascii?Q?YMmAY1Urqaz/5/HpuHTJyk8uaPPLg8VJAfn90buih+I93N+CJlFJoQo4E8vc?=
 =?us-ascii?Q?5xvvLNCcHqqFL+TUWqaj/oo9HXOYDEJkOjNS6u1b/lHO7trZ4JAzhisuwKxw?=
 =?us-ascii?Q?pJcr3mCLfytG9TW7q4o7Xk1qMPgLh6CcqhOrHbJRcNykXVutL7PLs6MHNSzy?=
 =?us-ascii?Q?A8+iXoy+EvrD5LPigJ7OzXz2I+95WdBBKaOFvwpWFhoiMDU6SXoS8CvgzwW6?=
 =?us-ascii?Q?yeAoXLoOWWOHb1rNesWko5ejG5EeQVHqFQAGH3eVrsn7B7sGNLy9Q5My9jPT?=
 =?us-ascii?Q?pdOtEsBj2/JZnFgmC/sLxwWvk1PYJJpl13BGzD02gudLMwztLW0oKoXFuQcb?=
 =?us-ascii?Q?BjgO7HOJQ2ZJb6EZoShR4uMkFPgH2NRN1Tey3t8A2Plpd7eqllpZCy0W3XOE?=
 =?us-ascii?Q?+ggwYp/ExZA7czTi53iSuYAdA5NoszjoBzRsXiKOTWu0bZJvljqPbtlyMs8Y?=
 =?us-ascii?Q?9cMfYQXXRMlbrAIO/Rx0R7DOYUANLB/OSYgelf+JaESF2nmI/ktKVZ3roEq6?=
 =?us-ascii?Q?ndJrdJOb9oHiCvX3W2mdiUKDGxJt5Gka15q3KPq+pNdgceAdbAwwqiMb/TWQ?=
 =?us-ascii?Q?lHfGSLPqcFPI/30YpltH2xVlqxbpK0qVg2c6ghgF1QbXYT/GzvgHJY1g7MOX?=
 =?us-ascii?Q?qWBXY7u3fDlgi2Ffk62fI4dshq/OtMd9Dn8vuW5VCh58wASbMnC6N/Vc80vb?=
 =?us-ascii?Q?L+0Hot+NP7fK+OBlyFQcnkjNpp0T0VSyK4s104/sSt8x1nBYNyR8i0VXHTWS?=
 =?us-ascii?Q?4rn248pRNdBCWIu+TUK+B4amD7T3uPPQ6LObnKSnX4CdDtgTc6rKOC8Ct+Sp?=
 =?us-ascii?Q?X9VQwdOGNQp3Heet5KyhYtcuQdpe6YnqyWlH2r2CFaccopqlvJNBRTirER3z?=
 =?us-ascii?Q?kAcNiQNENH0pbfK/TVSetL4xs5K7DjMjHTE8Uc/zu8okTEm12PavxXr01DQd?=
 =?us-ascii?Q?kFl3lbdjBF+uZQnTnolUeO7gDp43J+fUNcSlTBgjF0DZhtOrvCnVkoMBwSdm?=
 =?us-ascii?Q?+ATFVV1h90emh3cHRZjKzBrwVeCgIozCCJNfX+XIMXjMjW5FOzX6/mR7LQlZ?=
 =?us-ascii?Q?orgOk3CLitkUxQiSTism0Ed2YfNPqyhG2xCl8G/lqZczEa3bpw8P22bbOiI/?=
 =?us-ascii?Q?UJ9+u+UyhmGkIQTTGjmFN0mwUr4saojv/EzY39ySlNcHeuB8WISe1hZKAi/o?=
 =?us-ascii?Q?xF5CZESbMeXOFYv3mG5sPHVnbLc4H7F/78cgVxy/KS/PlwiMR+e4YGCrjRUJ?=
 =?us-ascii?Q?SpoQHksH4bYEHaGdCg25CZSTdvc/iYV96OTrwsA4w6+zRmqTcQqWSFmyneRe?=
 =?us-ascii?Q?exAFfmjGysr/wW3Sdqf2DUqXtO+8Dxp5IFp4pMpgt0NKTdGV30HHYy/+Loex?=
 =?us-ascii?Q?Gg4L7JVCS9tqA65mZkylsMZArJv/HgJPKC3rOoJlzFWYl334mtw25iWgwfqL?=
 =?us-ascii?Q?V8Rb4DGo77gCyBKLui/WzElI8gKZIBnh5tIwAqd1h+gw2u0fwU9CmXWe3uKt?=
 =?us-ascii?Q?KvHBLmqVklmnZTYQbgSjdRL+fB1wx0BmIuFsND8whvaTbPoK8/Z1MoFDVBAP?=
 =?us-ascii?Q?ZBzGyIE2lVfJmEp6PhgareJiH7qs24quLV38N3rknf3pQZbTTFE7tP+jw6/N?=
 =?us-ascii?Q?XmAK7c5GTw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40245e5b-95e8-4a08-1fae-08da3fadc284
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 06:54:35.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwjDLklhzf/TAmC/WvNpDfnFcbJNlhxIxFYTaevyiP415DNWaz48hPnw8kQ46o4yw4HdnzNKZChOzuW9BlU+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2371
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_unregister() already checks the clk ptr using
!clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
again before calling it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 sound/soc/samsung/i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 70c827162be4..84e21f7fc179 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1247,8 +1247,7 @@ static void i2s_unregister_clocks(struct samsung_i2s_priv *priv)
 	int i;
 
 	for (i = 0; i < priv->clk_data.clk_num; i++) {
-		if (!IS_ERR(priv->clk_table[i]))
-			clk_unregister(priv->clk_table[i]);
+		clk_unregister(priv->clk_table[i]);
 	}
 }
 
-- 
2.17.1

