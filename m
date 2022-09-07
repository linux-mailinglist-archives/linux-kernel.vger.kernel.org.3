Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D825AFEDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIGISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:18:37 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE1AB1A5;
        Wed,  7 Sep 2022 01:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8a/WHaaTOCEiwbhhCm810hUdFjr4crbNZGkZg1rBQlFgYIiITXEeif6o1UDzj7Y6B+dtSQP1PuUnRRlCjKzyCjZc1TTbr11lBTN4Zm0Joot95ENsN+rNFUsf28SOaJyd1kPzJNyP86TCMwXtFZPO2Vyl3bxDMEJMlnUeGYCh12NwGGRvfLTELBOuq/rqVkRCKK6gJgYLV7+QDxb5jsQ9h5fF9AueuofAiS5wQrUKd+NnTvMVt579pOf1/+9tVUqlMfKo1Y6I1b0PFud7OF/b+E18XrA/Ug+qFt8ZKSL2nY7QN2zQ3ViJCeLtPmHcRE6CSWassxZfLHXyF3eimAuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaBI8FQx2s9ki1yDubPE1ILsNLVHm3vqBO42HN/+YY4=;
 b=k/BhiPlehJCJkjddhom9IPBmpoBhSflc7GZKb7T05vHZY286JVueXj1ehMuD8bIi2LcTxAemb8reOl1CPdG5M3wa6ZmaD5COnh8i3hRSqvAC6pHRva6JSvud+K2mw4K0KCnnnFeYiZmvpfcniZVh0evCdssYicSYBxV55Gj10MyBqcDUn+XfYZIlOWAnZYJeQ6/iB+nwKPAj7YzIG4vJwmjZkevoHHwHAArrPCBAfv+rnGiHUudBGDPsmtIv4CkGAgcqrBq0MLCLMuy1fOZ/rCXaGv4BEvYwV9ejpwe3mtF0B4fI6Y3nfzodOYu0LzR+dVuaaQtif+x+mc8J2oyEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaBI8FQx2s9ki1yDubPE1ILsNLVHm3vqBO42HN/+YY4=;
 b=WMOAI6bRosG/uWSqL/XDydO+vtm/WTzCEtZIXle5wBfMDv6Ensc+5jHSVdPhhL7PAyoM+iSZNYNlDCY0DuOVT+j43BCgAsv/7JJ64zuAAqO2IfIVDHAcVs0suniYpf3nFVmUB1w6NjXUc/HHvvmhKPG4eNpYly+ffMQZX2X5L34=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYBPR01MB5407.jpnprd01.prod.outlook.com (2603:1096:404:8023::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 08:18:31 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::5c6b:d323:4806:9b9]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::5c6b:d323:4806:9b9%3]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 08:18:31 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prabhakar.csengg@gmail.com" <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdrGeUEU7xo1X0C5pIjumEuYVq3SNg2AgAFpbSA=
Date:   Wed, 7 Sep 2022 08:18:31 +0000
Message-ID: <TYCPR01MB1058865290D9F2ACFE99086DEB7419@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
In-Reply-To: <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c18eb28-d5ea-4579-4655-08da90a98cd7
x-ms-traffictypediagnostic: TYBPR01MB5407:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qc2dAAGC3uqIgCoh4wWHgMFlQUJiMRXEvmHd4jRzsHqsLRJX+F7GItodYA4xYRuO2MUisRbRPDwgkRln6xjx1HY77/ure/WCb9IVg76OZW3ZenAejYE2+jphbMCvO5anjMnlSmvBO1AJ9qb1DXnvygKq5vUJsCALqQ+Y/hggvwLTFPhpBYlqOlQlcn0rLUoK58aQDaygxTFnjDj5mhtIZ4Fp6GdUWlL7j0OF8h12IO+Z+NWhd/yjAZSM9gZwjBVsnSFDZBYeSVJ5EFu6iH2r+gz75GHNG2BMcMZt/EvOVoYLnbttzb0XToNlrPgwMjG/2HIEG3qVdHLiv8gzbx5iBQItTt7iJmAQEC6L9ozwZADspCZ8Jj5sgIYgthwVyZTvEWo5k1FSGj+hzwsfqbPVOaMe2vhLTwKUBdL0QKrQzwP9b8LcmwQH6AAD8K6BWD9gb3JqWurSsFgpfV3B5JpMW+3VLHYDHOmv6qe4W+zKX1gU9nVykEBdr04UlfXeym/Ip80jeMsXFsyVxYO0aaiOp07xJb/Qhfi/zvs0QoZLa8aJLnLQ3cEMS7cQ1NbKyjNpnv7YPUqXqDNWc3vCxTBoT0NLqW172pEjdHuc93fcL08BEY4v4fqU55Ry5QRw3JatRjJ3zCpRkXsQuPdMPQFDwvBbr2yaHBvSsBK8JZF2lG7bqwlZHUzVTeuJvzeMJxFJTA/J84mMrwc4NZwXbzPaOE107fYNeWieEnPS4cvGPXB0nyFrcT37mb6f5mq3UgUVqeRfOpGUl/YRIDOgprGcfu2cyWvhRMdV683O69D9qJwY5od+doQKjj1xZ0zrFWQMAE/DQTGw0VsdfEjzBgd0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(478600001)(76116006)(110136005)(2906002)(83380400001)(5660300002)(66556008)(64756008)(4326008)(66446008)(8676002)(66476007)(7416002)(316002)(54906003)(66946007)(52536014)(33656002)(8936002)(71200400001)(55016003)(26005)(41300700001)(9686003)(966005)(6506007)(7696005)(186003)(107886003)(86362001)(122000001)(38100700002)(53546011)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0FPG6G0LSbXw7kwmb+wmLSZk9fFq51H5J8QcA40kRqxBW1Te78DmTH4k?=
 =?Windows-1252?Q?E7V0t0zjlrSPhiCOkCbe3BF3zkKAgUbgdH9nLhDmNECp0hwfGgoweFft?=
 =?Windows-1252?Q?Pyn7+pRvPnA/xcAH9weYwtdWur3pbuIi3az16YRonDWUCANBrRg50xIQ?=
 =?Windows-1252?Q?LEedn03bzLxs3jDlgXKyY8kwNhtwRuGcKYEzOqhTDS9c7gs2PiPb5GMj?=
 =?Windows-1252?Q?aOUY3m2TjaEoCaNDFsY7OHyBnQGIH3hvKrlpFW5zKX49YLxCURSexcGF?=
 =?Windows-1252?Q?z2GnF0kzyiJwPzO9NOh75CzDY4j+lALd0xona2Jrz1ag8YUstNKcHYeA?=
 =?Windows-1252?Q?ZlanNwY97Mwe457DepLJDkiqkq0E5f+KPnxu0+AgiabkP8hSZE5qMgC2?=
 =?Windows-1252?Q?iblRoVlvqXX4wHQ8rS2aVxMe/ayyARJBfq2pegEEB14wP+wUHX7+1kn7?=
 =?Windows-1252?Q?8/Fj/6LLUQ4YWKK6UVy5kD8LQox/S5V18je3Zl5wj+Vce5pD1Xq2YqxG?=
 =?Windows-1252?Q?wlvHa96QgPMTctomSxbH5bMDro544eq/e5BQFH6eyiM2ezJUSEKKT/5S?=
 =?Windows-1252?Q?qeMiwn63Uw7UYwslIAktKrMmTZP5K4e0itN0oPIOi4vvapz8W+t3sEaD?=
 =?Windows-1252?Q?CQ5Zy/u508xE7Ket++XzInNGC5G/O0yzycZCER87AsaBwIK04lIae/Fh?=
 =?Windows-1252?Q?r6JZjX3D986eBxmkJuzI0c/wfk6W1TkBi6MvuCGe2k1rXzFOVGOFE47j?=
 =?Windows-1252?Q?jiQ2x5Zjd0E4eUQskCCDoz0iHG4LXLkPkR6oqgD6tKmTpEv/o5isM9L2?=
 =?Windows-1252?Q?Q6QWwr4amlT841744P7ckN0cnYtJbxzi0eGamN/AS9e4x9s1qIieFpkT?=
 =?Windows-1252?Q?kO5ar4nQAJf+2q59HvqQFgLvhtglMaXaRamd+CpA69J6koAJ5oQGye9E?=
 =?Windows-1252?Q?vZH8+f2TJ+vp+DRiPilom6ranIgJSQplwa0/u2hzx7VSLCLaoU0wfjWp?=
 =?Windows-1252?Q?LdZ753Pi31CoG4xjxj3aYuH7Oj+vQ8Gt2UPq+vrrgLrkCV8t6OJk/Q8a?=
 =?Windows-1252?Q?yfNXzTVMpq7IeXSAKuxz6bWIxmuhfByySIC1LLtPdYCDIsBUG62bZtf4?=
 =?Windows-1252?Q?qkLjcznecG6dfXZBAAjShIahTxyVE7O+vU9WXZOTEnyTAbBc6VpocOo8?=
 =?Windows-1252?Q?kyw6pzhZSVK7RbssvAdZpE4EgcxR/oz29sioqYU77GRpEiZLhE0CkekV?=
 =?Windows-1252?Q?kXb6f0mu2KPIkq2UFHc6ldSuy8sKEcUwjQxyngOiQmwm3Q3gFBaXDXRL?=
 =?Windows-1252?Q?9zzqtPpiqUfoplK5kAJ6bg76Dnx+Sgcf6JK2+uzhlHXme3rP7Ik4vv13?=
 =?Windows-1252?Q?oIfoAgvnvyvCM5vCfaQfQOpFrv5xSqO6bfkeDlaRcBRQ2GFK1EkpxDpt?=
 =?Windows-1252?Q?2mByMaFPQgW5Joz8kTWifNseTKl9sV3aPxQKzHVnQSN36oOTBREYugSH?=
 =?Windows-1252?Q?3FBrieTXqzf76d573f7qrsypcjU2qd4mXbkEhsnta/dfmOx8yvVWWZbN?=
 =?Windows-1252?Q?qJmf/L15q18I5N+HxjJGdZbGX2faWL8wqpyiNRqI6488DR/TG2S6FnFt?=
 =?Windows-1252?Q?XfZyKO6ZQwslRN4tj6H0FSx/4uhqQ+o//uwD7+Bl6TKks4ZywiRe7Ud8?=
 =?Windows-1252?Q?du/3sH+KWnkhwutOSSu4OzQCte4QxXYZ+Z9Ut6N68aK2erJttIMLhA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c18eb28-d5ea-4579-4655-08da90a98cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 08:18:31.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jem70ZjPz2E0Q/UahqvBdjp7r1QHdi450DTr1axuEz8XM/8mUQGeIWNzE0Ttu6ukLxWS5xgecEC4HaDBuwErXnQsN/CGhfh1tZzRBIuS3D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

Thank you for your interest.

> From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> Sent: 06 September 2022 11:39
>=20
> On 06/09/2022 11:21, Lad Prabhakar wrote:
>=20
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 2a0ef738695e..10a7c855d125 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >
> >          /* Vendor extensions must lie within this range */
> >          SBI_EXT_VENDOR_START =3D 0x09000000,
> > +       SBI_EXT_ANDES =3D 0x0900031E,
> >          SBI_EXT_VENDOR_END =3D 0x09FFFFFF,
> >   };
>=20
> Everything else aside, I am very interested in what's happening
> here. I'll take a proper look through things later, but for now:
>=20
> For PolarFire SoC we have an InterHart Communication SBI EXT that
> would would like to upstream support for. We are not aiming to put
> the driver itself in arch/riscv - it's just a mailbox driver, but
> I would like to use sbi.h for defining the vendor id etc.
>=20
> I am not sure how this all aligns with:
> > We=92ll only accept patches for new modules or extensions if the
> > specifications for those modules or extensions are listed as being
> > =93Frozen=94 or =93Ratified=94 by the RISC-V Foundation. (Developers ma=
y, of
> > course, maintain their own Linux kernel trees that contain code for
> > any draft extensions that they wish.)
> >
> > Additionally, the RISC-V specification allows implementors to create
> > their own custom extensions. These custom extensions aren=92t required
> > to go through any review or ratification process by the RISC-V
> > Foundation. To avoid the maintenance complexity and potential
> > performance impact of adding kernel code for implementor-specific
> > RISC-V extensions, we=92ll only to accept patches for extensions that
> > have been officially frozen or ratified by the RISC-V Foundation.
> > (Implementors, may, of course, maintain their own Linux kernel trees
> > containing code for any custom extensions that they wish.)
>=20
> Which is in: https://docs.kernel.org/riscv/patch-acceptance.html
>=20
> It is unclear to me whether that is just for ISA extensions or if that
> covers SBI extensions too. At least for us, since we don't touch arch
> code there is relatively little friction & there's no concerns about
> reducing the portability of a kernel since it is just a regular old
> driver.
>=20
> I was planning on cornering some people *cough* Palmer *cough* at
> LPC and asking him what his thoughts were there.
>=20
> FWIW this is what we have been doing:
> https://github.com/linux4microchip/linux/blob/linux-5.15-mchp/drivers/mai=
lbox/mailbox-miv-ihc.c#L27
>=20
> The IP itself has not stabilised yet, so we have not sent any patches
> yet, but we do intend doing so...
>=20
> But yea, I'll take a properly look at what you're doing here soonTM,
> although at this point it may be the other side of LPC.
>=20
> btw, where can I get my hands on your hardware?

The latest information I have is that it should be available via various di=
stributors on the 21st Sept.

Kind regards, Chris

>=20
> Thanks,
> Conor.
>=20

