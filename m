Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83F4FFD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiDMSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDMSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:06:03 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20072.outbound.protection.outlook.com [40.107.2.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF944767
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeZdKUM/XVC8atvJNlJPaSUdCxQOyIZEDIerCEccHPHL1se8yGERUl11Ro1T2Ox8pIH/4ZMP43mz24mAr0GPA8qglPMB3TX+DzbYgt6m/Z5rCp/+VgOXIVLLtQu+XzdPfIUMu3HKfmDK4Xa93cqLDlmCObZ/QAVNjttg0wpGj8axoa3SkzM5AX7mfREwpY/e7s5Jpn1kQ62QR71N6g9t/+BtSerwmLDAKFSib8MopLTj91YYy1vQYYdFyDg7cVB19AN8xWr8FRLvs3cuL1mPRfZ7kbQGhqiHOFpLA1SLehPy8z6oP/9B1wwSzpvHCU6DPI/O+KLN+TpkdUe75cZqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI7m7wPLzudCnFOwflw5lofgcuna9ZPkrGdUOwu6ZvE=;
 b=KTb3jpZ3M0gKSA3dMkm6wlOZthjO7VHoLV+soBY3VJAKVuLBsGEpa6NMwEdYuK1jtmbKJjDpuB9aEmlRELlyUX2y+n6VygrIOLw66qjZsAyXnhvCUDJ792IMfxEqgdJUEHPBh4WFkFKQkkKrZrWXRXlXdBNizbX5mLLpCoTwFNWMYjoA3OYtOeV8HThNqEjBT/doG0rXMNbCrI8QpJKxrYcwDE1ZeKqsLdVWQMLX3b7vVYd1hIbNTXvidNk2zknJ119gjWrfBtGo/wZL61DWFXZgE6Tcatba5Qe0M6z/OkS7b6XofWqF+sQ6qBaoEOdgK38BaGd3QaaZiiXd0pEa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI7m7wPLzudCnFOwflw5lofgcuna9ZPkrGdUOwu6ZvE=;
 b=bRU5Ip7bcPh+CQzQP5wBnxGRlHcfhD5yd+fzMdxLqHFVV+6KJ2Xy/X3KGAtFyirZdY8ZoXFPYeXtLUjSjVhhMDHr1TzhA9uMXviPUek/io0Z2+0YtyCfR/KlvokQ0Uhq5g0moeZCxjEeY0Dz63Nm1Z2ABIxVjzVST3ur354OnsY=
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13)
 by AS8PR04MB8214.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 18:03:37 +0000
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8]) by DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8%9]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 18:03:37 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Thread-Topic: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Thread-Index: AQHX8M2PMjnmeEe/+EahWZj9h1xp0Kzuxm+AgAAXPtA=
Date:   Wed, 13 Apr 2022 18:03:37 +0000
Message-ID: <DU2PR04MB894975813DAC1043AAA23C5B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-2-leoyang.li@nxp.com>
 <20220413163209.4pqqpyqdklhlzp5p@skbuf>
In-Reply-To: <20220413163209.4pqqpyqdklhlzp5p@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c51e8d8-2fe5-465b-319f-08da1d77eedd
x-ms-traffictypediagnostic: AS8PR04MB8214:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8214B77748C50982635C061D8FEC9@AS8PR04MB8214.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz354SSAhzs87VemUfrLMdrvn6sF82mMH2W5IWbHp6/xR4gAKevQ5V7+/lQX60gMOJY/7Lkk5AXrMai/MnFmMyU/GYxo6hCU6AzhKiTFXs5Su/B31t7Rcgpb9vFkBIxXUOLUoDhetSiEkhmls12iEDd5ApUklXfZQC8IXC3Teox0Fy7hEnpqXQK1Ie2wRud2IEv62K+/18W44XvrsuVSqqNGmnoOVhJue881WbpHHVkPl587VUIpSiSvHkr14pGpPjh6Xy+hX6n1KFOFdPC0HWZ0Tpqbzx3lOxnpyt2PQfrHoJb2o4E/73qQ2nXOMH6L8COTrd5veWC41tWSJySics1j1K83IPDrFD5kD/te1+2hyp8HXJzNLoOBkp51Z1LdJr9O7t1bsVNkjpanwHb2LA133FiGPCF3uFxMzmRATYtVZGoJFKPPC5pO93eH9zBFOo25XTrAjMJ2vosl31rSi/rfoOcAD7QTWuIpEl++bc0k05WEvDMYcc83InJl14aHqUUJKzMiX68fwq4RIcys6o1u9c5VuXo82WnDqj/T3wn1HFFTRsED8B2XjDYAuQLel76N3zU8kYR7MPyAWQSmFZXSXBCbuyhNWD1Tbx92mQqg7VXzRD7XQ+7esrHGAUBn0xAx8gFLgeuMYD1rCH+0RBoMgQg+ZZC15bgi0PtNZ5rlMuQl9kHHWW7rkXl4qo/1CqHbN9KUSTmJ7XOI9ZOuPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8949.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(38070700005)(71200400001)(9686003)(55016003)(26005)(186003)(4326008)(8676002)(122000001)(38100700002)(33656002)(83380400001)(508600001)(54906003)(110136005)(55236004)(5660300002)(53546011)(66476007)(76116006)(8936002)(66446008)(52536014)(66556008)(86362001)(6636002)(6506007)(7696005)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZV0mfifOBuBIknCx1xx4bl28nFDBzEazcdGDrDSxTS5w6z+fLbZcaWXt12bM?=
 =?us-ascii?Q?JVWLTyG163CAF2wOR7JIRsqjjNeF1/fnDGsVG0RXjMOUGkH1upC506AZXicJ?=
 =?us-ascii?Q?cGXQOrqkzXRkel9+j+JeFETF1sC4JSA5ZcAHk4Wo96iGw/Y5/CxnQUwb4pIn?=
 =?us-ascii?Q?5yP+UKPWS8qLGKIxy7/pWK23hS+LylYtLOHDzgfI7rExakBFs2bHjFtgEdnT?=
 =?us-ascii?Q?her1DH7jrdGjtFYk083mwH+SSoX6G7pJtXrizkY4G2262xm8c5W1nHLX270U?=
 =?us-ascii?Q?MgwX72pPQ7lC1FaCoVg2z91TQazerNZhflA/QUjdqtNE/wqSRTpLHFBjmrNl?=
 =?us-ascii?Q?TFkUJsvHeehXwp2hnyhdZGWWlVbGIPkrpQzNJSuMsC4c2fgF2UCotJgCWyaq?=
 =?us-ascii?Q?FNtp8Xq60N9V5eCpuYPdGWW+YX0tv7QODpT5ql+AhqSt64UFNAUCAgs3PYL/?=
 =?us-ascii?Q?adI+k45GAGd8rY8OHD0lOdl+CTebyJ3FELOCCwOdF+sKZ0hgQrqeKF/h48kY?=
 =?us-ascii?Q?UYck9Vw3ythJSVmmjzrjUyTMpxqYpATMkMdhZlAIXg56hXw17P/GP2w8Lc3H?=
 =?us-ascii?Q?Z0ASlpQu2ImgYv3SlnP5kP/Sn9Q63Lm0RgvyUevU3lnHhkdFnyYVozzqNjnu?=
 =?us-ascii?Q?t0JvVDbka/Iy8MnzQLvP4LFH4yiHvCD+ngkV9nh59O31C5LUCw5ty8wIKpK8?=
 =?us-ascii?Q?RC10MYBNXGjv40Of6ZwOgTUMrlQ55bNSJF4FW/oWxBPvnL4axN4xzXX0VLrD?=
 =?us-ascii?Q?GS63bQokFuQ4LIrr+7+XPKREQlUrOI7umejV4032F3V3fbj+2N+aEHXn6P72?=
 =?us-ascii?Q?e28jjQrH5HTATZUvq78oc/8pXpCBkg47J4+sdktfByuzTq4C4OkltwtBZYH2?=
 =?us-ascii?Q?2qwzoL7g4ntdmpme8UQP9qF0la7vsA1m9SK3aHAltyCs3uRPYvMNxWYNb9HN?=
 =?us-ascii?Q?brsx6UhpaPMe67I1Uv8qCesQ75OC1TqRzjYpbXP1G6nLAPugjjbsf6QX8h1w?=
 =?us-ascii?Q?SEnhhSWivUbQYwL8sOdsM9hDkMiFjNwYlTlpvXAALAeGeRwjdVUZAv3vhiLh?=
 =?us-ascii?Q?Uxzd+J3dFF/z8Th4Pdp7yzCPByAjByy6Le4totMWxsKk2p1vdrxLqF2c8SRc?=
 =?us-ascii?Q?ZVnI1f/DfKfA6V7Ovr7ms69G0S8EB7m2jpCOMzshxCzIo2v2/dOvOqO1MkKM?=
 =?us-ascii?Q?D0WO71EplGviGxcenscw4fSUOXeRl0tAmR6xRt9SerQkq4Qz02CdFmg2Javo?=
 =?us-ascii?Q?W+3iPnq6XIIxVJPwQKbNOIsRJCEWAD7ymsK5gR4Dy4oON+gcESZOWFwn9XhO?=
 =?us-ascii?Q?HcJXZaW1GvyA/V/VXcwrCmeGK9D0NUunAaCJFY7TRnTAo05qjThIEVF9dEjM?=
 =?us-ascii?Q?krFc+5UtT5VEwSkv1HUggK2PFu6p4YnBMIVts3uqOZM97CD0GnI3USlrFnTX?=
 =?us-ascii?Q?dhyELJJzcz9bIku31jqR8i0weguSGahFjG9fZmKh8sX3RYKJcfTzZdYUccrq?=
 =?us-ascii?Q?BS0hZD7FP1pSBpcSjlfqOSZsVCb42a7FVIIlz1996vwhkyAJVT3MzlkAImAb?=
 =?us-ascii?Q?W1iXVJ2w3kVFccqJa7rTbfGRDksXMiQPaxyi2OEmoCos017QzVZYgqFEX0nv?=
 =?us-ascii?Q?5DUkdBpbMMNJXQMPstUr2C7F0uWsL/tHSDKtvvyod1G927r9nJa8DBbl0GRv?=
 =?us-ascii?Q?JHm2UsVtrGQMk6VhRli7MCbcS0QO1X0N7fnLmTICrnFJFAl2wiLFVwTB1zBb?=
 =?us-ascii?Q?DUbEu9XaWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8949.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c51e8d8-2fe5-465b-319f-08da1d77eedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:03:37.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUqcncZzEUvZOt07ec085PcPaw2B/GSwr9TKJKuPlIjD29CU4R40o6zj50+1DJLn46rsTKgdHH6wTgyvIg9CFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8214
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
> Sent: Wednesday, April 13, 2022 11:32 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Xiaowei Bao
> <xiaowei.bao@nxp.com>
> Subject: Re: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
>=20
> On Tue, Dec 14, 2021 at 03:32:33AM -0600, Li Yang wrote:
> > From: Xiaowei Bao <xiaowei.bao@nxp.com>
> >
> > Add PCIe EP nodes for ls1028a to support EP mode.
> >
> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 24
> > +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index fd3f3e8bb6ce..9010c535252a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -637,6 +637,18 @@ pcie1: pcie@3400000 {
> >  			status =3D "disabled";
> >  		};
> >
> > +		pcie_ep1: pcie-ep@3400000 {
> > +			compatible =3D "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> > +			reg =3D <0x00 0x03400000 0x0 0x00100000
> > +			       0x80 0x00000000 0x8 0x00000000>;
> > +			reg-names =3D "regs", "addr_space";
> > +			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> /* PME interrupt */
> > +			interrupt-names =3D "pme";
> > +			num-ib-windows =3D <6>;
> > +			num-ob-windows =3D <8>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		pcie2: pcie@3500000 {
> >  			compatible =3D "fsl,ls1028a-pcie";
> >  			reg =3D <0x00 0x03500000 0x0 0x00100000>, /*
> controller registers */
> > @@ -664,6 +676,18 @@ pcie2: pcie@3500000 {
> >  			status =3D "disabled";
> >  		};
> >
> > +		pcie_ep2: pcie-ep@3500000 {
> > +			compatible =3D "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> > +			reg =3D <0x00 0x03500000 0x0 0x00100000
> > +			       0x88 0x00000000 0x8 0x00000000>;
> > +			reg-names =3D "regs", "addr_space";
> > +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> /* PME interrupt */
> > +			interrupt-names =3D "pme";
> > +			num-ib-windows =3D <6>;
> > +			num-ob-windows =3D <8>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		smmu: iommu@5000000 {
> >  			compatible =3D "arm,mmu-500";
> >  			reg =3D <0 0x5000000 0 0x800000>;
> > --
> > 2.25.1
> >
>=20
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:631.23-656.5: Warning
> (unique_unit_address): /soc/pcie@3400000: duplicate unit-address (also
> used in node /soc/pcie-ep@3400000)
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:670.23-695.5: Warning
> (unique_unit_address): /soc/pcie@3500000: duplicate unit-address (also
> used in node /soc/pcie-ep@3500000)

This would be a common problem for all the layerscape PCIe controller.  The=
 controller can either work in RC mode or EP mode.  The current binding of =
the controller defined two compatibles, one for RC and one for EP.  Therefo=
re the SoC dtsi will have two nodes with the same unit address one for EP o=
ne for RC.  Fixing this probably requires comprehensive updates to the bind=
ing which breaks backward compatibility.

Regards,
Leo
