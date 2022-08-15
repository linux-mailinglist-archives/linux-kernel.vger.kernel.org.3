Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F1592CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiHOJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiHOJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:21:53 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C4A3;
        Mon, 15 Aug 2022 02:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl4Q1yvrET+Z1TI7fV4FcKIVgxwGMDQNXd2fu/xmo+yiD1sKVdDkMz3g9sjF+f9tCMMI8HYGrrke8IVnUO70eaUMYxDN/RCZszNab5eNl3v6dFD1q0ADVzxibEbL5R1Jz5/EnS14zXqSz/g+cNCGhIElmtxS6yEcrcuXx1Piidvxp7Zcx9YG3bG5AzgAO9c/HXlz6kjMy0+e6sdcZyyfX87f8vZSqSjw+R+Jw5JVjrJlwBYt9sB5LNjbi68w7G4jvvCeI7h4mqyPC5ReX819mj8RLk2AQ3tOylQDJhC71yaXXDwa5MKKlaol8qMLfatXaMTmzy026ff/jV2SgVCCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tUG3hWn4RiPQOPL9vAZFhuu7pDb22I3VmAaziDQduM=;
 b=GWKjEXg4+4q7qVub317iiU3nUWmPJd6a/bJj5VBUiostlNwdSm3XxMwQbEqudQMQify7rYWHJzCI8yW8dFyFnZgUsP8lkNwDPKf3pbnhrTF1br54Zhb8s9/PimMzVMJdaBR1bcGgW/58p22g5iDNhl10vjR8TW1IVO3ud+HsrawR04aYwTwO8KjkK8VAiScfjFfxrfFkUQcZ4EUS9SI5FotwclTdp/GPSbgP1ksH8fHNKNLb9WY5yWTMna+MEAGMtd1UbLx9Du5uo6AbEj6R4E6w+x8YTRDNBMQU1R91iu7t0zI9bkadknGm7v48/kzoCWTZVze0/2bgXF5MYj1O9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tUG3hWn4RiPQOPL9vAZFhuu7pDb22I3VmAaziDQduM=;
 b=Da61NRD8CzyDCeEVL+qHpqFLNh/M7mnQmx1n9DUJCFvLfEnan7VbwUjf1EfpP1/1H0rbsBgHHiv5/nhVj6/Tt9hpAw1Hu/2EcBfNavemks+Q8+V6EZaIKjm3BD4yFVcD5uGInAw3c0AA67qIixCXACiSpL3FNINW4937mjhgCsg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7183.eurprd04.prod.outlook.com (2603:10a6:800:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 09:21:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 09:21:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH V2 5/8] clk: imx: add i.MX93 clk gate
Thread-Topic: [PATCH V2 5/8] clk: imx: add i.MX93 clk gate
Thread-Index: AQHYsEZ4jBr3501chky22d+LcNdZ862vrHGAgAACEEA=
Date:   Mon, 15 Aug 2022 09:21:47 +0000
Message-ID: <DU0PR04MB9417B5170F0697260E3A829788689@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-6-peng.fan@oss.nxp.com> <YvoM5/6mR5MtGxuk@linaro.org>
In-Reply-To: <YvoM5/6mR5MtGxuk@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85170805-3771-4d52-bba3-08da7e9f941a
x-ms-traffictypediagnostic: VI1PR04MB7183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auxi/BXD3OyNzTzhNtUra46Xuda3oBsoTIM+45f480x/bbKsAIuMp2eSJVl1dOrZtdZ1qzf5xcN58Vw8dk4F90tE/2B2YjpOnH+9gxGtj9gG9W9X2UAiCEQPqN+Nie/5MAIpxYORkmlaQbSoc3yMvNZO2ZPlkFdfgfVrgzNejdXWAXhphBD1UoO9BKH49ecgnz8KcdORIzRvUOjBETuaxFJoA9hTDlYLmBuoRhmhr6B/2XrXmPsMpVqXEFHB+YyQQ+qykcm90gI2cwW4Tsrv70Kq/WKyHcm4t0B6n2e0IeFHxuadWFHjx9Ql3uFNG1eLPGB58YOaQDeYWhUliW2HzOKursekw+cYbhmfwxoaAfSXF5FpfieggcUHBVXxiLOxeipaDgoL8dovGATNZar9N3/fRfRm+yP+iRbERvQOYRB2PT+6+6zwBL4mP25QrT4FSzv8ZZDNSV6Bf3DifIQCNwJUBBIeWwBsuEkYpyAym4hgcmIricnMBIlE1GNOI3y5nnB3zXqwP7CxCi+YydYpNEcq7E5/RW+7kLx0b53Oc/i1PX1hibN/c8bdImZL7wmF9TVu4jQPozxEhQTGGvcSiMeQHAJRWRFOCmqAFE534Zmq1k6/PPzaBaE8lfm5WTnjJYpYttHSQMJubYaaqhcVsW2TR+6AGQ09lYf/EGQFwq7lqlUh3EdcaV3d2ZmTrTC8p6/LRLzuVTzDB4TX6BYy/cAr7T+KpTqvYLhXgV1Zz+DCfaxpPuVnO7BsQ3Rm9dVdtuFPD295K2iOgeULXluhMb12/IFQVglgBDKRHx31VKCGY6sr4wWUPqXnOoEF+oXn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(55016003)(316002)(54906003)(110136005)(2906002)(33656002)(38070700005)(66946007)(64756008)(8676002)(66446008)(66556008)(66476007)(8936002)(5660300002)(44832011)(52536014)(7416002)(76116006)(4326008)(86362001)(9686003)(26005)(53546011)(41300700001)(6506007)(7696005)(122000001)(38100700002)(83380400001)(71200400001)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3JsWXgfBHNBpsfdr9cjnBXvTpd2oXMKELP1LpJqox5cDbdo+X1hU2oMmA+yY?=
 =?us-ascii?Q?Lzj3DW9wfswf1w3g9eGJnTNj4tlzStQ4TA0e9dv7ljRC1lA+OOAGC0VtqYEl?=
 =?us-ascii?Q?gcD4Hd0iBSrJ/Jr4Kc8V4X/7pYhAnL4CMGZyuNGIkUywy2a3MLDaIHbP8PCi?=
 =?us-ascii?Q?rT0lxusOCMjoVpCTl87whWoTcMREtTluJXSb+ocYbGT5CJ8VqJkGfGXgavTN?=
 =?us-ascii?Q?1PVafaq30MKhSasr1u/NvXb6msTcIFgnpSpD/SEzu35TMZBxyaZsC5lZb0rE?=
 =?us-ascii?Q?tRsMP8bL7Psh2WVsfT16K0/IAPHGWupF3thnjSd3pv2Qd1LSCpU/b/nfklcv?=
 =?us-ascii?Q?ebSFtnJV+Yn7B1EsB1Kyqyh7mR9sv+GRo1MXYdKA2XlfDjsG95NrRYrZXsfP?=
 =?us-ascii?Q?2HZfeyMmH9fChKDykeGAjC+RpWzp+qQGNMvWbw43LK7C7wzFUNbW/EZ9QrfR?=
 =?us-ascii?Q?Q+rwrx84h4FjR24bQ/heGzfK/6LZXPv1gk3Z0g9oOm1cXq9Cc22D7W2qNRdN?=
 =?us-ascii?Q?lxgBPgcin66VJLj0jpMWJy/kkUP41snfbvaOZdxTolVExUeJukn+wl++ixWP?=
 =?us-ascii?Q?iiV5Kn85SXTqTFpcEdayrQOcUERIYmn7ghTeE5TRmWvREmjjMLT5RrlauXXq?=
 =?us-ascii?Q?zveaPUaodamTIgkBwVfSQoxcELlP1xXKV9agzHGansqwtuMKz6PW62E16xft?=
 =?us-ascii?Q?Ss5t7n/5pM80GK+uzLjA2XGkFO7fKnYxo8tgdFK6CMoD31dOZDX/2UVLePgG?=
 =?us-ascii?Q?LKubu9qJXkaG+F7NzOXdFn/M3v0WhC3S6bsLRcTve2wb4j4e7OuSsYxXinrd?=
 =?us-ascii?Q?s5+LzZAU/2/cJTJA2cgLEeKecycaMptl5Vv3Lkd8HkMUjo/B1l4ffWUnCgSf?=
 =?us-ascii?Q?uOYoTLI4kRfnVpfTsFg9RppFuOk7d416J+UHfS3Ytmvq7645LUEKBTFsKIcb?=
 =?us-ascii?Q?4amG3z+0fRNSDzwcR2+mKboWrvOA9+iKOescSAg95f5jjTy+L98lvIwGGqpn?=
 =?us-ascii?Q?YBH9Qx76tnF+IhkRALENmd9SWPpLSZVMYVn24HYzA1pC93h9gZJ77hGRbHKl?=
 =?us-ascii?Q?qQN5kr9cIemaGIq48OWPa80JoVXG1ZGVRn/y6k6nq+ifQWkGljITkLoD+0qF?=
 =?us-ascii?Q?Hb920oa5sq0FQs6V9GTHqIVsu+h+pQqi+mSZpoKBAhCWvfBQRSDI/6lO3Ivv?=
 =?us-ascii?Q?evL1//4WHWpyl1cOEgmep9XspEfKynxCwEf5JKszYdGhrNUIoyV2F3dFKCp0?=
 =?us-ascii?Q?x+idbMv4fAN2srvG8FoBK3dlMv9QCsGOUtl0jJv6+qO6/AC8HBnuWuXH7gYd?=
 =?us-ascii?Q?aI8IRaSWol8P600VfoQvz93Ho7nwGuIxo3Cu/SEOF2Jdr3FCVohxfEkqGY8g?=
 =?us-ascii?Q?6LscHGnTFMymXUXU6EB0cgvkdsn7blyLGuFNo1WDOhQ8dZcxNX2dC/XataiJ?=
 =?us-ascii?Q?MvecmFV5wC6LKN54E+87SiHN8JyiwpetC5lCT/0jdAuRJVkLHsfZOPMQCI2g?=
 =?us-ascii?Q?G9oN7qC1gFuiGK/h3lFYbuSFMSPlA0N5oqyEtuMmon4iT/fOOschPXfZapTT?=
 =?us-ascii?Q?aZwBcAWeceroHYv67pg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85170805-3771-4d52-bba3-08da7e9f941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 09:21:47.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXAf/9ZAtY2L65F/PqWmNv0Bpqhi3dDR3uQvtjEcxgmewhi9E4SqFE+HcJFBW+mrxtLzFG+R1+pOpjZPEuU7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

> Subject: Re: [PATCH V2 5/8] clk: imx: add i.MX93 clk gate
>=20
> On 22-08-15 09:30:36, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX93 LPCG is different from i.MX8M CCGR. Although
> > imx_clk_hw_gate4_flags is used here, it not strictly match i.MX93. i.MX=
93
> has such design:
> >  - LPCG_DIRECT use BIT0 as on/off gate when LPCG_AUTHEN CPU_LPM is 0
> >  - LPCG_LPM_CUR use BIT[2:0] as on/off gate when LPCG_AUTHEN
> CPU_LPM
> > is 1
> >
> > The current implementation suppose CPU_LPM is 0, and use LPCG_DIRECT
> > BIT[1:0] as on/off gate. Although BIT1 is touched, actually BIT1 is
> > reserved.
> >
> > And imx_clk_hw_gate4_flags use mask 0x3 to determine whether the clk
> > is enabled or not, but i.MX93 LPCG only use BIT0 to control when
> > CPU_LPM is 0. So clk disabled unused during kernel boot not able to
> > gate off the unused clocks.
> >
> > To match i.MX93 LPCG, introduce imx93_clk_gate.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile      |   2 +-
> >  drivers/clk/imx/clk-gate-93.c | 199
> ++++++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h         |   4 +
> >  3 files changed, 204 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/clk/imx/clk-gate-93.c
> >
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > 88b9b9285d22..89fe72327788 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -28,7 +28,7 @@ obj-$(CONFIG_CLK_IMX8MN) +=3D clk-imx8mn.o
> >  obj-$(CONFIG_CLK_IMX8MP) +=3D clk-imx8mp.o
> >  obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
> >
> > -obj-$(CONFIG_CLK_IMX93) +=3D clk-imx93.o
> > +obj-$(CONFIG_CLK_IMX93) +=3D clk-imx93.o clk-gate-93.o
> >
> >  obj-$(CONFIG_MXC_CLK_SCU) +=3D clk-imx-scu.o clk-imx-lpcg-scu.o
> >  clk-imx-scu-$(CONFIG_CLK_IMX8QXP) +=3D clk-scu.o clk-imx8qxp.o \ diff
> > --git a/drivers/clk/imx/clk-gate-93.c b/drivers/clk/imx/clk-gate-93.c
> > new file mode 100644 index 000000000000..ceb56b290394
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-gate-93.c
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2022 NXP
> > + *
> > + * Peng Fan <peng.fan@nxp.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/slab.h>
> > +
> > +#include "clk.h"
> > +
> > +#define DIRECT_OFFSET		0x0
> > +
> > +/*
> > + * 0b000 - LPCG will be OFF in any CPU mode.
> > + * 0b100 - LPCG will be ON in any CPU mode.
> > + */
> > +#define LPM_SETTING_OFF		0x0
> > +#define LPM_SETTING_ON		0x4
> > +
> > +#define LPM_CUR_OFFSET		0x1c
> > +
> > +#define AUTHEN_OFFSET		0x30
> > +#define CPULPM_EN		BIT(2)
> > +#define TZ_NS_SHIFT		9
> > +#define TZ_NS_MASK		BIT(9)
> > +
> > +#define WHITE_LIST_SHIFT	16
> > +
> > +struct imx93_clk_gate {
> > +	struct clk_hw hw;
> > +	void __iomem	*reg;
> > +	u32		bit_idx;
> > +	u32		val;
> > +	u32		mask;
> > +	spinlock_t	*lock;
> > +	unsigned int	*share_count;
> > +};
> > +
> > +#define to_imx93_clk_gate(_hw) container_of(_hw, struct
> > +imx93_clk_gate, hw)
> > +
> > +static void imx93_clk_gate_do_hardware(struct clk_hw *hw, bool
> > +enable) {
> > +	struct imx93_clk_gate *gate =3D to_imx93_clk_gate(hw);
> > +	u32 val;
> > +
> > +	val =3D readl(gate->reg + AUTHEN_OFFSET);
> > +	if (val & CPULPM_EN) {
> > +		val =3D enable ? LPM_SETTING_ON : LPM_SETTING_OFF;
> > +		writel(val, gate->reg + LPM_CUR_OFFSET);
> > +	} else {
> > +		val =3D readl(gate->reg + DIRECT_OFFSET);
> > +		val &=3D ~(gate->mask << gate->bit_idx);
> > +		if (enable)
> > +			val |=3D (gate->val & gate->mask) << gate->bit_idx;
> > +		writel(val, gate->reg + DIRECT_OFFSET);
> > +	}
> > +}
> > +
> > +static int imx93_clk_gate_enable(struct clk_hw *hw) {
> > +	struct imx93_clk_gate *gate =3D to_imx93_clk_gate(hw);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(gate->lock, flags);
> > +
> > +	if (gate->share_count && (*gate->share_count)++ > 0)
> > +		goto out;
> > +
> > +	imx93_clk_gate_do_hardware(hw, true);
> > +out:
> > +	spin_unlock_irqrestore(gate->lock, flags);
> > +
> > +	return 0;
> > +}
>=20
> Just wondering if we could use the existing clk-gate2 since we would only
> have to implement the ops that are different there.
>=20

I thought about this, but i.MX9 LPCG gate has a different design, it is
not i.MX8M CCGR gate. Although the first version of the i.MX93 clk
driver use clk-gate2, but it could not support i.MX93 well.

You could see i.MX93 gate API use different input parameters.

Clk-gate2 not support LPM(low power mode), AUTHEN(authentication),=20
WHITE_LIST(domain control list).

i.MX93 LPCG has two working modes, DIRECT mode, LPM mode.
DIRECT mode is a 1 bit control bit if LPM is not enabled.
If LPM enabled, LPCG use a similar way as CCGR domain bits

> Also, would the next i.MX9 platforms also use this? Or will we have one
> similar driver for each new platform?

i.MX9 series use same LPCG design per my understanding. I hope
there are no big changes in hardware in future, so we could reuse
same driver.

Thanks,
Peng.
>=20
> > +
> > +static void imx93_clk_gate_disable(struct clk_hw *hw) {
> > +	struct imx93_clk_gate *gate =3D to_imx93_clk_gate(hw);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(gate->lock, flags);
> > +
> > +	if (gate->share_count) {
> > +		if (WARN_ON(*gate->share_count =3D=3D 0))
> > +			goto out;
> > +		else if (--(*gate->share_count) > 0)
> > +			goto out;
> > +	}
> > +
> > +	imx93_clk_gate_do_hardware(hw, false);
> > +out:
> > +	spin_unlock_irqrestore(gate->lock, flags); }
> > +
> > +static int imx93_clk_gate_reg_is_enabled(struct imx93_clk_gate *gate)
> > +{
> > +	u32 val =3D readl(gate->reg + AUTHEN_OFFSET);
> > +
> > +	if (val & CPULPM_EN) {
> > +		val =3D readl(gate->reg + LPM_CUR_OFFSET);
> > +		if (val =3D=3D LPM_SETTING_ON)
> > +			return 1;
> > +	} else {
> > +		val =3D readl(gate->reg);
> > +		if (((val >> gate->bit_idx) & gate->mask) =3D=3D gate->val)
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx93_clk_gate_is_enabled(struct clk_hw *hw) {
> > +	struct imx93_clk_gate *gate =3D to_imx93_clk_gate(hw);
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(gate->lock, flags);
> > +
> > +	ret =3D imx93_clk_gate_reg_is_enabled(gate);
> > +
> > +	spin_unlock_irqrestore(gate->lock, flags);
> > +
> > +	return ret;
> > +}
> > +
> > +static void imx93_clk_gate_disable_unused(struct clk_hw *hw) {
> > +	struct imx93_clk_gate *gate =3D to_imx93_clk_gate(hw);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(gate->lock, flags);
> > +
> > +	if (!gate->share_count || *gate->share_count =3D=3D 0)
> > +		imx93_clk_gate_do_hardware(hw, false);
> > +
> > +	spin_unlock_irqrestore(gate->lock, flags); }
> > +
> > +static const struct clk_ops imx93_clk_gate_ops =3D {
> > +	.enable =3D imx93_clk_gate_enable,
> > +	.disable =3D imx93_clk_gate_disable,
> > +	.disable_unused =3D imx93_clk_gate_disable_unused,
> > +	.is_enabled =3D imx93_clk_gate_is_enabled, };
> > +
> > +static const struct clk_ops imx93_clk_gate_ro_ops =3D {
> > +	.is_enabled =3D imx93_clk_gate_is_enabled, };
> > +
> > +struct clk_hw *imx93_clk_gate(struct device *dev, const char *name,
> const char *parent_name,
> > +			      unsigned long flags, void __iomem *reg, u32
> bit_idx, u32 val,
> > +			      u32 mask, u32 domain_id, unsigned int
> *share_count) {
> > +	struct imx93_clk_gate *gate;
> > +	struct clk_hw *hw;
> > +	struct clk_init_data init;
> > +	int ret;
> > +	u32 authen;
> > +
> > +	gate =3D kzalloc(sizeof(struct imx93_clk_gate), GFP_KERNEL);
> > +	if (!gate)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	gate->reg =3D reg;
> > +	gate->lock =3D &imx_ccm_lock;
> > +	gate->bit_idx =3D bit_idx;
> > +	gate->val =3D val;
> > +	gate->mask =3D mask;
> > +	gate->share_count =3D share_count;
> > +
> > +	init.name =3D name;
> > +	init.ops =3D &imx93_clk_gate_ops;
> > +	init.flags =3D flags | CLK_SET_RATE_PARENT |
> CLK_OPS_PARENT_ENABLE;
> > +	init.parent_names =3D parent_name ? &parent_name : NULL;
> > +	init.num_parents =3D parent_name ? 1 : 0;
> > +
> > +	gate->hw.init =3D &init;
> > +	hw =3D &gate->hw;
> > +
> > +	authen =3D readl(reg + AUTHEN_OFFSET);
> > +	if (!(authen & TZ_NS_MASK) || !(authen & BIT(WHITE_LIST_SHIFT +
> domain_id)))
> > +		init.ops =3D &imx93_clk_gate_ro_ops;
> > +
> > +	ret =3D clk_hw_register(dev, hw);
> > +	if (ret) {
> > +		kfree(gate);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return hw;
> > +}
> > +EXPORT_SYMBOL_GPL(imx93_clk_gate);
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> > 396a5ea75083..dd49f90110e8 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -451,6 +451,10 @@ struct clk_hw *imx93_clk_composite_flags(const
> char *name,
> >  	imx93_clk_composite_flags(name, parent_names, num_parents,
> reg, domain_id \
> >  				  CLK_SET_RATE_NO_REPARENT |
> CLK_OPS_PARENT_ENABLE)
> >
> > +struct clk_hw *imx93_clk_gate(struct device *dev, const char *name,
> const char *parent_name,
> > +			      unsigned long flags, void __iomem *reg, u32
> bit_idx, u32 val,
> > +			      u32 mask, u32 domain_id, unsigned int
> *share_count);
> > +
> >  struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char
> *parent_name,
> >  		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
> >  		u8 clk_divider_flags, const struct clk_div_table *table,
> > --
> > 2.37.1
> >
