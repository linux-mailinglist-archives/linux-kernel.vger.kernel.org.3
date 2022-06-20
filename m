Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB69550ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiFTDIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiFTDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:08:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194149FDF;
        Sun, 19 Jun 2022 20:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/KqbsqU16X9m9Q2pPcfAHBs1OPSt9JOlqWbUR0y2pdXyI+MLOMjC8U1QsnZ8vAkDbd6KwwLGbeHvlYgMtD6gO4lw9mxypJpc42MN8kQIFtI61t/6g8Bw4E4TO8SRWqmGkmrq9nXisfA7+JwWpf+BBgzePeD3ZrWGZweDUCqHJNEkEwiAkq3BOPS9P6oDmLmct1XdyIqLUqd8V9Dv53cZWtf45u6eaJFZ+9Xq+kFN/0a9Tqpuq6xIhhh+Iu4Z/GW8OFV9po9o5chBbFMTFw5HQ1K/h3QZCtJWL/RrVQ/p7GBrzwOxZqw01xKWd3xlXLQec7uo7k+5Z5JEBN8Et3DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25mMPcScMgkUJtAJgIbBofSUyiw5mC5wIaV6BCT+eLw=;
 b=VA6Ip4gKIaVX7gaCfzlIXaOZepnDX3LHgUa33JWZKRssv9TcyVRopFGqbPfILiXobXXl613niA3SFUoNlO/Y1F+yCb8HxDqBHtdcx1T5t0T4+9o8R8mSgPYDvy78aQ7Hx3pgFl8DwHdy4olApX9SM1M23bD1G1gxuzQXswLYWlSySmSCyOH+hQnGld30FiefzY4u+R1iTyq0ZgKB0CEt5gc2BAjF/Y//hGhwgPdhm4c3q+W6HTkC0qOzG5oXjEcojI2W2eGxSmCDvp1L5sLAE/1W+xAVgvaymSUuQXVtVwIGWqnhefhmplTTJjw8BjOU5gU3VspSk7+0nog7D1x3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25mMPcScMgkUJtAJgIbBofSUyiw5mC5wIaV6BCT+eLw=;
 b=X/shV83jyC9GTpmFB0hTXSm1v5/3Vgil3sBDMm7215cfxk25eIwRfPgkxK64n1i5i5xQiBj9V06UAYPVLqzGUq0Ygj/fIq1YlLodIlI8QSiwi/oZRiqdtTcJjkkm1Eu4esvPeaxotlg4AnP+vIsknLt5cQxOhy8RiD/x37lNQgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by HE1PR0401MB2602.eurprd04.prod.outlook.com (2603:10a6:3:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Mon, 20 Jun
 2022 03:08:22 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:08:22 +0000
Message-ID: <7bbc3b55928a579413d87becacb26c444e2c3450.camel@nxp.com>
Subject: Re: [PATCH 2/2] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Mon, 20 Jun 2022 11:08:13 +0800
In-Reply-To: <8a1d7575-1334-e5ab-5228-f75ae67a3d13@linaro.org>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
         <20220618092201.3837791-3-victor.liu@nxp.com>
         <8a1d7575-1334-e5ab-5228-f75ae67a3d13@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac65d8c-e7cd-4be4-0449-08da526a2220
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2602:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2602BC675CAEA91815F01D2F98B09@HE1PR0401MB2602.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y0AyPV5YScRxJRVyeldJrd4gX/VguIblD7MdWQWu2+FnEtSWqGMiZcecyswZ7wz++NiD65m8PGNLwV90wwsmtmqNEarDQIreUpY8cngHmARe1GYbk23KDpeoebsCLhylT3GCnB+iC3TMG/UMHlQM3nqmJeY03awof6bC+P9jtcayOj+cGu67jk95i18q0Ky1/4cLMX1asop/wFCgGzaP9kjjTAkNm8W50WItiKdeRUxjP0bsRQd+zvDHixNKQV1UHlerT+/rEJCLrnhG/IIXpLlDJAQzYvHAL8M0qUGhUoaC+TyamwkOL33SBMMAkpbqSCRU5N9OVnD8CCeJlbf8HLb3G48MNRDtPO2Gn3EkEKUoPVH0qaewQbj4NDARITmKp0CpBbTZQ1/zrOPaKJYhzl00HZE/gO8XmXi1p68SKREqncxL0YtxQKILpYFZKGmx7W73Pvo+KTuKNll2yC6KhMXsZDPPA60fzNdwmaz0Z/KrbAMcV6qzEYAfNqL25Raby1F1qCBbXHexAPwZ5k8VFKvxwFhic+scwQSB1WHjjKJkv5p293O/zBl3rn7Xha0Uqt9K1P7/W5rF8jzRWQN0zPYDOrTJtaI2K5SGkD2A6LhMpqDDvxr8VTTkCO8l/eb58wBKFnSPKUr/tvjgipiLbg8Dh0rxS9FmrIoqdIF3jGeeJjQpssCeA6KweFKTwC1hBEP5P7dyCKZlczUnO8mBhYgre4WGxgoJzVMnR4TBiZsUr/EycV5JjVDSLq6bZg9PWz240ZUPw3gZROXeMmYgM1mPcy1qeLbkluuuARvEiNouOX7RH3rbjR1Me92cS6s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(4326008)(316002)(66946007)(36756003)(26005)(2616005)(7416002)(45080400002)(5660300002)(186003)(41300700001)(8676002)(83380400001)(6512007)(86362001)(52116002)(53546011)(478600001)(8936002)(38350700002)(6486002)(966005)(66476007)(2906002)(66556008)(38100700002)(6666004)(6506007)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlvN2JqR3huYmNtYnhzcTlkY0U2N1R6dkgwMEEwaE9CMDZNenFIRy96MkFH?=
 =?utf-8?B?a1pjR2E3cG5BenBmZ2tRQjdWd2RnaFFDUTVvSTlPUktwSmFlWVJZakx1VlVP?=
 =?utf-8?B?K0x0Y3IraVlQbEZBVUk1MGtwOWZ6N3NaenNyN0k2THdiV01rVUg2TStFQzNQ?=
 =?utf-8?B?dStUN1U5OWFnWUpYczd6VXZPRmJMNm42TVFDdjBBc2dOTDRKYzBPemg4VytW?=
 =?utf-8?B?cWROeHBRdkg0VjBsenNZYUVJV294dEYzMzdxQWp1bXJwaDNla1ZNSFZ2UStC?=
 =?utf-8?B?ckkwb0JsY21UNm0rMG04c2dPcTMzSE5RQ21mVGhRdVp0SUZJZk1waUZOekUw?=
 =?utf-8?B?RDhYZ0tiY05rZlpTdUUzb2FwNWVNZmM2ZEJvUnZ3LytGNGFmUXFxYmRSalov?=
 =?utf-8?B?MUVOQWFlNzFBMlBsTlI4dkVnMXp1U2hQejA1MWJ4Zk1Objd6VFRZcU9KZTdy?=
 =?utf-8?B?SGgyZEY0aHg3SXBEdHhyUDRrenFIK2hvV0ZWYlhGbkt1V2dndEp1MjlDbm9q?=
 =?utf-8?B?aXpsUGFRS1JFQy9MK2hkZ2tOMU01MVZheURMUzRqbkhmL3hBTzFxdUNUWWc0?=
 =?utf-8?B?MVBzdUpiSFJiMnFHMWFGUzc0d0FaYzREVDN0RmtUakZWYVBTQ01UR1ZhTVhm?=
 =?utf-8?B?b3crNG9PcEliejVCUGkzdlYvZnRjVDFxZEpMME5TTnNlMUJsTVdOWmhMZFNx?=
 =?utf-8?B?bExNL2tycjBSVWt6MDVyNHZma1RIN3hmT0Q5UW1tQkdDTFFyYUh4NEdkQmxx?=
 =?utf-8?B?ZDN5NHYwd0ZScEJSSVd0QUhFZ25jNllQV0l2cFJIUGFyOHJNZzlvOHZoNHd6?=
 =?utf-8?B?L3U1N3duRnpFNVhmMHQxdmd2dmIrYjZtUisrcWNybm1tOW9jNVFnRkNZMkFr?=
 =?utf-8?B?UnZRZ3A3VHRFaG96cGEwQzlDV25Ia2cyQVNjY1A5NGJTemt5ZVFqL2s2cEMx?=
 =?utf-8?B?MVVRY3c5L0pFaEdaNFkvcHdRVVRXRFREL0FCKzFOYmxjWVlKQVZkUDBpT00v?=
 =?utf-8?B?YmZjWVNINWZxa2FUMndETEJKdjN4OHVkOHY2dFpYMDROTEY1L1ZaQk5yUEJL?=
 =?utf-8?B?V0x3V2RqRlQ3RkRvdUhZOG9DY2phcUlmeUdRdENVSmZxYzVvTUNza01XRGhI?=
 =?utf-8?B?YlR4Qkh0MGxZWFhIRHpiemJPQ2FZUHpaR2p2bFZUUU5MbEJ2M0RsWFcvUHIv?=
 =?utf-8?B?Y0xOVjIxd2JxWHZ5T2JjT3ZrWkgyUkRTVXgrZ25oU0xPWkpSOWFIQ2dQZllw?=
 =?utf-8?B?eVVzTEJwSVF1TEVjbU02VTZ3dy9MSlJXNmtJeFBON3VrejBOMkRhMXFCelBL?=
 =?utf-8?B?UkQwdnhvYzRIYVEvc3A0NkdYRVBSSGxGR1ZROVh4cXhueU5tcjZLNDZoSFNT?=
 =?utf-8?B?Q3JjSDV5a2cwMzBYL3JyOXh1ZGQ5WWY2TG1WVEd5SjJTT2JDaTZtdG9PQWhQ?=
 =?utf-8?B?bVl1WlVZbHBEZ3VXMHRObkI3bndsblprcTdRUFNoR3hWWjA4VHRvY3RibG81?=
 =?utf-8?B?UG81WlI1YnR4dVhrMHJNVk1qeUxISm1rZWh1b0svb0RhbUtSUlFpaFF5TDIr?=
 =?utf-8?B?VGdCTHM5N1hvcGRVU0tRUnJBVXRRV0FBTTlNcmNmWGdwOWJwRDdtbktiY0V1?=
 =?utf-8?B?cnhWUnp6SVJrRjdVUnBCUk40eVQrQzNKQ2MvMmx5TUVudk9rbU1seU4weWZF?=
 =?utf-8?B?bUdybGxHN29OR2N6bngzWm5ZZFMwaWhWVzVyRDBPQ2ZyRmIzSnFTcVFzZDk4?=
 =?utf-8?B?WGVLNDl0bk5UWmdXbHNHak5LUkh6ZmZxWnlPZmcxbnFqelVOdGJHZ25WcFV2?=
 =?utf-8?B?dDNIa2NxRXNlaXJ3QUoxV2lOZUFVMDFMTS9hTXZrQTRPWFRYRWQxajl2YjFI?=
 =?utf-8?B?VDZuNWJqNzh2YVErQkx3cU1yM2lKVFVybGVGYkVMZ0RQMEZKZHZFRlp1Umlo?=
 =?utf-8?B?VlRXVGxNT0Z6djZrZ0wvcFVFcWtQQXczVHFJSGZSRjArNHJ2U29KbFpkSEpE?=
 =?utf-8?B?Si96UjFsaWdMY1UvUjJETzg3czNYcEVtKzNKK3FZMXpIOTFadzN3MjBzalZ4?=
 =?utf-8?B?NWNYTGhNelk1bVFnZWg5SE9aWjF6eGlWT1ZsdDlaMW1kSGY2cWFnZm1hYmlQ?=
 =?utf-8?B?U2xyM1pKWmtWb2hMc3VIa1VlSm5HdUtvS01uTXpMdHpPcVNZWlJvaEFGcEU1?=
 =?utf-8?B?bWJURktkTUVybXFLdS84NWNvZ2V0aEJTNnNBNFNlMWFNRDhzb09JUGtmWFlI?=
 =?utf-8?B?Q1BzTUdqQ1VQeDlseGdLUUxZMHRFWnNFY3RmTERla1NkeFBHa1N4RERaQUZn?=
 =?utf-8?B?NWVIdHpHc1h2S3liWVRWOG5aZGIxNU9uZ1h0QlJjZWIyVEhxS05nQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac65d8c-e7cd-4be4-0449-08da526a2220
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:08:21.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhnI1hX6nBP1fNu7mGL1mDDuAQbR11/YYZD1upzftEo0HIfQJ9AVgKbqDbZndKR25qJfCEQXi+7bP02QgdF8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-19 at 14:15 +0200, Krzysztof Kozlowski wrote:
> On 18/06/2022 11:22, Liu Ying wrote:
> > This patch adds Freescale i.MX8qm LVDS PHY support.
> 
> 
> Don't use "This patch".

Fair enough. Won't use it.

> 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17.1%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L95&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C82050bf711fb4a8eb28108da51ed5912%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637912377082315453%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nloK3581LSb7%2BUF%2FTMR4b5J4GYRw4SKKRfK%2FRfP3UrM%3D&amp;reserved=0
> 
> > The PHY IP is from Mixel, Inc.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> 
> 
> 
> > +static int mixel_lvds_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy_provider *phy_provider;
> > +	struct mixel_lvds_phy_priv *priv;
> > +	struct mixel_lvds_phy *lvds_phy;
> > +	struct phy *phy;
> > +	int i;
> > +	int ret;
> > +
> > +	if (!dev->of_node)
> > +		return -ENODEV;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> > +	if (IS_ERR(priv->regmap)) {
> > +		ret = PTR_ERR(priv->regmap);
> > +		dev_err_probe(dev, ret, "failed to get regmap\n");
> > +		return ret;
> 
> All such calls are one-liners.

Will do.

> 
> > +	}
> > +
> > +	priv->phy_ref_clk = devm_clk_get(dev, "phy_ref");
> > +	if (IS_ERR(priv->phy_ref_clk)) {
> > +		ret = PTR_ERR(priv->phy_ref_clk);
> > +		dev_err_probe(dev, ret, "failed to get PHY reference
> > clock\n");
> > +		return ret;
> 
> Again, one line instead of three.

Will do.

> 
> > +	}
> > +
> > +	mutex_init(&priv->lock);
> > +
> > +	dev_set_drvdata(dev, priv);
> > +
> > +	pm_runtime_enable(dev);
> > +
> > +	ret = mixel_lvds_phy_reset(dev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to do POR reset: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < PHY_NUM; i++) {
> > +		lvds_phy = devm_kzalloc(dev, sizeof(*lvds_phy),
> > GFP_KERNEL);
> > +		if (!lvds_phy) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		phy = devm_phy_create(dev, NULL, &mixel_lvds_phy_ops);
> > +		if (IS_ERR(phy)) {
> > +			ret = PTR_ERR(phy);
> > +			dev_err(dev, "failed to create PHY for
> > channel%d: %d\n",
> > +				i, ret);
> > +			goto err;
> > +		}
> > +
> > +		lvds_phy->phy = phy;
> > +		lvds_phy->id = i;
> > +		priv->phys[i] = lvds_phy;
> > +
> > +		phy_set_drvdata(phy, lvds_phy);
> > +	}
> > +
> > +	phy_provider = devm_of_phy_provider_register(dev,
> > mixel_lvds_phy_xlate);
> > +	if (IS_ERR(phy_provider)) {
> > +		ret = PTR_ERR(phy_provider);
> > +		dev_err(dev, "failed to register PHY provider: %d\n",
> > ret);
> > +		goto err;
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	pm_runtime_disable(dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mixel_lvds_phy_remove(struct platform_device *pdev)
> > +{
> > +	pm_runtime_disable(&pdev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused mixel_lvds_phy_runtime_suspend(struct
> > device *dev)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> > +
> > +	/* power down */
> > +	mutex_lock(&priv->lock);
> > +	regmap_write(priv->regmap, PHY_CTRL + REG_SET, PD);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	dev_dbg(dev, "runtime suspended\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused mixel_lvds_phy_runtime_resume(struct
> > device *dev)
> > +{
> > +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> > +
> > +	/* power up + control initialization */
> > +	mutex_lock(&priv->lock);
> > +	regmap_update_bits(priv->regmap, PHY_CTRL,
> > +			   CTRL_INIT_MASK | PD, CTRL_INIT_VAL);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	dev_dbg(dev, "runtime resumed\n");
> 
> No such debug messages.

Will remove the debug messages.

Thanks,
Liu Ying

> 
> 
> Best regards,
> Krzysztof

