Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5604B590F67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHLKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiHLKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:23:21 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50063.outbound.protection.outlook.com [40.107.5.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3E92F40;
        Fri, 12 Aug 2022 03:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lad0l3Yvwn/0AMFe/gsnVFNstclHlgPF3QYUQVEdNoRUsGbg/q88r7AxeNnZqUGLShq0ZG26kiN+Vvew5wgdjbrs+7Al41lDZV7BdB7Nj5nwdz9cwmK0ZgCLXMym1wa2CDpEUyD6gqyl9XjUg/GEcHjtFyyD6u83XebvhP0SyizQxreECpcVEfQ3/smYMzBl7mbTZys6HUx4Q8tv8n4MDVpVkj9bwBGSrO3if5a8xw9to7j5Q+MG6+NW5U2sNNKZVkTR47gW3/nFtdI/fZuq0ZzcTOrJ5icNq8vb2GsxRKKVaoNr+yqqO+EsOrfdsRhOH6p63bkamF9pzO5C08wLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmCJV09CoIOJyIXziHjG81wQZTz6g85dUgxakKnGWdw=;
 b=nLXK7yj7vtVASVjeSVuhTY/jTCzjjmYBWu9ecnnXzwzDZQtOykL7SZlfHWvcbmaIC0pppXY8/qjGw/FOZb7tMnMVUwqbNSOXoBUbDQyUPLJb88j58jRwGKSHTrL7tNb1rjNoiXULT/ILqE26STobzRSOa7S1WOPtKRQfxYXcSnL3t221mFZLyTJXouFRBN8tYBnGaHi14LjFNtBXiKd640tp+S71ifUut9rfRpDdW2p/9z5h2UolDVpp9UvB4t4HKSenzu2tlV0Ge9p+MuJl5pUYHB7qcR4YyDFXLh02mb0/qqZgaNiUSEh3epwE67KIu4tnmbj0Wb45B5FGdZi5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmCJV09CoIOJyIXziHjG81wQZTz6g85dUgxakKnGWdw=;
 b=hNwlvlH1XbiKxvx23y8Ptv6gJHeJ29aT8/HwvgLFFC9TsJWw6/lZkRmTvLUnILCelk6pIWRV+ERCWSsdLqCQT2DpOWdhHWWVbRFP8kyly+GcSQeHiNdsKHMLNnbsoUKv8KtPFgBRC4OBLTLQvePHJH6LQ6QuNJQKmu5usgDKpBzY8ByL6yPgkUWfZ3X/Cn8sLb3S16VV9D5ud/quNViLeJEdw27VFmURq1DrtNo/m+ZEHuX5bzNuTQuoI29xazYV9YL1C+r1YIP4dUJeZSGPIuzD5Psny+vXRqvpJDWnmkxTkxinkwoTmvP/Wvzt8nmA0XyzYXj8IMx7N1OKvNjYKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 10:23:17 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 10:23:17 +0000
Date:   Fri, 12 Aug 2022 12:23:12 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220812122312.7f6f6a30@md1za8fc.ad001.siemens.net>
In-Reply-To: <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-2-henning.schild@siemens.com>
        <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e737b4d-212f-40f0-e4d2-08da7c4cac01
X-MS-TrafficTypeDiagnostic: DB8PR10MB3813:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xlCN39Mpaqm7Bpx3mitllz4A5+W8klutg1EgM4zhls2VDZHVowFXH41MNl/aLygZFly0W7aSQOeNhN9uqyLeZciBrF7uFqbyiKbTOMsILSIuxUo+kCCKJo52b1Prh97NAzZ3GKKs2DC/je41UumqMIo6yZsgsjrDUjNwNK6Q+t02VY19VrfshnyNh2J+BLzNtwATf+qQhzlK7lcMqt1WDPLPIs5sEpAAWKELDmcu1UaUxHND7y48ZujOtguFb3E0rOEqnq8LY7boBFYL/z6/BDPWZLcTfLIkY6F1wNIPNMiR5foFdBU5XR2deIEZ4xZnKllrn+8V0wzDAAUJVPJuaXLWErdD7xWPHMKu8/Lf7oRAgSMCIsYpI5m8ixf+7lYXpLvGiPxizuFYg5rp46KGpzP5/7dulhImwkOAaL0uQE6UKUS+d0Tb1FvwlK/yp7U1m39rvfA/eps6JLw2rPEFKx38JFk+ua5dyvj8zzz2M8bCpZdMKkXf20V2MWU5bgEXDc9dgPZ2p/QbPcrQtJqHtHgBMriJrG1b/pVHZSv6xstGk0yjYjsGOmHxKFeer74ydicfGh5rm5JS0jYG4R8qeNThvWEjEBYq/AWFumzN263atkb0ZKwEP+zJL1i/ELGW8VZVmN6bPQE4CUgCHxXZ3qaopH90rphM6whS33QJ8vXfo3YT9vGwOrSwN90dzBLfGKscJnBcef+hlL7Liis9dSXShw0WxRA3YRsCdG29lPt2Hg3hpSCxABCHnnvWdDX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(66556008)(82960400001)(83380400001)(9686003)(316002)(6512007)(8936002)(6666004)(44832011)(41300700001)(7416002)(5660300002)(6506007)(66476007)(66946007)(6486002)(186003)(86362001)(1076003)(478600001)(2906002)(4326008)(8676002)(38100700002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoWHY9thlYbozY2FHpPRvFyWwT8Mji4D40O+a/iGQc+Z1q2pQfnCy4EGSfWZ?=
 =?us-ascii?Q?nk+2eA1PSes0UBt7ij+zw1TpXdNpXHr+S/AJ1t2XinLoeH8ynPpnXRnwEQrt?=
 =?us-ascii?Q?9cpOEdtnYE5xx6sMOvGMSLBLp4aGK6PesEd2O4iIqhBBlkhA+iwgaA1q1/Ei?=
 =?us-ascii?Q?O+xee0jJuov7cgUBHpow2O6oJHAsPJTfnbUC0xPoDYQCOQ5akohMuKr0c8Cz?=
 =?us-ascii?Q?AcEvZEfZ90B9xb4ai1DEVrO2lGBbozq8TY7DA+lIR9M2KedRBIBO4X/1pkOV?=
 =?us-ascii?Q?ccP+iis5L8Qip9O7QMOa9sc45xN25yxp8aGhPQljNVGp4l/Fi8w5nc6s9Cq6?=
 =?us-ascii?Q?sMEHtK16lx+1X0/Qg408wMcFDNp0LSZlx5+P9wDHmaEzyfi5s6Xt2uu/R8vd?=
 =?us-ascii?Q?NQqTeEO8b+ulvl34sduD9WEtVC2NbGfLSTvmq3drBrSNFoukGOpmri5shDMi?=
 =?us-ascii?Q?0tKpFH2TEZOVWQmWh4JDYZUN3XTa6ptHbEvmAy6d/p6nq0itJkSrXstq9bbw?=
 =?us-ascii?Q?tlE13GzYn+YWkiR6gy0maodEnvT9rFOJZzRx3K8Mlt+f1AjDG84VDzR89z5k?=
 =?us-ascii?Q?Tw1pdHCYF5ZP31CGFy7dbZED1axupaNw5jeslZ+UpVpCMBYyxEu+3sILyevd?=
 =?us-ascii?Q?mzqT5LC+gDagoocwIVFsQ5hXmVCiSTGUYcQlwgyVNIOIWJeetyaSspleoQwG?=
 =?us-ascii?Q?Uycm4YBM8Le/XEhxue3QX+i6mI54Ti05o3X3x0E7U62T3s/5paBehxUokmqK?=
 =?us-ascii?Q?ipFhdAJlcINsfvnMcyNY58TIZ4nIwF+3bdyrTP1hSUQT48su2ZdVSEEJ2o/J?=
 =?us-ascii?Q?LD6bXCfjFJrieLmny0i5I3Cb0E7L9gVP0YIYwxNM/xBv2Ek2j4u81qRd67qv?=
 =?us-ascii?Q?5IcFCZ1BgIrLIGdxjfSQr81KXbXYOW+ENaIzbSv/snebkGQmq4YXaPoBY1qV?=
 =?us-ascii?Q?L6tqsOlNYHHMz80xhVOjkDql//3PfdgTcYwvtbAAk/+k1DI7p534sMDFGBhd?=
 =?us-ascii?Q?BpGtZT8dJchgZkCGmag+pj36Rg/FxCNZG/kvSi07VpMC8ycRnkA443Pahrrr?=
 =?us-ascii?Q?YgImzClw+2BL/C65KijiRHx284YZAlgSHOZTpJJFv2zmSNVjBVe7Xn4OJkgA?=
 =?us-ascii?Q?MVhBXy6kQsPx8phNou7olSFBhzeCgXuANLBBZZiIm2BV6pDBepqejK2mmW3O?=
 =?us-ascii?Q?zq2J2mZr+TV2kOoS/bLo9JKVFIrz0MIkX1hQVvLIRew1laDYM2k3noI8M9Q/?=
 =?us-ascii?Q?L1SaTDW6vQttJXtX4Si8YvGb7e+3/1rvOU6mqN/nu1gyvO/knfkTwcw/6SrO?=
 =?us-ascii?Q?bTWqXjN6fwD4r2k6QTc5NA4Qkpit6bqxiSHUiRJ2MpscLB2lDZ/VoZIoRaMY?=
 =?us-ascii?Q?9+obR1axt0Rt2oe6Wt+AdkXOWEu0IFuWKjr22OxCW7qKgV3VrJwwY+1rVx0i?=
 =?us-ascii?Q?aF+3ICwU0ioEEO2CWVCVX78188cL2YCxX0x1EAT27Ao5UeCMTVx4O2UqNhVo?=
 =?us-ascii?Q?7ZHCPCsvRAdRwmIrPSuYqcDo+eYj9xh0MeduYyfbkRVLGrppIBozIpJv/71R?=
 =?us-ascii?Q?ZZwgL3yWWFNDLoA1IlAY5uihdlumUEQeTvml0J7j6gvZ3o0yFNpkqWuzwWVQ?=
 =?us-ascii?Q?qbf3cbTtbpKGJRjMuNnacdhM4bvp12/0ev56FLlqQQnXrdVQ2R/XoHLLUXan?=
 =?us-ascii?Q?emYcCw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e737b4d-212f-40f0-e4d2-08da7c4cac01
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:23:17.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwcAr/alnKPaDDGD9t+0fU1apBvMAMcCI5MXRTZdoemyTUqiFVeegnmy84E95pSYtWCq5nyC7na49n017ffR4Cyj7bHq+U3sQfLitucZVoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 12 Aug 2022 10:43:03 +0200
schrieb simon.guinot@sequanux.org:

> On Thu, Aug 11, 2022 at 05:39:05PM +0200, Henning Schild wrote:
> > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > very similar to the ones from Fintek. In other subsystems they also
> > share drivers and are called a family of drivers.
> > 
> > For the GPIO subsystem the only difference is that the direction
> > bit is reversed and that there is only one data bit per pin. On the
> > SuperIO level the logical device is another one.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/gpio/gpio-f7188x.c | 71
> > +++++++++++++++++++++++++++----------- 1 file changed, 51
> > insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> > index 18a3147f5a42..7b05ecc611e9 100644
> > --- a/drivers/gpio/gpio-f7188x.c
> > +++ b/drivers/gpio/gpio-f7188x.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> > F71889 and F81866
> > + * and Nuvoton Super-I/O NCT6116D
> >   *
> >   * Copyright (C) 2010-2013 LaCie
> >   *
> > @@ -22,13 +23,12 @@
> >  #define SIO_LDSEL		0x07	/* Logical device
> > select */ #define SIO_DEVID		0x20	/* Device ID
> > (2 bytes) */ #define SIO_DEVREV		0x22	/*
> > Device revision */ -#define SIO_MANID		0x23	/*
> > Fintek ID (2 bytes) */ 
> > -#define SIO_LD_GPIO		0x06	/* GPIO logical
> > device */ #define SIO_UNLOCK_KEY		0x87	/* Key
> > to enable Super-I/O */ #define SIO_LOCK_KEY
> > 0xAA	/* Key to disable Super-I/O */ 
> > -#define SIO_FINTEK_ID		0x1934	/* Manufacturer
> > ID */ +#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO
> > logical device */ +#define SIO_LD_GPIO_NUVOTON	0x07
> > /* GPIO logical device */  
> 
> Please indulge me and add a new line here.

Mhh ... how about you write exactly how you would like to have that
define block. So we do not have taste issues in the next round.

> >  #define SIO_F71869_ID		0x0814	/* F71869
> > chipset ID */ #define SIO_F71869A_ID		0x1007
> > /* F71869A chipset ID */ #define SIO_F71882_ID
> > 0x0541	/* F71882 chipset ID */ @@ -37,7 +37,7 @@
> >  #define SIO_F81866_ID		0x1010	/* F81866
> > chipset ID */ #define SIO_F81804_ID		0x1502  /*
> > F81804 chipset ID, same for f81966 */ #define SIO_F81865_ID
> > 	0x0704	/* F81865 chipset ID */ -
> > +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset
> > ID */ 
> 
> ... snip ...
> 
> > @@ -485,12 +516,8 @@ static int __init f7188x_find(int addr, struct
> > f7188x_sio *sio) return err;
> >  
> >  	err = -ENODEV;
> > -	devid = superio_inw(addr, SIO_MANID);
> > -	if (devid != SIO_FINTEK_ID) {
> > -		pr_debug(DRVNAME ": Not a Fintek device at
> > 0x%08x\n", addr);
> > -		goto err;
> > -	}  
> 
> Sorry for missing that at my first review. You can't remove this block
> of code. This driver is poking around on the I2C bus, which is not
> great. So we want to make sure as much as possible that we are
> speaking to the right device.

Ok fair enough, we can make that more conservative and match the two
manufacturers and also make sure that not one can bring a chip id that
the other one uses for another chip.
A v4 is coming earliest in 1.5 weeks.

Henning

> Simon

