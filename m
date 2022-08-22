Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1459C06B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHVNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiHVNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:21:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D524F24;
        Mon, 22 Aug 2022 06:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkNkCI0czivXBhYPUad2+Y47s9UIsD4X26iqAmj9bZZ7j8aqnzmJ8i6Izp3C6yUvR3jIBxY4s/iJ9vm9szumyVNKmXGnpVWKwYqg/3vaDe2GUUnsj6mL3TStDE4GUdEPKj2E2qcBTY4L1kk5ET6t4+Tsstphtr7vAigS3NBoLey1FRhbNMwlKMLJCXEwF3sZnZ/6YrT51R5pBEx0x7p64iRKXUYjWYYMtyHbedPr3cdvni8jjuTLuODEFKLu04SVGGYpTwRUa+TxQl14eLngqaxxbEN/T4tez3XKtty1ythB5nce8eunOZQ5ebEbMJUzcDVSZHMW2Ti4XAt5XeaYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMnVSipjrdwhn3ZkwErhEIoZumJB/1k6x/SCoNChmOI=;
 b=HjyNFXkKyFdQ98UXRJF6Hi+lC+CDIl7vSx7hlp0150t3ovrXnuRuVpC96+ln/mCrRghHHfAPWqOph3d+bnxhRqER+0mjLbY8cmzey9jGqs4ywEHfDMI3KxQzgeFIH4hVlCZNuw6jK9/EXlH2ulgvyQavlmexYV9cgXnjNziXKsXptIDBklkjGUHT0Zzj9gqR01QInlljeYqBeoi7fJ/pvq4QcWfqa1aCzls8yRVFnG+vcrdj7HN835ZH4wbdg/8b6ZWX3jsaJP/2ia7ki8XGgyuugpNWd/stutnyl8qQTlkN9DUXjz0jrQphZbZzZmMTI+ah6TcyIs3Lir2ANOR2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMnVSipjrdwhn3ZkwErhEIoZumJB/1k6x/SCoNChmOI=;
 b=NkfUPa5rL+5llytHBoUS+EFH4eFtbAlAjzgIGNJOLkdMHsNMeP6yOLogozq/1mxsHR3V1YHc4FOGibCoR1YhHub1tz4UZ+VBhLNedJO0kbT+WbvmJRVXPMLI0zALtInMZe89ToJeS30IOQkKhbbj6R0cGBp2hzYt3Y9zjMyOPlOAqeJHSzx3DszGPv1I98ybfBqWTfFWpsITzpiFz7JZ8HrMWjCiyBKlpHAepqBDBeU8E0eEgP0wgkVdPpHdopUBz4NaoPfS/daJs9ueykyxa6iPNkQDF1fOuvDIjTdjmkzAdHwwDyBUB4Vo4pVjND1vU63om9Z98r0n3gatzkZTJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GVXPR10MB5887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:21:47 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 13:21:47 +0000
Date:   Mon, 22 Aug 2022 15:21:33 +0200
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
Subject: Re: [PATCH v3 2/4] gpio-f7188x: use unique labels for banks/chips
Message-ID: <20220822152133.5e8f257e@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VdWdzsT9wc9BNNKTJ3-eBn3uWdCFXqE2TT+CiJnoTOQYw@mail.gmail.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-3-henning.schild@siemens.com>
        <CAHp75VdWdzsT9wc9BNNKTJ3-eBn3uWdCFXqE2TT+CiJnoTOQYw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:610::44)
 To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cedf383-0e73-433d-b49b-08da844143ab
X-MS-TrafficTypeDiagnostic: GVXPR10MB5887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mG2WLaXazLSBCafbhefod9tXAV4SNbtI5E/EoiQsRI767tDHlLnkSb9jCViwfg+N3Hih2XsNaAQ4GsSY3WzKTf468oOugkeM8Ac1uTMHKVRhdA6fbRpPua+JWiXA7zXDUoTHHiXfYxGOX0/I3M45yZtMj/fhdUFVBmUcj724oGf9GG3YBi9XDKkFoR8xnIs/PNr7e0ZBmMjTnhCboTwjf0PI7sP7c7QXsIb+X0DbW9/pZv1rD2gnN0bqexasFqr03WFp+hmli3AhgIaLBMfP6m1T9fs+ndOtOR35lKNnYWJFRRv/X4rXMDwR5JvYwLdAMIQQYnNauR/+SAnyQcSP+zzIBiz4lA57OSHfL5uE1j3bZyFx9+9r5hYzCe4oNH8bUOdiZjlmMv8IWHDbTT679yW+fwVquArlhFeRSS7EkUIamlirxvp4nVX06OWt0G36miEDTnRPb/BCFPOu23ygyO4dS0mWRDyJxNMGD8cv7zfYujacqtY6OyAerbZp/+I6Snak/ILdqA6D7YDxAJHDEDebs4Dc5+m3yAe99xRe07RvOA1td2MWHYYjG3yxwz9iDSe3zpKqQ4Rs2RoKl2cxxEV3iSQ1o7tO3+m1Pp4AuL7KfU6qZ+NEcdqAXxQqUSX1AwYOE1zZ9KF1QAj9msreD/wr6Co9iBOFRZoaSfnlqSYqRtAGGrojr+7KtX+NwR7eUmo1N3Ta3/GVfFnYhW9ShA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(6506007)(6666004)(478600001)(6486002)(41300700001)(186003)(1076003)(9686003)(6512007)(26005)(2906002)(83380400001)(44832011)(8936002)(7416002)(5660300002)(316002)(54906003)(6916009)(66556008)(4326008)(8676002)(66946007)(66476007)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?haxzI1841zmX9seDQouWzBg8EZWMhs41UYbvevzJsCkbWfsAfmipervfxZGo?=
 =?us-ascii?Q?IlbgkfWrEbSJU23olgsoHsucquJKHhPP7A7ARQ00UR98HzqH86u5bwlWvTM/?=
 =?us-ascii?Q?ZYbb7W3kGhs9u3u0sn3IVo9E9FNvXGCmAX1TgqXseqr+BmzFE+OuiTpcHnvJ?=
 =?us-ascii?Q?EMJa1q6FSB+1ZhJEwVxA5zVJfQc/b5TC+e2l7Qc6bnw5l0VcK3WjScQbD3Mf?=
 =?us-ascii?Q?hMRGvQkCJTjbYm9feXrBX2bCLnObjo+EkQAQV0esRuT/XRWFVd4z0UX2KTzd?=
 =?us-ascii?Q?nosTIyaFbPApmWPOEThsYK/8fAVYOJTZ1IG8fb4lU4WKZkn3V0PERVVKVK5z?=
 =?us-ascii?Q?vc/AlsevTR8n+wT6HpS1iH2eGYmlBdmcjOqa9+PiY7wvwVCPPXxXGSGi/RvZ?=
 =?us-ascii?Q?KthRiXvbzZ+wplJbM9/J4MLtL7n73WvdZRlPsFJ8YcJuPcDM8oi1F1SE08Ot?=
 =?us-ascii?Q?Y2CvyuD1W0SV8HywU1fERInN8xet6UikCN7ouq+PontiY5fCGzQUwLKwAu2r?=
 =?us-ascii?Q?L5hQ2okg1Kv8UY5gL4mHjPJ685LdXlM+YTRZLja8oIvqRuLmPu3yikBOUCrz?=
 =?us-ascii?Q?E1qFXy3B2c47KRIQerDm+sV6MKRJNdtpVnNAoGuJ5TiZyPjHso2c5zwBuAyb?=
 =?us-ascii?Q?UeC1WGnOe4zuvJZjqpTJxl2TruuTFubZYenZY3BAPkjCzGU+ZVI12bQO9LSC?=
 =?us-ascii?Q?Q4tyilyJGasf6oy2SHSHYfSJMCSMD7mQv5I415RnuGzNrSM71Ng1TLw+X0Sa?=
 =?us-ascii?Q?kFOXhQui0NLVAZYUmeUbi9TVCDPwdn5p5wTblC+Auky/ImFLFhfwFrK59Izs?=
 =?us-ascii?Q?OnvYdnFeipNcFanqEzLLzmpTBNxRlXyO7oHX56p0ECFr/wq7te7OpKQgkbbC?=
 =?us-ascii?Q?24sLjDAnpcIbkrh5lSPENrDFR6lao3nDdt5HOpDmo/eV/q82z0VHrj7oYj3E?=
 =?us-ascii?Q?GxGLCbkXSqhqHhchzADPIJDUKd9gUAe1E4Q4b7YNdlKcFabt3wdq0G8zbNAy?=
 =?us-ascii?Q?H4O6kRGFhA4i/J9fvfXgwTdjl/0lJqTTJwyrRQmTrNuH72tB6YLKUBhqhqOm?=
 =?us-ascii?Q?irm+d5xLCkWCNOOUTOiIMQUpdZ1wr1Ys6Ykhyd7jmYQDQJiDTmV4J/jm1CN1?=
 =?us-ascii?Q?TMK1lfEkBXqNnhKuTjCfApcdkE2v4fpQ180hEnUyIsP052IMYQGE9/NcWWCm?=
 =?us-ascii?Q?vczsTgVu05v3zJmXZIiTUR5V2NwbfzhGd1Gm3IFLNKwEGe3r7BCcGeU2v5iu?=
 =?us-ascii?Q?5LQFQCXknxePpwRpxSsrYIBN8wluXMeo2/xjdMl5sn0PY+lrV/wcJCalFe0L?=
 =?us-ascii?Q?/TGryq8KjLoRWMTyjbyzY9XVWPMW0meijKoMQYqBrkMMyiw0uwxljAwMIcAZ?=
 =?us-ascii?Q?IaZfi/xwSbttLxIcPnuVYG0G8lwe0AmR8bLxluJw6bpOyrCyKVy4R04qvahn?=
 =?us-ascii?Q?t3g0TR+FpjBTiXthEpuThx3M0Rv9bSlzSxQ0Z6D405gbTp1HKhpIlyxhm0/O?=
 =?us-ascii?Q?y1QSAOm+PSQknII5Pczkmn83KqIvVF6b5JVI2Es24W/2Ui8v73mJy1uIbkCE?=
 =?us-ascii?Q?7hG0sdJPZKaTAVS1sJ/31OVmDkKFu+IRtuXXFQa54vcJywqGbkTpz9Pfm1Le?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cedf383-0e73-433d-b49b-08da844143ab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:21:47.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhU8ly0R5oOh0v/GJHIF2t1BdzS6FCJb6NwH/mf+HhDdMccrPTfOUGB03wqY+ZALjO5KURC4tjpuoVZhL/0bxfGUpZZFWBg+gTqaUTxq5q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 12 Aug 2022 10:39:08 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Thursday, August 11, 2022, Henning Schild
> <henning.schild@siemens.com> wrote:
> 
> > So that drivers building on top can find those pins with GPIO_LOOKUP
> > helpers.  
> 
> 
> 
> Missed given tag. Do we need to bother reviewing your patches?

Sorry but i have no idea what you are talking about, please help me
out. Whatever i did miss seems to be pretty relevant it seems.

Henning

> 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/gpio/gpio-f7188x.c | 138
> > ++++++++++++++++++------------------- 1 file changed, 69
> > insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> > index 7b05ecc611e9..45b466b04070 100644
> > --- a/drivers/gpio/gpio-f7188x.c
> > +++ b/drivers/gpio/gpio-f7188x.c
> > @@ -149,10 +149,10 @@ static void f7188x_gpio_set(struct gpio_chip
> > *chip, unsigned offset, int value);
> >  static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned
> > offset, unsigned long config);
> >
> > -#define F7188X_GPIO_BANK(_base, _ngpio, _regbase)
> >     \ +#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)
> >       \
> >         {
> >     \ .chip = {                                               \
> > -                       .label            = DRVNAME,
> >     \
> > +                       .label            = _label,
> >     \ .owner            = THIS_MODULE,                \
> >                         .get_direction    =
> > f7188x_gpio_get_direction,  \ .direction_input  =
> > f7188x_gpio_direction_in,   \ @@ -177,98 +177,98 @@ static int
> > f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
> >  #define gpio_data_single(type) ((type) == nct6116d)
> >
> >  static struct f7188x_gpio_bank f71869_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 6, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 5, 0xA0),
> > -       F7188X_GPIO_BANK(60, 6, 0x90),
> > +       F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
> >  };
> >
> >  static struct f7188x_gpio_bank f71869a_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 6, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 5, 0xA0),
> > -       F7188X_GPIO_BANK(60, 8, 0x90),
> > -       F7188X_GPIO_BANK(70, 8, 0x80),
> > +       F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> > +       F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> >  };
> >
> >  static struct f7188x_gpio_bank f71882_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 8, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 4, 0xC0),
> > -       F7188X_GPIO_BANK(40, 4, 0xB0),
> > +       F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
> >  };
> >
> >  static struct f7188x_gpio_bank f71889a_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 7, 0xF0),
> > -       F7188X_GPIO_BANK(10, 7, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 5, 0xA0),
> > -       F7188X_GPIO_BANK(60, 8, 0x90),
> > -       F7188X_GPIO_BANK(70, 8, 0x80),
> > +       F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> > +       F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> >  };
> >
> >  static struct f7188x_gpio_bank f71889_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 7, 0xF0),
> > -       F7188X_GPIO_BANK(10, 7, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 5, 0xA0),
> > -       F7188X_GPIO_BANK(60, 8, 0x90),
> > -       F7188X_GPIO_BANK(70, 8, 0x80),
> > +       F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> > +       F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> >  };
> >
> >  static struct f7188x_gpio_bank f81866_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 8, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 8, 0xA0),
> > -       F7188X_GPIO_BANK(60, 8, 0x90),
> > -       F7188X_GPIO_BANK(70, 8, 0x80),
> > -       F7188X_GPIO_BANK(80, 8, 0x88),
> > +       F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> > +       F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> > +       F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
> >  };
> >
> >
> >  static struct f7188x_gpio_bank f81804_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 8, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(50, 8, 0xA0),
> > -       F7188X_GPIO_BANK(60, 8, 0x90),
> > -       F7188X_GPIO_BANK(70, 8, 0x80),
> > -       F7188X_GPIO_BANK(90, 8, 0x98),
> > +       F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
> >  };
> >
> >  static struct f7188x_gpio_bank f81865_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 8, 0xF0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE0),
> > -       F7188X_GPIO_BANK(20, 8, 0xD0),
> > -       F7188X_GPIO_BANK(30, 8, 0xC0),
> > -       F7188X_GPIO_BANK(40, 8, 0xB0),
> > -       F7188X_GPIO_BANK(50, 8, 0xA0),
> > -       F7188X_GPIO_BANK(60, 5, 0x90),
> > +       F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
> >  };
> >
> >  static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
> > -       F7188X_GPIO_BANK(0, 8, 0xE0),
> > -       F7188X_GPIO_BANK(10, 8, 0xE4),
> > -       F7188X_GPIO_BANK(20, 8, 0xE8),
> > -       F7188X_GPIO_BANK(30, 8, 0xEC),
> > -       F7188X_GPIO_BANK(40, 8, 0xF0),
> > -       F7188X_GPIO_BANK(50, 8, 0xF4),
> > -       F7188X_GPIO_BANK(60, 8, 0xF8),
> > -       F7188X_GPIO_BANK(70, 1, 0xFC),
> > +       F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
> > +       F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
> > +       F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
> > +       F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
> > +       F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
> > +       F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> > +       F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> > +       F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> >  };
> >
> >  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> > unsigned offset)
> > --
> > 2.35.1
> >
> >  
> 

