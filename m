Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11558FE98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiHKOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiHKOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:52:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6F12634;
        Thu, 11 Aug 2022 07:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnmBXafpqpLx+ydRfrXRFPs+tx/2azoalFrzE3cczRJ4hgUOeLx1fjGZsad8HJZXzexKcjxvIbffA0XfeAAZV3lFBC/DiiRNZ8hMOWVv0pXB6+8A2Qz+VzkiAue9UuNS834IRXqhXXGm99jUymfXsePe+15fVopvTTDI0DaOG6vbSQQVZ8D31WiJs3bbPP0q5Dtbz1GGGhZq8az5xejlx+wqh3BscdTHQqq4TkPFwuatjPEEs5FgwCTM8GZxjQyzHxufRs3wE6dBBddXgsFxNHfMLhUvcHtaQiFt3jgbuliZ866zFkfA6j1i4bFzREnSCjaZYRuljElzQjSNhQ3A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+isUDi4xoOOX/PsNjuear99Vi1NPUDotC2ESswmEnZs=;
 b=Aj/mus5QYR1YDQuXIwS6Tkaf/CfwY+fpFPWvy6qVA8OAX07Lis9RMFoEYNgMAB29pAOD5u5pIwF0UudQ2QqA5BsTiUA+AdNVfdyBZL30QOApungOEGWZlGB3Xin8WcMdBp/X7B/ct49hgVq+pfZ2RjFBgwqDquLvRV0wPqdwMAGu2RZtxxuGueUqtyYVtY65c9ncEKFh56Dq3FEuR+JgiwoMlE+YVrpGQo38H43dVnoD0iLk0AFF/A9BnW2Qx9KXgZjt0vCB0vXxpAF0NZOxRiSZbHrcvbwttlOAxjstNA+rWQv2cLG/iNtSdDU2pChATsi/3v9FrI702DMNJppWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+isUDi4xoOOX/PsNjuear99Vi1NPUDotC2ESswmEnZs=;
 b=XIkCiaQGwf0FkV8GeUAzuU6inr5fhQle00hONo18vOHvAXF5y+p3ry4J5QY0yn5UfBUUcZM8tc9Ay1zuHEMPfDNOTq7mNDN8ngR3MdCKNSLGTLHgAsyD9Yy8ecuvHAhhkugxwtQ6NA9goONL24B0h1ph/IyYW61DXZTxZ1eR198=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB4007.eurprd04.prod.outlook.com (2603:10a6:209:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 14:52:45 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 14:52:45 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Topic: [EXT] Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Index: AQHYrX/efnr9amG8xk2M44gwbstyBq2pxDyAgAADc/A=
Date:   Thu, 11 Aug 2022 14:52:45 +0000
Message-ID: <AM9PR04MB82741882E177387DB95AE3B589649@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
 <20220811124135.95299-2-shenwei.wang@nxp.com>
 <db3020ef-7321-e171-b5bc-9c1795c2cced@linaro.org>
In-Reply-To: <db3020ef-7321-e171-b5bc-9c1795c2cced@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a72bf5f6-8417-401c-91aa-08da7ba9269d
x-ms-traffictypediagnostic: AM6PR04MB4007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8fSPTYE4H8FPlqY8q/c+pZ4kCJOmSzWL2q89itnKK3Gy4VBQER0bU+8QQayNdbRYB/TtUCr/4Fn9SeTCHwxg7b0fdqoVZyH6joPSOebZtDkJ6gZuXA2O64A+IAo4sJgfc8VPT4y+wLYLYNvMTYfz9b5B+QFJRigxB79dcmDUarKRTUDJhiZp1h7O+rDgZ0Qp11hqlH6DyPqtO3qgPIZ0ztlrcSUDcchuZDNckvbFwO49sRPLdAk7QetiVkchgSNqIKjMLmYz7bWW5dL4bNAhSHOYIaMkNquatZ81mhZECU+g+mBHhxZ/jHsJHSp/1r+Tsh9lfWUt1XCSodpc/bjykTL4Kv1RE99BSHsVNVAJdvac94CkW+m+qQuUP++WnrPZKmSVjXKwzo3e/hm5za8bTxYnuWQqFj7GM2IUUoXCNdG99AAHC8FXFxa05euqvGYLy1yx+JkEnyBwEVxANXh8TuwsLKi5u5enKo6njCiRa7FKzVucyRQHhM617Hi3+/HQ2/USPvO86dRGYFb6RL5epfn63X3RF1niSB3CluiKECr9chZYOi6k/HF/UoLo6dMSmxWKW/yb+4TNmym8cXBf45fqn/G3wfnn5wLiO5Nb22/uTHSSRdsvgmgsENTucWtnP0snDv+X9fXSXUUCHoXFYyGBLZzD2BFqlpE+TVUIefuxVjQ7zeZ93Xu5+OIsV8BCveiJnQRf2fqvBax/d9EsbCucmmGvecyxNW9l0pa2TsS344znTlm2ASSlKKqF2TmmaqE4xZnQVRVPjosVP3N3Vgs3uy65HZbT2IIMU+BG4govOC5tC6GTzCqmp7DJG2GuvQ5wBLcUUkq2QqkKMPJgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(83380400001)(6506007)(26005)(33656002)(55236004)(921005)(41300700001)(2906002)(38070700005)(186003)(9686003)(38100700002)(55016003)(122000001)(7696005)(44832011)(53546011)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(86362001)(6636002)(71200400001)(110136005)(316002)(76116006)(52536014)(54906003)(8936002)(8676002)(478600001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iwXDoUOiVsUq0i2EBaJwjWCJWNnPapxRGzOVlUh7l2i7r3AIrcCeZOw9h07?=
 =?us-ascii?Q?4Cd5l/h4Yc0ZzDkuNc1b4JBKQdlLKdrsAFRDqhtPrYSQyNycTOkIqG6Clthi?=
 =?us-ascii?Q?QazjQn7Vntm5EEQ7b8bgTcfv9Gk1afiwdDHl2r/U+N073lk8pxYzWd1+Scd6?=
 =?us-ascii?Q?wip8gJWOgp31/cyvIJt52FHz47CMesSjbRc0M8avVbkPedFyP2RzkRKCP3Kt?=
 =?us-ascii?Q?8Aoz3JqrmB4xr2QOPwR4NyvJwj4v6D9iS2k4fdy6iwMEaDq3WN/nEgOuk8MV?=
 =?us-ascii?Q?4crUi9dUs0+PzWHc+9hMngE/qxNS6hMsSkcguLkNhK5kmW0QyVXSxGksPfAF?=
 =?us-ascii?Q?LwmueVrxlCsJpboJtRTobfLq7MtnxELuThSu5D18zrGYAVb09uwq37aSywNm?=
 =?us-ascii?Q?tuiHj9RtmvOVRrf36aEGC17RflZX37sqhnsLcQ2icPtqukfqL6Hn55gkNHaZ?=
 =?us-ascii?Q?7NQMVl7gYqKRrrrLwW/Y74SH1XVFf8qJXw1lMWP//Ral/ZY5YqEkQWukM+iZ?=
 =?us-ascii?Q?heXmQuLAs5vmPtvF2I3Yxsz0WBrxvDQ2EzP9m7gR1WI4xfoNoBAh3ElGBZXX?=
 =?us-ascii?Q?G676oNzdDREOdpwGg0ImMxJOCgQw0HUdF24IO8T+9y4iAQT8BP0pPau05peQ?=
 =?us-ascii?Q?+K4ddllhTa/90JVHEWYVPXwJk/LIUp+g841pQYmawjMN0eXZYbGUuq4d/j4q?=
 =?us-ascii?Q?4rb4n8s4NQwcQC01e4pdt51lpC/DzRc8fbjBPHVTo0JZQMxEVdusnIkhiJ1t?=
 =?us-ascii?Q?M0gdep0xM7AfiaFSUOvo8v1v7UrA2JZ7/2GSv2ieSBVvdOoDdpkMj18ONzST?=
 =?us-ascii?Q?IDDWtIIz7TJPeRAtOshU4u/GZGovy7fRSjAOALw285vqJ6h4UVBKGKUVkUvP?=
 =?us-ascii?Q?GajRjavLDMxxaOEgBEijE/nTArdqh6uHNyyBtZGIsY8baLhj/b4M1D38C8ZA?=
 =?us-ascii?Q?VjPU6GY34BCmHYNWAkGLqlZkHJZ52kw0KiY+xZ2a6K0w4Dro7CMmFAASEAPh?=
 =?us-ascii?Q?YJM4sqmLZfzS2vn7//KdgNqwtMI+YT6Esgyi8qgjHG/elYA5As6NCH/PfPIP?=
 =?us-ascii?Q?OvjCB09wIMFZyp1wIImGkq38uY44IO1UwweZEpdYpgSjPF2LMGJZgznlXpqB?=
 =?us-ascii?Q?IDtFlSl+PFgf/sMN5HgJZt2fxfj39+WinGFsKe6HdJkIDGn8C3RoD9o/QQN5?=
 =?us-ascii?Q?AeNYub3nq3Ap4hRWGJaCsqQsEaSfaSkD1kkClMciFplwqR0pyFC923B+xN1X?=
 =?us-ascii?Q?kN4a2gXNKuZO4304AcwiVNeI094bH+HmO1AWpIGqUI0CL1UqtFz9dy6kF5SW?=
 =?us-ascii?Q?HeJGHqbMJpK/hFo5eiWeYkn08FtCjY3m5Nthf0CNuXp+Itq0iGJzbKmxWYwS?=
 =?us-ascii?Q?bAv2gfZCJEx10w3yzjBuYp4TDNIw1+zGSwwqXaxw9aTcM6BiDFeVQLJaweTM?=
 =?us-ascii?Q?uLtTZ4OOPABxQBQL+2zV2Sb37OOK+1fcNw7Sk6loSMxLWsx1MFGIePc5OJ0Y?=
 =?us-ascii?Q?m486UScNJ4i2souyrUZ2n89rOz3GdL2tmIe/kwWy9Asun+9eSPDY04PvnB1k?=
 =?us-ascii?Q?2sMEPilC3jcdKWdPEhNvu6cO0zPVQRwYqtDs/i7h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72bf5f6-8417-401c-91aa-08da7ba9269d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 14:52:45.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RtIbdlcdb8fPzVwnfdP4XXRXrDeCHFR9SLDwMhUT9Sw1WT23sB7iYW1ysJuJOJTOZF33XAtbjtclVyxa1B7XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, August 11, 2022 9:36 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linus.walleij@linaro.org; brgl@bgdev.p=
l;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.lin=
ux.dev
> Subject: [EXT] Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio dri=
ver
> bindings
> > diff --git
> > a/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> > b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> > new file mode 100644
> > index 000000000000..a1b024cddc97
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> > +description: |
> > +  This module provides the standard interface to control the
> > +  resource pins in SCU domain on i.MX8 platforms.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8qxp-sc-gpio
>=20
> Now the filename does not match compatible. Use the same compatible as
> filename.

The subnodes under fsl,scu.yaml have their own naming rule. For example, th=
e watchdog
compatible is "fsl,imx-sc-wdt", but the file name is "fsl,scu-wdt.yaml". Is=
 the filename required=20
to match its compatible?

Regards,
Shenwei

>=20
> Best regards,
> Krzysztof
