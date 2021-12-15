Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627EB47585D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhLOMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:05:39 -0500
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:16769
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236954AbhLOMFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:05:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abfduen0Gc3XHFtcWhULAc+0tJ+PTUAJ27vPIdo5ea2YlnaTaP3xqjSq/ygB4XpCPY6SCwAmYTpgznn7Dy5u93B7+B7n89A177EILewZ/hInp+H1fI99v1MmIMTWvQgtd3bCMPZRIUM3O9SGQa4q6lwb2By7KQivelrfM4hSasA6PAhNmPgwiyKzrfkezZvh5TYCfyy/64C87scqRy8h+XjtcD0Xj32QvCNHougaMtfO6x12fkFrZncW4rz3mxoe6a/CyRfea0PCBb8lYzwKix77TyA0V+yQbaklRjT0ZfHWwt814jWqq3Sq9geT4aCsCH1Q6xZqvfzZ4ECBevPjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47eWcTZTM514UqAIaWQR7fUL9nJpYUPXrdFlQz5H04k=;
 b=LXu8q1007SbeSJ2RHCe7+Fgt42YAGgTon/mM/jyZyC+6bx9AtRrv60gSmioFFrIRB/IPtuQslf4QYnAAPcq7oNlXpSJfk7vpofL5JVKJABrNihGOUAmirIMpU1WxfgAQMVOSOAFSP+aarD/N88MWW+921FopaT4zbmCTdjDV+QGXkdCt4wk/DVwKv2z9H4/4fW/Q+oAm1nw4nETG9S9edYhI00W1KlG/Y+TeBlloUyJfRUpe62IYPOgxUabsh3QF8f5aRepfY1o6KuG45ztTqtBs6S51tevE8E4ixKq6DPE56JtGQ2SXMpMkzaREnTCxK8TzAkcKas1JY0UPB3EOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47eWcTZTM514UqAIaWQR7fUL9nJpYUPXrdFlQz5H04k=;
 b=I2RAmSQ0NqkYMBTq78kg2lvCr6Q+/erEyim07khkEq2F1tyv5Z5ulvbMI84XJsX+THkYg4RPpBouFe4LuhrREhtPdvujjvrol3zzMk1LsBqD0mlVYLtdqzrRWZ9d7qq2XNrx6/YgtS2lxjSADdkz0EOGHyigMd68tj2ECdtVh1Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 12:05:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 15 Dec 2021
 12:05:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Thread-Index: AQHX8X+RJl0WiuN0bE2TAI+j7pq7b6wzKOQAgAAAXXCAAB69gIAAAFuggAAHxICAACRjYA==
Date:   Wed, 15 Dec 2021 12:05:36 +0000
Message-ID: <DU0PR04MB941762839A98B9BB140876E688769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
 <20211215064559.2843555-2-peng.fan@oss.nxp.com>
 <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
 <DU0PR04MB94179C41295FF369E5D755D488769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm0MWDhzkkwAZoz@kernel.org>
 <DU0PR04MB9417A1DC98221DF4EF76CA7E88769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm7AcGJaanGVwkR@kernel.org>
In-Reply-To: <Ybm7AcGJaanGVwkR@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08bac61b-ce04-4c33-bcf6-08d9bfc33456
x-ms-traffictypediagnostic: DU0PR04MB9346:EE_
x-microsoft-antispam-prvs: <DU0PR04MB9346A172E292C5DE6AB3721C88769@DU0PR04MB9346.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36Q0+W8vK/lzVgbJeVpzDToFF+QqIqCUr9jpvB9mvWYBV/piQeZ7BvUgZ+A+ZZLPpdJL3F/NhefbelP/RvfFjj9mFd6tKL1yHjo0jnvFU/hZMHuuXc3qQOh4VEvxjQMoYLniZ4f0eThilWnFNiODnK1o561m9C1hhjWCE4P7AGA7TZrCu5PoPWk0vez3hGyLW0HcRTFRUfQN4Rw0dZ7KR46rIOn3BuFKe9oufqWQravPlFTi66QZKhU71geJbfnmtNb6tzko49owJsXhQEZ0EKufDBOwFUqlrNfmDzXbXPW4/GJayYP30YrgSEiwxGl7wGr2J+7oPzztAcQPqvTlFP+h6YgzY2W7VyvZ0uwx+F5A2Tb2LJTTi3L9fCJtt88TmYTPQHLzJrV2r1NuuY1UZu6cYAIYm9DhPt6HDXtlP2wZmRQo/rWSaZW4JnAerDRVC5Ge79+z2m1fNu5cvMSx+b0PjbY6Bh049sNvKgq+E7Bvaq/A4akLpmrJtOP/yr7xtNKdFU8+Z74z3P8SobdfkGehpSZw4JkeTNyd1Tl6Zypb8aVutpbl78delhOzY2YHJMX3pkJOC753bLiZzjsqIRgubp7xqsnfm6hzFIPHeSQkCqwgPgk4o5XglCgog4LIwgzV/AbKEHOIUV5kc1+iRqsMXyKIKxLlKY5W/+bwJdD6VUXDnKeEicXZID/xL+4ScDcz5sWRC+ezY2Aiv0wYdAjQE6cWKgoQs/axMw2oPdktf3DDbuVmw3IN6f0AG27HtO0Dxjax4GDzRbLku1HWM62rpTpVDYYKiOEuAsm+4TusCA1wfriAGEuwRiKOQwMy7U8SKSvvgg5SLU+Qfou9Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(6506007)(44832011)(76116006)(66946007)(38070700005)(9686003)(508600001)(5660300002)(8676002)(7696005)(2906002)(66476007)(8936002)(83380400001)(52536014)(4326008)(55016003)(26005)(66556008)(122000001)(54906003)(966005)(6916009)(64756008)(66446008)(186003)(45080400002)(38100700002)(71200400001)(316002)(7416002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iujI+KrLfwi05KBf0naMao6mKEX8FZmOOQ5BpQZntiTvDULNe/T4LOazRrbz?=
 =?us-ascii?Q?9tnwxOe89qmzu2vBy1FP8aJkHpvAgLE8Gle6JGBrseJVJ6GfpyvxGENHGtUI?=
 =?us-ascii?Q?M16ORTmBMd7+8az75gVoQrRy3pYHxT7cF70GzV3pLR9VCuDRuFQOGZmAufD9?=
 =?us-ascii?Q?Q5C5r0PkvjZFnlhrLoLr4PRX0N2QibrfjdLN5bM7XqG4Kn2JJ9AgCuvlZcHn?=
 =?us-ascii?Q?mFlijLSgHvkNRocqR3ZW0BBPgJEN89qAU356NIwZiavWfgf+l2dFafdtAd/B?=
 =?us-ascii?Q?rPsYwhG0n1KH+MhaDXFtvdlU5MKTA6b4X6uFPP3+vgdCyZw2nLX2DdjVA49o?=
 =?us-ascii?Q?zHBEv3f4niZgSfQ0wyxbXoETBdn4mLQGwMQ9EnpA6Jc12pb4MNXqzkAacNcB?=
 =?us-ascii?Q?7zCp66LW5pUp4w4/2F4itUK55gPcbHf0TNfbCMEqxFNnyocSH2hcYat56Nwh?=
 =?us-ascii?Q?1i3rnYQC7TFNoFNhWSSwxGQ8el3EMsbD/g9cGWflKhFxR7N5M2Xq/CpPzTp+?=
 =?us-ascii?Q?dx7n3ML5mRO+rB0VmQk1btVXkO6d7ruKHemuabukLcjV7RMqTIokWVAspkHR?=
 =?us-ascii?Q?HmKZEajKIgQbSAiBO7fa9Q/ZzJGExHUzP2XilFbGEUPkDrXBbF1+Sch+gB8i?=
 =?us-ascii?Q?JQzCP6N5o1c+D6ZroY8IKqyckAFW7JSdG3yI9nR3tIs4D3aiJ6VDFx+SoE+w?=
 =?us-ascii?Q?eNuhvfmSpbYvdSSv5Lab3tor775LgeZ8+ENUO8zH1OdV3LVSV2M/z0k6ZLve?=
 =?us-ascii?Q?qnAB79Dvwh9xOwGnFX3EURbFYf5ReLZ81JrBPD5MeOdxFwf5I8qvNo2IxQAH?=
 =?us-ascii?Q?HeC3TWnHhjSrl7sABZZlytaO7npinHTME3oOKkqFloi4NcIDdqwKmYwV0ZLD?=
 =?us-ascii?Q?3+LtG8ELz5obsILHxLMYhkRFF+PnatmckzGXzhFkQeSN7hPjlfqjVvWrA2U5?=
 =?us-ascii?Q?eK10gy903WgcsLPy+YaJcrDru9q5XgwqZ5v0FiuwjX5YTzwsg04Pg/kLETf3?=
 =?us-ascii?Q?fayTyjW1Z2ZGldinWk1107uHqQWpOn6BHkB0isM/J/4B1mInRcg99kjs1OVm?=
 =?us-ascii?Q?4QnD7ulTv6yLz2thYG6V04MAuTPJEgeQ/88Jm6LaCChdoXRgrhhrK7biQbmd?=
 =?us-ascii?Q?cT5bvW2pI6jJ1MFBRrRUxhfdqNRLcxx/CzPRG6VCCzwA+CHeEIV2s2CKtBZr?=
 =?us-ascii?Q?5u+VCfFb9yDuH8V2ENwdyjX0vLet83mVXWjpmVJShVE5vkX8SJWTqP2ERAB8?=
 =?us-ascii?Q?ew2JGmmDSRt18tPgMsqtgn4WHgRdWlcNeQlPJAoT292RdR/ie0r/FzGSRgvg?=
 =?us-ascii?Q?/s53ijuG+taNs7G4sO4LZ62NikKF843v/CorTKP+Ye1pSW5gYyr1kxgeam1U?=
 =?us-ascii?Q?gUJmlpHbQeV9YNJMC9iAIUIEVHLBtbhf+xcZAgut9zH8VVSupqC5Cwc68xOQ?=
 =?us-ascii?Q?n8xvZG20JKq+Tz9UGGXOYXanRnHni4dYJS8xZWSNO2R9f7ZAqslHy/6FJ2g2?=
 =?us-ascii?Q?ra/eqSEZdUiFkEQKc5nC9K+BhXLd1nXpouKa0YXPnX349lmYl/1cdyVf2c05?=
 =?us-ascii?Q?Sz6abY+iD8dVMCkHxChOjkVE0eOpFkanbA8hyib6FWDxqSkVuyDZVIHIXKDm?=
 =?us-ascii?Q?PB8pwz3zW4jQdHROVlI7H58=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bac61b-ce04-4c33-bcf6-08d9bfc33456
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 12:05:36.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6vHoQ3T+BydIEg7dPwh6AVmZmXR9u0/XGoUM67UUkzJyjWvsLMTKp02KWa6Zjdmdvdkh+ANzeZXCn9ZyciPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
>=20
> On Wed, Dec 15, 2021 at 09:30:36AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > >
> > > On Wed, Dec 15, 2021 at 07:59:45AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > > > >
> > > > > On Wed, 15 Dec 2021 at 07:56, Peng Fan (OSS)
> > > > > <peng.fan@oss.nxp.com>
> > > > > wrote:
> > > > > >
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > There is a "mem=3D[x]" boot parameter, but when there is a whol=
e
> > > > > > reserved by secure TEE, the continuous DRAM area is split with
> > > > > > two
> > > > > memblocks.
> > > > > >
> > > > > > For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
> > > > > > [0x50000000, 0x51000000), the memblock will be split into
> > > > > > [0x40000000,
> > > > > > 0x50000000) and [0x51000000, 0xffffffff].
> > > > > >
> > > > > > If pass "mem=3D1024MB", the actually max addr will be 0x8100000=
0.
> > > > > > However if need the max addr be 0x80000000, mem=3D1008MB
> should
> > > > > > be
> > > > > used.
> > > > > >
> > > > > > There also might be multiple other holes that no visible to
> > > > > > Linux, when we wanna to limit the max addr usable by Linux,
> > > > > > using "max_addr=3D[X]" is much easier than "mem=3D[X]"
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > mem=3D is a hack already, please don't add another one. Limiting
> > > > > the memory like this is far too tricky, given that the kernel
> > > > > itself and the initrd could end up in memory that is excluded,
> > > > > and we have to go and fix things up if that happens.
> > > >
> > > > We wanna to use the reserved memory with request_mem_region, but
> > > > with commit 86588296acbfb1 ("fdt: Properly handle "no-map" field
> > > > in the memory region ")
> > > >
> > > > request_mem_region will fail, because the reserved memory are now
> > > > as kernel memory.
> > >
> > > request_mem_region() is for MMIO.  Why do you want to use it for
> RAM?
> >
> > + Jan, the jailhouse hypervisor owner.
> >
> > There is an out of tree driver
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2Fsiemens%2Fjailhouse%2Fblob%2Fmaster%2Fdriver%2Fmain.c%23
> L466&
> >
> amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C0540c0c55ed24688f9f308d
> 9bfb0b7
> >
> 7d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6377515879788
> 01324%7CU
> >
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1ha
> >
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DowLVa3T4jnTPvohHwdEnP2%2F
> uMiUJmYeTc
> > 1TwM0i9iCE%3D&amp;reserved=3D0
> >
> > The hypervisor jailhouse is loaded after linux boot up, and the
> > hypervisor bin file needs to be loaded into DRAM that reserved in our
> > device tree with node with no map property.
> >
> > And the hypervisor use virtual pci for communication between VMs, The
> > virtual pci use part of the reserved DRAM area as PCI MMIO space.
> >
> > Maybe I should use /memreserve, but not node with no-map property.
>=20
> So, my understanding is that you need a chunk of memory that Linux does n=
ot
> use and does not map into the kernel page tables.
> In that case /memreserve + nomap in the device tree could be a better
> solution than mem=3DX.

nomap not work now since commit=20
86588296acbfb1 ("fdt: Properly handle "no-map" field in the memory region "=
)

I need try /memreserve

BTW, do you think max_addr would be an option be added to memblock
common code mm/memblock.c?

Thanks,
Peng.

>=20
> > Thanks,
> > Peng.
> >
> > >
> > > > So we use "mem=3DX" to work around the issue, but "mem=3DX" is not
> > > > user friendly compared with "max_addr=3D" when there are multiple
> > > > holes used by
> > > others.
> > > >
> > > > Thanks,
> > > > Peng.
> > > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  arch/arm64/mm/init.c | 21 +++++++++++++++++++++
> > > > > >  1 file changed, 21 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > > > > > db63cc885771..3364b5e7a7fe 100644
> > > > > > --- a/arch/arm64/mm/init.c
> > > > > > +++ b/arch/arm64/mm/init.c
> > > > > > @@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
> > > > > > EXPORT_SYMBOL(pfn_is_map_memory);
> > > > > >
> > > > > >  static phys_addr_t memory_limit __ro_after_init =3D
> > > > > > PHYS_ADDR_MAX;
> > > > > > +static phys_addr_t max_addr __ro_after_init =3D PHYS_ADDR_MAX;
> > > > > >
> > > > > >  /*
> > > > > >   * Limit the memory size that was specified via FDT.
> > > > > > @@ -189,6 +190,18 @@ static int __init early_mem(char *p)  }
> > > > > > early_param("mem", early_mem);
> > > > > >
> > > > > > +static int __init set_max_addr(char *p) {
> > > > > > +       if (!p)
> > > > > > +               return 1;
> > > > > > +
> > > > > > +       max_addr =3D memparse(p, &p) & PAGE_MASK;
> > > > > > +       pr_notice("Memory max addr set to 0x%llx\n",
> > > > > > + max_addr);
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +early_param("max_addr", set_max_addr);
> > > > > > +
> > > > > >  void __init arm64_memblock_init(void)  {
> > > > > >         s64 linear_region_size =3D PAGE_END -
> > > > > > _PAGE_OFFSET(vabits_actual); @@ -253,6 +266,9 @@ void __init
> > > > > arm64_memblock_init(void)
> > > > > >                 memblock_add(__pa_symbol(_text), (u64)(_end
> -
> > > > > _text));
> > > > > >         }
> > > > > >
> > > > > > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > > > > > +               memblock_cap_memory_range(0, max_addr);
> > > > > > +
> > > > > >         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> > > phys_initrd_size)
> > > > > {
> > > > > >                 /*
> > > > > >                  * Add back the memory we just removed if it
> > > > > > results in the @@ -427,4 +443,9 @@ void dump_mem_limit(void)
> > > > > >         } else {
> > > > > >                 pr_emerg("Memory Limit: none\n");
> > > > > >         }
> > > > > > +
> > > > > > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > > > > > +               pr_emerg("Max addr: 0x%llx\n", max_addr);
> > > > > > +       else
> > > > > > +               pr_emerg("Max addr: none\n");
> > > > > >  }
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-arm-kernel mailing list
> > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2=
F
> > > > > > %2Fl
> > > > > > ists
> > > > > > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;dat
> > > > > > a=3D0
> > > 4
> > > > > > %
> > > > > 7C0
> > > > > >
> > > > >
> > >
> 1%7Cpeng.fan%40nxp.com%7C3ad0ef697ad64542556208d9bf9d1e1f%7C68
> > > > > 6ea1d3bc
> > > > > >
> > > > >
> > >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637751503805222488%7CUnknow
> > > > > n%7CTWFpbG
> > > > > >
> > > > >
> > >
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > > > Mn0%
> > > > > >
> > > > >
> > >
> 3D%7C3000&amp;sdata=3DiKVO4PUPnaRr%2B5gHcXxaaRxBt%2BK%2Fjytg8eQ
> > > > > dCqgqh5o%
> > > > > > 3D&amp;reserved=3D0
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>=20
> --
> Sincerely yours,
> Mike.
