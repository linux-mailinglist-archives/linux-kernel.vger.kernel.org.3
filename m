Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9D571ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiGLPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiGLPSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:18:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A2C445B;
        Tue, 12 Jul 2022 08:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIWbuO3s+EXh6GoSG0dqacGdTg+NJXXDk5jcEAAA6DzwjPPI0APmIBpDhuvmeG/Bg04tFnWXHUbxriCiTsRKzOvfYSWS96kHka5K7jMOTyL1epyAJ2EQwLTTKuChwzFx7g557TemggRHS0IazxqSwdTqkRrh7LVWkeQCQK0M499rZacJ3bT17xW2R0ZX8VBqTJ5OoayC8+ujPsK5B9H1nFETAegtIW2MQBPyRWTz2Ac776A6OTXecNEOsOwJ+7rfHLRCLiravGPudBo6lhrpdgYXAUtxQRLfPeEoxyViTypomonxs9Y5xBqabrOZawpgMuBOR34gBTnh4+exEGZ0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63+gheiCenw4mKn9UKDDuUY8lLdxPJk92XY+zM3Foqg=;
 b=J19NgzAl8rrzORoixtC2s9h4+/GGZ/6LtQF0Ljyrz8CbZfZpPdMo8n6NdZW9tMI3kGCWN3AP0rbNxdYoYFDUaWmbIMFObCrS0PvntjEGBCVtBn4IIw+z7z/1Ljm9cebbGE8qY9L/QxiwA4z/XIaUJovMdQTwOtSnIppUNKC6+MC1m0ZAn808Ar+bf/zuETYjTe9YxljxkhmCf+JGQQ+TCngT/DdUFCljQeMaLOlA46Q8j4xPD7wNbhIUcRCZgxFFRGEnzpxMYyow7FyoTn+15t/ybaLAh0OGXEwL7dTmkAVYkgVcRJN7LAkyZFJq1qKmCDjx+fD5aO2qZ45ScVUMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63+gheiCenw4mKn9UKDDuUY8lLdxPJk92XY+zM3Foqg=;
 b=MrLNAu1p/vc+EWeEyu+s62DMCk35FYdFPW5I6srgCaghXmydRQKNowkoV0Ltymgj+cZCoWwQo/frel1K1DIdn6gAsrouwqrOwcnGtoEXN+5bNN1nvXuhFO00wgCb3EalNvoSDNZnOtiJR853gDlJ1pNwU0T6XTIlq52ZuXv+KBfXtyjahV59dE4RdqMQ4uFu1W2UoFvRSyoZDswXu0zWmpWYCclnJdqpGHvxudjaIbqnWjstwtDTETxMs34w7qx6j+EjKRQtHSpjZdbsq5gqXy0Kp+bfG4773Rj1kekkH3QYT2xnWTKKNuai85q20d3H57rCY2OuLyiHtYc9CU6o9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by VI1PR10MB1615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 15:14:22 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:14:22 +0000
Date:   Tue, 12 Jul 2022 17:14:20 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
Message-ID: <20220712171420.1fae2b39@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220712143237.13992-1-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0070.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::21) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fa2965-f5bc-40b6-cb43-08da64193338
X-MS-TrafficTypeDiagnostic: VI1PR10MB1615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6sDzbpWPvKIxxl4GJBchJJI+WKfK76SCFtfOoTs0QEoHXXuhC9rjCX8P7qeGV0JMqs5wDYJk2znym6FeGVGR+K5JRXdVRsQ+G0hrXYggGx9VLw4gT65teR6mDJwlSWcJNMIshv4mBcDyUkZOVy8I33lGr5oq0ZaEP2MKmT2ytYkwUawIm/XOOaLX6zt4PxWgf+0GoMImCBZbxPvUE8Gk0R1zLLyGFEBaqe/XNMHuLcLeGWFZuCMozuAqZr+ahGXfLl44iFUYKALB1xSu9DzHTiUy6fnAM9igaBZjeF18dHNAoIHDzAdK0duH4PwL27cA7gYagwfwSGRktm4+6gPMCbY9gTS7rD0x+oRIJJwqC7LyWCQL1inuI9Slyk9QDvHuzafAS96P3mijLFcOrupjV/guDlOfXBeLEbgvGxigp4D0+MQajpcsLtgFkduHztT+mUeBGts4HQZPf8Kt2bEnr25hMaGMLQY1RDBNIytT5J/Rkq9ahFHAuqlq0c0o/ucKoAGIjmPNIquajvG0LCnan2hEgy2eY47vzStK2EZjxYrjUSb3ooMHIz8op59QWcrYaqavV2d5v4iWDijTgGjkgkLaw3fvXPcS6XISO7zxiWa1bntDmIEltqWsYZBHMeEtLqIX/glCnLfYnFljg8l+FZwHERZSKn6X16S1OP7QQDJiJUvRhEr+TP7sHv+UBri+tNLcMh7Zb6Q5foP041VgqML9MweK9F6tPNYlZG3jfTT2QWsvK4xvzgWDAEjmgMtUWakoPy3Jo3QRZ8yDqh3/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(82960400001)(66476007)(8676002)(66556008)(66946007)(186003)(1076003)(83380400001)(4326008)(6486002)(478600001)(316002)(41300700001)(54906003)(6512007)(6506007)(110136005)(26005)(86362001)(44832011)(5660300002)(2906002)(9686003)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5OmPtSIw6F6nPyexoq7AtUkI+OgtnAwUnRXmR5tXruTX97Avy7l4IRvJpac?=
 =?us-ascii?Q?xFn5RixzvkcV9cYyE8UZWLewW9zzTmunI1APp2ni4Uve+c8wKrqevLjKin6d?=
 =?us-ascii?Q?GPthJUk98hcOkpojiARq02lhM9D+KnKy7S3UsBQapXFG1sFvW0LCiQoFsiNC?=
 =?us-ascii?Q?FTYTL4CGaYphXNDUfhKdMC3Wvsd+IloJqS7VkdowPnOg03DatTGKdVOyJq4t?=
 =?us-ascii?Q?v4Cpcqm2uXYIf7DfuR8PG1VcQGC2HwLJITrv/ZhBTIoxrvGXFVG5BGVzzpnw?=
 =?us-ascii?Q?s9VIIF0CPpO92VHvHp+Rlhp6ppoWTWj2T97xx3CIPW4YAyhw6kjU2wpmMbZ7?=
 =?us-ascii?Q?9BwQD9cZLvjnQf2V5x+octYHUVK/zvvcITTXBV8HNKG/7VGnRX+6deIBJxgL?=
 =?us-ascii?Q?m5VMhiud7ig/VunFvTqkNgHLqvFt95GbpARboKRtTICAxbKnVqGXRTzNd92f?=
 =?us-ascii?Q?Qwsz7vrRywK9kqWA7fdRcDsf8jnLRHeqAQZA/YSmdrZULo61H5H8oNhMGu7U?=
 =?us-ascii?Q?74bqYgsGZ7D3O9acn5/LyxEWAmtc066Nt1ylaU27qxniHcpI4VDvcfX19HYH?=
 =?us-ascii?Q?iYV+tfuyAhnkY6t2frvi6M1R0GS5eKV83RFegbZ3Uv/Mm3nV5LuTSC6c0VrE?=
 =?us-ascii?Q?ae+7EjpbKYTxo0DsI/bJzUTJuVn10NHTlXs6b2MJ/NIAsWEMcSPzf+f4/caK?=
 =?us-ascii?Q?hmgXbvGBzlTkXb/X+efEqjRMJTV5TKDHUewX64RkZP38672LZMIBOeHQ7pym?=
 =?us-ascii?Q?7XuiVdZbT/Ndiot71Y+RCJe20paI6T0DnhEdb+IuO0pxogjE2JWfll9PVMXP?=
 =?us-ascii?Q?pZBWXjLw/I71O1tfEZa31GftHZDooGevn3IQJkOmYD+6NvoiSwyd3P4om0fH?=
 =?us-ascii?Q?hIPoh/3AVoUNFst61rQwEEeehTO0pUNkO1T6NchBocOBaspDDVNL/4XnFU1W?=
 =?us-ascii?Q?OtNXfDMkkyLjPY5t4bDg0mNhNqyN7s+Jkdu1ZYatE/0Ruhulh6JOvP+d8aNU?=
 =?us-ascii?Q?tU3KdCC2YyAPT5qddRRygJ+gBBQ64WJXRTD/OM8PuJymCk2SR5iOuKP9AHvl?=
 =?us-ascii?Q?PYfSaIk+TM96VfdRnK66v1c93U6CBZwbbV71B8p2+qHLsKBMsZYrWDjLnqyf?=
 =?us-ascii?Q?4gwi/xH3uXx5PMsgjL1TeXn2LL7/f+lS6GYUJCow2RY/YtLNJ7Hn7fkIrFMq?=
 =?us-ascii?Q?FWKj9AG53jOs8u4pgqQlWx4tE+oDoD1xYzAQ+a4DDOXU9QokcHg4Fx0NFe65?=
 =?us-ascii?Q?MtN5TtnnJKVULbNtGm5fQlH4bF1VQs+q6Q73QWh93qXwHsXtuqkzdLOjPiVb?=
 =?us-ascii?Q?DdA0+Gc9fpyc+r9HELHfJey/GtacD3arjfQtUf4d8HfT+Kl/vHNHhq1nK3zI?=
 =?us-ascii?Q?xs/frY/k2BjZ/wzQv6Ibios41RsRrnX9kxqnhGhuqWcpP0RT2cSR6HKmNmfe?=
 =?us-ascii?Q?z+88JYpOtKnESut2MupjYaCrQhJthnC5ux1v1TJkXTa9m1FU3BGibM31DyS6?=
 =?us-ascii?Q?nbYQDjaMOtDswOaESIb+xCuoDCt0UpoA4V2c+lX+4XemYcXyDvVfd1GrEtV0?=
 =?us-ascii?Q?5IajfxWiM2FxaOgXxP3sNNqqY7Ag8kIFd5AtJ6/dH6dR1n0xTYLfowLKSmk8?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa2965-f5bc-40b6-cb43-08da64193338
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:14:22.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKomoMngkYgXuVHETKIjGCa8M9FMDb5XerHLSiJst2FhtbcmAJlmr4uUU/2D6MZS3pCr1VTiCPpLCb4wwn7eLxP+cum+/Glx9dG/+gJ3uQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 12 Jul 2022 16:32:34 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v2:

 - moved Kconfig switch to correct section

>  - move from subsys_initcall to module_init
>  - add 2 more patches to show how it can be used later
>  - v2 is based on [PATCH v6 00/12] platform/x86: introduce p2sb_bar()
> helper
> 
> changes since v1:
>  - implement get_direction function
>  - style changes requested in review
> 
> This adds gpio support for several Super IO chips from Nuvoton. The
> driver was originally developed by Nuvoton and i am just contributing
> it on behalf, because other patches i will send later will require
> access to the gpios. The driver is valid on its own.
> In fact v2 of this series shows a future user, not to be merged right
> away but to show what is planned.
> 
> The driver supports several chips, of which i only managed to test one
> but did not want to drop the others.
> 
> I hope the original authors will help with the testing and addressing
> review feedback. The changes i did so far mainly are inspired by
> similar drivers and some just concern coding style. If more has to be
> done and the original authors do not jump in, we might start off with
> just that one chip i can test and add the others later on.
> 
> Henning Schild (3):
>   gpio: nct6116d: add new driver for several Nuvoton super io chips
>   leds: simatic-ipc-leds-gpio: add new model 227G
>   platform/x86: simatic-ipc: enable watchdog for 227G
> 
>  drivers/gpio/Kconfig                          |   9 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-nct6116d.c                  | 412
> ++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds-gpio.c   |
> 42 +- drivers/platform/x86/simatic-ipc.c            |   7 +-
>  .../platform_data/x86/simatic-ipc-base.h      |   1 +
>  include/linux/platform_data/x86/simatic-ipc.h |   1 +
>  7 files changed, 467 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpio/gpio-nct6116d.c
> 

