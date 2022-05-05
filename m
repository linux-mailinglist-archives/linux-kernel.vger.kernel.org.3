Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5531D51BBF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352725AbiEEJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiEEJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:30:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8137ABB;
        Thu,  5 May 2022 02:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjXW5kR9voKFPiTF+8XW3xCOQV6bKW8kFqF93cg747bvfSJmSBzS7JqvD+X+DcYWvUisiGVOZoEu9abXqT3fn+58QSmzQ2lDGLeQvaKdbU6ahnhtQP5914zhFplKSLXrUsQilZ+J0l/P5LGiKHchVSJv1D8ErB7+XpboF9PCKzJv3v6y9RaKQsu3JDFHvg0XwiaxTin4AKEsXT+Im9Q70S4E1kQivWOtfXuOjtj1ZF3sU/qGkb29/ePrT9oDwyugeqxZgDRce5G7nfK+i8hxNA3M1xaaSGO8mEoalqSMynw9/EG0gS8tcGRSXSxwbfSbsHSk2ECawNDOBrerUugvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7ZYNv4LUpzsvsU7HoonB7jZ8phcz7PCaj2SEpzHrGU=;
 b=Xr+FH63rdABnIZz1byk6xVI8RbeR+jIc8WuKk/oalhUZz/zXHjUzOLYeEAci46WG13nQOny0QtHhrw9NJO2Wj6/TSaMR7/bTiWlzDBjJc+izQj1rWUkv9Gxl7fa5KVNaGu1pM3iw3TQgAnnV7jqdVJdn98R+Zn+5qzzfXS0rhf5v4nVnofwUCSDf96Zlh720wSoogsB2mYcWzA+IXMNZX3dcpuRg1Dgj9Bf3e9xmHMoKzuu3Xij9kxVHFqrzljMbbJRT0QlfVxLqrIZeplnyrAEm9TGi/N93ItHFxdFPqxBTiU0hDljH/XByfculcN0wPXTtZyHNlzIDe1o2BwMl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7ZYNv4LUpzsvsU7HoonB7jZ8phcz7PCaj2SEpzHrGU=;
 b=O8aL1dPv7hUsgyU3/4hJugQ6ndEUjd/b0syXoLr21OxtoWUt2bo+9+9YHt8s+z4/41Jp4jpSVkaLw20CNyk2zNWExlZgdawDjvz24DXDmGzPKevrRAXcWxGWXolidVG8Jq3b7tWrR1DcMxTybSLzrPBd4Jr4qYKOQgJOKI6bvTA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 09:26:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 09:26:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 0/3] arm64: add i.MX93 support
Thread-Topic: [PATCH V2 0/3] arm64: add i.MX93 support
Thread-Index: AQHYXulHF+y34Ra6sk+O6vv1l7ZMaK0P9baAgAAPrnA=
Date:   Thu, 5 May 2022 09:26:30 +0000
Message-ID: <DU0PR04MB94175A698E4363D2BB63F90988C29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220505082607.GE14615@dragon>
In-Reply-To: <20220505082607.GE14615@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6634aca9-4032-433b-adca-08da2e7956ca
x-ms-traffictypediagnostic: DB8PR04MB6714:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6714A8BF6598AB7C572C98B488C29@DB8PR04MB6714.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4yWdQBgt1QzRHVUFGgyyC7E1IUMpJG7vrkPsLKJ64sRjMs75EVz2FD7In4F5NA52CCnk9JAccIe9gahjMbsW7eoumg8ionb94hpijEyakQquiTzOIBqeSnBE3O8BAdugvXFv/4tCQsdXmr28quyWEvdoKEbWv1TZWgX6oOQYXtnVgu0flaJPCqbzk0Evp+msZQjtSHzBEtHU0kresvlJUX0fBFkJLMcBcfm8MVpNgmJN/2rXNnr4XpiW/UmD1Vg15yE30sIdKK/tvNcELwEWIWt79yjXuoYIaTJ4oi7zg+YJtCoc2HJeT5MuCtiHvxvkIZVCTpe2Ywno3dDnPn009Xx9xp3IBGxRa0NDDm1meP6f+8plrmyui5NQCczwsfz/gHlzQ/L7tqUFUYwqPIsFT4uXOju4pog1Mb/TmP9bikJogdRRkUhoWh/LzdjHpvWMqSrzYWFREOETBhArSbkIsd1vD2haWiV0lcmOW1PBgT9ugQdalx5qODImJxnSRoNSe2Fm3PhnfhdmMDIsaLcuzQUlAjuFMOFWyyKWRC15EQ9uayJtbVSZHHGroFP+xGThOFrLm6CHjHiVk2/dY9dkwdsXZPIKnwamUCkz8cEZPS3ZoPUBJouABj5MBx2yTzFkcgdVYvf3FmgpdBgBvPqNSfwmSpD/srfm9KqnYNQBD6kUudg6ymnh2L6tUbnu8giEM/Cayq8Po007HTM4p/5Mrfs/V2i1gI8KP9BIupCvnEFCLOBsxUqAX0opeY3zJEfBB3qRKNY9VUXYHVMLs7oKBxNbEc+CBv1NkMuWI7+/2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(7696005)(2906002)(71200400001)(6506007)(8676002)(966005)(26005)(508600001)(38100700002)(38070700005)(66946007)(4326008)(76116006)(9686003)(64756008)(66476007)(66446008)(66556008)(5660300002)(86362001)(52536014)(316002)(8936002)(55016003)(33656002)(186003)(44832011)(110136005)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ZEZCH53ffVcFfntUy2ssZ+8NrQrWBRoz3UycvQB7ZjpCeOmMLWDDaYUbgyC?=
 =?us-ascii?Q?Om2qNiV9S+5Z+y7zBgQ1wMVpftETLjVs2u3OP7l5sKylSXptNODKsnXVinjF?=
 =?us-ascii?Q?Fvu1eqFhYypzpJIn5yp2BO0j5XtYaf3M1J5SltqeGrM2xXG2s9PgyiUAT8uy?=
 =?us-ascii?Q?SfWmKNyS2tSvW0vcscBu4VX0G2I2Te+maEi7cc3abkK4LsvVMttd2PSC5WPW?=
 =?us-ascii?Q?PfbE/C7hiMs2BjNedswF+L1WMxtHlMq+775knzxPfiq7OPN9JCA9ePnE+a3i?=
 =?us-ascii?Q?jpn9SZG/2UAtGfUovIeIoHGtD+5J5sR8GjUohxx6Hmp8oowMqtkEutH+SpaW?=
 =?us-ascii?Q?XMS+I+KOAhCAqNetOulUK6Lv7MjPY6WGNHzXPeVjuiUwNSNPDgqvuLcj8AE1?=
 =?us-ascii?Q?Wnje1liPOvkb3NopfzoSeD8ALQulWrtjwYJNNpQYUymM6yctGGd6TI7G6cr7?=
 =?us-ascii?Q?vgVuN4ffOU2BKBCOIXqyo2qxpYhHNOmeEoGRWfjP5MmKlnx/+uMvDWh40hNB?=
 =?us-ascii?Q?gAxjTbhGwfkYZe8E40uxgZxIOGIWNtM7i4hIBNYwVVh7woIOF2LjFouV24VE?=
 =?us-ascii?Q?ZxTOJcIh2NS7PEP74kgRDfZaoM95HCkdvwjO78xKrnhh6LKedbRDYFrYMTR8?=
 =?us-ascii?Q?VaPlx2ot/syL5FqbEMKIHsl9MV5TfNX1SmH/oxoPEYcFJZBKndH/XPcEF18b?=
 =?us-ascii?Q?XhjJP+hPbTNnDlTCVrMtEHDgFl65quMrA3XNE0QllRFQiv86DhiZJdsjHnn7?=
 =?us-ascii?Q?XEWWsV68WDOKvWok27W8z5ev+bGoUvSqXwn6WCYeEEuz1ZW+LU+2cINTGdXy?=
 =?us-ascii?Q?7vsr+3l5YFHFr04OjBSpwARBh/eSrypjBV7THTxGGo5LeC09sjjiO2jdXLJm?=
 =?us-ascii?Q?sZQp8IOzSXm8cDUt7RDDWkt3Uw4GW1k2r62YeJDFhF29rjcDAl71xKO32OwD?=
 =?us-ascii?Q?3g27sbWDlGOtCipGQIQo7nWm+6rmCZs/VIZSVTRX5r+eRLJ9zgDfCHcywWT2?=
 =?us-ascii?Q?dCYYOt/IMHR3m9luPyt/OwercCs+gzyprhoLy17/ncPcvWBqYWulM/0WzwNV?=
 =?us-ascii?Q?bOTAM80JRLiKjdolO/zXpQIcjWS5XXFGmFF2uCciZ9/78/0tRm1JJJ1xkA5F?=
 =?us-ascii?Q?sEmAOnguFKfci8Is6IrkjytB1wn4JHRl1X5O608R3/suH5BXmIxLCQLrfVez?=
 =?us-ascii?Q?0Q4fbVRbkseq7QSNfUkyvmSE3OboGrY7Lv5GsHX0raZKtrXsqH+wo3LQzyKs?=
 =?us-ascii?Q?EOtmXRg5b9+FbMBoothfu5zmX6y16UTt69TzRKZJZika8zkCjY+VaZ0MuK9w?=
 =?us-ascii?Q?DucuG+bCKHwWIFUQ0dl//+90p1brqbWcVyIgxpDJtq27wMfg6OU1DoZiJJpq?=
 =?us-ascii?Q?Zlh5b8IQW4s+wMJsDbTAR61yhk945HDquWCeq6LtA5tAmV8GqJB7w029VeOv?=
 =?us-ascii?Q?22SH6uPO1WTOXfAH7QeTc6nTBJolrIQBvsjn5b1CQ+O52C2vE61aZHeqMFV4?=
 =?us-ascii?Q?tVi2Mvc8DPfaJGBfnNu5GSIXLv098bkGhIrpuq5mwcu7KAOVYm6W9DZfVO+C?=
 =?us-ascii?Q?jvB23I0xWCsHT46Z3dxy/fQA81CdbFCUScPclVrbRTkNMsDmrw3NGPySZ3vh?=
 =?us-ascii?Q?3T9aWONpeBmA3Zp4fytO9B+riPXzpr8t+gje9NSveJ0HfFH/zn6Kap4oWcjA?=
 =?us-ascii?Q?xGfKJeSMVNBK09/asRPiVLIPX2jBkHVe3htaEOYfl2/C8MZ8NAoYgGglwNSR?=
 =?us-ascii?Q?vp3E1Hq99g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6634aca9-4032-433b-adca-08da2e7956ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 09:26:30.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aApnvWPheBZdemoBIY01Rdr5/AQMeN4m2DJVLrxcqiM2/Q1FpwmQ4eXVuFmHycdQUOTj2WZwkb8m8Mt0XS+1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

> Subject: Re: [PATCH V2 0/3] arm64: add i.MX93 support
>=20
> Hi Peng,
>=20
> On Tue, May 03, 2022 at 08:29:48PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> >
> > V2:
> >  Update License
> >
> > Add i.MX93 dtsi and 11x11 evk board support
> >
> > The required bindings and drivers has already been in tree.
> > There arem checkpatch error for the pin header files as other i.MX pin
> > pin header files.
> >
> > Peng Fan (3):
> >   arm64: dts: freescale: Add i.MX93 dtsi support
> >   arm64: dts: freescale: add i.MX93 11x11 EVK basic support
> >   arm64: defconfig: enable i.MX93 clk & pinctrl
>=20
> Could you check if we can eliminate some (if not all) of the dtbs_check i=
ssues
> below?

I just give a check, the fsl,imx93-lpuart strings are in linux-next tree th=
rough
Greg's branch. With that patch, there will no lpuart warnings as below:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
commit/?id=3D77edd0de002813629bb3b6efd336a630fab68aa0

But there is a warning about compatible/model for board, so I'll still send
V3.

Thanks,
Peng.

>=20
> Shawn
>=20
>=20
>   DTC     arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
>   CHECK   arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'compatible' is a
> required property
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/root-node.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'model' is a requir=
ed
> property
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/root-node.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44380000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema:
> repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/serial@44380000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44390000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema:
> repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/serial@44390000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: pinctrl@443c0000:
> 'pinctrl-0' is a dependency of 'pinctrl-names'
> 	From schema: .local/lib/python3.8/site-
> packages/dtschema/schemas/pinctrl/pinctrl-consumer.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@44000000/anatop@44480000: failed to match any schema with
> compatible: ['fsl,imx93-anatop', 'syscon']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42570000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42570000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42580000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42580000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42590000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42590000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@425a0000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@425a0000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42690000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@42690000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@426a0000:
> compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
> 	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuar=
t',
> 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,im=
xrt1050-
> lpuart']
> 	'fsl,imx8ulp-lpuart' was expected
> 	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpua=
rt']
> 	'fsl,imx8qxp-lpuart' was expected
> 	From schema: Documentation/devicetree/bindings/serial/fsl-
> lpuart.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0:
> /soc@0/bus@42000000/serial@426a0000: failed to match any schema with
> compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43810000:
> interrupts: [[0, 57, 4], [0, 58, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43820000:
> interrupts: [[0, 59, 4], [0, 60, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43830000:
> interrupts: [[0, 189, 4], [0, 190, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@47400000:
> interrupts: [[0, 10, 4], [0, 11, 4]] is too long
> 	From schema: Documentation/devicetree/bindings/gpio/gpio-
> vf610.yaml
