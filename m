Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12255B1FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiIHNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiIHNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:51:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5B7754A;
        Thu,  8 Sep 2022 06:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE8Ub1qpQT8To/VbnPs4gjeOsbMhW/bMmqwxB2AH4He4SAVvc3rjrnGQTMlQ1TQnis9gxWrPIOtQtgCNN97JUnF8Fi58/S10eLqo3kJRjV/6HWZhnj9WXjNo5KZdWTUtpxibZUAi5aaLY87AV9Y+69Bh/IeqaQxKtT4AYrT/9Jqn8uSlP+HQynFu1ILekng3aMSmQYQE7fXp4fYx2OMH8QeSsyXV48yF4e952FdZi4g1ASEvA4mc4ADrySqHpIIbe1Q/jhbVJ5Flb2gE10W8Znf5mr1417npZktlg2zDLvXBysSC5qIlyrewScJN1lEiiFHF3WaA+SQ43Q7kIOtQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U35Sepkj6t2Mmn88f5OkFHgcAAFdSzLX/Y1gISq8y9s=;
 b=PH8BrxTVaK4EXc9F4BD91NvV9UzNlNuJ8W67zdisls8C/HeDzIoTf1eG6KQw2nYdvtwxQVPjyritlVkf2lbHkBiKxn9syeDgIL7ygZUhCnomfLQcNK24Jaah51twKlw2lmoLG01O2vbkj3dgY9yf5JoXY6oO0lIqclYnTe+nhsAU6RYbpI0SxowvSWTGkahZ38LGk1Nk91QM+X2QbUmL0fidfFAYIR83IR3FK6Neqmiu5z9DgppHmOeyVSVQotPJxcgpKDk1dbP3clgUR7L09peE70Rznwdbrhh4rDFdTPL7UGA5h0uLfc93WXJ9iAgdXh+X4iU+sYhoBkfST3mgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U35Sepkj6t2Mmn88f5OkFHgcAAFdSzLX/Y1gISq8y9s=;
 b=ErmotNeiq9eSbFDn9HeiskNHPxwykz7HP+Pvq14nGAdpkPmVFfq+ynbDqvEvHPWfF2KAs6zsbzoJFo5F0d0IlSIPZsCZVosFqZgYbjUzLuOZvKifcpRiyxHIl1aht6q/iSWFOnQBNr6svCx1AZa0l91LqY+by84Sry5GksYeGd8=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by VI1PR04MB4447.eurprd04.prod.outlook.com (2603:10a6:803:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 13:51:33 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Thu, 8 Sep 2022
 13:51:33 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] arm64: dts: imx8mp: Add snps, gfladj-refclk-lpm-sel
 quirk to USB nodes
Thread-Topic: [PATCH 3/4] arm64: dts: imx8mp: Add snps, gfladj-refclk-lpm-sel
 quirk to USB nodes
Thread-Index: AQHYw2bc6Qh93RgiaUetlFhVHkNoxa3VjKog
Date:   Thu, 8 Sep 2022 13:51:33 +0000
Message-ID: <PA4PR04MB964018044E80B9A0867B142D89409@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <20220907144624.2810117-4-alexander.stein@ew.tq-group.com>
 <PA4PR04MB9640C21A8F2DC44DB58C5C9089409@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <1836686.CQOukoFCf9@steina-w>
In-Reply-To: <1836686.CQOukoFCf9@steina-w>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f3c70ea-5185-4c3d-c7e9-08da91a13dbf
x-ms-traffictypediagnostic: VI1PR04MB4447:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K22QQvctijm7/Tlvurb26lJHqsNrfC372RyS6JEklIVjiSsOm99bzAYDG6vYzfkyv/VMiD6REGggqYbqnGoOwOkVfzMVreSJFfgYW8LfyfMJp0TrxUEfnl6zNkuhz4527R9kpSvXtp3D+pUjOWcBxbL6Ae7YjJ1DfzklYp1QE7pe+XzMTCeFj5jv3BPgkfdESz9OjDAuHDwuO6JbQ5X5JuKSH5x5vmVD5EgFLxa0BYX257X6/lHL0uhP1tFjes0Pr141kKQbItyyI4VHgoNdNupObn+7c+6z+rpk4a3SE9r8tuQtl2WJGwm0I3Y1711TZtT/rF+xpdL61uvG+55Hq79rpMonBSoBV1LInFraLwGIcLb+otQbysA+YZQMcoPpXxTYcU4cmhpkW5gPhzfDSCF8qCpvSQ29iM+ngYIpTkfBqFKxdems13+xiMpRoAX2NJyaw6r8EU9qgGOM05iKoQ5zPAt8VWaiKordPcM1mqvC7Aesh30lDOBSCfzhAtgFyL8wRI7cXIjwER0PTe6yKMqCeqaZMmD71j7+dNYQJKLBbh6KfThdrNVp5V7+rZCDSbKyAMRt0C6L1uLqMFCIbYO4OI4a2jDhzzg5/2Ut1MAW6ONG4kZFV36r0mXUY+aRoc8rcyzd2zzpJBaycRcZrdRVbW+tYcgYZNNXJpBGY8z0ZjjkDymEQVY6dGcHURQRUjIiWMfWTS5jptKe6jDyeRNuHBQCv6LAh8pFiqwd0f38YFDF6V8lVuCM7SZQlh2SR5M5ebKdfCRsSFVpOhNg/MQBscGJBnTnnWI3duSphS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(66446008)(478600001)(6916009)(54906003)(6506007)(9686003)(7696005)(83380400001)(26005)(8936002)(33656002)(52536014)(38070700005)(55016003)(7416002)(5660300002)(2906002)(53546011)(86362001)(44832011)(66556008)(4326008)(66946007)(66476007)(8676002)(76116006)(38100700002)(71200400001)(41300700001)(186003)(64756008)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2MgzE/CiH3AnrM48HBsnAmwODhVw8xlTIwfKDHN/NCpl7Wyw753Dzw3OWot8?=
 =?us-ascii?Q?6v1XjKbb+b0GK0bf1UAmEcRmpS2SFrpmJzg+r7KHGBSVJJbd1Qbw23rxOSVe?=
 =?us-ascii?Q?43ejuHaJTfOSTHuDJJ+gs1g2y2auQ0EJOwCp4xC3VtfQ5/S19HUP+utZQbqf?=
 =?us-ascii?Q?BVmA0eCKdRDMQYwjCeXBdbjoNwoWBmdeDArkDwMslfkHJDxCTiQUrhVFsVw9?=
 =?us-ascii?Q?zKGkV3QnSDk4hTGcMAMRhAW2HepguVccZm85gDDkYHWji60XATrq0ukKIDo2?=
 =?us-ascii?Q?Cz+/AJliJ35i5MFvXugIqV3WcRD+OVuA2KYblLWt+LdppdJ0JwT7mNja6MSq?=
 =?us-ascii?Q?kDvgSZCPzhqrRsrANk6MeSQSINRISqb4mXXiY3j5901/6+P79iNkRofiVyZd?=
 =?us-ascii?Q?O6JQKyoMzNivtQqzLFHhdBtLBhNea+wgc3SFJPtmfYDW0CVQBaMbkq0uCbpR?=
 =?us-ascii?Q?5K9IBXM2OJBxfi2RV/gSyRvnD1KpS8jcJInxsapE4mSEHv6Tf00TEzp5SPwZ?=
 =?us-ascii?Q?Jj1a6ff7FbyBlde9l0n93+UDvsK2fx5XZZNGD9lvUz82CAovf21DvgkW1sV0?=
 =?us-ascii?Q?AY+V+43O5zmTwT+axGTx9lRCBceQDPBvjTdGkPjjpckxTQ9aCJuvefyV68R4?=
 =?us-ascii?Q?qZHq90jgTrmkqJWt1UlP1OigZP5UePpZBHgleECWx5jSUn7UXZElk//pqKtj?=
 =?us-ascii?Q?0yzSW8iLzpJ2dJ/qAO64r08Z21eQdv9RMuNojL0Xu0+a8mShESI9At5Cn8vz?=
 =?us-ascii?Q?pARozkC1j0FrNvf+DqnyEkFT1wXVQoxZtKaaf9XYviwEPfYOudg3B3bAiZNZ?=
 =?us-ascii?Q?HNOjStNK5x/FSceulvOddSalGmpL9+qkJkCsRo/ZAgAUZHA/0SkGsUJxwgnp?=
 =?us-ascii?Q?gArn5/UJ/zzS+lz+joC4nrMaAu3GA6ttEPOUafb2h+RO2RvdyDmIjVQ3V69o?=
 =?us-ascii?Q?dbL4jgT82UpPZiW8j/gEhq++6LLokm1bDzE3MJ4sY24ikwwRFc0jqokZpk9K?=
 =?us-ascii?Q?IyJ0RsyWyCmnfqoTM9ux8IvwdvmMF0m4LGJCGo1wJod2cc6HSkTj60MJiwbf?=
 =?us-ascii?Q?BJ7uXCpgojg7hs0T+pIkZDWNJ1CUvkxBFRcsAk3c1bGLamG4CyxJgPHqFTw4?=
 =?us-ascii?Q?uN0Lia5TUNKpJXWWiSgfTbWa8VXF0FLfZLLvpxx2V7t1CDv2dZR02lmqxTDx?=
 =?us-ascii?Q?9xPV9967nDSboMm14sOTuBNcMpJf5YPRHN0CqItPWOB1CM1BhbRQhrAkegGs?=
 =?us-ascii?Q?kGorcUtoOaho5J/pZzhyZUpJYzEZEp/3y0h6Syz0SDmLTXdt0zlhOAUG18EX?=
 =?us-ascii?Q?IXOoS5qxzFFktK6SZZ3rQ6iW8IkfTyIMeHv6Qbk8WfNo2rc9ePW3bIvBkC6j?=
 =?us-ascii?Q?YSb7oMFtQHykT/yjyhs5vwNsplY7rYuwj9UNE65faqIRkD+JMO9zM/wmDNNf?=
 =?us-ascii?Q?wjT5Yc4uf8xEdtFGhgadmHsfmY9pXoYsJLGSItKwa1UYaG0vsW4i5MuiQG27?=
 =?us-ascii?Q?bH4XmUQD6KKmluXW/p3hOJGtTvArAM1sbh456FAFIYLibuWiVbBsbjoRb2xP?=
 =?us-ascii?Q?EvsdvWPJEfqrAYe6hdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3c70ea-5185-4c3d-c7e9-08da91a13dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:51:33.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMZkU6vz7Kdz3ADyFIStMFCRyLZEwGvfc5mgiLOGFqEr8+J+6t1ZdNU7UAEiRBd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4447
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
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Thursday, September 8, 2022 5:39 PM
> To: Jun Li <jun.li@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 3/4] arm64: dts: imx8mp: Add snps, gfladj-refclk-lpm-=
sel
> quirk to USB nodes
>=20
> Am Donnerstag, 8. September 2022, 11:12:23 CEST schrieb Jun Li:
> > > -----Original Message-----
> > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > Sent: Wednesday, September 7, 2022 10:46 PM
> > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo
> > > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jun Li
> > > <jun.li@nxp.com>
> > > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: [PATCH 3/4] arm64: dts: imx8mp: Add
> > > snps,gfladj-refclk-lpm-sel quirk to USB nodes
> > >
> > > With this set the SOF/ITP counter is based on ref_clk when 2.0 ports
> > > are suspended.
> > >
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index 53493dc7d976..0e7f5842a3e4 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -1300,6 +1300,7 @@ usb_dwc3_0: usb@38100000 {
> > >
> > >  				phys =3D <&usb3_phy0>, <&usb3_phy0>;
> > >  				phy-names =3D "usb2-phy", "usb3-
> phy";
> > >  				snps,dis-u2-freeclk-exists-quirk;
> >
> > So this property can be removed?
>=20
> I'm not so sure about this one, as the description is talking about USB2
> PHY providing a free-running PHY clock. I don't know the details if this
> is true or not.
> But removing snps,dis-u2-freeclk-exists-quirk from both USB device nodes,
> USB devices attachments are still detected when the USB hub is suspended,
> both super-speed and high-speed ports.

With below change in driver:

-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &=3D ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;

DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS bit can be cleared by new property
snps,gfladj-refclk-lpm-sel-quirk

Li Jun

>=20
> Best regards,
> Alexander
>=20
> > > +				snps,gfladj-refclk-lpm-sel-quirk;
> > >
> > >  			};
> > >
> > >  		};
> > >
> > > @@ -1342,6 +1343,7 @@ usb_dwc3_1: usb@38200000 {
> > >
> > >  				phys =3D <&usb3_phy1>, <&usb3_phy1>;
> > >  				phy-names =3D "usb2-phy", "usb3-
> phy";
> > >  				snps,dis-u2-freeclk-exists-quirk;
> >
> > Ditto.
> >
> > Li Jun
> >
> > > +				snps,gfladj-refclk-lpm-sel-quirk;
> > >
> > >  			};
> > >
> > >  		};
> > >
> > > --
> > > 2.25.1
>=20
>=20
>=20

