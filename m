Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F7584C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiG2HFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiG2HFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:05:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0781B09;
        Fri, 29 Jul 2022 00:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1AQRtkIsrVfV9CCCSXlU5ChYrItYY5RqHObqwlUXHmBohLIjoB9JiqYnIVmfebIwkDnN/HEPiztZX3/JhRhfXzu+6PGZd7TaVd7SJrRzunaevC/3fwosXhDJDoE0rot5vtuSNtIQiLt+7tOl9/V3ZOTK+CyD7mOASpCum9ByV86ryUmBO/4jO9BX6aoZ8VXuef9SQYBxhx24Z5G/bAe7vf4yaS9TtTh/mrO18qlwwGYIFgLjKWn3BZjWlG0oufupI6o26MkuYIwrqp4gDBf62LWpoDgFWruMzv1B3vkPPAAViB1eQgsmVHD5CrRQg/L3Z2WmURxYwVuBOnchBpfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq2JK0KdPizvEHwBLQgknxSPPJY3cUEgIdz8VZmxPD8=;
 b=Oj9BH37q73/ccWwTiZOEVR5E73opLdeJ7m3CLOU2zue7KQexoyY4gYd2tyuX+0FK8yk+TgESMYoFpYDiso0VLER+kWaP65q4zDxtV1IkQ6dB2e4swA13XOTxVokLxnanQXC1zkClO/PUTf+Z+hQrBWEgnZEIo6SDmvq7P4CmBxY7GAgnYfZr9RkTxirnPQ/+e/E40zHiEsxasxmy8Z/FUBCL9G2GQvB0rBxf/qeSUCNM5RiQJJeVu1hjQfkT7qPlVod5TLVQ0Uw6AWLk2QaQ7bshU+Gxo4u6oj8auxP23vKjuGf2O1MvKhx5r4DLeKvoX0YiLTq0CMXEfLoR8JauYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq2JK0KdPizvEHwBLQgknxSPPJY3cUEgIdz8VZmxPD8=;
 b=Vsjm4YYJbPlMsWizdJJwVlqDZNjMVSbrB7/e3PhmYyjShEtJJKAy+B+5CjQr9XJZaVVvs8Bh655oesmAcbQtCFtnDP5UkoO2PISpMnIf910UylXy9uX1lEUagp4xHuKADvvxAA8TsInS5T0QBQHX89R/cz2YWMjqxS2KI0Ijffxp6XvRxYj3pnepiZ9MjuTK+Rvic81552VtuH7Js1HTQzJlu8pS4ssfQKdY6MkDLoGilJ6uej59cLVhYEh8Gr7ehKzC8JhBeUqNz+1vRHy01k1wZa9YjNXdVdyOZNOlnH01OkByM2LBYMlMJun/ehkpjqxztmdC8THpM+bJt9+0lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB2843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 07:04:42 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 07:04:42 +0000
Date:   Fri, 29 Jul 2022 09:04:31 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>
Subject: Re: [PATCH 3/4] leds: simatic-ipc-leds-gpio: add new model 227G
Message-ID: <20220729090431.565ed505@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VehvE1cN9kMAhkuRrgek9Tt9OExpYnkPYNqocGPEG6Tew@mail.gmail.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
        <20220728155652.29516-4-henning.schild@siemens.com>
        <CAHp75VehvE1cN9kMAhkuRrgek9Tt9OExpYnkPYNqocGPEG6Tew@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:610:5b::22) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374f4df0-8a02-4410-854b-08da71309c0e
X-MS-TrafficTypeDiagnostic: DB8PR10MB2843:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xL2HS+JUESdOGDJ+TF1IMIJH29vMtDwwSQpfLW1QWuXT3EF2VQYNX+yAGK0vK6EaGlBMi0M4dktwpeharXdyK5DTeVFg6JycTbyw8JUvMrQauWOl8Na6/W1DNSj9Axi2Iwf63XjakllOsAd3RfwEYA/tvykPaj6eJMQBbLbZxjJlS0dv32jsjd0LtfnZu5eddz5Yxu39e9zxAh/ZCOTDDamLpk2vxm/0XUc0D74+XS38vUBuiwKGrq9GQI2A/K2PT0esVNccb46ovs/lek9y1CDsin71oZOqxfDeoQDFDt+li2+zZKTFKIHKGETTCfX8lnex8s5H23g23w6dxgGQ3/gvdiPCmMVbuepIZcWqbFN0QSolOIsIrf5ygoJTc7FF09CNQac3qJEu6pbQor5G0K8kaY8fRSLQwBegc+zhS1b3frh6jfXz774gGuYNrziq4GQ+geH2w8NJRdZryUi23sAYs1Fi/QDE748ySW3y8NxGw3UKxbgYTKj+3hEj7/9FYGMTjA5VRibD076UAALrTsgkemh8l4HHhvuQTD1ps4Pa6OuclubIe5NTAzMw/zMa0Y2WD5BklsCc6Vw2a5P/0CYD5OpyxCy/0ANlab91DZ0HW9NBQ7fehxgpVRNBEfuiekQClgfqsPMl6BJnJQkAtzyEGzVv7dFyhZDFhtVoHaNQWKOFD+oDtnFEXD3AzVVbDaS+OuhiIXeZGsyKI6mZTxRMqDIBW8Xl0SXDWJ9cvmkaXEYvuGvNlNT/Ybc/g2x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(110136005)(316002)(478600001)(54906003)(1076003)(44832011)(6486002)(2906002)(186003)(8936002)(5660300002)(66556008)(4326008)(8676002)(38100700002)(83380400001)(66476007)(41300700001)(82960400001)(66946007)(6666004)(53546011)(9686003)(86362001)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g40vreZQe/f2UBJFW0G+n2Ps7QEZMgJFDlk1gAvuGfv0xoRyoVdVjDp+u6wG?=
 =?us-ascii?Q?kv5LOKFX3xMgY0REBNsuV3h2ykZ7wqb2DZ7NJrnKXBbNyQPFBuo2B87MI5Hu?=
 =?us-ascii?Q?s4HnbAP5HhYCpgHS+b9Z0B32HO45M09GMCrXFdi5J/x7X5TYVg6gLAtITWFP?=
 =?us-ascii?Q?K5oJhFGitRT2MjPuZCAv1hAT2irNo4Dk4xvrZUX5c3YcxmWKx2m7IqWp/iBE?=
 =?us-ascii?Q?8ZG3nNgBQWGNbUhPfXF6LhTIBQquwm5HkavcuTuSAsfZ9hsR8gNQCmJp08k6?=
 =?us-ascii?Q?CycwdRE8j+RFkknDeo0sJRquui3FQcIHXM1GmH1wdkkkvwEHZjenS9QCsmPd?=
 =?us-ascii?Q?thoaUuDBB+2jcpP3bmFp7qkhrLwMeS7mQHKv1BlaaEtP+nf1i74Xqw3FJ/Ze?=
 =?us-ascii?Q?pDvVmStT2V5LbY7gFJI1J8nmGGJAK1sTRoYDDtSu6MFw5MPwhNEV60+S9hPL?=
 =?us-ascii?Q?VN/pPPD2hzL+c8dKa5Xxntm6hnXFJW0uZgqWPGF7cGa6jYMH6tSFz5cFn0Z6?=
 =?us-ascii?Q?Dl/Wrf+kCaw4s49ptZVG4ckXC8OLP5rLcGeTQJsSaAgzfqYXhXLZaSQ1jIoP?=
 =?us-ascii?Q?1E057NC+66PSobr0GEhIqwgRrAU//nEcWILQv575NGHYcyjNEg1hCmaBodBV?=
 =?us-ascii?Q?MrOojd+u44L+X4oROhaFXW0vPOONCMEFVpKMPPHpCe9irLLOzW4KvQPodDoU?=
 =?us-ascii?Q?HHq0H+EPBfMgWe5tL9+rhezbP14g3uGpmbMqJNELY3M0XQlhVXhs6jmnBvid?=
 =?us-ascii?Q?Qf18zJ0ueaRfrPEUsA8w/yBOQ6Z3fUbiKn2CSiT9R8Zs+pooBRhdAvpdzj/i?=
 =?us-ascii?Q?JHYUvHoHYlZ1tYjZJ90Wp1XLptqH2Q9x+MJ91I0Ud702xfjMy5FuZaNxwlr5?=
 =?us-ascii?Q?9da6e0X6/6bpH4CL3/1pSNKLeoOj4hgHL8dWX7hxmGSZuCEpkidNkQB47HkG?=
 =?us-ascii?Q?c1LNoW57Emipf1XMZUW0iLlE2KpCGZ16qEli0/PELZgdHQPwpddMd02GCjvf?=
 =?us-ascii?Q?bjboNb0VLO4D0LUvqTqTXC8PbFBOpkb7SScCl+LMuPzKGFT7POWm/4ezJ3bA?=
 =?us-ascii?Q?cHpH5mNAov0r5eHlr6vteMBsIcgIl6nvwgGscwv1HTTVAJRRTF3sGgkkdp1m?=
 =?us-ascii?Q?w+7KWRuTCJUn/HzbzeX6MIsB/MfBxyqd1KXIq7as5Hhsqkn9UMWAawVKbCEf?=
 =?us-ascii?Q?BS84QbnmxxFNq/Z6wzknLmO0kc1xIAxgj1qt8c7bVE/e0FUv8t/9eHxV3yfG?=
 =?us-ascii?Q?/iYWNI/dNEwIEuWhVAVEjE21ceCeElYEc21cWVts2cApFEDA0D3LnLdfynzr?=
 =?us-ascii?Q?1QR0gkqumCgoANuHzV5qRwszgB3giydJ6LDw3/0DgB8bi50lfSaaEL1MpSff?=
 =?us-ascii?Q?sCJ2g5kOoRsXMIKo7mtwDMnFnn5dBai31e0e0AmO/008Mu/ThEgOmQn4x5NW?=
 =?us-ascii?Q?ZX4AsGVbKLAENRdbnsJ6I4J+fpgCP/rHwxHlbdHWKpH4PZpz7w3t5Ly80lzP?=
 =?us-ascii?Q?NgIXDRzQBJfBD6rvxE3EYfK6fST8fLKBF6kac7CaFPxoBoXPpHSvTF2gu0BW?=
 =?us-ascii?Q?/ydehopPT0AxP9/6joOsty+tBrSbGDDrB2uSwrLYXastZqTWaM/1yv/YTYQ8?=
 =?us-ascii?Q?Tu4pAExs5gYk76VQnSn52d3au7r/dLPyjWFY5u9G79lmIvA3s9vyVHwxCGAM?=
 =?us-ascii?Q?5MeF2w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f4df0-8a02-4410-854b-08da71309c0e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 07:04:42.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjCyoBvDobGwLava1d4x/+40nINIP+RiZcBZsUW2y4mtDpYor/isM1PP+35MSNtzRGMZoh/w6iu649AEb8MZ6zOTLMesjNX4koYYU4O4oq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 28 Jul 2022 23:41:31 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Thu, Jul 28, 2022 at 5:57 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > This adds support of the Siemens Simatic IPC227G. Its LEDs are
> > connected to GPIO pins provided by the gpio-f7188x module. We make
> > sure that gets loaded, if not enabled in the kernel config no LED
> > support will be available.  
> 
> ...
> 
> > +       switch (plat->devmode) {
> > +       case SIMATIC_IPC_DEVICE_127E:
> > +               simatic_ipc_led_gpio_table =
> > &simatic_ipc_led_gpio_table_127e;
> > +               break;
> > +       case SIMATIC_IPC_DEVICE_227G:  
> 
> > +               if (!IS_ENABLED(CONFIG_GPIO_F7188X))
> > +                       return -ENODEV;  
> 
> Hmm... What is the difference with the 127E model in the sense of the
> driver absence? Why do we need this check?

What happens when the GPIO_LOOKUP_IDX does not find anything is an
endless printing of all missing lookups, actually pretty frequently so
that the kernel log becomes useless. I did not look deeper but i guess
"leds-gpio" will go into some sort of polling and wait for those pins.

The debian configured kernels i used so far for my work always had
PINCTRL_BROXTON, i guess if that was not available i would end up in
the polling/printing loop as well. I never tried without, just found
that polling thing when working on this model.

In fact the 127E will likely also need to check for PINCTRL_BROXTON
somehow. Or maybe the "leds-gpio" platform device needs to be
registered in a way where it will not go into polling/printing. I will
study the code to see if there is a way to go without polling but then
i might need some sort of serialization so i go not try and
register+fail before those pins exist.

Pavel maybe you have an idea what to do here.

> > +               request_module("gpio-f7188x");  
> 
> I'm not sure why you need request_module().

The difference to "pinctrl-broxton" is that it comes up on its own
because it has autoloading support. And this one only probes on
=m + modprobe or =y.

Henning

> > +               simatic_ipc_led_gpio_table =
> > &simatic_ipc_led_gpio_table_227g;
> > +               break;
> > +       default:
> > +               return -ENODEV;
> > +       }  
> 

