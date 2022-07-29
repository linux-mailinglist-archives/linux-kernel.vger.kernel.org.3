Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BF584C72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiG2HQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiG2HQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:16:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392394F644;
        Fri, 29 Jul 2022 00:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAlkSo1EoRpf0rT/fkhCjxsfHLy7kZ1ze+Ax+4qmLjB4IzVjHALrNheUtLdCIEdrp1H6NIcngubyIlTNhdXTktUDo43vwhiaSqDArh736Bpyne4e44npxePIz9jALJ/JkDNVUGF9suMwQgAiSFRrAdMaRbwjhuG0psDQp8XkcEPaUH441efwdFemPglWj6s+UOpfIOLC/piqBcljsPNYkrEl0FUQTznsIVI1kLGfBfPp5SkoHuNeBrGvAdDDf/QeZ0EPWX8Gujh3P2zzdiGCUgQz4F4l20o8ULPZlj6tvy0AvFQlvye27WR53rZ9nd/XczfMHYoS8MgAiOwI4Yb83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXTObE7f7xdsnNLlw1IYg/SYuoNyVH32xIoNzI7qSvE=;
 b=mFB5pGVjwT4Tb1MJDknnCG8+2TNvRcl64tM89Gpj24EH+blZZAJ98yF/HBfkLOWeym9E6PtwR6T/F0FuzmMQxWynKOGlVOgQTYglVAxZBUQ+7aE77e9eHa43BoPgQceqEwAziAfvc+4QdhpWSTciMVkJ3er41epFXsK73bQvugn42BlLq3pLB1KlvkIeRTAeCf6s+azzF+hN2DsPC8Vc2wZ00gz69jX7hMthAF8oGWbFKqTzDqnXtIDxuLA7fMzaWyFtOdofsf6UkmdsIt2EH9NwDp03WadVJL6B+UEllO6dXdewCEKd4WPOjpjfW8BcwePBaIO1yvPYklfyRojKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXTObE7f7xdsnNLlw1IYg/SYuoNyVH32xIoNzI7qSvE=;
 b=E9qM+UsVVQUhbJbHeD0pvbdXdTFnjgrTU5OBQHX6mUbOrJ2BXx/5hn+Ghr51P9gnUt4eHh7VkPv9EvWQL0QxVvsYtvdhRVS6UvLvyLiGtWdM+0Wh8SHLHek1bLS8217dEdaSQSCyOErATxCturB/NAhwlblVH61BwH55zVrslXODeOHOVvDr2QTitqT1DS3cn3RiL/JoUW4WqeLS+78g/VvA0mQbNtiaz2J6ks6d0r5tZe3h3ECA8XSlz4RrrY4DrJ3/JWqQ/p603NWo9iWaayDmWQnomU5i6fdLwqs27o3yPpSm0QZgKGCkJJMKQMTVOSxs6mF8nsWfktiSqyx2Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB5572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 07:16:11 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 07:16:10 +0000
Date:   Fri, 29 Jul 2022 09:16:06 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <20220729091606.1205dcdf@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VcOHxJDBpnLrMQOWRED-WfJebRrYPtJZ35-8_B6wHAi1w@mail.gmail.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
        <20220728155652.29516-2-henning.schild@siemens.com>
        <CAHp75VcOHxJDBpnLrMQOWRED-WfJebRrYPtJZ35-8_B6wHAi1w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0107.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::48) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c3e5ad-980e-4ad0-b431-08da713236b9
X-MS-TrafficTypeDiagnostic: DB9PR10MB5572:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15Ndw2Z+UppwbbkQ3Cv9oCm6SbQY1oc3o21If1gjHHw8GjL3taEbe8JN3Va6YdP20p91vtiY10vIyeHKiyuNEqbrXn9ZQ/Qh4jxu8J34oZRNZpV5rEDpSxDZCqZDaZnpo7GdVtKFqJ9UaXEwuqeb1oH2jszVy20Hdf1Ffv+JVdaLxhX46rPJCx0dJg/CVoHAgC2ihH80UGHVZYBleU2MI0Y4NcUkgNm9RI9jfl0V72u149fkwKFIrCmOxJCzAiKe55h0vKgmEXD9PBYhvmvkq7Dus8fr4Z1HRyGr3PjlN8Ivb56fhT4J0BFdQLR+hkVRe8XQTzOEUFDqkJDUnsC0Q/7wAnVZEnTJrxLXYw170IiU8Up1Tl/r1gS8SXmZGAwsy7mTAt3S3Zl9zNVww9pe0mnBOnx5KyyOyMAlpXNPdkhlqgzRP4U5wI9aU7P6ICBd0MGMeNc6kLrSKQWN8GfnI/F627rGmy/oXaSwvvr8NOmNtoV2P7KwOohSiTe0ampMJWFV89MuprBxvMCGjvJUZBQ/V2PHk+TXgtIQB/Qi/C5kIF026vDRrwohlG7SyyEJMpuRcQcqmd4Kx3i/LMTS+BHVVI0cd6txAC6l5U9SMuomE8uO8KFWkfzFiGG3cVG5PkTJf7C1sqLLCZCrGjU/xKCJURqPJbOgIsMxmX4348LpCPsra2BqMT//GuvyWFXnFJHx85pxdyq4/1Bi3qfc03fzegHOZpEgzm7L8YQ8jqQ63iYuKsyjQqcwJPDM4p6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(6486002)(6916009)(8936002)(478600001)(66556008)(8676002)(66946007)(4326008)(5660300002)(44832011)(316002)(54906003)(9686003)(6512007)(86362001)(1076003)(186003)(6666004)(41300700001)(66476007)(6506007)(2906002)(53546011)(82960400001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAnxIi7H1uAN7J4pqxkENx3LfDHtqGwqSf6cGkOAyR29EwZhXmib4wdQgxSE?=
 =?us-ascii?Q?6JxaUp2xdgYLQkMgBMEb/mCP0NwKiiXIRVVrit3d6esTY+NhIYtQhl9eACoE?=
 =?us-ascii?Q?4L79E2igo7056BG3gnNS2s9sxTleZRVL8qWGWuDQ7R9wueqYAILj/WXT0fMe?=
 =?us-ascii?Q?OuyNqTP/Y020cSEQ2/oOQl+Y/bI+otnWTmGnvjHFkT1KeU2JBS3DdJ0WvqJu?=
 =?us-ascii?Q?fLcOG/NJIwxe21B3+5l3e8bo187U7lpq0r5ZY4EOzSp3vcMSm+04pw/ndnq/?=
 =?us-ascii?Q?deh+MAxqRQ/nBtPpoT5i6SIMM/LHjvHkOC4w4rSavxUQvpqjev1SBBUE3VLF?=
 =?us-ascii?Q?NwTNHDVlLnswwo5VDsfIpkwgLy3GoG32LsxMg8cD5YUoQHtH/ACTC3Pt8+3g?=
 =?us-ascii?Q?eWxxPVVZM8bR+rU7sr/Lz+AbI68Hjzjw1Yc8PJPoup/cqFgWKdhgw1eAGatd?=
 =?us-ascii?Q?i7urGv3+T8dv+/9BNJxwsbMXri5ksquwH1x/XuwtSRJ2RmfG1d+O17RL8yrq?=
 =?us-ascii?Q?nbVbIkG5Gry8Yx23FhRxwjzQexQwk89NXaTO1xT2EmTenqlHD7OTnShlggx7?=
 =?us-ascii?Q?6PuRdqWSQPfXq3maaL8H3MfjQj+cMzkxzEc+h9m0Q2uekjHnecN75N2OSglg?=
 =?us-ascii?Q?LhLB3O8oQOWzsURzyvYydbhvDR1dvL1Oh3JXNF0Ye7n1ytnpAo6dgyFJlvLe?=
 =?us-ascii?Q?GAtg55MT9J3klXXJ2Xcde/jbjiC/R7qHOPqwk1A6cTiUJACkUtfOzmtjcfNk?=
 =?us-ascii?Q?AnQOaDQrRnW5mRy+qWSNJjFCBoT3eUWGnbUVOSpdwwtdceYQgqRdUVdZy65d?=
 =?us-ascii?Q?GrCyB1Jrhx/wIKu0PuIfAAWEvQt0CohrUu2DrCiYUPJTaiVrdGcLXN3Ho3P+?=
 =?us-ascii?Q?VkcKKkWrdwzxMXJ/LggPEMam2N7FVklZFz086NIJ4qti8+NSK3vzYeU8klAv?=
 =?us-ascii?Q?70toVuo8KTJIozf2IT6uA3Nf3JibJSF0kYCmm0CshIDCKGWdBJ16/9L2f95D?=
 =?us-ascii?Q?plUEsjSni7HHs5h5WDY6c0oRXvlgfE2vd3qIOJN1+Qb0llj4EeetQQMlNvyM?=
 =?us-ascii?Q?PjSpNpgdyHeMK0NhnuXsGBZxKcjax+v/r6dEFe1ugbCotcwNXyOG+ZKgFlNV?=
 =?us-ascii?Q?+Gt3jOJucHj5ys+N1axC9V8PZTNvK2o/k40C+2+51Z7piJ693EZBkg+NwTs5?=
 =?us-ascii?Q?q6aE/WUD8RN6kF10kIC2UhmxP7Qdw+SnluTxlAlz9qJr6Ggd7rfqzYbYSdw1?=
 =?us-ascii?Q?5pl+MT5zJrzi9mXtWwZNSAf5L9PdCQ9Q7x7FEiRdTjcuRNj0DlVibKXU5KyU?=
 =?us-ascii?Q?P7KzN/qQlQcwbcHPi1Fnn9jHPYXYICHybf12yjRWBy70lkig+sJH2GfTjOzV?=
 =?us-ascii?Q?vstzco3I5MKGpbNIsgxsxQoEF8yFhic0vA3E7zdr4x/FNLKJ1UYT2AGICqrB?=
 =?us-ascii?Q?FPftSlBHV70E9aUATBT/DgxMkDa38kfQ6zWVTUKH8M5Ern6oIgxGUeA6yMbF?=
 =?us-ascii?Q?D6+5jvQXcuql/WJYvPZZ4pn6XL4AhALjDHTTp27Sj449KpKUNGlUvK8Atei1?=
 =?us-ascii?Q?fA2doCfp65uJysmL/O2ybA7QGEdvC54K7XZ+YeHcwLrRZ1fsKdeBiyy1FMaW?=
 =?us-ascii?Q?VV2u1vtOSzgkqen8IuB1gEBOQTilRG4UGs4N462AoOi1O6d3jIorDxmgDE+8?=
 =?us-ascii?Q?0dr2Fw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c3e5ad-980e-4ad0-b431-08da713236b9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 07:16:10.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYmoBD0Cl8vTS2HuE+qITNN2MCw9Vr8i7O8/2eMAokPm4TgR/x2stN95WziB2wLv8ZIYU7rH0XHxELFoh+d5NtxLvmEFgxqufuJxl/5eods=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 28 Jul 2022 23:33:36 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Thu, Jul 28, 2022 at 5:57 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > very similar to the ones from Fintek. In other subsystems they also
> > share drivers and are called a family of drivers.
> >
> > For the GPIO subsystem the only difference is that the direction
> > bit is reversed and that there is only one data bit per pin. On the
> > SuperIO level the logical device is another one.  
> 
> ...
> 
> > +#define SIO_GPIO_ENABLE                0x30    /* GPIO enable */  
> 
> I don't see how it's being utilized... (But okay, it might be good to
> have as a hint for a reader who has no access to the documentation).

Good catch. That is a leftover from code that turned out to be not
needed. Will drop.

> ...
> 
> > +       if (sio->device == SIO_LD_GPIO_NUVOTON) {  
> 
> Everywhere else you use `device == SIO_LD_GPIO_FINTEK`, perhaps here
> for consistency? However, I would rather see a field that clearly
> states that it's an inverted value. Then you can use
> 
>   if (sio->dir_inv)
>     ...do something...

Good idea, will look into that. Given we talk about a family of chips
there might be more vendor ids that should be mapped onto "inv" in the
future.

Henning

> > +               if (dir & BIT(offset))
> > +                       return GPIO_LINE_DIRECTION_IN;
> > +
> > +               return GPIO_LINE_DIRECTION_OUT;
> > +       }
> > +
> > +       if (dir & BIT(offset))
> >                 return GPIO_LINE_DIRECTION_OUT;
> >
> >         return GPIO_LINE_DIRECTION_IN;  
> 

