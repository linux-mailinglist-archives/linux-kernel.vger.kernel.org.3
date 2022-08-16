Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E835955C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiHPJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiHPJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:02:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629DD124C;
        Tue, 16 Aug 2022 00:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Z3O44fkgqR3Ktg6OnY5MNf4K+b7M65PJavswtm0cnWoK/jpaBTWCirSVU6p8yPXeLwDyXfumCtCc2Ag15BW28Wy2y0iQx8CioVSABjnRTiCxGXW3WYq+3yJADX11bOCMqMbxqDtZqLW2e1mlWqh1r0I6xOEE7kgXKCFdwFVbVlT3Vg25l39aNfs+xctbojGeMCQHxfL6GbOcErPikCiSvU6eGs/lzXudUDDuHNEw9iiR6SH8VjjDQT2R2hG3/p2Ir9y9BIFP93qD+n35ipzmCpKveUIIR1tz/cFC1LMQaLBtIx2FRiBH2YYx9bYUMMyc5iZWyyVBewDCtihYHjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f79xZ7Y0PY2d9LM1Vn+NIHqF5+iG6Epdj2KBV8nd6ak=;
 b=G+vVHRdZM/KuEra4IIdnK1Rf6qL1qXGX8duGxKbJNlKU36c4d97+Z/lLv+dkI5ikV6Hm2cIVqQvjzQX14Xz+sj39NysvIuw5cugvIGKnPHoRtVlvOdRWUDwfnE/qXlZUgJzm0lSAJpWC2bLs4mzMAjFKVeFBIcFR6WQ56DXEtnXrpY4oK6x8ffce+sOLIlz8MMTQeHbqbPk/wLufMHl+xf63U7lQWgNZyeTALxwEuoOgKzcmAbhGn9GRKbh2i9TQaEMREXr172R3eOrF9m/BH+7Ninka+KVKkGgCXxnCuOLQrPd6iVb9d5jikIXiVwIQGWvAqzxHnz3k67ZucFx8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f79xZ7Y0PY2d9LM1Vn+NIHqF5+iG6Epdj2KBV8nd6ak=;
 b=OBBuuVJC+H8SqGWBt63mAJ/w+F/EmF7bLQ9CVVRh81Zq6UIuay66+kei03MN8azbXU7SC0ghyP+psZh6I/VVGeZEi1w7LDw4o9qqKgfQTC/ej7A9w6/LChnBJz5BplL8VPNQEQHW+AhQFOxF2+fAQm8D9aJimukZpKCZ4t3jn/8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5547.eurprd04.prod.outlook.com (2603:10a6:10:89::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 07:13:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 07:13:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: clock: imx8m: introduce
 fsl,protected-clocks property
Thread-Topic: [PATCH 1/2] dt-bindings: clock: imx8m: introduce
 fsl,protected-clocks property
Thread-Index: AQHYsFgAb9/Dm+cZSEyj68dAWhpa+K2v/VoAgAEfCpA=
Date:   Tue, 16 Aug 2022 07:13:27 +0000
Message-ID: <DU0PR04MB9417593B87BB5A23A29D732E886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
 <20220815033632.1687854-2-peng.fan@oss.nxp.com>
 <20220815135756.GC17485@pengutronix.de>
In-Reply-To: <20220815135756.GC17485@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472caf3e-a2fe-4151-5289-08da7f56d10e
x-ms-traffictypediagnostic: DB7PR04MB5547:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2a0KwfCikCjjp7cIOEam0jjvK96SR1Pb30TRINh+7PjYj0Lrh2KvR155dSl8nF5ziAA9juHiUaZ5GLl79GGTkrmVdeP7GaYM0yRskCgjImNc5dbooidG/1c44nJE1idgmqBsXV+V6lI9D4Ppl4v5lih/oThRpJNFl6bA356CHcPHZ1vbrWyXhcPoi3i6+LxVe+S5ueQ6Qcsgy8bWQjvVmZWKEMyTI98FQs6QI8vZYIzvyOPij61aPFBAlogzJ8ieTcpXGoHmpgrx9dXcVFAblbszGxaTj4laPxiUZVfpgOkRKUYHal/YljvRftJaI+GvGaiPBGWrVyuO3Tk+KXZok7Uqpl48eqbh56MFokW0boBfSwEBJXxCOk9VviptT8ynRqcRsEmT1d55tkJTQb6QMXqrEIwKhYSm8TkL2cIEty6ejkMspmJe8LuzSwm4+frynodTK9tWamExw4abprPPt7bml46gg4E9saWcXlQiYFTRYpqmSCJYUWfCgaUNcs0v1+dcuZs1xbdHaaUbk/+/FQxsAT/fG7egnAmUG2WxohkvuoMUXY4WQJ4+Kg9tS5ne/qtVKoQprVnijNGb4couul3CRHFr83/vZ3NrCbE6HSy94CE0H9yMCLmF+DVq5JN1Z9X99kGin7uY9HbXOy/9GEbw36rTqMuy6sVZf+t+0pc39hp5IBuBVdW6DgF6ZVW2RJeScywUjckjUg4f0YL+UEP4uVk8gPeBHsA3pNANS3hxjLaNTWvHByI9Phbtt6nKSfaC47qm8zudTBRUwLMoaJQ4P0fXH1l010JINnfUD4NNdfD8cdu3f61dmGJyf31OzjBScUslW+p67DTpHh8ZVnM0ZHtWpUAsQcYO12NzDPJ7A7aoe8G40hDVgHcb3RG92dcMErBTiHuYcAzJXewUYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(7416002)(76116006)(54906003)(38070700005)(52536014)(44832011)(5660300002)(316002)(45080400002)(66556008)(41300700001)(64756008)(110136005)(4326008)(86362001)(6506007)(8676002)(66476007)(9686003)(122000001)(33656002)(2906002)(66946007)(26005)(8936002)(66446008)(7696005)(55016003)(83380400001)(186003)(38100700002)(478600001)(966005)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wV+59e2TirHWB9kwHDvMxvu8u1Vj48t+PSrkudEMB6JFFpe0B+VzfOMHNwSW?=
 =?us-ascii?Q?B9fAljJ7ytNWc+Vra+EckP5Ospv3Z1oHPnNOvJ3Hk3ckH7aAI9laOQJLYHfA?=
 =?us-ascii?Q?kwEUdBVmYs98A3h+BgyXxLK88rDRwoojZ3TtWsKwKTScz/33uEed0xgeJ9Cf?=
 =?us-ascii?Q?ZH45ZUY6bMI6mfMZyKVwyN+oijYgwkL4fGg4WJlyAVRZ22DhfdqbUCn3uS5W?=
 =?us-ascii?Q?UhFwkGWzMI0rX465/a2EtFJzpvBWoJNWjE1NQm53V170zqJp91nqwW//4vdh?=
 =?us-ascii?Q?yK6IvSA3Od+nhcb64WDrCUHRbXhFwxNw3KqyOIf0tYRROem1a8gdZw6aj1F+?=
 =?us-ascii?Q?wurjHZQ+qULpZXw+14SmsRx2hFkRXUOihvyK8TymDuocyC8JBUUCkO/oDqSd?=
 =?us-ascii?Q?ytd4fnPQGmwTESKX4v5mxm481Vio5YbxknDSqUF1pQImZpxNeL2Z6p0Nok4l?=
 =?us-ascii?Q?JzEMTx1JL7TOtWdz/T5VK7lh6xprs5nDAlEt6hV/5hqVX7JDqvJDxIuTod8f?=
 =?us-ascii?Q?t5y1WDFthxWKVUydA3rBoq6AIrVyoeVvfUEazM401hlCbaSkuoTt01TRBfkZ?=
 =?us-ascii?Q?vJYUNLu4wBEt+qIzq16xywCNDoBEN/RI35BRjjVOiYoFnOoyBa8v2MlOERfa?=
 =?us-ascii?Q?zxKKx+lIjqDYIqCty7hohNBGJ0Y9exX+0pmiJNS5FI6n+Ki4YD1TSNbjKHHp?=
 =?us-ascii?Q?rFm3vANuXroMx+xAF4MdXSc5rVbAK9liMLqFz3yGp9IlXnsmEpYPovSi/vfc?=
 =?us-ascii?Q?ubJr+SxUuD7OOW7XmVpsvW7eoYGyqOfEWkVnN8Ng5bYiZGUlzU3nEitoU/xg?=
 =?us-ascii?Q?SGhbKgGweedBmD3LuW11mTfZ9FQi7KFPiqWBmwPbkEP/+5oyL+e6TNorDiYP?=
 =?us-ascii?Q?QriB8Q4mN1Qy7S8z8rER0NC38FCmhqYaSTCvjiKqZrgbvxvlCZ8x7myK7vM0?=
 =?us-ascii?Q?gD3RT5da3ae6s8AM0vrehtY5z1cC+INRUKjYXMf5DxwX/N0aRqLRuUcl8MoV?=
 =?us-ascii?Q?Qq8jy4kVlYGDh9dQD/10zrSETxuA+ct+oVMKNlSFVL2JvgAgUq5U8wxgLv9w?=
 =?us-ascii?Q?3ijYa5rh06sE3QnXouudmU4Ik4bvDpUw4BfClQGStUNLDMMbShupQLRI/WQq?=
 =?us-ascii?Q?FFio8BjTrFKZMFXVCJJSe1DZ/DmnCcyl6oRxupJw45pVY2X61zIsXX0MDVlt?=
 =?us-ascii?Q?U0mQh4kYzcU5bcyT65GemSihL6hzutJ+cnJCyRrK3Myr2fvfyG3Px9x3FWDt?=
 =?us-ascii?Q?dN0JVW/lLQ3Nl8Y41vYRFTqYDRXqfphgGpJZMkjTJbzDYrIjKEaLq0H/4v4G?=
 =?us-ascii?Q?5Gjh2UCZpAAxK4LBK+2W73TlxKByuZy8wQ/Lj3PkLj7RPUtZRI0nl304yj8H?=
 =?us-ascii?Q?E4kquIMXRqpRuikiJHg9NzvxXYzzus0PpLBPLjBcu0EUoi04d/uJnjuKamWE?=
 =?us-ascii?Q?gN0YYyg9XoI18+OSohvTJycVsj7iz1z5D+2P37EmjSt5fEMkWcjVfF4WNQLw?=
 =?us-ascii?Q?k6Tr8MOrnYlR6fRhDtjHdHq8z5OOouLB+Pj88lWy81+UUbWY1DqynGIRPsI7?=
 =?us-ascii?Q?21p6dyj1o0MaBuTR5S0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472caf3e-a2fe-4151-5289-08da7f56d10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 07:13:27.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CQ8dgiBFC3kXC1pHRs67hX5wUfT98Lz0olEdDjy2xPZVs6i94tFI0HJh0MKRCLbnXpXQt7yUj2k0YbnP3zWtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

> Subject: Re: [PATCH 1/2] dt-bindings: clock: imx8m: introduce fsl,protect=
ed-
> clocks property
>=20
> Hi Peng,
>=20
> On Mon, Aug 15, 2022 at 11:36:31AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8M Linux run on top of Jailhouse hypervisor, the root cell Linux
> > should not disable clocks used by inmate. This would also benifit AMP
> > to avoid Linux disable clocks used by Cortex-M4/M7.
> >
> > So introduce fsl,protected-clocks for above case.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > index 458c7645ee68..0ec490ff9a09 100644
> > --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > @@ -39,6 +39,10 @@ properties:
> >        ID in its "clocks" phandle cell. See include/dt-bindings/clock/i=
mx8m-
> clock.h
> >        for the full list of i.MX8M clock IDs.
> >
> > +  fsl,protected-clocks:
> > +    description: List of the Protected clock.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> There already is a generic protected-clocks property described in
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fdevicetree-org%2Fdt-
> schema%2Fblob%2F0d1b78cd0c3d9a3d523ced17d7da64b03f6c18ea%2Fdtsc
> hema%2Fschemas%2Fclock%2Fclock.yaml%23L131&amp;data=3D05%7C01%7
> Cpeng.fan%40nxp.com%7C5dbc72639c9147765af208da7ec63315%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637961686968811809%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DD%2BfJA5h
> wblaX8VH%2BdQoN0pEFmCipfZHHf0ZVo07B4kg%3D&amp;reserved=3D0
> We probably shouldn't add a property with the same name but different
> meaning.
>=20

Thanks for sharing the info. I should check the common bindings before
cook this patchset.

> I am not sure if we want to go the route of a fsl specific property, it l=
ooks
> like other SoCs could have similar problems and it might be worth solving
> this problem with a broader view.
>=20

I see qcom just drop the clock entries before registering the clocks. But t=
o
i.MX8M, it is not feasible to drop those clocks, unless check the
protected-clocks property before registering every clock. This is odd.

So here I just wanna let i.MX8M clk driver prepare enable the clocks listed
in protected-clocks property to avoid linux disable those clocks.
> Anyway, please add a description to the binding what this property actual=
ly
> does.
I will switch to use the common bindings.

Thanks,
Peng.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C5dbc
> 72639c9147765af208da7ec63315%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637961686968811809%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%7C%7C%7C&amp;sdata=3D7UqyWwDDhaze2qZJ%2FknZ6Am7Y%2Bs%
> 2Fbpyv9SITJHgsZPw%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
