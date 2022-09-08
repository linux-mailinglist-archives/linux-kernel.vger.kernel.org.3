Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B825B174E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiIHIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiIHIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:39:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CD112E64;
        Thu,  8 Sep 2022 01:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGijST0k6I1O5epsqJofgajhLUB9pJompzXAl2FDFoiayJXhkDYJ+43Jtqfey/HpqOSp8GODKmhfwxf6z6/622sF2bYr7Ou4+HPp6SCYnra3eSnkhOqZz0DxDjpeKzrgTk3RF+bby+XCa5YZak5JdKvTdmXQc5XbHEdFqfBE35qYUxndRPCOMS2Hw3urAP0RMUknF4VTRf8pYmvrIRYqGE3tmPCKVrrQ8QK+dCF1uv45LA/y0XpxzpiWDL06clBiOd/f+xhlqfjljNB1HFuk1ZyGvgyFdzEbRhVGdPm0dwhcRFY6AGQAsD4F46lcebgZBzkg3a93PncMbhujkVVfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op4shTPyoaRgvIpX/NpyPVd2Oc2hYIpvSzGUnDprReI=;
 b=hwDUMeM5MV+1EcfRBGqeh5y43Qsz9hvk9N4UyULubGnjEYhy7yy5YS5XcnxVRo6kLZn5H2XIarWDMDW6OsmUVtzGdkdcWwj0LsWBQSH7FpITtBDIyljUGzz2ZiZp+xEwg5RuqdzIh9Y0t6y+FBydod8d0jScp/+TrwuqjdOUD0C1yDCDluLeVSlRJhAddMNhsuD4tutI1SNOGQaC8nqvZdbdlpuNiszXhNszfDDBGDj8XLW7UXG/YGJveeWOyHYPe/JQpJ2uXg0uRfjSL8am17kMQwI8UppB+Pd/UUaCaCs1VsqWUezbOzPfUgpN8yqUx6nyYT9g+OhTUFdNTecmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op4shTPyoaRgvIpX/NpyPVd2Oc2hYIpvSzGUnDprReI=;
 b=MgY1l2/E+tbVGqw9RHIMsnPzZMQL/D2+4PIW1G8KfTThCaAQdsd5Rhg9hHSkOwof9lubVcb1roJmCo1wVHjtLjCuYB84D0lqdfDFf8zmy3+33R1rrEni0OBhTaU7lF9NM++zu4rpDxeZvyPpJMabKA6M37HysuyOsHq1L+qi5ds=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8623.jpnprd01.prod.outlook.com (2603:1096:400:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15; Thu, 8 Sep
 2022 08:39:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 08:39:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prabhakar.csengg@gmail.com" <prabhakar.csengg@gmail.com>
Subject: RE: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqJJqv+SV7oQUWARHgAT75zHa3SNg6AgAJOjgCAAB1VgIAAlHqg
Date:   Thu, 8 Sep 2022 08:39:02 +0000
Message-ID: <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
In-Reply-To: <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8623:EE_
x-ms-office365-filtering-correlation-id: be771f0d-703d-4678-c673-08da917594d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uk7iG2nHcXZfIeYqZk7jLtYiqqB4uxV3y8fRSATqtAVBEM94qjHOpVKlv5HbTydXSpbkby9+gqflJHzHKVyUG6y2kAMz+8eBgsK/XuCkTZ9+XtiKoL+lglocj9h3eRg6hpJy01vwM3JB77FtuBq3K/CRW8Ov5skT9FAIidembCZnpwi0WgJJAmPr75+R0iCTR4ucCoK85Mn2KACHxbh4tGho/SZ4MKxIVb0raZIpfyTUIzG4tCbRYSiX/Pd+aidLfb9tBhRp3DPke3u15TOYpb9tUv+MNRZP0tOlrzVLi79aN7fMwY2fsHWkxXTBKUnkrYHS20626+IcUBhbrske0jAu5kVTG/0KeLvJEZEJpdLFCsdCROYMjJeR0Z0jayzuhpLiL5LTDvW9+R1/rxY/X5LxG3iLIChDGTnhtHg7IhWty2lRiqr1XIs8m+0y9AetsDj/xHHI6CXe6kExSHI5Nj59gH5RORCTwYtihuqC5WjIFWGVNHu7NzhSV5FyRFULOtu6x1DahpfbHH+muv8QNSw4m4766iMm4rieCZUqqTkKiqkRLiqiOILM9ClA2fxQyxcPU1aeBdWVKZfESe85MxK9N0SBmv7OINY8GJdAgcTQbflDdgJboHJMDXK3Ya2ePs5smxKflPwA2ZPBZAo8tuNEptzWPUEz/wWNwenWe+PdCBa2h+991OG9twxlvR4VQSXRNBbKWooTDSde40TKbwj5Mj9a5nH8lJrPvapN0giLvLsPLh8nioi7qtF39NFqZ/VYQv8QhIrqtZUERegUpbB+ywpqdoMDV4ZLRFa107BgVp86+DLenS1LzM3YjPu3vg6p7kNCj3H6prJnIRVO5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(186003)(122000001)(38100700002)(2906002)(33656002)(83380400001)(55016003)(966005)(54906003)(45080400002)(86362001)(110136005)(66556008)(41300700001)(316002)(66476007)(64756008)(8676002)(66446008)(7696005)(66946007)(76116006)(4326008)(38070700005)(7416002)(5660300002)(52536014)(71200400001)(478600001)(53546011)(8936002)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?007NF3FJsi85hlYqndBVc/jgxSKoQu2NAZnBx8LSajJ+YTJYIuhJpGTWm0UR?=
 =?us-ascii?Q?994goiMTu4t0aqGQbBiGKcQVD2xcAOIsafm45wiRO211wDdvendCX3diV76M?=
 =?us-ascii?Q?lVVKIk/ZaYcnVnmlma1SAzgxDNTzE3xVA7jwXeuqnm3TeFB/H4QR6x9n1eCP?=
 =?us-ascii?Q?PbBp9XZqzEB6yUkHZxgM2UhbB3rZ5+oKpCZen+NiNAWrPHcfNlj8vTD1sxBz?=
 =?us-ascii?Q?dkumYKi6p3b7eYT8raIjJT9GvK6symmIjYSziSoK3QUc+9uy2aA6x7S3wot9?=
 =?us-ascii?Q?YmcpbeYNS7TvkiMy6ytMwwWGbyxpgKLaxs6PbQVJzcepU0mGYNP+PQ8Sm+Jy?=
 =?us-ascii?Q?obTms7+nZBDZK9uSh7rAZFxN6PB2yrK4N6Pr0QsVx69//uPswDaONV9W5rfX?=
 =?us-ascii?Q?uXnHtIRlMP4XIX8F6ws91qGESpFFQSRJpyENjZ879UnrqW/fmHx3JnIlTPVj?=
 =?us-ascii?Q?n++4wkSMt6NL6ffTFJvrS+QiplY45LQhUCo2zfTOs2tg8fvYaQIKXkloeRsT?=
 =?us-ascii?Q?0Yc9dI8wbYO75zHUfN5vI2h1/ZJgn0PIt+RS/EZlI8j4fuGXBpo0yi2bN7IL?=
 =?us-ascii?Q?PZ6m4wb5Tj2A8q4PZgEIlmglDZxtcCSMDjz2E1wHHaOaM121ge+dgVeMi3PF?=
 =?us-ascii?Q?XCt22p0wb+utRzz+RHVCn1XsWuQ92A7EyFI+TiGIu8P9rnVwAW76qUUqgnUd?=
 =?us-ascii?Q?q9/B/EhW/QnHEPSi6sR0dT2HyQBHkBUgTZXJ+1rjT1cElFoTq+BDC0e4d2P3?=
 =?us-ascii?Q?+pAytLJn3XZcBzePC544/AnIzMXspgeTTzX0Z+ckyuIpmxDK/OTL3hHHnHL6?=
 =?us-ascii?Q?WEZANMSHfKZuglp+/lNxGdH3/XQuqJne7ekNA3T3Wds/jbom/bdKgZ7tNfBk?=
 =?us-ascii?Q?xgTREvRo3/CsAk5qOde3AiZnup3mB/9/SDBkny0kimUL5JshfEjNSPF9bJvo?=
 =?us-ascii?Q?oM1FZWsl77N55IOZ0+mufuMj6Lwwm0Og7AuG/DKdsXWATRY1BCJnGlyeIcPW?=
 =?us-ascii?Q?pwVkFFDQF7i2ZRG4KlnkObRWhHj7ZI5vfJyWZuYpfUK4Kmu3vFY+56suriM0?=
 =?us-ascii?Q?SANPwkzodhk00qR3QHmEnrVSt1+mpNWmRd48qb0/3DyKdhOVAnuvCA7zbRpd?=
 =?us-ascii?Q?IgeFiTHBqEgRGSWwEVbXH1mQTTfBobwQ4aS11/xkxab/2267LGSASHno3to/?=
 =?us-ascii?Q?6u7iHHWCxUqjSYDZkUXhjNaV9UY6LwDcpSkmrVK+xzZ9xMBkJ+8RU7XapGQJ?=
 =?us-ascii?Q?cr45sdyN1axMyXpFCdyET8qYDYGuxQkv4unWvc8z9Yu9WbSFvzDOzJJOASXr?=
 =?us-ascii?Q?4CEQ9BeBEk9Nd7gwX3C7p6t0fYpluil3ZSYJf+WhlnKPKXVOhBeF+xJu8QWg?=
 =?us-ascii?Q?ZBzCFpvam8PYKzew5+gJTeXjrlI7tdiZzRYnawQwJadbGopnJv5t5IjIIiX5?=
 =?us-ascii?Q?peXFuPoROFdjUKzZLOwWPvCMfup5KoWenhvJoBh7Ftu8Vd3gR97qJKvCbLQM?=
 =?us-ascii?Q?yISlXLTsse/clKiMUrJ51ww32h9vR8/ZfljxemjIr+/EbxKAOE27zhrboXB5?=
 =?us-ascii?Q?Y/Y6FKQcW2Imaosx/C93Stxi8yxe6RRKYojlFgc256vYsXp+bgbyHLbbTt9+?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be771f0d-703d-4678-c673-08da917594d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 08:39:02.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GW9ju6dFBeLbVzt1td9AvqdpfE4GpIiyO+AvFbLGVyP3wqQIL0li/KosN9bJo2PMYrzWMo/pTAQJh+I0GrEXEQQ96z5cODDhiZ44g50GJvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8623
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Atish,

What RISC-V devices you have?

Ours is RISC-V uniprocessor without IO Coherence Port.

Currently USB, ethernet, SDHI/eMMC doesn't work with standard
DMA api's.

On RISC-V world, how do we handle DMA api for uniprocessor without
IO Coherence Port?

Cheers,
Biju



> -----Original Message-----
> From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> Sent: 08 September 2022 00:38
> To: atishp@atishpatra.org
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> atishp@rivosinc.com; apatel@ventanamicro.com; geert+renesas@glider.be;
> linux-riscv@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-kernel@vger.kernel.org; prabhakar.csengg@gmail.com; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> configure the PMA regions
>=20
> On 07/09/2022 22:52, Atish Patra wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> >
> > On Tue, Sep 6, 2022 at 3:40 AM <Conor.Dooley@microchip.com
> > <mailto:Conor.Dooley@microchip.com>> wrote:
> >
> > On 06/09/2022 11:21, Lad Prabhakar wrote:
> >
> >> diff --git a/arch/riscv/include/asm/sbi.h
> >> b/arch/riscv/include/asm/sbi.h index 2a0ef738695e..10a7c855d125
> >> 100644 --- a/arch/riscv/include/asm/sbi.h +++
> >> b/arch/riscv/include/asm/sbi.h @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >>
> >> /* Vendor extensions must lie within this range */
> >> SBI_EXT_VENDOR_START =3D 0x09000000, +       SBI_EXT_ANDES =3D
> >> 0x0900031E, SBI_EXT_VENDOR_END =3D 0x09FFFFFF, };
> >
> > Everything else aside, I am very interested in what's happening here.
> > I'll take a proper look through things later, but for now:
> >
> > For PolarFire SoC we have an InterHart Communication SBI EXT that
> > would would like to upstream support for. We are not aiming to put the
> > driver itself in arch/riscv - it's just a mailbox driver, but I would
> > like to use sbi.h for defining the vendor id etc.
> >
> > I am not sure how this all aligns with:
> >> We'll only accept patches for new modules or extensions if the
> >> specifications for those modules or extensions are listed as being
> >> "Frozen" or "Ratified" by the RISC-V Foundation. (Developers may, of
> >> course, maintain their own Linux kernel trees that contain code for
> >> any draft extensions that they wish.)
> >>
> >> Additionally, the RISC-V specification allows implementors to create
> >> their own custom extensions. These custom extensions aren't required
> >> to go through any review or ratification process by the RISC-V
> >> Foundation. To avoid the maintenance complexity and potential
> >> performance impact of adding kernel code for implementor-specific
> >> RISC-V extensions, we'll only to accept patches for extensions that
> >> have been officially frozen or ratified by the RISC-V Foundation.
> >> (Implementors, may, of course, maintain their own Linux kernel trees
> >> containing code for any custom extensions that they wish.)
> >
> > Which is in:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s
> > .kernel.org%2Friscv%2Fpatch-acceptance.html&amp;data=3D05%7C01%7Cbiju.d=
a
> > s.jz%40bp.renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d82571da1
> > 947e49cb4625a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C3000%7C%7C%7C&amp;sdata=3DYAV2Ahz7TFMJJ3wCj%2FAdDuDEcPq0kXXL%2B3o6F=
A
> > d0%2BUI%3D&amp;reserved=3D0
> > <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdo=
c
> > s.kernel.org%2Friscv%2Fpatch-acceptance.html&amp;data=3D05%7C01%7Cbiju.=
d
> > as.jz%40bp.renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d82571da
> > 1947e49cb4625a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7CTWFpbG
> > Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D%7C3000%7C%7C%7C&amp;sdata=3DYAV2Ahz7TFMJJ3wCj%2FAdDuDEcPq0kXXL%2B3o6=
F
> > Ad0%2BUI%3D&amp;reserved=3D0>
> >
> > It is unclear to me whether that is just for ISA extensions or if that
> > covers SBI extensions too. At least for us, since we don't touch arch
> > code there is relatively little friction & there's no concerns about
> > reducing the portability of a kernel since it is just a regular old
> > driver.
> >
> >
> > It covers the standard SBI extensions as well. However, I don't think
> > this includes a vendor extension as there is no freeze or ratification
> > associated with vendor extensions.
> >
> > It would be good to discuss the policy around vendor SBI extensions
> > during LPC as well. We also need to discuss the ACPI policy as well.
> > We most likely need a BoF to discuss these adhoc topics. I will check
> > if we can schedule a BoF in advance.
>=20
> I did briefly mention this to Palmer on IRC last night, just was busy
> today & didn't get a chance to reply here. The indication there was that
> yes, this paragraph did cover SBI extensions - which would make vendor
> extensions not permitted upstream.
>=20
> We (microchip) are "only" doing a few ecalls in a driver but this seems a
> fair bit more intrusive since it is in arch code. Even if the answer is a
> "no" - a no from the horses mouth rather than on IRC & maybe some
> rewording of that doc to be clearer would be nice.
>=20
> I'd be down for a BoF, even if just to get a "no" in person haha
>=20
> Conor.
>=20
> >
> > I was planning on cornering some people *cough* Palmer *cough* at LPC
> > and asking him what his thoughts were there.
> >
> > FWIW this is what we have been doing:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Flinux4microchip%2Flinux%2Fblob%2Flinux-5.15-mchp%2Fdrivers%2F
> > mailbox%2Fmailbox-miv-ihc.c%23L27&amp;data=3D05%7C01%7Cbiju.das.jz%40bp=
.
> > renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d82571da1947e49cb46
> > 25a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7CTWFpbGZsb3d8eyJWI
> > joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > C%7C%7C&amp;sdata=3DseNiuv6EsY1u0SIT33%2F0CWHJu401d5zSaNmVb%2BUHKPM%3D&=
a
> > mp;reserved=3D0
> > <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> > hub.com%2Flinux4microchip%2Flinux%2Fblob%2Flinux-5.15-mchp%2Fdrivers%2
> > Fmailbox%2Fmailbox-miv-ihc.c%23L27&amp;data=3D05%7C01%7Cbiju.das.jz%40b=
p
> > .renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d82571da1947e49cb4
> > 625a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7CTWFpbGZsb3d8eyJW
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> > 7C%7C%7C&amp;sdata=3DseNiuv6EsY1u0SIT33%2F0CWHJu401d5zSaNmVb%2BUHKPM%3D=
&
> > amp;reserved=3D0>
> >
> >  The IP itself has not stabilised yet, so we have not sent any patches
> > yet, but we do intend doing so...
> >
> > But yea, I'll take a properly look at what you're doing here soonTM,
> > although at this point it may be the other side of LPC.
> >
> > btw, where can I get my hands on your hardware?
> >
> > Thanks, Conor.
> >
> >
> > _______________________________________________ linux-riscv mailing
> > list linux-riscv@lists.infradead.org
> > <mailto:linux-riscv@lists.infradead.org>
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flist=
s
> > .infradead.org%2Fmailman%2Flistinfo%2Flinux-riscv&amp;data=3D05%7C01%7C=
b
> > iju.das.jz%40bp.renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d82
> > 571da1947e49cb4625a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7CT
> > WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DAaMGs%2BqRpuw8MOWci3qPvJ1W5U296Vp%2=
B
> > higFxDSoHmo%3D&amp;reserved=3D0
> > <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
t
> > s.infradead.org%2Fmailman%2Flistinfo%2Flinux-riscv&amp;data=3D05%7C01%7=
C
> > biju.das.jz%40bp.renesas.com%7C7fd3275accdb450e547a08da912a0042%7C53d8
> > 2571da1947e49cb4625a166a4a2a%7C0%7C0%7C637981906834865446%7CUnknown%7C
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DAaMGs%2BqRpuw8MOWci3qPvJ1W5U296Vp%=
2
> > BhigFxDSoHmo%3D&amp;reserved=3D0>
> >
> >
> >
> > -- Regards, Atish

