Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34435B1422
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIHFk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIHFkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:40:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11686550A9;
        Wed,  7 Sep 2022 22:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHUdR9SbzvcMO/6f/noXRfvof7lXfMFK/gzVLf2uZ5oG2VrHWfgWsK0mGMYxZV9UADfMQj4uIJc2IrPd3q3vSC3A27Y51ud2DsDSG38p1TUiG5WSbUnnUX9d6/VSQPWjBUHm0Ymj3LvDRLHzZQREjpG172IE6nDni1D/feeFclvU7HC23Pi0RopoQyqUGRujg5ZrF2F3EEIdgjnyaIx9IgOnGypkLoBE51vyEqrg8hkRpWy1J2wm5WPBOJqTaXDoY1PEGfmBU/R0jHH81sWXp66IjMabKmTIyQH8Cnr29Dsw8Elb9C5Q+VzIWPCJ+JwcEFuHtN5Wwfr7mmAoCQO2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44ALHBBz6eJGrTjweu4qRMrmBWYopW/K8guaQsEO5m4=;
 b=RO4rhMgHaNzppBRPGw5bdril0jeBtzMd3jJxrmYIEzx/pZXoSWILayzG9PsC9SrF1IIM+4m7Ejj8HvdbJTb6pYnrAh0ZecsMVY8F61oCa2k+iGvJysMKmceyXt+wxm4QpjWZJagOecVsKaesZLzshQ3g/t98M4azPvB9+m1wTz2gk9Tzen8PmHAc8Xb480VLucjyZr/wPH8ivOjVTHA4jilv4CBH17qap2C8KpaQfwAt72kbwbikn3VABIUDO7OC8I1EkyRhrjaOn0Fa03pD1G0NysOCsH5JtxtkhFaV512oJwKAl/ypulZSQCYgfBulyk/kTzm3/IGtHReRH/aSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ALHBBz6eJGrTjweu4qRMrmBWYopW/K8guaQsEO5m4=;
 b=NbzlafD3VaC10AtihfF1ownlrVL65EZkGvOr2oUBsct+/kDqfFCQIcUOZ2CcfxO7SxSfnCS9DhRYaJbzRN2vHnNJSqMHvdTnz31+Cp4/SxdGVlunl8yF4rduZBjLh+vOCbA2oBWmS/S5Ij05MRvw3dd2uE/Pr1ufreaOnZgLOFc=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 05:40:12 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::10e0:e5f1:691f:ecff]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::10e0:e5f1:691f:ecff%6]) with mapi id 15.20.5588.010; Thu, 8 Sep 2022
 05:40:11 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Rob Herring <robh@kernel.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "sivadur@xilinx.com" <sivadur@xilinx.com>
Subject: RE: [PATCH 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc
 error after resume bug
Thread-Topic: [PATCH 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc
 error after resume bug
Thread-Index: AQHYfyP3kpnsx36RNUqlZPzh2WbLva1UOlgAgAcciLA=
Date:   Thu, 8 Sep 2022 05:40:11 +0000
Message-ID: <MN2PR12MB433326214F7A6F522F6A379A88409@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220613124703.4493-1-piyush.mehta@xilinx.com>
 <20220613124703.4493-3-piyush.mehta@xilinx.com>
 <20220617224808.GA2576564-robh@kernel.org>
In-Reply-To: <20220617224808.GA2576564-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: robh@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62dcf86f-e282-406a-a436-08da915c98e7
x-ms-traffictypediagnostic: MN0PR12MB5737:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwjov+ZyyLDVriWHd8e3oYvk+Pl6fQ0luZdGwQpzgVH3PF5vxu1FCar3CUYZwp+gpGmN+CHA7aPkD/6lY0ED+qiKfn1lUwVFcKGU9yEHOvu3JGcqYmvMD87+QaKa41xnr13UxB/Tb4EMy0+4zE1sE196BfsCZrNA3Ahvym3p6JdEtPJBSXy51/lW+uj4rUBLoBAcJaF5GQHsLLxYqeGzo5XBE0FtYFNhGxddxLQ+qZxkSQ6b5LtdPoIPcJCnervYk9TUgQmanp7+4bpmsVMBYZgieJdFPGhBpo6+WXZ8BVRUq++m4LkdN+uUWE2sqeOPMBewiN/aIoQa/ppP9lFPa/XF7d55oxHqhE018SvrcQ01WqWwV+UoZ7XXLC8SepzSRTAvbRkZmf8UHQnTxJGSjN8cgE27gkCTPDuAkghRHwK+/6/03uS2UUUj+dpBOtodHsNQ8sIzT2LWrU7X8B+52UOMySCBwOKyhtg+MA+cXXhWhq2cJPJPZSfdvwrVph53d8PhNRgSf4edS2dcB+0Kg1e63Lqt1yxND6LtT2vDIFlvHn+smUvyY82mcQ9Gp91+AeESn9aJQ0sc9UTdAAlU2+Se6E3ZbY3zmUvXOYKSI8+8QKmpXKmCR2fKaJy4HkL9q8+e+pv2C9NFTfVCk2qOgrOdnFKTl05xYM1gxI0T8K1AbuWgBmu1jTR17TZLdI7kC4PKR6xK/4E5bWW5WRdLfQyQQbeIyOL1JmdPddiNvd/Dwpp2BOfi5TzpVVh0t/aQOH85xWEIaQVIj/lqcs3OTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(64756008)(316002)(71200400001)(55016003)(122000001)(38100700002)(41300700001)(54906003)(110136005)(4326008)(66556008)(66946007)(38070700005)(33656002)(478600001)(6506007)(76116006)(7696005)(66446008)(8676002)(66476007)(83380400001)(186003)(8936002)(86362001)(52536014)(5660300002)(2906002)(107886003)(26005)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KlkA9Esb/xsa81+OuFi4j1UNKt8Cm5oo9FVlqvYKNfp+nTBNNn1vR0H3ve2C?=
 =?us-ascii?Q?wXQUJoC5gFQOAvNt0LinYaknzIDXp7OKUJQaYuIYBxmiMi2ZOIjpk3w2TjiZ?=
 =?us-ascii?Q?yHws2rrak1nS/TKI/yHC+8dY1k5qf/lgZKmNwBaEKOdi2di+ptbRfylst6I/?=
 =?us-ascii?Q?Cls3hWf+kJ+k3sf697vMIeXKONYzRZZHsJOYhElEbIHywrn7oehECWF6YKfp?=
 =?us-ascii?Q?qI4A41/WpZDervrqsHBl8uFCxcwz6PrgfBvRW/V6k6hKkvlyje0R9G2p44kX?=
 =?us-ascii?Q?4e/HzM1WCSUpab6T6YMXSIh9A3I6PTgTbHVGxVJm+RQqdlC4aWqdE0OM67S+?=
 =?us-ascii?Q?POKFPxePUiDC10S1I1Emc15iNtcEWB/F1E+YZUBi46gweFfUVRMZdHoDxH9n?=
 =?us-ascii?Q?fDMexxtSsow5S+Wd7Ef95WtuPSnrltGYJBqQhAxh3vJDqUIfXmnoM1LKq3Fg?=
 =?us-ascii?Q?YhnqPxUiJWArov0kqyo13k/3DV7IA0Ctr1IjAeQTEaDZzCWzEmf0tCjJ2egz?=
 =?us-ascii?Q?YR2j+3SHME1bOrV0duSnrQvQlfTbgu1XeMOFmt9QWq5OdtiZ53rt8tjBWqGK?=
 =?us-ascii?Q?VgZoGib3/TeDpcTE4I5L/aVtVPUF5FnOTaI8ZN47KBM0uaDTV9H72YNxiiJO?=
 =?us-ascii?Q?GgHe3UI88d646ZGGGzkj7wK5NEFZqA9qgK3a6q2QLKdRh6f8VPhUAVRbOZuP?=
 =?us-ascii?Q?+96Gro8Os6alOKrL2WnsdsfgtqClWb1yqrxT4ycQsdXyNq7e2Wul9T/SKBAS?=
 =?us-ascii?Q?XEA/hW1Wd/cqebKshXRUEJUyDZSWAKdhwSv9BuTbK2SbONVpdcbZahAxyrfb?=
 =?us-ascii?Q?585e5sxRI23mEh+K/Wd0WAP0ryP3qgINuWyx36asupc2Yr06uIIAEiqol/AD?=
 =?us-ascii?Q?F8zZrbkionEo6msNcGS9b23NszwYmnuuuK0MyY/rAe/GiEV5POoi+RVAx+zu?=
 =?us-ascii?Q?6UghySmHkZSVIm8WjxbwUybLB6lAEvI1ugPVPK06e+f1yDfPeBoGCC7Js3w5?=
 =?us-ascii?Q?5oICCdzr2Af8aBotbZV3uEj3ORAhOpC4okiCoHkRPmjtC9Xpofog5PsEE23D?=
 =?us-ascii?Q?o1BO5y5EMqK5ghC9pCibb9EyW7Kl0u/F4BsQNAqUPSW2AFUTZ73Z3UBgx8rg?=
 =?us-ascii?Q?p13tx5kyxgug6uX+jKPg7RTRuX06i5Rezl8eDe7OvBE0nykMFvCF7hZtUh2V?=
 =?us-ascii?Q?pKChdrOfs63bMGJ0xaG0ClVjVwhHx/kmOvrAxz7/jSynRxvG7LwJ7tV7kyGx?=
 =?us-ascii?Q?tZoMMUmdEc/kE9R0jcKMs6iueGyL44WsvliItA7itTYXx1EupXv22ThMHUh5?=
 =?us-ascii?Q?uTKG5ApkuhRvd5Ng4Rp+hakT6L25IUPrmpafZ4pIq2oxuqELaCd6pxi9J2o9?=
 =?us-ascii?Q?QUQMFPkm6qfU7UTyehsO15v1O604Mo6MpoaLcvKoLuWfxs2XkDv0k7iAFjyM?=
 =?us-ascii?Q?4NABjCio4LQskxkHl309UFnbDOK6LHRJI74BrpcTQZPXh6JeurFvWDZ+GpHm?=
 =?us-ascii?Q?v8IpwDaiHfBW+cn7zL3ijxc8eutz4RiCA2lgWFlBU2ONt4Aak1wN63D7PjSf?=
 =?us-ascii?Q?pZJPj3OjFJLZXj0sOnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dcf86f-e282-406a-a436-08da915c98e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 05:40:11.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrmYL2T3hEe9iHAup/MBCLITiKaDJsyvTZG6LXqWGGCyTSKafFh+lMFq9YrUvJMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello @Rob Herring,

Please find my inline comments below with tag[Piyush]

Regards,
Piyush Mehta

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, June 18, 2022 4:18 AM
> To: Piyush Mehta <piyush.mehta@xilinx.com>
> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
> balbi@kernel.org; linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; michal.simek@xilinx.com; git@xilinx.com;
> sivadur@xilinx.com
> Subject: Re: [PATCH 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing=
 crc
> error after resume bug
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Mon, Jun 13, 2022 at 06:17:03PM +0530, Piyush Mehta wrote:
> > When configured in HOST mode, after issuing U3/L2 exit controller
> > fails to send proper CRC checksum in CRC5 field. Because of this
> > behavior Transaction Error is generated, resulting in reset and
> > re-enumeration of usb device attached. Enabling chicken bit 10 of
> > GUCTL1 will correct this problem.
> >
> > When this bit is set to '1', the UTMI/ULPI opmode will be changed to
> > "normal" along with HS terminations after EOR. This option is to
> > support certain legacy UTMI/ULPI PHYs.
> >
> > Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> > ---
> >  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
> > drivers/usb/dwc3/core.h |  6 ++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> > e027c0420dc3..8afc025390d2 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1140,6 +1140,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >               dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
> >       }
> >
> > +     /*
> > +      * When configured in HOST mode, after issuing U3/L2 exit control=
ler
> > +      * fails to send proper CRC checksum in CRC5 feild. Because of th=
is
> > +      * behaviour Transaction Error is generated, resulting in reset a=
nd
> > +      * re-enumeration of usb device attached. Enabling bit 10 of GUCT=
L1
> > +      * will correct this problem. This option is to support certain
> > +      * legacy ULPI PHYs.
> > +      */
> > +     if (dwc->enable_guctl1_resume_quirk) {
>=20
> What's the downside to just always doing this?
[Piyush]

This bit is global user control register in host mode and is for USB 2.0 op=
mode behavior in HS Resume.
- When this bit is set to '1', the ULPI opmode will be changed to 'normal' =
along with HS terminations after EOR. This option is to support certain leg=
acy ULPI PHYs.
- When this bit is set to '0', the ULPI opmode will be changed to 'normal' =
2us after HS terminations change after EOR. This is the default behavior.

Normally this bit is set 0. If the customer PHY requires the opmode behavio=
r other way, like changing it along with term/xcvr select signals, then the=
y can set this bit to 1. Fyi , this is not based on any spec reference, rat=
her just based on the PHY implementation by different vendors.

So as a conclusion, this bit is specific to phy requirement and as moreover=
 related vendor specific.

>=20
> > +             reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL1);
> > +             reg |=3D DWC3_GUCTL1_RESUME_QUIRK;
> > +             dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
> > +     }
> > +
> >       if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
> >               reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL1);
> >
> > @@ -1483,6 +1497,8 @@ static void dwc3_get_properties(struct dwc3
> *dwc)
> >                               "snps,dis-del-phy-power-chg-quirk");
> >       dwc->dis_tx_ipgap_linecheck_quirk =3D device_property_read_bool(d=
ev,
> >                               "snps,dis-tx-ipgap-linecheck-quirk");
> > +     dwc->enable_guctl1_resume_quirk =3D device_property_read_bool(dev=
,
> > +                             "snps,enable_guctl1_resume_quirk");
> >       dwc->parkmode_disable_ss_quirk =3D device_property_read_bool(dev,
> >                               "snps,parkmode-disable-ss-quirk");
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> > 81c486b3941c..e386209f0e1b 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -397,6 +397,9 @@
> >  #define DWC3_GUCTL_REFCLKPER_MASK            0xffc00000
> >  #define DWC3_GUCTL_REFCLKPER_SEL             22
> >
> > +/* Global User Control Register 1 */
> > +#define DWC3_GUCTL1_RESUME_QUIRK             BIT(10)
> > +
> >  /* Global User Control Register 2 */
> >  #define DWC3_GUCTL2_RST_ACTBITLATER          BIT(14)
> >
> > @@ -1093,6 +1096,8 @@ struct dwc3_scratchpad_array {
> >   *                   change quirk.
> >   * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
> >   *                   check during HS transmit.
> > + * @enable_guctl1_resume_quirk: Set if we enable quirk for fixing
> improper crc
> > + *                   generation after resume from suspend.
> >   * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpee=
d
> >   *                   instances in park mode.
> >   * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk @@
> > -1308,6 +1313,7 @@ struct dwc3 {
> >       unsigned                dis_u2_freeclk_exists_quirk:1;
> >       unsigned                dis_del_phy_power_chg_quirk:1;
> >       unsigned                dis_tx_ipgap_linecheck_quirk:1;
> > +     unsigned                enable_guctl1_resume_quirk:1;
> >       unsigned                parkmode_disable_ss_quirk:1;
> >
> >       unsigned                tx_de_emphasis_quirk:1;
> > --
> > 2.17.1
> >
> >
