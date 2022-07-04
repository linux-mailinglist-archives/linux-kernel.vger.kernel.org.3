Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6232565695
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiGDNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiGDNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:09:06 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E6E10D3;
        Mon,  4 Jul 2022 06:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY8StceCpiQ2vKtnxyx/JyIA4jq1+BAoN3U6AT/hrA8LZ7bOLHDQfcwGli6dp/gR6E09dcpzKSbQ7V70dYTns4GXySxv+b6Ly72+7iwXwrjl1w6QaX2A4pqWsQhdjlMBXIvhSs44+cTX4Imh6P1uROt6Nfk/la+bREJYgBEM3lTZyQ6Y/CPQlJWxjnvndjVUvxiB/nMg4Pgq5rD7a77ZYr/NY5vKTTo8c6Z5H6oJRfS4Wa5uUOkHiGSk06VEDZbnNFBwIIb29rPQG14VMStE6klfKZcMAn6oG9qP1vMwLTDFduF4D3XbnK8d+5gzSXKYU5lhgMInIJUOAKYUKxnpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwcZq4Xe2A3iMwLqrQeXjyS6Tm14ITSyskJNOL2LA4Y=;
 b=Ql+/BzfdoxPtYrQRSU9JrDICunvIZ7T0gXHmWR+OLMidj28vsPgs+MZU2Rk6TqgyoHeVE9H5GDa3rthPVtDAT+Ju07a5wPkTNpOfgAuA07HoC9Nnz+R5D1lHb6XTCIUrzHSgDMHK9YSVZgZo1glNYh4EbY2+uUTCfbW+Ln54Oh0yUmYkl4vCbGuGlixQOFflqhQD42EH0bGEGqAPmbKENJFU2nRund+lIhr870iyQfHwrABwg6ZsOZO5QUvLlQwKZHk2IcSqrFan5Dm4QnUXTxvwPImgrtOW115JKIAmurCVVcBgk5IDysVghCsFAssE0ZPMvwntCL8nA+1aMLruqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwcZq4Xe2A3iMwLqrQeXjyS6Tm14ITSyskJNOL2LA4Y=;
 b=TJZ6MC4mc2mhKhALuj1u3eC+RA3QZbHQTDLzTUU19kGbyF6IYeTFGK9xCapfx2Ua/CMgEyQaafKQZW/QKcHysaVFRKkZj9KZd1RhOhbpLkZ4DiB7EU4qbYQq4hrsSe+tWg55byPD3bQEvhmZCCExtgPq7Dpe32fnEdghLLUmqrkTUFNy+233yUwqccWHyZ8zHxX9vHg4twXgTmbVFwxErL2Z409N1Z10U8uEGB/QSQeVc3D6Do/0G4FvI1QsgvNr+8mhdgIFaADQAFHaP9XJ6/KlBD4t0uwa2htdIp3+9OsT7XfZarojGZYzdv91Rx8cYG1LcZdfqaKd29NDDi/NxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PR3PR10MB4221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:09:03 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9%9]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:09:03 +0000
Date:   Mon, 4 Jul 2022 15:08:42 +0200
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
Message-ID: <20220704150842.4e56179b@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VcoN6eekZXPK8Kpw4aaJN7jfirnUH+1Q0JTEyLSKwrB0w@mail.gmail.com>
References: <20220701091412.20718-1-henning.schild@siemens.com>
        <20220701091412.20718-2-henning.schild@siemens.com>
        <CAHp75VcoN6eekZXPK8Kpw4aaJN7jfirnUH+1Q0JTEyLSKwrB0w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbec4f2-edc1-4622-97bd-08da5dbe5e03
X-MS-TrafficTypeDiagnostic: PR3PR10MB4221:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHjSEnl5cXbvyYUP3zX5XQO9xAsRb2TfEwsA4mEhFVtHFkliTbn0IoRL51P0UXbazttye9yuvhylnPc5FzeowbtaY//7/7WttiVUYzPkdfQ7Xsm/ZiUVDgRn4TdhvWI1VB/UhU+y4zTWnDr37WotGOh+XsxhtwF97uydtksAWWO9HkCNYJq6/34mK/+t/WvRhKMEtR2kZ/fxBD7l7acg/VdIqspOoKf1rRdQc7Pd+pC0ilnYkQKsSgE5Z2PCqF+9ZsRSB/uohJUn18j9NOPVtMBXnLR1uAi2OnRLkPFYd2i1LMXlTtT4BZUkJnO1MXVzCvjuWnZBnly+JUGW7scGRQbi2Mc65HoxNFvA5kmMw1U7j09dbL+hdyKoBVnHaTE2AaV+54Hx6OdKNc2D2kB7jbvoiFc5ipHF/wvShI+E9O47EaureZoZthZBXKIKEaRlqRUtOBSW3HAoDgRqYElANilKNbAbMHmR2H8ezuoRR2zBnLQlvByGWN+KNn95xrBiu6LifA5MyBbk2fQIsIihBRs7vLDZ2H7iOeBeGf1oevaKxSKXULGCnOT6A5TdgUsJCkcE6kYl04UFWNcmt0ignNzHXx9Gt5+ekEVAdk4USH/FiVpnlmW/T+7Y05pNVwkLgg6J/KgKDWRxuXt1Nt+pa4iMAtwRhPaDXRZpftnSIsp0XJ3h16hB7cY1l+5BD4B86nHGRDOKF/VcqbeM91nq6bNS0gMpQQ+1qX70BUjoihVMGZ6nmMrIXEqWi4g75KYp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(6486002)(478600001)(26005)(4326008)(86362001)(9686003)(6512007)(6506007)(53546011)(6666004)(66946007)(316002)(66476007)(66556008)(8676002)(54906003)(41300700001)(6916009)(186003)(5660300002)(38100700002)(1076003)(83380400001)(8936002)(44832011)(82960400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgaMGpVfdGDKFAfS3nOYYnPfZmch0CZMzJ5c+6VYVZfHtUIIWzeXcdzhLsba?=
 =?us-ascii?Q?RbJBYY7LfZ+VegCrnmQGNrq4CvwphI79Gr6udJyo3BL1jgMHK/C9DEaHjgeU?=
 =?us-ascii?Q?k7htVgE04Nzcb3QLOq1RJccYcpu2cX1japGym22S9Mv50qF07eJfDuc2zFao?=
 =?us-ascii?Q?snQ6LtSo/GGy2Jk5qwDTQUC1sAre1FhrW0rMacVepj9CkFcKfXpntaXVX4w3?=
 =?us-ascii?Q?xKus+MtncWRjCR5a9joJoBdFQYOqntxtfKOEV3ImL2kVvVIrKrgtAVz1RJmh?=
 =?us-ascii?Q?nJCgDUfYb0lEMCL6yF5QG/EKRG3Z3w2mwIxP+rCohGkJlP547MuOe+hovPyW?=
 =?us-ascii?Q?FgkCBIQEKkNiUEPOYmoamrtaBqWd1KNuy2DWRN/w8mx3ForzXh8iU8sqzpGE?=
 =?us-ascii?Q?39B0aCuXzSNlCKCfzNmbE2a0ImvYAPlI0FbJbPGCbmg+Epjd7U586B1PdNFB?=
 =?us-ascii?Q?NdGK0+XGaMtdJpd1ndUj8yVOEe9jFNA45lVs8tzWnuWwiAtm4T0ZdaWcybf6?=
 =?us-ascii?Q?J/P8GCcvmaCA3udxG5qigK+v3adOLbYs/RuN01n6Xr5ff8twtpYwgtoWFVEs?=
 =?us-ascii?Q?BrcNJtq9K8O0QnCo782RblQC/1njrkXszi46Jo3N5SswD0qmNWhX1u/44HeN?=
 =?us-ascii?Q?8X4AinCQ4+mml0jK2I4LnvVII2MFT2ZA0fn/CgDTQcV/Dy0eZd4lbDupqcVt?=
 =?us-ascii?Q?MI2MmmjWWsTIaG1fzNTejJrkRWn7BrErRuLGZAIB6umtkiAdXVj+8GrN/12u?=
 =?us-ascii?Q?MofGitQ533GJONdq7wF5q+s6hBeKSOR2mtJ8qZxyp5eCKKBumlZZ+Z037BMw?=
 =?us-ascii?Q?D5ZTPPePTxwp07tJgYN4TyzeVLa0im/r8ZVUwg5+mNjdkGlKafEe7k709I5w?=
 =?us-ascii?Q?YDVqG5n3It7CJfWZQni2/0rD9/XvUFdp1TZwTB8DPngvQTV/oO9QLKa+IztS?=
 =?us-ascii?Q?Wn9B3b5su0rdIuSM2QQwZwW70bP927NOOq5smOm3vT3wtdEVFM/BHENss94k?=
 =?us-ascii?Q?vkecFB1PwXic0eS119I0ewnCCkn2Ri6pNSsYLtfpy6mPcHNpwBbREnt8M/Z+?=
 =?us-ascii?Q?VmFkQ0+I9wQ2yxqtcWkRQjF+ujaRvtlPUeC6Isn1iRXv8FzVPz1F9CsTxWVL?=
 =?us-ascii?Q?w8JnkvK4jd9NqPZ5MEInOz2WO8YOvwq2IURCPQwanKVnIeyDDZfQzeIdfASK?=
 =?us-ascii?Q?tqQ+scTAHIR9VMZF0oP1Sjw4Jj4lsHOOT9dtJfgyaU4em7U64WLqSj/BZ1zC?=
 =?us-ascii?Q?vAWHzxZbcU4LWOXy3uenS1jmy7ydzGG93403FGuUYDuQ8giDAfXa6VaIsloK?=
 =?us-ascii?Q?4pdANGbfjlLk3mUyEeZ4n6pSXSKyKRpjduYLOTVt4UI++Z4gzdC2YvM527kn?=
 =?us-ascii?Q?cL0C9qRZHwrVrnvWdK4bZVtstK7h2PqsqMcit7NwztEsthxxYjBgVyCKeOvK?=
 =?us-ascii?Q?U1kQ7b4T9nYgPZpXcggt0XENL4+bLMbgro3ZcW8oUbJpEJx2EwaKhFt/kMaw?=
 =?us-ascii?Q?F+qQ1649TWrE1uZww9lqJ3PqSCkmqN1n38EXjRorGd2bdNUlheBSB1Oz4zfD?=
 =?us-ascii?Q?+NT6tLXFb9xxOP5TQ4vsRy/mzxxm5BoyAtHsO3EZ5dkdqQpXFlYZXpZum5So?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbec4f2-edc1-4622-97bd-08da5dbe5e03
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:09:03.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8p02ck2Zfp5GR7kvtIghSlT4L8gSgv6lSS2g67EuQzRhpdjFoz0e9mnRf8E1N07LG3TelYiHzA5eJkF6WY0NjuHwlHz3VUcDQp93hIGKJrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4221
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
> 
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

I ended up doing nothing here, code did not really look simpler.

For all the other points, except for the SoBs and authorship i did
something in v2.

Henning


