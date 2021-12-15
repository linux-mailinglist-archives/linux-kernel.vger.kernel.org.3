Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19634475534
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbhLOJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:30:40 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:37426
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230475AbhLOJaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:30:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri8kkN0dCUpQUyR608bq5XEuNJeDJsPqgC7194JFW+PajYPQxArECr9sBCorDN0Kg9irSM8/3xcKZr3d3u3aCtpTO/djtrYtROF8Z9TOxvU5YtatA8TmyPCT4z1FUvUoAEDc2qdtoqKC+Hg6p7KrbyJo5ocQ91BcLGEXBQNtPngoOVHW/kH6eWau0HxqpGTJ4/1+D1no9FOUQEps40ag6hjB2Q7ywTCVCIopwbdm23dL91fRgu9V10BRofhrIt4EnNaTIDfmMSzDQ9TTNUaWpzLRxF9UWGGxDhFHhMZesYeT/A+HmCVg6ZLoMwMcNtUK+kDstAhzRUnVeDMhuiaUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkKa31RKzO7SwclOAyD3RpGj6gQIfTkioDUKlw8ndXo=;
 b=VAVvhnP1I5vDb0orkMjBRLwMlhI2Kf7AOOO6OVCTfTEdElx8M09s6KAm01sk4X2zXvU8rOMDUJX3sorZJ04PL/ktFQKmc9dcXmzgLFokcUwJ4aR5wyI3KDHE+odTAGJ4cV1NDgyitpKRXgd+p8kaJtq4+cidYcjsH9qqQFOPU9pOcadn1AVmBz0olxpFW/kofOKL2X4sxEOOONT+83PBmynbDwZB49KLY1VK5zaSG9Kji8LxW1pcqN7W4C1YhgAlouSRcwcsi3/+zPz6gUnSr490O3uDmdvO4i3DxMNoi0C6VrLDRPikZwxhS9wFmh3izGqeTwnSBwoAb8RNi3zplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkKa31RKzO7SwclOAyD3RpGj6gQIfTkioDUKlw8ndXo=;
 b=OWoQXEahlwzdWrkuNjL14BiuRx3EjnPWkLnv0abMd3QPeFgyQQ+qlVXcisESKhxeJbA3xNlXNjWcEXKAkG533jG8/OssapImZfGr1kaBs3lHW0Y9CCNqfLnu8N9dCd9b0R6NRb1KfK10woPYlFg2RGAMhZF0Z7bTWYDO5+mNdro=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 09:30:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 15 Dec 2021
 09:30:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: mm: support bootparam max_addr
Thread-Topic: [PATCH 2/2] arm64: mm: support bootparam max_addr
Thread-Index: AQHX8X+RJl0WiuN0bE2TAI+j7pq7b6wzKOQAgAAAXXCAAB69gIAAAFug
Date:   Wed, 15 Dec 2021 09:30:36 +0000
Message-ID: <DU0PR04MB9417A1DC98221DF4EF76CA7E88769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
 <20211215064559.2843555-2-peng.fan@oss.nxp.com>
 <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
 <DU0PR04MB94179C41295FF369E5D755D488769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm0MWDhzkkwAZoz@kernel.org>
In-Reply-To: <Ybm0MWDhzkkwAZoz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 455555f1-e771-47bf-ccb1-08d9bfad8cc2
x-ms-traffictypediagnostic: DU2PR04MB8583:EE_
x-microsoft-antispam-prvs: <DU2PR04MB85834839C8B40F5E0CD76C6488769@DU2PR04MB8583.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HetKqDc6f+BnAnOKrM/d6A4QxnuYjxCTKQPa8a8G9+fwkzS7TnJtW5J7K7fD0ASr9xdxA+jgpUDPfdhGNKOt2LWy3TZ7Aaq7w2A6Zc0REA/8LcCojSpyBbHc4iUyaqqGrcFGB2jkOTLCD6sYy1CHLLanLNXFbqp6v2fZNmFiv1n731fj5vK1pn8YE1AkwTjcUZ8WXmCXDEuRJJ6fyAbb2RgemRW9guQiiptbY0YU7NclAJ0Ar0xmXno2BlHQpJANOAcPOFrp2lH1MqS5Ve+Duh+8/EUSMg6qx8E8Rv0BkatGv3DpXuTOr0h8/ZiFlQUPXBsWN1Vi3T89bNqcemwCey704gnbq4Msr9/JAww/ke4ACMBQKrvXDP/RvtGx3aA95IcdCrzb2H9Dl9FPQBsoCJHCs5AZMW9iOewseeSwsYgqIzb0Jp7B5187uNNxn8um1JIBmPdT/IMHBJDW0jdbwBngIBsEW+zCuvv+IMC0q7CbcxvLm7Rct8ajvMsR+uk0j9EyYBo89u+9cDRoS2h+u3nynmj5iwZxoFMFafHtjpvnbOO0UcrVaJX5Gu7VKLj0LhHMawB3NsWdhJSztD8dnUgCL99gp5tJSaZIvFY5XH7/pEsgLrlue3LvlCbTTvCMeNFRJzotn+XLMx++Ae804BV8GBKJavXJ2YddKg8V0krRnzdF/6/I2N6FJ9U3wbbffe+PwbI1BbQNnAOgB8Us4xiCJH0JNNCOYccxM26nGhIfj94vSIaQKzXfGY1649gxkYo1C6dnHBSqWekwNP+4Ly0wsybuAqioplUa906+jF7GlnAaFpovNxlvRwT7RdPTWjqvVhnDNy2dAocLagu0sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(38100700002)(83380400001)(122000001)(38070700005)(64756008)(66476007)(66556008)(9686003)(52536014)(66446008)(33656002)(2906002)(4326008)(110136005)(316002)(54906003)(55016003)(86362001)(7416002)(45080400002)(44832011)(508600001)(71200400001)(7696005)(6506007)(186003)(966005)(26005)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?APJoRmvy4scjiCejHdBVVix9p5x8l3IX1ngl4kxxC2k1dNvj+RRKLV/ndgIK?=
 =?us-ascii?Q?0VI6/CCdJPQKuWpv+5A+yuQ97m7A1IXlFkis5EYzD0D/FAH6m0AATtPtHTTt?=
 =?us-ascii?Q?jGldJsu6ho8hfPlsAcngzyE3nFBQ7MxKM0mwPTgaaJNY8nUkYtRexSDfH7vV?=
 =?us-ascii?Q?ziKdm2rN1gQiCJfwk/RiJfXh8cdgjjgk4TNEiSvqcwMkGEE+lec/zbQcOeEz?=
 =?us-ascii?Q?heT6DawGxDxItdzaURT8WBokfMaqYy+HVpVqZOnusCIF+52DtlTrO2T91IED?=
 =?us-ascii?Q?ZQd0jdrlvq9BNAoeOwl9xyKcX7RPC6hnIiLHY3VHSdNoEJBttFVWxz5V++35?=
 =?us-ascii?Q?zHdz0t8Ug1Q+B8AvuA2NR6hObBAdKxknVtMZCE5WtYmP0ztwSdhrg2VdCNHH?=
 =?us-ascii?Q?mLtMoEmTm7WSFiOywtEcogvRRlWKWlZ3DKBvCMfwCAnRzx6R29+tTSVSOLV9?=
 =?us-ascii?Q?018+ezlbyBzwL+a/8Z6imPNNEHEuTuYXLxYy120ibi4GxgxVZ3ulPOqpXUv6?=
 =?us-ascii?Q?LyWGi/bM3EoK3yotlPfzNN1/ciNDyr4edo6u/w+7/8qWYisRgeoMdEMHJ0+L?=
 =?us-ascii?Q?5bZISn19ibANAI2ejPbX2Xsfph4r+HFTqEYZSf4w3KsHBWSqMaez1+K5ZzwJ?=
 =?us-ascii?Q?2lqNEbnETbBSHt46nG8p7ARRiUe8SETuhdwJzVHW9MUWTVnYa9mFHf4npHW4?=
 =?us-ascii?Q?pJkhsb5WTYO1vqXUaUaELNwmZdYRAQzG4TZrjMJHcPlUefOt1+uiUlRyMDI9?=
 =?us-ascii?Q?0baFXztBPypcyqs5apIio/0xAow5bqD7Oq3m/fV2vQhoAraGwR/bstLKD2dT?=
 =?us-ascii?Q?d1BrYRCy8mkeoLkGoQKWuM9lu/n7PVblwYvourSUWZG6d1BmVaQ8L3tjloUt?=
 =?us-ascii?Q?+2VVpN9SZFM8yPaUeyNhgAnGJUg/EHKDcl4x0KxSFcoVyuBIA5aVkoqHIjQC?=
 =?us-ascii?Q?jh3CWmmZJ6jTGzedDesOEiYxszWuM11pC2RifanFNl0w4C8Dzc7yYgIZ7BJz?=
 =?us-ascii?Q?9xSU576mdZrE0FSnkS7OXHF9uGthLi/PeDLDNBahNGYuLIyKTPVOpnqMTtF2?=
 =?us-ascii?Q?L2DumYKYPoNku/znBDrMfbRH6KwXZP3AhPPs2rjzLgA61qqrsda0BQRJnVxU?=
 =?us-ascii?Q?4GixLnBY12jZH28LkzxeN1JshCrJETbuML9WAKVy0DrY5ciR46aRULcOi2d5?=
 =?us-ascii?Q?XPIxBCktNegwne9gRtJ+P8qLn9AZ5UbpyNwDoHG3FrGYR8Awm8TPBWelts1m?=
 =?us-ascii?Q?rzgHZlYe1bHj7NOSMKSz4w8EMVn2PLF6CepMQaqKxIwaJkxJzGq89FFJcS6T?=
 =?us-ascii?Q?yfOYL/BdhM6HycwNJXl8SwnxGDB1SGNfJ0ZCfLiOTalH5fuZylwS+V0l9Msp?=
 =?us-ascii?Q?VDXttItxXJU1V9OrxKQoYUGrMsmXBc0XwxY4YTeBP9EExXnC79+uM4PVS1QE?=
 =?us-ascii?Q?IiSccDvTX+9pe2XBVDw5+CZhtugktDopK6VhwJW+VQpvhDRoP54qhx/gsxsR?=
 =?us-ascii?Q?OhgSCiKkdlr+JJB2CYjyUuWEcxR9D52r9zvHDFv3TlUyX6A0LIbv22CwzNeI?=
 =?us-ascii?Q?MsKZC0xSC6oAsbzX6xm3Erd3EB5BTzPxNcYWZdrN79PIY3QSkNkgZC/lVxk2?=
 =?us-ascii?Q?P1+EQCiA1CyjY7fXqkukQlg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455555f1-e771-47bf-ccb1-08d9bfad8cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 09:30:36.1071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kw+IIxbGdC8FRBvn48Yi87csmZTejhmaszt2ZlW99FzVugKx9Hf+3Z8F7K3CsDrSsoAjdc5NPKaEQv7cmgeKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
>=20
> On Wed, Dec 15, 2021 at 07:59:45AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > >
> > > On Wed, 15 Dec 2021 at 07:56, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > There is a "mem=3D[x]" boot parameter, but when there is a whole
> > > > reserved by secure TEE, the continuous DRAM area is split with two
> > > memblocks.
> > > >
> > > > For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
> > > > [0x50000000, 0x51000000), the memblock will be split into
> > > > [0x40000000,
> > > > 0x50000000) and [0x51000000, 0xffffffff].
> > > >
> > > > If pass "mem=3D1024MB", the actually max addr will be 0x81000000.
> > > > However if need the max addr be 0x80000000, mem=3D1008MB should be
> > > used.
> > > >
> > > > There also might be multiple other holes that no visible to Linux,
> > > > when we wanna to limit the max addr usable by Linux, using
> > > > "max_addr=3D[X]" is much easier than "mem=3D[X]"
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > mem=3D is a hack already, please don't add another one. Limiting the
> > > memory like this is far too tricky, given that the kernel itself and
> > > the initrd could end up in memory that is excluded, and we have to
> > > go and fix things up if that happens.
> >
> > We wanna to use the reserved memory with request_mem_region, but with
> > commit 86588296acbfb1 ("fdt: Properly handle "no-map" field in the
> > memory region ")
> >
> > request_mem_region will fail, because the reserved memory are now as
> > kernel memory.
>=20
> request_mem_region() is for MMIO.  Why do you want to use it for RAM?

+ Jan, the jailhouse hypervisor owner.

There is an out of tree driver
https://github.com/siemens/jailhouse/blob/master/driver/main.c#L466

The hypervisor jailhouse is loaded after linux boot up, and the hypervisor
bin file needs to be loaded into DRAM that reserved in our device
tree with node with no map property.

And the hypervisor use virtual pci for communication between VMs,
The virtual pci use part of the reserved DRAM area as PCI MMIO space.

Maybe I should use /memreserve, but not node with no-map property.

Thanks,
Peng.

>=20
> > So we use "mem=3DX" to work around the issue, but "mem=3DX" is not user
> > friendly compared with "max_addr=3D" when there are multiple holes used=
 by
> others.
> >
> > Thanks,
> > Peng.
> >
> > >
> > >
> > > > ---
> > > >  arch/arm64/mm/init.c | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > > > db63cc885771..3364b5e7a7fe 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
> > > > EXPORT_SYMBOL(pfn_is_map_memory);
> > > >
> > > >  static phys_addr_t memory_limit __ro_after_init =3D PHYS_ADDR_MAX;
> > > > +static phys_addr_t max_addr __ro_after_init =3D PHYS_ADDR_MAX;
> > > >
> > > >  /*
> > > >   * Limit the memory size that was specified via FDT.
> > > > @@ -189,6 +190,18 @@ static int __init early_mem(char *p)  }
> > > > early_param("mem", early_mem);
> > > >
> > > > +static int __init set_max_addr(char *p) {
> > > > +       if (!p)
> > > > +               return 1;
> > > > +
> > > > +       max_addr =3D memparse(p, &p) & PAGE_MASK;
> > > > +       pr_notice("Memory max addr set to 0x%llx\n", max_addr);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +early_param("max_addr", set_max_addr);
> > > > +
> > > >  void __init arm64_memblock_init(void)  {
> > > >         s64 linear_region_size =3D PAGE_END -
> > > > _PAGE_OFFSET(vabits_actual); @@ -253,6 +266,9 @@ void __init
> > > arm64_memblock_init(void)
> > > >                 memblock_add(__pa_symbol(_text), (u64)(_end -
> > > _text));
> > > >         }
> > > >
> > > > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > > > +               memblock_cap_memory_range(0, max_addr);
> > > > +
> > > >         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> phys_initrd_size)
> > > {
> > > >                 /*
> > > >                  * Add back the memory we just removed if it
> > > > results in the @@ -427,4 +443,9 @@ void dump_mem_limit(void)
> > > >         } else {
> > > >                 pr_emerg("Memory Limit: none\n");
> > > >         }
> > > > +
> > > > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > > > +               pr_emerg("Max addr: 0x%llx\n", max_addr);
> > > > +       else
> > > > +               pr_emerg("Max addr: none\n");
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F=
l
> > > > ists
> > > > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D0
> 4
> > > > %
> > > 7C0
> > > >
> > >
> 1%7Cpeng.fan%40nxp.com%7C3ad0ef697ad64542556208d9bf9d1e1f%7C68
> > > 6ea1d3bc
> > > >
> > >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637751503805222488%7CUnknow
> > > n%7CTWFpbG
> > > >
> > >
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > Mn0%
> > > >
> > >
> 3D%7C3000&amp;sdata=3DiKVO4PUPnaRr%2B5gHcXxaaRxBt%2BK%2Fjytg8eQ
> > > dCqgqh5o%
> > > > 3D&amp;reserved=3D0
>=20
> --
> Sincerely yours,
> Mike.
