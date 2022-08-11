Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5F58FDBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiHKNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiHKNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:52:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60155C96C;
        Thu, 11 Aug 2022 06:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXt9tfZjBqSEDRQ2nZjA4AxFYviKXUZu5TP9bumAMRt/5mFv2BjG6uZ3wQyYLn3Uh8OsFmP12qM5H9nRA114Eb2TkWiMQrhixJJjxP7As+xjC+rlfT5sWfQBEe8oQ1Di8dUYiT+WFWwMm0bR74skbMxuDqfQ9lbLPNfhJHnydp2LW3yvZLho/C8BpqEDbP01aOxHVqxqaVrH09MJlybNt8oYCV3Z8hgP7JFeUImrBcfK46GPCtVTBPaCIGbVqPlvvSFqdi08Sr4WeZeu+pQiUGpUU7qtYMbsGkve8/AQarl1ifn89XagiNAzqW+80N1vWsqxFwzR6g9isiAHwVtUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4VyqJP56LpwH23RHrZk5mHIjXgaotH3HoMm9snHaYg=;
 b=ixhfbp3CD5mg+KsWg2CNm3qMcUeEilQ/FC5U3kAPY4ui9r6w+Ak0870Xt0Z9Xae8K3gX04OZ5kSs+wlcTgo23TGOIeSFu/CN+TqGKk/+kxbJ7Wv3GBsy1S12G9oMDMOekI4zMrU+Ko05wyJB1uPuqK0e0lz/pwvlGdHBw+bn7Ah6y5DmhJslJQeTcBgBZolulpdYilqKKLgtGOvVs9NRt8kjpADu90JJYU5iXIyG8oyVq9YJhaeTMt1XJ5E6f1nEJ7x2nS35jYIhrUxnUlQ49lSJL0uJtFy14S2Ncqb3QZvGY5XkfnHh3pEH1j61wEQnl+CRhwIx0BTdXBcqBa+brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4VyqJP56LpwH23RHrZk5mHIjXgaotH3HoMm9snHaYg=;
 b=dLeJ7SOXkiJ+NzU5mhnxsuiB10hNWOA8bCa5f9fsG3zWUGumoQS5Kcw0gNG7MqYfnUJXSco831Fs+uLKDYkxBriOp7kDA1XGu4V5fKexn1rfQTxXQju2Nf6z+1NGi0iH/+jTCNg8eu/Uocjffg6fUKA8/okhBGBopZjedd1zQU+l4TonBHbmvk+NlUf6jGDIrZeBnykq+zvqpz+C93KHhXmN2ZOmnmz2b1iFWfd08dBxN0hmgWoF0Qd7Oc8hsVtha7CIqnOdWav/aW38EHgQNcjRZpaqG5c4OaFjkJZ6CjXn8IPUG+fvhUaNnMS/H36VSlYzd2EZETSzJPDrBLJcww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PR3PR10MB4032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 13:52:49 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 13:52:49 +0000
Date:   Thu, 11 Aug 2022 15:52:39 +0200
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
Subject: Re: [PATCH v2 1/4] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220811155239.4df134ca@md1za8fc.ad001.siemens.net>
In-Reply-To: <YvUEu8bUc2RgtRpi@76cbfcf04d45>
References: <20220809150442.3525-1-henning.schild@siemens.com>
        <20220809150442.3525-2-henning.schild@siemens.com>
        <YvUEu8bUc2RgtRpi@76cbfcf04d45>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:610:4f::29) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3158a5-b90d-4db7-a875-08da7ba0c72e
X-MS-TrafficTypeDiagnostic: PR3PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZwBbRSFAaFczdmAl34nbooxhgdHDlBxX0n+vAc6oWO5sZhc+/7Oh2KZHqU39hys6aKsschJ/2PGXsIIOqT5i6RMGeFU0j5qNocJXid/n08slkFfk3pMzVDP6lwfKOWoaW6YBKSFTJ6511+uWc4UHaJRtsGfrk7mwY26q9jUtSeedop5aU/vSsSPNP2oubUvgZ9QIprixnADUYkLH4blBayH84fm/XDXgFDcsnB+ri9Jyfq5NUi61sR+d+jJTsjvNLza9EZRuJRaXbg2CuzWVXEeIVO1VBdO8mBfzATWke5wzwLlcoWynyd6jgo5BoUjxpylPIpf4I5ljCG2R+YqmnUNfJXmTLHfQO1bFkm02wYb10FyT7+WbmjiEhXSJTpgZbIj3gj5tzRwvzOF6kPz0z4mPRVZMszrAwAh9OeDZCP/HSLIMIzsZH0AfkXZM/zAKTbDexszB/C8mNSSvX66BU/CDWUMWfb4hCQeyrJ00RPNKRAaw9lA1cNFw6jJIM9olIVQCIb64g2LWPq/eY3X8gFJYcijfNGN9HcbFmCnrzGIYcu+0pVPbLgI3/gJ16FNY+XRafHB1Jv89GHvRVkgc4gJOiUbY1Nm9iyG3xmI0+gVMDDsC+94I9tBtYYJyyBbreVhAUz+sJLJHKvLw/lZisx4YsUDo+DM3RI5vzmZPo0QXBDwEOnx2HReixLLWh2HuJihsmTxIq/4o3srR0OkjTjCcuUaeuUg2UdV9Xw8zL3OAGtGkWq82jvytAhOo2Rt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(54906003)(6916009)(316002)(478600001)(41300700001)(6486002)(2906002)(4326008)(66476007)(66556008)(66946007)(7416002)(5660300002)(8676002)(44832011)(8936002)(38100700002)(82960400001)(86362001)(186003)(1076003)(6506007)(6666004)(26005)(6512007)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WeePZ2VYOla5vZooSoqiJF3BIHSX/kwUOfmHgyeLnfxGpxlU2QoU0woy6pH7?=
 =?us-ascii?Q?z5YKXVH4BSy9BoUSWXSIcBt39kBHC5zfOjrITjI8B8SDm10L+EvtOvRjr/2o?=
 =?us-ascii?Q?NhnILlHzBgY8NfM6xP1YlGOh+2SN2SA8z/CC9w4fl946JnUudCm5s/oTBrCK?=
 =?us-ascii?Q?/wFGqdx6A6Mu27ptkiwErUz+yHtd71YQmyeFo1Jt1a0aaq8vZD4Ng0E+ISgV?=
 =?us-ascii?Q?r9rNWZCwRyx2jkagt19M0TM9krkDrd83yW93ObODc0tnVYlOlqJaKO6r8eWZ?=
 =?us-ascii?Q?GzOUmC89KK1NlER4jKKOTjqCcfPSCBLLpysDurpWbPvONz1k0ZEaQlzJVmR/?=
 =?us-ascii?Q?vIPHrpnQXwezBDnufai8lMmMXHoYAPCfozkD6bHxTLCLKFPY8uVlypbWX8Q6?=
 =?us-ascii?Q?vped0x5ASY2QPFQZIuyfYQwDbc2MUmykW5x6YXTuraYREqR+O0wFk8Gg0eIX?=
 =?us-ascii?Q?bUf+vtyMXQvOmLHKZJ3ejeu8cUm0RrrfYrJjyx7elfathrtUsyqI9WIFzbqx?=
 =?us-ascii?Q?m6b0YIuppJms1Kauby/nZxVbKh/3Ts8BK+QbNW7PWHDirQnsJORTBzAT1SBN?=
 =?us-ascii?Q?kOj2E3p0zj/gCDHZiudpi2Deglr6kVw/WKLuMRX8ZbMTCqayv2ARsrCe2sVD?=
 =?us-ascii?Q?1svtY3z5nVbahOGPz4ZMarkSOQkq4oqHJCuzckxQQaLXv03GlfpO0x5bJ60p?=
 =?us-ascii?Q?ZTHpP37l4GvASIFnC4iGfGhGAAs49pi+sSQYSIG8vz3UFzKn+//9YNDnqHeK?=
 =?us-ascii?Q?rUUlUlud4zJR4mw0iEFqDYSqgviFFuF1U6KRFQ5KKbAra48Z+fVbLpk/ygOV?=
 =?us-ascii?Q?WAnl+dozQQpUTF2B6j/JX6DXBZOH2ZO4QmIHNUblN2XKX0+3ifWQCSeTIbj9?=
 =?us-ascii?Q?VdcLTVHuapZhH5i6Ca3XsLbla9cE1OR0uIwmIaH9BO6v//60wofRFG2wteX/?=
 =?us-ascii?Q?4N8bnXpuj1KUgtkflNIXYPlQDqbjWYWS4P2ouY5cedzKMrVHoMU88FvDhzHz?=
 =?us-ascii?Q?O2fx3HpIsUYcn2mjrdGHHBz3PbdWxYSPWB6EvCUegc62RWlpv/7NBhOCZ5AS?=
 =?us-ascii?Q?SaBK82BBWzejdZAUn6RcIA10098jKbUesyGyhtCOjN1+9nb2gyOzvgOQvPqo?=
 =?us-ascii?Q?Xl/THg21nMqv61VjCYG3VbT0OUZY/MhrAnzoy+M+F+JUUJNA0oUPFxhPXmgf?=
 =?us-ascii?Q?ACotls0Q38s/bnU/IWyYxChsCL5pNol6xotr9y+WXAoflsqOXceqU1NKQpyB?=
 =?us-ascii?Q?hvCCtA7ZlNTdO/fjAD6X2EiR9+rTSGl5wrt6TWbNv4Yf0PHtBiTlvV5iSfN/?=
 =?us-ascii?Q?zo5rhcxE0n3QyyDn5tyhG38QHkiXQv+fuCbmJOx7uBJ0v7t9brDsvDXwHPNS?=
 =?us-ascii?Q?VaQPf9lxeTvnfPLyZZNfBxh0ouXQZwLyVvoHqLgQ8mcmhj88cucu4Qtc77Va?=
 =?us-ascii?Q?8VlPRyIwNZtU6A2vRpXCQk6cK7odH4mSxqXbEFKlk6W+N9AaxzLQnyq3S9ad?=
 =?us-ascii?Q?sBBPObneFQlf0rk640BEElZFH/D/uXK5Lr08yqbcYYzOwUt7f27UJcUjdVib?=
 =?us-ascii?Q?9CtY1VVV2ZFnNsOYilzKPwOzIGPLzsMEezd32ZybRInHLQ3qgBXExTYyvaNO?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3158a5-b90d-4db7-a875-08da7ba0c72e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 13:52:49.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IU9QQ9ZaIjx8HBfBMXhvgququub1DH2+SoqBcq9Uu6pU5wW8Ddzwdbshba7qPDsvspWpbBpVU8y30rJbi0e87feflka2Mj9wk0STE1dcj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4032
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 11 Aug 2022 15:31:39 +0200
schrieb simon.guinot@sequanux.org:

> On Tue, Aug 09, 2022 at 05:04:39PM +0200, Henning Schild wrote:
> > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > very similar to the ones from Fintek. In other subsystems they also
> > share drivers and are called a family of drivers.
> > 
> > For the GPIO subsystem the only difference is that the direction
> > bit is reversed and that there is only one data bit per pin. On the
> > SuperIO level the logical device is another one.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> 
> Hi Henning,
> 
> This patch is looking good to me. I only have a couple of minor
> comments. Please see them below.
> 
> > ---
> >  drivers/gpio/gpio-f7188x.c | 70
> > +++++++++++++++++++++++++++----------- 1 file changed, 51
> > insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> > index 18a3147f5a42..4d8f38bc3b45 100644
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
> > @@ -22,13 +23,11 @@
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
> > logical device */ #define SIO_F71869_ID
> > 0x0814	/* F71869 chipset ID */ #define SIO_F71869A_ID
> > 	0x1007	/* F71869A chipset ID */ #define
> > SIO_F71882_ID		0x0541	/* F71882 chipset ID */
> > @@ -38,6 +37,8 @@ #define SIO_F81804_ID		0x1502  /*
> > F81804 chipset ID, same for f81966 */ #define SIO_F81865_ID
> > 	0x0704	/* F81865 chipset ID */ 
> > +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical
> > device */ +#define SIO_NCT6116D_ID		0xD283  /*
> > NCT6116D chipset ID */  
> 
> Can we do better to make the definitions above more readable ? With
> the new additions I find it a little bit unclear.
> 
> Maybe we could add a comment on the top of the Fintek and Nuvoton
> specific sections ? Or maybe we could group the LD_GPIO_ definitions
> in a dedicated section ? Or something else :)

Not sure what you mean. But i think i will put the two logical device
definitions under each other and simply add the chipset id at the end
of the list. It is all a matter of taste, when i wrote it it felt like
putting all the Nuvoton block ... 

> >  
> >  enum chips {
> >  	f71869,
> > @@ -48,6 +49,7 @@ enum chips {
> >  	f81866,
> >  	f81804,
> >  	f81865,
> > +	nct6116d,
> >  };
> >  
> >  static const char * const f7188x_names[] = {
> > @@ -59,10 +61,12 @@ static const char * const f7188x_names[] = {
> >  	"f81866",
> >  	"f81804",
> >  	"f81865",
> > +	"nct6116d",
> >  };
> >  
> >  struct f7188x_sio {
> >  	int addr;
> > +	int device;
> >  	enum chips type;
> >  };
> >  
> > @@ -170,6 +174,9 @@ static int f7188x_gpio_set_config(struct
> > gpio_chip *chip, unsigned offset, /* Output mode register (0:open
> > drain 1:push-pull). */ #define gpio_out_mode(base) (base + 3)
> >  
> > +#define gpio_needs_invert(device)	((device) !=
> > SIO_LD_GPIO_FINTEK) +#define gpio_single_data(device)
> > ((device) != SIO_LD_GPIO_FINTEK)  
> 
> Since this macros are only used to get/set GPIO direction, then I
> think we should use the "gpio_dir_" prefix.

the first one yes, the second one is about data and not direction, but
i will go

gpio_dir_invert
gpio_data_single

> Also is there any reason to match the LD GPIO value rather than the
> chipset type ?
> 
> I think we should enable this specific path only for a Nuvoton NCT6116
> device for now (by matching the NCT6116 chipset type). So if more
> devices are added later then we are sure they still go on the original
> path.

Right the chipset is which says how exactly that variant works, not the
device number on that multi-function chip. Will fix.

Thanks!
Henning
