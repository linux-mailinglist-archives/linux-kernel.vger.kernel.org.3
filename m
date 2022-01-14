Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFD48EF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiANRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:11:43 -0500
Received: from mail-cusazon11020024.outbound.protection.outlook.com ([52.101.61.24]:47448
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235260AbiANRLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb1LFfp0c0x3GT1H2QeS1533dKApCa2cunV8GAiBEJeYYgAThBScg0s3PnCkAv3AVlwrenJPwhru/T5cpSGQJY6tdXLWwRO5Nz5vsB7AzNH+Nd7aMKi9nDe2UwUJeGLuDhg10xpoSqD27nkeHn2F+rms16/Awr+WarNJre5Vf5FWw+iCVv+HGrGr+zSQ5gexm+enrZMx6Wz60mhUpzV/lFuMBHIHsQEPtMyumsp8WUCJcGricTwCmi6eOnhjS3Eo5z1N24ISbDWrlyXCi8gN2Nak8CI8cyH1wiKJbUo27t6kW/lk6xm9rCTY5JXgbPZJErOXYAhTLNMTZcY2g+EpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HumsrFaWlRZRTUods2ciDoqhzA8Z7mu3lm9LlxNFgxk=;
 b=caJPgAD9b01YTTvbWo/KlbQkueAF13EPQ7Jh138EyuU2jkXZ4Tv0jmQy/IKTEA/+G7lBanafWnHJy26BsP1I+j1Kaf50RhVCDMyC1zUOLA/tgTOwV9Z7WWXwdTLE9Qe/zdsxAE8ceGMbQvC9zETCpYYulGg3U56KdpPhe5ZGulKzQW5g+/bw1ZRWMTDP+btKMPWk0NjEq49fStlTrjtYK5rr/RhDzCQEDU+M8w1gTLTdw63paVrxC7kOginTMdUnkEavFhxdgIQ6DoLPgvdKgF5aO0OA/SZBOOEjj7Wd70dy4MTgMDOHVZRa1LWcVD0GuR149ipVMl4HYFn0ur6GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HumsrFaWlRZRTUods2ciDoqhzA8Z7mu3lm9LlxNFgxk=;
 b=aBgvLTNza/yWG2SnWwoIi8v+l9LUMc88Y8XpAIvh7TW+rSXKzfwMaojV0XJMfxFX2O1grX92T1rRKBi8e7dDkfb2yRfppTNSr13qf4JAW4TNQWjv8Q4MMoO1zBsKDXm0bKHIfWkCEzc55O9lVAOZUZfVkJR+rtWZv6j6uEiTOqM=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by CY4PR21MB2099.namprd21.prod.outlook.com (2603:10b6:903:ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.4; Fri, 14 Jan
 2022 17:11:39 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::5431:89c4:b796:d095]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::5431:89c4:b796:d095%7]) with mapi id 15.20.4909.004; Fri, 14 Jan 2022
 17:11:39 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
 Dependency
Thread-Topic: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
 Dependency
Thread-Index: AQHYB4eRmHGShFFynE+Myw0nlxV6+axiDqaAgAAkEACAAACagIAAAbCAgACPFjA=
Date:   Fri, 14 Jan 2022 17:11:39 +0000
Message-ID: <DM6PR21MB1323CED3DF2B9604E30FED25A5549@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com>
 <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
 <87czku4z2i.fsf@kernel.org>
 <CAMuHMdWEh07zXZZesuY0sksXaa6ptDvv3Fv4UC1RDkf7_KUv8w@mail.gmail.com>
 <2d6ab8ab-79c8-681b-a898-a88b48fceb55@redhat.com> <874k664sqz.fsf@kernel.org>
In-Reply-To: <874k664sqz.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8a41111-201e-4aae-abc8-b9050fe16487;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-14T17:10:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 009ee428-bb7c-497a-4ef6-08d9d780edcd
x-ms-traffictypediagnostic: CY4PR21MB2099:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB2099342A2ACDE9D9488C137DA5549@CY4PR21MB2099.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9nVkqtLocwoj+7het9TfWd7KwUtYesCl16cHz7xcxEIpNTgPzMims29sZrXTju04OcCAuV0RBSh611CmUr1YdC+l2dvGwHLuOk5ua239v5GCQTQg8o9M2hdZXc2tYZC11Vl/UVdeitzgtiRouBM2iyrSOTNJL1XFixtyrnojDyyZgh/6GIO8VZk+0jEKHPYb1SsBURV+St/vBSOBCBkHEYl88/mrJlYXFLgKwWpOOlsiao34Tl8QJfOZJBPbs0td7FaNlhzwEsBoAGITTPajTbukfCBU10m2iIqcaBTvqN1o+MjcFW+JDozeuyj5dlh6mNCO66lAjOgQ9rO1Yn8eLG9HHC09Bb3YzxRSoik6f1BKVGRSelTKoRZ/Xqwd4KHCJvG58opCQuKZ5rs0Qp5E5X/RY7bpdoVgIaM6OamO6kHgzPIlJy82ebrdNJiaft1kU8U8CS5CcxyANsR3u/Ux6OHFjU9Kv363XjIj6qnHu9KR3trH0bGFrlNQIuAyHq/NHNDYeex3loznC7i0PwdR3uaAXi3dqGHRaPc1RMxjt69TNPm4425zSTgpvwYH8oZSMxFTu/oRGjP/o+oMpNyqwlpf2U6aJFI8hA4sladaV6I9OXjQtANZ3Kr2hqfjeSG9uJLol6Ee25A1XqCY74xf7hNU6ey7DQd8i8LaVA05PEldvqF08mxXSqQhUtSDIodEsFCMqnVGbAMH4DGQsmmUI2BzLYayVY/cJvdqxS5Lb3KB1bRyDUt3tXFbzk0aJmu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(8936002)(66946007)(64756008)(38100700002)(2906002)(66476007)(66446008)(66556008)(33656002)(71200400001)(7416002)(55016003)(5660300002)(122000001)(38070700005)(86362001)(52536014)(9686003)(82950400001)(82960400001)(54906003)(186003)(53546011)(6506007)(7696005)(110136005)(8990500004)(76116006)(316002)(10290500003)(508600001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lk4WqjnURvoS2P0PZijA33K+X51UqUKTvtdwG1CjhVXRh1vs5XK54gzfIfMQ?=
 =?us-ascii?Q?Q3fU1VyyV1p058Z/IIhtlXzS2MDncFcOHZeNNft1P2tGVjrUxSRiIQ9SbnX5?=
 =?us-ascii?Q?EjYTuLqkpBJsZq9ycJx2TvJoWc5LOzut0otCNHvnyWqmMWrm2qMOGhR4LcBV?=
 =?us-ascii?Q?42OKkwzly46fP0vYFKKBPwzmCZ1rxARWEv9DzhexaKCd73qC4g5yPbsIXoQg?=
 =?us-ascii?Q?ByvkwU0Zm9oHUbyG3AA8J19cd+EaaF+yMe6M9pTKHDspqErGialnju/Zz0Vx?=
 =?us-ascii?Q?KtM1eMk7mVo0qfruxBHgtpKM8q+LZKNmilGCNaXeUEW+Fad7Gyy8HGwigCSf?=
 =?us-ascii?Q?TWPkqsWnZZ2/l80BpyNNKAtFiBlTOGW1DfN0sDxafme8mb2KpwmZ0q24Py+3?=
 =?us-ascii?Q?xMMGVj3rXFmRS0KvmzBdhf8ujSb1/AHXYQJVSLMXsX4QDDNenm0zoeFu28cR?=
 =?us-ascii?Q?TrhTEasATQhHySYY/nbhRZuamVQ6lYleJ8mivaF0oLzrisV66HFlfcBiJPmD?=
 =?us-ascii?Q?I6ok5cazBSzxgDU+CtxighO+puEGfWlNZ/G3m2Y4Jnnrp5LSwEbKGI2Q9o1d?=
 =?us-ascii?Q?Vnk4378n1vl5+Ao1RCFwnneFigyLnn9yuASE5A8+bgJjSMH4kedWXlwxeht6?=
 =?us-ascii?Q?pBW0KYMOYuRQNRqukmvHHFPq2ArMMHVv6N+HRyUx//xpVwLH4/5+qUGS6mFA?=
 =?us-ascii?Q?ieq25WdMjVSItEMExZkeB3i3yMAs/CTcvSqag+IjMI7uIMY9UGa7YIYeleTo?=
 =?us-ascii?Q?xWFfsQQf9lCA2lee2xHiFj7QDxvaeE5fzMkUu6BMiYYyn6EddS4JT4Pjiw34?=
 =?us-ascii?Q?XoTB9eRjG+o31fRaHGck+5EKtU9v8m0fmMvIyYgvpM0DysRJFqt3u5N1HTu5?=
 =?us-ascii?Q?Za+8RKSaKlGu+XZcVF1BOXzJeKkbHAhns87+dHP+X6Dgr8HYLNTDbZlU9Fj+?=
 =?us-ascii?Q?7/CCNBrjcXXstaVjxIbI2TogCID/vUye+d79XeIpdrlwyZueDZUTtdOk5bhg?=
 =?us-ascii?Q?GM5mWvniQxrjoewcYAliGxCyfymbt5zC63wHBk4mJ0wZ+BAy2E/SJmbTgbMc?=
 =?us-ascii?Q?kWcIOQVlkYaWvrCZehm2wreJNiUA0voJWRaa3A0VaAP8bvgqTYyZcEI0sPzB?=
 =?us-ascii?Q?xESOOBF9AFH7l7EFjSwy//uGPLLNRxUbHyacRgWv6nt/I+jpyxrPMRGt6X4K?=
 =?us-ascii?Q?+nff2J49g0Gzt4JFRZ531isSTmrUCfcFwkzBwuHu92LxlcW3iLkQG16tZ0kH?=
 =?us-ascii?Q?j/99VujHJsO9FQTfvzRdL5wl3UOSCbxWLhWJFqhasn9mv5whEpkQukWlp8Ij?=
 =?us-ascii?Q?m5i6YJt+z0711NV5ddsvr9Zvvf+SyKSOKa8dK/Lgujnnq3OdNjaN9+0Dk/Zm?=
 =?us-ascii?Q?EHUPGu4wNHMm/NBhMwwqrr3d4FmvnH4XZ1LXr6xys1fO6+Z3mUCI3W1D78uK?=
 =?us-ascii?Q?aSkG0CoxwMTnsoGKU8YJUNHJrDxG+5lZe6CPwXc3qLELKg4EwuxqGfi3zZt5?=
 =?us-ascii?Q?d4ZoGGgiix6nKPQW/qTSuijA8VtOsH8t52Ebp8RYZp0zOcfgzZHCpA/fTfjE?=
 =?us-ascii?Q?ts/6/mHjgobrd0jvzFMwFZDNos5xL/ETCwww0JCWeK933T6FcgLH/Zz/iCD2?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009ee428-bb7c-497a-4ef6-08d9d780edcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 17:11:39.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iXFudWgssmQgUO3N1vE9HTdCY74Eh6SbQpNhK8AK1D/d/p/JFVhxqje+0Bf0sw1oI0G2/AAl1UeHD8jG6dmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB2099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Felipe Balbi <balbi@kernel.org> writes:=20
>=20
> Hi,
>=20
> Hans de Goede <hdegoede@redhat.com> writes:
> > Hi,
> >
> > On 1/14/22 09:29, Geert Uytterhoeven wrote:
> >> Hi Felipe,
> >>
> >> On Fri, Jan 14, 2022 at 7:21 AM Felipe Balbi <balbi@kernel.org> wrote:
> >>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >>>> On Mon, Dec 6, 2021 at 4:03 PM Jarrett Schultz
> <jaschultzms@gmail.com> wrote:
> >>>>> Since the Surface XBL Driver does not depend on ACPI, the
> >>>>> platform/surface directory as a whole no longer depends on ACPI.
> >>>>> With respect to this, the ACPI dependency is moved into each
> >>>>> config that depends on ACPI individually.
> >>>>>
> >>>>> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> >>>>
> >>>> Thanks for your patch, which is now commit 272479928172edf0
> ("platform:
> >>>> surface: Propagate ACPI Dependency").
> >>>>
> >>>>> --- a/drivers/platform/surface/Kconfig
> >>>>> +++ b/drivers/platform/surface/Kconfig
> >>>>> @@ -5,7 +5,6 @@
> >>>>>
> >>>>>  menuconfig SURFACE_PLATFORMS
> >>>>>         bool "Microsoft Surface Platform-Specific Device Drivers"
> >>>>> -       depends on ACPI
> >>>>>         default y
> >>>>>         help
> >>>>>           Say Y here to get to see options for platform-specific
> >>>>> device drivers
> >>>>
> >>>> Without any dependency, all users configuring a kernel are now
> >>>> asked about this. Is there any other platform dependency that can
> >>>> be used instead?
> >>>
> >>> there's probably no symbol that would be true for x86 and arm64
> >>> while being false for everything else. Any ideas?
> >>
> >> depends on ARM64 || X86 || COMPILE_TEST?
> >
> > That sounds reasonable to me, I would be happy to take a patch for that=
.
>=20
> fair enough, let's see what Jarrett replies
>=20
> --
> Balbi

Sounds good to me, I'll include this in the next patch version. Thank you f=
or pointing this out.

-Jarrett
