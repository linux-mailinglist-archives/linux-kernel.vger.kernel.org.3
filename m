Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA25A0AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiHYIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiHYIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:04:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3D6253;
        Thu, 25 Aug 2022 01:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4dy6wHEKMefauEMiSB9m0kESWQm2XnLrupkwO+nJvBPA3eacrLFxzlnvKZnvk9ONPOmT69ykrtfxCRBTxsO+3NlrbbHAIpy2UhZVTUaqoeOle84ISWL8RwjNEUALxDaSHZf5ghH7qjqL+8672srfD/+9zoG/UcsfQ8saybo7yHFRLc4u5YTOxfD5b2El0x8yY8oz3YMeDJYtEywtTkbXy57Qf57vcoSjn/CGiESBqErPInRbv73jfaZ9qnZlxBa9cnPQYIfIm9wcnQnlNb90sH3VEpFftMs3QLL4qzKdqlzw5SDu60L6qD/DNkY3p4maodQvNXR6SLaNLSZs49PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvOVectgxmcuijxoAx6CtEIyq/IS1hvmDIzs6ayJWxk=;
 b=Dz2IxupceecAT3f++B6uhhiIf0fA8roQDDuyU6k65IMz6ijbFY5jsWOEW3ZksWMa4/sm7vpg2yekmLcgl07YcUsE3e7eLUehgDMaKHl1c2ZA9y3Xhh9nLhmc0rXonOlVxwCgw9JTDYxUVWyHyPNTY2MjIjnhsrXfUeLtDtvCKN5wiW9XYPdtHoBR52V2jcKUbItYVnCGX93bIgibW5AsiT9p/oDSXFnoyXpD4Q2gzbS4ddVE5beVyVAa2HDvtp9aC9ZF/tCoA9t12kOi/RNd+LubYKHY9FcTmLMH4It3+sj1Irqmg5+OkUHGhlq07nuthh/BevN49+R9DBOOv57zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvOVectgxmcuijxoAx6CtEIyq/IS1hvmDIzs6ayJWxk=;
 b=R6lt+Y6D/mkLknaQBpTbzu8/8bGjXt4ilWp+rb37oyifjuMC7cbNskYHLGSV/eGFiE3gqr2YcqIAUfzUSMzS1uiBdwxeyc3K9duU+5NZYt5pGN2oxVnYO9vIk9OC9Lt+6MqCB7NOIlILIvdnB46qNur/FlroNwLzUe8ESRiFuoNcZuNxeRGV4a3vSE08h/YSIHLlcluzZ/aphoAKt9KCU8kW/Nm2lJKTXbxkngL4BrKFdWBjCSnVyyZfzq4GPOT83VUNBMxx4FYoNV3DoiYmpawW1bBCyhBqy+3DNrTSQGWlCIS2V7fx85NDyKUm1XT0/5Pjeo4tlKK8Qn3UDjArjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VE1PR10MB3421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:04:45 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:04:44 +0000
Date:   Thu, 25 Aug 2022 10:04:36 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20220825100436.30b89f3a@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75Veu5CpRcmtvKwqhwqpjSgrvw03V6k7WrO8v=+cLhABcsA@mail.gmail.com>
References: <20220824131428.31904-1-henning.schild@siemens.com>
        <CAHp75Veu5CpRcmtvKwqhwqpjSgrvw03V6k7WrO8v=+cLhABcsA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:610:74::33) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f07eb221-8cb3-4fe5-da5b-08da86707886
X-MS-TrafficTypeDiagnostic: VE1PR10MB3421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: harWU+1A/9US3tL1gF7Nri1R/ZUyKHUsZYellsAXw/BegHgNLTbWO5z3hBi7Bqzv9QN+eR4pbPCPm4clHOFXPA+aSnHnKwCoFbwAk0UFVTSV0QYdnKMCqEdUdbq/2RJEa777akUIRYfMlMSORJ/lI8mGui8ypzgj70/pAPizPf1GuHwvEuVUA6RWdcPN3i2nhkRvNUXfHDCpFWc+CM0EfOIPIuZesRPeZbJ7Egg1jN7d2JNDTen1FlOVe06n+yvJo9q3MQDMuRwXGhSR77OW9O9qGCmXfahYM1EAzFdswkofpyPD8vQ+BGQuq1ahg5m3evKHla04wOO1YYVMSPj/uuS7OTuqTr+xkOeT17QhYuu4GyIsTRU81dPAMGdEfK03xxWJC4jHOedMIaVP5+kGKIVC99DKBvNaqdyhE/QkBUx9/90ojMexkFQBdTS8OUsq+0T+uUevHf1a+gAShr5KZUT2wOJUv1f4xDtRvKmu6A+6TPaLiOfZRofuTvRcQOyumsdlWO/22xLO+4RNYESn010LK2FAJ7S+jpTYmcCuVeM1dcMgH/PCr+sW5NmK5lSLiPKZOVOeTQ5nngmq4NFunz6P0J6ZdO/8oReMozVnPa0e5NNNBbf200TghdMewkx9VuZ8Mm5HdFc+OGG3fpEgZicI4Q4ig4gqxIat3TpH0nP9IFDjkEUjWmVms3dQH1dcihMeOQm3aMHnucPeg+/pPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(6506007)(41300700001)(478600001)(9686003)(6486002)(26005)(1076003)(83380400001)(186003)(53546011)(6512007)(5660300002)(2906002)(8936002)(44832011)(316002)(54906003)(6666004)(6916009)(4326008)(8676002)(66476007)(86362001)(66556008)(38100700002)(66946007)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8GmQaPmYD0GG/FnZzITP2WiW71lxMBWPWDnyBL8WFQlRcmy5Eslvw936/lz?=
 =?us-ascii?Q?sfhYuXxVlW+DWRv1fvVcdzT6HVS3DITrO6oNiuxq5vv341Vlf1N3iicM1+20?=
 =?us-ascii?Q?0Bz8y0stZPY643dPu1rP3n2SkX3Co1JUyLyMJOrXNpoArsvu0qwXzUqW5jQA?=
 =?us-ascii?Q?meZ2uz6lA681J2SAAsXwYnczjagjPtpOAfF3rWciBtjCVSaGqV3tQ/PLjHxp?=
 =?us-ascii?Q?uZvU/4WQx9gAk22VaZAdcTz29D0gQN01Cm77Ylr9XgKv5+2i/+w5tY7Nw7bB?=
 =?us-ascii?Q?hwXzzbJgEpuCKE4/D2FuaBINrq0xyuXA3tjemNHMtCCBMyC+Eufb96vlecUc?=
 =?us-ascii?Q?7Oht7o8d2QakZj3AjU6vm/tXgOjSnav4gjm33RklbNprD5KquNMMSpw/uNm0?=
 =?us-ascii?Q?eA4vv27/eD6NDaXYCSdm/kZommdWtdTMVvZvK+1PITaHniYtt0u5+O41Cglq?=
 =?us-ascii?Q?uw+GYTDN2gzMmPcnOdMtfi51FJ6TRRJWB9ylwncAlyM8z+CvtZeKNir4pCqB?=
 =?us-ascii?Q?pkCP/7WzEXr81aKT7MzfkeUD8TxbShMddwy8Bq2El+GOPGmHuy7IItIJ25yi?=
 =?us-ascii?Q?unyhzLIw50Fl1/w/KTbYf0cCXSk8nVO+2IuO1RFHzlx67HRgLgWbA0MW3kup?=
 =?us-ascii?Q?c/oMXEyEe7b4T4sHnd2ME41LfeMypkloYNx4qoEVI91k68DuHIbzLhFHRcmZ?=
 =?us-ascii?Q?HQ4Bo/T5KwK13dXXROELsMIyS0YQLx7NUmfxvrfWQBuPExJW7aCccI+Agalr?=
 =?us-ascii?Q?zBi78AY/kclhnGltbZdh6OaV3zaTZvaOP7yNCcKTcENU2sqWu6TTB04ua6Ki?=
 =?us-ascii?Q?dZXv2tJYyFCn8fxDljMEINuwJRrNtDA13JJlYKGoJq7h+gLIda3FP0Ysk5yY?=
 =?us-ascii?Q?cPEjoI6ExmR4kC2rmV0PbCap1THIhPhmkWx5+9ayhR0FgIHNu2GAyZINZs9N?=
 =?us-ascii?Q?iD9HL9iPXLhqYd7WjsfGmRaGzjAOs36rDjGvlQRIj40Nh00TONi/MLO23zFn?=
 =?us-ascii?Q?luAPN4qnbCdUuU3XP+Vdw/BBCKAFZx3XcA2aTQDtaDWbDub75ucxJ1SNvUJj?=
 =?us-ascii?Q?j4y6TpeqsocKvomDHB8vP9Nn6bsd8QPmZhmGYf38FT9icMCGJzykuicEewRo?=
 =?us-ascii?Q?Zdn/1hHyOwgklQEDy4U76Nk2dAksd3moXTFLZnia7qmJW9HziK4c8PShSGGH?=
 =?us-ascii?Q?n3GiNm8KTC+t2pnuKwftV+xLWtM6TDjRZOldVmAMjbueEWnVFIR04YBMhvJn?=
 =?us-ascii?Q?jPMNIYgD71eop+zmXPnsJm2S2f+7+NfTaScATOPxzWnyLIHjxIChg6AgntAF?=
 =?us-ascii?Q?ZAJYZahUpvgk+t+uLUMZA0TZplfC5VAgxr8kbcFwITlEpbgtdqLWMYqZ2UEk?=
 =?us-ascii?Q?0VWPERdmh+aHlX3iDWXaVJLAwzZyB60sZQKfxQJZxnGuv/LNGEqyb3Z8QR1W?=
 =?us-ascii?Q?0ekqiCkuxdM1UO4kHl3FaWbI2eQqvp8IiixNJzSbzEGuoqYrZBEN2kSiDIvX?=
 =?us-ascii?Q?hTKzsIvOuDXAeHXn/7C5Zj6oh9okdf7mATIjC9LTYDcRkSj26gTXoVU8cYds?=
 =?us-ascii?Q?RqJYd/F7NznowmesQm2BWEDoBV2x50cQk+IoNRZpbyE9ZlOvstRIUVa1QaDJ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07eb221-8cb3-4fe5-da5b-08da86707886
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:04:44.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8c/rbp8vvQjIzL0LRRZS2E2bKDydV+z1DmCT9ss3sgWGRSXUjzY2ekOa4+2/kneXi2rsuFjuSBZt351H41LrAEf8KBODV3Q+qw6WfMOqcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 24 Aug 2022 18:53:49 +0300
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Wed, Aug 24, 2022 at 4:27 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > If we register a "leds-gpio" platform device for GPIO pins that do
> > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > later. If there is not driver to provide that pin we will poll
> > forever and also  
> 
> not --> no
> 
> > create a lot of log messages.
> >
> > So check if that GPIO driver is configured, if so it will come up
> > eventually. If not we exit our probe function early and do not even
> >  
> 
> not, we
> 
> > bother registering the "leds-gpio". This method was chosen over
> > "Kconfig depends" since this way we can add support for more
> > devices and GPIO backends more easily without "depends"ing on all
> > GPIO backends.  
> 
> "depends":ing
> 
> The code is fine from my perspective,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> thanks!

Thank you! Typos fixed and tag added in v3.

Henning

> 
> > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > of Siemens driver") Signed-off-by: Henning Schild
> > <henning.schild@siemens.com> ---
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> > 4c9e663a90ba..0c96ba98e338 100644 ---
> > a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -57,6 +57,8 @@
> > static int simatic_ipc_leds_gpio_probe(struct platform_device
> > *pdev) struct gpio_desc *gpiod; int err;
> >
> > +       if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> > +               return -ENODEV;
> >         gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
> >         simatic_leds_pdev = platform_device_register_resndata(NULL,
> >                 "leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
> > --
> > 2.35.1
> >  
> 
> 

