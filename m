Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA5588C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiHCMh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHCMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:37:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAC24F05
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPnHZKlCD7QdePBynOM8q1yvcGAWUQqUJ5npvQbrr71ELDGxUtQZnE60blvVuPB3JDgNPlYJm5KWqPIXTNANJJtToPcHU/MHnxxO9DKytpVAKCMix0pf6THEXtYmk1C3/F/2a4/c0T7hLjlcNtatVZ3kWxDcGsuz3ysk6kMB6nTEjLIdKDJmhWk0K/n9T5x/6UlZ8b4JjNCLBGiAsyYMQCKFnvzsCrcx+JIS7SjuK8Us7tOnCsAbips6QDuo6SvX8bOxhuDiuRQUq91AIRhT+e187bCFwEU3s2UhoEUNDkIqjL1zZPq3ZSFAQyO6suu65N52QEHAkNFHp/pLEPfEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx3SKa5Q59OoxHYn/oiZFMOoSqk57thxdLgQqGVFVe8=;
 b=ZeJVm3R6JX7EY3a7LVsPW/Wf0oLp8RK3CiePqr3wDMd8ZzQNjHr1TRLNYk/JV41+ixQ8fiN7rjUdM8MViYYoUj+10eI1IpVy+iGiEFKi+RZ6ZSLf2+J5oT5qszsIFt3NrVgxXRRrO+Jb2pKSykRdSavMq0Wyy64rkUriI+/qLcWT/CVRm1ctq6Vc3dLBEtzqxA1Zonjunv5hZz8h5gKcBl2losYEOak/ur1NtsqmmsKdwPJSUP7jq6YCZdxI1Owxg4d7NJJ3bnSL+O/SKahsk6HLE6EodITJCXwVxtoUCSToKJTp74np/EjWKbT+Np3rZkL7aMqgHEWRfXNgI5IlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx3SKa5Q59OoxHYn/oiZFMOoSqk57thxdLgQqGVFVe8=;
 b=paGsiQpJmX44t80rwsFBLUS9YEZOmwhHcFl7Ap6W7S/mEvn0yw33gn8LX7hu8ls+2kzMbKz0fk8LkfEAqUg2ti1v0P7PM60jwZe6WFE3Bjz6mKWnD5SPUPUjcazW4b59ED1HorRQ4Euv+/XSwBcIoxPUCoF5deYbQeLsZ9wTXXc=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by MW2PR12MB2345.namprd12.prod.outlook.com (2603:10b6:907:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 12:37:16 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec%6]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 12:37:16 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gic-its
 domain as parent
Thread-Topic: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with
 gic-its domain as parent
Thread-Index: AQHYpzRgdVlYVwtHmECHDGmKRNvx7a2dG/WAgAABFwA=
Date:   Wed, 3 Aug 2022 12:37:16 +0000
Message-ID: <DM6PR12MB308280D48C11912EF02DBF06E89C9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220803122655.100254-2-nipun.gupta@amd.com> <YuprA2OdGH6LSnZD@kroah.com>
In-Reply-To: <YuprA2OdGH6LSnZD@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-03T12:38:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4fe479b3-f9b8-470e-8374-ea42e8451487;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37836a3e-25c9-4af6-ed67-08da754ce617
x-ms-traffictypediagnostic: MW2PR12MB2345:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+YeQCeb4WcBEndhC0rqJ5jK3AQA/c2QNNf+Nib1DiyvOvH74SbF3X/3PSoZsGaWBROl6J5iF20IByzBro29/CzyRDxjbqAKKU/4YgkKZJa6KPAiIHDZT6HXCucT4x5uAvRa5wetdHiBN7U2Q9nrc8JENQjoDSnu6jvveuKTt6GuDET8XW9RhYHOSxC8QooXQHGGz0wbtA96hionzMpGhHq2ND5/dxgzLmpbOf+mAmka/A69P06nKbvgJQergoDpc7JrgF1bl3nVcI/lgG0ipLGqhDvff4Wh2X1Ghuyr3bS28pg060l1fezt/gvmBWtx6TuDrl7Xi+sEBPH9zjGEI5kwpmNhcshpJzmca2tUnP/W8K+iodN7ZmpnLIceqYvlnY7I+q1zY8STQnZXeYy+F6WmF2iL2jXI4OR00ki8/fToJC+hzKyeaV9BFOI0Ftl7mtqku/cEgD4/5a7Y+9WUkP2ZrklGpzQjh/4Cc+wdme1/LDN+Tlg+PHXy24IA4HKYfc8xssEgnpzGCx5x+BIKFgDGf252Ab03w0xbeIlY7pAGe8eNtgaBod+t+Bp8QW6VSID8R/5DpSen5T1CQRK0K+tUlh114RvS+F5LkfRJR154eZZ/QrZ4GMGaf4jyMFfI+Os13YbrpgspPX2DvCR2IvT2kRxCjoAHAekuVLL1CmQ9YNZJEywwTW/ZjYRPBAXLACzgqH9l6KGDhZcWUEZmf5mYyOosxkDbsQ97j07svtIsjKW5Kt+LqbCmkvvSohcfmWu54oAmBWumi+7AUI+QgGAr+Onpi2L+dWpWbIRYW/UiSqVUn1TGpvZkRGYsoUKR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(7696005)(76116006)(6506007)(41300700001)(26005)(5660300002)(9686003)(38100700002)(122000001)(33656002)(55236004)(38070700005)(53546011)(55016003)(316002)(186003)(52536014)(83380400001)(478600001)(66946007)(4326008)(71200400001)(8676002)(66476007)(66446008)(64756008)(66556008)(86362001)(8936002)(6916009)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7AonW08/q8Bl2zbMCmfV4cMU4AmHpJp+NgOFEtL/g4ciNQ5bObhCNLINx8Aj?=
 =?us-ascii?Q?43e3fU/t4MTQwnheWaSP6rxNpShoeWdd1pC2DVHM0LsgF3GXwSwzwdSlKjdA?=
 =?us-ascii?Q?QLG1k1m/LknaRx8sZ2EhhlNFCyC0Qzuf0ejH6FGNBAINXLj/3vD4b+CP2kRH?=
 =?us-ascii?Q?bYYoV4wPv5cGQiJQrHU4lIitZX1a1/wGxs6n7Pg0IhRwyB948XyHL/5hODfp?=
 =?us-ascii?Q?rQTYIcZg6rvWw5W09A+WsZZEH8veo0s+/z8pUWIL4z6MiMpFnORmo+cagKBC?=
 =?us-ascii?Q?L9ntC3JoHCwrKGcUzw6hyUxtK20/bWDx1c5fwPieRJgPyIu2L2H97zzXr0I8?=
 =?us-ascii?Q?+ODwXn2sLzvZkZGVG3KYpxDkpfyhdNHWkuPZOYke4kv85eYEBZnsH9r4P0ZF?=
 =?us-ascii?Q?Zvz1oEeTMM8c3fPpTAooelGgmGvgZSSUkHn+tNcOqj6g6JXV3jwsEGWpRHix?=
 =?us-ascii?Q?oC+zQFHnzQCeNBgA2yt/lUZt//bjz9/cTw6v2X281TQIZLV8SVpB8yj0XYv+?=
 =?us-ascii?Q?pzQ7aXbPYfRTlfa0YZ/tcTG73KDwx4FJSwNVmbj3nfoGaZZnPijSMdy/1vMw?=
 =?us-ascii?Q?/XBFN+7y2wkD0tyUTeL8bhycNTm4pEkRVole8Gsc/dOvCPBNPSDUOpC9UPJc?=
 =?us-ascii?Q?lv0pIZ6LG3PyIT5VTj1jCLIRgeUPNH0GDAsREhHV7gEf2qIUaZxs8zhy4OwD?=
 =?us-ascii?Q?PlKJCcIacP0GgNbXW+NDFAZNgJy0zDgIXLOaGMMYa4rw68Yr9XMims3VEaCg?=
 =?us-ascii?Q?xfLYknTKvwgTpMbCCFq5UA/ERFBViM3HIbsTz+MK4/2BANQSIYNEIAPRFQhr?=
 =?us-ascii?Q?syZhmrtyMDgqkXKBPuHXVObs0RN5KeTT/ZJOAW97evh2grb6zg84STLSPFC3?=
 =?us-ascii?Q?HJo5V3cjZroUhkOhjrIBjlTiHc1Qhtn/NWXQ+a0KYQr2mSYgQx37o5udscYx?=
 =?us-ascii?Q?EUAHg9QrRhBQ7jtxPK4Yr/62crY+2jr6GTSmsw07lXnZI0ySwhzRSaYOQew0?=
 =?us-ascii?Q?2xgJu7QtdXgn2t5nnS3gl+gAjsr4y9ZQdMAd3fxg+lycCObArArgxeTpCQr+?=
 =?us-ascii?Q?0sCpeAldSMJ8RDalR9K7DXMnZmU9d3sgQPzCBQLPPfqxH+9hqN191hZs+kW7?=
 =?us-ascii?Q?xGy8CjEQ0q6RhCOy+EJeYdgjuG7qsX8chtDvNxHAzTKixIfkgkp3YGCKDwHR?=
 =?us-ascii?Q?Vbf7B56WVNRxjHdNjkXHa8L3WYprh+kWCQG7q/hiTTOXnQ7wn0AQojVbCLEA?=
 =?us-ascii?Q?Ua8Kiskum2i5tLyLJPa9cd3KnnXjjL8EkQ/ktEG9wXBvkTqJbGI56/uukovc?=
 =?us-ascii?Q?BCg5OmrE7w/C8q/yOwJ9QzzgM10j3NtNx4MqQ3r4zWD3XGtMIFFoMWTbNdzz?=
 =?us-ascii?Q?ElggiHZn7mWubBvgh6MV9aatOn2WMHhaZZrPaG6x1lLTceRCV2a3MTNn6IIX?=
 =?us-ascii?Q?fzdgK6tzzFxynVLt2JqGZyOQPxz9xsU2BnMbkXi+DAtbRuK8rQHGDeFjT5NU?=
 =?us-ascii?Q?RmTsuqxkj/nG0oTMZMOrpxy6XpmKMUPekqQjjuvtEKmnbuCvBNtcpKAC+dkL?=
 =?us-ascii?Q?WlUIyPg1S79LC0CS1tA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37836a3e-25c9-4af6-ed67-08da754ce617
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 12:37:16.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aT3sOiGMSkEkwcoxR34Zg/5d5g7edwyL3RTazCaVKn2ZJUH4nHv4ZuXUHZG0c/tL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 3, 2022 6:03 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> rafael@kernel.org; maz@kernel.org; tglx@linutronix.de; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Subject: Re: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gi=
c-its
> domain as parent
>=20
> On Wed, Aug 03, 2022 at 05:56:54PM +0530, Nipun Gupta wrote:
> > Devices on cdx bus are dynamically detected and registered using
> > platform_device_register API. As these devices are not linked to
> > of node they need a separate MSI domain for handling device ID
> > to be provided to the GIC ITS domain.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> > CONFIG_CDX_BUS and device tree bindings for xlnx,cdx-controller-1.0
> > would be added as part of CDX bus patches
> >
> >  drivers/irqchip/Makefile                 |   1 +
> >  drivers/irqchip/irq-gic-v3-its-cdx-msi.c | 113 +++++++++++++++++++++++
> >  include/linux/cdx/cdx.h                  |  15 +++
> >  3 files changed, 129 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-gic-v3-its-cdx-msi.c
> >  create mode 100644 include/linux/cdx/cdx.h
> >
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 5b67450a9538..623adb8a1f20 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -115,3 +115,4 @@ obj-$(CONFIG_WPCM450_AIC)         +=3D irq-wpcm450-
> aic.o
> >  obj-$(CONFIG_IRQ_IDT3243X)           +=3D irq-idt3243x.o
> >  obj-$(CONFIG_APPLE_AIC)                      +=3D irq-apple-aic.o
> >  obj-$(CONFIG_MCHP_EIC)                       +=3D irq-mchp-eic.o
> > +obj-$(CONFIG_CDX_BUS)                        +=3D irq-gic-v3-its-cdx-m=
si.o
> > diff --git a/drivers/irqchip/irq-gic-v3-its-cdx-msi.c b/drivers/irqchip=
/irq-gic-v3-
> its-cdx-msi.c
> > new file mode 100644
> > index 000000000000..eb17b74efdc5
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-gic-v3-its-cdx-msi.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * AMD CDX bus driver MSI support
> > + *
> > + * Copyright(C) 2022 Xilinx Inc.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/msi.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/cdx/cdx.h>
> > +
> > +static struct irq_chip its_msi_irq_chip =3D {
> > +     .name =3D "ITS-fMSI",
> > +     .irq_mask =3D irq_chip_mask_parent,
> > +     .irq_unmask =3D irq_chip_unmask_parent,
> > +     .irq_eoi =3D irq_chip_eoi_parent,
> > +     .irq_set_affinity =3D msi_domain_set_affinity
> > +};
> > +
> > +static int its_cdx_msi_prepare(struct irq_domain *msi_domain,
> > +                               struct device *dev,
> > +                               int nvec, msi_alloc_info_t *info)
> > +{
> > +     struct msi_domain_info *msi_info;
> > +     struct cdx_device_data *dev_data;
> > +     u32 dev_id;
> > +
> > +     dev_data =3D dev->platform_data;
> > +     dev_id =3D dev_data->dev_id;
> > +
> > +     /* Set the device Id to be passed to the GIC-ITS */
> > +     info->scratchpad[0].ul =3D dev_id;
> > +
> > +     msi_info =3D msi_get_domain_info(msi_domain->parent);
> > +
> > +     /* Allocate at least 32 MSIs, and always as a power of 2 */
> > +     nvec =3D max_t(int, 32, roundup_pow_of_two(nvec));
> > +     return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, =
info);
> > +}
> > +
> > +static struct msi_domain_ops its_cdx_msi_ops __ro_after_init =3D {
> > +     .msi_prepare =3D its_cdx_msi_prepare,
> > +};
> > +
> > +static struct msi_domain_info its_cdx_msi_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS),
> > +     .ops    =3D &its_cdx_msi_ops,
> > +     .chip   =3D &its_msi_irq_chip,
> > +};
> > +
> > +static const struct of_device_id cdx_device_id[] =3D {
> > +     {.compatible =3D "xlnx,cdx-controller-1.0", },
> > +     {},
> > +};
> > +
> > +struct irq_domain *get_parent(struct fwnode_handle *handle)
> > +{
> > +     return irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
> > +}
> > +
> > +static void __init its_cdx_msi_init_one(struct device_node *np,
> > +                                 const char *name)
> > +{
> > +     struct irq_domain *parent;
> > +     struct irq_domain *cdx_msi_domain;
> > +     struct fwnode_handle *fwnode_handle;
> > +     struct device_node *parent_node;
> > +
> > +     parent_node =3D of_parse_phandle(np, "msi-parent", 0);
> > +
> > +     parent =3D get_parent(of_node_to_fwnode(parent_node));
> > +     if (!parent || !msi_get_domain_info(parent)) {
> > +             pr_err("%s: unable to locate ITS domain\n", name);
> > +             return;
> > +     }
> > +
> > +     fwnode_handle =3D of_node_to_fwnode(np);
> > +     cdx_msi_domain =3D platform_msi_create_irq_domain(fwnode_handle,
> > +                                             &its_cdx_msi_domain_info,
> > +                                             parent);
> > +     if (!cdx_msi_domain) {
> > +             pr_err("%s: unable to create cdx bus domain\n", name);
> > +             return;
> > +     }
> > +
> > +     pr_info("cdx bus MSI: %s domain created\n", name);
>=20
> When drivers work properly, they should be quiet.
>=20
> Also, when drivers print lines to the kernel log, they need to use the
> dev_*() calls, not "raw" pr_*() calls please.

Totally agree on this.
Will be updated in the formal series.

Thanks,
Nipun

>=20
> thanks,
>=20
> greg k-h
