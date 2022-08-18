Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B788A597AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiHRAxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiHRAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:53:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BB2DDE;
        Wed, 17 Aug 2022 17:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFxDxQHhldIHFSqFyTy8Sk4tf+C/nEid4Gb9UZeUheAGmhQMqoiexQhXN89wBn2K+lX+qISYiu3MmVRq5wtS59guXrtRzGNjUtNw1l75k5hHXjPQC8vTKwdmd8kpfGgMBMrAA7NaZJznONWn/oK5qrWVZNA0QdDn2N3BaIu02fqzw+KkwCDDqzDa0srckencUdm+Ni+bmmO09hGhlQ6zgojZ28B0fImE25ditmfKOn+hmNV9foPNYGCsMJdWRyYAryUbEtD2zx0XbyyzU3z08y0wd7u47Outme5ibxminMHHgqvOjCPNXH30ltvyhauU79eDDOLY886rdVrbeL82sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKAXOZdSagVQD/rZUBa94nsXdu/8uCqF8m4SsKfboeU=;
 b=Eaop71o8Jh856nI1v5mCStzrh1SCrjxY2IybNyZUIJg/0Y3vUfW/+dNORE2KwIuE+zZou8PrsUo599jSdnnbWH8Oc/qkEBpdq5+SY7QzUroNLaqDKTqtukj7xKnYrdw0wCu7Frp0ZvCjLva2OkldIfEchrIbIGlt2OlrGu1R7B3KU9zeZ8vL9Yx7xHg/9K7lDJp/JSULwv0wpVAkY8yB4f3562q8N9o+IIcviX8fOkxiGfwZdS3rfc9+/pqQkmIuacQ4/JvRuFD4SnRNYrk7HbnFfU35yIkFUf2Uk4Gr4VPMVnhqEQJ14k9rqgI3AmiVGQqeMHVr6c3/W8qEzzhuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKAXOZdSagVQD/rZUBa94nsXdu/8uCqF8m4SsKfboeU=;
 b=lFDUciDIsZHAq5jLJyq2wgAxulgV5hwXw3Wp2c2/mDRDQ48lBO31dX4/suqWEeCnEBPgnAeiw7IRQ+Q5MibNMLuNDvjwF3kVckh/UX0gz/2xoiziUccvOdjrQjJqByTzfzsjnNkhJIZdpcIIDtfZ1/YihKDxnGouZiJAm0Y+VQg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 00:53:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 00:53:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings
Thread-Topic: [PATCH] arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings
Thread-Index: AQHYnoHKBGH3oKF7wUO17pIeB2bfi62z/MRA
Date:   Thu, 18 Aug 2022 00:53:17 +0000
Message-ID: <DU0PR04MB9417A328952B6D0B153A3F3C886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220723105005.3583860-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220723105005.3583860-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 514270a4-f152-4500-1568-08da80b409ba
x-ms-traffictypediagnostic: DB9PR04MB9353:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CX3W/DggZPOSmH/DSqXklXJHdb9SD0CZA14Mi3qfof87WIbg+8nOt7/GgOeowC6oYgIS/DAFK2ksUIZfUF16jAbBcmrbHcKGR+p7l+iM1TmbIq3Je5wAkclklQueDM/eaFWsO4T/+p55aCMncA8Gs8UaqvGPUcm6sD6aMWOB2I7wZOzqoKtC7Fe3doYqCIUSyMUx9wEdsS8ddGFi3HykuhvaKoOoSxqYICbhJrMJV+jiDM/7Y/OgkkvsO1FtIOJdbtOc5woEyeQNR06m76jDFPY/5af97c7mnA4PBXzShmrVPyH/QrDEm+f1YvmmOIKzFRcP6ZqKzn4F476YiBqc08HkyEZLFZ/G1YfaOwWFDzd+zRBSW3e30ob+fIdBq4X5FCUWVexL3eCAvJEa+eyn87kAlWZHkha8yAhmE270EGugsQJPw/iO6FF4QcyS/4vLrgiyRfr/cRcD7MbFj+GPqNGhdo0BNVUb9+thijiKqiBZy8M0DMPqR03zO3wVY9YecWlaefA1ZqOXJExpDp4o2JGkR3whDoxoROolzQ9n2Bz3B9MLxO/goxa/ng9U6NPCPbtuitweqXQwgDSsh7URVw0VH5eTAn2zWfeXGa5Pst8+8p6A6+sRXQ4w9OnSHkayJ6fhs2RlT4ZR+iHwMzrRDJrnvZYleEB51pd0zw3anxH1h+9S4vEuHe5nN4VWtXBFsYzjbrwMlNjzeQRyUZ+HHSaYc9k577O4mOUJaEeFkM6T8Oz2zpFfJjzoG39s5WebT6jXUchQPtfsB2IEAeA7jprj2wI9eXdEk3qJk8UDFr8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(38100700002)(86362001)(8936002)(55016003)(5660300002)(2906002)(7416002)(38070700005)(71200400001)(122000001)(54906003)(41300700001)(7696005)(6506007)(44832011)(110136005)(478600001)(52536014)(316002)(8676002)(66946007)(64756008)(66476007)(83380400001)(66446008)(26005)(4326008)(66556008)(76116006)(9686003)(186003)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cbYXMT++RWhMERPM+0eq/1r+7ZtnLBBF/hZP3cZi9/tZe7TF4ZLzszbQLkpD?=
 =?us-ascii?Q?bbkWvlbJeUlmlTK1xpwHHurhrroczgguzenYwqMJ5y8ctgDuOpkQiAy6ni5F?=
 =?us-ascii?Q?/qlhmFlo9LQKe2T/TTfaX7ZGWH2eYgOc/DKtCXt2BEk4bWVZtsB4L2i+VMju?=
 =?us-ascii?Q?KK8m4GxkNR6leBUSy0Sw2kShMJqEIyB+6d714JVVXaYsDtgKZcFwsLVBoyfS?=
 =?us-ascii?Q?5ShB9nNTexGSObLI7HH6MhFodLPDFrO6U6Xhji1zCQu4mvC/cpvMRdbLofHH?=
 =?us-ascii?Q?TxXs0qMPX4UuFHBLjFmSRXTCPeDilA73we/1xkCLUu4j53n7liACzMD8BLpv?=
 =?us-ascii?Q?b9AP1rS/4ncfnGp8zLDccgEanZkgBT+2zFoPwE02f4sTKIjrcIPPGwuZdekA?=
 =?us-ascii?Q?LnAwBYwTiJ/rf6Y+47qtzXNhX1QbqTZsbFJuzSVd5hgRI/kmy7k/8mCuPZJn?=
 =?us-ascii?Q?3BY3myUTMa63G0F2lbzijbCxhQXTlbvjqRBt0oa/YrWBGFvk6qY72/0jxc/r?=
 =?us-ascii?Q?QJSpqXMLZYSjwiz4opYrjYNzc4R3eAT8VyizWFCMz/cfXNvy7P4Gsh1T/R2N?=
 =?us-ascii?Q?zxbpUtsK+JFvCp/n1v7D4Rjc+kqnPhjxrL6J74mp9ypeTi/hnP7BQ7F8ZyNl?=
 =?us-ascii?Q?ilisUBxfxXQwR9Pn/Tdy8ODY9+gzGsLkfnZJzXjN7DXxepdk2WxWFjseJ9YO?=
 =?us-ascii?Q?qExMKOVuslk+qkoxOVQjG9iGL7TQHH2bDzz8GNxNyewSREIPgwKBqEy0r+ew?=
 =?us-ascii?Q?UcCPUT9wzvCT0E5n8NC5t/Am0HA9y0LV0JUxNCo+Nw97GHycfki4f/mTHkBf?=
 =?us-ascii?Q?IWwfVP6oKMxoidhtq4x1LzQItE3FPlumP0tw46kH7ChIuG4s3flhqiWNp0ke?=
 =?us-ascii?Q?ZMnIKtJYAy7+VH3KcvjwPVr7clHtGyXjCr0QNBrbnv8xXVp4FseTD8m3xcyE?=
 =?us-ascii?Q?5LkwtxkbqCDuHkVvDVq8UyiwlQWRVDALLmGRO3A0XXgfeb3rBs4pvCjJ7UVh?=
 =?us-ascii?Q?2KWUbTupX8HzM0qw8Lcnvme9ntMxDh161U71BJChXVr9VaHuTVaJAv+vKckR?=
 =?us-ascii?Q?yqeGalqEqGnuYmv6xGo5rnkGnzgc37rUbk8Bc3tZc8hhLMaX28koDb57CLUS?=
 =?us-ascii?Q?+XLxys7AgUh8YP29eX/EPIvuC+t5lcE7XTWiEK9oidnWZreP1hcKUI0AhenW?=
 =?us-ascii?Q?d6IiyWw3E3rJEB5b66ofdicZrU6kKFu4B+tG3aqnXM3t7abVVImvS9P90YI9?=
 =?us-ascii?Q?RK5ynvJsDsxZAijbOti/OJO1WaL11vnEi7hykVD/mKd87kWYMFIRf0pIXmIz?=
 =?us-ascii?Q?l/A9DEw0NkFP36KkhtF21ZlYyZzfWPz+EzUa8geklN3rpJX0pU3+QU6WUjuX?=
 =?us-ascii?Q?ttTwD3I9o3D8cQ2uWWWGECrteiyTi+hQN2jP36Ow9o9LmhtfcxXl71gfEB4Q?=
 =?us-ascii?Q?bQM/5WzaDRcei4YjGPpZNV3YE/4IAdDXcHTnnnxF+G868pvkkPgbl+BbwGoo?=
 =?us-ascii?Q?sVUKOjLa6vznfkjSyvqqhHBMiURlohyAufncbV42kv48ytpg6ETu1jR/oKee?=
 =?us-ascii?Q?OObQaajbYg+lW44Rm4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514270a4-f152-4500-1568-08da80b409ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 00:53:17.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZ6vk/DSJtuPtR6l3WUX9rHP7Xa3eo14QZRYeFny3dTUSKXFTbEf7cULgiTGgRPmw7oTqTjcAglfNODdaXjTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

> Subject: [PATCH] arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings
>=20

Got time to give a look on this?

Thanks,
Peng.
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The pad settings are missed, add them
>=20
> Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
> dts support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index 521215520a0f..6630ec561dc2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -770,10 +770,10 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09
> 	0x110
>=20
>  	pinctrl_sai2: sai2grp {
>  		fsl,pins =3D <
> -
> 	MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
> -
> 	MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
> -
> 	MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
> -
> 	MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
> +
> 	MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
> +
> 	MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
> +
> 	MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
> +
> 	MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
>  		>;
>  	};
>=20
> --
> 2.25.1

