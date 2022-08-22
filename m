Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72159C082
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiHVN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiHVN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:26:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307F2C677;
        Mon, 22 Aug 2022 06:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApJ/GlbC4lXxWTrG8Valp6OmSLmgRRGiRRS9GktFkRt16TUDP9MM6YJuVPokoKt2O39o1HCO1x7uaW4eswU89xQlxtxgxJXeR1W0sTGmGnAoXbaQA/QotQ37Xwii9uN7bsFpDswkACKbz1svqZholxwJDmkVFWP4iPChD1zPW6ZoL5UT8stWLdvyoyaU9qeo5tpdIzuYxu9OBeqFUH94sdH6ZGeC9MQPc6vkIdIZ3zsMu9PXugq73r9e1eIP3GgkwxG1/7FkWm5xRa6hAiO+CIq8cu6KOmsl/WtGtPVfHlrFfaFPXQS60xnej2D/c+Iwnng4uNfyw/otJqaWhslr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULwqzSdxcoJFVwnAoV5Dv0MXI4HOZcJgg7FJ/jm5H3E=;
 b=GQOxRmfiPV9+exPecru2LcJUU/RQerXxaJGvMf5jrcwewMdgygPGn8TKz5S3gXk0cSwj2dIO8yIpdIhSIYFBMgcmmgVMn6Q8894afieh4C0jzVAlbhb0MR3nj9gKThHwJAxU8CW4IXRYRZUoEd2DPWYqHhstbN1Odi8YdJqbTyP1gEVK4/4KumKVfn0GvlcVbh2/8vqP3ztj1d4O4wnVfSgsusKJ0QbwtWND/bI5DYp93gS9CPwAmtE7pujL4dV/JtdvD5dfGgyj/ATz6bYmZUsvj2rV18NdOmxFGQSpX2+9tu3z7gOfwWy7TFqrUtVmFqzG4aFA3wYSqtsfZCYJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULwqzSdxcoJFVwnAoV5Dv0MXI4HOZcJgg7FJ/jm5H3E=;
 b=zTxQ86ZxetvOXI5gUm93Axt9yeohe1KGU+uKTEuS1gsjwgMmNSgPDrPXgzyU6vk6OgrwfStulJUhDWNrM/7585HJufyYrAH+s7AT9GeOsIs5728j8Ieqk19zJZxof4wpVoWsg08Ojv4C9XAVSjf6+dxyWb6Ige85uSutQLddv6zvdsE4Ou/2fj0xxUdLIxe0Ts2ebl5y2mnALaYjNbLKlisACfF6bS0KpoaCNOieUtvak1HBgYaBA8fvC8eGDEOdMZMI5hw0JOzkluegqf4i2FshAOVzAmPDcho0z3aFKI/6+e938HbjqOnGEHdrA63uQUNJtANzdyDply5UrV8s8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB5429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:26:26 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 13:26:26 +0000
Date:   Mon, 22 Aug 2022 15:26:13 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        "simon.guinot@sequanux.org" <simon.guinot@sequanux.org>
Subject: Re: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220822152613.55f71cc6@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VdgKHh+ma34pY=PzS6MB6NWNtzBAADqQmaJgT+couN1Dg@mail.gmail.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-2-henning.schild@siemens.com>
        <CAHp75VdgKHh+ma34pY=PzS6MB6NWNtzBAADqQmaJgT+couN1Dg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e80ec04-8331-40f8-56e9-08da8441ea32
X-MS-TrafficTypeDiagnostic: DU0PR10MB5429:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aR8hFzPOgWLRxuXtgmOvJOIwpBE4x5qcSZ2XmAGXgbg8b0ILwlBAX/6xwRDcdZGZ4gOHBpCoKS/ECPM1wiKzO9P8IsZhAm0U+YJWY1O4KDSwUEP0uPfBLytQ3bGKJWtpd1nt+KfIyU39aCLxl2cJu4vwCbsuHkoh92aZRMdc5biTs+IKyIsdid4f2w09F9ZP4EjpLv2Tx/FWbJDjt5eQB4rc2HdOwW+0t+OWKzgVkpmuF/c/Bft2D9AcYGuyahjtXL1PFefEDJ7yhUcRKInJ48c+RDwmSHslkVzkJC3KDI+s4TwxC1dk6uwT7dwtPj3Tmyp8PnKZ8yGDTRJ7qdPDQp6Up5Wbb3HJDAjJgqlDCqvkBBajbSmBFYxLGbgx5ky89xN03+RaI2tg6jalwDspWCOpt3l6NWSK3Z1wgYi+I5txEnNhIpeG2811nbziaQVyzV8EVbyaPCrWt9sl1Wk+2ghouwNAJc6a0YBJHT1aEdTdb/V7K/NgfQQm9CeyY4lwdhEuJ64XmmPPHY6LHbavZGWL0NbT00XRqzm/CFdVwfLdrmNgpNS+wY5890BwC9fUnloHTgfFGkz3QIbbW2VY/gdD0XxLTxqG2Hc8wsw2vwSQBdZ0MUAFLB9cziz5HfRyhxN7uMicsXJWCm2//aTB80NPvoBsQ+q6bQNyfgA5NEvOoWEymwuUMf2JtQ2RE5cVowLVsRQCSEd3wBtqkF9pkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(38100700002)(83380400001)(66476007)(54906003)(316002)(4326008)(6916009)(66946007)(8676002)(66556008)(26005)(9686003)(6512007)(6486002)(6666004)(5660300002)(6506007)(86362001)(186003)(1076003)(41300700001)(478600001)(44832011)(82960400001)(2906002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGJRGsFuRFDEIjCdJ/yrI6plGyuXJnuKMTlinhuv9KrXfz3xeLcQuAbrTk0/?=
 =?us-ascii?Q?aV7h1d4KmIT7BKal55Kh9vWEJ0u7scQHk/9UpLE4LtdQSfS5b073yrKnImZK?=
 =?us-ascii?Q?k35MCIyIHm/MrIwT+sf9iQrYCUZ9iUHJlVAGBGMLPWYoXFqNGdCZk+zElvLw?=
 =?us-ascii?Q?B0HlOp9ERHoktSSMlwmKnDmsjINHryPEKF7vuoecUnhBvemgmleM2F3V7u/s?=
 =?us-ascii?Q?01TK7iIerjI+Df5MS7GleEGsAmpAAslmdn7cO6Hf4AwYJQ2P74as5MUMfHF5?=
 =?us-ascii?Q?mFla4HUsP0EHenvX96OasQzfYPagTIVfTsCnuf+zx2Pook7TQkagjvvs97og?=
 =?us-ascii?Q?mfvrN5IhEjm0ORwn71MrinrZQqvkS9MnRe39PKMzPCXd6gjRwvjpcO6m5E6z?=
 =?us-ascii?Q?JZ+syp4fMjooKMd4eZ3Cd1aujEZpcqcbUAzaZGAVT0xSVKkqip/CzxH7HvI4?=
 =?us-ascii?Q?FCTvO+NaQ7F3yLfPXy8tboj1Mx7q/ITxcKDS49YJEm3CyOpbV7W9RUzMvePl?=
 =?us-ascii?Q?Jgt+e6dhx0TZ+WKGihwIuin1J5Y4jh4GlJiH35mUCE5ofKlBeK5jhyGm/LaT?=
 =?us-ascii?Q?kfpwWh1HkCpeWUv+z7RMTCDSDaFoBKSu7kcUUerXm1xoczwi1c8PwAQR7jw3?=
 =?us-ascii?Q?KPj1QhMj7jIvkud/xVWQ2KkcLf+XyJ6FhvAx9GoK5KmcUz+fvsbGkR/xluvi?=
 =?us-ascii?Q?45VeTFykjkD1rj0wnNAAAPR0fOJpj1tX3o6xYz1BOfs6L4vhTh6Ut3uEA8Fw?=
 =?us-ascii?Q?Ej26r0eI6ezanmDt+54InNKU2XPHKEA5l8qRi1Jyk7sUH183vyMrbaQOksV/?=
 =?us-ascii?Q?YpWAp5pvkV9GHnFs2/HILEoGY5zEdKVdq95S9hRUSTfAKgwjPQ/JPqjqEEvy?=
 =?us-ascii?Q?J90fdogeh37XETY679opfxGfbfpdJzKi7hEZYCjJuTClLW0ZsQn572e2ym/4?=
 =?us-ascii?Q?+rf3jpkd9+MkRXuvvFNvaftW04g5uToSTa/ysZSu7eLD83w37WaVAS55J3YL?=
 =?us-ascii?Q?QrSZskUryf50fgIX0i7N9SXKw+2RimH16SxyglOHF9MMBlingdZUTgRtv0wP?=
 =?us-ascii?Q?0Wjqf2gQc/VJdZ7HWyvBpUj2kXuMZ2dgsYxkNq/tcu8rsLgvYe/13qcgP981?=
 =?us-ascii?Q?LPDH7032GDsE+sxdMbpH6e/e8cV/f97DPbYAT/wgrarMD1Yj+l0vuNSyEdLT?=
 =?us-ascii?Q?Itjw7sNMo/AEQOeDhuUOmFnTGQwICEDyw5gDtU2BgpUiHbWkcsaEvE87xLHS?=
 =?us-ascii?Q?nqVSYjWqj9rtf9fZcjzQ3GjrWRjaPr0iuQZRSr3myYyh8SdmIlmo3w4X72Xs?=
 =?us-ascii?Q?V+kKHpiDmB0o3RpghnoAQBuEpLuckGDv3+e/AKQCPIyXf3gx8eHyqJGkUrSH?=
 =?us-ascii?Q?SQe91FcVyZUs0Uqb88+AJ93L9Ocm6CSeXxwO7OQEDiZGyLd1HMRttbkz06nG?=
 =?us-ascii?Q?HStTf4UJJDtfqZF4p9iUBf/BxMhR46uJa8drZdwR0iAAG+t2Mm/l6VkMXS7g?=
 =?us-ascii?Q?Fnr5HsX4bneAnupiJq41yRPzl2KUfiby9rfzsdsi6rPhNor1mVvtdmqLNVvJ?=
 =?us-ascii?Q?wACN1Qguo+fEgLZJz46w3z+B09n8Iq1tg3RrxDAOfvCgy5wl4GHj1WeGHJRB?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e80ec04-8331-40f8-56e9-08da8441ea32
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:26:26.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLIDzrJJTF0de4MSGc2Ui03Ok6w0rSAyhPZP5gHmlT4ypogIwnNitMhrssDSNRB0jIGVTehAJu0KfX2IHoCKXVINS6r6/RTBfbqn4D6qlOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 12 Aug 2022 10:37:02 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Thursday, August 11, 2022, Henning Schild
> <henning.schild@siemens.com> wrote:
> 
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
> >  #define SIO_LDSEL              0x07    /* Logical device select */
> >  #define SIO_DEVID              0x20    /* Device ID (2 bytes) */
> >  #define SIO_DEVREV             0x22    /* Device revision */
> > -#define SIO_MANID              0x23    /* Fintek ID (2 bytes) */
> >
> > -#define SIO_LD_GPIO            0x06    /* GPIO logical device */
> >  #define SIO_UNLOCK_KEY         0x87    /* Key to enable Super-I/O
> > */ #define SIO_LOCK_KEY           0xAA    /* Key to disable
> > Super-I/O */
> >
> > -#define SIO_FINTEK_ID          0x1934  /* Manufacturer ID */
> > +#define SIO_LD_GPIO_FINTEK     0x06    /* GPIO logical device */
> > +#define SIO_LD_GPIO_NUVOTON    0x07    /* GPIO logical device */
> >  #define SIO_F71869_ID          0x0814  /* F71869 chipset ID */
> >  #define SIO_F71869A_ID         0x1007  /* F71869A chipset ID */
> >  #define SIO_F71882_ID          0x0541  /* F71882 chipset ID */
> > @@ -37,7 +37,7 @@
> >  #define SIO_F81866_ID          0x1010  /* F81866 chipset ID */
> >  #define SIO_F81804_ID          0x1502  /* F81804 chipset ID, same
> > for f81966 */
> >  #define SIO_F81865_ID          0x0704  /* F81865 chipset ID */
> > -  
> 
> 
> 
> Logical split by leaving blank line here is good to have.

Already discussed those bits and changed them. There will be another
round because i will re-introduce the vendor ID check. Let us see what
that will do to those defines.

But i will give Simon the last call here.

> 
> 
> > +#define SIO_NCT6116D_ID                0xD283  /* NCT6116D chipset
> > ID */
> >
> >  enum chips {
> >         f71869,
> > @@ -48,6 +48,7 @@ enum chips {
> >         f81866,
> >         f81804,
> >         f81865,
> > +       nct6116d,
> >  };
> >
> >  static const char * const f7188x_names[] = {
> > @@ -59,10 +60,12 @@ static const char * const f7188x_names[] = {
> >         "f81866",
> >         "f81804",
> >         "f81865",
> > +       "nct6116d",
> >  };
> >
> >  struct f7188x_sio {
> >         int addr;
> > +       int device;
> >         enum chips type;
> >  };
> >
> > @@ -170,6 +173,9 @@ static int f7188x_gpio_set_config(struct
> > gpio_chip *chip, unsigned offset,
> >  /* Output mode register (0:open drain 1:push-pull). */
> >  #define gpio_out_mode(base) (base + 3)
> >
> > +#define gpio_dir_invert(type)  ((type) == nct6116d)
> > +#define gpio_data_single(type) ((type) == nct6116d)  
> 
> 
> 
> I think with namespace prefix it should be fine, otherwise it might
> be a renaming burden in the future.
> 
> Also I would rather see them static inline one-liners, so compiler
> will perform a type check.
> 

Simon already acked that. The additional code is in line with other
code already in that file. So while your suggestion is valid and i also
wondered why it was defines instead of inline functions, i will leave
it like that for consistency reasons.

Henning

> >  static struct f7188x_gpio_bank f71869_gpio_bank[] = {
> >         F7188X_GPIO_BANK(0, 6, 0xF0),
> >         F7188X_GPIO_BANK(10, 8, 0xE0),
> > @@ -254,6 +260,17 @@ static struct f7188x_gpio_bank
> > f81865_gpio_bank[] = { F7188X_GPIO_BANK(60, 5, 0x90),
> >  };
> >
> > +static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
> > +       F7188X_GPIO_BANK(0, 8, 0xE0),
> > +       F7188X_GPIO_BANK(10, 8, 0xE4),
> > +       F7188X_GPIO_BANK(20, 8, 0xE8),
> > +       F7188X_GPIO_BANK(30, 8, 0xEC),
> > +       F7188X_GPIO_BANK(40, 8, 0xF0),
> > +       F7188X_GPIO_BANK(50, 8, 0xF4),
> > +       F7188X_GPIO_BANK(60, 8, 0xF8),
> > +       F7188X_GPIO_BANK(70, 1, 0xFC),
> > +};
> > +
> >  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> > unsigned offset)
> >  {
> >         int err;
> > @@ -264,13 +281,16 @@ static int f7188x_gpio_get_direction(struct
> > gpio_chip *chip, unsigned offset)
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return err;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> >
> >         superio_exit(sio->addr);
> >
> > -       if (dir & 1 << offset)
> > +       if (gpio_dir_invert(sio->type))
> > +               dir = ~dir;
> > +
> > +       if (dir & BIT(offset))
> >                 return GPIO_LINE_DIRECTION_OUT;
> >
> >         return GPIO_LINE_DIRECTION_IN;
> > @@ -286,10 +306,14 @@ static int f7188x_gpio_direction_in(struct
> > gpio_chip *chip, unsigned offset)
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return err;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > -       dir &= ~BIT(offset);
> > +
> > +       if (gpio_dir_invert(sio->type))
> > +               dir |= BIT(offset);
> > +       else
> > +               dir &= ~BIT(offset);
> >         superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> >
> >         superio_exit(sio->addr);
> > @@ -307,11 +331,11 @@ static int f7188x_gpio_get(struct gpio_chip
> > *chip, unsigned offset)
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return err;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> >         dir = !!(dir & BIT(offset));
> > -       if (dir)
> > +       if (gpio_data_single(sio->type) || dir)
> >                 data = superio_inb(sio->addr,
> > gpio_data_out(bank->regbase));
> >         else
> >                 data = superio_inb(sio->addr,
> > gpio_data_in(bank->regbase)); @@ -332,7 +356,7 @@ static int
> > f7188x_gpio_direction_out(struct gpio_chip *chip,
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return err;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         data_out = superio_inb(sio->addr,
> > gpio_data_out(bank->regbase)); if (value)
> > @@ -342,7 +366,10 @@ static int f7188x_gpio_direction_out(struct
> > gpio_chip *chip,
> >         superio_outb(sio->addr, gpio_data_out(bank->regbase),
> > data_out);
> >
> >         dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> > -       dir |= BIT(offset);
> > +       if (gpio_dir_invert(sio->type))
> > +               dir &= ~BIT(offset);
> > +       else
> > +               dir |= BIT(offset);
> >         superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> >
> >         superio_exit(sio->addr);
> > @@ -360,7 +387,7 @@ static void f7188x_gpio_set(struct gpio_chip
> > *chip, unsigned offset, int value)
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         data_out = superio_inb(sio->addr,
> > gpio_data_out(bank->regbase)); if (value)
> > @@ -388,7 +415,7 @@ static int f7188x_gpio_set_config(struct
> > gpio_chip *chip, unsigned offset,
> >         err = superio_enter(sio->addr);
> >         if (err)
> >                 return err;
> > -       superio_select(sio->addr, SIO_LD_GPIO);
> > +       superio_select(sio->addr, sio->device);
> >
> >         data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
> >         if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
> > @@ -449,6 +476,10 @@ static int f7188x_gpio_probe(struct
> > platform_device *pdev)
> >                 data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
> >                 data->bank = f81865_gpio_bank;
> >                 break;
> > +       case nct6116d:
> > +               data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> > +               data->bank = nct6116d_gpio_bank;
> > +               break;
> >         default:
> >                 return -ENODEV;
> >         }
> > @@ -485,12 +516,8 @@ static int __init f7188x_find(int addr, struct
> > f7188x_sio *sio)
> >                 return err;
> >
> >         err = -ENODEV;
> > -       devid = superio_inw(addr, SIO_MANID);
> > -       if (devid != SIO_FINTEK_ID) {
> > -               pr_debug(DRVNAME ": Not a Fintek device at
> > 0x%08x\n", addr);
> > -               goto err;
> > -       }
> >
> > +       sio->device = SIO_LD_GPIO_FINTEK;
> >         devid = superio_inw(addr, SIO_DEVID);
> >         switch (devid) {
> >         case SIO_F71869_ID:
> > @@ -517,8 +544,12 @@ static int __init f7188x_find(int addr, struct
> > f7188x_sio *sio)
> >         case SIO_F81865_ID:
> >                 sio->type = f81865;
> >                 break;
> > +       case SIO_NCT6116D_ID:
> > +               sio->device = SIO_LD_GPIO_NUVOTON;
> > +               sio->type = nct6116d;
> > +               break;
> >         default:
> > -               pr_info(DRVNAME ": Unsupported Fintek device
> > 0x%04x\n", devid);
> > +               pr_info(DRVNAME ": Unsupported device 0x%04x\n",
> > devid); goto err;
> >         }
> >         sio->addr = addr;
> > --
> > 2.35.1
> >
> >  
> 

