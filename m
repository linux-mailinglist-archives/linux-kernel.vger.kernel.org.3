Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27658B6C5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiHFQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHFQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:24:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2B11158;
        Sat,  6 Aug 2022 09:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSmPAA9R97NAZRihoLVdLKSJVXQ1fxyTOmDi4JacT1uRO/15oh3wFfrJLvH6Png71ptHePym8xJoNNZNaAgvThcAe5dHgxbbSmEVoaA5mcUlijyEo+/VpSmYadcCSBJyAMjiTkE+7o79+DEFUPOcALxc3+0WY4S3ZwGRElakbo/VzScvMsXlJKibuSWRz7rFRGCyX8BhuBHI660dSb6fnfqqcB0zl/HZdJtQJVI12nfuexLzXxwEfMuQWZeAX7pWJICKEuHSp4DUgkUf1c9l7tdbdw+A43vc+8Xqetp/OOUlRV1Cf2tPuj1tAx9iwDBQpjaNn7DnvpmMhM9qwHDtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evYWeiidGTEP2p6B5d5Cab4Jekw2Vglivmq4a6rybxI=;
 b=OQwIwIJFei2EL27Qtn1nSlWKNhXzT9knynGT7m4KMRCaB71eIKPjngAI4NghYWz2PAnPkeD66vE2QGoamgcc4uU84rVUH2nWEfZoU4MrxgVUMfzeZyNnhDb9bfHcPcL+dJTRlIMeR4fATgtmouZxbZoqzjRPnL0MZEyUYSR/IlsosUKnHmJVIMry2MltkriSFR6Jm0lvoJt4H+2CSzK+F0D+mvbWOd9+B5YOfOZP+OsgyjIwFJWgTHU977O0X0+jeutoEuydjXuehgumxwPGPtzJ9zl9Ta8UAaPg9uu1xZOldUlFd/QFsY5IDe6n564N4xWUrpQMKu5OHN75P5gVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evYWeiidGTEP2p6B5d5Cab4Jekw2Vglivmq4a6rybxI=;
 b=Y/ZeJaI1CraYIfmJQ9h1nOQWkD+i9sO6YU/GSC1lqnFpX0luMB1NtWcvzRsCXVwAkPkO4CNBVcPA1SgovXkuINRSOXCFFGeW1dpuThftoZNnuwlYVEucj6q2dUjqta4Ypgcck9sppur75RUamLgw6I+BZ7yuzHZi2MyJenwC9CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sat, 6 Aug
 2022 16:24:00 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5504.016; Sat, 6 Aug 2022
 16:24:00 +0000
Message-ID: <9f83cba8748b6ecdf37f0543ff596cbb6637ff61.camel@nxp.com>
Subject: Re: [PATCH v3 1/3] drivers: bus: simple-pm-bus: Populate simple MFD
 child devices
From:   Liu Ying <victor.liu@nxp.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Sun, 07 Aug 2022 00:23:49 +0800
In-Reply-To: <CAGETcx_QVaYYHsD9HZmBu404K-oXRCPm4N4GRrYu4pGyw2DHbg@mail.gmail.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-2-victor.liu@nxp.com>
         <CAL_Jsq+B5PMOmZO4hz5DyEsA4V=UkrNn-6b58h8VbcPa2iaQ1g@mail.gmail.com>
         <CAGETcx94De-wofRjtPgNxa+YQoU3+j+we+4K9Evm=vtzhopX8g@mail.gmail.com>
         <dbafe424aa9b4cdb79397476c1c4085ea2f0d242.camel@nxp.com>
         <CAGETcx_QVaYYHsD9HZmBu404K-oXRCPm4N4GRrYu4pGyw2DHbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa0fd4e-568d-4d1d-3266-08da77c811de
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2559:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0lHWj8V51ww09QuQG7Wj7jVOipgxGqa6XeUR4TTTotEhkfWe4G7Xbh0FZTl+AnPMdCnmqS30JTlnubc8ALqmvCDKzgRLvLQJd24OeMbWRH1LpnYTcmCe3jRnNIJSmfJJvNHcI0MTJrnRVdhQfbvtVFiBHsXVA1BJAnFyNnvon45+dBOxrb4flsc5FAJurruGNd06+JeYnSHtPDTEQCMRkHU5ootrhn8yA2xF1jmv3ruXtS85SPLK2PZXkegVRWLzCpY8oUxThh3ImnfQzRIzDTn49DZJytadBG6YxKDvlJApVe4ePYvyH+58Wr9AIzuZpN8lZXLgaDIprtgZ2LXAm0+TyaVxpjgRbKZf19ybaIC29KCJWEJNXH5et1CBGGrTo/cOCdp5PAvRcyb/1hykFdIW8NkQj5m+CHCeB2pD9rVEXP8SQKXD8ur0VillwcC+dj4s90O0f0OKjcgYypPZo6gZ3/mLf98hnd2LAdy0HC1sIXXapQZP8MZO4/NQLseANszlLlXJLvtmB4ZmMOyYXlck8LXeyZSE8NjgNrHTU9PgcNdNAgpvgr22dBcyu6q0hqsbbVa12nFO0Zu4jGcUahtsTk1W8vIQEhM0YYVkNl3SpK8a8J/Qa/+zS4K1qlThlRtIrVarSuW6ckJ7tdwK0CRlbfYEfL7VdtENlljo+9yUiIL+RuAB//+dAvUbQ+lzw6rgRNeVFG8MVRg3aJ29Sb8tJHpi/f2Zq1K3XZklVyOHeDah2FyjmIgn0MHYjBhx9FoapGNaiL6UUnkb/BNKLUeO2JS78PYgZEhHQgC++gSXxUNE9jVJU+IbmGkTSlw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(30864003)(2906002)(54906003)(8936002)(7416002)(2616005)(6916009)(316002)(186003)(5660300002)(8676002)(66476007)(66556008)(66946007)(4326008)(86362001)(36756003)(478600001)(6486002)(41300700001)(6666004)(38350700002)(26005)(6506007)(6512007)(38100700002)(52116002)(53546011)(83380400001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG4vSlRxa1pqdWdQY2NaZjBtQU1TRnhDN3U3T2hxQURrcWhxTktOZEp5V0tx?=
 =?utf-8?B?TXB3WXdyWUVVRWZuR0srL0pEYXlQcytUKzRQMWltNXg3YS8wOWZxcWRYbENI?=
 =?utf-8?B?dm0zb3d3MXBBbVNoM0c3S1BGcDhSZlpXU3NxalVCY1cvNU5STWEzWkN3TmJj?=
 =?utf-8?B?MHZPSkROMXY5Mjh2TVVXbTlJLzZ1Q2JFYXlzbXc4MTZvMWpqZ3lUT1dKajhM?=
 =?utf-8?B?dWM4d3hybzlRczF3d2xqSnAyYWpUa2RzdnMxN0R3dTdrREJyRGg2ZUZQeG5x?=
 =?utf-8?B?ZE9IODVGUlppQ1BNWHo1MWlJYzlpbzZlZGI4NDNwZ25FV3VESkhFbjBpZ3dE?=
 =?utf-8?B?RndsbGpkV0piTi9UeTVmdEllYldTOTFjU2hocWFNNzhudHU5cmVWbkxDdkJm?=
 =?utf-8?B?a1BjbStSQWxtcFpiZTUvWXEweTdDR2Y3NnV0YnZsaEJMVGNpMFB0ck00eDhp?=
 =?utf-8?B?UXliUzFMTFhpblRVVEdFWE9SaXYvT1k0STNwQmZNRWpLYmJyeFBNWmY5R1JN?=
 =?utf-8?B?bXVXTDJXSTdTdmJpTlVoS29KbTB2bzFHK1pMVU0rcmhCU3BWNHlCZU56bmxm?=
 =?utf-8?B?UGE2UStlVXJQelZOc2tub1ZBeWlmVzZRczF4NjcrWnk4TkFYRjNESkxGaDJn?=
 =?utf-8?B?K3NvOXdoL3Npc3lpaEtxdisyVnkreTFsYnlFVnA0b1BQQjV3Vzg2SUdFQW44?=
 =?utf-8?B?WGxLbmcwNE9ESkhTU2pXNnArNUR2Uk5MSWcxNS9hUm5UaUt2MFI1R05nRkRZ?=
 =?utf-8?B?STJBZHh5eWpKRXkxZko2czdjdlpFYjN6dU9FUFB4VWhKSG1tQVRLeUh1czZM?=
 =?utf-8?B?d2NySWNFOS9oR21QZEYyNXpkbVlTOGpLUkVxYnFUNWJPNlRLazVuWU1yZkIx?=
 =?utf-8?B?cS96R0ZNMU5uVERtajNVZjBRZXRHUmd4RTUyTmZidjN3NzF3Rk5VQXNjekpX?=
 =?utf-8?B?aEVxVEVSQ1lXNUYrWVNVMkNnc3hCY2ZSM2VkTzB3TTFCWjVRSW0yRHZJb3F5?=
 =?utf-8?B?U2N1Z3VJVE9WRGtna3M1cXhCaDM1dVZDUnpVUGZUN0tINGFaa1ErREdqM0Fa?=
 =?utf-8?B?WTlFZUFNOWhNcGdsUnQvdTVKbXpnd2k4THg0Y1Z3VndCeDJ4U3Bsd043cldz?=
 =?utf-8?B?bXViUHpiZmV2Uk5tSGF2N20yb203eGJmVXJzeGNXOFMremZxaUVvSnhQcWg5?=
 =?utf-8?B?dSttRW9RWVBXZlk4Z1FPKzVxL1VWdDFZMTNCUnBwWFF4djhZbmN3WVUweEt1?=
 =?utf-8?B?YkpCY1pVeDdDcWY2TEJrOHFpbnlOc3I5eHRIWTF3a0R4OWpvRHdUTE9ZRkFI?=
 =?utf-8?B?MHVyWmVtTTBQREVCdkY0bDZCR01GaExmb2diSHJrT050YThMQUNKU21VQkNW?=
 =?utf-8?B?ZlIzb2xnRTM2eHdZRkJXc3YvSTAwakwvbm8vaE93RTdXOGlnZE1xZ3NabkF0?=
 =?utf-8?B?TlJPMGZFRmpCTURvYmpwRy9rQ0prNVE2VmgxUXJ5OC9HZzFNN3M5SGVxTUZh?=
 =?utf-8?B?TGE2VzQzbnJTUDRCR0FUay90U1c2VkM5UThBaytKeFU0TUljVEtiN29OcGt3?=
 =?utf-8?B?bUo5dUg4dGkwU3lQRnNOdWp4L09CRmRPSkc5U3hlamQ3cGE1N1V3K052Zzli?=
 =?utf-8?B?MVp4MlJneTBibDlKemRPaXNZTkNZUmtKd3VOdmJBNTBBa3hoYmVTWkovaUp3?=
 =?utf-8?B?UEJSVC9QMUhwclB5bnlaWkVJZ0wxbjd5NkFHb0FDRlVjTldyc1lPS0VES0NO?=
 =?utf-8?B?b0RVNm9xVnB0SDVmMHh3c0c4TXBaSEhTNEZYam0ycXNXdjhCcGJ5NjBrU3hY?=
 =?utf-8?B?eFFCeUNCaHlLbGZrMHVDVThIa3BSZzU3VnNIT1YweFVFYWR1UzBjS1YwOEJi?=
 =?utf-8?B?bXF4dzZiSGk5ckpJNlN3VVRhOVJ6MG9kNmtCcEN3aGVsZ0lDYnJLRG96VEh3?=
 =?utf-8?B?SGV6d2dNbHFUOC9oVEFpU3BBNURuYUYwS25aS01tbkdBY0FvQ0dJNjNaSkho?=
 =?utf-8?B?bXZFVDFGMkNWeGtObnJsV3pTamtYSGt2QnZSaUsyUEZ6Q21Nb1VreCt4RlMx?=
 =?utf-8?B?aUZyYW9vQUxXUTdKOGZRb09NR3IyZ2lpSytYWVF2dHNPN0hGRXp0UG9kNjl0?=
 =?utf-8?Q?S9lsQMDPWnRE9pQOLOhHFMGZp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa0fd4e-568d-4d1d-3266-08da77c811de
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 16:24:00.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDpOJC/hovmvbjuvmrX4Vqqz4UKQAs+noMD6e1HIqrtLsBlLGCFf/g40Oj07PnJO5h1BhIgIKW7TaQVfI4vYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 10:55 -0700, Saravana Kannan wrote:
> On Fri, Aug 5, 2022 at 3:07 AM Liu Ying <victor.liu@nxp.com> wrote:
> > 
> > On Thu, 2022-08-04 at 11:26 -0700, Saravana Kannan wrote:
> > > On Thu, Aug 4, 2022 at 5:18 AM Rob Herring <robh+dt@kernel.org>
> > > wrote:
> > > > 
> > > > On Thu, Aug 4, 2022 at 12:10 AM Liu Ying <victor.liu@nxp.com>
> > > > wrote:
> > > > > 
> > > > > There could be simple MFD device(s) connected to a simple PM
> > > > > bus
> > > > > as child
> > > > > node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a
> > > > > child
> > > > > match
> > > > > table as an argument to of_platform_populate() function call
> > > > > to
> > > > > specify
> > > > > the simple MFD devices so that they can be populated.
> > > > 
> > > > There could be a simple-bus under it as well. You should just
> > > > use
> > > > of_platform_default_populate() instead.
> > > 
> > > I'm confused why we even need this patch. Wouldn't this driver
> > > automatically probe simple-mfd buses and populate its child
> > > devices?
> > > We already have it in simple_pm_bus_of_match.
> > 
> > First of all, this driver doesn't populate simple-mfd bus's child
> > devices because "ONLY_BUS" is set in simple_pm_bus_of_match[] for
> > simple-mfd.
> > 
> > The device tree I'm working with is something like this:
> > 
> > bus@560000000 {
> >         compatible = "fsl,aips-bus", "simple-bus";
> >         ...
> > 
> >         bus@562000000 {
> >                 compatible = "fsl,imx8qm-display-pixel-link-msi-
> > bus", "simple-
> > pm-bus";
> >                 ...
> > 
> >                 syscon@56241000 {
> >                         compatible = "fsl,imx8qm-lvds-csr",
> > "syscon", "simple-mfd";
> >                         ...
> > 
> >                         syscon_child {};
> >                 };
> > 
> >                 /* more regular mmap devices */
> >         };
> > };
> > 
> > IIUC, default buses listed in of_default_bus_match_table[],
> > including
> > simple-bus and simple-mfd, are populated by
> > of_platform_default_populate() in a recursive fashion, when
> > of_platform_default_populate_init() is called.  However, simple-pm-
> > bus
> > is not listed in that table.  So, bus@562000000 (simple-pm-bus) is
> > the
> > last one to be populated successfully and syscon@56241000 (simple-
> > mfd)
> > is not populated (recursion stops).
> 
> Ok, it's working as intended so far.
> 
> > Then, this patch adds a match table to populate syscon@56241000
> > (simple
> > -mfd) _and_ it's child nodes when bus@562000000 (simple-pm-bus) is
> > probed.  of_platform_populate() will populate syscon@56241000
> > (simple-
> > mfd) and it's child devices (sycon_child) together. Hence,
> > sycon_child
> > devices will be probed ok.
> 
> I think of_platform_default_populate() is the right solution here
> instead of spinning up a new table. Because a tree of simple-bus
> children of simple-pm-bus would have the same problem you are facing
> with simple-mfd's children not being populated.

It seems that of_platform_default_populate() is _not_ the right
solution, because simple-bus/simple-mfd devices probed by this driver,
as child nodes of simple-pm-bus, are not power managed buses, which
means simple-bus/simple-mfd's child devices PM operations cannot be
propagated to simple-pm-bus.  I'm assuming that simple-bus/simple-mfd
devices probed by this driver should not be child nodes of simple-pm-
bus at all.

> 
> > The problem is that syscon@56241000 (simple-mfd) fails to be probed
> > with return code -ENODEV as "ONLY_BUS" is set and "simple-mfd" is
> > the
> > 3rd compatible string.
> 
> Ah, thanks for the example of your DT. My bad, I had forgotten the
> "simple-mfd" is one of the default populate busses and can be a 2nd
> or
> later entry in the compatible string and still have its children
> populated by default by OF platform code.
> 
> > Even if it's probed ok, syscon@56241000 (simple-
> > mfd) is not power managed, which means syscon_child devices' PM
> > operations won't be propagated to bus@562000000 (simple-pm-bus)
> > (?).
> > Anyway, somehow, syscon_child devices do work, based on my test.
> 
> Aren't you seeing this propagation issue even with your current
> patches?

I realized this propagation issue with this patch of mine when I looked
at Rob's comment - to use of_platform_default_populate() to cover
simple-bus. This propagation issue is the reason why I'm assuming
simple-bus/simple-mfd devices probed by this driver should not be child
nodes of simple-pm-bus at all.

> 
> > With regard to PM, simple-bus is the same if it sits at simple-
> > mfd's
> > place.  So, maybe, simple-mfd and simple-bus should be power
> > managed as
> > well?  Or, simple-pm-bus should have no simple-mfd and simple-bus
> > child
> > nodes at all?
> 
> The problem is that there are cases of devices with real drivers that
> also list simple-bus as their secondary compatible string. So we
> can't
> really remove any of the existing ONLY_BUS as that could cause
> simple-pm-bus driver to probe them instead of the real driver.

I don't attempt to remove any of the existing ONLY_BUS.

> 
> In your case, why even list this as "fsl,imx8qm-lvds-csr"? Can't you
> just change your compatible string from:
> "fsl,imx8qm-lvds-csr", "syscon", "simple-mfd";
> To:
> "simple-pm-bus", "syscon", "simple-mfd";

fsl,imx8qxp-csr.yaml[1](already upstreamed) mentions "fsl,imx8qm-lvds-
csr" and "fsl,imx8qxp-mipi-lvds-csr" compatible string entries. It
follows the SoC name(e.g., imx8qm) + subsytem name(e.g., lvds) + IP
name(csr) fashion, which exactly tells what the IP is. Although no real
device tree is using the IP yet, I tend not to change the compatible
string (DT maintainers usually don't like the change I'm assuming).

[1] Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml

> 
> You are treating it exactly as a simple-pm-bus. So I don't see what
> this extra "fsl,imx8qm-lvds-csr" distinction brings. Or make it if 
> you
> really want the "fsl,imx8qm-lvds-csr" in there:
> "fsl,imx8qm-lvds-csr", "simple-pm-bus", "syscon", "simple-mfd";

If you take a look at the examples in fsl,imx8qxp-csr.yaml[1], you'll
find that a "ipg" clock is syscon@56221000's property. Drivers[2][3]
for child nodes pxl2dpi/ldb call syscon_node_to_regmap() to get regmaps
from the syscon. The problem is that syscon_node_to_regmap() attaches
the "ipg" clock to the regmaps by calling device_node_get_regmap() with
"check_clk = true". Then, the clock will be managed by both the regmap
driver and the simple-pm-bus driver, thus unreasonable clock enable
count. I know drivers[2][3] may call device_node_to_regmap() instead
with "check_clk = false", but the drivers will be changed and they
don't really know which funtion should be called.

[2] drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
[3] drivers/gpu/drm/bridge/imx/imx-ldb-helper.c


And, like I mentioned, "fsl,imx8qm-lvds-csr" tells the exact IP ...

> 
> If you are actually going to write a driver for "fsl,imx8qm-lvds-csr"
> then you need to have that driver bind to this device of yours and do
> PM management and populate the child devices if they aren't already.

... and can be used by a dedicated driver - yes, I'm going to write a
driver for "fsl,imx8qm-lvds-csr". The driver probe function just
essentially calls pm_runtime_enable() and devm_of_platform_populate(),
that's it. Leave the "ipg" clock managed by the regmap driver.

Make sense?

> 
> Long story short, with what I understand so far, I think what you
> need
> to do are:
> 1. Patch to manage clock.

I'll do this, just like patch 2 does.

> 2. Patch to use of_platform_default_populate()

Nope for this one.
Based on my understanding, I won't use of_platform_default_populate()
in this driver to populate child nodes of simple-bus/simple-mfd devices
.

> 3. Fix up the compatible string to list simple-pm-bus in it.

Nope, I'm afraid I'm not willing to change the compatible string.

So, it looks like what I need to do are:
1. Drop this patch (patch 1).
2. Patch to manage clocks (patch 2).
3. Add a dedicated driver for "fsl,imx8qm-lvds-csr"/"fsl,imx8qxp-mipi-
lvds-csr".

Regards,
Liu Ying

> 
> > 
> > > 
> > > I'm wondering if you are trying to workaround the behavior of
> > > having
> > > "ONLY_BUS" set in simple_pm_bus_of_match for "simple-mfd". Have
> > > you
> > > tried deleting that field and see if it does what you want?
> > 
> > Without this patch, deleting "ONLY_BUS" works for me, as
> > syscon_child
> > devices are populated when syscon@56241000 (simple-mfd) is probed.
> > Deleting "ONLY_BUS" may make simple-mfd a power managed device. Is
> > it a
> > right thing to do?
> 
> Ignore my point about deleting ONLY_BUS. That's wrong because then
> the
> simple-pm-bus driver can end up probing any device that lists
> simple-mfd even if there's another driver that could (like
> "fsl,imx8qm-lvds-csr") and we don't want that.
> 
> -Saravana
> 
> 
> 
> > 
> > Regards,
> > Liu Ying
> > 
> > > 
> > > And we wouldn't need to use of_platform_default_populate()
> > > because
> > > this driver would take care of doing that recursively. Especially
> > > when
> > > you need the clocks and power domain to be able to access the
> > > child
> > > devices, you want the driver to probe and do that at each level
> > > before
> > > automatically recursively adding all the grand-children devices.
> > > 
> > > -Saravana
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > ---
> > > > > v1->v3:
> > > > > * No change.
> > > > > 
> > > > >  drivers/bus/simple-pm-bus.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/bus/simple-pm-bus.c
> > > > > b/drivers/bus/simple-pm-
> > > > > bus.c
> > > > > index 6b8d6257ed8a..ff5f8ca5c024 100644
> > > > > --- a/drivers/bus/simple-pm-bus.c
> > > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > > @@ -13,6 +13,11 @@
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/pm_runtime.h>
> > > > > 
> > > > > +static const struct of_device_id
> > > > > simple_pm_bus_child_matches[] =
> > > > > {
> > > > > +       { .compatible = "simple-mfd", },
> > > > > +       {}
> > > > > +};
> > > > > +
> > > > >  static int simple_pm_bus_probe(struct platform_device *pdev)
> > > > >  {
> > > > >         const struct device *dev = &pdev->dev;
> > > > > @@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct
> > > > > platform_device *pdev)
> > > > >         pm_runtime_enable(&pdev->dev);
> > > > > 
> > > > >         if (np)
> > > > > -               of_platform_populate(np, NULL, lookup, &pdev-
> > > > > > dev);
> > > > > 
> > > > > +               of_platform_populate(np,
> > > > > simple_pm_bus_child_matches, lookup, &pdev->dev);
> > > > > 
> > > > >         return 0;
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > > 

