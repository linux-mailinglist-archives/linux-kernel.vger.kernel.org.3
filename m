Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26004C58FB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiB0C3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 21:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0C26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 21:28:58 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140125.outbound.protection.outlook.com [40.107.14.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706F11B5CB;
        Sat, 26 Feb 2022 18:28:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYMhJ1MRALEctM1kT2vuiVd/jJ8xGVXx/vjrswsKoErs6VlG734xeVXeZEEYZD68K4qlGkWFZe+9kZELOm0SqAKEbj7Xuly6CNp4LlNEOb4Rbr9M8U7MB6Q/C4XlsYgOY8eGFoPAVDenRoUJ/QK6eKR4C1koGdEgWcctHB0Y92UfMdJwCXN2OzMGxkIHFs4f3nsYKAoZT9Tg6fzwVvLtcg/QrsIB9U+JGYAfXYD0svRdHoULSVbL4RE4oUF23BzeAJUOjqkY+cCGLVkutABNNNY6Z/Pry+Px1jpmSYkrB8qJy8rUuE/61qQXVu0QraUxUMlPRaHF2H4kIL+d6jUN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3MZbvbOxYUaM6PU79A/2yt6WxWSRjUVqyjACOK1c7Q=;
 b=IxSPjxCw+oAeayrzn9Jypr2A2qw1iiVxlTDQAxA1Cnqv4xNeZ6LtJQJJcQKTCRC1ES/HGPQJt2p0HUln7/+F2fMU5mJfPYn/7o3QekIoocf/AEveKruUR+pLe+hu5h5TObspOU9YUx1+r/oSP/5AXLh1I/maEhf/R5NmihkyEa/uY/3X4yFd2+gSC+fneDKCnjHbfXSALD4k1cTZWwPCH8QxbvG24ndyy3tGZ5dhiMH/NgMYUQ1pOFIlDbbrQk4Izl0iGwzfvIURweykFqKTHgIpuSTZRzCfM4TaO8hotUmuMQkIfyhZMz44Qv50U25LajQFIsqEEK71aaL5TipIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3MZbvbOxYUaM6PU79A/2yt6WxWSRjUVqyjACOK1c7Q=;
 b=SVgGSq3I1zcKzzauRBglRUmO0N/dF+KdMujsDupWbydICUm9rr93MJ6q2vvWC5KTGuIvLhjSeHNa677hLOJ8UNsMyDm97yY00izsQYUN1d9YY9cdvDFeswaQdg1wmNb8pDBIwmOcFvAVP8eadP/BoN0j/CMQ7M4aPqwT51RKEr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM0PR02MB4577.eurprd02.prod.outlook.com (2603:10a6:208:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Sun, 27 Feb
 2022 02:28:17 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5017.026; Sun, 27 Feb 2022
 02:28:17 +0000
Message-ID: <6df069a3-939d-21be-ed17-bc9e9d20cffc@axentia.se>
Date:   Sun, 27 Feb 2022 03:28:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0069.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::30) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a9d492-0ab3-444e-e70d-08d9f998d041
X-MS-TrafficTypeDiagnostic: AM0PR02MB4577:EE_
X-Microsoft-Antispam-PRVS: <AM0PR02MB4577F31A203D245F281373E3BC009@AM0PR02MB4577.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQUQHXXKM9gbnkRwUwRKTOgUa1bqRPRtDWhQsgN1yfKNP0rWYEsISKk3eLr2Cw9SNGHaR84RZyOxrkg8PGzwv/28Y65caRkSnDbKHuh6xExsM2DIhWpmvvaawJRRqofp6TjQrCU90Cs/bLkB7jV090vUXRtrXoqcZ+XCo0Yb+9Zc8sd39IH1OAnNDAZLuYwfpmCfIqkl8gPUB1tszugAdqLmSvJSkpGfTmuTqVxJAVIoSbbIsJO8j8kDuX0d04doATH+jUrLhRvt0RyzbNnQzc34rMm/xT7Wy6g6M7hzBwj8Jfik7ZP7GG2/PdRq2viOuUEqbfKLXN+lpPKTiuj7c9C6DQ/DyA6DfubmwxhM3c6lprSDUhsp7Qt7m1xYXQmopv/KJSJAMzsAT9Dqs3JmjpGMf8sAV4IrKKxJbSI7GcAtb12aod6e/FC2BtI+r2km72D/vpNd05LdLEZwUsyIGnyKeFXJtV+JpIZiz1BpfcWFC5rqNzufwhzyK3qCGZg7V5G+j4YJ4gKH3Dz+PqXSELChN9oHUYjbfx3Yj7RIk5TlNyUBMQz5gZ+6oCcjvU/BoD2O5hnLCUhhlmS6HzwKchBD7ASiISmucsQBN8wfANePOXXiq9BkdDLdT+Lwgt3x0hQj8I27bQawHDnhiggiYz2lYin+jh4hYwNfalBXWePmpcdcHBbClBj//3uK9IJUUIVFzCnd/7MGN7gC4ZPtpNl9idOsF79XcIb7PGcO6i0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(396003)(346002)(136003)(376002)(36916002)(31686004)(6512007)(6506007)(8676002)(66946007)(66556008)(66476007)(2616005)(83380400001)(31696002)(38100700002)(186003)(26005)(53546011)(86362001)(5660300002)(508600001)(54906003)(4326008)(36756003)(2906002)(8936002)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnF4Z0d1Q0g2SGRrWnc1UEJHVDVwa0lOT0JUNWtKSWg0WTQ4Zk5zRDd5cW9q?=
 =?utf-8?B?aXRwb21ydnVyVEJqVElXV2taUlFkWlgvQXNYTndibHU4TEZiejkrbG5USjYx?=
 =?utf-8?B?Qmw1U0xPN2QvWC9vRVpueG5KUHRJaFJMNU1rN1VmeEZzaUJyY1hCM3ovUTNj?=
 =?utf-8?B?cmdTdGp5d3lWUjNEZU0zSjJaQXBzYzc1NERETy9kV3NxYkdudDNseEtnNUtv?=
 =?utf-8?B?UXd0cWorNWR0dmlkektlK09OZTUyM1RidG0yVW9xNUk4bzQzQWd4TGE3NFFX?=
 =?utf-8?B?T0J0VTREdDlKTVp2ZUZmUkxjMFExVDVNaUYxUnd5VHNOLzhqM2g5UnVZMmlT?=
 =?utf-8?B?U1MxSm55L3F3TVg4czJRYzFadGY3d2hoK3djQVVnUmxKUlU3aXlRUmMrTUEz?=
 =?utf-8?B?NFA2N2sxb3FkdFFkZ3dCY2ErbmNxUmEvbG4xZ3ZvaVZJN2VLSnFOK1FqbFI0?=
 =?utf-8?B?YzFNUjBoTmJhcGRYZmUwdjduRUJ4UEErRm9Ra2ZBQjZjbFhGRTdraFZldVJy?=
 =?utf-8?B?djJaVEljU01Vek13YmRmWHpJWEVWRHdZQUw3T2JRK1hBb0tCK3ZQV0Q4UnV2?=
 =?utf-8?B?c1g4WHhrQlNCQkdCbFdDTDFjclFTc2R5RHRwN092OEQ5aXpWa3JLODF0WFRp?=
 =?utf-8?B?blVVaElqSWQ1UUFlM2ovbEYvRVJJdUtkUUhOemZkZDk2a1ZTT2JyZVVpcVBX?=
 =?utf-8?B?KzN5WUVkenhWSUcwODBEbThsZSt4SzZZci9JbmQybGwza1RxUi9CcUpLUGFE?=
 =?utf-8?B?L1MrMUs2NFdUMnkrSEVZejlCckt5M2wvUGRIdW0zNVVQc2hLaDRuZGkyUUFC?=
 =?utf-8?B?RnJDZ1hNY0pXUVh6cmgvZlkzSzlIUDVjdGJMQ1VMaUtIUEJENzVxakZOTUZy?=
 =?utf-8?B?dE96V1pIQklUZllSMDdhVDZIcWlxRHRta2VZYkFXOCtSMk9iam5nUHN4QXp0?=
 =?utf-8?B?eVRWeGF4NWtMRTIvU0N5cStqSzc5aUF2UzlVa0t1OUZlaG8wYTJNMWNOd2pI?=
 =?utf-8?B?bHZpY3RVaXd4eG0yU2FBRVNYZzk1VTk5M0JRcFh6OGc5QUYyNGdaL05yMTda?=
 =?utf-8?B?TnVReUJrcWZDZ2o0SldSNFZudTlmd2VxYis4dXhwZVc5VndGQnBaOG1JcjVQ?=
 =?utf-8?B?ODRiT3Bucy91QVJNbFdNNC91U1RpTG9UN0hMNWxkMEVlVVlmR3MyTzBGS2Uw?=
 =?utf-8?B?R1BXNldmbHF2MHhBNTVQNUNDdGFFSXNUdnZ4dWhMaGx4NkhFSGhrQmdjVWtG?=
 =?utf-8?B?Z09qa1pLUmtnV1RXQVVMTG5FQ29DaWhOaWJ5RlIyOHpGQTkyNzlEaTJPQVVr?=
 =?utf-8?B?c043YmVSTW1ud2RWSmFVZXdLM0Ivb0ZzVHpnQ2ZVZjVZUXRRVmxSUHJoV2dt?=
 =?utf-8?B?WVl3SXZrM2h3aVBPZ0IzdW1VNVZsdkpaamVIWVE3NjR0TDhmT1FsNCs5Kzda?=
 =?utf-8?B?Q2NBb3hNVFVZK01laHlYeU5BS0ZFOEhFbUpueU1MeGhWeHArSUlRelF3UXk5?=
 =?utf-8?B?S0JUeUtnMjVlZWRScEpQNmRtcHVvZ3NLVXdoc093VjZlTG9Pak5qY0pmN0ln?=
 =?utf-8?B?amxmaDNVcXloU01tT24xRGdKVXp4bGVZMGxJZjRadW96MVU1MHhTVHJzSFZ4?=
 =?utf-8?B?RE9OWkQ1UkVkZVM3c3dQdDFpWVRSLzhUVXppMEdBcWdHQXhFa01qWSsrR2s4?=
 =?utf-8?B?T2VyQmxTdUxGVG5zOVFXWlBzQ2EwdU1hdzE3OXRvdjV4blRrbjFJbk9kT2Fs?=
 =?utf-8?B?cTVIK1kybjFPbmZtOHI1WCtqa2x2cHc0WHVpY1p4VUl3aFRxWjZZbE9yY3k4?=
 =?utf-8?B?NGVTOGY4TGJ3R05qdzJPRjhFajVvYkpyRnpFSTJzaFI5ZEUrZGl3Wmhqc1Bu?=
 =?utf-8?B?S2dDd0o0ajJtVmtzRzBxcG01OWErdXRVbk9UZkNXazdHeW9xdnE4TTM5LzlI?=
 =?utf-8?B?blpXOWd5am1EbVJmeEpSU25kd3pCU3Zsb05McHpJYUNNbjVaeEN2dTZRaUZX?=
 =?utf-8?B?dDhlTUw4NGVuV0JjTWVJNEJIay8xNXBSSXRDYjY5UTVDVjBBbTFVenVXL01q?=
 =?utf-8?B?WU1UT3Z4cGQxNk1KS2xyNWJsa2VjT0lHeXEyaWdESmhPMGh6Z0ZvTEVzK21B?=
 =?utf-8?Q?15YA=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a9d492-0ab3-444e-e70d-08d9f998d041
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 02:28:17.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 120tVQpZpVS3QcetHemfmJrxW9lvJ3fuDrIAjruFnSBml5Ll0QRRT0LXWgK3WDJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for the late reply.

On 2022-02-02 21:44, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped depends on OF
>  drivers/iio/multiplexer/Kconfig   |  1 -
>  drivers/iio/multiplexer/iio-mux.c | 48 ++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/multiplexer/Kconfig
> index a1e1332d1206..928f424a1ed3 100644
> --- a/drivers/iio/multiplexer/Kconfig
> +++ b/drivers/iio/multiplexer/Kconfig
> @@ -9,7 +9,6 @@ menu "Multiplexers"
>  config IIO_MUX
>  	tristate "IIO multiplexer driver"
>  	select MULTIPLEXER
> -	depends on OF || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the IIO multiplexer.
>  
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index f422d44377df..e6f0fef96494 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -10,11 +10,12 @@
>  #include <linux/err.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mux/consumer.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  struct mux_ext_info_cache {
>  	char *data;
> @@ -324,37 +325,20 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  	return 0;
>  }
>  
> -/*
> - * Same as of_property_for_each_string(), but also keeps track of the
> - * index of each string.
> - */
> -#define of_property_for_each_string_index(np, propname, prop, s, i)	\
> -	for (prop = of_find_property(np, propname, NULL),		\
> -	     s = of_prop_next_string(prop, NULL),			\
> -	     i = 0;							\
> -	     s;								\
> -	     s = of_prop_next_string(prop, s),				\
> -	     i++)
> -
>  static int mux_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct iio_dev *indio_dev;
>  	struct iio_channel *parent;
>  	struct mux *mux;
> -	struct property *prop;
> -	const char *label;
> +	const char **labels;
>  	u32 state;
> +	int children, all_children;

I dislike that the pattern with one declaration per line is broken here.
There are perhaps a few too many variables, but introducing one instance
of two declarations on one line is disturbing for me.

So, with that fixed,

Acked-by: Peter Rosin <peda@axentia.se>

>  	int sizeof_ext_info;
> -	int children;
>  	int sizeof_priv;
>  	int i;
>  	int ret;
>  
> -	if (!np)
> -		return -ENODEV;
> -
>  	parent = devm_iio_channel_get(dev, "parent");
>  	if (IS_ERR(parent))
>  		return dev_err_probe(dev, PTR_ERR(parent),
> @@ -366,9 +350,21 @@ static int mux_probe(struct platform_device *pdev)
>  		sizeof_ext_info *= sizeof(*mux->ext_info);
>  	}
>  
> +	all_children = device_property_count_string_array(dev, "channels");
> +	if (all_children < 0)
> +		return all_children;
> +
> +	labels = devm_kmalloc_array(dev, all_children, sizeof(char *), GFP_KERNEL);

I'm a bit sad to see the copy of the labels array. No big deal,
but it seems inelegant. But the of_property_for_each_string_index
macro was also misplaced and therefore inelegant. My guess is
that the device properties should be fairly static and that the
copy is a waste?

So, anyway, I'm just whining here, and the labels copy is ok.

Cheers,
Peter

> +	if (!labels)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_string_array(dev, "channels", labels, all_children);
> +	if (ret < 0)
> +		return ret;
> +
>  	children = 0;
> -	of_property_for_each_string(np, "channels", prop, label) {
> -		if (*label)
> +	for (state = 0; state < all_children; state++) {
> +		if (*labels[state])
>  			children++;
>  	}
>  	if (children <= 0) {
> @@ -395,7 +391,7 @@ static int mux_probe(struct platform_device *pdev)
>  	mux->cached_state = -1;
>  
>  	mux->delay_us = 0;
> -	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
> +	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
>  
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->info = &mux_info;
> @@ -426,11 +422,11 @@ static int mux_probe(struct platform_device *pdev)
>  	}
>  
>  	i = 0;
> -	of_property_for_each_string_index(np, "channels", prop, label, state) {
> -		if (!*label)
> +	for (state = 0; state < all_children; state++) {
> +		if (!*labels[state])
>  			continue;
>  
> -		ret = mux_configure_channel(dev, mux, state, label, i++);
> +		ret = mux_configure_channel(dev, mux, state, labels[state], i++);
>  		if (ret < 0)
>  			return ret;
>  	}
