Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF77B5B2BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIICGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIICGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:06:44 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50065.outbound.protection.outlook.com [40.107.5.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE069E8AA;
        Thu,  8 Sep 2022 19:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCL9tsyyobb1cKLDnPR4ENsrAAy7ocJyPhImDwgZYZ1RDzHylWDczn7OfCxr63HSAFNc508J5t3P7VBu47CA9rI45XPqZD486YIUXmCx0xtI5+iLk03sqocak06F0r+oJv1a/e1NY6fX9vwBbA+VQ+NPQ5sj9+sMxzQ0uED9mx/YGkkaxECv25v071WUUxqd0bWtI0ifj7afmszm36Kn1s9JPuHqHuhzt8Dl4aydSwf3e1Zq+r/oYGInTUHZF8LIrc1RRyrwP8KIIPtanuSFc/u4auOH+iIEb9KkOvS0Qum1GlZecsUDkJTg1KcwuHpGN3V9X/JZQr2X8RJCQCKDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJeWNyPl0wNjiPX/7N1zu4sFUaupyO1kZZXuDSNelJc=;
 b=Fi1XRpn8kpO6wKFAMOf2D5n2+gf3nIptBQF8dB/AVYfFEK77bwrldQ2PlQkBoMncynYHa9elDs3PKoqp2yze8MJ9R4FZKH2bIOK65o7GoI3qs8FK2gfjoWGfPKcLKO9yrsYdLiZpDR5asGznej9APMFrS9f6nm5k2Vst+ZECWqGya7jff7V1YsvPMI+SgcXAOoUDESlzO9kGPOIhuVx/TT6DjA21xUTw/zFo5nc5AZ/CrtH4zwBWlRPr365E1B/d57Pqc7EWDFKF2fSLVZO6LyPsYiZY5ndvJpA4eaM6AMvPYiRUm2t88vZAVmmm9UpVcsMRsmTExNEHla8yZmnYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJeWNyPl0wNjiPX/7N1zu4sFUaupyO1kZZXuDSNelJc=;
 b=RyM0Z80L6oVZal08ANg/YkABB8uCSTPQcPIkqWQeBm+LVmQJddwWFCtgo7jDOQekZA+c3Mfwz+sEPtjunrbce85lL3pZLRFP69nQMgrMIfF2f7FuIpH53yx/0suKx2tU4vjoc7CbgFdmf5a+AIgxlb8+XQ7n/AyU4ezOmQubk/k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3944.eurprd04.prod.outlook.com (2603:10a6:209:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 9 Sep
 2022 02:06:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 02:06:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Topic: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Index: AQHYvlGBdqdb0Wka20ODtoakwJg21K3LiDmAgAozSACAAA+IgIAAKeoAgAAUeoCAAFoVIA==
Date:   Fri, 9 Sep 2022 02:06:36 +0000
Message-ID: <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
In-Reply-To: <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52852221-e1a1-429c-34e1-08da9207ed1e
x-ms-traffictypediagnostic: AM6PR0402MB3944:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzpnDiCc3MGqENbcoJa7KUbSdpzXPXTvW1Bymagu6QbhF7iXOMTTANFApy3cAZAQSBSrNAqGKsbpvS98CXin+3MCjdhgbqloW1FoDOGsUR7ixbQvzPPBW3WZgd5vtc7TIE0KR4oGznYFE8b12b//gepnqR+4Ro3+DmXtxdeYQ/fIRDSKkuYbqtJaWlOTbl/7gSOWdM+2A9Jwl0RzfZszzjt9ybHS9AalS3sCHn9T00IgoucmTnd6TYJQpEXEJxsIbXS+4YFytnZsn9R80XpZ0hDST8d1I2QrptTMAqBJkoO8iP/gex5B/7/ozP+LnnD03sCI+ntpGsYtbX9rpgmopI6fpk4rXA+SZIVOr/bOxc0VOm0oCDhZetrZDDT5Rr1R2cvI/GYoYsXwR5ORvsk9vIiELtzf4f+51xrlrczFhtJ2A2nRZuFDXuiGYz6CI+aaB1aS8ZubRY0Y2zWaqYtzzGgaD2t/ipWP84cNdJql3LRqexwRUW6BZobbMeuthQ31TPIcDr8ZQ1gykmp/u8jiXzeGNa59bF3BM3xdZ4XAee9c+u5SzSsj9C7sQfXysQPXfotZd9QU74TDwhAkb2HldJEZP58b8htsZksyU4oT17HBP6T5jxqdqprZ/QMmiwd2vUScmZU8aPkrFmGkwG8yDdmBGZT3rpbyO9Jp15YYGQm2UUcOdkZ4D14PNVOgutDYpqRppsiOqS+Y4UOdywagxMeGk5AZu2UGIb3QZYiJ7g+36RlpH0dHA8C7ZgEj0TVTIxCBnB/DrSy3Od4esC6KKey9y0Us1oHGfZf9UQbuBas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(52536014)(83380400001)(44832011)(2906002)(41300700001)(86362001)(8936002)(55016003)(186003)(5660300002)(122000001)(6506007)(26005)(33656002)(966005)(7696005)(64756008)(8676002)(76116006)(66556008)(66946007)(9686003)(38100700002)(66446008)(4326008)(316002)(45080400002)(38070700005)(54906003)(110136005)(53546011)(478600001)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCXisrlXztK6xmseWT0mhKymrpkMYAxQw/o6n5lz0rQ1i/Yj7wlQiCV6nBGH?=
 =?us-ascii?Q?E+AOtdGnV4n+2NSWUuyjpPGYLlujvPKRY2cWWz8m0eZX5VOU9I95xNKI6fTj?=
 =?us-ascii?Q?GtbSD+7PLHcIg53emeyfXqRq49jWQP7IaaEZvVdfyJuLovKjnMW7ZBepHqIV?=
 =?us-ascii?Q?pmLAYubebHywopUySjMBNB/YKVWx78mFIJmejlH9oMUSQkpPZnYayT1dc7OM?=
 =?us-ascii?Q?5yL/KnurKtoGa9gNLbERE5MVDDXX355bN1qc6BQOmQb+LmL2q8DRctaczs33?=
 =?us-ascii?Q?ZzsReQ5Cm/b2YGk6ZJldYQTTK1PJnsvsO52hJgPcjyRrPM0knOj8KFJWiVHh?=
 =?us-ascii?Q?s1d96CeDN/41GvSIneBTTzI9JRVMCYj0Lcqpsa4CeLBNC+gC2Jxv4k7Uk6jp?=
 =?us-ascii?Q?LEd3TAukFgOjil4I/PnBWyJLVXT57kvLJ7DRf5OutKtWW+f0gqjC1Ya4LY4M?=
 =?us-ascii?Q?h4XnvRaotbXWa1td8u65h/kvGGhcmxWCPzDTQ1C9lSAxBoKSxWQKEApenyFW?=
 =?us-ascii?Q?TO/hp61LQ6N+KN6m1OYdlUbWakzr/UFx8eom5zlqsHgWhKgxkhVMvCSzgHjB?=
 =?us-ascii?Q?0qPOtmpaljreXzVu0+mVSH6ZHFpR3dlP+q3K4Jpu2Z03QLt7GohgL4Z7oUzY?=
 =?us-ascii?Q?UM8C3VqelX423n2vKczc3wZ9W1M3nsPdLujqPrCGibxJb68SGqB+c9MTkUIg?=
 =?us-ascii?Q?l78a45PbIImBZqwNI+A8RvbE/22a6/grsRz6HtTfUMfytvpwM5V2wd3yANlD?=
 =?us-ascii?Q?f576plPfAMYhalgaRKW/Cw8cFbfxWezFSO17UC5sNqD752i1Zh7yJmXwURcM?=
 =?us-ascii?Q?IN7PyepVM9hZzxivTUQ+SBpUiHuTyBNjFX4berNJCvwEUecb1VjLy6BobXUm?=
 =?us-ascii?Q?CcB6joWv9NYsiMXCM6dgSVhrzNNzDNNWW+XzjVcBvEeGxjLoqWcGZGqAFaIc?=
 =?us-ascii?Q?Xle6p72D+4HopVAcUIRh0JOBoXJZ6ftAyrhSmlaMofW1lyBREGZ/lUyn5rmf?=
 =?us-ascii?Q?zTk8PCpEeVqsCSvLCctSovVcngRXSVudCs+hq64UtddkHqQucPCCu6GcpkCq?=
 =?us-ascii?Q?rRG1ObGD7hQBipGRjesWPKyCEAhWFP6ED1FIk20ROUACB0E/F3WQKR27Gcpp?=
 =?us-ascii?Q?nacga/djHJ7i3o6t+FZ1JSS4xzvhja9f4KLiTEfrS2WpWQOIbASH5E02/JwZ?=
 =?us-ascii?Q?MQTnb0dsCmcIYcu8UA3nNtplJLKz68mG/drEENsrihL8iNjFA7EcWhaMjKCD?=
 =?us-ascii?Q?dbYAAKQ5kXEIrD5yu1EfkisFOZNhlj/qiOm8o+QCFpgig2dR3bakVJCoodgu?=
 =?us-ascii?Q?EPtlKvPmJAhhR8NfuQOAWNNgUk4yislqoRk16TjzY04nC7Y91C1SSZiNHwDa?=
 =?us-ascii?Q?UWJjGBgPjw+mJDP7OWeKdhbTfSfdWnOnJ39Ip03ugA40VYQ15B0EtFxASu7V?=
 =?us-ascii?Q?IHWEVC70W2chVnmNkJv2nsi61Vrj3JVUkmFWorXI/dOS0j3i2CtMWN2Sqa9F?=
 =?us-ascii?Q?CYTZpncc4sQ583A2VhnKW5guVTcqZqdnQzjv/h0oHA1OsO9V2jusk2L2P3Mc?=
 =?us-ascii?Q?RCvW/sitTxNCyyHXfto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52852221-e1a1-429c-34e1-08da9207ed1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 02:06:36.6327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnS7eriArgI7KZr0x81yLerHFyAw4ayZOHJixK448b2rS+731Z2QUeX8FSunfC3HoRpitwN10VOs9E00LKQ1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT fail=
ure
>=20
> On 9/8/22 21:25, Tim Harvey wrote:
> > On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 9/8/22 18:00, Tim Harvey wrote:
> >>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> >>>>
> >>>> Hi Tim,
> >>>>
> >>>> On 9/2/22 01:23, Tim Harvey wrote:
> >>>>> Greetings,
> >>>>>
> >>>>> I've found that the bd71847 clk driver
> (CONFIG_COMMON_CLK_BD718XX
> >>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
> >>>>> C32K_OUT
> >>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
> >>>>> the IMX RTC as well as the IMX WDOG functionality.
> >>>>
> >>>> //snip
> >>>>
> >>>>> This happens via clk_unprepare_unused() as nothing is flagging the
> >>>>> clk-32k-out as being used. What should be added to the device-tree
> >>>>> to signify that this clk is indeed necessary and should not be disa=
bled?
> >>>>
> >>>> I have seen following proposal from Marek Vasut:
> >>>>
> >>>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
> >>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
> marex%40denx.de%2FT%
> >>>>
> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=3D05%7C0
> 1%7Cp
> >>>>
> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
> 3bc2b
> >>>>
> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
> 7CTWFpb
> >>>>
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6
> >>>>
> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DuF26u9g4onuqCWzPRAvD%2F%
> 2FLByaEhh5
> >>>> Dtah9K8CcAOAM%3D&amp;reserved=3D0
> >>>>
> >>>> I am not sure if the discussion is completed though. I guess it was
> >>>> agreed this was needed/usefull and maybe the remaining thing to
> >>>> decide was just the property naming.
> >>>>
> >>>> Best Regards
> >>>>           -- Matti
> >>>>
> >>>
> >>> Thanks Matti,
> >>>
> >>> Marek - has there been any progress on determining how best to keep
> >>> certain clocks from being disabled?
> >>
> >> No. You can read the discussion above.
> >
> > Marek,
> >
> > I wasn't on the linux-clk list at that time so can't respond to the
> > thread but the discussion seems to have died out a couple of months
> > ago with no agreement between you or Stephen on how to deal with it.
> >
> > So where do we take this from here? It looks like there are about 18
> > boards with dt's using "rohm,bd718*" which would all have non working
> > RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
> > arch/arm64/configs/defconfig) right?

Is there any requirement that the bd718xx clk needs to be runtime on/off?
I suppose the clk should always be never be off, if yes, why not have somet=
hing:

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index ac40b669d60b..109cef35418b 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -104,6 +104,8 @@ static int bd71837_clk_probe(struct platform_device *pd=
ev)
                dev_err(&pdev->dev, "No parent clk found\n");
                return -EINVAL;
        }
+       init.flags =3D CLK_IGNORE_UNUSED;
+
        switch (chip) {
        case ROHM_CHIP_TYPE_BD71837:
        case ROHM_CHIP_TYPE_BD71847:

>=20
> Feel free to continue the effort.

Tim, would you continue the effort?

Regards,
Peng.
