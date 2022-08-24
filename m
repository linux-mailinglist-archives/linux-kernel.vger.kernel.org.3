Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C659F713
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiHXKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiHXKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:06:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040980346;
        Wed, 24 Aug 2022 03:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buTrbv9H7brZxCr7iWODJsF7j9jTkRsPIdW61qHjBI5MW33Rm1bNmcwZyGCVDjk6k2ZyURzMCcNyARmM1EnzA1s6oTDnxmNHjlmmKLo10TcQvPxHM6N8wraAVxp5/XeV2VeAZibriEqyhnhF+FRQyUcYPGO5AyrQr5NJMXq2KxIawg5DN27b8E4jgj0hRhrOWlcu5SspFTz/x2bmtJK8mu6oeYYlxmZsG2v9hizOwLE3FdXiW2sxytL9ekYZh8Iso1eB+MdZsmeNoDwYJZtw909Oerq5qyLg/ItyMohP8K4y3apSbLzvkfQIzhq6ThivlSiNfn/z/JLv12A83OtFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJMslKGvHXzbOLNK7N22XXGA5I8AIHMjmbtKCQ5eO1s=;
 b=YMQH6l7YoaCyZqYKqbgezU9QRflTUbUpm9TE+tjwUfMsx8L4ceIr1JYMput6WvK48pgnF+5yMGGLq1lmj6pJ4jJv3xrAlylaLY1ldzWnWvo2TAHPrcO6Nqj7faP98EVr0dtEhRw3Ig73uo87vqM3Q5h/+kR5JDXv2yBZI7hcRjdwmC+DLaPa6/imw9xCsRvLzRArkm0bJC4wmafHRs6lOEEisTD3Xrney9A7b37oWvKsjxzHRXdajF8EZt81/uxjgap67IabkmWU4W9fUAB9ISa4VSauww+lMAsjoMjZ1ictnrendfpw91SfMR4hN3o8kFVUYk7n3RTRgZyrfFQaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJMslKGvHXzbOLNK7N22XXGA5I8AIHMjmbtKCQ5eO1s=;
 b=POFtPhATlF4BHDdSdEOBiQGaKchUHC8lNv8HtCw9iMWX6HJ+l2/aRIcH/XfoCwsUvJ3izhu/Z1EyhwJYFUGXRTfpKWRZVKlMLqWLE8iIHhjbWFSKqkjCYZjIZVHb94SxgkjiAVcqqqO4OEhiUNjR0ZCXsqp/mKaU2LVhRiTc0IA=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM9PR04MB8651.eurprd04.prod.outlook.com (2603:10a6:20b:43e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 10:05:54 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 10:05:54 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Topic: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAmF+ACAAAMHAIAAZZiAgAEFDYCAADtTgIAAMAWAgAEz8ACAABu1AIAACm4AgAAHGQCAAAV54A==
Date:   Wed, 24 Aug 2022 10:05:54 +0000
Message-ID: <AM6PR04MB605317170101019C75BA9290E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824080338.humjny4fabhmx3z7@pengutronix.de>
 <AM6PR04MB6053D8E0A9AD24757095BFB5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824090622.ubbuf4doyul7d42r@pengutronix.de>
In-Reply-To: <20220824090622.ubbuf4doyul7d42r@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e2fe14-e2d9-4161-a8de-08da85b83b79
x-ms-traffictypediagnostic: AM9PR04MB8651:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMCE8qxzsDusCmJ9BS/o/6O4UgOromVHODKwwkbsQuxs2/HkFu4WGX1qh4Cbas4iQ+59wsmh9ATAEBzBN05fQ3PC47o8pkP9YKdMqrWeoUe51/p6c8ht4yOTWG0X+iyESiLy7WghYf08+Nji19f82vpILE0oTr+a70XeQS6MrHqGcZdL1hZxYzBsp/NdjNxZMHjpU/Z6Mfeh27qAAGppFLbQO/FEkFyxTYb83n6HtRd+GNZajoTZa7UHa1ab79y5tOXWnwqaVPSh14uSNWOB+YW1ftfBIWGQNqGwysNHzNlh4p16CR7UFkkrMXxXj+e3Duci7v1tTaU7ODT03+W9erAR3zebE/0JTJmiQlF8INHXeYiW2nLb4CpDYq8i1vSmMa7RHMJvXgOmiur1isa6+EAhPat24cS09MNJ7Z/5fOqdVSHTiAfRZZfYoJjTkFLM2mPr77waS4Xed0tLXvGZ1EzTGaHDIKpbaBsg4lJxde5NjI1lRMtqzLXDdM3ZAyyz/C6gMj1qBfzrt1A3Jzh+69z0Idf2QpSt9vRRvpcZNDJt6W2iBZJ6Gm33xBiwc8IXbsDdWpDtxu796waYwzR06aJAIThVgzwEBHv2JqoX0Mx9lXNDr8KoaMK9XmBcaydC0zzFbeSfgI0xlkGlaL7oscvp2EL5kl76RbpCdeWDpyTs5sRqchOiFspT1S6n6Kd8T+KAIQr33LNiGiMO7kyhpzovomO/6udD12IuBG+IZro80R18mEoOUnz8gBlVLiQ7G9fRoltmHlZwlVEcjckf6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(122000001)(38100700002)(33656002)(54906003)(7416002)(55016003)(4326008)(6506007)(7696005)(86362001)(53546011)(66556008)(66446008)(66946007)(66476007)(64756008)(41300700001)(9686003)(76116006)(8676002)(26005)(8936002)(316002)(5660300002)(52536014)(6916009)(38070700005)(83380400001)(2906002)(186003)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQVl288OPqDDz6+cB22zBWT1iXuUD2o64TUxK99bbjft8h/WM5u2Kd015I/y?=
 =?us-ascii?Q?uRb5m+dQwpORTyAcjwMWxEBgUnr3CRNHqzCVhvpRubJRGlyjHRrUAqLI2Xrv?=
 =?us-ascii?Q?DDI9Ta7E9wyQw6A2yzbTbpiufRStl3UD6rqgwX7hrmQar7woQKsELAvbnRGj?=
 =?us-ascii?Q?9gtleXzjX+BBT3n9wM4zhzlpfskZnzM3Ekc/+Tu6zpaCmBwiw8hB9NtkFHxT?=
 =?us-ascii?Q?RVBlDX6+dOgGQX7BMoMk7VISj+Dz2b/v6JKKTb5N8auIANbHKqb/pI+5IRO/?=
 =?us-ascii?Q?PSelR+5ojgba/CoFrYjiCAgRn5SbTEd29CUWCbUHIQCI4Y7URUGAr1Mk3JS2?=
 =?us-ascii?Q?w4my25J3TrWbzleddQYI0m3/2m8sSHikSkxuVfOO2pZCBUzg8ZQoDuMHCLAR?=
 =?us-ascii?Q?23pg6rVvxtLoXVhU4rrDEVTS1ycTpAdkNQvHwAZLVcUH1tfXmDWuMvI3pxkH?=
 =?us-ascii?Q?8/glBVFVOr6oSJ0de9ee4UWo9rSGP8Kp7KO/4KjFNQZGQxd2VJl9xpF9ZRpg?=
 =?us-ascii?Q?CfD1nlWv4InI4Aor0RQN7bC3xIhhBoRWhqWwKLK+aH6lWzahRpIjZeHPEh8U?=
 =?us-ascii?Q?N2Nim49cpp5kerquKxrSBn9BVxSGiz+7IuxPAj/JVu330Sxt7quyExErIwh4?=
 =?us-ascii?Q?2PQs7Etabgw/AaGFWgH8LT4wIQZqeQJoi8p44aN89tjwHBMjCrD0qlvOlNKc?=
 =?us-ascii?Q?zoV/Z5c2aHMAxYddpdVYcp3Y0rIwnkbu5H/gVilp+iuQN+G6hciV5CdNi3KL?=
 =?us-ascii?Q?sm4nT6pBSoyj36k5oLJ/ycXj0sWlsQOmRDFwGe7jXl2EXrlcD6/D27ttV+wc?=
 =?us-ascii?Q?rccqsGuIwtGag7uipMZFcX+F5weTNSCl4VqZNaWABwsJ5okLp+xPkxCI15J4?=
 =?us-ascii?Q?kxreOp5MiqG6SYD1U+zEd6SSyRdk/XdY8Pz4Vm0IKN7kVd9CnKMec0dsLHwh?=
 =?us-ascii?Q?0Ppi99ePqZTAkINzU0QTFiAOtIDQMD1U+KFUn8jgt/FkzWIDUtMpiwzJtqS4?=
 =?us-ascii?Q?UpLYp4WPmOckw7U7l5Ld1qwXy1x6yHkVMy1d1tVPIGLzc1UkD4RhsSdcVXLF?=
 =?us-ascii?Q?65qbjqaL6o8JSclwWrxuzhcz2jAMIQip2fibpxXsqXA9w3jWsAb/PPR1xn+3?=
 =?us-ascii?Q?L5J6Bp7imTdA/BrdWRyB8EqsF1pL5M7e2HRuv3xmy03DrdjJKY6qU8kgjAo+?=
 =?us-ascii?Q?1cW2vGMCPdVVA+GmItJW/9NKqoCBJ5CBPEAQUyxDVMllag6+Lo7J7UVjuuhC?=
 =?us-ascii?Q?pM+lVOvHYlxBqZoTfS1QmmM1MSPJhuR7CJBE9gjOBnlPRNZ8esh2Lc7RVuUq?=
 =?us-ascii?Q?cgQs1HYUsVZLDERJtyQRn3/G0Gw7J8jqS9+1NRl1quwsTc+o7FqWrqecSpeJ?=
 =?us-ascii?Q?VUZfYpV+Sy7+cUYkg0BDnOOuKkdx1bT3RGrgiiimGKPZK1VvFQ1/r8ixOrsM?=
 =?us-ascii?Q?PNvDULdojVBv8Xi7mnXaHo9zetPxDh9Dun81BmDYkZ3/prtH8eUjPgMpxkAX?=
 =?us-ascii?Q?1OE+ucLdcnMLeNJGJE2vqT6mDHNKffZ6jDtt2pOHFdWJZdkswn5BxMCQZ+Yc?=
 =?us-ascii?Q?u2nU5iGal9eWwpFIqYiAQ6u6ktdElwM3gsKjwujA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2fe14-e2d9-4161-a8de-08da85b83b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 10:05:54.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9LV5ZU0AcdqobuG8bnrzsYLUK0VJhIVdaTA9/Hc8J05DGYuXejazUYCbwP1qGEsqECSnZvv0PTjV8/k6hNPfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8651
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Wednesday, August 24, 2022 5:06 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier fo=
r
> unlock sequence
>=20
> Hi Alice,
>=20
> On 22-08-24, Alice Guo (OSS) wrote:
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Wednesday, August 24, 2022 4:04 PM
> > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > linux-watchdog@vger.kernel.org
> > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > barrier for unlock sequence
> > >
> > > Hi Alice,
> > >
> > > On 22-08-24, Alice Guo (OSS) wrote:
> > >
> > > ...
> > >
> > > > > > > Hi Guenter and Marco,
> > > > > > >
> > > > > > > 1. did you see any issues?
> > > > > > > This WDOG Timer first appeared in i.MX7ULP, no one report
> > > > > > > issues probably because few people use i.MX7ULP. This issue
> > > > > > > was found when we did a stress test on it. When we
> > > > > > > reconfigure the WDOG Timer, there is a certain probability
> > > > > > > that it reset. The reason for the error is that when
> > > > > > > WDOG_CS[CMD32EN] is 0, the unlock sequence is two 16-bit
> > > > > > > writes (0xC520, 0xD928) to the CNT register within 16 bus
> > > > > > > clocks, and improper unlock sequence causes the
> > > WDOG to reset.
> > > > > > > Adding mb() is to guarantee that two 16-bit writes are
> > > > > > > finished within 16
> > > > > bus clocks.
> > > > > >
> > > > > > After this explanation the whole imx7ulp_wdt_init() seems a
> > > > > > bit buggy because writel_relaxed() as well as writel() are
> > > > > > 32bit access
> > > functions.
> > > > > > So the very first thing to do is to enable the 32-bit mode.
> > > > > >
> > > > > Agreed. This is much better than having extra code to deal with
> > > > > both 16-bit and 32-bit access.
> > > > >
> > > > > > Also this is a explanation worth to be added to the commit
> > > > > > message
> > > > > > ;)
> > > > > >
> > > > >
> > > > > Definitely. Also, the use of mb(), if it should indeed be
> > > > > needed, would have to be explained in a code comment.
> > > > >
> > > > > Thanks,
> > > > > Guenter
> > > >
> > > > Hi Marco and Guenter,
> > > >
> > > > Thank you for your comments. I plan to enable support for 32-bit
> > > > unlock command write words in bootloader. In this way, there is no
> > > > need to distinguish whether the unlock command is a 32-bit command
> > > > or a 16-bit command in driver.
> > >
> > > Please don't move this into the bootloader, enabling it within the
> > > init seq. is just fine. If you move it into the bootloader then you
> > > can't ensure that the bit is set since there are plenty of bootloader=
s out
> there.
> > >
> > > As I said, just drop the "16bit" unlock sequence from the init
> > > function because the unlock is handled just fine in all the watchdog_=
ops.
> > >
> > > Regards,
> > >   Marco
> >
> > Hi Marco,
> >
> > Sorry, I did not tell you that all watchdog control bits, timeout
> > value, and window value cannot be set until the watchdog is unlocked.
>=20
> You don't have to according the RM:
> 8<----------------------------------------------------------------------
> 59.5.2 Disable Watchdog after Reset
>=20
> All of watchdog registers are unlocked by reset. Therefore, unlock sequen=
ce is
> unnecessary, but it needs to write all of watchdog registers to make the =
new
> configuration take effect. The code snippet below shows an example of
> disabling watchdog after reset.
> 8<----------------------------------------------------------------------
>=20
> also the RM tells us:
> 8<----------------------------------------------------------------------
> 59.4.3.1 Configuring the Watchdog Once
>=20
> The new configuration takes effect only after all registers except CNT ar=
e
> written after reset. Otherwise, the WDOG uses the reset values by default=
. If
> window mode is not used (CS[WIN] is 0), writing to WIN is not required to
> make the new configuration take effect.
> 8<----------------------------------------------------------------------
>=20
> > Support for 32-bit unlock command write words in enabled in
> > imx7ulp_wdt_init now.
>=20
> So.. after reading the IMX7ULP RM, which was not my intention, I found ou=
t
> that most of the WDOG_CS regiter bits are write-once bits. This means if =
you
> didn't set it within the bootloader you still in case "59.4.3.1".
>=20
> So the imx7ulp_wdt_init() function just needs to check if the
> WDOG_CS_UPDATE bit was set. If it is not the case, then you need to write=
 the
> WDOG_CS register as currently done. If the bit is set, than you need know=
 that
> the bootloader did the job for you and you can exit
> imx7ulp_wdt_init() early. In both cases the unlock is not required.
>=20
> Can you please check/test if this is working for you?
>=20
> Regards,
>   Marco
>=20

Hi Marco,

Rom code has already configured the WDOG once, so we cannot use " Configuri=
ng the Watchdog Once".

Best Regards,
Alice Guo
