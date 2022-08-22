Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3259C3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiHVQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiHVQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:01:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C12DA8E;
        Mon, 22 Aug 2022 09:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4FHomp1Lcb4Twg5yVu45KoRQ1MMlg5brGn7TqVD+CXvnwaymg8H2QhOd3rrkck8LlKkDAg16XAi1CuWqa9xdTgJl2xRZmjpWrOXSAROr19KfmErMock/Ofk5HJMCVmw22kHn8EBEkpMtzD6/xsZmqCdZw4imzXaY+Cz9unczYJrbrgu/d+W9269qGYlc1rnDOwnAu+igkbuPyRyQmeAFlfKmPSFX8sOd7YYgSxgtC3Xmd3e2lO/pB6Pac4UwahNASKduxEPvz1pP1i16A2uii8e7JnqD1XtmAw8ScgTdz3sbqFovPXdMzfg8zNjjqn3vkGnBzPOtxtQouXfwDSkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGUfQtlDfWQkMaZo2brnKXEbdbzx5kDyMp7KvmN7pMg=;
 b=VMaS57yXX1QGeqiusIPmXlLa6GjBVBfoNTaSVmrgCF9bZPm87UM0OsyEMcgVkiKiaFOIuTrfMXc+c1q8Azc9w9QU6fAR5BC6MUILF8Uh/Bb+sIe3lmOK7kGdF5j95bIJVrbeU1T2v/NGq6lfgoBCBvMInfPqIdisGgElX6JwQnD9zTMMhafNem5F/7IciACB9zzg4EyLycBfZVsgpuQQKbKludZWBNSGAnhUSeG6o4dR7HDxPlT21A1NRa684O4RXy5hrX7vg2JUjcNCZ5gLrYDzgaIoFyF2XPWzQ4Qk/KX99d5HcdQlLmH4Zk8vYYmZBLsrQOjlmHIYZRc0p8FIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGUfQtlDfWQkMaZo2brnKXEbdbzx5kDyMp7KvmN7pMg=;
 b=QCfExMVyn5tK7YXbWtYeKtiW341EqbfZxEwymgXkVjCxWBE2QQhDO85kgJvTHcZMfn+Gbhzfij8iWuW/tUfGI66EbAzSAiY7NKsOHs4Vb5C1H57ZdzBM13e2Pw7+6q5tAs6OUaShUc2UL0SRfzGviEUP6wVo/rouW7/XbFN6AqhW1rvDm/91eHbjDdzZ+yFNBONx4zLr5Ikoj48oHxEVPCfPe/5bwIuFIsPXxJAfFUlysooZ69nL9TY0vaCt2AAyyHeL5bY4srRxwmI8gIXUQAPCGoIXgxO1K8xS3saXEjioGcd/FXf+zTjdaXJCNiV38oYnsrndgsintfuSYNEgrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB4439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 16:01:18 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 16:01:18 +0000
Date:   Mon, 22 Aug 2022 18:01:10 +0200
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
Message-ID: <20220822180110.70c5cab4@md1za8fc.ad001.siemens.net>
In-Reply-To: <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-2-henning.schild@siemens.com>
        <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83842d20-de88-4d3f-b51b-08da84578c96
X-MS-TrafficTypeDiagnostic: AS8PR10MB4439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDDjthpJuGp/DaSTce5OrK/EZ2efQqkLuxyDvyDKU9pDixlgy340pAgIpGuH0i7v6KOwburWr9dDm/taxkbn09EHBiC1K4rzlivH8R+judls1Rv43qHMMkSmGMpAIoGxi3h2J6ogukqooCEAH8+xEQnsiDgGg7K5FV6AsTiXRaMkY6JycTFzIcz9YUentUvHJk2fh9soLPCQtEEC4G0sFSfFg3IgQaXjEccyGCs5xi/HRMWG0OtHX0c6GNmIrXID+L9h5nQ3DELmhe0xP6GS8Qvs/hdg8Kol/XSiOHuM/Y8XgMfwDKGYr5STFuETWAXqMB8tSAwgarKhbJw1Tk7ozdzunMvr1Yh7QnIb3BAu3oFXeby40OdTp7EuIbzS9sLW5BIyxGq+/f7uQVaqEjL2dgnWT9NrcEfaXxdO3ilkmPly9Nm9dd/w9bma5mQgvoNwi19zoYuuPw6TdzFh6JQQg2ZYp+JUX5T38kHSc2oRegovp5WIdQAOFtdNEwpBg2/XCe/ri5BOHj3pv5Bz1BZorRgdq3DnKk4GOUYkho583SSfczTOLffAFd1xzDpExvxH5jILcwVxSBlmlPeeSt++1dZFDgm1dFq0yW8xdM/b3j2lEv3/JfI6/UYjIBxo3klTL6bD0fQNBtFDXgYJ0EN7aJu2hzq2eto80rQYYVBq/0gKcLD61Xbm3gxlE/T95zGcUom66HZcMOvgQ5oBdMlYTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6506007)(86362001)(6512007)(9686003)(26005)(6486002)(6666004)(5660300002)(478600001)(82960400001)(44832011)(41300700001)(8936002)(7416002)(2906002)(186003)(1076003)(83380400001)(38100700002)(66946007)(4326008)(316002)(6916009)(66556008)(8676002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4Lc5JhctMj7dEd+EcRJiXYwSF3w3CC4j/hzLU9wqbio8m8zY9gnMsMKIjzJ?=
 =?us-ascii?Q?EWJYX1dL+um9lFhAOeZIWuVeFB2HEfPonI/ZC7QaCpdQ81yfNhhzRio9lq3J?=
 =?us-ascii?Q?9S5LJIryrqDHBY57Q85rUmd945N08mVC5B5W2w8pOFYABhNc7f5egUjVDPJO?=
 =?us-ascii?Q?vynrA+cvBBc2+Xi81Y5nBfJVOh1ZiJ3KS55mEFeURNOM35aGYhEnaDtYEIRT?=
 =?us-ascii?Q?+VeeCw7yv/LacBg1NiVh+UH3RV59rrLAAh2isbfByN7mSjAVN9yPBSBJGulC?=
 =?us-ascii?Q?b5hPv1X702i3/nqAmZSMN9laybekhuJbPzx8ukRuBMD4qQ4oryK5LfZutIMc?=
 =?us-ascii?Q?yXeyQGLDXXJvwT3NAAyrl9M74kNAlbOiJ8k9vmp8CT4ET1MgPC6gheFB7QN3?=
 =?us-ascii?Q?fIhEPG48FP6oJKNxVLMNaFUtbFmzYM1YxBi7nO1sKxZztSohvQMW0fz45dzY?=
 =?us-ascii?Q?71FydglXsVjpgm+n+K6LqfmdURUJqn3p0UvSLd93V5vA7PreXYOAtzL7vQS9?=
 =?us-ascii?Q?rbOdwwXhxYcuHSZjmpmax3D5XbOw2n51Q7FZCZljlvmq4kF1UlDaWoXXTNM+?=
 =?us-ascii?Q?myCzzl9I5Brjr6TRkR8sNiOuGK7lt+RQCafPgm1vbs13g78Nak8G75f4n8Qv?=
 =?us-ascii?Q?rWtUgGhKmt61jkoKz9xXC0unI0UY6mr/sova9qv/MjwhhpLZ3lmJ1lAJTo7Q?=
 =?us-ascii?Q?eMSSWu7NN3HZuhxoM81zsgIzCLLdA+34iIGgu58gmEwroU60Pb2rx86Zl7/V?=
 =?us-ascii?Q?uXp6vL79hRk2+Aj70H5sKbnvHzELCUkMwCujsK52y7Rr4AMMcTrshRAutEPT?=
 =?us-ascii?Q?X3jCn9Ej910IxyUrh1ZywymjMyZZEMDlCrb/R5du7bdpC21zniQlGQENwP2/?=
 =?us-ascii?Q?3qKT0ILlO4a/m3A9MltbMCdA3zK6bmXHHyCrKwE6OjmhcIj9kbCBYmIyOZYe?=
 =?us-ascii?Q?9hcEMuPjcFcvM80Ph74tMkA1evo7Ij0Ta+HefporQOizaszRwxbPLnnmU8Za?=
 =?us-ascii?Q?7oPAObGUA1jh1u+VTvBGW0Y5XnOa/C42MajpkvyWnVmmjoJOHEeVT6bDVzC5?=
 =?us-ascii?Q?evVe/bNTnTG7iiWtGWsDRy6Qsn4EO3hfn45yKBo7QuFl+l09M89njEPd+qFZ?=
 =?us-ascii?Q?Rb5UWbauWSjG6hOoNHSaUedu+uUOFyD/VKg9GcQYXZ62BGynkPQ5riSGMJJA?=
 =?us-ascii?Q?tQL6zCPtDsrFyihWkejgh0Z1He7pa1FkWjcyhU1yKEhyGHDZrkLjVA67L75W?=
 =?us-ascii?Q?jL/whI7JBKFC4Lv7jFUjHKziLnJvWeu6V9b1bGXshZT2HkSqSrUOmubxVdYE?=
 =?us-ascii?Q?1pE9Hi3vurWbX9SC6HyTURLR3OzXoVioe8liAzh7a4fhParxamNnp//RBB5r?=
 =?us-ascii?Q?FgcM6YUI2ORVLnxIlYpbqHu/SC5s9siLF6Lp5HLvtRImQ7bVgG6Nj3F4TxpG?=
 =?us-ascii?Q?6VdcJ09HxtjhIzvM0e5h7eSjxgKnis5gZF4aIIC5Zkkoc65+cJq+6rCMzBZu?=
 =?us-ascii?Q?RlzfpNf+JRkNeXxP+mINJtVpOPDOJEUcmDEExnHK0mtB7dXZyNIxqVjMoy1H?=
 =?us-ascii?Q?jRA8HGg8KCh9d8rlVis45YGynqnKczOjJFrXHcYmSS3su55t26mWn5Qfenrq?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83842d20-de88-4d3f-b51b-08da84578c96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 16:01:18.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4IkoES4FGbyEb5eDETAnR1TKZiMye4d8k6rj2lutUh97WtpbOZabsDRGpCfMk9Lr/lP6hm3klxwtqzTdMpNuUpN3L6JJEZoxjc2NFdZz60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4439
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
> 
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

Unfortunately the Nuvoton Super IOs do not have a global manufacturer
ID, just that chip ID in their global control registers.

So i think we should really just drop the checking of the manufacturer
ID all together, like proposed here. Or we could check manid+chipid for
fintek and only chipid for nuvoton (like i.e. all the wdt and hwmon
drivers for nuvoton do already).

In fact i will implement the best checking we can do, so match
manufacturer and chip where possible and drop to chip only where not.

Henning

> Simon

