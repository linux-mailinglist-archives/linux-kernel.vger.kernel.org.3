Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3B5B036E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiIGLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIGLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:53:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755606716B;
        Wed,  7 Sep 2022 04:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiEC5X9JbdFvI0SHoJoiYkAEWuf1GeRGlsKqJkoKySS77JgCaoYtAYkQh+WvxOeSS9Y4rT2C6YneQcmEMDqFudJwzyuTQaqHXF0ezQihoYoHVrd7g85AW0ChFZk7+iPYiO+GPa/K6VJIUJBytw9NYFO3Ftk5prjcGPBcsRPJwUraF61hx5kgFgFwC7MOrkYuegRQza5waSWSSy3bgrBezp+IOGICBSukbZOOfAgNkG0Mr/kjHZ08H9D4wgtzeCqScqTaGxw3Fjpb1hmdh0g1yREC7bAsA80t3AYcbXKjgtoEhiQ5PyvR9ktRSBA1V5FyHQhBIoVxA5MU+Nce9Mq1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXUoUlJo7GCVe8nNp1SufpUpo2vbQOpw4RJQerKD3uo=;
 b=RuOMORakpoT8ktsEX95hp8TJRZmJDQk6KYNNHffdyGS7VglpMlP5NfzakVa8szL7iZsotdMdDFhpFTSjDW0c8R3PKkgOAoQiZLgj9Df/Uevlxr2NgEACn0maI3aGtWHYzHnfuqNqUY9MdT02YDVHbAaNWzKUc3YbJ4+XoiHG46DbhVACs87ab7aQWVkrO3jJKINfVmPmZx6Xh6nXMqypNS2ksR0RQLk+TBjPnaMGubGv9RHX/UiXAsx5+CtWDosGeJUwiX21aGfIXY8dVmydQwRRc0cqVSJOu8i6psqR017XgyinR0Q9ljXkvVRJSxjCcDfWF72meIk2dx53aWdd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXUoUlJo7GCVe8nNp1SufpUpo2vbQOpw4RJQerKD3uo=;
 b=jH/YmRfzYGV2VCqdvo0rEwj6t/yc9InnCWKtxuQaT4tBay+bZPLKQwmjdMxnQjxzI9yppIjIkHuAerJCXDYZxrx1pysX3wnYsnRel4Wx6QoNRv15p0UmSRg3xRMkJZ3puq+QpX094JUetZOlrN192rv0L8upwHjLI/IyQchXDzE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7634.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 11:53:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 11:53:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl
 HDCP/HRV_MWR
Thread-Topic: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl
 HDCP/HRV_MWR
Thread-Index: AQHYtfKfasmqvrEJqU+BhOPMGEGska3SkF4AgADKegCAAJkvAIAAAINw
Date:   Wed, 7 Sep 2022 11:53:26 +0000
Message-ID: <DU0PR04MB9417419FC095F8B1C525041F88419@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
 <2849448.e9J7NaK4W3@steina-w>
 <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
 <3198688.44csPzL39Z@steina-w>
In-Reply-To: <3198688.44csPzL39Z@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8560b8-27e9-4078-dad8-08da90c7930c
x-ms-traffictypediagnostic: AM9PR04MB7634:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdBEQbZCklnbpgDkJWz1pwH8OgfeTiQ2oNR5tGwug6w4v5Dp9EGQi9DFjcqcDNchIELrpBi8m0Dj1nM7tZnSibBghMjT4EXsyd3QEmsfj+wLx7+Ynt8RdZlany2S64ew9bl67nWs73WHRik6QtwcSuybmlw1lKbIcqXHpwI0LGL2QtY3/YKFUcVDnBCw8u3BpOlBxSveYbSNS57MxrZcesxTcFGSHHUvYWQFiFaz0WetGEn9fU7T8fzfTroXFNAGem37xqnbe1b9Xi88hqtTJbDeSMYRdHsB0B06cLaShespnAl2Ozj7zpcbXRoK5J86juLndzkk6hmhu1aSR9fwUA+hjOvw37EY7pkuMKr9pZhYkr31zpTEI02a8AvAY8VRoGRY9OOvhmZeynKAlBU5ZVIYqLh3pPFVDPwet4QkyhsoobEsgX4OuqZVi6kVa/jKY8s+VcKKY8klz8IAyZkjhOYFMZmF1b/WqJp7aSVn3Fk8YxKvT8fPM9ew7GDGoZCCUHiOZ4y9o5GAwIeFjjobad6lU0FkVM7LlK1W0F//0cgtoP5avWh71O3/pQMQINdwhHXFdflhjUSMDq6yJgnTPKaUu5yuzDfRkf6iHhhPDodbf6hBunPbj6vroMqq800aQcCVYcO0+hUqN5sh28FwxJWdz3Pj50JL/ifS2eC1aDSuRaazAuP4FR3jyfq+mGlTo11AOJc104y3qo6Q9GevhAqYYMcRhQM8Nft6psdXAMel8nJhusQ4IjzRs1+GUuUO2Dh5wGo0mgIgEHe8jtCLgS0fV0gyShzK89ZslIt0XWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(5660300002)(41300700001)(8936002)(52536014)(33656002)(26005)(9686003)(53546011)(2906002)(7416002)(86362001)(6506007)(7696005)(55016003)(38100700002)(44832011)(122000001)(38070700005)(186003)(64756008)(66476007)(8676002)(966005)(45080400002)(4326008)(54906003)(478600001)(110136005)(66446008)(66946007)(76116006)(66556008)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrinH3zY0Ii7O3IoB3O8N2TRDACTdVZh8fCvnBN0/FG/n+F/UDDZaC9y2Pzv?=
 =?us-ascii?Q?/mFllmkj6Gax8OxB7rOYKnTbe4j7+bHbuDXxsTzm/7c06eOYTBIpZKMndbpt?=
 =?us-ascii?Q?eQZxzTvfsppyXZA/KroSBaVoBtlWUI26LL2TVacA266yFBkDy85ITqFlCk0t?=
 =?us-ascii?Q?tmc2cqnQ6Hj7dujIrx8RAX7f7AvKfqFJqWMnQIvnmoVA/nUaXF8nhgEospSg?=
 =?us-ascii?Q?u9biSKtwbG7xoVnZSr7Gk5kJYWBSkcHpdWqIlAQjH6evwN+bZIg1Ey4BJPrT?=
 =?us-ascii?Q?0VN9QmKKIYPwPBsq2bzUcBolVq3vboTqUMnORNuO89TH/0VKuHJ52FQoi0fq?=
 =?us-ascii?Q?sEFrvXoRhFsui3vQ5Pa41aMt7v27VakJS1lwf0bYJ3zsELPEjx5hqUW7AqLB?=
 =?us-ascii?Q?tKWkFPHN+WlM19b7JZ1eeBoRloGfpuvucFOx9BJ9xffvd9SIIQ0mMG/dyjKt?=
 =?us-ascii?Q?rFercHIVeEN3mD39jhg4agP5gpHj5O6GrenG57UIqAonD4BJnk2n3r/zYRxP?=
 =?us-ascii?Q?S2yE5Xx3pq4mbxInAZvh4VB8DuophpZ0K9SMRT9bOASF+fXEasMNtxG9ml/g?=
 =?us-ascii?Q?DTDu/0fs7nVKMnymdM/GpeFvSItvpQtYuufeqs47OUMSjGVmPSd40K/1MgSf?=
 =?us-ascii?Q?9S8nDAV4Wd4/So1kNC/1QL+XH6nI0NZ8BvLiXTlCa4ujbYWYjKCvCWVJMXQz?=
 =?us-ascii?Q?HbMwSbfHvQXQnlXN3IeCHZJnaUl8ZMsWGMz3tKpGhmVu1vYuwfM6FuMRA3Ph?=
 =?us-ascii?Q?npFFoGw95OWwFnJjgJHtAUpMRnOJaK48u1Kj7Awg/bSsoEVMLK8fWEJarBTw?=
 =?us-ascii?Q?6VC2k3lGWaON5oRbSi7PSB6YWexpT8iPv3M4ppuAJOoo+veWBu1lnExjsuGv?=
 =?us-ascii?Q?ORbDQ7yoEY1VXMJYk9bmSTT2WDnRIxWviQVSpQHk4uf0Ayu1fVrcp8QpVwLI?=
 =?us-ascii?Q?7Ga3Lie2Z+mi5FMRBhgvASs1BkDofbnAoLjblj+xpyR5yd1YvcbVpM21xEPj?=
 =?us-ascii?Q?5/CUB/t2Tv3EuVQkzQX94HCCKfDgu9lz1AF9K+WgOKqfWtLO8EtWP6ymgAjv?=
 =?us-ascii?Q?lLxojooL689pX6jbfl5WfxfXIdMg0Q3ISVjLHquQBjnQoJbaZCR/jdwxi7GF?=
 =?us-ascii?Q?U0L4tFliUcM1OlnOMLDqephrG7XCX7PvkgoKRu/dTIkTgVXgOD5HQoBrs8g3?=
 =?us-ascii?Q?9qhr0b0Ni2nBbenrKDzVcQGTRjFL7WDe/EiJcxa+hF2tEU/wZOJ+2atbIwP4?=
 =?us-ascii?Q?6Cp8KjgwtvW1kR+V8VbggDULGQp19totWcI0/SV0G3LxjrRTlQVbHByitG8K?=
 =?us-ascii?Q?TAmDhbSsCacwVWt8C1XJ21cmfmlZwpXF5nwNAHnJAYFeOH6gqNftlI0Gj7Z2?=
 =?us-ascii?Q?cJjukz+5EKze42NkNzoxsj+lIHbCGG3f5gtIr30vX7nkgz3x6DarcyDUIckS?=
 =?us-ascii?Q?nLuhsDSorjN/JAVxxjwu0VB8eaODfbfBuDlgmmKrSaxqjH+8RuI5LMPgSK3l?=
 =?us-ascii?Q?WiZntYrVPPN55iyRJb7sX4YtIWeURmcjNAr2H/DaiGpFF34GxC+xDaASe9lK?=
 =?us-ascii?Q?n0xtX/W47Hr/YsCiOlOhB4WBtEJsuTWQBJRUPoVV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8560b8-27e9-4078-dad8-08da90c7930c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 11:53:26.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3P8xQSmnjI5T/H0PkLxei2dL3ECQkE2Q/hxAgHy6ZVDmXvyMMEideGlAg9WCY94rPgIYXpyPBdmogf2M+nf9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl
> HDCP/HRV_MWR
>=20
> Hello,
>=20
> Am Mittwoch, 7. September 2022, 04:41:46 CEST schrieb Peng Fan:
> > On 9/6/2022 10:37 PM, Alexander Stein wrote:
> > > Hello,
> > >
> > > Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
> > >> From: Peng Fan <peng.fan@nxp.com>
> > >>
> > >> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video
> Memory Write
> > >> Master for RXRX validation), so add them.
> > >>
> > >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >> ---
> > >>
> > >>   drivers/soc/imx/imx8mp-blk-ctrl.c | 30
> ++++++++++++++++++++++++++++++
> > >>   1 file changed, 30 insertions(+)
> > >>
> > >> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > >> b/drivers/soc/imx/imx8mp-blk-ctrl.c index
> > >> 6f983adcb47c..527d45d12a54
> > >> 100644
> > >> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > >> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > >> @@ -235,6 +235,13 @@ static void
> > >> imx8mp_hdmi_blk_ctrl_power_on(struct
> > >> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap,
> > >> HDMI_RTX_RESET_CTL0, BIT(12));
> > >>
> > >>   		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0,
> BIT(3));
> > >>   		break;
> > >>
> > >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> BIT(11));
> > >> +		break;
> > >> +	case IMX8MP_HDMIBLK_PD_HRV:
> > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> |
> > >
> > > BIT(4) | BIT(5));
> > >
> > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > >
> > > BIT(15));
> > >
> > >> +		break;
> > >>
> > >>   	default:
> > >>   		break;
> > >>
> > >>   	}
> > >>
> > >> @@ -283,6 +290,13 @@ static void
> > >> imx8mp_hdmi_blk_ctrl_power_off(struct
> > >> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap,
> > >> HDMI_RTX_RESET_CTL0, BIT(12));
> > >>
> > >>   		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1,
> BIT(22)
> > > |
> > > | BIT(24));
> > > |
> > >>   		break;
> > >>
> > >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> > >
> > > BIT(11));
> > >
> > >> +		break;
> > >> +	case IMX8MP_HDMIBLK_PD_HRV:
> > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > >
> > > BIT(15));
> > >
> > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> > >>
> > > | BIT(4) |
> > >>
> > >> BIT(5)); +		break;
> > >>
> > >>   	default:
> > >>   		break;
> > >>
> > >>   	}
> > >>
> > >> @@ -365,6 +379,22 @@ static const struct
> > >> imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] =3D
> { .num_clks
> > >> =3D 2,
> > >>
> > >>   		.gpc_name =3D "hdmi-tx-phy",
> > >>
> > >>   	},
> > >>
> > >> +	[IMX8MP_HDMIBLK_PD_HRV] =3D {
> > >> +		.name =3D "hdmiblk-hrv",
> > >> +		.clk_names =3D (const char *[]){ "axi", "apb" },
> > >> +		.num_clks =3D 2,
> > >> +		.gpc_name =3D "hrv",
> > >> +		.path_names =3D (const char *[]){"hrv"},
> > >> +		.num_paths =3D 1,
> > >> +	},
> > >> +	[IMX8MP_HDMIBLK_PD_HDCP] =3D {
> > >> +		.name =3D "hdmiblk-hdcp",
> > >> +		.clk_names =3D (const char *[]){ "axi", "apb" },
> > >> +		.num_clks =3D 2,
> > >> +		.gpc_name =3D "hdcp",
> > >> +		.path_names =3D (const char *[]){"hdcp"},
> > >> +		.num_paths =3D 1,
> > >> +	},
> > >>
> > >>   };
> > >>
> > >>   static const struct imx8mp_blk_ctrl_data
> imx8mp_hdmi_blk_ctl_dev_data =3D
> > >>   {
> > >
> > > Something is missing here. Iget the following error during boot:
> > > [    0.886211] Unable to handle kernel NULL pointer dereference at
> virtual
> > > address 0000000000000000
> > > [    0.895043] Mem abort info:
> > > [    0.897841]   ESR =3D 0x0000000096000004
> > > [    0.901606]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [    0.906942]   SET =3D 0, FnV =3D 0
> > > [    0.910003]   EA =3D 0, S1PTW =3D 0
> > > [    0.913159]   FSC =3D 0x04: level 0 translation fault
> > > [    0.918054] Data abort info:
> > > [    0.920943]   ISV =3D 0, ISS =3D 0x00000004
> > > [    0.924791]   CM =3D 0, WnR =3D 0
> > > [    0.927761] [0000000000000000] user address but active_mm is
> swapper
> > > [    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > [    0.939749] Modules linked in:
> > > [    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
> > > next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
> > > [    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on
> MBa8MPxL
> > > (DT) [    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -
> SSBS
> > > BTYPE=3D--) [    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
> > > [    0.972823] lr : dev_set_name+0x58/0x80
> > > [    0.976674] sp : ffff800009c7b860
> > > [    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27:
> > > 0000000000000150
> > > [    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24:
> > > ffff800009ab8958
> > > [    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21:
> > > ffff000000225410
> > > [    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18:
> > > 0000000000000000
> > > [    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15:
> > > 68203a656d616e3e
> > > [    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12:
> > > 616e5f6370673e2d
> > > [    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 :
> > > 7274632d6b6c622e
> > > [    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 :
> > > ffff800009a240e0
> > > [    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 :
> > > 00000000ffffffd0
> > > [    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 :
> > > 0000000000000000
> > > [    1.051749] Call trace:
> > > [    1.054199]  kobject_set_name_vargs+0x10/0xd0
> > > [    1.058574]  dev_set_name+0x58/0x80
> > > [    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
> > > [    1.066534]  platform_probe+0x64/0x100
> > > [    1.070297]  call_driver_probe+0x28/0x140
> > > [    1.074322]  really_probe+0xc0/0x334
> > > [    1.077909]  __driver_probe_device+0x84/0x144
> > > [    1.082284]  driver_probe_device+0x38/0x130
> > > [    1.086486]  __driver_attach+0xac/0x244
> > > [    1.090334]  bus_for_each_dev+0x6c/0xc0
> > > [    1.094184]  driver_attach+0x20/0x30
> > > [    1.097772]  bus_add_driver+0x174/0x244
> > > [    1.101622]  driver_register+0x74/0x120
> > > [    1.105474]  __platform_driver_register+0x24/0x30
> > > [    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
> > > [    1.115009]  do_one_initcall+0x58/0x200
> > > [    1.118861]  do_initcalls+0x164/0x19c
> > > [    1.122534]  kernel_init_freeable+0x134/0x17c
> > > [    1.126909]  kernel_init+0x2c/0x150
> > > [    1.130411]  ret_from_fork+0x10/0x20
> > > [    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000)
> > > [    1.140127] ---[ end trace 0000000000000000 ]---
> > >
> > > Adding some debug out shows:
> > > [    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev:
> 0x0
> > > [    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: hdmiblk=
-
> hdcp
> > > [    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdc=
p
> > >
> > > AFAICS the power domains 'hrv' and 'hdcp' are missing in the
> > > 'hdmi_blk_ctrl: blk-ctrl@32fc0000' node thus resulting in a NULL
> > > pointer from calling dev_pm_domain_attach_by_name().
> >
> > The HDMI blk ctrl dts not landed in Shawn's branch, could you share me
> > your dts change?
>=20
> I don't have any dts changes for this matter. To get a bootable device, f=
or
> now, I just removed the IMX8MP_HDMIBLK_PD_HRV and
> IMX8MP_HDMIBLK_PD_HDCP power domains from
> imx8mp_hdmi_domain_data.


Ah. There is no hdmi-blk-ctrl node in linux/next tree. Anyway, let me
have a check.

Thanks,
Peng.

>=20
> > And dev_set_name, as I recall, Lucas has a patch to remove that.
>=20
> Is this removal a fix or just a workaround?
Fix:
https://lore.kernel.org/all/20220826191305.3215706-1-l.stach@pengutronix.de=
/

>=20
> Best regards,
> Alexander
>=20
>=20

