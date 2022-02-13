Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087414B3E72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiBMXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBMXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:46:57 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C65517F9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Byj9Es6n3B9MGcONGmg9CZVTZowQ04LEIIEifEjAQHWTeJRz9SGF5ne3cRExzMdoPtYjxIOOPZhHedse13+EzDT4z9/XAkYW28KXhbh+AmdSYoNnoIiwOPW+4t+k1PnyrsTSBbEBpBymWSlwaOPzdSnq9xI9JIKYAh/5tiZPMIqvvDe/eWdNMcbYQWYm+9IY964hjqgwAy0+lOmCdCQA6QDINNwvag8QCjC/WNq9br+ArKbh9xgstDruIA5pMNoMcrR4A0l0JlLggRJK1qWHCpn1zJxU6jpDcb3XCnFWYcEdZSv3Z3M++5ARH1qrAOEGL1fZe0yxwm4iIO4/DCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dorCdrRNyC89n/vagkX21E0+L7RxHNS5NiUWe9Inyro=;
 b=LD66lrUgIbPJ/KVf6Lguyn7oClRBoSp+AHdSKzyNlpAhLzdWd94Fw9FZR3J46/Cg+SC0DCkBkl7ay6uGfK4IvP7P4D0dl6yOzHety59/OQ0fehkJDiIoDH+H36siXyg7sGgdtlOkVzB/dBdTGXvsDFZHYFa5FJE7tr/OqdtB1Njb6MMMhpqzN4JvFUZsbqdf7FjT+Y/Z8rOkWpXp50cjdeDib0lHXLee6ASaVMacc2PCYv3poo9q2I55ul4cmHHNxTJVWBBdJtH4evfGFE2Fsm3YrGsAJ20YW03gD8WToFavDhGHgO/WExtTdpwu09XTOmJV4GmSMSpF3nsBWg54kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dorCdrRNyC89n/vagkX21E0+L7RxHNS5NiUWe9Inyro=;
 b=F1/b+WGXMbouLayIPTdGoFz6YdWwf/i3VtNNi4N/xP2U6Iz1V4bdFCh6BLtowqdD/2e6CkF1biB9uSIal2PCu1ahEQJYwUS8MAxaVFzlgrmaBqKRLYedo8NLxvfqzPgFoTUF+aPFFEZ4PATL25syDcV6O1TY3xcGfZ6lLRrtJbE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Sun, 13 Feb
 2022 23:46:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Sun, 13 Feb 2022
 23:46:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates
Thread-Topic: [PATCH 0/5] clocksource/drivers/imx: several updates
Thread-Index: AQHX8ONNsTFmjnGsD0WJi9r2hmyxN6xdV8+ggBfiokCAAAnSAIAdQaqQ
Date:   Sun, 13 Feb 2022 23:46:46 +0000
Message-ID: <DU0PR04MB9417CFE2BBFDB2FDC32CA8F088329@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177F777E854B92C665303488519@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417BA24DB13CD6C98BE47CF88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <c7584787-838f-97b8-5e2a-c7f271d8a406@linaro.org>
In-Reply-To: <c7584787-838f-97b8-5e2a-c7f271d8a406@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7fa3250-b8de-48ba-2a96-08d9ef4b18ab
x-ms-traffictypediagnostic: DU2PR04MB8501:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8501F1DA9FD1C717401B243688329@DU2PR04MB8501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6fV9aAs1St3cUqlBJh/xBvhhYHAf5nlHvap/Gv3j6KNW6k1bfq8KWuCF2NNhqJmSgRiFLgkFBGwRWQUlMY8SBu7ZVkVdSoijm6TNS3fkO67C8d/AB4Uf4Q/dYCQzfFCIwwfZjMhne1OZCAOJx1QOhI1rm9lINe8fWlZgCW4IcZJGYpbpTzQJuqqCD/eSI/UDQGCRt1mwlC68+KEusJAlJBc15fDdyE+Js8j8MvuD47lBS/mOfdFDeATjVVZURpjVqwGyhReFV0oVN16Dhjp8BQ0eisNH9xUk0wKJOc+G6f6l9S+n4C8hVHHdz3OWNGGWNLL3Lkmzd94zH2LS20NM0g3ZoC53uRtjUxapMQpKkHB8d3+VxDluzjlKc1n3+gbG9ouv8UepL+vu2RKOvGVVktUZFjJ/jKE8Br+/zS+o4aO8A1qZa/9SOF4eaPB451LTdVw/xfY/0oF3gW7bThEeLlyOgFvI3wuxoPfqY9yBASFr68Fan4YOskr4g9zPyPa1r7RGD6BPNfR6dRP2qBpKDeHLVIi73UND1/DOmSsFEWOyKXH75031sRxUuvhKwQZHNccW3J432FSHyRNLkP2Ri8NzGdYrMFIqOM08Vk107WI6BGD9dIhsZk0XvBLpigWt4K9BBuhC6FW/xeHqNpFAvoSUwcGxZYPXxQKFgYumT/ctIB9oyPlp6Q8VC0Zq/GihdQUgs48dwRdCtI1jGsW6LFm0egmXoAL3KNXY9Qxnd4Ou/AdRDFrXGWmetRnNLsL6ms8JBoSrX69bvQblUTURKu9X3f2aWCEhpmHa0340gkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(33656002)(38100700002)(9686003)(2906002)(83380400001)(71200400001)(55016003)(186003)(26005)(508600001)(52536014)(15650500001)(38070700005)(8936002)(76116006)(4326008)(66556008)(64756008)(66446008)(66476007)(8676002)(66946007)(53546011)(44832011)(86362001)(110136005)(316002)(5660300002)(54906003)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?5VmWAYmsdYKyuPkEA/IWGVsnMmE2JDoHoCURP7mrRNJlV39zSN2DwJ+UTZftJr?=
 =?koi8-r?Q?BvCDAAhdFs3WjFjHyCINuthBh8zs1/o8zEdwkY5ydRGNeiEVcWdapbm1CI7Rv7?=
 =?koi8-r?Q?DmdotE6Y5KuucNO1R5elZ7EXrkOCUx+FMcTXJkjJG/s6qMUxj/OvFJBnVLFUQP?=
 =?koi8-r?Q?DAgK9SW5yD2J6/q/tq6fCW+nGEDHtIb3dzE2CFQ7DCE7F1bw30ROqjQP26wHBp?=
 =?koi8-r?Q?Lx4eotf0+tDvxU/wrHqt959uNl8Dt9szjUbErRS+DX6HHzuTUxnGG3egwwy8Kc?=
 =?koi8-r?Q?tJRZ6pxfJaz9Idx8oAsKK1jPTTk3uW+FVKqXaWmGr/q0q5OuaHe1an9PyrONRR?=
 =?koi8-r?Q?IYjus1LpksBBUtC1G7faYlOsYxa6CA3ES28NQzN+bPNt7CXrjWqj6VDo68np4y?=
 =?koi8-r?Q?lMoRAr+74U34uDc45euRJyOHpExXiuD/QVgkIXPP7yodsij0PjHy7+7+gh4tDR?=
 =?koi8-r?Q?QqTdW3PnE0tU3mI2EiiK286zw51yq0Ik7sFWjABBh+4uFQG7+FUBN7I2MrzvcZ?=
 =?koi8-r?Q?/Q+P/68okhhqWAamaV6oC4il461rptxRDm55dT6yJGPGKt35CWTRTyZpbIPbTt?=
 =?koi8-r?Q?rEqF/OyrXviBPQrSOoKWBnaGO+ax1ZycG99O1wPzD8zyOor+6WVPjW4bQ5rbcK?=
 =?koi8-r?Q?lJwQZfullsZCxePAAOSG6cNQavIAL03AEDqkfZ6DyYT10Hs0XcwOdI+yPpos6p?=
 =?koi8-r?Q?pEALGDed+bUIN9tt5+f8VmIQdohWz8B3ZWnhnxe2IuTv93f6+2z0X0SF6BAt3T?=
 =?koi8-r?Q?tOdF+J6Wz/NGM42rOjG0tAGFySJXQZ1eyfs1Q2m2RWN4oinkSLYzRIQ61cjHKF?=
 =?koi8-r?Q?YiXFhIDhgtkcFCzGbEAw0MBsXKuerfoppaarMpZUJz23CvuaylPHHpyXthOT6u?=
 =?koi8-r?Q?bVeitdeh7T6CTjaoRtJTsRIjDhDyBLVnVTT5uWz0VYIefyDyFQe2IXjgbLx2Ra?=
 =?koi8-r?Q?Ko1Nt/flMDavCgOPiKMwaM7//wni4AQ0rOqZftdkRQvMOHfvqzUQWbIqCfx96N?=
 =?koi8-r?Q?ttniUtDVgr6OWV2jWj0UFC+3yC8+aXSvHfJ+UZmJrdtK1EpS0U+jThy0HV00mP?=
 =?koi8-r?Q?oQsqTVIfpqhFRUKuhffHwkKAXpemXm9QxS1cdEDhCPRAQHWrCJXzx6rKz8Ao8b?=
 =?koi8-r?Q?bz5t4RwgRvFUQpwNa+S00UxDVxCs+DY2vpL4qZ7pzdzRJFFkUiIbBwWARJNrPT?=
 =?koi8-r?Q?lLbseAAAzE2yASpQI8P1iaZU9KxiCbMERcadR5fO/tyS+VrBMRZ9vOWRO6GLWP?=
 =?koi8-r?Q?kY7gbYQfZU6Gijv1HNCKfvGVB4UruGjf398h1y4XhlaL/CEM2PpoXX48rfGsco?=
 =?koi8-r?Q?3ncqGwr8iPP72LAJLWVDIRyGn0SPUVYnF11M5SZqG425LeV4BFscSI8XW1WS35?=
 =?koi8-r?Q?StCp1jNh93ThSEJi/58veUU+sVYFmMZlAHdit+7Tc+a7PX3RdsAVDUwCOFrHt+?=
 =?koi8-r?Q?MWtONqATEy+5EIi6H3w1H69riA13ucgj5Ue3z4j330FeG09kAVz9kv3f/4l1FM?=
 =?koi8-r?Q?N+ZWNHPEalIMyjiT+cGBiO7Jj00kWDyzJjDtozvSxqOtcbZzBkZw0q/KTn266m?=
 =?koi8-r?Q?585FdaSinw=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fa3250-b8de-48ba-2a96-08d9ef4b18ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2022 23:46:46.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yx7ZMb17YNcjHpVRIpFKHg1YSKBcARRYfD+EkSWYR5WFJYp/FRwnU9Om+kOTHm44wYfbp6eTvfOsAOR4Q90dwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/5] clocksource/drivers/imx: several updates
>=20
>=20
> On 26/01/2022 09:24, Peng Fan wrote:
> > Daniel,
> >
> >> Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates
> >
> > Do you have time to give a look?
>=20
> Yeah, sorry for the delay
>=20
> They sounds good, I'll pick them up

Still not in your tree? Or later?

Thanks,
Peng.

>=20
> Thanks
>=20
>   -- Daniel
>=20
>=20
> >>> Subject: [PATCH 0/5] clocksource/drivers/imx: several updates
> >>>
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> This patchset includes several update of i.MX sysctr and tpm driver.
> >>
> >> Ping..
> >>
> >> Thanks,
> >> Peng.
> >>
> >>>
> >>> Peng Fan (5):
> >>>   clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
> >>>   clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
> >>>   clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
> >>>   clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
> >>>   clocksource/drivers/imx-tpm: update name of clkevt
> >>>
> >>>  drivers/clocksource/timer-imx-sysctr.c |  2 +-
> >>>  drivers/clocksource/timer-imx-tpm.c    | 10 +++++-----
> >>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> --
> >>> 2.25.1
> >
>=20
>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7Ccb71984b85
> 4c4bd16f2708d9e0aa295e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C637787843705684549%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3Dop5BIq2UuUmYonbEV0U27tVbLPTfxnkASmS52eABSJ8%3D&amp;
> reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.f
> acebook.com%2Fpages%2FLinaro&amp;data=3D04%7C01%7Cpeng.fan%40nxp.
> com%7Ccb71984b854c4bd16f2708d9e0aa295e%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637787843705684549%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000&amp;sdata=3D7weozdfeg9ykj8wObv1d1G5UYCExNepqhFv
> a%2BNwo9cE%3D&amp;reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt=
er
> .com%2F%23!%2Flinaroorg&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7Ccb71984b854c4bd16f2708d9e0aa295e%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637787843705684549%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3D8QScPZeVas%2Fpb%2F8YuUJMBjO83eeD%2BP9Sz
> S3yfdKbid0%3D&amp;reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2Flinaro-blog%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7Ccb71984b854c4bd16f2708d9e0aa295e%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637787843705684549%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DL90xtQflnMHRmrZVvmvXVfAY7npcLPM4%2FKITN
> bxgY1c%3D&amp;reserved=3D0> Blog
