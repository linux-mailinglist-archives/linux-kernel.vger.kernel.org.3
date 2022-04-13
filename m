Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4944FFDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiDMSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiDMSlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:41:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BC5F8D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf/0du7sDZiaBJshym9WKiBUP3A3W6jLaH33GJeZpoucPlSWY+PvEXEEG4mzMR3sLDy3naNMH2WJ9ebcKvMcdVwGI1HROAq18CPmPpjaFgr58fYYl0gxE3Z0HdaS0UWI4MYgqLav1S/OIFkg/gsDzPk2TltCeVK5zfUTb9X/cDa5ulXMkGh7ApOcq01NpAsu04aB+oU6kt6iqfGfWPY2/c6HQe92fRgHm4OSZOvELbS7SHOiMI6Z1ITLw4pUMkN0cHCO2JQkJPMon/pqRNVrrNjFZ25ELPqV0R0CSieQgvkui3NSXG+CWlx26KCpnELRa+NDVdCKoDv2HHUsXgnmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJzdvfzVvvEG/xaBQa0puCoUL6wCtSrzaJ3UR7KAj/I=;
 b=TTZt7WqiC+qB9N29cYC4SLbFPWnjmkEXo6+pJhhkd8CC8CoHWE3iMWrGFuBX+3c6u5YjVp81OSmbHcesgbB63JyPB7L4g69tlVfzVUjDTGuXRpEAhS2QtqDNihuHIUYASsZBGRthNuHSaI/SeClYQXsgSzOUgFrywsLUZCMzXMdQL/XjRh3wdhrCjyN8eXUYrJ3LwtDM8iyqmbPdAh2CQ1YZVURylROnLFFSu3O6/9Z6gTWWipApfr+d9NuchfEODjbtrPtBdsZfVXQMJrhpqTQ5LNfx6FGrU1oQol8r+xM0ahmJnxZ46fRqC39kIPKVcPDgGTz4O5wZM2Yq+BdTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJzdvfzVvvEG/xaBQa0puCoUL6wCtSrzaJ3UR7KAj/I=;
 b=jb1xXAVynqOs9+lhoQnGkuXseJSn+3HXdhWK4aPBMDwboMGZP70ak3Z8JlN0qCBbsALTA7wDvXawYN2BGF0UbFIjZlFLlMDLnyB0tT2bHHRkV4ZKuzBVEgTaKwAHqeXvuyF9WF/3DMGnqWwMUkxppagEa5xG3kgPFe8H29B3oU4=
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13)
 by AM6PR0402MB3335.eurprd04.prod.outlook.com (2603:10a6:209:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 18:38:55 +0000
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8]) by DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8%9]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 18:38:55 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Thread-Topic: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Thread-Index: AQHX8M2PMjnmeEe/+EahWZj9h1xp0Kzuxm+AgAAXPtCAAAd7gIAAA2oA
Date:   Wed, 13 Apr 2022 18:38:54 +0000
Message-ID: <DU2PR04MB8949D8178E875088F39A058A8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-2-leoyang.li@nxp.com>
 <20220413163209.4pqqpyqdklhlzp5p@skbuf>
 <DU2PR04MB894975813DAC1043AAA23C5B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
 <20220413182207.chvdbqnmmm5vbz2b@skbuf>
In-Reply-To: <20220413182207.chvdbqnmmm5vbz2b@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40107011-84d2-4a61-3ab6-08da1d7cdd3a
x-ms-traffictypediagnostic: AM6PR0402MB3335:EE_
x-microsoft-antispam-prvs: <AM6PR0402MB333573C354E1543EF47CA6638FEC9@AM6PR0402MB3335.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of2qryGeIfJNjxFYNNO+xuoi+YQQN+Dl2o2QdFe9tIK8pAyquG7XexumFOeglnhkCA+UzTnO68TggcUl/uCvcnKqfsYSo/rgIb9kSmAS3SGGZSndir95z2asHiSlMP3SKIjeNXSjVYw6VYZXeyJcYgCZSZ3l7ev3JfmTDaYKYhTaX5yXT9lXrlNHx03wDYXYtk94nAHcXVYMuwtfRdJpUL/AZllf72eOb1lOg18QUi6mH3X6p84RP5T/UrO1wWa2iEKAk/+alGXBEzFpaGIUdktwOsPpNyMWweEAYkIm+AQvh7kUUMtG15tnUNW5MQoGIZXK7IC5lvV204z8D4qNXftYlzSwH20+Gy2jtWRtpKgJjZzQK8Db1ZiDZ3xdv5B8IwQpP4OMdO71dY6wlfrQXRtQAEVuN3qWUKBq6BRpgyHVQEOXeKIh9AEPM5vY92WdrdDoVivXJXlxatmEjjGsnW9pRcwSCLwfVVV+57nHWCXDPbcyLqCZvNMEjYD5op/nTY0BwSMSnEJ+56owE7oDswGzx4th6+L48ePiYi/CGXlphhQZiqp3w0YO65+bPZDjlnFI/eSOM7WtKUP8f3pGHdsrCwUDya0h23rvYKkiasfs0J9Slfhyt0UPXpXsj43yW9/GtactJnua5nk8VYRerWIkWK9XWjOuJGcDH1kwfqEip51zP7FDP3zR9UsHbaEWji7qyaDSoY15n/PvmHm6CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8949.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(55236004)(122000001)(8676002)(64756008)(86362001)(2906002)(9686003)(76116006)(52536014)(71200400001)(33656002)(8936002)(66476007)(38070700005)(55016003)(54906003)(66556008)(6916009)(66446008)(508600001)(38100700002)(4326008)(316002)(53546011)(6506007)(7696005)(186003)(83380400001)(26005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bPbAGQDRkL1XXYPoqKP1jZSrAHOjqtgVFIugHFndq8jcqeyxv3MfinCA/dJF?=
 =?us-ascii?Q?dp0Ki1BIVt/wX2Vnhbn0YsWqTFmHtfTyZqSwiv1IVDPszTRpb8sQi1D/A2UE?=
 =?us-ascii?Q?lBRILX9Vb81ZHfrLOm3Q7F1VKl5Ahjkst23zsW6jM7ZP8EFm4gYF8BEuWNcq?=
 =?us-ascii?Q?tgf0PxH1uZlpE3IYf59HU7MdZesYp8XBj4/4N/5/lONUCiPPxYMLGGLuSS+z?=
 =?us-ascii?Q?9tA1OGO03zaNunBRRKOUJNDkRBK4h849KFJTOcaNm9SwC7vG91Tw3BWqW1FT?=
 =?us-ascii?Q?f7bAvcig/aCD0IwthqJ620yXS/EkA79sH7EdfPJLZzRH2TyiVk+XXZG1DahA?=
 =?us-ascii?Q?T7If+SYPHTxDmhMCYhrf5+mhTA+wAB7Z22Ym9zekzJrey+BNszxpN2Bg0/VT?=
 =?us-ascii?Q?p3daRhcF/qpSPtjLOMQGLpA5qVVKA2YhYyXhSxFMKTgN2b/Fg0RKKdvuFQ4u?=
 =?us-ascii?Q?85Bac1bLyakoNqJCttkvqssGsQcBU3gfP0XGTgDAvp29XBA2KgvAVOmreqyV?=
 =?us-ascii?Q?UvP/iviW86IVBKKjgd+uerhbTexz7Qr/iAPZ8Ra6CBBeXmWQVQhFznRNBrdD?=
 =?us-ascii?Q?r5v6a9E9SMPw/Xz2ia1uvC3q4v97POWH5siOoBFpwrOeiSGDd5RdaYrG5s30?=
 =?us-ascii?Q?uWgbZ6vJMc2ly3IWHFOyMHf0jREFioZoO6p5dlPClI4IFu1gIzN6dpKeT3AG?=
 =?us-ascii?Q?mW1cTD7FzS0AZsD4qpRNOw0bhgOq+kfND5YslBs/lRBIgeEL3Le/Z6lFBbAg?=
 =?us-ascii?Q?40mhOQTMyUO7PrWprJ3usFg58ZGT+ol661ucD/YW1y7LWm/9CN76tyG2Le5U?=
 =?us-ascii?Q?iAKxmj9UGjHkiJHFpXfioGnoXNfVlb/nCED+pnlGiRBsvJKsS7ivhtwLf84E?=
 =?us-ascii?Q?xmp0Q/HoxJawpFuNTv9XJCKcl76ncAf9/XYftdMMWPpFv+Ff8wAGzaN8E+vt?=
 =?us-ascii?Q?uRzPwQtrfIiJIdTEUnWYahT7HFCJVcBAau3NbNfvUv3eplsRMv7JotyE2rfn?=
 =?us-ascii?Q?6bAosYGc/zMXdsNMAtsWzsg96m1mp3Nv8FcE9rrMEbuWmP2i/ytM/RwCv3bz?=
 =?us-ascii?Q?mqiuM2W8SO+7mK0vTpxmV/+cNEbslvtWMZaDoBmOTjqTxux+FdNnSB3n0if6?=
 =?us-ascii?Q?xll73HsLFigX9yYeZUpLhOXdVu2tmiPx1gYNCSJRHCcmANuDtkegQk8P+XLe?=
 =?us-ascii?Q?p+FUM/I6AtQPAfSAuuYoWO8PV/+bc6kFmahyBRsEtMaZLmEsejJYfbdEpNpK?=
 =?us-ascii?Q?fGh3tP3+WAj/R1Uf1oZ5vpWR0ELZ2iG9GEGoIj46dWNO6BIV9u8FK7YDOGED?=
 =?us-ascii?Q?dGSERv1GhRRsW85f/PNCOCWJgstLklpQS/GyOYRO4276ue87sWTFHEouDEbl?=
 =?us-ascii?Q?3FZ+hY/gEvGZOvy19RhpYAxmXiAiV7ItudyXAsE2FyaPYtgvoY8Zfo8FUWQp?=
 =?us-ascii?Q?fr1hOvvd/+7aitSLwXIf/WOebiVDQgJbcLUFi3isSce6TPjl/R8QluVvNsc6?=
 =?us-ascii?Q?4bUnLunxoYaXjq9jPRWd10+tPIDmWl2xX6QeSO4DNvQXNuE+wKQyisKbCJNz?=
 =?us-ascii?Q?4uo5N7Dm2twjwaCvWrMoUe9y62iqm+7h2RGwhStHyubK+MDcTpehsIht8FQp?=
 =?us-ascii?Q?2KWxWduwAsKSnLW+FrvQZgjHBNftwffkpDNY1jwAUIR3xW/1t4VO1aPivfEe?=
 =?us-ascii?Q?dyaE6VjjYxMtstGDFCzn4kpshR6G2WL8Cy0F4wz56CHPEMmIu8YwROsJ4hti?=
 =?us-ascii?Q?cQ9JIF1cHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8949.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40107011-84d2-4a61-3ab6-08da1d7cdd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:38:54.9671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmf8RLHn1AXHnL1KtBxetlw/76gzFd8MfWMFLkulqNYJp8i0V/G7YZz2hl8bGDrniyJegbHZ78iei4IGE+QBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3335
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
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, April 13, 2022 1:22 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Z.Q. Hou <zhiqiang.hou@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: Re: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
>=20
> On Wed, Apr 13, 2022 at 06:03:37PM +0000, Leo Li wrote:
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:631.23-656.5: Warning
> > > (unique_unit_address): /soc/pcie@3400000: duplicate unit-address
> > > (also used in node /soc/pcie-ep@3400000)
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:670.23-695.5: Warning
> > > (unique_unit_address): /soc/pcie@3500000: duplicate unit-address
> > > (also used in node /soc/pcie-ep@3500000)
> >
> > This would be a common problem for all the layerscape PCIe controller.
> > The controller can either work in RC mode or EP mode.  The current
> > binding of the controller defined two compatibles, one for RC and one
> > for EP.  Therefore the SoC dtsi will have two nodes with the same unit
> > address one for EP one for RC.  Fixing this probably requires
> > comprehensive updates to the binding which breaks backward
> > compatibility.
>=20
> So we have to live with these warnings forever now?
>=20
> How are the PCIe controllers configured for RC or EP mode? Via RCW?
> Is dynamic configuration possible?

Yes. It is configured via RCW on reset.  I don't think it can be changed at=
 runtime.

>=20
> Can't U-Boot detect the operating mode from the RCW and fix up the
> compatible string in case the controller is in endpoint mode?

I believe the u-boot is already updating the node status to enable the corr=
ect one.  But it might be confusing to change the compatible and a bunch of=
 other properties at boot time.

Regards,
Leo
