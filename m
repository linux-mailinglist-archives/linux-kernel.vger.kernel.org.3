Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC67C4B8127
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiBPHOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:14:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiBPHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:14:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257F3A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:14:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW4kvM0nr7OwUd8wWrqd9TKQydSr1NODfM05OyPwJmhshVs2goSytQI6x9EIm4gkVIOXUqocwgm0pJcIMNEXcGLA/HnJitwEwqwRi5DTUdgvWZPD57N6C8hiGnuqlG107ufowBk88dHvQ+W3qJ6NJcZfGI5iRRkRccBl+sGm6v6mSgBpV/2oj6Z/L5o6aEU4qwt0RAiNGBMnikyH/OspyvBWrW6E7L3ntYH1zQKOaYb3HdPNLaNIDu1Zu3WDG6opAl94OuiBq3KUSc7W1uGXaQG4dhAq7tugfJwdy4Z4Zgh8NYRsfnFB96mpuFVKnIuFDt+XzM4+nrc0/awpiqox9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kExFFvUXbo3RwmK5ystYGVcQdKBZqI3DM0gcp19G7fs=;
 b=lNpUtXEhVo8fLE+BAWK491z11Ge0ANyU/ZrZCJjl8J/efXq0PwwqQOstHe3k13/X9xBmibi1TSLNnOtVKp/eo+4YXNZtWA/amBWZSvobW32kmLUCk5Ac+yNZ+p9adAlRd20xXTrRSVHV9owfl6FL8yQgATZIUA89NEcynt+jRydNkO7Ghe9HuJfamvmdCl+UkpIFJsdWJqWkvYMbUneH/SZp+YOzkLi7ZKXH6IxBkJpRbvPh+FSPrFD6GfFNYlHw8U8EbseryLVuLpHDi8hv9UpR4TbLMSSW4VY6kXivJJhTl8lhcPj0F2440Hbu42pZQuIpRqZ7q71zRVoZU/RW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kExFFvUXbo3RwmK5ystYGVcQdKBZqI3DM0gcp19G7fs=;
 b=pFGuuwd0KCYTZqqdkFACXHtEBDUwYH5s9q9dSXuRmsBrTJYbkfWi+d165QE0YJCF7XnuYuDIvBoaAFoswWBvaWUqWjjPvpZLVZ6eF4jY05pl0AoCtsoDRhlZ1INndc59iQI6yeOK+HTXvOJqj385q5dAtxUH9TVuA47BMZrzRwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB6248.eurprd04.prod.outlook.com (2603:10a6:20b:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 16 Feb
 2022 07:14:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::ddca:beb1:95b0:1ae1]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::ddca:beb1:95b0:1ae1%4]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 07:14:00 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-imx@nxp.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH] phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})
Date:   Wed, 16 Feb 2022 15:12:57 +0800
Message-Id: <20220216071257.1647703-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce8cf30-711e-45be-33cf-08d9f11be7cf
X-MS-TrafficTypeDiagnostic: AM6PR04MB6248:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB62480A2D5E83D745F43E3C9C98359@AM6PR04MB6248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLTua+A3DN4MT4f0J7xtAvOcyW84zf0aU2VBUVFBNuNgJLgCwRViDbHFjGEbrMXPZaSzY54M4KhYI6EJbhefe+77DArSN3R2OuEog2to3S78hJjJDvbiDrglt7XphYHaCJDDmbT5oGcNP6sUBCSetl6pnAQ9K6PDYXKOF6fWgX9FPWBZfKopB+YdI9uZx9eaI3T3B7d2dnzqIGOsJY1LxkzR4WIyHI2U/GyBa3hcmYAKQO93KGhGgsQSMVA39KYcAiFCt8fsGSXR+uBBw62MpW8qQJ7WSvw3D9z8tfSDfhFFi18OfIyNcyA10UlQX+2Hl1DoJ9z0P9wc/jnhqUWxyZi/58rdYRzEWVWdVzaAqY2dBI4UC19VwE/I01UcMsaJncXTctCGiw8HrrWMmM/EqqmjOuIpzwKfAtSauKPTQcyvKFM3nzpZqjOZ8EMJ9HIvYzKNBfeYxfS1+kKgjFx5a/rxm7I1kljn3uewalKg/pXahxT27lB3fZ4czXM3jsTX7CwSGfvYXwiEK2pRh/fBb0D0d+bYUNgL/ssDE3VwuJLu495S6WgJV7iY/Ow34Fxkit0qRXb/ebQimmlyu6T8nF9CcGUxqbNjvlYUNVZKlxRVB48fl4rAcZM+OQlJXL90cEg6VlSIrbYZJ/1dqlcSzIIGv3Ygiw1rwqbTNcskw7cRVRXMSpPuJDnTciddZ0e3EnJIVkTOeUKaKWHsRFULUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(186003)(6486002)(2616005)(316002)(1076003)(54906003)(38100700002)(7416002)(5660300002)(52116002)(26005)(6666004)(38350700002)(6506007)(8936002)(86362001)(66556008)(66946007)(4326008)(8676002)(6512007)(66476007)(2906002)(83380400001)(66574015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdXZU5kb2ZrVUoxZTRoL3JIcDl6WjdDZEl4endpd2pmb2tKS2hXbkxQaDQv?=
 =?utf-8?B?cXViZkFHVTBqMWc3Uk83RVh5VEtwRVpnVVNNWkdYMG5FUDZTQnJZMXlMQnMv?=
 =?utf-8?B?M3J0dlI3TXZjdUU3OU8xY3BiK2U0cGVaNDQwbzNCZjJRYzUvcFpkb1A4R1Bl?=
 =?utf-8?B?Vlcrck5TU2tNQUpyQlBzMHlnM2w4NmxPaXdhY20vOUV0QS9VRUN5MFJ5T2dH?=
 =?utf-8?B?ekpobmZaNkg5RG5mdlp1ZkJlU0NlR21YcnJKclUyWlU4QmpSOWJXQ2ZPNkNF?=
 =?utf-8?B?a2hZbVV3WlZJRHBYY1VKQVhCRm5qUjI1RkM2bXFxREsvNUZXTndXVnFaWlRJ?=
 =?utf-8?B?Z1BwbUZlM21sVE1QRmVyQjltQ2tvRGk4cGMzUCtKY3hvb0lUUlVNazhXTXdm?=
 =?utf-8?B?akF0RVZ2dnhMMkhhUVpWZ3pkaHFLNFZaUFNuY2kzQk91MFQvNlpwSFVYV0Uz?=
 =?utf-8?B?SFdFSVRTNXNiK1lxRzB5V1ZqNElCbFVRRWs5RmVsdVFYbElRMWR2eWFGSkVB?=
 =?utf-8?B?ZklZTmV1NFpyMHNXQ1F5T2QrcHZHS2I2MlhoTzJsT3MxemVRbEZxNWhqVTlF?=
 =?utf-8?B?OTFOUmJpSUh0OU5pZXZENHZtTmhUUXd1a2xOWnhpbXFQUzlzTytpVDB5T2hS?=
 =?utf-8?B?V0F0RzZXK2kwTTkzMU9RNnM0dXVVeHgzYlFNZjFBMXcxNkllN0F1QjNBcHor?=
 =?utf-8?B?cmFhclRobGhFamV3b1hydC84QlRCN2ZJNnY4ZWUzcFhlUWJPSHc2cFRiNEJC?=
 =?utf-8?B?YkNLMk5jalZYeGNCQWpKUDZ4U2IveFBtUDdMTnBNSDl2RXZTdlgwNnlqb1Az?=
 =?utf-8?B?RnAvMFhEUGRpT2tGMUZ3RjllR1N1Q1NaN3VidWhqQkI1Y201ZnV5YzNrVGw3?=
 =?utf-8?B?dm5MdzhVREVEamlia3BVNjJnMTlPUEI2UlhTZmZOUjRNYytxYUJBa3g3d1hO?=
 =?utf-8?B?MjluOEc5bm9yc1NuMkZCbGcwSXphUWVEQ2hreWZZZUplWkRaWUdLd25KNHhu?=
 =?utf-8?B?UFFGVTlVbGxtNTJFbDNnVDU3ck9XVVB4eGM4d2ppTkt2QkhwcVFXQ0lYYnVT?=
 =?utf-8?B?bExJQ1pNNGxiUmszOSt0S2RuWHFnR0JVVlZyaGt4bE1DRkh4MTllcFhQejZa?=
 =?utf-8?B?MkRRUTNyMC9rRkF6d3NDdFh6UGNyWGdUaHpNcmZMMkQ5cWIxQW9iLzJaMWFr?=
 =?utf-8?B?YUwzaGQ1K2IxQ0ltVy9tSDFUWWswQTRkN0EzT3kxWUxZelpBNnMxcWV1UVF3?=
 =?utf-8?B?ekZHMXRJUDZXQS8vU2tVWkN3NVV0cUU0aTZzcU56NUgyaStpLzVPNWlUUjJW?=
 =?utf-8?B?RDR2d1NmbTc0Sy9SdWtldXQ2cFFNMElOWW0reFBpWnI3NkFLb09xa2kyRnNX?=
 =?utf-8?B?VVZRMGRvR1U1b01lSEE2VWI1SzZwOVNsK2xDVGxxa01XTkxjZ2U4NEtOS1ZY?=
 =?utf-8?B?K0ZqNTVWM0xkclZ6VURnQm9SVmFyOExvbkM4NlV6U29hZUFRdFBHbHMzMVYr?=
 =?utf-8?B?c1NpZ1BsOGdnOUxVU2JqdXRHTjNFMFRSZmQvRFd3WVdUVUxTT0RMUkdic2R1?=
 =?utf-8?B?WGlBVjJvNE5jVTVzYnBCSlpBclJIVFBZb1dJMlQwSkNSQmlnaXdYQVl2WVhP?=
 =?utf-8?B?dHlONTZ2SHJoSWdwUnluUUtzeVkrbENqTEhHSXNHekc2QTMvNm1McUZOQnFz?=
 =?utf-8?B?NE8yYUo4Rko3WXV5Q0k1blphbFJhVDdFYktjd3hzRFJVL2NjTW9vQWp0UjBx?=
 =?utf-8?B?YzJVNWk2dkdGS1BQTEMraW1FYzVHVlozWTVHc1ZTWjJRMXl3VHp3S2lPKzF6?=
 =?utf-8?B?ZDZUSHg2K0pZZWN0R1doYkk2MVhoUk1mbmloQWZyZEtUNlBCSTROR3g3K3VI?=
 =?utf-8?B?WGtPQUNnSU5IV3ZQWkNmV1BEcEJMU3hsQkRFUWlLNWdZSU53bUN0eklpOFBZ?=
 =?utf-8?B?TWlwdG5XalM5RjFMWE40aFB1UlVZMmJjS0tpUlBjWThHT0pJbU5Ec2pPaWFw?=
 =?utf-8?B?ZlBaSGd2WFNCQ2pmYlhCY1huMEI3TC83SDFWbVdNNGtOaTZsQlptS3htKzdq?=
 =?utf-8?B?bkswbmp2SHkxNi9meDRkd0EwZWE2b2V3UFFTY25md1p0bGZYbUJRSXB0Vk9P?=
 =?utf-8?B?UzIrZUFlRFNmS2IzaDJ4MXk5RHpDblZ6UW9SNkNDT21DL1Y3OU54N0NJNVRV?=
 =?utf-8?Q?6/AzQpJLSBgUWzLglLaOmW8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce8cf30-711e-45be-33cf-08d9f11be7cf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:14:00.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11KmnTHfASVveuTajPyR93lyBBFhVakh4gY+veTalFdXxhiSi2ktKiWbAVeQSHyahS5NiYbGjwvYmjpYgwV2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment of the function phy_mipi_dphy_get_default_config(),
it uses minimum D-PHY timings based on MIPI D-PHY specification.  They are
derived from the valid ranges specified in Section 6.9, Table 14, Page 41
of the D-PHY specification (v1.2).  The table 14 explicitly mentions that
the minimum T-LPX parameter is 50 nanoseconds and the minimum TA-SURE
parameter is T-LPX nanoseconds.  Likewise, the kernel doc of the 'lpx' and
'ta_sure' members of struct phy_configure_opts_mipi_dphy mentions that
the minimum values are 50000 picoseconds and @lpx picoseconds respectively.
Also, the function phy_mipi_dphy_config_validate() checks if cfg->lpx is
less than 50000 picoseconds and if cfg->ta_sure is less than cfg->lpx,
which hints the same minimum values.

Without this patch, the function phy_mipi_dphy_get_default_config()
wrongly sets cfg->lpx to 60000 picoseconds and cfg->ta_sure to 2 * cfg->lpx.
So, let's correct them to 50000 picoseconds and cfg->lpx respectively.

Note that I've only tested the patch with RM67191 DSI panel on i.MX8mq EVK.
Help is needed to test with other i.MX8mq, Meson and Rockchip platforms,
as I don't have the hardwares.

Fixes: dddc97e82303 ("phy: dphy: Add configuration helpers")
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/phy/phy-core-mipi-dphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index ccb4045685cd..929e86d6558e 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -64,10 +64,10 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 	cfg->hs_trail = max(4 * 8 * ui, 60000 + 4 * 4 * ui);
 
 	cfg->init = 100;
-	cfg->lpx = 60000;
+	cfg->lpx = 50000;
 	cfg->ta_get = 5 * cfg->lpx;
 	cfg->ta_go = 4 * cfg->lpx;
-	cfg->ta_sure = 2 * cfg->lpx;
+	cfg->ta_sure = cfg->lpx;
 	cfg->wakeup = 1000;
 
 	cfg->hs_clk_rate = hs_clk_rate;
-- 
2.25.1

