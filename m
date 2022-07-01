Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD2563256
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiGALMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiGALMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:12:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DA4504F;
        Fri,  1 Jul 2022 04:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkMLlASu+6QOoBprjOOVDsS1wzIHM/JXt+ku1bppjZfDTskb5dvfJea/usBm4tXLTn3y0ZhzN/DuH9wXb/Mxy/vt8pnQiXNzSBtWfBAaZO6QMn3PLhEJI3fsSwBZ2C9te4FoX/EWqFXX1QLIZuVy6CxnHiuXzgicB06f/IoeTyyDwYcB1JR7BLkqBA5B6W3jbtFhYe+zvjiXXmmusUryIbgh16ZjPYkWAwVUFA6vXstbsjfQYJb0CDeyWmQspY3cbX/Aosh0rwvCnF2ZJfLNqV4dzkmO1fyve/s2eG4/cx2E3tBfnyDajrCf2W3bJVQHM49acc9YInJFFeaKMBf/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvdwlVVLG2KYxs16QBkQiYYte+W4TEGezGEh8PRwTcs=;
 b=WWvxtNMECnBreUQBNdsMAC7s1TI8dG3FpdV2UTu5jLf6c1V0XpSfbxzqZq7w7L8tTxYCGWFGaZlG7+Y148A8D1DrDesNVVTHhN44vhrw5Z6CLM1PcJFU3L6M6UY6fUWKer8K7Ce1DSc1cRurOU24GZmAS4tlXJuLUzvt2qQYDvf/kFcc/GocYdExb38PmlGX9ABge/W4KVyXHUUnAMql3mvlrfAvvZ7bxXEg+Noqi3uoVyBlPpOlxtH1Rkd71XpnuU3RdQc75pHPA58Nktgv/dVaEH8Jcsml8ZaMRZwYDBxzq/4gQWBsV0RiohQhqRUhB+J9+6l6d6kEI0tgSReXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvdwlVVLG2KYxs16QBkQiYYte+W4TEGezGEh8PRwTcs=;
 b=rw1gyvrwyzDpc5dIURafK5jTyriWZGMtWWHVETJxP5OiSSW2AIat4C2NkKV2buPCGuSfhjlh8qLnE3596zipkl4uWaprQddyS/7+hP1SmBY+1L4/2ZzPcYwLaHS4dZhJLkhUupjjyEgTtY0EIC9KGiEy7cRgnqhRHnw8/AzFep0ogVMeSfpr7AQ+QGAFGkwOlkKJrDa4Zcaf/nzKzwHb9qetKMsKUlb9dWLolwj0n42FXQZ+k/nZCgB/3HR6bhiGZgXKRGNV6U7meEWaOF6m++p+NOr9JpCOP31/Q+PWjAFs5mbksbUlk8LcCtSzE6a9AC91YJaI0ebb+EzbmqVftQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 1 Jul
 2022 11:12:36 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9%9]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 11:12:36 +0000
Date:   Fri, 1 Jul 2022 13:12:33 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
Subject: Re: [PATCH 1/1] gpio: nct6116d: add new driver for several Nuvoton
 super io chips
Message-ID: <20220701131233.68b0f507@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VcoN6eekZXPK8Kpw4aaJN7jfirnUH+1Q0JTEyLSKwrB0w@mail.gmail.com>
References: <20220701091412.20718-1-henning.schild@siemens.com>
        <20220701091412.20718-2-henning.schild@siemens.com>
        <CAHp75VcoN6eekZXPK8Kpw4aaJN7jfirnUH+1Q0JTEyLSKwrB0w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::20) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f1abee-b589-472c-c380-08da5b529a7d
X-MS-TrafficTypeDiagnostic: DB8PR10MB3386:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+SI09PmsjIvOEatXh2kxZ0WI2tS5jZHQ9KY73qXIakI8Hune7iKH3yBy/TU+tF5gJBbGX6kkTDYnOm9z9agwwJPkH/zksStVYIFVe1slA781wOAfD983tqR4xZYqofM2VUOWgP7/X/MM1jfcoFe9ERtdAZIQtrx8pxhRQpPgmngrWaBJ9xIZ50GUwGAcgdBFpe2hssRPWDj+PSwN6j2JhZRwQ49iI5TzzTglC9cRd85CVTYODKQISdnkto09jY1Uc94U7Bh4HI1Hj9AoDedMjmPb3OcvoQZHaR69nkwLd9JihIF3dy26KuWCgpBALTb63LmN2GaPGInSMDcbSkItwpEH+aasZUIPRZ1zkIWpNOmCe8CRh9gmqi2WJrVDfEjQEGwYuQj1SOcf+tR34DaNobHLsZXd6jkNUm2GxEcDqieCvhzlUJkoaTCXr69VZUZ+poGlYim4TOQk7lb4a+fyVbvn+U/kuV9YCUBoXDPfzhAZ/FpN9dwU6WHalJzDuonJiBHXfA7LPlRzECvekqVDfhWeZsB7DEZ2NaxoR7+5Di9taHAfOxlyR8oGpfp4yowNc1Au6GF895QuwIhERAZHUyyhScxcr2+mw/VIfTxEtEvxrwAheLhgAPIPJR5WWPtluYRVFvHSPvOLvhjg/nx92iqhbuZ6aqusy+yFLD7SxCHy7fhLPLGe1H4dNCC09qErpY7/r8bSonoDW2bj+HNLDgHhyROZs9a2YSdBhcXXXgfibEipsIvHn8OI2DJMWcL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(1076003)(38100700002)(9686003)(6506007)(6666004)(44832011)(6916009)(53546011)(41300700001)(316002)(26005)(5660300002)(86362001)(66946007)(478600001)(6512007)(54906003)(8676002)(186003)(8936002)(83380400001)(4326008)(6486002)(66476007)(66556008)(2906002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0sa8OVQDf8hWMP1HYRnvhtt6EPfPxIM5PqWAIr1ckylb/mxOhgtxHDnusmGE?=
 =?us-ascii?Q?hK8hjcICt7kXN61YV0Uuf3ATvU2hBfaFlLRmFizQXEBOpWY4OcPlt1c15lK8?=
 =?us-ascii?Q?ISKaIhko6PtvX3R8OU/AgLxyl9Iv364PyGNlHKOUYFJ+68oINwiojHSbnKwd?=
 =?us-ascii?Q?u0sMSmGWy1F/WhMOfZpnEMRRIQNq/S9J0/0o+n8eEhsjlVscr3kAHznpAhpX?=
 =?us-ascii?Q?loi1k3Qw912SelXimKtBReXdFBivJtz7eRiHrpFWlQDmlgrUsFEKRiuZIdf1?=
 =?us-ascii?Q?RR5pKPTBqLpsrE2cuewqswlQyeltue5TtnbrtUbYCA1WIN4lfAZsyBFKhmVN?=
 =?us-ascii?Q?iAhpXAee3ftW+hF84kfUQ2lSGlV+uQN74ekDlFWk0PAdAhqiCmZthKaC+A8c?=
 =?us-ascii?Q?+NTheHB6VhWmwbHthsb2V89gDkOGFjO7K25mN6E6Xtpl4GCnGyDEKkI+y6l+?=
 =?us-ascii?Q?z9CQXALQ0ojBu2nqn0a4yd2YuA8wuVUYlMwxsi56r3ejEwzVy8CSP+PUOneo?=
 =?us-ascii?Q?1CHeRfcVHYfqHUnq7sKquAgYdqyAxBpNzshz1D4PDVW7iSz68u8ozKqIavAE?=
 =?us-ascii?Q?AXdN/d2ekwThxZ3g8WtRYB4mTlSLczfHg1VwuGlCwI2Pq2GTW9TdrKkqrWeP?=
 =?us-ascii?Q?9wguuC1aspF0yVc65d4KZVm+d0YjvjnQBi9q1lX9tAZfAoClG8tgnH1N/DIB?=
 =?us-ascii?Q?7qYS2jugxr7FxZgpLZIkTWwi25Z8UObgmmoK3649dSuYZN2cJBeTN7kwajGo?=
 =?us-ascii?Q?rxRSmff/u5q6SVVbNc3TEa+APBo6OxSCzkE+PdI27zn+6vovO/C5vwP9UtkW?=
 =?us-ascii?Q?uHpIPKZkdwm9rAG/irBE0PyEDdzhlH1ql3RBML+1nblVLAq8OtO4eROjimLf?=
 =?us-ascii?Q?BKzd9tp4Sn5XxVfzwogY8casPnYNpImvvZyjveKGecpPLdHiDlgD0e16pAtu?=
 =?us-ascii?Q?nUF9lRwXPRWRxxfd8txqWfdI3WNf/9lulW3ZkGJk7YWKmMSWdTEpFXN33URf?=
 =?us-ascii?Q?8WX+mWuSbJ5LmWNJXeo5zC60lBmVZxjpEiLJnSONIUdeGoNB81vIC7X7kVWQ?=
 =?us-ascii?Q?hd5JVDZ0Vu+AFJON8hbkccJ4D/LuIhfN1bSjCpyt/d9tCxMY8+EzuBPO4qra?=
 =?us-ascii?Q?JoSiM2cq2mzE9L38DSb3FVSYI63JQMyIBxN6OdhFI2Z+4Hq4qeS6odXjmO1k?=
 =?us-ascii?Q?igh1Fir8B5Jcq6C4Dnt7rmD7GfBwfsmWdM8kMk8F1sVZxiNCIgHKlXJXmnTf?=
 =?us-ascii?Q?tUo1oQyQJhV4zEFzTdIfKAmJ9RYBO8NwGVhmzgptJfJyAaQV2GwPlYGmv8zB?=
 =?us-ascii?Q?Tp8sGAToY/FScNdLw7bTFZoLO5nXnKOyychepFIWjOdwZHnMSUm7efBp+MSv?=
 =?us-ascii?Q?2Fe1QtUbUNz7bSIGMOe5mKl2bUYjicACkVxEL5/edWuwCKv0YoAqYhJarBS2?=
 =?us-ascii?Q?YqPLqp9bFw/BshTo7UoIWO8FaVMSexP1yQxv1WJ+GFSz+ciRz8hxQObjXtbf?=
 =?us-ascii?Q?VnfZMGMCxghu+GxCrzkdSY5yWl1Cgm5E/1QV6/qFqdZUn0wvtqULLplqNgsr?=
 =?us-ascii?Q?o/1Hvj4gnNxnbnJUQCxP174ZesOqOvlYncsWNhBCQNhndD8hJeajL2wJQ+oc?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f1abee-b589-472c-c380-08da5b529a7d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 11:12:36.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sxZeANAh9SqcGZDziytmKs+FpeGdLV93lKPQyAwH8jKqIJ0PQ6ZiEDwQ1CBRLaC90TQOXxM/iWkvKKHL9vWfBbNjjh5Hs3OYVh1Jwro3jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 1 Jul 2022 12:45:58 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Fri, Jul 1, 2022 at 11:15 AM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > This patch adds gpio support for several Nuvoton NCTXXX chips.
> > These super io chips offer multiple functions of which several
> > already have drivers in  
> 
> Super-I/O (to be consistent with the help in Kconfig, etc).
>
> 
> > the kernel, i.e. hwmon and wdt.  
> 
> watchdog
> 
> ...
> 
> Since you are talking about authorship in the cover letter, is it
> possible to get the original authorship to be preserved in the commit
> and authors / co-developers giving their SoB tags?

In fact i am afraid the original authors might stay silent. I do not
want to claim to be the author, i am just the one who polished for
mainline. And i do want to give the original authors the credit.

But i will not spoof git author or add SoBs, unless i get explicit
permission ... which might not happen.

A lot of the findings in the code below are actually what looks like
copied code from drivers/gpio/gpio-f7188x.c and
drivers/gpio/gpio-winbond.c but this being a new driver i could apply
the improvements here.

I would have to look over the proposed changes, would not want to touch
too much because i can only test one of the 4 chips.

regards,
Henning

> ...
> 
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/gpio/driver.h>  
> 
> Keep it sorted?
> 
> ...
> 
> > +#define SIO_ID_MASK            0xFFF0  
> 
> GENMASK() ?
> 
> ...
> 
> > +enum chips {
> > +       nct5104d,
> > +       nct6106d,
> > +       nct6116d,
> > +       nct6122d,
> > +};
> > +
> > +static const char * const nct6116d_names[] = {
> > +       "nct5104d",
> > +       "nct6106d",
> > +       "nct6116d",
> > +       "nct6122d",  
> 
> It would be slightly more flexible to use enum values as indices here:
> 
> [nct5104d] = "nct5104d",
> 
> > +};  
> 
> ...
> 
> > +               pr_err(DRVNAME "I/O address 0x%04x already in
> > use\n", base);  
> 
> Why not use pr_fmt() properly and drop DRVNAME here and in other
> pr_*(), if any?
> 
> ...
> 
> > +static int nct6116d_gpio_direction_in(struct gpio_chip *chip,
> > unsigned int offset); +static int nct6116d_gpio_get(struct
> > gpio_chip *chip, unsigned int offset); +static int
> > nct6116d_gpio_direction_out(struct gpio_chip *chip,
> > +                                    unsigned int offset, int
> > value); +static void nct6116d_gpio_set(struct gpio_chip *chip,
> > unsigned int offset, int value);  
> 
> Is it possible to avoid forward declarations?
> 
> ...
> 
> > +#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)
> >             \
> > +       {
> >     \
> > +               .chip = {
> >     \
> > +                       .label            = _label,
> >     \
> > +                       .owner            = THIS_MODULE,
> >     \
> > +                       .direction_input  =
> > nct6116d_gpio_direction_in, \
> > +                       .get              = nct6116d_gpio_get,
> >     \
> > +                       .direction_output =
> > nct6116d_gpio_direction_out,        \
> > +                       .set              = nct6116d_gpio_set,
> >     \  
> 
> .get_direction ?
> 
> > +                       .base             = _base,
> >     \
> > +                       .ngpio            = _ngpio,
> >     \
> > +                       .can_sleep        = false,
> >     \
> > +               },
> >     \
> > +               .regbase = _regbase,
> >     \
> > +       }  
> 
> ...
> 
> > +       int err;
> > +       struct nct6116d_gpio_bank *bank =
> > +               container_of(chip, struct nct6116d_gpio_bank,
> > chip);  
> 
> Can it be transformed to macro or inliner and then
> 
>        struct nct6116d_gpio_bank *bank = to_nct6116d_gpio_bank(chip);
> 
> > +       struct nct6116d_sio *sio = bank->data->sio;
> > +       u8 dir;  
> 
> Here and everywhere else, perhaps keep the reversed xmas tree order?
> 
> ...
> 
> > +               err = devm_gpiochip_add_data(&pdev->dev,
> > &bank->chip, bank);
> > +               if (err) {
> > +                       dev_err(&pdev->dev,
> > +                               "Failed to register gpiochip %d:
> > %d\n",
> > +                               i, err);
> > +                       return err;  
> 
> return dev_err_probe(...);
> 
> ...
> 
> > +       pr_info(DRVNAME ": Found %s at %#x chip id 0x%04x\n",
> > +                       nct6116d_names[sio->type],
> > +                       (unsigned int)addr,  
> 
> Casting in printf() very often means a wrong specifier in use.
> 
> > +                       devid);  
> 
> ...
> 
> > +       nct6116d_gpio_pdev = platform_device_alloc(DRVNAME, -1);
> > +       if (!nct6116d_gpio_pdev)
> > +               return -ENOMEM;
> > +
> > +       err = platform_device_add_data(nct6116d_gpio_pdev, sio,
> > sizeof(*sio));
> > +       if (err) {
> > +               pr_err(DRVNAME "Platform data allocation failed\n");
> > +               goto err;
> > +       }
> > +
> > +       err = platform_device_add(nct6116d_gpio_pdev);
> > +       if (err) {
> > +               pr_err(DRVNAME "Device addition failed\n");
> > +               goto err;
> > +       }  
> 
> Wonder, don't we have some shortcuts for these? Perhaps
> platform_device_register_full()?
> 

