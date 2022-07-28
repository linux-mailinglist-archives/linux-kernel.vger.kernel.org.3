Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80062583FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiG1NbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiG1NbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:31:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130080.outbound.protection.outlook.com [40.107.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D314095
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3dCu75srDs22fMVpYtwZ6EFJ8f+vuszHDU738pR4EK6Mhpm8wrgoP0COFmmAfCyn2caxR6c196G5pDUF9o8dxsH6BFUymKFxeCX123rAAeBmdoPhXlzYXsjP/lsciHvwX3eCvYsK4XU9kIIoOavfTcZkfp0g1jV8Kwrc+vUX/KyH7Y6AHCfu4dJW3k0cZGgvpN9nPhW1aXJxFx+3CmyxdrMdmqbR3sAFavIgaBk2jOAinXGkCi18NumkH5ikaJrTSXW7NrpS4DyfSsiRBwJuaY0I8ebHKol4JLQr+exgn1hPbmjV9F6Tel4L7xFhePD+BMwDYOf4CSmSar4l6y6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3sPhtD1O5TnghZb0Mltrt+b2YzYlasKThKi8gW4Ryk=;
 b=Qlf5/pWu1LTrREpAtAaDBu9xMDa3w4z+aN6MZiTdi4Rf2XniyNmEzyiCUAJANkfmBRmMcD0AnB3QXsOGBYl2DWMu3mEq5KtVi0ry9Wm2VO1eDL9fKpZSweiSpAxgR/55KMVJentPAAx9JcQPBiJKi0gn7YIxWjE68e7Fz54iDj9fCGk2KzkA5bkf0PVYJKrLYo7HH8FHmca1Q/wBvvTOY2lqb6F7VD1kGe6MwAPogh9eLtyzcQ2anbfE2TTBEzVCBJUzsxnSqSqYXrxkAS5gMfYoJjctRS6tP1xS23yq32bB+4eJqTB+EMMlN/PQ63e/YLgbAQuXyH/peVjzgEh8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3sPhtD1O5TnghZb0Mltrt+b2YzYlasKThKi8gW4Ryk=;
 b=aDjGhHnFsZQfeI4v8CblRyfH1pTr0HZOjYNzV+ceZ5aasWUJ9RnuPcyT/Ol5BGKUO33Lu2tI5jtUCR+Ts5uHqLbwxcV/KJrvhqQBZwyT3xXrfFUO4qZ0AC27FaRPkwhMndgN5ijkoYiNCsOln7RGrHokGVnQSaA4z1Z9cSOK7qg=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM5PR0401MB2449.eurprd04.prod.outlook.com (2603:10a6:203:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 13:30:57 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5458.019; Thu, 28 Jul 2022
 13:30:57 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v3] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Topic: [PATCH v3] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Index: AQHYodNDgTwSkPcX40WBBOsOXPckLq2TaDgAgABgqQA=
Date:   Thu, 28 Jul 2022 13:30:57 +0000
Message-ID: <20220728133056.3lsrlxkc2lhtwhih@skbuf>
References: <20220727160915.3648155-1-vladimir.oltean@nxp.com>
 <87zggtwuit.wl-maz@kernel.org>
In-Reply-To: <87zggtwuit.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 873c7740-34ba-4f73-9aef-08da709d674c
x-ms-traffictypediagnostic: AM5PR0401MB2449:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMbiWmt6LIRgnArZxIgW+UkHTBS2gddPkBITEUGzhVDBZZvHCJbQzraLjkT1c2utmpTUnq3pV+umkVsd/yaTtjmwT0bvGvw389pWeQZuQuGlNjI3vwxOTKGvg+oh/ZM/6ZkZeyPJJCDpLLzNeqBFGglUQEbVnFqxhDRA1EujZ/mrHln17BsFMxR833auaKzAehfFUe+fKlRu8HaBSgqOT5j9irECPdFs2iwAgcDyYOPhMmOtiC7T6ZifbLwlcDaLDBvtAr6t/tDHJr8DY/DPCkfOunjncGstBe0jBytUItgs9Eub7YOM0PHNo5ENnxUNTmGgu4sDm14zMgCaV9Tb+83J4hEmTBTwr/2F1VWPv+dRbiYni9/Rj/A3oOdWgQjTac1RqyhkGACcxoDXhu7NMafvsS7pjq8SosCUv3TSAk6E6MSkZDXKKJ8qChAdbYNUGbyeXMVUoAsuJw28mkZkbFeVWLpVEX/i0+Zk2SdrC58qnJKxmk08hXcu/fAq0/CjIMqpUUGIzGuFSzL8/shGAw4jArpBmSaIVkaU74QrJbb+gXP6J0fY1XtsQdG71rl7I8BX84/uVTwS8dFHX6mYixyQBqhkK4BLvTiyW2Azjhkro7MmINzeJrH7T4kaEeauzEyHVfJJbajzeTFxRKJpyjzAEmPW7ZTD+3fZpUpXdKiV7Nj2lRTq0Ci4p5gxUIviSg7CahJX5b1Hek+EbrGspm6QzP4W/2UWe6ai+W9mBVHuI9CmWXslMPp/woptA3xvEnzlNJxQcYe82dESAjMMpHUxPAqmFHhS+xPag7iqLk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(122000001)(33716001)(6512007)(9686003)(38070700005)(86362001)(8936002)(478600001)(44832011)(38100700002)(316002)(76116006)(66476007)(83380400001)(8676002)(1076003)(186003)(66556008)(71200400001)(26005)(66946007)(4326008)(6506007)(2906002)(64756008)(41300700001)(6486002)(54906003)(91956017)(6916009)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CIYqRBHvg4kSQI6FBKdPnya2hQPv/s6vnK8ZjyWo0H85Ko00QbkiqTVA+0LQ?=
 =?us-ascii?Q?aXNmhtBKB5RffLx+ZUpWQzPedkDt6w9Md8PpB69LvNKEYGe6gg+cni7LRy1G?=
 =?us-ascii?Q?ctsZOyR+GuY0INbVeSbe5/BTY187e0lqiVWop2xl/ChBgaRqs8piBIWJVciX?=
 =?us-ascii?Q?c+dW0lYxrYXwJQhAcaW4I95Mq7VNlxG96LRl/lPJ5M001vytjqUUwVXxHKly?=
 =?us-ascii?Q?fYgU4fD8c7DdK4TinZVgHwhwdPqgXkhWrilE4Ueg1jO6Yl8pU7vCQ0Qyj6/z?=
 =?us-ascii?Q?uhjC44mx2V18OSpvJvDyNETOlwD1qJpb6PTAyiBsFil22u1dOsnfqsEE01t2?=
 =?us-ascii?Q?7IkmsM4SHkxPz/xXp/VOA61mVljPIRMWH1ADvhhvxQ0uMROXtzfk+OVolhZ4?=
 =?us-ascii?Q?HPo88fkPD08QqovLzbtnhY+Wy0/waPpQSHjr8T5Roa8h4ZOlEHwdIn2TEnSx?=
 =?us-ascii?Q?trGNJR6TrWbbBfNEOC+PcWraRDKOIAWywrQHPeLtLGAwpZAGQK3vosL3kwFW?=
 =?us-ascii?Q?A0ZuK3AnT6hvo74JkFog+2L8HNVw3QorYJABqOHdTqdQ1KtHj4DBWnO643v3?=
 =?us-ascii?Q?C2LynRUe9lqegqYwiKL3a+83DkYEYmnyoNCAhIQhuXHaJ9eWvGUBcEkhK9Ir?=
 =?us-ascii?Q?/66KQAxVTGhqkku5OImcfDBpqY/uQjR97XLRV2K3bXMQTL35/7rrUwdoabeL?=
 =?us-ascii?Q?oGI5YMyEjhPpYBxHaS1PJt3GZhhXV4q5F82D0KDtSLYnd/fWrvwdosvVs48s?=
 =?us-ascii?Q?7ihXDLbQpjvoBxesaiBxHaRTVcE4v73er8xmQ5U2F4SKb9WX0c81LV0Hm0/Z?=
 =?us-ascii?Q?MLycJw543rJXHWxIFRbBMtpATNaRaQAT8UkfVdiCc6O/pS0tR+WhO1TuCTto?=
 =?us-ascii?Q?m4ho0gJ3BAaqSVJml7DXBlN3nvI8GQ05yJw5ZfdDzaiokrugniTIbNN3RHln?=
 =?us-ascii?Q?9PLMLuwvhvoWcZrtrLbYvRLgF8vFe4q65umkGoqHvFhkW2INHy9rECewvLPZ?=
 =?us-ascii?Q?3miaSDayra3dS8gVs927S3dTvRvFdJDePI9NAROzMbnvolfkDGkj7WzFrq4H?=
 =?us-ascii?Q?LkhumTgOThTwP+zhIgIVxCCtj53IvDrBSZH0G8A42hodCFxEFVd0jHxgBI8x?=
 =?us-ascii?Q?ss9nJWZjWIB14mUvze9Vd0O7uIk1/d7mKiKBA1/ojzBLRE/94PFtdkCJrzW2?=
 =?us-ascii?Q?OvSCRWJWVhX9qCnf+puhEqouCE5MLHKdUvEumcwlyB5s60Zbwt0feFEHlLpW?=
 =?us-ascii?Q?hDNhc5K/yGVxRqcQh/2Cc+2U1ms7uUwSEabFc5O+88G2XeKTIrEGy1iaeWxP?=
 =?us-ascii?Q?+Pz4XVEf4LHZS4AI+hxeZGvA4fAbcsMzhjS5C14kEaRHQPHBCy+CSntXJeBz?=
 =?us-ascii?Q?kqSlEgcXgCwdMejuyGYdGGpQWS5Tliri5GezuV7DUpNWC9ey/tehs2VK6z1K?=
 =?us-ascii?Q?iqCfacE7O7OJRwCiGo/XDc7VscDwdMS3w57kF3hYRybQ3s1D2sTaxmPe7HyB?=
 =?us-ascii?Q?Q/e7vzdN3TbSfVS8tSuq2i2mtzWc2rR8chQ5c1o0v86VdhitrNeQlg8x+8SX?=
 =?us-ascii?Q?qB2k0Y3hIjiWfCKiDhu91sp4WIl/0nOpphjiH0zD1LywpcUrGr7hYBnu1Hzr?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAFE42E3B0A1F14B9BBA0FCAD2262D7E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873c7740-34ba-4f73-9aef-08da709d674c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 13:30:57.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avI1bVPqsygVJvyTJID9Q6aYQgE3HgPQXEWB+nPCq5KqaNqq1fh1tc3kJAdlzGtn74uK+VrUfQ9mVi6wfi0/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Thu, Jul 28, 2022 at 08:44:58AM +0100, Marc Zyngier wrote:
> On Wed, 27 Jul 2022 17:09:15 +0100,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > The irqchip->irq_set_type method is called by __irq_set_trigger() under
> > the desc->lock raw spinlock.
> >=20
> > The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
> > regmap created by of_syscon_register(), which uses plain spinlocks
> > (the kind that are sleepable on RT).
> >=20
> > Therefore, this is an invalid locking scheme for which we get a kernel
> > splat stating just that ("[ BUG: Invalid wait context ]"), because the
> > context in which the plain spinlock may sleep is atomic due to the raw
> > spinlock. We need to go raw spinlocks all the way.
>=20
> Interesting you say that...
> > -	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
> > +
> > +	intpcr =3D priv->read(priv->intpcr);
> > +	intpcr &=3D ~mask;
> > +	intpcr |=3D value;
> > +	priv->write(priv->intpcr, intpcr);
>=20
> Which really begs a few questions:
>=20
> - Where is the locking gone? Sure, the warning is gone. But the driver
>   is now broken for *all* configurations, and not only RT. Result!

Correct, I had assumed that calls to irq_chip :: irq_set_type() are
implicitly serialized with respect to each other by means of the irq
descriptor's desc->lock, but clearly that is only true for a single
interrupt line. So I'll add back a lock that keeps the rmw atomic.

> - Is it *really* worth it to have 4 dumb helpers that bring nothing in
>   terms of abstraction, and two indirections for something that could
>   equally be expressed with a conditional?

Probably not, but it was a choice no worse than going through regmap's
own indirection. I'll try to come up with something that avoids function
pointers.=
