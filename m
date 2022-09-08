Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321E75B1DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiIHNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiIHNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:01:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2110.outbound.protection.outlook.com [40.107.114.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2DB99CF;
        Thu,  8 Sep 2022 06:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trclaks5eqXhPDyJgZ1YhJ2K8TVAlDMiqkx04aL+TaNut0hFhub9YKe+22Wooyoq9PVoGt1LkNv3oiRj5Hd5Qv83wTG0+WA9nc+8qwY+YbpAbFTyDNtwTJSWPfLZD4cHY+5kFKJTfndCIbPPtDqGThWl96FQl7pSc8qmHC22I9KPtOKDrmLI4QiBTV0dWbWqRnLWw1nTi+s38xS0E8e1tynwWsks4jTXUWjYqv2r0uaX0WNFOOHE8SAFDZEXa1Tn28HHEhT6d5IBlg13vY3x90WdzfkNVvRXTy/Qfe8nPQ7frc8K0JFYyz55alFOl/shZOJCTIG1S6U1yiqWOri4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG5xwTw24HRMQsZ8Wlj+X+1rEHTEHt1lAJLkGTbpStE=;
 b=dNURqx6eSdhr8zTzgizGuB2qxMJSderkjZzX25r1DYf86PetAHpDL/AUsu4vugjEV6SmriPT6VOb79IfakX/VgY4eeUWIuiKHHQRV9aS3bxbNc8ODaf2+vGw07DprqmvtpAUregqyAYXInyoZbdfYaWX/OKsufnqFTzRwNc6E0xBWNK8rm8+BTlncPlrnG4ww0OOVwBzONuQQyNl2jxD7cXPNcMKXJwUbjFaAhO1BE3+FbeJAOJWfAOWtgBDV4uac1vI5HKOFvxHZQULlZnzg8z5o4DA0St02q+DnHeE1+sXsl+cIgFPj9o7bsjbO4M9x62bN4/tNlYgm/0M4EtVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG5xwTw24HRMQsZ8Wlj+X+1rEHTEHt1lAJLkGTbpStE=;
 b=ivtPkFa6tKscX4Zj7sKCtdgbMYKfpA7Ozi6u24sIjkkQc4RKrmcPSRlg5tgkOCJNu/dFXxL+JXWp1ysIAr0KOlnlbOvatu0pzXhJQutBWG7DY5+P2JGGLl+6TucZeos2vtWrzS+vTv9w2QFJS/1NuKK0bUQ952BWr8D3OBHeF7A=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8396.jpnprd01.prod.outlook.com (2603:1096:400:177::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 13:01:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 13:01:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "guoheyi@linux.alibaba.com" <guoheyi@linux.alibaba.com>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
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
Thread-Index: AQHYwdqJJqv+SV7oQUWARHgAT75zHa3SNg6AgAJOjgCAAB1VgIAAlHqggABG7gCAAACJQA==
Date:   Thu, 8 Sep 2022 13:01:08 +0000
Message-ID: <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
 <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com>
In-Reply-To: <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8396:EE_
x-ms-office365-filtering-correlation-id: 0519b484-aa3b-4ff7-3899-08da919a3258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFCpIw5IcfDto1SK2G1CfzusiAwBWLhEzXUdi5C6Lczs0z33hrD9HwRvL6+WCKXjOcE5ExIhFn7doZ1U/uEeqX8ofBSaXqMJuK6YrTu8hsucfdZfgHUzb0/Kov8rI2G4cv9h2TQrGNv1S/+X9BZj8jYg9fsoUuUw7gzx6DNr5jnkEGiMDVT/kXjbd/JIRUHAJIz00kOt5RdP/I5B51P40rL8e7cLU3MjXTEpRfR6cc8g96x6PW++YvtYDy+YOCEmzuJ37UCEXX+efVekiMHR+jzfvDD2YJSmo+C3+Sd7yKW95L5fT+vcXdXcaPyeV7UDWsxpoqQWExEtJ8mhYuptC8h1d20Fsd7bGhk9zYCimUPJypwxQjVKd2CZSxQN1lkp6GnUy0Qk9eDfKq1VjVS9RKwTm1wr3C33945ni2UC8ftjXrK7Z9KMrl4QzhiiZKE04ccJwp6St12sSD6+3myHSQRW/SwJnds1/Q7441jefw9Sw8oUNH8v7AXt762ZVb22CxCmcAcsFUFGSF4ivKr8n49C5KUSoc1XPnfexGvVDNF30i5claxDk1ZD4P6Qab5n9Ndw0ysXXJDEE5prlsKr8SMibAVmJL4kSD5mIFs8nD8ZOgEffLdvubacWVVBFhfIxBYJLDAUpHJiVmIQf2ly3Cg8+IeaSzVZMu9UyRFSh5Lcu4CCJGbgaJdsiD3vS6hidS9WRS9jus4gUlHFQWVCHH/bZ+Cn04fyavLWUyPnjkqQia7cITSHKLf+wf5Fl+xjj8GjVryzk6atpjtDDT1GSt218n2Idhy4Y5LWEEQo8RE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(41300700001)(5660300002)(8936002)(33656002)(26005)(9686003)(2906002)(53546011)(52536014)(7416002)(7696005)(38100700002)(86362001)(55016003)(6506007)(122000001)(38070700005)(66946007)(64756008)(186003)(83380400001)(966005)(8676002)(71200400001)(66446008)(54906003)(110136005)(66556008)(76116006)(478600001)(66476007)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DA3Xnx07nW6SgXATDD+20W2ZUt+wZ0/Yn/1tGT87Pfjlx1BiclwtY+1431kz?=
 =?us-ascii?Q?cG4slI+y9FZtky4XZhflx+xlTpVRwBfrijk57c4mKuYnjHwts5CZaJQ8zyq8?=
 =?us-ascii?Q?vSB45HEz8JVSTgqx6KVI5x2P5ec3NbEGq+EwcjuMNGEAP+oUC+Qvtw/zDZbq?=
 =?us-ascii?Q?Zv7ux5wuycMHe6w9ITV+qKqvqm7qZbJqcU+OMn00+03H7TtBc0e4Z4be+PPN?=
 =?us-ascii?Q?0xBxMV0+d9Wu03AtIsc/ZkJm5+izll8W3clFNdTlgB2V9T3bImmzbSMYpnD5?=
 =?us-ascii?Q?Iwi5VRpgZ+WmzbzGZSL/ihl9Hzcvhv/NCaObxemqcdXZAQQEqmyX1ZqhSkUb?=
 =?us-ascii?Q?QNdNqOosRFaXydThqyzSsf+SyN5T9omlt50+iuL54iMpKWG8CJMBQudw64KM?=
 =?us-ascii?Q?spvzVxHPq76eWSMHqF+Sh48mxIvMYa36fP4xiqABIQ16s/uqKZzmzKobCICu?=
 =?us-ascii?Q?D4UdUVFg9t5O/w8f04MQwFoTIJ1/G/J1HxwA4ULCFp7HRVJHJdPwfQo8Jewz?=
 =?us-ascii?Q?aOl6OpRT+FfkEnHC9R5qcsVwzcT6vL1pj6f3VDX1Lur9uh3j4IU0qfz9/3XJ?=
 =?us-ascii?Q?gE1CPmDkYG03DQciBXCFq7aAhlIE7FyC2aQgJJ/0EPH0GsZ6NYwUVDCAAxKh?=
 =?us-ascii?Q?0AYiXiwYGWPZGvEsCswNYUL4iwC/5/VKFl1g3b4HsF5Kf/E3ZNIyZkjTsBG2?=
 =?us-ascii?Q?6KpKBKGdckv+WhpMYWtTBgbwr5gx7RlYo+Yx/Ry2k4fzj/Gr9QAO818wvbj/?=
 =?us-ascii?Q?K3wiWUoxkUZfmyntDKQ6v69FCfOJ/jO33hnby314xq1YpOKgTwdgGOObezVV?=
 =?us-ascii?Q?YZcAzvvFYKPDeszB7VDCdnH8xIXRSsUkSE6n2skjmT9xc5kG5EC/EG6qclFT?=
 =?us-ascii?Q?+ft97BTGgLztdwR3WdnDCK7pLOpbL5w5uzRbbVOfdhV3yC2/689YQpnqRvz5?=
 =?us-ascii?Q?5EC1qTykRKa55ejKQ9N5gDhEqo6pTUZIvmLTzFEfO1QIiqeO4p+FTCwJfahN?=
 =?us-ascii?Q?VWsIP7/mU1RH/9RVYdLxFNJPA5Y3aDGol29g7kDkgE0PbV05a/2r7qIMFarV?=
 =?us-ascii?Q?6Xy8W080DCpT7jRsN5KR91VuKr7bmCEVXoNk2zyFCxx/wlqBmSjKWEH3OCAK?=
 =?us-ascii?Q?VlPz9S7XCsotbZWw5aFUVRfswJ03KnxPvHVzPQzYtU6a3x93CSJ8qUqGs2/3?=
 =?us-ascii?Q?/QyD+MZ7yBEeqkncXdTHLjXAlNtJolyXHglDVtRxNOn6E/klr1U4jYTv/Na+?=
 =?us-ascii?Q?yabEwfLenVtjjV2oiV+AFilvVr++7xFBp++agrHmdVi6SGKhFV3RMLBPYjQT?=
 =?us-ascii?Q?5lkO+In02K+hw5A2hjqzzJ7dMuscZ96kapygVeP60y7abCkHpQoSiguozcWp?=
 =?us-ascii?Q?crcihVkqNrxNBHny9Y1W/nULZ9GF/JY3QYroKzl743eZuLvkVY8qaB5Xc1pP?=
 =?us-ascii?Q?Q9HvrGZsCdZJZOAnuOFAuApdlpWJzaUnrr9HzZ9n6ys9BZtZqMJorhqg82bM?=
 =?us-ascii?Q?OKBKsMjlUIKev4Od16230yhG/vNEBZJL2B0rkO2KHK9JzNhw2S5W0TUY7iZ8?=
 =?us-ascii?Q?K+/HSQhRrZkST7zhFHBCIGV9qNt5QRmvdIS0xCYRbOnWO7KG+YxgXJSl+fZP?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0519b484-aa3b-4ff7-3899-08da919a3258
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:01:08.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2R58zOmp5y9BE46XNse8ZJ0Jqcq/O7LH9dBVANw67BgirW0vYCxG90zPijCUmq/lKxZDLipwGED8Zjn/mXuok+ClAm2XBIcFaoiYV7KmtxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8396
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for the feedback.

> Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> configure the PMA regions
>=20
> On 08/09/2022 09:39, Biju Das wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > Hi Conor, Atish,
> >
> > What RISC-V devices you have?
>=20
> A bunch ;)
>=20
> A __couple__ PolarFire SoC boards, HiFive Unleashed, D1 Nezha, Canaan
> k210 MAIX something & the VisionFive.

If standard DMA api works without any issue means, on these platforms
IO Coherence port is enabled in the hardware. So all peripherals
involving DMA work as expected.

> > Ours is RISC-V uniprocessor without IO Coherence Port.
>=20
> What does "IO Coherence Port" mean? Zicbo*?

The HW will provide coherency between CPU and peripheral.

If Zibco* is uniprocessor, then highly it may not have IO coherence
Port enabled in their design.

Guo, Please confirm.

>=20
> > Currently USB, ethernet, SDHI/eMMC doesn't work with standard DMA
> > api's.
>=20
> Sounds pretty similar to the D1 so.
>=20
> > On RISC-V world, how do we handle DMA api for uniprocessor without IO
> > Coherence Port?
>=20
> If you do mean Zicbo* you're into errata territory there & I don't know
> if that'll be acceptable upstream - not for me to make that call...

It is not errata for sure. It is a HW design where we don't have
IO cache coherency port enabled in the HW. So looks like it is not
an extension or errata but it is core stuff.

Something similar to incoherency mentioned in below [1] for uniprocessor
Systems.
[1] https://elinux.org/images/8/80/Initializing-riscv.pdf

Cheers,
Biju

> >
> >
> >
> >> -----Original Message-----
> >> From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> >> Sent: 08 September 2022 00:38
> >> To: atishp@atishpatra.org
> >> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> >> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> >> atishp@rivosinc.com; apatel@ventanamicro.com;
> >> geert+renesas@glider.be; linux-riscv@lists.infradead.org;
> >> linux-renesas-soc@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; prabhakar.csengg@gmail.com; Biju Das
> >> <biju.das.jz@bp.renesas.com>
> >> Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> >> configure the PMA regions
> >>
> >> On 07/09/2022 22:52, Atish Patra wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >>> know the content is safe
> >>>
> >>>
> >>> On Tue, Sep 6, 2022 at 3:40 AM <Conor.Dooley@microchip.com
> >>> <mailto:Conor.Dooley@microchip.com>> wrote:
> >>>
> >>> On 06/09/2022 11:21, Lad Prabhakar wrote:
> >>>
> >>>> diff --git a/arch/riscv/include/asm/sbi.h
> >>>> b/arch/riscv/include/asm/sbi.h index 2a0ef738695e..10a7c855d125
> >>>> 100644 --- a/arch/riscv/include/asm/sbi.h +++
> >>>> b/arch/riscv/include/asm/sbi.h @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >>>>
> >>>> /* Vendor extensions must lie within this range */
> >>>> SBI_EXT_VENDOR_START =3D 0x09000000, +       SBI_EXT_ANDES =3D
> >>>> 0x0900031E, SBI_EXT_VENDOR_END =3D 0x09FFFFFF, };
> >>>
> >>> Everything else aside, I am very interested in what's happening here.
> >>> I'll take a proper look through things later, but for now:
> >>>
> >>> For PolarFire SoC we have an InterHart Communication SBI EXT that
> >>> would would like to upstream support for. We are not aiming to put
> >>> the driver itself in arch/riscv - it's just a mailbox driver, but I
> >>> would like to use sbi.h for defining the vendor id etc.
> >>>
> >>> I am not sure how this all aligns with:
> >>>> We'll only accept patches for new modules or extensions if the
> >>>> specifications for those modules or extensions are listed as being
> >>>> "Frozen" or "Ratified" by the RISC-V Foundation. (Developers may,
> >>>> of course, maintain their own Linux kernel trees that contain code
> >>>> for any draft extensions that they wish.)
> >>>>
> >>>> Additionally, the RISC-V specification allows implementors to
> >>>> create their own custom extensions. These custom extensions aren't
> >>>> required to go through any review or ratification process by the
> >>>> RISC-V Foundation. To avoid the maintenance complexity and
> >>>> potential performance impact of adding kernel code for
> >>>> implementor-specific RISC-V extensions, we'll only to accept
> >>>> patches for extensions that have been officially frozen or ratified
> by the RISC-V Foundation.
> >>>> (Implementors, may, of course, maintain their own Linux kernel
> >>>> trees containing code for any custom extensions that they wish.)
> >>>
> >>> Which is in:
> >>>
> >>> It is unclear to me whether that is just for ISA extensions or if
> >>> that covers SBI extensions too. At least for us, since we don't
> >>> touch arch code there is relatively little friction & there's no
> >>> concerns about reducing the portability of a kernel since it is just
> >>> a regular old driver.
> >>>
> >>>
> >>> It covers the standard SBI extensions as well. However, I don't
> >>> think this includes a vendor extension as there is no freeze or
> >>> ratification associated with vendor extensions.
> >>>
> >>> It would be good to discuss the policy around vendor SBI extensions
> >>> during LPC as well. We also need to discuss the ACPI policy as well.
> >>> We most likely need a BoF to discuss these adhoc topics. I will
> >>> check if we can schedule a BoF in advance.
> >>
> >> I did briefly mention this to Palmer on IRC last night, just was busy
> >> today & didn't get a chance to reply here. The indication there was
> >> that yes, this paragraph did cover SBI extensions - which would make
> >> vendor extensions not permitted upstream.
> >>
> >> We (microchip) are "only" doing a few ecalls in a driver but this
> >> seems a fair bit more intrusive since it is in arch code. Even if the
> >> answer is a "no" - a no from the horses mouth rather than on IRC &
> >> maybe some rewording of that doc to be clearer would be nice.
> >>
> >> I'd be down for a BoF, even if just to get a "no" in person haha
> >>
> >> Conor.
> >>
> >>>
> >>> I was planning on cornering some people *cough* Palmer *cough* at
> >>> LPC and asking him what his thoughts were there.
> >>>
> >>> FWIW this is what we have been doing:
> >>>
> >>>   The IP itself has not stabilised yet, so we have not sent any
> >>> patches yet, but we do intend doing so...
> >>>
> >>> But yea, I'll take a properly look at what you're doing here soonTM,
> >>> although at this point it may be the other side of LPC.
> >>>
> >>> btw, where can I get my hands on your hardware?
> >>>
> >>> Thanks, Conor.
> >

