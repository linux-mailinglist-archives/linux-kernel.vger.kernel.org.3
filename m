Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69F7566954
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiGELcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGELcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:32:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF301403F;
        Tue,  5 Jul 2022 04:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC+InPfdxLGyJG11Edv2MAGATIydlh0GKcpCV9wm6JgFsyWV9P5otupPkw9YCUCApNZNgn9t34RTV6fQUgmlnmFLKHZ5j2T9r79622Ic5mcV540D8eoms+eDvs/WvSZwzriq9UAtCHirlyeCyYK0tB5x09G8BuJPRSeYL2YT3y0J4wdZ2E73s1n0SduJOd/cvCPvxXC+pzJaCXZYF3WaxYxzPi76stBBgafqxfyJSNS8qKDGU+bEtFr/+Lu/XWm5nwExFW7CFrOXdx4fB4AYXNSEBDA5NAG/PetePDRoAPtmgRec/2Q0aKVojxzGoruaZRYmPUklNY2glnz6C1J6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2dQq2xIz3pS0uEbEibeKv1yy1ioyUYZTIYE0HyoHvs=;
 b=bZ3mU2aC12zp2qekFu94mvP1THv5iQhOyjA0fBdBAzpcdRBCweqBWj+sfrJ9Xo6Nr820eWb843uQfxFL9jCNcyM5FX8Ehq3f02pdCfl5DJr6+N5Y2JndCZEJSafUjKkU9CJDQ02zdB8vAwDyLYsi4t9gy1ZZSjHozhG+leDabF58j82emCe7z4LTmLa+LMZuGclFS6Bpsnrqp3u4j/WgdUzSCe1WWCuBxyfrMqmzsucOzk59MSQpbbr9EEUK7tFraoRtXTjmMdAsdyRbGGUWBj9e4iIouplBHr7RdmlrP2ovUXqeqXmzF+rxY9HyII1UwfEdlw0fmYaLf109ar9L0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2dQq2xIz3pS0uEbEibeKv1yy1ioyUYZTIYE0HyoHvs=;
 b=16PBdHyAyHAz9aI7K8JIzirpG+BMyfK8UxabCGlh9bnP/29Ww7uquSoHqeCBinWCl6tafp4LQQomKAkZL6vwgn0wgAN5tMj3tY6+AoDA9MRonhtQWIYOvHqbKOSZjEakaFnki1CU4p1teIeTVacCQgyoNxq8NRUBkTxAxzHpgX8=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by BN6PR12MB1940.namprd12.prod.outlook.com (2603:10b6:404:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 11:31:59 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 11:31:56 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>
Subject: RE: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Topic: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Index: AQHYSNyT5AQVGFEfc0CeWm5NB0lZxazhsf2AgFc3IxCAISRtAIAWId9Q
Date:   Tue, 5 Jul 2022 11:31:56 +0000
Message-ID: <BY5PR12MB4258E660A6D54DFBED7DACD0DB819@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <20220405191757.3rzc6q477reusywp@ti.com>
 <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
 <20220621091650.ktuluymgpdgxghd7@ti.com>
In-Reply-To: <20220621091650.ktuluymgpdgxghd7@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15ab685-b345-4d46-36fb-08da5e79f779
x-ms-traffictypediagnostic: BN6PR12MB1940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mr9Prfl4L2/3UFWQw6cGJuVRI0eTc2ChhPh+13hymXMR9pQJ4A959rfYfJp1WM+q/bhSy+u4LjWKgZGa6MAPeXrr4OgmNfdXsAvErYSfFXzUjYu1xBDH3mRt2hfrS9tCPC9vnQlcjNeX9Hud7J/3EPK/LRjv9IOQnpj+LNhox0C86dtZKtghHxaMfFWOakHgU363M/b2Hg3DOTq05bMOYb3vPwESCQbW7s/ujjKE39CvGzaTiLhT0uki/RKd/LiHuLo6XK0n6D6raykJOvd8OVPooEwSwwC13oq4LNcAUbIYdL/7RgsJE7DL5eecCDjJzYNvUA+ddPe/ayJggkzih6rtCAHxlrmKSjFPvofrnlAT6nih4bBeruV7TAotNx2U8MUASUlvKE0iOpFr1djxtchG5dn5Nql60SsO0YdllvkF/AFKw4hdl2QEaPAGoGF6bEosjBYfywIbtfRyXpXYwzVCQMi1X5ReJyUGWkux5yKwqkidx9IeKdYEu0939BolyZYA0sMA2UyAq+7haGHsLHo1LnbrzgsA5tzy9bU5rEdIR7UBcE8GZQrL0v4owp+T6kBbx7rdFgqCFF5ND6QbZ1HmDG5q7fU5E9TG4/KJC8DmfJkRDbDl/o+HfuBuv3rEt0yUO1v3C3ZL+xEH/guXB27LyMrA/mrfAyV1VN4KuGMv/SSSwgMSBJBaATor/QU64sqKT1jMy1MAEs1ZTNcwxWttslr7OzdYISmi/kBmwuIWD+bhWFlqW+/kRx5qdqlgtge/C2ruJPWe0FAh/58icrnyKazRxgrzR8u8Oeh/EIMmrNVSwLWpeaxl+7cM9btyf8aCgTslegTCbJ6o2sS0tIBi5ut6cayKtJcNMiha/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(83380400001)(186003)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(33656002)(478600001)(52536014)(86362001)(966005)(8936002)(5660300002)(26005)(38070700005)(122000001)(9686003)(38100700002)(2906002)(41300700001)(55016003)(53546011)(7696005)(6506007)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zM0b37eCUCoBsNHLks/NrCu7eCFFDxK27FRKM0CEe5r5tWnV4tkoRwvolqw5?=
 =?us-ascii?Q?BUAVl9s/tPy8XeRkpD/8cpBwFHuE5J8HoO8QrKP6oXSIleaxRVd6ZqVjMNOJ?=
 =?us-ascii?Q?+KplfmRvNNNyG0pGQr/aBVVCkvvvEz1fRck7cM+jyd94oVi/U9lJbZrwx++g?=
 =?us-ascii?Q?rNdYL0fp8oaJ95OYoYrQkJDo9YvExvymbRaCAtBYN+Uv6BW96t10HZd+nCXc?=
 =?us-ascii?Q?6Opt7PNHjcDog+dYe29s0Owa5Giae53ucimTqnmjBH8eN3E7+Px96XnKVc2f?=
 =?us-ascii?Q?apgEYsvjfu09Vna6dOPnZXP12viSPd7nS9752eH7ngcQIk3bXT5fppuIHZFr?=
 =?us-ascii?Q?PtJ5c0ykAvHyMC60vJgCxrM3yEnKP9jJP3zR2BNS8jtImlPr5qSuuNgG+JIN?=
 =?us-ascii?Q?hffHlJqrVHUIn2yTAPmMw4E20wBKesirefm+TfrG0uEFqv/DhrpWWuD8t/qs?=
 =?us-ascii?Q?ay/P5FO8kenggs7qvPtdGdkvzDbVXel/lm9DzV3VwG/z7tJ8VpeqQFavkCRu?=
 =?us-ascii?Q?0+6jNC9XI1Sujzt6ZDhI9+61w4WvRer0Dn5nB4zohtbMAmV79ym86y8L7fs4?=
 =?us-ascii?Q?8w0OobBvRZ4hvV5i30I+u3D7Zr41NYeLtRYFjqrlZMByt8lBKaVi/JBbJmAJ?=
 =?us-ascii?Q?xsGABiH4v/yN7/s0stvT5UYjYDzqOMtxe3CERBIqupRw/ZgYQCTxAJZzaqwD?=
 =?us-ascii?Q?BGaUBAP6g7kQp6Tcz9mnRNacUFTv9lVl2oEpVvbdGKrCPSHwSSMbMOELYFL5?=
 =?us-ascii?Q?QPZl12vG45iRjzF1dySst9MxsAt1SK0jA/ALUJBRTRvW+0GTIXwbjG9OQ3DW?=
 =?us-ascii?Q?wO4Zwetu6CI09qXyLPX9ngTeMxMIli/OQSc6HaNPU3I7egcW6WiySnh3U3eW?=
 =?us-ascii?Q?IreYSb4eZUt6l1+jMYq+cdo/X+WcQWQbtBallZ4FylXMB+Xh0bI32GMoFLUe?=
 =?us-ascii?Q?WtK4NfFc0U2sgVJvF0O8LjJG3AKbY33lsbihkBPaKDwyxvPoXlZyGzH7N9l2?=
 =?us-ascii?Q?DqB83duZZh33Be9V90UTZtokJw2IwmW0wde3aLGXoK5ISMkjCp1p+AQmygBh?=
 =?us-ascii?Q?ZvOrY5BIJUxQM4BZDdYVp0eveug3IM3o5gIGBlq0i0rfvFMlXTGcidKSTwMi?=
 =?us-ascii?Q?/YrAaU+usjlFjoigj43xfVtPGMGz8KAJiRZ+vvGReXJit+/K4moHa0Mj33Ie?=
 =?us-ascii?Q?7NLCwRGjpSbJIWPP3JHUpzhDlkwj0ti5k/FHj1ab0jl5lQDhwNFfM4DnFwzF?=
 =?us-ascii?Q?yfERxgMa+nMp2gpHhP+IwSsHa0YQrTOiYOnI1mp0twub2wdZJ+mnaXCKpvtI?=
 =?us-ascii?Q?hlHoFhYwIcZYKHf2ND6Oea7/15f5+BYkOipnDQ5Ct81Yh21z75ncLpmFerh0?=
 =?us-ascii?Q?JOMTnVp+DzcZJtupnA/GhiuhQ+GZgtcy+tp7a9ko4ODPdui/RvMrukgvCdIE?=
 =?us-ascii?Q?Ap5tTk0mr5b+FbMCoprihh0afm7kQzUjNgU1K+ewOCSuItCEpYKncsNRH2Zd?=
 =?us-ascii?Q?ZFpszRNL3tvWqzwucVLloe628SzKEGTBsOkUVxbPRDJVPDoN42WX6o2OWbGO?=
 =?us-ascii?Q?4gS2iq82KwgzJ6is1K0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15ab685-b345-4d46-36fb-08da5e79f779
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:31:56.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuNhGqC/oWrngqxZyuLcGP4niRQwoM7MvXPJjFbNxbKoA3ab78upcAH8bEeXUkkZtRmpujO5K+xiMqLMVIfJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

> -----Original Message-----
> From: Pratyush Yadav <p.yadav@ti.com>
> Sent: Tuesday, June 21, 2022 2:47 PM
> To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> spi@vger.kernel.org; saikrishna12468@gmail.com; Srinivas Goud
> <sgoud@xilinx.com>; Michal Simek <michals@xilinx.com>; Radhey Shyam
> Pandey <radheys@xilinx.com>
> Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI devic=
e
> reset
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On 31/05/22 08:12AM, Sai Krishna Potthuri wrote:
> > Hi Pratyush,
> >
> > > -----Original Message-----
> > > From: Pratyush Yadav <p.yadav@ti.com>
> > > Sent: Wednesday, April 6, 2022 12:48 AM
> > > To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> > > Cc: Mark Brown <broonie@kernel.org>; Rob Herring
> > > <robh+dt@kernel.org>; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux- spi@vger.kernel.org; Michal Simek
> > > <michals@xilinx.com>; git <git@xilinx.com>;
> > > saikrishna12468@gmail.com; Srinivas Goud <sgoud@xilinx.com>
> > > Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI
> > > device reset
> > >
> > > On 05/04/22 04:30PM, Sai Krishna Potthuri wrote:
> > > > Cadence OSPI controller always start in SDR mode and it doesn't
> > > > know the current mode of the flash device (SDR or DDR). This
> > > > creates issue during Cadence OSPI driver probe if OSPI flash device=
 is in
> DDR mode.
> > > > This patch add OSPI flash device reset using HW reset pin for
> > > > Xilinx Versal platform, this will make sure both Controller and
> > > > Flash device are in same mode (SDR).
> > >
> > > Is this supposed to reset the OSPI flash or the controller? If you
> > > are resetting it in the flash then you should handle this from the
> > > flash driver, not from here.
> > I am handling OSPI flash reset here. Agree, controlling or issuing the
> > flash reset should be from the flash driver and not from the
> > controller driver but handling the reset might depends on the platform =
and
> should be in the controller driver.
> > One platform might be handling the reset through GPIO and others might
> > handle it differently via some system level control registers or even
> controller registers.
> > To support this platform specific implementation i am thinking to
> > provide a "hw_reset" hook in the spi_controller_mem_ops structure and
> > this will be accessed or called from spi-nor if  "broken-flash-reset" p=
roperty
> is not set.
> > Whichever controller driver registers for hw_reset hook, they can have
> > their own implementation to reset the flash device based on the platfor=
m.
> > Do you think this approach works? Please suggest.
> >
> > Code snippet like below.
> >
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 2ba044d0d5e5..b8240dfb246d 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -285,6 +285,7 @@ struct spi_controller_mem_ops {
> >                            unsigned long initial_delay_us,
> >                            unsigned long polling_rate_us,
> >                            unsigned long timeout_ms);
> > +       int (*hw_reset)(struct spi_mem *mem);
> >
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c index
> > e8de4f5017cd..9ac2c2c30443 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -598,6 +598,27 @@ static void devm_spi_mem_dirmap_release(struct
> device *dev, void *res)
> >         spi_mem_dirmap_destroy(desc);
> >  }
> > +int spi_mem_hw_reset(struct spi_mem *mem) {
> > +       struct spi_controller *ctlr =3D mem->spi->controller;
> > +
> > +       if (ctlr->mem_ops && ctlr->mem_ops->hw_reset)
> > +               return ctlr->mem_ops->hw_reset(mem);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(spi_mem_hw_reset);
>=20
> Hmm, wouldn't it be better to register the controller as a reset provider=
 and
> then teach SPI NOR to call reset_control_assert()? This way you can clean=
ly
> handle GPIO based resets as well as MMIO register based reset using the
> CQSPI_REG_CONFIG bit 5.
>=20
> How I am thinking it should work in your case is you can create a GPIO ba=
sed
> reset controller driver (I wonder why this hasn't been done yet) that tog=
gles a
> given GPIO line based on reset_control_assert() or
> reset_control_deassert() calls [0]. Then in the SPI NOR DT node you just =
do
> resets =3D <&your_reset device>. On a platform which supports reset via b=
it 5
> of CQSPI_REG_CONFIG, they can do resets =3D <&cqspi_controller>.
>=20
> I am not particularly familiar with the details of the reset framework so=
 I
> would like to hear what others think, but I think it is a good proposal t=
o start
> with.
>=20
> [0] Or, you could register the GPIO driver itself as a reset controller.
>     I am not sure which works better.
I found this link which does the similar implementation like adding gpio
based reset controller driver but looks like this idea was dropped due to v=
arious
reasons.
https://lore.kernel.org/lkml/322faa05-240e-0fd4-8ceb-68f77e871cf6@seco.com/=
T/#m6c676fe25453525aecb26c71f3f3a5bad5e3e923

My understanding after going through the discussion is, we should live
with 'reset-gpios' property to register the GPIO based reset pin and make
use of the gpio driver calls(gpiod_set_value).
I may need to do this at SPI NOR layer instead of handling it in the driver=
.

Regards
Sai Krishna
>=20
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index b4f141ad9c9c..2c09c733bb8b 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2966,6 +2962,7 @@ static void spi_nor_set_mtd_info(struct spi_nor
> > *nor)  int spi_nor_scan(struct spi_nor *nor, const char *name,
> >                  const struct spi_nor_hwcaps *hwcaps)  {
> > +       struct device_node *np =3D spi_nor_get_flash_node(nor);
> >         const struct flash_info *info;
> >         struct device *dev =3D nor->dev;
> >         struct mtd_info *mtd =3D &nor->mtd; @@ -2995,6 +2992,14 @@ int
> > spi_nor_scan(struct spi_nor *nor, const char *name,
> >         if (!nor->bouncebuf)
> >                 return -ENOMEM;
> >
> > +       if (of_property_read_bool(np, "broken-flash-reset")) {
> > +               nor->flags |=3D SNOR_F_BROKEN_RESET;
> > +       } else {
> > +               ret =3D spi_mem_hw_reset(nor->spimem);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> > Regards
> > Sai Krishna
> > >
> > > Also, as of now at least, SPI NOR only works when the flash is in SDR
> mode.
> > > For TI platforms, we reset the flash in the bootloader (U-Boot),
> > > before handing control off to the kernel. If you do want to properly
> > > handle flashes that are handed to the kernel in DDR mode, I would
> > > suggest you update SPI NOR instead to detect the flash mode and work
> > > from there. This would also allow us to support flashes that boot in
> > > DDR mode, so would still be in DDR mode even after a reset.
> > >
> > > > Xilinx Versal platform has a dedicated pin used for OSPI device res=
et.
> > > > As part of the reset sequence, configure the pin to enable
> > > > hysteresis and set the direction of the pin to output before toggli=
ng the
> pin.
> > > > Provided the required delay ranges while toggling the pin to meet
> > > > the most of the OSPI flash devices reset pulse width, reset
> > > > recovery and CS high to reset high timings.
> > > >
> > > > Signed-off-by: Sai Krishna Potthuri
> > > > <lakshmi.sai.krishna.potthuri@xilinx.com>
> > > [...]
> > >
> > > --
> > > Regards,
> > > Pratyush Yadav
> > > Texas Instruments Inc.
>=20
> --
> Regards,
> Pratyush Yadav
> Texas Instruments Inc.
