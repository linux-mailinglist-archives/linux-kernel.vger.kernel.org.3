Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82559FB06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiHXNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiHXNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:16:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16084F66A;
        Wed, 24 Aug 2022 06:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7+fh0BYhloLRY/+cHf4VqQ5xnGvTsBERR1Y2eJyujRgC2OczsL2RRT1zDxzuaXoHaInLFn84fljK3qCZOtcyNi9sYm69q5CgNO4Ojcx+Ebe41CG3eGER2AbUPMJEPLGuh36PqHTB7zubA/IDmvFLOoH7A5rT97wrnlEzjQeBibCT20TDx3hukk2p6AemQ1NCFusLLK1ca4/JgCkk/i8Vf58YnBxn3s4ZuC2zoHKskuQQ4a1jo85gFC7RDAI07WhtKG+RYDEUGaxyBKwSVjtIjcr6UFhS+gYeBwiHVSVb8jH9EfgY7e2HbFEmfZQsp5B8odhooz1VfmD66BvqPgdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c8FCHFGiHuqjWITmJiE3pFn35Y1/UH1fSJtjpPM5IE=;
 b=gcpw4Cwz9LmFJQ9EhAAJKZ01ftl2EkeuCB6ZnfGXk2rVZ8z7sHG8bLjwUgSNwakjb33dMT77raWFDvc/P1z4Vxm5dUNCwCrLKs0Ul/QpiH/bQNrhH8vshgqmVZbB7QtWljHwFqQRQqTsKi6FgFUNi2/fathMvHD7hjLFO7NVq+5EEGuUpOSCD/DRBG1j9GxjzFv8pOlvEsKLkTTG4BF9xwfRyb9xJxzC/JwZbEBmH0v3Iodvoa1IdSj1HHopKSkFOrXgj6/IEvwKY+xGRqRFClGq/wSn25oxGQ7EEPdz5vObZfhVkZF6+IaYndbcHEiObovBxjCb55C1D7jokLo/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c8FCHFGiHuqjWITmJiE3pFn35Y1/UH1fSJtjpPM5IE=;
 b=cq2+z8kocamPfig3dboLx1vk8IGFNuFdKqndQu9MEGaZns/fZtK94JTau15P8XaxjTa544C9jz998ckG7+TgkpYM1DTJtyXu7bolWCTdaI0kuyFuUJlu5T37bFcpX5xr2b/mfJd9n2z/u3SgrECXBc0IhJkUHKnovdEmcgjGel20+T8FozJHYSinwalRr45caAuZP1MaND//qTXMY0Qf/zPlWM923yyxwWoQsf/1TNZmBstIxI4uYIPn+PH8iFkrqalVOGOGRAMpsBBwmXks11iansscLOKxCAC0OOEVyjYOHjzmOscs3i0hqkfUnwOz9kJuyWAGbXVRc2xKWJ+xsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PA4PR10MB4384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 13:16:45 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 13:16:45 +0000
Date:   Wed, 24 Aug 2022 15:16:43 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20220824151643.1a021bff@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220824131428.31904-1-henning.schild@siemens.com>
References: <20220824131428.31904-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c27fa7c-029c-4f0d-11da-08da85d2e4d6
X-MS-TrafficTypeDiagnostic: PA4PR10MB4384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJL18rk2Dz23qjLr15vC8yKURIayhFaawXhuSeX9K9QL5ykNppeDitAAbuqvRhOOXIFKkvKnw4pGdmbN1JQ7Z3zH+3FFEsCSGHgCXB5num7KhwLQwN5LS3lKmgEt0hW9+pua0XNgZgsUK0mbNto6fdDBU/F2pWIxF5Jg3Z6hNzUuiao9cDDQkeG1liP3PfXF0I+Fpzs+czghzedSkKU58js7Iv98Rv0BSMFEUYnFmnDdVfb8WjGOCGGtXHlrRHmO09iXfKG1PL8kv9x8Ujk+DttEfGO6OkND9/3lPxp1lOJLu7DBtC20Owfgk4hpuaUa+IDLb5xNUgH1mEwyAvIA5Ov0AmPcr1PdZH/LfmCYvBpBZOXty0wd61ouzdT9WxXxuFXY7OPw+EvOCUURbIhbZCEp1Ki9ypMINGiC72ebdRQKy4439LHf2cThRsCWzjazyS3A71PBFEYjTjS3jFrhtroXNipyQIj4drq4BLz5e2H7FobEskb7PJN2aFErC8apGIQP0Ct1vpsQdvDIhhk93gu0tt5kXwkRQsxVpY0DgXgcTgH64nTRSa2AZV7yBBeJGyAZNY/mng7fOCo8PUe/cSBp9SJhVCFi4wdLJEc3PT3YX/+5/1lLKEj941UPz1EeSeQbqUxt5ONx/t8onQ6HJqOI1dFi/F2XuRHIrxU0hgoUK6aDAM49NmlpCKZ5jiXI51+Qj/C08nEX69CvAuO+OSpZzWonzNIm9DEP+rVT0JoNs1nz4rsG8nwRWRIlIW5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(5660300002)(66946007)(66556008)(66476007)(82960400001)(316002)(8676002)(478600001)(6506007)(6486002)(6512007)(26005)(38100700002)(41300700001)(9686003)(44832011)(8936002)(83380400001)(1076003)(186003)(110136005)(2906002)(86362001)(2101003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90QvN6P4v8wHRa9G0GYhyWan9SBPbAcPldFm06dhXM6DjC+dILSAzarXaAWu?=
 =?us-ascii?Q?xROuwWNNDHt+Yj9Hzwei2tmRZ1iWgAaCcc1XS+2XRVBzVsb7rAspY6muti8u?=
 =?us-ascii?Q?st5auXYToC1X4eel/8ceIl7i4PHVy9LjtE88WBU8PwNcUszSYhoVBWp5IfP4?=
 =?us-ascii?Q?IH0O/y7VlN3Eh/VP1az86pjl/IsPPGu/vRFeRpqSeMojq3lI5J3EGpycxOcu?=
 =?us-ascii?Q?YNQnhf1ISALWG044Jej26iwBEWrUWB8BrNYzQ4fcXZX72OFhfVoPi7P+CbeJ?=
 =?us-ascii?Q?lybyDHWBj4wFvtvu2adHHDWLFjN4xZ4jAoSN/DZokAuxbNsnaHcbq5f+N0bp?=
 =?us-ascii?Q?YBQNfxj3A3/P3qdMYEFA9Dv7HapP7PGWq9yDxO+jnEJsaTxcwopyuDs4Wxvu?=
 =?us-ascii?Q?jCu63nOCN/PIlvW+ica7TAp5dYnu3NZf0ahmAOP8pPYGI7Uc+tJ6uEE9vJnN?=
 =?us-ascii?Q?9uLspybuRl/2WTGZIPcIfbIgs6C4cnTq69sGeAQwFMNFzqtmNFd9DRmiMnt1?=
 =?us-ascii?Q?xmqna2VzOteiujRyZ4gyVp0hUEJVSVgAQ9WzSSlEYkq471sK4LGuDw3rKLI5?=
 =?us-ascii?Q?5n+zp9pWcutf//jElX64bZZDyiM300D6zZ9U/oVGinz9Lj7BVWWvxpyjoaXI?=
 =?us-ascii?Q?iLC+Czy9KRBSRXmdE5Ctcv50Qsc45V9yi4HT/2RQo1vprKJxa3BL4RPF/xYa?=
 =?us-ascii?Q?O1PmOmvpNpyHS+opgFpIKYb+p97lFM8fIvzu7DhCpFUuTE2GDDZhZl54wi9b?=
 =?us-ascii?Q?60mGQxWvgTvtriiIWQSfq37+cmN9zvc+jEcZIrUyEn0xCGj6L/KNj74Auhah?=
 =?us-ascii?Q?zGyoLf3znH0gNOVtzZIdMG3lDeMBwfH3NbDnOQu4P+FNQmER11TkYNzEpooK?=
 =?us-ascii?Q?64LIUQb1AsBMQL/+k64G5j4O7DN6PDq+HeQ0lPY1tG2sZE8HGkP5s96VJAyD?=
 =?us-ascii?Q?gfDU6G4UdMLbpavoU2zDEfwzmqqEGershr3uCxOQ/Ifq9R4oMbfxkHmyQITE?=
 =?us-ascii?Q?DRC7UCUSmNgeO8+wBP6H6CBi3IGhh1n7JnJxJDCwWM7rX/zbKrLO60rf535d?=
 =?us-ascii?Q?cIFOW6t+s7XHF31xHtCO+oR9u7weGmcVxHKZN3ElRp48P9fjlib3+JdXd0Su?=
 =?us-ascii?Q?tUBcaU87eJ8CcUlrF/YT1x/DIRkOF8PzmK4S1sPAYFnBXUCLHi5nnUg4vTPT?=
 =?us-ascii?Q?zQ3Zh8D0WO4judhKUKqVvNd8Ytqc/bnkQtwCRCTSy2cxgvip7ZtIpnNSn7TZ?=
 =?us-ascii?Q?XZZNSHQQvUu86AoMqZJHn0dlQC8g0hQLw+U81OSZuXGQFh99h2tmI+qW9Kdv?=
 =?us-ascii?Q?HYKUhQ6SyjfN5zc44BWZsCSY7FrA5jw4NNfJPvDavywEH9Y693SVrAMDA3DE?=
 =?us-ascii?Q?KITDf/zaK74CQpy8hJa15TkV8+dYj05QfK6a/GKdNQ+FUTg1rbgv+bjEupY2?=
 =?us-ascii?Q?7tmPewtUVe3ZZxP+SZvUa7QpR8rbWSl476iF36U3wGSVBfTGKsuQznomovVC?=
 =?us-ascii?Q?h7JPIS/6UEF3Jt5eEQvwJgquRpDTOLWd/9U5WGchtR2PBeBSBzkTbSfTKcT4?=
 =?us-ascii?Q?m2gwsTYCGfvnYXNYHnq1FTye/wqdrDMfDqJx/3oxkehQcck7XLu1zjVsk2KD?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c27fa7c-029c-4f0d-11da-08da85d2e4d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:16:45.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOx1cxzxr1oTTMRKcBpMZ0x0dkan+p+wpZV4JgsegQCJI6O20ZxT0oI+OUwWANI/+Q1oNit2GRcNci9WLnlslOoKluizYMhlDpmMi8MBc40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4384
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

Sending again to make sure it is not missed, also i included a "Fixes"
into the commit message. Tested on recent master, still applies.

regards,
Henning

Am Wed, 24 Aug 2022 15:14:28 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is not driver to provide that pin we will poll forever and
> also create a lot of log messages.
> 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over
> "Kconfig depends" since this way we can add support for more devices
> and GPIO backends more easily without "depends"ing on all GPIO
> backends.
> 
> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> of Siemens driver") Signed-off-by: Henning Schild
> <henning.schild@siemens.com> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> 4c9e663a90ba..0c96ba98e338 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -57,6 +57,8 @@
> static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
> struct gpio_desc *gpiod; int err;
>  
> +	if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> +		return -ENODEV;
>  	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
>  	simatic_leds_pdev = platform_device_register_resndata(NULL,
>  		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,

