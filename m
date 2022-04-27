Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A15E51247F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiD0V3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiD0V3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:29:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3BFC10;
        Wed, 27 Apr 2022 14:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMr5trpo1c+hcwrwYg5OucizF84SHpCUvlNdZIZ/iEdFss0PrlOq3Hn8afy9NDNB974Y5XENc9gGgsKhu9frlFz5JI7KRHv4jPzqxTNgkVystqNxfzMY7PbDyacM2SREjVy99VClRzIAlrR2w5UTmvvW3qnoVMip8ajoQ0IKHrI2GVberk40lW/edkLvdGQmebaqcfqijQxfccbUrldoJdATJm3fZrZ5tirRJaTgAxKeC9vV2Oske3/Zc2vemxffqO/0U02A6KLEMcdgxC9lnXruag9W5xY5DJ8c7TcwHkxvwWd9pCWWWbelkJos5tZOMvS2V8o6MZUmPRJWzHkLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNVdwtAkUfLbsa2/iU4x+IDWIF2+UMhxzpZ8twNYVvw=;
 b=F4eN6I+kuqTJPFKr8xmtpPoLD8l7vZFJU9xH9ENEGyaPz38CRRRJS9IVuc3GzvNH2+qez5zSfobDTdMZDe9oZJC9ZW0jiXHvAooaVCuDbx/fIJK4J+L8chzjV1XkzHhFdcMr8ABPFT9qNoTAqMnVShj4fZ14gJlicQ29KDauz0YuS62YurPnaIdUvcAxPtaSo0sWU/q+OQQAAOR187g2FgHoBDnKPSfYO9WYb5n2pOYopdhN9YinISpJkJurXjn0miM2i2f+bkIBLR9GCDVesHYFeQgDyhnKe6gdJxHUp4gziHZsvS7ngHh2biFng8/iH6LSeOml2Tni0Mez2qyuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNVdwtAkUfLbsa2/iU4x+IDWIF2+UMhxzpZ8twNYVvw=;
 b=CCs0YgWk62TwYDavFMG1sd1RrKEDijxgTJJUUS1e33nhbf/uKS50n1r4RyreFqoEscSOD2TwemyRSJD6pJQRUD1+pJSEcQC13pZlg6BhPR3CKyLlGBGNfVKYu9MUhZW79rc78UE8zarF6vFR0xZEwNjPPSIDGj3p7S80ZPhRVJc=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AM0PR04MB5281.eurprd04.prod.outlook.com (2603:10a6:208:c6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 21:26:22 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::8859:691:cefc:9a17]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::8859:691:cefc:9a17%7]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 21:26:22 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatible
 from ifc node
Thread-Topic: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatible
 from ifc node
Thread-Index: AQHYPZSNlrqSlMmEREyf90tEZ5l9OKzo3ciAgBugjrA=
Date:   Wed, 27 Apr 2022 21:26:22 +0000
Message-ID: <AS8PR04MB8946C4F390D57C34816DBFB28FFA9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20220322022818.9860-1-leoyang.li@nxp.com>
 <20220410072745.GN129381@dragon>
In-Reply-To: <20220410072745.GN129381@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22e460cd-95ae-4633-1382-08da289493ea
x-ms-traffictypediagnostic: AM0PR04MB5281:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5281441729EEB575AAA5C7748FFA9@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxycWvYwtGDawtuoVkCppZeg2KPD/ED2nRGgFaQ98Bw18/VK34vBhqwVYUAg8rKMyyCSxveriL7nzLeLmibF3lx0yXIEX+4yLLDjVf8qDtkPzGMqx9BpsHa8FXnAQu5cn31yLm/ln+eE/kmfSFfFL0BZyr+2uYavHpZsZJrhD5aChj7mWMaA/io2P5iaJZ/LxWjyLczKEDpWkbfCi40YG5Y68sMhyLABtC65t85zaMJpOj+83lohwlxYliqV/QPCOCYuSkAllgsH7ZgQ2P+PJN65bmylveVQjnjLhIOdFp8Id7tLX8Npmc0i9xCdTLa+dkWb1l6hXWH+q9GlDV4pbXN38rzu0C7REwgI1qERoDKtdVdtoPRGKYqzGfiqvBFiwiZM6iREiejuWk9+vSXbIOLByZfOnBmX0ioMMx9nnwF3DnKJ9R3gsylp57fM+sP5DzliK5Wd63uN/d/1yMmfEIbm7u1eoAQY6jopU7ei/Um2i6wwJdFBKTHqkfitlAH/FxqlqhJPWcZpkv6tALR/j7uOE9va1dy9Ltp2OL5hciKTbEedj3HYIjeybxMPA/rFWUXj4VtdNr2Z9sf9Eh8a+5TsD7C2AmRfv6j/K8SR+gj3+sxu1q9Uw977fL3RGUkRrwBWFDtxXN+Qi/W26s/U22r+kUdqUQ4tPliJRTgAObxEyMjCUUublUoyDwNkZztzm5QhUxAondJFTJ8fbkLcIFOB4PZ/nYYgATDETOljUt+iPZkHK78wvndI28KzO3W3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(316002)(9686003)(26005)(83380400001)(54906003)(52536014)(6916009)(8936002)(33656002)(6506007)(53546011)(186003)(7696005)(122000001)(508600001)(38100700002)(2906002)(38070700005)(71200400001)(55016003)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?he+hJj9zEe9ZwgOwY1cNwSuDBKbqjqfpDY8BBrEkUhlP2L3hfB3Twt9RoWkD?=
 =?us-ascii?Q?q8B6rNwQPCTwrrvO29YbWxL6ozGXnFQw/WH8EjMMlO8GY0ooGxbKlpWe1IyM?=
 =?us-ascii?Q?6I3Yo85YmXxX1RqiCi0qKu72GVIZzzup72UaauUkDw0dOtgBzk0oFQAw4ObB?=
 =?us-ascii?Q?Gy6BcOUUiAOvhh6Zyzrka2CJU9NPviGt8zvNH7fDPohkogDV5VWNjzFz4Da7?=
 =?us-ascii?Q?wOH8i5dD2PRv89ym8OkeKkgLgUdYoJPqk5DY20KQzbh7t2MdNl+O5Xa2JC6q?=
 =?us-ascii?Q?0EQHODgp5fD5g5udjZlSHbC9wwrL9vThMviOketoRTAtPWBXf5F98DlSY4gw?=
 =?us-ascii?Q?ydTh/UVlccX5jmPkZR8VE4L22UMZXbEUCX8gg92tCXN7JITSw/C7vVM1jdVi?=
 =?us-ascii?Q?eWzW2g8sxZygDXchlhL/A/vg2XpR+UVFJUlrZT+48se0qpRydbRJRbfRI/ob?=
 =?us-ascii?Q?SGW6S+r7HBxFR3FXjUr4puPmED3SZLGhuraxoNzppFNYt0qOjvTmJvMPpqnT?=
 =?us-ascii?Q?5Arbqf0Uo465dK8IW4rm6MhYTqS/C+jHkmjo9ckUZcSWMWbZzRllasTUJ6tP?=
 =?us-ascii?Q?SOB3Fhk1F+SNcvfOxk72JfAVtWyOX0EzGGV+3xE4b1eY05F3sEpFAWGrHwJ9?=
 =?us-ascii?Q?Q2PacxSIF+RRSVmlvsvfz2wsDliLuA1mKUPAt+DZaVxKnr+h9nGz1mbIwAGr?=
 =?us-ascii?Q?cFeY5b0hoLeTCH9mh/SW1qnw84qTdHdi2xkyGI+U2XPd67p9PvHZgFn6CyeE?=
 =?us-ascii?Q?eWppMH9qWpUyI0j+WAYiENN/3t5+Lc2iFVFAo2dEuALxtj+CfH2W8YuywsvP?=
 =?us-ascii?Q?AqgChj+WbADmxLzTx9WTkOkJsQjYkSOYz1o8lTrqL2l4+GnuWZxDLVy3OTtR?=
 =?us-ascii?Q?JA0Yc+MWV38INyH5wzKrdH/EyTXxzWhJoDZX4o6ZoutJXEahRH7+LWbnvhZ5?=
 =?us-ascii?Q?ahYJzwf7ciG0OHhoKmwlVcwNHm5BEoXO4wf6yAm1JAN+4ukzt50MI+y4ZeYp?=
 =?us-ascii?Q?jAKzIBM7bsYgSGr0g1msZK8lITpgnjMOH18aX41X/LDyzggvQa+kkZVlATSy?=
 =?us-ascii?Q?VicbC0DiKK4PNKly7fqGiVNVwrmm0tE3qdzmKht9QPJlubGfpRnbd2fgYTG0?=
 =?us-ascii?Q?WkVLb6Ba5Qj7/IgF157yQoefFKQLcJcsLeqs1bw4DpPlTnkj92iylsrDWISd?=
 =?us-ascii?Q?Jw1GEDqzOps9wKipvj7SBrXmWdnI1Ia7mNYVWIq237LzUVekN0b0dkKWlJqZ?=
 =?us-ascii?Q?bYG6x0dCINCICyJ+cOqrrLT1Gdb1g/HKD3fnCKYtovDb7hZ/wNIJ0mLWq6LJ?=
 =?us-ascii?Q?/wGH5Oa1zfwogRjnDXIYcaBi2fomQwSzYN0Mh+uqJJ2JeswbBz3rcY13mGfO?=
 =?us-ascii?Q?HPVnHUA8nwOo/wA/Msjl6swbrQr+NraySNL+Qq0BAw0VKH57b7hpcHL1a+tW?=
 =?us-ascii?Q?LV1ShAZcNUFSJCqQSvwzvFpVBLcmYk1zmQda907d3mUiwskAz7R7ZB4wKYqc?=
 =?us-ascii?Q?UicTz9Q8RDL8bmdkMwy5c1p0TdZdvE6dJJwXXdZVLzNgoW4lo3zDc1zYRyRt?=
 =?us-ascii?Q?Jfg70znZgssKKPnDIqwJuORMAkgmxL9oSJ5e9cPcGvvCCGpL9nUvwl4R5g2D?=
 =?us-ascii?Q?Bpv2TfBZNufckcTF3z5KImZ/kzyBkKo429RyUT7MIMVeS1u+RaHY05VrDyhT?=
 =?us-ascii?Q?k2iriSNVVYbH3Hi5JLEdBs8lrH+TKGsYl8D8jHY9Q0i3YlIpE/PMqVQ99PuL?=
 =?us-ascii?Q?abBsEpaACg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e460cd-95ae-4633-1382-08da289493ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 21:26:22.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89AWughRV52ciwjrxsk6zhsmhKXUQRGcAM0jOu7QVNDZCIGU8ihiU9FSNUnms28bRXwJSu1/UJnTJk7rbLkgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, April 10, 2022 2:28 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.or=
g;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatibl=
e
> from ifc node
>=20
> On Mon, Mar 21, 2022 at 09:28:13PM -0500, Li Yang wrote:
> > The binding of ifc device has been updated.  Update dts to match
> > accordingly.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>=20
> I only received patches #1, #2, #4 and #5, while it claims there are 6 pa=
tches
> in the series.

I used the get_maintainers.pl script to generate the recipients.  The patch=
 #3 and #6 are for powerpc, that's probably why it missed you.  Please help=
 to review the current patches.  If they need a rebase to the latest baseli=
ne I will resend the whole series and include you for all the patches.

Regards,
Leo
>=20
> Shawn
>=20
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index 2e69d6eab4d1..52835d3dfa1b
> > 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -123,7 +123,7 @@ msi2: msi-controller@1570e08 {
> >  		};
> >
> >  		ifc: ifc@1530000 {
> > -			compatible =3D "fsl,ifc", "simple-bus";
> > +			compatible =3D "fsl,ifc";
> >  			reg =3D <0x0 0x1530000 0x0 0x10000>;
> >  			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> >  			status =3D "disabled";
> > --
> > 2.25.1
> >
