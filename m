Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34A4E67DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352296AbiCXRfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352293AbiCXRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:35:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E47EB3F;
        Thu, 24 Mar 2022 10:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwUDAse4/y2/odzBrGFTesT3hmT1tN15QLs6SmRLhD4r2EfAWY0mzLFttwAJ6BQmbmc+yOiHSeQ7toTlm9kESct+C0BXtJDaTUAGusbU57u9OCmLz2iTVS1Ch6SanJ6baBU/8UejqjV15uhK/P8AleE3GdYSTTYDnbrp4PPypOvRK3ir6BIFVXs9kChYNFX5n4zgbK/NB9xikl8IEYLxdJ7+F+RtMZpcPWCvirE9RtDX816AEb6VJoJ1jbr6O0CWx8PZ+YYspUonnMRvO4ns43rYhp6/Nd6LtJuRfRLtxPgqC6ogAL9zo2YAlW4ZFdR1vUyC2ZXleUntyr92VbM/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7sC7dwTnn2BRPQVMa34DYOsPPnHRTcp3SrVTfIhChM=;
 b=EMXrsGGMdgN2feEY/pc7q9CMHYF8f+6wQpyJ93l8ycCUQ//k8B4feZZnrLzPJoQYSrbqF/oKMXJ5/Q4Uj3I2ooiL3GiXxMmw8ZWJx+GpA4AbScRc9bp6iNZ1BkK3hzByFjqoGw2UtXTnE8x6lM0uQ3gD8lHPf+6TsjpZ8yIutWQI65lzCJmhWdE4lX8QllTscs5qnPZLnciWQR56mFdh7G2+jFXoNujaDuhcyFJu5L7sqsdq8WmPOhKYvqHagpV3u8JBEiS95KEVDbHPadWuEGlIfBfv95Sp7HQ8vR20XK+pGUKI3fcRA/MEkpbG97SSs9HGqijER1s5PCfzmyA4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7sC7dwTnn2BRPQVMa34DYOsPPnHRTcp3SrVTfIhChM=;
 b=eKLPR6NCDsfxghPF/1OxjGRqHvBGe5z53XGypzBUSKbuCFMvEb64qJvUIK2hvMzjPm/slkiXcUEX9ZzqLZv9Y0+KOUnkvrSdieeSXol4qX1kzjyHymW+9IudQVF19nZNUokYJCclt0mJl1Bo33r/XjdIcIK9ySbGXRbIMRthbBI=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 24 Mar
 2022 17:34:06 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e%3]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 17:34:06 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Topic: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAICdm7aAgAADHQCAAANtgA==
Date:   Thu, 24 Mar 2022 17:34:06 +0000
Message-ID: <20220324173405.nusk6247ouvek46y@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org> <20220324171041.t5yoocinj6gizcc7@skbuf>
 <87lewz5kr5.wl-maz@kernel.org>
In-Reply-To: <87lewz5kr5.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 535b111d-954f-45b5-9cae-08da0dbc7f3b
x-ms-traffictypediagnostic: AM0PR04MB7140:EE_
x-microsoft-antispam-prvs: <AM0PR04MB714084FE17F5C7835DCD9910E0199@AM0PR04MB7140.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hQoTxy7r/tLwgQjYRw+oIOtPg9KPbf/Ax53c/tBPopGjT3HELH3t2w+F+SMM4z+bxEaslHLDjV3w/ToF3mgLJ7z04wtcF/JC31OlXKuIutXwtSD1CUSjZi5ZrPcd4GCqSaaoQzDGVNLALdIRVQ7A77ncp0vqr0olmIVjxJVLrIkzAjML5+qjxv+ecMnHwMK56NgW5AJrId6xaygFE/ubnsmuIRht88AsgUhVxBuGtavd98cInG0h6EDQKEw4sC6fRcbbHxCKokRz0nmuDmQnnPLYMArc6htzNx6dM3kJqebJRv83DUpIkJmVMkwtkIyjq85xstqMhLwkXaeTxit0kCdghMj/kXz6QJnBoqIOSgZMgMByMvD1uC/U5dG/i8HMLE2o7KpUj2Z6KYKMlAg7NnqvMx3vj7W4GVVSLXjoo3GE6do5H1IZHhq4I0ZLu+JK1Y4/ogQ2C8q9m4FYb8QoIyrMzdE/n07Jt9wL6ahtHIuE+xcvg5cO9ZioWjNAPWaGUliHc3ycKD/rrv/Unc9GrfkRbw51y8Ub+9lHJOvCZoX5eIEoIsp3CK+480GKK4CjXYoOYdciaAUhtXcEIPoO6j+Pcf9wXzmBoM2s8wr2Z46t8ZASEUEmdeJGzks94YB3c2+5uZUihxFry4wtoDBdZVuy39EtzMjiZ3xmqr5WGH+OPfWWjpPOGrQwKNmnB2LV68pgS3noYsPzer54TuQI4p7ofD4ubPnKnHUzSg+92eBhBxAMp/zL9O+QbQ2djtDzJL74cM7jJQ9o+H2PppbMLCd+bVDiWpD9y9Wp7UdPAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(44832011)(5660300002)(54906003)(6916009)(33716001)(122000001)(8936002)(2906002)(38100700002)(83380400001)(38070700005)(26005)(186003)(1076003)(86362001)(71200400001)(966005)(6486002)(6512007)(316002)(6506007)(66946007)(76116006)(9686003)(508600001)(66446008)(64756008)(66476007)(8676002)(4326008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ErhAYid6TZFd9ypg++d7IBllx2Vu9sf60iLUMyPWNpwXsPTYDI0X8lsMb1f?=
 =?us-ascii?Q?rEA0jq358b6bXGou3CZs5ImuitmqHczqV6jnbtXAn9nKGcTJHVX/2hXCVr1T?=
 =?us-ascii?Q?FzNZl1Et7DWabDxCY8tvwXZB4iU8nCO/Yjw+2VV8GOXNZyBVqoBKeFTycFqB?=
 =?us-ascii?Q?A41WLmxBcLo/tc0mbQG4s4PGu8FZzrKSjnAwIraAIun3ZoIgHCLMQehwrTVI?=
 =?us-ascii?Q?W6pEuxEiDJ1gvPHYwqCd3MzO15E7PUcDjiZBTf+YcKKApYsYs7kIYcldQGjc?=
 =?us-ascii?Q?HDLEg42RFlJtMx+EeOUPYUw/dZABHAUN154iph0HeLaL2b2YrSvAbSYnYTQf?=
 =?us-ascii?Q?uoaRprFkcB0o7zLefeT7JHViRqheCVXO0bN4wWJawxmOsQdCCqzi5OBaU/mC?=
 =?us-ascii?Q?BFULUKvgXPYlK8pfz7f3f+cc2Dw/lKW8+t9rtbuVQ0LPc4uEJ2iii36+UnaQ?=
 =?us-ascii?Q?CTxsw9DIapCd9AOyAwDdnLstQuCPK9hp+nMNEUx0K4XMuqWuazZ6BETooAg9?=
 =?us-ascii?Q?LQQ5vygVPOgrC7ESjQXh3T6JAaPmZ0DDEqdpdTkItG77JOfLmvee/AFgcCrp?=
 =?us-ascii?Q?KnNqfKflT5qNRMs7fajI6LzTQ5DRbQqhatcVTmXCdckSBusxSQI7dpPZZ+Bz?=
 =?us-ascii?Q?wYzKa05iYgwLfq+r6+Li/FKRNJepCtjjBwI86Maul/y8hZxd5x2zZJgPmlpT?=
 =?us-ascii?Q?xPDRS/00xz8s/I6L0vJPMe6l1YEyY2xi3HxkR4uuOYwGns2ArQHitS6l+bmf?=
 =?us-ascii?Q?CSQymxw1UR7xHQ+ZjgDrev3HbfXTj+HUWzpc7kB67DN8ylxVID72gh6TBq4R?=
 =?us-ascii?Q?ptCBlR/4GN6hY8LVFVPOHR/FOt1hUgQ/kyetLnM+QtXhrI9qb6VARanFhu6n?=
 =?us-ascii?Q?3R6xFZgUOvu9eQ0ZuhBwqvkaTOQdZAaVOonxz3k7BChlhxrNag+cXZD+xW5A?=
 =?us-ascii?Q?Xq9ONvgu3p7NJ0LimldGG3lBMa2jxxFHcU/FKv3I0mn6J2gki6EV8ZkWDb2A?=
 =?us-ascii?Q?vTIgvrPfLjEz2YSSRtkPnQcy6p6KVsXwTsF2fdT5nrx/0BSSzikNfrM5vn0r?=
 =?us-ascii?Q?nzHKoLicJkXbi04Q/pTNqPAq3F5Oxkup9Q+UEyIFRU79tJg4u1ZGxXfIKyRu?=
 =?us-ascii?Q?931Cs1oOwg/F4+nIhKszL7ARujMFoKsyfqVQRt1qIEXxHD/YeSIq7AehGP5I?=
 =?us-ascii?Q?NmlrHURN2HnMIdaMDpB+uVocIbWXdJ8sFTn5rjrK55libCq+kwfnCgYWdRww?=
 =?us-ascii?Q?4Wl5pO0sO/TFtkf+F5FHregTJg3kxMtJL5jPeOtGTeS8NzafZ7D+z8fD1Lh2?=
 =?us-ascii?Q?iCWRbPGq/pMulbNXuFcVD2mO2ti7D/DfTj9TgpgOpoY5w3Bjz9wZQGsu686I?=
 =?us-ascii?Q?I0HB0Nx5nzB03fXPdCguHfs393cHCEmDMZwsBMSrAylPFXhugKfCsj/0GxqG?=
 =?us-ascii?Q?rAMJVdf3+XMj3qAUsD2yA/ACMEVG3fEZOgP0qxqq0zdtFYm7h1l5+k6y53ST?=
 =?us-ascii?Q?AWVH1yS3QOSkTDa09TNM2UZodr8qIP2H8cOQlSOaSHO9V1951fzWa43SWqR+?=
 =?us-ascii?Q?RqhV7GPsXUfw7dkwTiIKlkXMZe97CV+yWebF85c9tH2Otbyra0IApxtbFdpj?=
 =?us-ascii?Q?/FfJt7KJLHPNXxmFeKLa9fko6cAAX1PBLwMphTwX0FDJuyqhBOsVjO6pJyNy?=
 =?us-ascii?Q?N4dq2WY4NfLgb82kMB9/OUxTNmI3ea0XzIwK4ttah1yCMlsz860DAVjqYsbA?=
 =?us-ascii?Q?xmxuL9uOSH6wmfInsWtzZ5K/DvUoUl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C72A2E8862BB9244922AD30026681452@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b111d-954f-45b5-9cae-08da0dbc7f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 17:34:06.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pNmh7uYvYUY7s6AKPu1IoYx1xzZ0+4qK4/h+5mfbb1zqvIrO1ua2DoWLqTQ4Yx3+0Epc+pkMb82hQ4QBZ4sSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:21:50PM +0000, Marc Zyngier wrote:
> On Thu, 24 Mar 2022 17:10:42 +0000,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > Hello Marc,
> >=20
> > On Tue, Dec 14, 2021 at 10:20:36AM +0000, Marc Zyngier wrote:
> > > On Tue, 14 Dec 2021 09:58:54 +0000,
> > > Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > >=20
> > > > Hi Marc (with a c),
> > > >=20
> > > > I wish the firmware for these SoCs was smart enough to be compatibl=
e
> > > > with the bindings that are in the kernel and provide a blob that th=
e
> > > > kernel could actually use. Some work has been started there and thi=
s is
> > > > work in progress. True, I don't know what other OF-based firmware s=
ome
> > > > other customers may use, but I trust it isn't a lot more advanced t=
han
> > > > what U-Boot currently has :)
> > > >=20
> > > > Also, the machines may have been in the wild for years, but the
> > > > ls-extirq driver was added in November 2019. So not with the
> > > > introduction of the SoC device trees themselves. That isn't so long=
 ago.
> > > >=20
> > > > As for compatibility between old kernel and new DT: I guess you'll =
hear
> > > > various opinions on this one.
> > > > https://www.spinics.net/lists/linux-mips/msg07778.html
> > > >=20
> > > > | > Are we okay with the new device tree blobs breaking the old ker=
nel?
> > > > |
> > > > | From my point of view, newer device trees are not required to wor=
k on
> > > > | older kernel, this would impose an unreasonable limitation and th=
e use
> > > > | case is very limited.
> > >=20
> > > My views are on the opposite side. DT is an ABI, full stop. If you
> > > change something, you *must* guarantee forward *and* backward
> > > compatibility. That's because:
> > >=20
> > > - you don't control how updatable the firmware is
> > >=20
> > > - people may need to revert to other versions of the kernel because
> > >   the new one is broken
> > >=20
> > > - there are plenty of DT users beyond Linux, and we are not creating
> > >   bindings for Linux only.
> > >=20
> > > You may disagree with this, but for the subsystems I maintain, this i=
s
> > > the rule I intent to stick to.
> > >=20
> > > 	M.
> > >=20
> > > --=20
> > > Without deviation from the norm, progress is not possible.
> >=20
> > I was just debugging an interesting issue with an old kernel not workin=
g
> > with a new DT blob, and after figuring out what the problem was (is),
> > I remembered this message and I'm curious what you have to say about it=
.
> >=20
> > I have this DT layout:
> >=20
> > 	ethernet-phy@1 {
> > 		reg =3D <0x1>;
> > 		interrupts-extended =3D <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
> > 	};
> >=20
> > 	extirq: interrupt-controller@1ac {
> > 		compatible =3D "fsl,ls1021a-extirq";
> > 		<bla bla>
> > 	};
> >=20
> > I booted the new DT blob (which has "interrupts-extended") on a kernel
> > where the ls-extirq driver did not exist. This had the result of
> > of_mdiobus_phy_device_register() -> of_irq_get() returning -EPROBE_DEFE=
R
> > forever and ever. So the PHY driver in turn never probed, and Ethernet
> > was broken. So I had to delete the interrupts OF property to let the PH=
Y
> > at least work in poll mode.
> >=20
> > What went wrong here in your opinion?
>=20
> I'm not sure what you expect me to say here. You have a device that
> references an interrupt. The DT seems sound (I don't get why you think
> "interrupt-extended" is a problem here, but hey...).
>=20
> If your kernel doesn't have a driver for the interrupt controller
> referenced here, what do you expect, other than things not working?
>=20
> 	M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.

I was just raising this as what I thought would be a simple and
non-controversial counter example to your remark "If you change something,
you *must* guarantee forward *and* backward compatibility."

Practically speaking, what has happened is that the board DT appeared in
kernel N, the ls-extirq driver in kernel N+1, and the DT was updated to
enable PHY interrupts in kernel N+2. That DT update practically broke
kernel N from running correctly on DTs taken from kernel N+2 onwards.
This is the observable behavior, we can find as many justifications for
it as we wish.

(as to what I expect, Ethernet PHYs work without an interrupt too, but
 of_mdiobus_phy_device_register() treats -EPROBE_DEFER from of_irq_get()
 as special, because it assumes the IRQ domain will eventually come up.
 The IRQ is optional, as evidenced by the fact that kernel N worked)=
