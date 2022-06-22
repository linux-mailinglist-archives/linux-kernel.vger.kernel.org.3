Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4AD556E89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359631AbiFVWeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiFVWeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:34:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A6628E3B;
        Wed, 22 Jun 2022 15:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVmye4RpAtaqRI5DvqSbmUm9CcNmXyX75Q3tcd7O30ViRBUvVC5hTFpZ9IZuBTpNxy8oRMaOoH6ZSeOG3hVh2K7PajTs4knuWwUhK4hvwTUhLouZ8DZoVD2xY8Gv3d5tpCMT80PD1fU6b3kqHTxqixaaj2QAm4lXrJfi5Q0dvr/roEPh/5F2TLt90jBwvS65W19qeceMCYFR9LLFi2N1eMrs/MZbpkChiwNtzorLdHWvxhty/fW6dJDKjj3p8H3DuiNJD/AW8OheMifbsD/sGas69hUGAnh2/+CR2/fnruba+p1tS20xKBvWbx8nk842g7GHvwmfD/sylnccbtLesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alMzItBtAuEHWwPo2tK9Yked1KQtSFLyOXA6JNepbPw=;
 b=TnoStiPSKP2pVhNPvhMj4lW2ylfOCIL3q5350ul2p31jb35f8v+DZYnKSoOTneCEIf3ZwPatR/6LE5YMc2DApGgfOUBoHDqaHvJK+ZhHcp2n4+1y2bmPMIqIWqtCJ7p2e7zeMfqTzV+g2KAVb9Qy02V/ie/YDRqbi9sooml1CoNAtZFsa04zERi/NlRmKpYfTl3kg5mGBxtI7ieACOf0U5fsNjpH1G5Fm0T2brdkR2CvrcETKZlcDcysb6D3xJsGfHgBhDfvAvZ3MLrfE7lZvAYX1OUAB9NCOB5m2M2LvTLFF/JDg3atKjRQ/m5jFSQ2JlrV3DFPyAg9T6bt16V39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alMzItBtAuEHWwPo2tK9Yked1KQtSFLyOXA6JNepbPw=;
 b=iVxkeVc7BUugYzBPe9R6iDBVd11yGbaJPrbqyfGUVqaO31zGe8tLpbr2xqykE3acS9wx2l8fIAlx9NQPgQEy6dc46pm0YMkh3kY0BdP0aFTdX5qxx3x3eMlhFYNMMfae6qseZrueRU0FdlftFMSKYmlxdYEG06NDE74OKB+Pads=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 22:33:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 22:33:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "abbaraju.manojsai@amarulasolutions.com" 
        <abbaraju.manojsai@amarulasolutions.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "t.remmet@phytec.de" <T.remmet@phytec.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "t.remmet@phytec.deh" <t.remmet@phytec.deh>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
Thread-Topic: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
Thread-Index: AQHYhf/v3iWzsuRUtk+w/gzP0mHI661bBj+AgAD9Q4CAAACK4A==
Date:   Wed, 22 Jun 2022 22:33:59 +0000
Message-ID: <DU0PR04MB94175AB468DA032384FC6D1188B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220622062027.994614-1-peng.fan@oss.nxp.com>
 <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
In-Reply-To: <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10015c3d-fcf4-4bb9-e732-08da549f4ccb
x-ms-traffictypediagnostic: DB8PR04MB7114:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB8PR04MB7114A7802191F9E3A852BA5E88B29@DB8PR04MB7114.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3N4fb6PTyQ85GE7sNdcAA/gJNwYM5ofVardzoEmG3+VLg2mCdeEMPa7JXwwCd1EyvpV1+NuQb843+/xcx6O+X1H43a/TSQx3Jp2xa/txAQkQMOJ4don/IBpifI8ZSecQSjaXGjqoJiSF56LDqQ+AyQVp8Q/IVc4BbeqBCjiBKyfMQGo7iM1TNt0W4zm+2GcF4DweQ4ElmWIOyRAwd9EAGmqKdvyS78FMiTGSm0esuqR7ruhjaKyN5ng3w51fIz0spuorPor2/CUA22pPsz1wNaStm37QYO/g5NaxisFnhJgjXNLAUt9HVpVlIhNVZmZmkAQ5Yzl8fsZbGjjgrLxpNbIqTfZOECuAv6cHtmNj8dnydcxo2qzlWvIIl3OAj3gZ72ZqEwe2JoCQp/hfBkhT5gvrM2Hv8I/ikuZkB7zrysvKvTUypZvGvgleUbLKBqtwo8PQXUYYhL3AEbDvpk0aeJPtkWaISQlP3KtrviJbkLOYVQWm5l5pIFKwHbdm8KV54QG2Kl0ltW2bkjDSmJWwwcJKUZdo0qkvyRXBDyhGoEZ+pkJXMxNkmw+zRN2J1Z/U0AeC011U15RQPDN649Am9cBMiAwx6vSSgT81i4iLxBibo517vMRirpOGl9mMizRqOjAQK7Gkl5J5ys7E8OAOvJ1BFbFDzmY7MQPtTJa6MDR2HG/E8A10ONCLFmnaX/R9JzOtqcpGrba7jq+focskq2cbZMqTu2gQYy++UZKF7ZRpCcJPWw5XkzqKz7vvfSCSijrofIFkZjvaYBRXX63hS4vxhLdF7iOKh9C8Dtmy6s8mnm892bs7Kl5VBFZWx/qF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(6506007)(76116006)(7696005)(55016003)(5660300002)(7416002)(8936002)(83380400001)(71200400001)(38070700005)(44832011)(66556008)(122000001)(8676002)(45080400002)(110136005)(2906002)(53546011)(4326008)(316002)(478600001)(54906003)(64756008)(66446008)(26005)(66946007)(38100700002)(41300700001)(9686003)(66476007)(86362001)(52536014)(33656002)(966005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IiDmzYMTQ8qQsUNo3zaEFc0gAsFg5XXood7h0DztiHK+D9+7ShFNZFCpXbN0?=
 =?us-ascii?Q?6eMdvhyUD+Nr2yVTPXcUHAcPyMWrv4BG+kkoxOTeOuTv0uLQT1HBxWbZuEbt?=
 =?us-ascii?Q?VnTOjzR63G4CEhWbSGjFzG5NfO8UkR/7Jo5VZaKqjPo7J4wcpdbi18GZFAnM?=
 =?us-ascii?Q?PuV4JdpJObApgsvnd1V9buWyYrJe5yvEl8tCSQCNJCTS/ie0kp1RF+F5guw0?=
 =?us-ascii?Q?fkkajtYQyan5ARLR/1rFmifwinDlPU9UHIS0We51mFUkEPwGEpGj4+oQasaN?=
 =?us-ascii?Q?MXVqCBtGkZToJq0DZW/TM0kDApLb3B1XWDkC1TR6OazMHyH76RrpOVhoRywn?=
 =?us-ascii?Q?+FX6sZW/tLT7w/n6vrOEF3d68/3dGidWLS5c/KcENZs4iC2iIja1r8QR72qw?=
 =?us-ascii?Q?qLRUgpprFcUROWRxTIjH07LFiaPw5zRl+uvtsFEubb+vsLbWjBGU0iQnz34g?=
 =?us-ascii?Q?64WaaFOlSyU0z0B3Q6g6RQH0VN0hkyZ69vV2x0I4pbGfwFtRx003swQurBJd?=
 =?us-ascii?Q?smI4gK7qalgyN9mSoxVXCU11SBhLVqIQvirRJHiGyqhTEH1wMHNypnODvMtV?=
 =?us-ascii?Q?FbdJLSq94YwFsVOCPBLXP3rDdtaV8D/9bBfcqutg9k/hsnuqzav/y4aDU3NN?=
 =?us-ascii?Q?K0EdMGYtxyYBQwlHtkI0tGpPE47Y/SqjMscx8TLIcxHw+Tn1hsuv24W3M/W5?=
 =?us-ascii?Q?uR3TSdo+hJ5pdi8n91VvmEyg8MqawMPMlnRDl+vIGvcRpftGa3f5hGOk9qms?=
 =?us-ascii?Q?33mhJw+3ItewHgdSZBERQANFlXijaE5OJBWQdkqxvlFi7mlwJOHK3ULnbs4p?=
 =?us-ascii?Q?p7zOZVx8RxaIrQ+pJcc8B9teNxFh3BIQRZ7FL+XGXI1kF/gg6m5KN4Su5ws+?=
 =?us-ascii?Q?KU5nuiTfZC9LH2/Yd5+QeTdBoPiOgsOPdiXoKvy+OjCPIMbX2Yn6bNUkpxgX?=
 =?us-ascii?Q?P46yATIG9Km0qjS0ZlaAFrgYaJufn/W+F0vcoGMklc3rlFQ7pxHEc3tELq70?=
 =?us-ascii?Q?EqCFJq0/J1lIfcnwgv5+j3bayEUP2PkZjYCU5n9mJ2T9fwjeSFRFtcYrzNQb?=
 =?us-ascii?Q?y9xGhzorix+PZRjrXx2wGWIkIbW6ppAaMgrtGLDkGmNtbs1y3IURMgmcHYhB?=
 =?us-ascii?Q?Gn5ZuvhzX7lzsUD2Vo762vH6rexv4/Gu5Z4yJgaod3n4BnLc7dUl2lrsbWSa?=
 =?us-ascii?Q?qe9AgTZA+7jgq0hcu2GWoEwbP2GCT5/jBZ52uicD+Fxnn48XviX2XxxooRQy?=
 =?us-ascii?Q?2OhvQdW3sfwT8DWG/fcV2FfBUjoZpnysgY2VnwwrjCOTjbgrAXVidkvR8WCr?=
 =?us-ascii?Q?wsicYI2UXk66JAjvbNdVbT+Hw54pmFufyOIyqoZYttyNOqi1WT0hwHiuLnP6?=
 =?us-ascii?Q?xJwXlShe3v05ayvwWKsgHrsbhVCBq/8Rly5VliOyh3MHmmGgmEzL+aeiTSi9?=
 =?us-ascii?Q?MbPpDNrOgB9QwNOscPC1hjM4jlhAZjnEPIdj37SL53FzYTezg9IGnc+ajI8S?=
 =?us-ascii?Q?isW1rfUCexPKGRSYO+pOTSj7IAaOg4SSfpWVBzoXGG3imvJD43Juc7OnL+2x?=
 =?us-ascii?Q?chhRZy+EgXHh06ssrvy3NrOLVmyKg+G1Nj4jXSSML6o3Qq8MZQNBYcDcn9CP?=
 =?us-ascii?Q?rRBtF1bhhZLX2IxI1IaWb8i6N5yBs+oJkW0DesZmyf7YQccAb8SY4M0k0bbD?=
 =?us-ascii?Q?NH8XEB5RzMqG01bxC56h30BzaxiBIEqL8/TmL8yiIsHJEoKWDiFtzCt/z7l1?=
 =?us-ascii?Q?ZcE4RahanQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10015c3d-fcf4-4bb9-e732-08da549f4ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 22:33:59.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJILLUx9VOQQbnpLANj1N/MX7gV1SKEGnaudG67tmKKb2N/dyrWY7qe6XIx2lDPeF/o2ILFCr+KRo2EYZNgvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart cons=
ole
>=20
> On Wed, Jun 22, 2022 at 12:24 AM Sascha Hauer <s.hauer@pengutronix.de>
> wrote:
> >
> > +Cc Saravana Kannan <saravanak@google.com>, the author of
> > +71066545b48e4
> >
> > On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Commit 71066545b48e4("driver core: Set fw_devlink.strict=3D1 by
> > > default") default set fw_devlink to true. This has a side effect to
> > > i.MX uart console. The sdma will make the i.MX8MP uart driver defer
> > > probe for some time (~10s with i.MX8MP-EVK board) until sdma ready,
> > > because sdma is a supplier with property dmas set in device tree node=
.
> >
> > I just tested this on an i.MX6 board and observed the same behaviour.
> > The same will happen on any other i.MX board as well. This will also
> > likely happen on any other SoC on which the UART driver uses dmaengine.
> >
> > >
> > > Since this uart is for console, we need log printed out as soon as
> > > possible, so remove the dmas property for the uart console node.
> >
> > Fixing this at board level is not really an option because that means
> > fixing each and every, at least i.MX board in the tree. Furthermore
> > this would mean to bring the deleted property back in and to remove
> > another dmas property should a user want to switch to another console
> > port.
> >
> > For what it's worth: NACK for 71066545b48e4.
>=20
> Peng, I sent a fix. Can you give it a shot please?

Thanks for the quick fix. I have replied your patch with my T-b.
My patch could be dropped.

Thanks,
Peng.

>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flkml%2F20220622215912.550419-1-saravanak%40google.com%
> 2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C7a841838946c4df32eb
> 408da549efa47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 7915339019509985%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &amp;sdata=3DwO7NEebGVRp1C7LvhRyZnTTzJwma5eHDfDcoAqdLE24%3D&am
> p;reserved=3D0
>=20
> -Saravana
>=20
> >
> > Sascha
> >
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V1:
> > >  The upper set fw_devlink.strict=3D1 patch is in linux-next tree.
> > >
> > >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2
> ++
> > >  arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2
> > > ++  arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  |
> 2 ++
> > >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2
> ++
> > >  4 files changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > index fb11c03bc8b1..3fdb38bc0069 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > @@ -359,6 +359,8 @@ &uart2 {
> > >       pinctrl-names =3D "default";
> > >       pinctrl-0 =3D <&pinctrl_uart2>;
> > >       status =3D "okay";
> > > +     /delete-property/ dmas;
> > > +     /delete-property/ dma-names;
> > >  };
> > >
> > >  &usb3_phy1 {
> > > diff --git
> > > a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > > index dd703b6a5e17..fb2b44e94482 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > > +++
> b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > > @@ -69,6 +69,8 @@ &uart2 {
> > >       pinctrl-names =3D "default";
> > >       pinctrl-0 =3D <&pinctrl_uart2>;
> > >       status =3D "okay";
> > > +     /delete-property/ dmas;
> > > +     /delete-property/ dma-names;
> > >  };
> > >
> > >  &usb3_phy0 {
> > > diff --git
> > > a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > > index 6aa720bafe28..68a478151292 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > > @@ -99,6 +99,8 @@ &uart1 {
> > >       pinctrl-names =3D "default";
> > >       pinctrl-0 =3D <&pinctrl_uart1>;
> > >       status =3D "okay";
> > > +     /delete-property/ dmas;
> > > +     /delete-property/ dma-names;
> > >  };
> > >
> > >  /* SD-Card */
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > index 521215520a0f..f90c1ac2791c 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > @@ -554,6 +554,8 @@ &uart2 {
> > >       pinctrl-names =3D "default";
> > >       pinctrl-0 =3D <&pinctrl_uart2>;
> > >       status =3D "okay";
> > > +     /delete-property/ dmas;
> > > +     /delete-property/ dma-names;
> > >  };
> > >
> > >  &uart4 {
> > > --
> > > 2.25.1
> > >
> > >
> >
> > --
> > Pengutronix e.K.                           |
> |
> > Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C7a84183
> 8946c4df32eb408da549efa47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637915339019509985%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3Dh0WK5980JKlkNVax%2F7PopVftgkClnG0SLAvuPqh
> lj0A%3D&amp;reserved=3D0  |
> > 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
