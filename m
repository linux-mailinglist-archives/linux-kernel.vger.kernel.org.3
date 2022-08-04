Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C25899D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiHDJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiHDJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:18:22 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47A3A481
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa7iXC9DxNb8OzSIIV2jA9Cm24RZDf+RQYtseJr6A21kNQHAZQ/hRoRQDaolbtVgrDv5HQkeE1k7rNyFE0thgMH/0FmdePX/yEcdScjWi6901arWpovnvdwJaNBpgKwpgcPO5WWhTex0orT2yYKlT/9ob8uCHdtWdLh8ee165b2sZ3UKy7Evzp1jyZ61bvj9Aag7DtkxMP2HisChT5/7l/jkNIq4hLizHIMGfJ/ifexhcgjjQYjOXKNANEfbfv2XyBXxAGchpGI8YOuAb+KkoejbY3mzI1gP54RalwbJ/bYotFAMjqKKOUWKNTRZSnrSf7NjvWwILJBhwIancs1VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5LjKKhRKB63oQS03nRuK9X8Br1RCnNluT5uCUZ6bCg=;
 b=hNCWzTePxOgjZDqQkl+BkTwxA4IkwRNU5HgLAmYdcPZxiIq+ORl+dnjoI5Bz7LfnQbx0/ksaVfuUO6WZZ1/pIeqphn1+cQya/okLFp+qxlM+BwibGJD49pKwV3k+zuxzKJJ2SN1ChDm18YaTbFQ0rVQ0ORbbXYE4FsQhP9EU4+JHYL1sePYPeufhs8DjvM/opjfVurCnJGSBBtN/QwbPL32PM+Vj/1evw6+occnBVVcCZWNmtEGKI5Tl4zLWLx6+XlL2MpfANifvREqekwIbBRVDRNxlBg5q9B6hL19CEvzfMnaUoq7igIxdL17DbXyPGFPKg9wQhqka1ItXuW263Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5LjKKhRKB63oQS03nRuK9X8Br1RCnNluT5uCUZ6bCg=;
 b=E6dPY6nPZyBhJluUm4yzPZDtM/DSyyeDTaknK83ujpVouUb8890xmDREuIcztWVhqKZQd3KvtET2kPMeIOGdbSdQTM/1D6kx2rPVAVx/GBL+/BwTexPEyJ5XMk6SepxDQcy0vsoyzN4MnIPkJwJFoRYSHJcTv4WgtKtwkDOZCcI=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Thu, 4 Aug
 2022 09:18:19 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec%6]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 09:18:19 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gic-its
 domain as parent
Thread-Topic: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with
 gic-its domain as parent
Thread-Index: AQHYpzRgdVlYVwtHmECHDGmKRNvx7a2eb+cAgAAA0ZA=
Date:   Thu, 4 Aug 2022 09:18:19 +0000
Message-ID: <DM6PR12MB3082B8F57D02A359FC61F449E89F9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
        <20220803122655.100254-2-nipun.gupta@amd.com> <87pmhgwfyp.wl-maz@kernel.org>
In-Reply-To: <87pmhgwfyp.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-04T09:19:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a900e0c4-c21b-4968-acc0-1a66c42281c4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0499c275-6874-4e58-9207-08da75fa455c
x-ms-traffictypediagnostic: DS7PR12MB6359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ILj6/VfTrKBBkoGWsjCyJVijCvZOD/FKH3Wh4XcTF4tL7jNaYaioTgEDgm+WRzCgVGV1xYCPqd2FCTDPAldK/v+RDgpS1hxapJvAfKVIUx8Fhc7ZCGkyUmOvqlXvZ4GwoqYCowFVmYsvcL6Uwsbc5vOIVKBdSl3qXsmpAIC9FRZB2BQJLJv58YtJ/IpSg//SwjnHb6fSjyqX+aEsslPi9tCEFUljN6a8EqnwHCY61COJEUJeC/GEIA3cJwf4sVRpfFqBqrJCxV6FozWDirYnp6cbi01fVS2M6hQgWJsd3byR10ipfgtZcoYG1hUkDmbjKnvD1ZUebqzv713OTaaxk/ZjJpEjgNqmqp1ytYhXOEiMgGvXGFe7oYc02BVA3joxAS3bBE2JWdWVZBqak4tm1pD0COEQA5Wa2RSs9znPVz1e1UiMAJqCws2WDqH0C/Vei3p6Ik4KWgTwn5cNEx1t7gAWri4aHSkd54kMoBHqFl7LOjdsIXeBN58vuadXdlJCeHwpsZUkEsy6otftuwvVaxkOhR+WBCDDGixOhgR9VVhBHn5osLJQo/PWNRVklvDf0BWtnnDaTJTeYlMP06J8IzWrfiqx5KL99c6n+TSO4AJ2qMeMF9nhaebC43NpRy/is6+6riwHbOHhNb9EwrCnwhYlTqOPG049sNkDFFSqHavDpfiB7nwFRQK0Edh/AAD8xXlxCklOm6YXoX1TYcAquyqtAkSLCafHQ5gOWgfKx/++/uZjdNRgUeUMV1QCtqXBtY2ORrvLRKd5Q04f1yOUKGz+suh9TQAdNUGvTkRz7rX9ZLooqgX+DvZ/RC7m/8Do
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(41300700001)(7696005)(26005)(9686003)(71200400001)(478600001)(55016003)(6506007)(33656002)(186003)(54906003)(83380400001)(53546011)(6916009)(38070700005)(66556008)(316002)(86362001)(2906002)(66446008)(64756008)(8676002)(66476007)(76116006)(4326008)(5660300002)(122000001)(8936002)(66946007)(38100700002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8G0LZrFRzhqqk6yZw+z9s3KPukUHHesbVJ+IqBsvcX2oQ8RRX0MDh34mbR8J?=
 =?us-ascii?Q?chAbP84qYRh33evg6gOwiLd+IyIvXZAaAWKUd6SWXrwyqKV3QaQ9o1wm8QvP?=
 =?us-ascii?Q?9Dp36LquK6o7Y3/zRSPNGR6mrvgf4JnTWTOrSb7cusbHIHuT4hKALkLuCxlI?=
 =?us-ascii?Q?pEUkUjoBqAnErHf3GnL9ahCHwg8SRx4AHe+ivhf1MRCKc2MzKDvdyK+2yGAq?=
 =?us-ascii?Q?EYj2J+Tgn3J5MKxjNS5n5MQJnWOJr7JnLyjxp5serF6+XyVrrEmZNcyXRHXC?=
 =?us-ascii?Q?Fiqc7AFyPKhxM0F8YA7cyYb1RWodYv+B71UFz3p7FhZJRJThWMK8Xn2SFwaj?=
 =?us-ascii?Q?zQfjJlZ9iIwe9aNWNsqbJ07/S0RmUwTZo3PiJo0rC9+QQ6wGLHL+znWDcFVV?=
 =?us-ascii?Q?8bp5xV3/GwlAoA2wiW2ApNFomYJMVBvZ3OGUe5PAJLck5XmLNPVomlYYf8Dd?=
 =?us-ascii?Q?yA6603lKR2+zDgjrHo9TmOFXEs6G+4asARtp4xiefX6kfHIB4dqihyTm+wi1?=
 =?us-ascii?Q?TPIuNuaqJe/90CAZ+mcmr/lC1b37pPT9x4o2XYAVcXONQQHrXU/9BKGXGM3g?=
 =?us-ascii?Q?0ugc4cNT+2KZLpKu2tBECnon6nLBBinlHKVpz+a4qCiuZ3xEG+V1913tVAFb?=
 =?us-ascii?Q?syoc+gmfJd/B0NAe1TfxHGwdE00FbNqKp0KxG71buirVt6uivX5Bu87DdYox?=
 =?us-ascii?Q?cB/mL+rP3UhcTZ0fNRtQqQQX0Zq8kBJ8t1aFBC/u/ddXFdbY/KrVNyRBkwLa?=
 =?us-ascii?Q?FqffJ727rnJmzGFXjsjplxAsmcGa5LEO2+/gizEYwkl5b3LIhme7TJkGNuSY?=
 =?us-ascii?Q?eMFSwUe2w2KcPeQJ/jZJtZ01kkoyrxHDLfbDLT5y5dYcVoQnHIkzgcCbYjdw?=
 =?us-ascii?Q?HHTQ7FLEe6IvqXx8d8MvO9zD/ya8FPOeAHhBvaLfPl3YIqdn9rUaDeHphZBP?=
 =?us-ascii?Q?V6b5OegUyVXTc91lZmIctmqPUPNlhf9ywpEViZwo0VUU7AP7ZKnGLraICQrc?=
 =?us-ascii?Q?PYIrqFpB/afHFcXTeLFLJBabNPKOXBijBbpGjWfsfgwl68QpkxLYURZmKLmT?=
 =?us-ascii?Q?0VucqVjmgcToTRXN/6QC3d0nJCZH+daAfV4+QNch1ouIVoeF4LuU6zvvmvi/?=
 =?us-ascii?Q?F8lkZbo/ou+t/05VJoTT6bmyrufK7eK1BrmibQjD9rO0cwUQpj7OWNZsv1db?=
 =?us-ascii?Q?wZfQf5BMUEeXad3geHORcMy8AUJuKw6aP2lv5lhYkIo9pmYPvw3gloFiz8T7?=
 =?us-ascii?Q?z1EGhAnZCj+wK70BXMAge9pcZuhBVuoQMNMxYcY0QNMompsy342sz+Wt18Rt?=
 =?us-ascii?Q?PsVd+8DR5R1sZBwUNPvGg5CBLUk6aIRNX3466c3jK7XGZROSzNaWUGBVD88H?=
 =?us-ascii?Q?+w+DblsIrvPSnEGmisFruSWXM/QBKKkGGdbHAVuRBLWuG0J8qufl2WwA4LKe?=
 =?us-ascii?Q?uFsgYaihIfxZKnbTvwjmkSkWJWyBYM3/Ny462xdGDjpDGLJDyqyewcV6w8Bw?=
 =?us-ascii?Q?GwycpHa69Vhc9GbKxDnwXYV1JhzNs9FqGpJVRnrnA1TFFYy/5d0+tPOcLXdf?=
 =?us-ascii?Q?5pw0xePjiXcovQ9D018=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0499c275-6874-4e58-9207-08da75fa455c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 09:18:19.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7LOCLmWalk2Q//Mu9BnG7YHgdN153OOCReQP+SsBpHraQSouK9YpJ4nSqPsSvaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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
> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, August 4, 2022 2:20 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; rafael@kernel.org; tglx@linutronix.de;
> okaya@kernel.org; Anand, Harpreet <harpreet.anand@amd.com>; Simek,
> Michal <michal.simek@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Subject: Re: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gi=
c-
> its domain as parent
>=20
> [CAUTION: External Email]
>=20
> On Wed, 03 Aug 2022 13:26:54 +0100,
> Nipun Gupta <mailto:nipun.gupta@amd.com> wrote:
> >
> > Devices on cdx bus are dynamically detected and registered using
> > platform_device_register API. As these devices are not linked to
> > of node they need a separate MSI domain for handling device ID
> > to be provided to the GIC ITS domain.
> >
> > Signed-off-by: Nipun Gupta <mailto:nipun.gupta@amd.com>
> > Signed-off-by: Nikhil Agarwal <mailto:nikhil.agarwal@amd.com>
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
> > @@ -115,3 +115,4 @@ obj-$(CONFIG_WPCM450_AIC)         +=3D irq-
> wpcm450-aic.o
> >  obj-$(CONFIG_IRQ_IDT3243X)           +=3D irq-idt3243x.o
> >  obj-$(CONFIG_APPLE_AIC)                      +=3D irq-apple-aic.o
> >  obj-$(CONFIG_MCHP_EIC)                       +=3D irq-mchp-eic.o
> > +obj-$(CONFIG_CDX_BUS)                        +=3D irq-gic-v3-its-cdx-m=
si.o
> > diff --git a/drivers/irqchip/irq-gic-v3-its-cdx-msi.c b/drivers/irqchip=
/irq-gic-
> v3-its-cdx-msi.c
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
> > +     return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec,
> info);
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
>=20
> What is this? If this is supposed to represent am ITS, it really
> should say so.

This is a CDX bus controller, not an ITS. This will be added as a part of
device-tree documentation when we add formal CDX bus patches.
CDX is an upcoming AMD bus, supporting dynamically discovered
FPGA devices.

>=20
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
> > +}
> > +
> > +static void __init its_cdx_of_msi_init(void)
> > +{
> > +     struct device_node *np;
> > +
> > +     for (np =3D of_find_matching_node(NULL, cdx_device_id); np;
> > +          np =3D of_find_matching_node(np, cdx_device_id)) {
> > +             if (!of_device_is_available(np))
> > +                     continue;
> > +
> > +             its_cdx_msi_init_one(np, np->full_name);
> > +     }
> > +}
> > +
> > +static int __init its_cdx_msi_init(void)
> > +{
> > +     its_cdx_of_msi_init();
> > +
> > +     return 0;
> > +}
> > +
> > +early_initcall(its_cdx_msi_init);
>=20
> I really don't think we should have any more of this muck. Yes, the
> other busses are also doing that, but here's our chance to do
> something better.
>=20
> Why can't the *bus* driver (I assume there is one) perform these
> tasks? It would really help if this patch was shown in context,
> because I have no idea how this fits in the grand scheme of things.

Agree, bus driver could do this stuff, and I was considering it too, but as=
 this
was the norm so added these changes in this IRQ chip :).

Bus driver is not out yet, and we have pushed these as RFC changes for
early feedback (mentioned in the cover letter), but yes, these patches woul=
d
be clubbed as a part of overall changes.

And we can move it as a part of bus driver itself. I hope that suits?

Thanks,
Nipun

>=20
> Thanks,
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
