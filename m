Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819857D6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGUWQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGUWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:16:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150114.outbound.protection.outlook.com [40.107.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6930B57;
        Thu, 21 Jul 2022 15:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqk7m+sRSbHJZrH6/2fmeRxI4qhY+KRzTJ37oh3JzwwEZZeM4Cws0vECMCxH9YdG8PN52BoNxFzDfzPr+HIouY+606c6q9rLT5/SPVIUT9JmkQR6kz790pD4rRoWHZa9Pd4o4PE9wdYWg8Ykg6+KE68901vp4GYgPc/yz9AgGX9euPPWQ0YRHvS0aDnf7S1e2UQkzjJNZQeYP/0vcfrHz0RNFVR6WmWW9HAUtd8Sn+/fg3KWRnskkn6LAw++1YSIna04ap8WiOOS48GBW2dh3SW7JWr69LZpOsvWu30THiJeL7VSeq9MeF4HArSTscuEjRE9LzhCxbB3pIe5BVhIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcKvKtjMKq3AVFMW1LDXTIdaqaDoKT8Nkke6JDMlEnI=;
 b=gc9eJxIc6dlFtFtZKbI4o9MZpjjZBckAfP1CU8WteAHQXoyHVjHX6W8U5Zd8N6TMjygC89tErg32n52GCqwD7RxdoVVh9RQ/OjJT9mYPVCjpnIYWoRIydK0jQYHC3rGOqfYDcRRpxzYSde+hYotJM7qVKa1BaiywdCAdF4V7B9etIC9DOxq0/br/yiYTnSUJ2yoa9wJVLSI3nrIser1IhPTh7x2KsytnUaO+4SdV6XM8QZwnL0A/BYshZwgCJ34dF23jangIV6luvqCFBhvDg6/a60p434UhrrSbYq5IVnDAbCq2PAQ7cAO0pI5Tsv2zUQLxXKhBDlZXbG2ZVvK++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcKvKtjMKq3AVFMW1LDXTIdaqaDoKT8Nkke6JDMlEnI=;
 b=YbSvgDoQ5okLIF8Ca4XkzJ8SG2btpjJ6EQ7olqNvskDscdB//rOQ6N6iksZfo3vmCjc0uefxH15rGEkz8TdOIp1pWfwNNew30I2jebKOaGzTTWX05Dw5U9C27Z+SE7dFWuZiwVIVpNouSp+k+DTWyJKp4uJSQdHbZ884N39blJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by DB9PR02MB6539.eurprd02.prod.outlook.com (2603:10a6:10:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 22:16:17 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::1ddf:614:f243:c32e]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::1ddf:614:f243:c32e%7]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 22:16:17 +0000
Message-ID: <b8539e31-b20a-6eb5-4b86-59a17d7c6939@axentia.se>
Date:   Fri, 22 Jul 2022 00:16:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] iio: afe/rescale: Implement write_raw
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721191526.374152-1-paul@crapouillou.net>
 <20220721191526.374152-5-paul@crapouillou.net>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220721191526.374152-5-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f06c4a-1c96-4b40-8872-08da6b66a1eb
X-MS-TrafficTypeDiagnostic: DB9PR02MB6539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TwZU2kXPwrwoWV2UjhLsXQTj56wsMUMslI2dXfws6ZM7tzLMW/dkNNFOLydOhaTtBML0F2NgTBZciHiNDCcoNMpOUSYGXZu0dUZK4MaCyI+aJ/ZQ7V6icjaHs0VqzgN49iXtWo3IVuHC0baazuSegzUCtiy6ANzD66I5zCz3J1V/5lLOBnIJ1+EARiDJG7VaGTCGs7ElZ2eKvUP5UGhjSluZu+0DbsWWTXr8mO4pj704TNZPibD/azH2SFf3G4x8G55/BbReWYLsQ2z8XUJR5sSPXa4+ekxn8PZWPtt4len1Uojh03Bb0eJkwXYCF8lzmC1eZwvQqzJAfKbHMt/YeUCIZbs0HBEwX66amYsTIEJmHYkGtCxF2yQhFeWTqZdLwPdwHhdsMJwC3J9qtAn3KkBVrvfmCai7E3YbHK1dYQSYwNHdclmwgk4SoFe3Jfqq84nqjmjpoT2NS+OiFufNJLdiDzHEr63CVXY8dt4qGYsg4uewNuIBgiV8+lZOm9whprkdfvdGa6ATQ1l8buMGNQSHEbX3oI8MQEnZ1m6QsH4auoiBIT1gjqezA4rQvqSyeTd3rGznyybwCmJCC7TaXIbdDi7UIvqPqc4HOZ/srzKEyoWNHPrvPAGjNQGtWeNuQcOh6qLS+1jLF2Pr60rmI385r5xHFTWqxhcaC+FenNgZ42LYcb2x1I+0IefVTJn92S1kRDaDrMjFKkbQx+cLnW2HMFwfkkD+AlET7g7AvzRuBrqamlaPjTIayqeLLPYqdKNe+cWTofIzGFEaTbkHotmtBXxj3qfM2vzSbL6Q9WQTM+Io6NXJIINTfyYqwkfi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39830400003)(396003)(346002)(366004)(136003)(26005)(2906002)(36756003)(6512007)(478600001)(31686004)(41300700001)(186003)(6506007)(6666004)(66946007)(66556008)(5660300002)(6486002)(38100700002)(2616005)(86362001)(31696002)(8676002)(316002)(110136005)(8936002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FqaFFHU3pPRzBLT2lybzhMRnNZSHY5SWpPRGFmUS9qaGRUWkpIUW9POTIy?=
 =?utf-8?B?dGVjMUk5OGxzUzN5YWhXVFhOYld3ajdjYmFzb3ZtY213c3c0V2J3TWZ1RkJQ?=
 =?utf-8?B?b1Z0aklpVTB6Ri9MZmtTd1pWMmJoM1FuVkVhZWJTa3hobysvYXVrZnZkS0s0?=
 =?utf-8?B?aVloYTB4Wk5Zdjk1Zm9LclBaZmVVKzZ1OWVrY1F3NlNUYmlZa3hjY0VIcit0?=
 =?utf-8?B?ZlRwRjZHK29xTDFERjJ4c08wTFBQOXpXT0JLdjhiQjk4UVdCS1pTVlhmTHY5?=
 =?utf-8?B?V3dIczlTSWRwb0ZZMmFwd3VqZ1lGRExteXhIVWYvRW40QjM4OExyUU1TcHlG?=
 =?utf-8?B?ZVVWVEFWL1puM2xFdUVOdE9uZGxKTitsSFJ5eXl6OTBLUEZsTlIxZUc5dEJG?=
 =?utf-8?B?TWE1V01zazF6Um52UGlLaHlqK0tZK1Q5dStDdC9WQ1FmdFJpaG1CbXBjTFlp?=
 =?utf-8?B?MHd3eXVqQ255WktROFN0OWp4UXZvNUdNYXUzTE5lREp2QlFudXZXa0hidVU2?=
 =?utf-8?B?d3pvM3pyNk5keENyOTA4ZTUwWEJXQ0ljb0Q1c2tKOHBsNDZDK0lTWjdZOTMr?=
 =?utf-8?B?RmlsYUw2WmRqMFkxaVVhU0svWjYrb3VBNWI2NmQwUFZ3YXpMaDFJZTNHY2s4?=
 =?utf-8?B?NWRxNkoxbHJnUTZhaWJRZVJPSHZuOU5aRkdBdFBXVWhMdXJCdWRCbGgzOEZI?=
 =?utf-8?B?dmY3Ylg5TUJCOHBRSDdZb1lhL0JIQjh6Z3lILzVZY3lSVmkvZlAwMVNQbFJ6?=
 =?utf-8?B?NnpYSzB5SFF6UlFWeGZVejl3T0MwblBOaWFLVVlMWXQrd2R3bTcxT2pBY2Uv?=
 =?utf-8?B?ZTRxQjBWT3BBNVlzazJrd2Z3bEpsZmhiUlMwMGQ4a0NvVDdTZmxHa2FXcmhh?=
 =?utf-8?B?OCsxb2g5bS9od3FrenlON25Lemk1b3BlOGRkVVV6UGNzcmZVMnlRVDJmc1Nu?=
 =?utf-8?B?cmEwSHhKR1d5UHVzbjVJckJSTG0zQVBMZmtaRnQ1UmpoRVY5cmRsWnAvbVBx?=
 =?utf-8?B?Z0Y2THFTVFA1SUVQL1hGd1ZpbWMwM1dPc1FnT2d1N2hsWWdWWmJYb1hmcUNL?=
 =?utf-8?B?bVNNSnpXWXp0K0FwRldrd1dtSzNYQUtsSFpUT054WWZGV2tXRzhhOW1FV0No?=
 =?utf-8?B?dTByMURFcjdzSXFENWtlUkNMSDVFbGROak9rVmhJUkhrN3BpQzFWbWp0TzN5?=
 =?utf-8?B?RXliTHBzYkF1aEpQdWNLalFTTGNkclZsajFLZS9Uc3p6SXdXMFZ3eVdiMkZR?=
 =?utf-8?B?YmpvZTZ6cFZ5Qjd2YVZyVEQ3NHFGcHN0eUcwN3czT2xGanlXT0ExZk82RThX?=
 =?utf-8?B?T3AwZmh6eWVOcXk2dVMyQVZsNm1jbENJRnJIUDBhQTJTUFhrdThhRjFTVHFu?=
 =?utf-8?B?NEFjVUJsbEVYQWtpZ29IS09iUVRBZGxJQWZ3dUI5QmNDWTduUTl2R3BOK0tG?=
 =?utf-8?B?U2tSU3FXeVV1dHd4V2MweDdPUFNzZ25RQ3JPeFNJYU1iYy9TZ2FrNXp6eHhj?=
 =?utf-8?B?Z2tLRHNrZDdaTllxZjJ4VjFYbUxKdFhzK2E4SHNTd0dyWVZrNkt2bE1NZWdh?=
 =?utf-8?B?bEN5VVdOU1BMRzJ1REF5N0pBRFMrMWh4RlY3aGJ2NlgxNWprbHJ3UTVqK2l3?=
 =?utf-8?B?bHVseHBnRitCQlRZUXNWV1pMUDlPSytGSGc5SU1SUnJkQTdqWTJNY3lITi9D?=
 =?utf-8?B?eTRUSVk0THE5ZnNOVnRvQ2lBaElZeEV2eU90SHMvYVlVYjM0V2xVYmxJQlds?=
 =?utf-8?B?VWNGdzRuV1V2ZkVta3E4YmhRYnoxYTJIQURrQmpvZDJaMmg2SDRIWTdBTmtr?=
 =?utf-8?B?NElZNks1emJSSnU5dFFRKzgzR2x6WkV2WldkdHNzMitzejlwN3IyYXNtYy83?=
 =?utf-8?B?d3lQL1R2Ukh5bWh5Y2draTRNOFAwYmdWbDRnTlpIK3pBSUxWWXVGb2wxVkxw?=
 =?utf-8?B?TTRlYS9Ebzd5dEN2b0R3WGVXMlBROG9WYUFlc2dwaXBDUVF3MmUrRU5uRVVn?=
 =?utf-8?B?T3BsT0tFMldQUWNKczFWcHpMOHdycGNsVG4xTU8xT3lsMzhsK2VmUmt0b2hi?=
 =?utf-8?B?dGhIam82MkVaaDFlZFRLSVNCUVVhWFVadk5EeDNGUi94WTd1NEtXTGJGdi9m?=
 =?utf-8?Q?I8Gf48fLMoDG46BROMVDN0mCv?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f06c4a-1c96-4b40-8872-08da6b66a1eb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:16:17.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W9/+HYjSmlAVZAOD6P3UKEun/XUqFs4D2GtKrOUQPV21tIm6tifr/U+vthfBufq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-07-21 at 21:15, Paul Cercueil wrote:
> Implement write_raw by converting the value if writing the scale, or
> just calling the managed channel driver's write_raw otherwise.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 5c9970b93384..0edb62ee4508 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -141,6 +141,27 @@ int rescale_process_offset(struct rescale *rescale, int scale_type,
>  	}
>  }
>  
> +static int rescale_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		tmp = val * 1000000000LL;
> +		do_div(tmp, rescale->numerator);
> +		tmp *= rescale->denominator;
> +		do_div(tmp, 1000000000LL);

do_div is for unsigned operands. Can val never ever be negative?
What about the numerator and denominator, can those be negative? I
think this code should live in a new rescale_process_inverse_scale
function, or something like that (and a few tests could be added to
drivers/iio/test/iio-test-rescale.c)

> +		return iio_write_channel_attribute(rescale->source, tmp, 0,
> +						   IIO_CHAN_INFO_SCALE);
> +	default:

What if the source driver has a .write_raw_get_fmt callback? That bit
of info is silently dropped (with no comment that a shortcut has been
taken). How does inverse rescaling mix with a .write_raw_get_fmt that
returns e.g. IIO_VAL_INT_PLUS_MICRO_DB anyway? I think all cases might
get a bit hairy to support, so I think you need to do some filtering
and somehow fail the .write_raw call if the .write_raw_get_fmt of the
source returns something that gets too difficult to support.

Cheers,
Peter

> +		return iio_write_channel_attribute(rescale->source,
> +						   val, val2, mask);
> +	}
> +}
> +
>  static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -250,6 +271,7 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info rescale_info = {
> +	.write_raw = rescale_write_raw,
>  	.read_raw = rescale_read_raw,
>  	.read_avail = rescale_read_avail,
>  };
