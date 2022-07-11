Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41869570884
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiGKQp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGKQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:45:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4163C8E7;
        Mon, 11 Jul 2022 09:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeEIB4iZwQVNTvxREB64Euq57cJ/Q1XMg7ItWQxKyxrtgp46R/PtehRuUrg6Tt/yBicQi4lVspIxqlEouSZiDCfDWWbs8jZIPVucopRzBsPuHebxcLs7vRpt1UlThCPKVQ4c8fJ0dcefoyeTjarLmF+rhmuy8lKi5gzZkHs6r4mz1lmOYHyE2JfoolJVnWDLrrub1dpuTipwPu9bPWkLzlCKFoZr7o+LarxCL12emQsdq7vut+dxVp+c2Y0fMO6M/MUnWhMwscsDWG5CU+M8863p25k5tvc+xB9s76+wHQoQZMoW8wUx+rfRVwo5MD4fVNpS/c5V6/1kzy3W5bpeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an54bch2zhV6Y5rBYjaYqgaK3QmYAxLoBPWHCF9Ljpo=;
 b=EeC0EYePBrYbPBbknIC2+fldiNlq4OS//PjR/kleL/c7aC12Y+Q/1l2LSenp2YNjYJLBIhyjR0sZlN2fs2pNSd9+8rVhA8YtYy1y5ZVCkSE+q0HXLzIYr+wbAKehYFcQVRy5+jjosy433alXNaP+44Jsf4MDI21Z6RUeaZ33Rc9l26VV02k+JrBJRvZ4qDTnvFCNeuCkiWPoT8rUaf0fn+o/vH30SjnZB4uVLTNl5ULUXYEvWXKqFEbjbBlqILNGHseXNK0Kuo5SrmdjylPgC65DdAaD1ouI37oaj6ksCYGNXtbE5InjmlYnb1vuDgqUqtByub0m0dXMGM9r1SLssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an54bch2zhV6Y5rBYjaYqgaK3QmYAxLoBPWHCF9Ljpo=;
 b=JsVBevA8GIl4fWqkyQDeuUb1SV0kj04jTbEWi0zDJ1nDEme68UoP2tQiy5QPhV1YkXoGL90OmiOGePtPTxdb4rHUpPTyRM383LaOfdcwVQU8OHbx/xynjbOUUzzE9OrXhNKf7fdzDKaYZrnJs+UpIW7ENOLjNuqzyTQtu8eYHJI=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by BYAPR12MB4694.namprd12.prod.outlook.com (2603:10b6:a03:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 16:45:20 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::69d7:4030:98ab:3593]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::69d7:4030:98ab:3593%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 16:45:20 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "sivadur@xilinx.com" <sivadur@xilinx.com>,
        "radheys@xilinx.com" <radheys@xilinx.com>
Subject: RE: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Thread-Topic: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Thread-Index: AQHYb2cEXoSLgZPquEiCXVJMPsCDdq1sCocAgA2hGAA=
Date:   Mon, 11 Jul 2022 16:45:20 +0000
Message-ID: <MN2PR12MB4333A5DB77BC767A01A7AA2688879@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220524120802.9394-1-piyush.mehta@xilinx.com>
 <20220703003434.GA1382015@Peter>
In-Reply-To: <20220703003434.GA1382015@Peter>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b182ff7-00fe-4541-ace7-08da635cbe06
x-ms-traffictypediagnostic: BYAPR12MB4694:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doenBpOZSqxaIxUR0ECRVSmrbP7/VpPvcm5QX36oiPsy9JiMVZUThIA9wNvcheAxyY1fLJMZNxIdi+RAMiq9Y9lEYpmZfrmDFeJvO1lBN9LnxU8fcH2KczkhLCuGTm6EvJj2B94VLz/oj3x295PIaYiTN7TI/2JkLmdEzviqc5pFR9WMNt3QWVrY3E0NhwYWvqIFEwO2HHj6OjpOSMRsIqnaVZmiCi0t4meTnP+FhINzttrjVLg/ez6yiQnAaggxUn+VAUjHjVylLSl4Kn6hFUtEX1WFn1EyL8Bp7AStaztxSEK8JCgeTYI9+gIEYqXJMNpEi0st3PGih2iw3jX0/qT/ud1DlsdrjXGwAnklitrcm+T64gdKSSlIiLvGd6euKzaghSBBQr4T6xkQiwDJ9MenB8y6pIm27SmEsFBkchUzP95g47kSBuKIMo1dPlqep3s6GHewmhkfcy77InXbruBL7pXmkxjhmvC4K1npGDv3H1gxf4Z9SSjoAmvl68To3gzvjhroWA2P6O12ZCKbwGbz2ZXE//TzzucgDgQnflJjQmWvErApj1rMgprbnuQ9twHvw5DfE4DWlpu7e/Lv+Hk2uY+6DbOpaqF8b4Q6CA3uAE42o98kLWFlTkbObPgDum8lg5L+RzpqjA/9tuem2lCPJANSxczfYGfgjY8P1CH2CoPqlgH1rgBD1xAo/b+nONB+ZUhfbVzAINKFLCVnt62E5aC2JBdi/WHsXIfpKB/mxfHYY9u49p/m25p9+3lEcSNNY/mODtV4toZBnoHVt7sPrVwBF0GhrLhQNHC0HV2xwHKvkZQhQ41fy4yst2+l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(478600001)(76116006)(53546011)(7696005)(41300700001)(6506007)(64756008)(38100700002)(66476007)(66556008)(4326008)(107886003)(122000001)(38070700005)(186003)(83380400001)(9686003)(8936002)(52536014)(55016003)(33656002)(2906002)(316002)(8676002)(66446008)(110136005)(86362001)(71200400001)(5660300002)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2oYeRgqsKe5pW5SKS4aNuA5sDn6Mhr0mA2Mpk82u62gKPspy5YqLFt6+6Ue7?=
 =?us-ascii?Q?ZUXWsH+PTQkhMUU4cs8lkrSz8zhUBlqtUMXXraEeMUVCMpN+ZyWEgdTL5Kpy?=
 =?us-ascii?Q?/O5yeNIz3r+0XdN4lURxPHdmaqFAxYRAYEdFk/oD/TtAwnEifAd9s3bWmw3k?=
 =?us-ascii?Q?iLwrFNjA0Q1bowh/DzDxb4y3KjAKtx0Bse4/Oj6lUf9fkit601zcugRSsLVy?=
 =?us-ascii?Q?Z7HlNz8gH6Gpo2NQNHKKwnd538d0x5tMfQEx2SH+qq4r5j7OHYeCKsVpMh0U?=
 =?us-ascii?Q?H0VkAWIY98dy8aq5B5GOM/3BVGmwDQf0oYvlcci/sL0EzhQeEQlROZtxXmw/?=
 =?us-ascii?Q?gXFCQUWNM880ozCuieynGSycnyFKzsMcDAmpEHLxDRESA9xgRwYO1VxhXvyo?=
 =?us-ascii?Q?OEjOs+RHvtg7EuMPC2jONnY8mjul/Yx+tSOb1RU7iPjzLDaOy9uXRCr+nMzp?=
 =?us-ascii?Q?qjy0EuoWdh2WV/RxRFGcuDTJUZykl1bqrUcmnk8lJmtl58MAn86KPVWmzAVI?=
 =?us-ascii?Q?3Tjki1RlKHl9QjmKyeayrx3kg8Jqrxy31w+/4/umyKaGkGFSBz6aWsVYP/sV?=
 =?us-ascii?Q?J2g7m+yqNI8PtgiughlVcD56CSA4+6nOE/ehoK0bs9RgO5UrEqZEn0r/nDH7?=
 =?us-ascii?Q?aX8y1kCKpf4lebPACznVHG16O9lZxfG2/uhvdDB/w7Iv/gRIUxmPMGnnbn9a?=
 =?us-ascii?Q?SiESLuCVCdQdt2R1i0dvH+mZSQljMvASfT/R+OvnI8DxAZ6MbZ0otEwJ4uyC?=
 =?us-ascii?Q?LUXHaq4qIMG+eCAbbZfLFWudNeT1mKO5GUrANv7qQFpxbejP6ixIlsnuowDX?=
 =?us-ascii?Q?AdreiFPI9cXy1DGfivLeSlkSR8Trz+xz9EocNdRIuRDbnOspnh+06LgiLF+q?=
 =?us-ascii?Q?8bmcsd6LRKQ90a+FWYza4EYCFNuDenexCFDIQdhlfvmcJIt+ocw0m8Z+kQej?=
 =?us-ascii?Q?5e0ZDbpp7/NSu7AuAuatmOocy7H/Jkv4gSemrQgnTmDPTXCAKsP73yJyHRMr?=
 =?us-ascii?Q?4nAG5CYRkDytEoGzyFf86IwaoKBGXhAC+Vg+jNVKM/O68oiZn0bM6ME847ym?=
 =?us-ascii?Q?rc/fie76TTXYp2Skk7nXI+22f/18Qv+4uS/EnufTDSWWNzXo4FAZJ+1c5jnC?=
 =?us-ascii?Q?mvyS/5hos5ZK8YjPXH2pb9nV9lmywp4TkQu8nR9y2StmsrgkO0CdnXtBbtYh?=
 =?us-ascii?Q?em1YCVcZ42TT0/PALaMdnyl7vsbiJ+oxibYjKf6a0yd717jwj+vikpnMV1rE?=
 =?us-ascii?Q?WndY/Jzmi8/XOeoi2Kk+OPjG3fzycRn8R18yJj/i62cZ0zn+6ftJMNiQzVKL?=
 =?us-ascii?Q?VAXvLAl8KZzLe7v0Ay4sDuHC75BL3dkWyNAj8DlJ93RG2bOQrcHqWa3v5UEt?=
 =?us-ascii?Q?fE5UlfMlHa4Yj7i9dinjdpG4YOogeRCulaGp0lkLaR/f+fp8zUNPPS9pV69e?=
 =?us-ascii?Q?h5X8fXFMoAH+kri4hDxHaMhNmOaX9Ht8SuboImlU/1YQn9VHNp0ByHAmqbzY?=
 =?us-ascii?Q?/iFZiAPT2Pi+G6srTC2s6soL3eCp4fbGFF9TjTIqcrT3NAWxlbO67KNtnMGa?=
 =?us-ascii?Q?hOQK1kEn3RRrCuYie2Fs3v8skVfFVG44Jhe5fu3QatZHqnyjpFWJjbdrfGSK?=
 =?us-ascii?Q?wPMWEhVuS40PK10Y5+51PqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b182ff7-00fe-4541-ace7-08da635cbe06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 16:45:20.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEkMOQE7CAulwFUNs+iEcYiJaOrrem59nkpwiimfBlNCE2JGOm0whl8/DjaRBX6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thanks for the review.
Yes, we are supporting OTG feature and have used OTG FSM platform.

Regards,
Piyush Mehta=20

> -----Original Message-----
> From: Peter Chen <peter.chen@kernel.org>
> Sent: Sunday, July 3, 2022 6:05 AM
> To: Piyush Mehta <piyush.mehta@xilinx.com>
> Cc: gregkh@linuxfoundation.org; michal.simek@xilinx.com; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; git@xilinx.com;
> sivadur@xilinx.com; radheys@xilinx.com
> Subject: Re: [RFC PATCH] usb: chipidea: Add support for VBUS control with
> PHY
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On 22-05-24 17:38:02, Piyush Mehta wrote:
> > Some platforms make use of VBUS control over PHY which means
> > controller driver has to access PHY registers to turn on/off VBUS
> > line.This patch adds support for such platforms in chipidea.
> >
> > Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control
> feature.
> >
> > Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> > ---
> > We have created this patch as RFC, as I introduced a new flag
> > (CI_HDRC_PHY_VBUS_CONTROL) and would like to get comment if it's the
> > proper way to check for VBus support for zynq.
> > ---
> >  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
> >  drivers/usb/chipidea/host.c         | 7 +++++++
> >  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
> >  include/linux/usb/chipidea.h        | 1 +
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c
> > b/drivers/usb/chipidea/ci_hdrc_usb2.c
> > index 89e1d82..dc86b12 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> > @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data
> > ci_default_pdata =3D {
> >
> >  static const struct ci_hdrc_platform_data ci_zynq_pdata =3D {
> >       .capoffset      =3D DEF_CAPOFFSET,
> > +     .flags          =3D CI_HDRC_PHY_VBUS_CONTROL,
> >  };
> >
> >  static const struct ci_hdrc_platform_data ci_zevio_pdata =3D { diff
> > --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index bdc3885..bc3634a 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -63,6 +63,13 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, in=
t
> portnum, bool enable)
> >               priv->enabled =3D enable;
> >       }
> >
> > +     if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL) {
> > +             if (enable)
> > +                     usb_phy_vbus_on(ci->usb_phy);
> > +             else
> > +                     usb_phy_vbus_off(ci->usb_phy);
> > +     }
> > +
> >       if (enable && (ci->platdata->phy_mode =3D=3D
> USBPHY_INTERFACE_MODE_HSIC)) {
> >               /*
> >                * Marvell 28nm HSIC PHY requires forcing the port to HS =
mode.
> > diff --git a/drivers/usb/chipidea/otg_fsm.c
> > b/drivers/usb/chipidea/otg_fsm.c index 6ed4b00..5ed9164 100644
> > --- a/drivers/usb/chipidea/otg_fsm.c
> > +++ b/drivers/usb/chipidea/otg_fsm.c
> > @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm,
> int on)
> >                               return;
> >                       }
> >               }
> > +
> > +             if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> > +                     usb_phy_vbus_on(ci->usb_phy);
> > +
> >               /* Disable data pulse irq */
> >               hw_write_otgsc(ci, OTGSC_DPIE, 0);
> >
> > @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, in=
t
> on)
> >               if (ci->platdata->reg_vbus)
> >                       regulator_disable(ci->platdata->reg_vbus);
> >
> > +             if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> > +                     usb_phy_vbus_off(ci->usb_phy);
> > +
>=20
> Have your platform used OTG FSM? If not used, do not need to change it.
> Otherwise, it is okay for me.
>=20
> Peter
>=20
> >               fsm->a_bus_drop =3D 1;
> >               fsm->a_bus_req =3D 0;
> >       }
> > diff --git a/include/linux/usb/chipidea.h
> > b/include/linux/usb/chipidea.h index edf3342..ee38835 100644
> > --- a/include/linux/usb/chipidea.h
> > +++ b/include/linux/usb/chipidea.h
> > @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {  #define
> > CI_HDRC_REQUIRES_ALIGNED_DMA BIT(13)
> >  #define CI_HDRC_IMX_IS_HSIC          BIT(14)
> >  #define CI_HDRC_PMQOS                        BIT(15)
> > +#define CI_HDRC_PHY_VBUS_CONTROL     BIT(16)
> >       enum usb_dr_mode        dr_mode;
> >  #define CI_HDRC_CONTROLLER_RESET_EVENT               0
> >  #define CI_HDRC_CONTROLLER_STOPPED_EVENT     1
> > --
> > 2.7.4
> >
>=20
> --
>=20
> Thanks,
> Peter Chen

